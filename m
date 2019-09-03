Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0913A69E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 15:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfICNbg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 09:31:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57590 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbfICNbg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:31:36 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.1 #3 (Red Hat Linux))
        id 1i58uE-0003Gi-2l; Tue, 03 Sep 2019 13:31:34 +0000
Date:   Tue, 3 Sep 2019 14:31:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@lca.pw>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: "fs/namei.c: keep track of nd->root refcount status" causes boot
 panic
Message-ID: <20190903133134.GG1131@ZenIV.linux.org.uk>
References: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw>
 <20190903123719.GF1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903123719.GF1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 01:37:19PM +0100, Al Viro wrote:
> On Tue, Sep 03, 2019 at 12:21:36AM -0400, Qian Cai wrote:
> > The linux-next commit "fs/namei.c: keep track of nd->root refcount status” [1] causes boot panic on all
> > architectures here on today’s linux-next (0902). Reverted it will fix the issue.
> 
> <swearing>
> 
> OK, I see what's going on.  Incremental to be folded in:

... or, better yet,

diff --git a/include/linux/namei.h b/include/linux/namei.h
index 20ce2f917ef4..397a08ade6a2 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -37,7 +37,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
 #define LOOKUP_NO_REVAL		0x0080
 #define LOOKUP_JUMPED		0x1000
 #define LOOKUP_ROOT		0x2000
-#define LOOKUP_ROOT_GRABBED	0x4000
+#define LOOKUP_ROOT_GRABBED	0x0008
 
 extern int path_pts(struct path *path);
 

to avoid breaking out-of-tree stuff for now good reason.
Folded and pushed out.
