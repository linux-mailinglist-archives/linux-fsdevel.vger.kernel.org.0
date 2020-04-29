Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238421BD477
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 08:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgD2GNl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 02:13:41 -0400
Received: from verein.lst.de ([213.95.11.211]:60889 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgD2GNk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:13:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 477C868BEB; Wed, 29 Apr 2020 08:13:37 +0200 (CEST)
Date:   Wed, 29 Apr 2020 08:13:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jeremy Kerr <jk@ozlabs.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] powerpc/spufs: fix copy_to_user while atomic
Message-ID: <20200429061337.GC30946@lst.de>
References: <20200427200626.1622060-2-hch@lst.de> <20200428120207.15728-1-jk@ozlabs.org> <20200428171133.GA17445@lst.de> <e1ebea36b162e8a3b4b24ecbc1051f8081ff5e53.camel@ozlabs.org> <20200429060553.GA30946@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429060553.GA30946@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 08:05:53AM +0200, Christoph Hellwig wrote:
> On Wed, Apr 29, 2020 at 09:36:30AM +0800, Jeremy Kerr wrote:
> > Hi Christoph,
> > 
> > > FYI, these little hunks reduce the difference to my version, maybe
> > > you can fold them in?
> > 
> > Sure, no problem.
> > 
> > How do you want to coordinate these? I can submit mine through mpe, but
> > that may make it tricky to synchronise with your changes. Or, you can
> > include this change in your series if you prefer.
> 
> Maybe you can feed your patch directly to Linus through Michael
> ASAP, and I'll wait for that before resubmitting this series?

Btw, turns out my fold patch didn't actually compile without the
rebased patch on top, sorry.  Here is the proper one:

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index c62d77ddaf7d3..b4e1ef650b406 100644
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
+		struct mfc_cq_sr *spuqp = &ctx->csa.priv2.spuq[i];
 
 		qp->mfc_cq_data0_RW = spuqp->mfc_cq_data0_RW;
 		qp->mfc_cq_data1_RW = spuqp->mfc_cq_data1_RW;
@@ -2166,7 +2165,7 @@ static const struct file_operations spufs_dma_info_fops = {
 };
 
 static void ___spufs_proxydma_info_read(struct spu_context *ctx,
-	struct spu_proxydma_info *info)
+		struct spu_proxydma_info *info)
 {
 	int i;
 
