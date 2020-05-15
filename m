Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0401D57CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 19:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgEOR1o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 13:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbgEOR1n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 13:27:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C75C061A0C;
        Fri, 15 May 2020 10:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=18mwp/q8sV8ky3Xs5Csf6eFReIMsx0xc80Vz0Im9aK8=; b=AYT3eRrVNy9OS3ow10EwcjCcYe
        HDo7BHlOZGG6GoeWHX+hq6EXMisOZ/X4fA0GPq1zilq3XFO57QKal2qmZ7tMcCksU2nKxmKuNMaNu
        +EoiYsOFuboNCtPZE6ZFjCSVhRSz57+fhKpljr35lIoDdwGF0cMASNNZba4HnPVeyYY97QP0CzeBO
        MK22lgrr0XJB6KxvgKKQ8w9hqB//g42yGpFNoOVjz5kXTEIyQFKguQF0ObZY1+2sbQDFP0nJ5ALs/
        EvGx10W/hMWWrBg3tpEUvbnhCGg2P1oCW4F7LiWtZsBWyeFmjE4W3DDKPg1Im6BuQ5DCthaRVmNrW
        2Tlpt3YA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZe7Z-0008Ua-Ff; Fri, 15 May 2020 17:27:41 +0000
To:     "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] nfs: fsinfo: fix build when CONFIG_NFS_V4 is not
 enabled
Message-ID: <f91b8f29-271a-b5cd-410b-a43a399d34aa@infradead.org>
Date:   Fri, 15 May 2020 10:27:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix multiple build errors when CONFIG_NFS_V4 is not enabled.

../fs/nfs/fsinfo.c: In function 'nfs_fsinfo_get_supports':
../fs/nfs/fsinfo.c:153:12: error: 'const struct nfs_server' has no member named 'attr_bitmask'
  if (server->attr_bitmask[0] & FATTR4_WORD0_SIZE)
            ^~
../fs/nfs/fsinfo.c:155:12: error: 'const struct nfs_server' has no member named 'attr_bitmask'
  if (server->attr_bitmask[1] & FATTR4_WORD1_NUMLINKS)
            ^~
../fs/nfs/fsinfo.c:158:12: error: 'const struct nfs_server' has no member named 'attr_bitmask'
  if (server->attr_bitmask[0] & FATTR4_WORD0_ARCHIVE)
            ^~
../fs/nfs/fsinfo.c:160:12: error: 'const struct nfs_server' has no member named 'attr_bitmask'
  if (server->attr_bitmask[0] & FATTR4_WORD0_HIDDEN)
            ^~
../fs/nfs/fsinfo.c:162:12: error: 'const struct nfs_server' has no member named 'attr_bitmask'
  if (server->attr_bitmask[1] & FATTR4_WORD1_SYSTEM)
            ^~
../fs/nfs/fsinfo.c: In function 'nfs_fsinfo_get_features':
../fs/nfs/fsinfo.c:205:12: error: 'const struct nfs_server' has no member named 'attr_bitmask'
  if (server->attr_bitmask[0] & FATTR4_WORD0_CASE_INSENSITIVE)
            ^~
../fs/nfs/fsinfo.c:207:13: error: 'const struct nfs_server' has no member named 'attr_bitmask'
  if ((server->attr_bitmask[0] & FATTR4_WORD0_ARCHIVE) ||
             ^~
../fs/nfs/fsinfo.c:208:13: error: 'const struct nfs_server' has no member named 'attr_bitmask'
      (server->attr_bitmask[0] & FATTR4_WORD0_HIDDEN) ||
             ^~
../fs/nfs/fsinfo.c:209:13: error: 'const struct nfs_server' has no member named 'attr_bitmask'
      (server->attr_bitmask[1] & FATTR4_WORD1_SYSTEM))
             ^~


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-nfs@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
---
 fs/nfs/fsinfo.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-next-20200515.orig/fs/nfs/fsinfo.c
+++ linux-next-20200515/fs/nfs/fsinfo.c
@@ -5,6 +5,7 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
+#include <linux/kconfig.h>
 #include <linux/nfs_fs.h>
 #include <linux/windows.h>
 #include "internal.h"
@@ -150,6 +151,7 @@ static int nfs_fsinfo_get_supports(struc
 		sup->stx_mask |= STATX_CTIME;
 	if (server->caps & NFS_CAP_MTIME)
 		sup->stx_mask |= STATX_MTIME;
+#if IS_ENABLED(CONFIG_NFS_V4)
 	if (server->attr_bitmask[0] & FATTR4_WORD0_SIZE)
 		sup->stx_mask |= STATX_SIZE;
 	if (server->attr_bitmask[1] & FATTR4_WORD1_NUMLINKS)
@@ -161,6 +163,7 @@ static int nfs_fsinfo_get_supports(struc
 		sup->win_file_attrs |= ATTR_HIDDEN;
 	if (server->attr_bitmask[1] & FATTR4_WORD1_SYSTEM)
 		sup->win_file_attrs |= ATTR_SYSTEM;
+#endif
 
 	sup->stx_attributes = STATX_ATTR_AUTOMOUNT;
 	return sizeof(*sup);
@@ -202,12 +205,14 @@ static int nfs_fsinfo_get_features(struc
 	if (server->caps & NFS_CAP_MTIME)
 		fsinfo_set_feature(ft, FSINFO_FEAT_HAS_MTIME);
 
+#if IS_ENABLED(CONFIG_NFS_V4)
 	if (server->attr_bitmask[0] & FATTR4_WORD0_CASE_INSENSITIVE)
 		fsinfo_set_feature(ft, FSINFO_FEAT_NAME_CASE_INDEP);
 	if ((server->attr_bitmask[0] & FATTR4_WORD0_ARCHIVE) ||
 	    (server->attr_bitmask[0] & FATTR4_WORD0_HIDDEN) ||
 	    (server->attr_bitmask[1] & FATTR4_WORD1_SYSTEM))
 		fsinfo_set_feature(ft, FSINFO_FEAT_WINDOWS_ATTRS);
+#endif
 
 	return sizeof(*ft);
 }

