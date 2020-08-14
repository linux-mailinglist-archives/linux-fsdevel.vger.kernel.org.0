Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE2D244ABD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Aug 2020 15:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgHNNmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Aug 2020 09:42:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:43210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgHNNmC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Aug 2020 09:42:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7BB76AFBF;
        Fri, 14 Aug 2020 13:42:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7C143DA6EF; Fri, 14 Aug 2020 15:40:57 +0200 (CEST)
Date:   Fri, 14 Aug 2020 15:40:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: NTFS read-write driver GPL implementation by Paragon
 Software.
Message-ID: <20200814134056.GV2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <2911ac5cd20b46e397be506268718d74@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2911ac5cd20b46e397be506268718d74@paragon-software.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 14, 2020 at 12:29:01PM +0000, Konstantin Komarov wrote:
> This patch adds NTFS Read-Write driver to fs/ntfs3.
> 
> Having decades of expertise in commercial file systems development and huge
> test coverage, we at Paragon Software GmbH want to make our contribution to
> the Open Source Community by providing implementation of NTFS Read-Write
> driver for the Linux Kernel.
> 
> This is fully functional NTFS Read-Write driver. Current version works with
> NTFS(including v3.1) normal/compressed/sparse files and supports journal replaying.
> 
> We plan to support this version after the codebase once merged, and add new
> features and fix bugs. For example, full journaling support over JBD will be
> added in later updates.
> 
> The patch is too big to handle it within an e-mail body, so it is available to download 
> on our server: https://dl.paragon-software.com/ntfs3/ntfs3.patch
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

In case somebody wants to compile it, this fixup is needed to let 'make
fs/ntfs3/' actually work, besides enabling it in the config.

diff --git a/fs/Makefile b/fs/Makefile
index 1c7b0e3f6daa..b0b4ad8affa0 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_SYSV_FS)		+= sysv/
 obj-$(CONFIG_CIFS)		+= cifs/
 obj-$(CONFIG_HPFS_FS)		+= hpfs/
 obj-$(CONFIG_NTFS_FS)		+= ntfs/
+obj-$(CONFIG_NTFS3_FS)		+= ntfs3/
 obj-$(CONFIG_UFS_FS)		+= ufs/
 obj-$(CONFIG_EFS_FS)		+= efs/
 obj-$(CONFIG_JFFS2_FS)		+= jffs2/
diff --git a/fs/ntfs3/Makefile b/fs/ntfs3/Makefile
index 4d4fe198b8b8..d99dd1af43aa 100644
--- a/fs/ntfs3/Makefile
+++ b/fs/ntfs3/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_NTFS3_FS) += ntfs3.o
 
-ntfs3-objs := bitfunc.o bitmap.o inode.o fsntfs.o frecord.o \
+ntfs3-y := bitfunc.o bitmap.o inode.o fsntfs.o frecord.o \
 	    index.o attrlist.o record.o attrib.o run.o xattr.o\
 	    upcase.o super.o file.o dir.o namei.o lznt.o\
 	    fslog.o
---
