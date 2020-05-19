Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03161DA438
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 00:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgESWEP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 18:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgESWEP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 18:04:15 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE7BC061A0F
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 15:04:14 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jbALJ-00C2eu-U1; Tue, 19 May 2020 22:04:10 +0000
Date:   Tue, 19 May 2020 23:04:09 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Thiago Macieira <thiago.macieira@intel.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fcntl(F_DUPFD) causing apparent file descriptor table corruption
Message-ID: <20200519220409.GT23230@ZenIV.linux.org.uk>
References: <1645568.el9gB4U55B@tjmaciei-mobl1>
 <20200519214520.GS23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519214520.GS23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 10:45:20PM +0100, Al Viro wrote:

> The obvious fix would be to turn cpy and set into size_t - as in
> ed fs/file.c <<'EOF'
> /copy_fdtable/+2s/unsigned int/size_t/
> w
> q
> EOF
> 
> On size_t overflow you would've failed allocation before getting to that
> point - see sysctl_nr_open_max initializer.  Overflow in alloc_fdtable()
> (nr is unsigned int there) also can't happen, AFAICS - the worst you
> can get is 1U<<31, which will fail sysctl_nr_open comparison.
> 
> I really wonder about the missing couple of syscalls in your strace, though;
> could you verify that they _are_ missing and see what the fix above does to
> your testcase?

Anyway, whether it's all there is to your reproducers or not, the bug
is obvious; I've pushed the following into #fixes.

commit 784233a6d4a56f1d0e6e4490fbf38d3cce5742ec
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue May 19 17:48:52 2020 -0400

    fix multiplication overflow in copy_fdtable()
    
    cpy and set really should be size_t; we won't get an overflow on that,
    since sysctl_nr_open can't be set above ~(size_t)0 / sizeof(void *),
    so nr that would've managed to overflow size_t on that multiplication
    won't get anywhere near copy_fdtable() - we'll fail with EMFILE
    before that.
    
    Cc: stable@kernel.org # v2.6.25+
    Fixes: 9cfe015aa424 (get rid of NR_OPEN and introduce a sysctl_nr_open)
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/file.c b/fs/file.c
index c8a4e4c86e55..abb8b7081d7a 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -70,7 +70,7 @@ static void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
  */
 static void copy_fdtable(struct fdtable *nfdt, struct fdtable *ofdt)
 {
-	unsigned int cpy, set;
+	size_t cpy, set;
 
 	BUG_ON(nfdt->max_fds < ofdt->max_fds);
 
