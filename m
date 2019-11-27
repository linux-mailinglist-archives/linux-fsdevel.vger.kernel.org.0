Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE8E10ABB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 09:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfK0I2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 03:28:30 -0500
Received: from mail.phunq.net ([66.183.183.73]:58710 "EHLO phunq.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfK0I2a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:28:30 -0500
Received: from [172.16.1.14]
        by phunq.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.92.3)
        (envelope-from <daniel@phunq.net>)
        id 1iZsgU-0003Z4-HJ; Wed, 27 Nov 2019 00:28:26 -0800
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
To:     Vyacheslav Dubeyko <slava@dubeyko.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Darrick J. Wong" <djwong@kernel.org>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <8ece0424ceeeffbc4df5d52bfa270a9522f81cda.camel@dubeyko.com>
From:   Daniel Phillips <daniel@phunq.net>
Message-ID: <5c9b5bd3-028a-5211-30a6-a5a8706b373e@phunq.net>
Date:   Wed, 27 Nov 2019 00:28:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8ece0424ceeeffbc4df5d52bfa270a9522f81cda.camel@dubeyko.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-11-26 11:40 p.m., Vyacheslav Dubeyko wrote:
> As far as I know, usually, a folder contains dozens or hundreds
> files/folders in average. There are many research works that had showed
> this fact. Do you mean some special use-case when folder could contain
> the billion files? Could you share some research work that describes
> some practical use-case with billion files per folder?

You are entirely correct that the vast majority of directories contain
only a handful of files. That is my case (1). A few directories on a
typical server can go into the tens of thousands of files. There was
a time when we could not handle those efficiently, and now thanks to
HTree we can. Some directories go into the millions, ask the Lustre
people about that. If you could have a directory with a billion files
then somebody will have a use for it. For example, you may be able to
avoid a database for a particular application and just use the file
system instead.

Now, scaling to a billion files is just one of several things that
Shardmap does better than HTree. More immediately, Shardmap implements
readdir simply, accurately and efficiently, unlike HTree. See here for
some discussion:

   https://lwn.net/Articles/544520/
   "Widening ext4's readdir() cookie"

See the recommendation that is sometimes offered to work around
HTree's issues with processing files in hash order. Basically, read
the entire directory into memory, sort by inode number, then process
in that order. As an application writer do you really want to do this,
or would you prefer that the filesystem just take care of for you so
the normal, simple and readable code is also the most efficient code?

> If you are talking about improving the performance then do you mean
> some special open-source implementation?

I mean the same kind of kernel filesystem implementation that HTree
currently has. Open source of course, GPLv2 to be specific.

>> For delete, Shardmap avoids write multiplication by appending tombstone
>> entries to index shards, thereby addressing a well known HTree delete
>> performance issue.
> 
> Do you mean Copy-On-Write policy here or some special technique?

The technique Shardmap uses to reduce write amplication under heavy
load is somewhat similar to the technique used by Google's Bigtable to
achieve a similar result for data files. (However, the resemblance to
Bigtable ends there.)

Each update to a Shardmap index is done twice: once in a highly
optimized hash table shard in cache, then again by appending an
entry to the tail of the shard's media "fifo". Media writes are
therefore mostly linear. I say mostly, because if there is a large
number of shards then a single commit may need to update the tail
block of each one, which still adds up to vastly fewer blocks than
the BTree case, where it is easy to construct cases where every
index block must be updated on every commit, a nasty example of
n**2 performance overhead.

> How could be good Shardmap for the SSD use-case? Do you mean that we
> could reduce write amplification issue for NAND flash case?

Correct. Reducing write amplification is particularly important for
flash based storage. It also has a noticeable beneficial effect on
efficiency under many common and not so common loads.

> Let's imagine that it needs to implement the Shardmap approach. Could
> you estimate the implementation and stabilization time? How expensive
> and long-term efforts could it be?

Shardmap is already implemented and stable, though it does need wider
usage and testing. Code is available here:

   https://github.com/danielbot/Shardmap

Shardmap needs to be ported to kernel, already planned and in progress
for Tux3. Now I am proposing that the Ext4 team should consider porting
Shardmap to Ext4, or at least enter into a serious discussion of the
logistics.

Added Darrick to cc, as he is already fairly familiar with this subject,
once was an Ext4 developer, and perhaps still is should the need arise.
By the way, is there a reason that Ted's MIT address bounced on my
original post?

Regards,

Daniel
