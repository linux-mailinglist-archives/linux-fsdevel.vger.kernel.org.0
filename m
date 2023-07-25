Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BE3761CA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 17:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjGYPAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 11:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjGYO7c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:59:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E871FD3;
        Tue, 25 Jul 2023 07:59:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7581661796;
        Tue, 25 Jul 2023 14:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC60C433B6;
        Tue, 25 Jul 2023 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690297150;
        bh=2uDpIMGQVMt/gC4T/BxJPAgKQID6PeU0gqKfksNKWnI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=n2fO+6f3o9pY7IlFzt0rPNlCPvC97bsCNM+BfmqJUquIMuUUrh8omevU9O4/AHkm1
         BUhGetnUcCuK1rxWP8h5CviIrVUp9eXO8jpGbYi5hteTH5Xqe5ITh/GzhKNHYCKlZk
         vlcYpaRegzQJvuY8ntTnypuLjutaWGFpxjpGt7wd4i0rEDrs0fPNKp6yIhyqEEdtAb
         8/r999SguPHVOPOVMoBGAZsACOuuAASF/w90W4MAecKdLt6gEneLVh/fG/faExs3M6
         nCO0XjvC7eMTX9Xqd+6QSmh67WMiduueljqyzpsqyRjLawhI4Oj6HHr3+rEmH8yk8G
         2Ixb9ASBBSh0Q==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Tue, 25 Jul 2023 10:58:16 -0400
Subject: [PATCH v6 3/7] tmpfs: bump the mtime/ctime/iversion when page
 becomes writeable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230725-mgctime-v6-3-a794c2b7abca@kernel.org>
References: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
In-Reply-To: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
To:     Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Anthony Iliopoulos <ailiop@suse.com>, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nfs@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        devel@lists.orangefs.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-mtd@lists.infradead.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1641; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2uDpIMGQVMt/gC4T/BxJPAgKQID6PeU0gqKfksNKWnI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkv+MjNDHnc3VpUZs/F8L9rjN3Zof/qnAfmWfPJ
 HHeEPSmh46JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZL/jIwAKCRAADmhBGVaC
 FcRQEAC4JBQVQ/gYYTowPETQ4WpI/KRmcf8ArByri6vezI/PnnC+6/c78VVo2CeuLvo39NWHvEc
 WjMBGKoIjC/rRO0g9ZTnQyG5xMCVFJm+txy5uj0RrkqVeSajWVGMi40jIG0PKIJonSTnuHRNnvv
 r0qqzIRryKNHPBIqhnaRnVE7lXDmsMo5PQmseWqdieD39P983bSTK3hdLBday25rstPj4a2TwIt
 U65Yd+CzgPnnCD8f/dWD0LThNK7BtgniJDaWOop13mmeXYnImIgU1M8iY29eCS+EPq8YjysZad3
 /bEH2S2nqMnbI/nw3UQ941Rxnnmw6bEPVJnqJAOILyOesX5D82MfHRraU5UCMLp1UUkr/S/iRZf
 +CarYlZ09IaFEzrA5A2xvr7M4KiNkRaOEhxzDIsQnsRlyqq5jSyU3JRapUwrSogBCkWuAMZRIyG
 JCaLNaT6v0B5u06FAdINF6uBlVGTmgb4jdavZFZgdI9vrNqAhU42ctOi+vRusrge9q3OR0LDnTU
 qMHqNtWGe3Hsc2mZEDzSRaXyzcEYKHXBLlXvun2i/eibMafbVx3qIaTbmDNpFzpim2LoIXyGBld
 HgWK8WxTS/Hc2mF2qYRoCmLCYwcXO/X1WknZcNwcoUCIy50fLXiWyW+IvPAQjYx/4uETnI8jV8R
 chM8OWlWlDNeYjA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most filesystems that use the pagecache will update the mtime, ctime,
and change attribute when a page becomes writeable. Add a page_mkwrite
operation for tmpfs and just use it to bump the mtime, ctime and change
attribute.

This fixes xfstest generic/080 on tmpfs.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index b154af49d2df..654d9a585820 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2169,6 +2169,16 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 	return ret;
 }
 
+static vm_fault_t shmem_page_mkwrite(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct inode *inode = file_inode(vma->vm_file);
+
+	file_update_time(vma->vm_file);
+	inode_inc_iversion(inode);
+	return 0;
+}
+
 unsigned long shmem_get_unmapped_area(struct file *file,
 				      unsigned long uaddr, unsigned long len,
 				      unsigned long pgoff, unsigned long flags)
@@ -4210,6 +4220,7 @@ static const struct super_operations shmem_ops = {
 
 static const struct vm_operations_struct shmem_vm_ops = {
 	.fault		= shmem_fault,
+	.page_mkwrite	= shmem_page_mkwrite,
 	.map_pages	= filemap_map_pages,
 #ifdef CONFIG_NUMA
 	.set_policy     = shmem_set_policy,
@@ -4219,6 +4230,7 @@ static const struct vm_operations_struct shmem_vm_ops = {
 
 static const struct vm_operations_struct shmem_anon_vm_ops = {
 	.fault		= shmem_fault,
+	.page_mkwrite	= shmem_page_mkwrite,
 	.map_pages	= filemap_map_pages,
 #ifdef CONFIG_NUMA
 	.set_policy     = shmem_set_policy,

-- 
2.41.0

