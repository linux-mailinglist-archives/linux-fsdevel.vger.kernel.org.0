Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6891BC63C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 19:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgD1RLh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 13:11:37 -0400
Received: from verein.lst.de ([213.95.11.211]:57512 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgD1RLh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:11:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3B91C68CF0; Tue, 28 Apr 2020 19:11:34 +0200 (CEST)
Date:   Tue, 28 Apr 2020 19:11:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jeremy Kerr <jk@ozlabs.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] powerpc/spufs: fix copy_to_user while atomic
Message-ID: <20200428171133.GA17445@lst.de>
References: <20200427200626.1622060-2-hch@lst.de> <20200428120207.15728-1-jk@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428120207.15728-1-jk@ozlabs.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FYI, these little hunks reduce the difference to my version, maybe
you can fold them in?

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index c62d77ddaf7d3..1861436a6091d 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -2107,7 +2107,6 @@ static const struct file_operations spufs_wbox_info_fops = {
 static void ___spufs_dma_info_read(struct spu_context *ctx,
 		struct spu_dma_info *info)
 {
-	struct mfc_cq_sr *qp, *spuqp;
 	int i;
 
 	info->dma_info_type = ctx->csa.priv2.spu_tag_status_query_RW;
@@ -2116,8 +2115,8 @@ static void ___spufs_dma_info_read(struct spu_context *ctx,
 	info->dma_info_stall_and_notify = ctx->csa.spu_chnldata_RW[25];
 	info->dma_info_atomic_command_status = ctx->csa.spu_chnldata_RW[27];
 	for (i = 0; i < 16; i++) {
-		qp = &info->dma_info_command_data[i];
-		spuqp = &ctx->csa.priv2.spuq[i];
+		struct mfc_cq_sr *qp = &info->dma_info_command_data[i];
+		struct mfc_cq_sr *qp, *spuqp = &ctx->csa.priv2.spuq[i];
 
 		qp->mfc_cq_data0_RW = spuqp->mfc_cq_data0_RW;
 		qp->mfc_cq_data1_RW = spuqp->mfc_cq_data1_RW;
@@ -2166,7 +2165,7 @@ static const struct file_operations spufs_dma_info_fops = {
 };
 
 static void ___spufs_proxydma_info_read(struct spu_context *ctx,
-	struct spu_proxydma_info *info)
+		struct spu_proxydma_info *info)
 {
 	int i;
 
