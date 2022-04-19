Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D945074EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 18:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355238AbiDSQsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 12:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbiDSQob (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:44:31 -0400
X-Greylist: delayed 2115 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Apr 2022 09:41:48 PDT
Received: from nibbler.cm4all.net (nibbler.cm4all.net [82.165.145.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDFE2FE6D
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 09:41:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by nibbler.cm4all.net (Postfix) with ESMTP id 45DBEC00CB
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 18:41:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at nibbler.cm4all.net
Received: from nibbler.cm4all.net ([127.0.0.1])
        by localhost (nibbler.cm4all.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id zNKezYq3qeWX for <linux-fsdevel@vger.kernel.org>;
        Tue, 19 Apr 2022 18:41:39 +0200 (CEST)
Received: from zero.intern.cm-ag (zero.intern.cm-ag [172.30.16.10])
        by nibbler.cm4all.net (Postfix) with SMTP id 17B76C00DA
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 18:41:39 +0200 (CEST)
Received: (qmail 29906 invoked from network); 19 Apr 2022 22:31:40 +0200
Received: from unknown (HELO rabbit.intern.cm-ag) (172.30.3.1)
  by zero.intern.cm-ag with SMTP; 19 Apr 2022 22:31:40 +0200
Received: by rabbit.intern.cm-ag (Postfix, from userid 1023)
        id D8786460EFB; Tue, 19 Apr 2022 18:41:38 +0200 (CEST)
Date:   Tue, 19 Apr 2022 18:41:38 +0200
From:   Max Kellermann <mk@cm4all.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Max Kellermann <mk@cm4all.com>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fscache corruption in Linux 5.17?
Message-ID: <Yl7mQr05hPg4vELb@rabbit.intern.cm-ag>
References: <Yl7EyMLnqqDv63yW@rabbit.intern.cm-ag>
 <YlWWbpW5Foynjllo@rabbit.intern.cm-ag>
 <454834.1650373340@warthog.procyon.org.uk>
 <508603.1650385022@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <508603.1650385022@warthog.procyon.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/04/19 18:17, David Howells <dhowells@redhat.com> wrote:
> 	find /var/cache/fscache -inum $((0xiiii))
> 
> and see if you can see the corruption in there.  Note that there may be blocks
> of zeroes corresponding to unfetched file blocks.

I checked several known-corrupt files, but unfortunately, all
corruption have disappeared :-(

The /var/cache/fscache/ files have a time stamp half an hour ago
(17:53 CET = 15:53 GMT).  I don't know what happened at that time -
too bad this disappeared after a week, just when we started
investigating it.

All those new files are all-zero.  No data is stored in any of them.

Note that I had to enable
/sys/kernel/debug/tracing/events/cachefiles/enable; the trace events
you named (read/write/trunc/io_error/vfs_error) do not emit anything.
This is what I see:

  kworker/u98:11-1446185 [016] ..... 1813913.318370: cachefiles_ref: c=00014bd5 o=12080f1c u=1 NEW obj
  kworker/u98:11-1446185 [016] ..... 1813913.318379: cachefiles_lookup: o=12080f1c dB=3e01ee B=3e5580 e=0
  kworker/u98:11-1446185 [016] ..... 1813913.318380: cachefiles_mark_active: o=12080f1c B=3e5580
  kworker/u98:11-1446185 [016] ..... 1813913.318401: cachefiles_coherency: o=12080f1c OK       B=3e5580 c=0
  kworker/u98:11-1446185 [016] ..... 1813913.318402: cachefiles_ref: c=00014bd5 o=12080f1c u=1 SEE lookup_cookie

> Also, what filesystem is backing your cachefiles cache?  It could be useful to
> dump the extent list of the file.  You should be able to do this with
> "filefrag -e".

It's ext4.

 Filesystem type is: ef53
 File size of /var/cache/fscache/cache/Infs,3.0,2,,a4214ac,c0000208,,,3002c0,10000,10000,12c,1770,bb8,1770,1/@58/T,c0000208,,1cf4167,184558d9,c0000208,,40,36bab37,40, is 188416 (46 blocks of 4096 bytes)
 /var/cache/fscache/cache/Infs,3.0,2,,a4214ac,c0000208,,,3002c0,10000,10000,12c,1770,bb8,1770,1/@58/T,c0000208,,1cf4167,184558d9,c0000208,,40,36bab37,40,: 0 extents found
 File size of /var/cache/fscache/cache/Infs,3.0,2,,a4214ac,c0000208,,,3002c0,10000,10000,12c,1770,bb8,1770,1/@ea/T,c0000208,,10cc976,1208c7f6,c0000208,,40,36bab37,40, is 114688 (28 blocks of 4096 bytes)
 /var/cache/fscache/cache/Infs,3.0,2,,a4214ac,c0000208,,,3002c0,10000,10000,12c,1770,bb8,1770,1/@ea/T,c0000208,,10cc976,1208c7f6,c0000208,,40,36bab37,40,: 0 extents found

> As to why this happens, a write that's misaligned by 31 bytes should cause DIO
> to a disk to fail - so it shouldn't be possible to write that.  However, I'm
> doing fallocate and truncate on the file to shape it so that DIO will work on
> it, so it's possible that there's a bug there.  The cachefiles_trunc trace
> lines may help catch that.

I don't think any write is misaligned.  This was triggered by a
WordPress update, so I think the WordPress updater truncated and
rewrote all files.  Random guess: some pages got transferred to the
NFS server, but the local copy in fscache did not get updated.

Max
