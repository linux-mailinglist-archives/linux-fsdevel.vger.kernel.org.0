Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFE9270FAB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Sep 2020 18:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgISQ4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Sep 2020 12:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgISQ4E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Sep 2020 12:56:04 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BBEC0613CE;
        Sat, 19 Sep 2020 09:56:03 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJg9W-001qS2-2o; Sat, 19 Sep 2020 16:55:58 +0000
Date:   Sat, 19 Sep 2020 17:55:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+4191a44ad556eacc1a7a@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] fs: fix KMSAN uninit-value bug by
 initializing nd in do_file_open_root
Message-ID: <20200919165558.GH3421308@ZenIV.linux.org.uk>
References: <20200916052657.18683-1-anant.thazhemadam@gmail.com>
 <20200916054157.GC825@sol.localdomain>
 <20200917002238.GO3421308@ZenIV.linux.org.uk>
 <20200919144451.GF2712238@kroah.com>
 <20200919161727.GG3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919161727.GG3421308@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 19, 2020 at 05:17:27PM +0100, Al Viro wrote:

> Lovely...  That would get an empty path and non-directory for a starting
> point, but it should end up with LAST_ROOT in nd->last_type.  Which should
> not be able to reach the readers of those fields...  Which kernel had
> that been on?

Yecchhh...  I see what's going on; I suspect that this ought to be enough.
Folks, could somebody test it on the original reproducer setup?

diff --git a/fs/namei.c b/fs/namei.c
index e99e2a9da0f7..3f02cae7e73f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2113,8 +2113,10 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		return PTR_ERR(name);
 	while (*name=='/')
 		name++;
-	if (!*name)
+	if (!*name) {
+		nd->dir_mode = 0; // short-circuit the 'hardening' idiocy
 		return 0;
+	}
 
 	/* At this point we know we have a real path component. */
 	for(;;) {
