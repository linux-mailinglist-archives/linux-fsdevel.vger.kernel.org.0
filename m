Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D242115A5F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 01:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfLGAqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 19:46:08 -0500
Received: from mail.phunq.net ([66.183.183.73]:52232 "EHLO phunq.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfLGAqI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 19:46:08 -0500
Received: from [172.16.1.14]
        by phunq.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.92.3)
        (envelope-from <daniel@phunq.net>)
        id 1idOEX-0006U5-SC; Fri, 06 Dec 2019 16:46:05 -0800
Subject: Re: [RFC] Thing 1: Shardmap for Ext4
To:     Vyacheslav Dubeyko <slava@dubeyko.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
 <6b6242d9-f88b-824d-afe9-d42382a93b34@phunq.net>
 <9ed62cfea37bfebfb76e378d482bd521c7403c1f.camel@dubeyko.com>
 <c61706fb-3534-72b9-c4ae-0f0972bc566b@phunq.net>
 <37c9494c40998d23d0d68afaa5a7f942a23e8986.camel@dubeyko.com>
From:   Daniel Phillips <daniel@phunq.net>
Message-ID: <a05837a0-a352-fc8d-5c9c-28d8065961fd@phunq.net>
Date:   Fri, 6 Dec 2019 16:46:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <37c9494c40998d23d0d68afaa5a7f942a23e8986.camel@dubeyko.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-12-06 3:47 a.m., Vyacheslav Dubeyko wrote:
> On Thu, 2019-12-05 at 01:46 -0800, Daniel Phillips wrote:
>> On 2019-12-04 7:55 a.m., Vyacheslav Dubeyko wrote:
>>>>
> 
> <snipped and reoredered>
> 
>> And here is a diagram of the Shardmap three level hashing scheme,
>> which ties everything together:
>>
>>     https://github.com/danielbot/Shardmap/wiki/Shardmap-hashing-scheme
>>
>> This needs explanation. It is something new that you won't find in
>> any
>> textbook, this is the big reveal right here.
>>
> 
> This diagram is pretty good and provides the high-level view of the
> whole scheme. But, maybe, it makes sense to show the granularity of
> hash code. It looks like the low hash is the hash of a name. Am I
> correct?

Not quite. A 64 bit hash code is computed per name, then divided up into
three parts as shown in the diagram. Each part of the hash addresses a
different level of the Shardmap index hierarchy: high bits address the
top level shard array, giving a pointer to a shard; middle bits address
a hash bucket within that shard; low bits are used to resolve collisions
within the hash bucket (and collisions still may occur even when the low
bits are considered, forcing a record block access and full string
compare.

> But how the mid- and high- parts of the hash code are defined?

Given the above description, does the diagram make sense? If so I will
add this description to the wiki.

> It looks like that cached shard stores LBAs of record entry blocks are
> associated with the low hash values.

Rather, associated with the entire hash value.

> But what does it mean that shard is cached?

This is the cache form of the shard, meaning that the unordered hash/lba
index pairs (duopack) were read in from media and loaded into this cache
object (or newly created by recent directory operations.)

> Here is a diagram of the cache structures, very simple:
>>
>>     https://github.com/danielbot/Shardmap/wiki/Shardmap-cache-format
> 
> This diagram is not easy to relate with the previous one. So, shard
> table and shard array are the same entities or not?

They are, and I have updated the hashing scheme diagram to refer to both
as "array". I will similarly update the code, which currently calls the
shard array field "map".

> Or do you mean that
> shard table is storeed on the volume but shard array is constructed in
> memory?

Sorry about that, it should be clear now. On the volume, a simple
unordered collection of hash:lba pairs is stored per shard, which is
reorganized into shard cache form (a hash table object) at demand-load
time.

>> There is a diagram here:
>>
> https://github.com/danielbot/Shardmap/wiki/Shardmap-record-block-format
> 
> I am slightly confused here. Does header be located at the bottom of
> the record block?

The header (just 32 bytes at the moment, possibly to be expanded to 48
or 64) is stored at the top of the zeroth record entry block, which is
therefore a little smaller than any other record entry block.

> My understanding is that records grow from top of the
> block down to the header direction. Am I correct? Why header is not
> located at the top of the block with entry dictionary? Any special
> purpose here?

That should be clear now. I will add the above descriptive text to the
wiki.

Regards,

Daniel
