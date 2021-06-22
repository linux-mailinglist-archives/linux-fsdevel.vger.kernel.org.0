Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979843AFCD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 08:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhFVGGi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 02:06:38 -0400
Received: from verein.lst.de ([213.95.11.211]:45192 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhFVGGh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 02:06:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A282C67357; Tue, 22 Jun 2021 08:04:19 +0200 (CEST)
Date:   Tue, 22 Jun 2021 08:04:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chung-Chiang Cheng <shepjeng@gmail.com>
Cc:     jlbec@evilplan.org, hch@lst.de, pantelis.antoniou@konsulko.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chung-Chiang Cheng <cccheng@synology.com>
Subject: Re: [PATCH] configfs: fix memleak in configfs_release_bin_file
Message-ID: <20210622060419.GA29360@lst.de>
References: <20210618075925.803052-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618075925.803052-1-cccheng@synology.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hmm.  The issue looks real, but I think we should just call the vfree
unconditionally given that the buffer structure is zeroed on allocation
and freed just after, and also remove the pointless clearing of all the
flags.  Does something like this work for you?

diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index 53913b84383a..1ab6afb84f04 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -393,11 +393,8 @@ static int configfs_release_bin_file(struct inode *inode, struct file *file)
 {
 	struct configfs_buffer *buffer = file->private_data;
 
-	buffer->read_in_progress = false;
-
 	if (buffer->write_in_progress) {
 		struct configfs_fragment *frag = to_frag(file);
-		buffer->write_in_progress = false;
 
 		down_read(&frag->frag_sem);
 		if (!frag->frag_dead) {
@@ -407,13 +404,9 @@ static int configfs_release_bin_file(struct inode *inode, struct file *file)
 					buffer->bin_buffer_size);
 		}
 		up_read(&frag->frag_sem);
-		/* vfree on NULL is safe */
-		vfree(buffer->bin_buffer);
-		buffer->bin_buffer = NULL;
-		buffer->bin_buffer_size = 0;
-		buffer->needs_read_fill = 1;
 	}
 
+	vfree(buffer->bin_buffer);
 	configfs_release(inode, file);
 	return 0;
 }
