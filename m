Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66E168F540
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 21:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfHOT76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 15:59:58 -0400
Received: from fieldses.org ([173.255.197.46]:34696 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbfHOT76 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:59:58 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 5E81A1F01; Thu, 15 Aug 2019 15:59:58 -0400 (EDT)
Date:   Thu, 15 Aug 2019 15:59:58 -0400
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>,
        syzbot <syzbot+2c95195d5d433f6ed6cb@syzkaller.appspotmail.com>
Subject: Re: [PATCH] nfsd: fix dentry leak upon mkdir failure.
Message-ID: <20190815195958.GB19554@fieldses.org>
References: <0000000000001097b6058fe1fb22@google.com>
 <1565576171-6586-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565576171-6586-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 11:16:11AM +0900, Tetsuo Handa wrote:
> syzbot is reporting that nfsd_mkdir() forgot to remove dentry created by
> d_alloc_name() when __nfsd_mkdir() failed (due to memory allocation fault
> injection) [1].

Thanks!  But it might be clearer to do this in the caller, in the same
place the dentry was allocated?

--b.

commit d6846bfbeeac
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Mon Aug 12 11:16:11 2019 +0900

    nfsd: fix dentry leak upon mkdir failure.
    
    syzbot is reporting that nfsd_mkdir() forgot to remove dentry created by
    d_alloc_name() when __nfsd_mkdir() failed (due to memory allocation fault
    injection) [1].
    
    [1] https://syzkaller.appspot.com/bug?id=ce41a1f769ea4637ebffedf004a803e8405b4674
    
    Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    Reported-by: syzbot <syzbot+2c95195d5d433f6ed6cb@syzkaller.appspotmail.com>
    Fixes: e8a79fb14f6b76b5 ("nfsd: add nfsd/clients directory")
    [bfields: clean up in nfsd_mkdir instead of __nfsd_mkdir]
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 13c548733860..928a0b2c05dc 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1205,6 +1205,7 @@ static struct dentry *nfsd_mkdir(struct dentry *parent, struct nfsdfs_client *nc
 	inode_unlock(dir);
 	return dentry;
 out_err:
+	dput(dentry);
 	dentry = ERR_PTR(ret);
 	goto out;
 }
