Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D531113E79
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 10:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfLEJqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 04:46:30 -0500
Received: from mail.phunq.net ([66.183.183.73]:48442 "EHLO phunq.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbfLEJqa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:46:30 -0500
Received: from [172.16.1.14]
        by phunq.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.92.3)
        (envelope-from <daniel@phunq.net>)
        id 1icniN-0002Yo-Lt; Thu, 05 Dec 2019 01:46:27 -0800
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
To:     Vyacheslav Dubeyko <slava@dubeyko.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
 <6b6242d9-f88b-824d-afe9-d42382a93b34@phunq.net>
 <9ed62cfea37bfebfb76e378d482bd521c7403c1f.camel@dubeyko.com>
From:   Daniel Phillips <daniel@phunq.net>
Message-ID: <c61706fb-3534-72b9-c4ae-0f0972bc566b@phunq.net>
Date:   Thu, 5 Dec 2019 01:46:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9ed62cfea37bfebfb76e378d482bd521c7403c1f.camel@dubeyko.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-12-04 7:55 a.m., Vyacheslav Dubeyko wrote:
>> That is it for media format. Very simple, is it not? My next post
>> will explain the Shardmap directory block format, with a focus on
>> deficiencies of the traditional Ext2 format that were addressed.
> 
> I've tried to take a look into the source code. And it was not easy
> try. :)

Let's see what we can do about that, starting with removing the duopack
(media index entry) and tripack (cache index entry) templates. Now that
the design has settled down we don't need that level of generality so
much any more. The replacements are mostly C-style now and by the time
the Tux3 kernel port is done, will be officially C.

So far I only described the media format, implemented in define_layout(),
which I hope is self explanatory. You should be able to tie it back to
this diagram pretty easily.

   https://github.com/danielbot/Shardmap/wiki/Shardmap-media-format

> I expected to have the bird-fly understanding from shardmap.h
> file. My expectation was to find the initial set of structure
> declarations with the good comments.

Our wiki is slowly getting populated with design documentation. Most of
what you see in shardmap.h is concerned with the Shardmap cache form,
where all the action happens. I have not said much about that yet, but
there is a post on the way. The main structures are struct shard (a
self contained hash table) and struct keymap (a key value store
populated with shards). Those are obvious I think, please correct me
if I am wrong. A more tricky one is struct tier, which implements our
incremental hash table expansion. You might expect that to be a bit
subtle, and it is.

Before getting into those details, there is an upcoming post about
the record block format, which is pretty non-abstract and, I think,
easy enough to understand from the API declaration in shardmap.h and
the code in recops.c.

There is a diagram here:

   https://github.com/danielbot/Shardmap/wiki/Shardmap-record-block-format

but the post this belongs to is not quite ready to go out yet. That one
will be an interlude before for the cache form discussion, which is
where the magic happens, things like rehash and reshard and add_tier,
and the way the hash code gets chopped up as it runs through the access
stack.

Here is a diagram of the cache structures, very simple:

   https://github.com/danielbot/Shardmap/wiki/Shardmap-cache-format

And here is a diagram of the Shardmap three level hashing scheme,
which ties everything together:

   https://github.com/danielbot/Shardmap/wiki/Shardmap-hashing-scheme

This needs explanation. It is something new that you won't find in any
textbook, this is the big reveal right here.

> But, frankly speaking, it's very
> complicated path for the concept understanding. Even from C++ point of
> view, the class declarations look very complicated if there are mixing
> of fields with methods declarations.

In each class, fields are declared first, then methods. In the kernel
port of course we will not have classes, and the function names will be
longer as usual.

> So, I believe it makes sense to declare the necessary set of structures
> in the file's beginning with the good comments. Even it will be good to
> split the structure declarations and methods in different files. I
> believe it will ease the way to understand the concept. Otherwise, it
> will be tough to review such code.

Declaring structures and functions in the same file is totally normal
for kernel code, you don't really want these in separate files unless
they break out naturally that way.

This code is dense, there is a lot going on in not very many lines. So
we need lots of lines of documentation to make up for that, which has
not been a priority until now, so please bear with me. And please do
not hesitate to ask specific questions - the answers may well end up in
the wiki.

Regards,

Daniel
