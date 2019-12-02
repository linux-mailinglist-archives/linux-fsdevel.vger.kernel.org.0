Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1230A10E448
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 02:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfLBBpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Dec 2019 20:45:07 -0500
Received: from mail.phunq.net ([66.183.183.73]:38782 "EHLO phunq.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbfLBBpH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Dec 2019 20:45:07 -0500
Received: from [172.16.1.14]
        by phunq.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.92.3)
        (envelope-from <daniel@phunq.net>)
        id 1ibalt-00027V-Dm; Sun, 01 Dec 2019 17:45:05 -0800
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
From:   Daniel Phillips <daniel@phunq.net>
Message-ID: <6b6242d9-f88b-824d-afe9-d42382a93b34@phunq.net>
Date:   Sun, 1 Dec 2019 17:45:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127142508.GB5143@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-11-27 6:25 a.m., Theodore Y. Ts'o wrote:
> (3) It's not particularly well documented...

We regard that as an issue needing attention. Here is a pretty picture
to get started:

   https://github.com/danielbot/Shardmap/wiki/Shardmap-media-format

This needs some explaining. The bottom part of the directory file is
a simple linear range of directory blocks, with a freespace map block
appearing once every 4K blocks or so. This freespace mapping needs a
post of its own, it is somewhat subtle. This will be a couple of posts
in the future.

The Shardmap index appears at a higher logical address, sufficiently
far above the directory base to accommodate a reasonable number of
record entry blocks below it. We try not to place the index at so high
an address that the radix tree gets extra levels, slowing everything
down.

When the index needs to be expanded, either because some shard exceeded
a threshold number of entries, or the record entry blocks ran into the
the bottom of the index, then a new index tier with more shards is
created at a higher logical address. The lower index tier is not copied
immediately to the upper tier, but rather, each shard is incrementally
split when it hits the threshold because of an insert. This bounds the
latency of any given insert to the time needed to split one shard, which
we target nominally at less than one millisecond. Thus, Shardmap takes a
modest step in the direction of real time response.

Each index tier is just a simple array of shards, each of which fills
up with 8 byte entries from bottom to top. The count of entries in each
shard is stored separately in a table just below the shard array. So at
shard load time, we can determine rapidly from the count table which
tier a given shard belongs to. There are other advantages to breaking
the shard counts out separately having to do with the persistent memory
version of Shardmap, interesting details that I will leave for later.

When all lower tier shards have been deleted, the lower tier may be
overwritten by the expanding record entry block region. In practice,
a Shardmap file normally has just one tier most of the time, the other
tier existing only long enough to complete the incremental expansion
of the shard table, insert by insert.

There is a small header in the lowest record entry block, giving the
positions of the one or two index tiers, count of entry blocks, and
various tuning parameters such as maximum shard size and average depth
of cache hash collision lists.

That is it for media format. Very simple, is it not? My next post
will explain the Shardmap directory block format, with a focus on
deficiencies of the traditional Ext2 format that were addressed.

Regards,

Daniel
