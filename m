Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FA537BC1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 13:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhELL6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 07:58:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:36262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230184AbhELL6d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 07:58:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 270B5AFEB;
        Wed, 12 May 2021 11:57:25 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 77612906;
        Wed, 12 May 2021 11:58:59 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: 9p: fscache duplicate cookie
References: <87tun8z2nd.fsf@suse.de> <87czu45gcs.fsf@suse.de>
        <2507722.1620736734@warthog.procyon.org.uk>
        <2882181.1620817453@warthog.procyon.org.uk>
Date:   Wed, 12 May 2021 12:58:58 +0100
In-Reply-To: <2882181.1620817453@warthog.procyon.org.uk> (David Howells's
        message of "Wed, 12 May 2021 12:04:13 +0100")
Message-ID: <87fsysyxh9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Luis Henriques <lhenriques@suse.de> wrote:
>
>> [ I wonder why the timestamps don't match between the traces and the
>>   kernel log... ]
>
> I've seen that.  I wonder if the timestamping of printk lines is delayed by
> the serial driver outputting things.
>
>> So, can we infer from this trace that an evict could actually be on-going
>> but the old cookie wasn't relinquished yet and hence the collision?
>
> It might be illuminating if you can make it print a traceline at the beginning
> of v9fs_evict_inode() and in v9fs_drop_inode().  Print the cookie pointer in
> both.

Ok, here's what I'm getting:

...
<...>-20575   [002] ...1    67.519214: fscache_acquire: c=0000000097476aaa p=000000003080d900 pu=50 pc=49 pf=22 n=9p.inod
<...>-20585   [003] ...2    67.535091: 9p_fscache_cookie: v9fs_drop_inode cookie: 00000000cd0099b3
<...>-20585   [003] ...1    67.535093: 9p_fscache_cookie: v9fs_evict_inode cookie: 00000000cd0099b3
<...>-20585   [003] ...1    67.535115: fscache_relinquish: c=00000000cd0099b3 u=1 p=000000003080d900 Nc=0 Na=1 f=26 r=0
<...>-20585   [003] ...1    67.535118: fscache_cookie: PUT rlq c=00000000cd0099b3 u=0 p=000000003080d900 Nc=0 Na=0 f=16
<...>-20585   [003] ...1    67.535120: fscache_cookie: PUT prn c=000000003080d900 u=49 p=0000000042542ee5 Nc=48 Na=1 f=22
<...>-20591   [000] ...2    67.538644: fscache_cookie: GET prn c=000000003080d900 u=50 p=0000000042542ee5 Nc=48 Na=1 f=22
<...>-20591   [000] ...1    67.538645: fscache_acquire: c=0000000011fa06b1 p=000000003080d900 pu=50 pc=49 pf=22 n=9p.inod
<...>-20599   [003] .N.2    67.542180: 9p_fscache_cookie: v9fs_drop_inode cookie: 0000000097476aaa
<...>-20599   [003] .N.1    67.542181: 9p_fscache_cookie: v9fs_evict_inode cookie: 0000000097476aaa
<...>-20591   [000] ...2    67.542980: fscache_cookie: *COLLISION* c=0000000097476aaa u=1 p=000000003080d900 Nc=0 Na=1 f=26
<...>-20599   [003] ...1    67.543098: fscache_relinquish: c=0000000097476aaa u=1 p=000000003080d900 Nc=0 Na=1 f=26 r=0
<...>-20599   [003] ...1    67.543100: fscache_cookie: PUT rlq c=0000000097476aaa u=0 p=000000003080d900 Nc=0 Na=0 f=16

(Note that I'm only tracing v9fs_{drop,evict}_inode if we have a cookie
for the inode; there are a bunch of drop/evict calls where the cookie is
NULL.)

So, this is... annoying, I guess.

Cheers,
-- 
Luis
