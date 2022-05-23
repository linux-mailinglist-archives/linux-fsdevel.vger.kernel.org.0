Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C72531385
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 18:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbiEWPka (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 11:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238041AbiEWPk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 11:40:28 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5036513E0B;
        Mon, 23 May 2022 08:40:27 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8D89B6FF7; Mon, 23 May 2022 11:40:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8D89B6FF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1653320426;
        bh=Z+qxa+zGW5+0guw4bev4YIEGkKyRlr9IpXZHYJdrvvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KLg1bD2XHFuK7LaU5CSgO/fVy9ThWOMltJQQ6GdSY5LWo0iS1RfJpIaWpP1ziepUJ
         5/9Eld5a0MLaZQ5Icp/r4jOYLHP4K2PW6FTIQTdz4VfjRwIo7JLTQQhCQiwGgLd6nZ
         r5ox4Uzm6Otsji7NiaA4P8WDG5X3j5WF5RInDuYU=
Date:   Mon, 23 May 2022 11:40:26 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v25 0/7] NFSD: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20220523154026.GD24163@fieldses.org>
References: <1651526367-1522-1-git-send-email-dai.ngo@oracle.com>
 <20220503011252.GK30550@fieldses.org>
 <20220503012132.GL30550@fieldses.org>
 <9b394762-660b-4742-b54a-2b385485b412@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b394762-660b-4742-b54a-2b385485b412@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 02, 2022 at 06:38:03PM -0700, dai.ngo@oracle.com wrote:
> 
> On 5/2/22 6:21 PM, J. Bruce Fields wrote:
> >On Mon, May 02, 2022 at 09:12:52PM -0400, J. Bruce Fields wrote:
> >>Looks good to me.
> >And the only new test failures are due to the new DELAYs on OPEN.
> >Somebody'll need to fix up pynfs.  (I'm not volunteering for now.)
> 
> I will fix it, since I broke it :-)

By the way, I have three more notes on courtesy server stuff that I
wanted to dump into email before I forget them:

1. I do still recommend fixing up those pynfs failures.  The ones I see
   are in RENEW3, LKU10, CLOSE9, CLOSE8, but there may be others.

2. In the lock case, nfsd4_lock() holds an st_mutex while calling
   vfs_lock_file(), which may end up needing to wait for the laundromat.
   As I said in review, I don't see a potential deadlock there, so I'm
   fine with the code going in as is.

   But, as a note for possible cleanup, or if this does turn into a
   problem later: vfs_lock_file could return to nfsd4_lock(), and
   nfsd4_lock() could easily drop the st_mutex, wait, and retry.

   I think the only trick part would be deciding on conventions for the
   caller to tell vfs_lock_file() that it shouldn't wait in this case
   (non-nfsd callers will still want to wait), and for vfs_lock_file()
   to indicate the caller needs to retry.  Probably something in
   fl_flags for the former, and an agreed-on error return for the
   latter?

3. One other piece of future work would be optimizing the conflicting
   lock case.  A very premature optimization at this point, but I'm just
   leaving my notes here in case someone's interested:

   The loop in posix_lock_inode() is currently O(N^2) in the number of
   expirable clients holding conflicting locks, because each time we
   encounter one, we wait and then restart.  In practice I doubt that
   matters--if you have a lot of clients to expire, the time rescanning
   the list will likely be trivial compared to the time spent waiting
   for nfsdcld to commit the expiry of each client to stable storage.

   *However*, it might be a more significant optimization if we first
   allowed more parallelism in nfsdcld.  And that might also benefit
   some other cases (e.g., lots of clients reconnecting after a crash).
   We'd need paralle nfsdcld--no idea what that would involve--and I
   think it'd also help to update the kernel<->nfsdcld protocol with a
   separate commit operation, so that nfsd could issue a bunch of client
   changes and then a single commit to wait for them all.

   That done, we could modify the loop in vfs_lock_file() so that, in
   the case where multiple clients hold conflicting locks, the loop
   marks them all for expiry in one pass, then waits just once at the
   end.

--b.
