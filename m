Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0FF749F45
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 16:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjGFOnk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 10:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjGFOni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:43:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F851732
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GOGLmZkKS+Mqk0K7P36N7SXDMTDQhhEvNASEsg58n2o=; b=PTV/c2Zrmdwmds7bdhAcrHY4zH
        c22UfluigfJsNeOabr/Ggma0q600wL2GfaqXeKbwqOn61eEKinslsGqH3i9SLHaHe4D2sfwIK/uxQ
        EDk5IMtruepRcvFFUnna2vDHk9W/m+Wc81lqsiX5G+7Gt0L+Jq4u/Wh+Zvx/kqL8OgvOTxKNrbmwu
        BARBHZgcKo/tse1E8cWrhev6j3OKfP8yLzJcxUigwA6B90lw53hr5F3lAxZHlv3HIUgqeTYVNEH45
        3QncFqVbuRB4TpOByOFpoNNBZD6c9Wg5rBadUx4J7JNcr5pA80TEKSXxj1WqZ/bki3Y9oYtp2K5lL
        bpWC3soA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHQCV-001tVc-2x;
        Thu, 06 Jul 2023 14:43:19 +0000
Date:   Thu, 6 Jul 2023 07:43:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net,
        Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [RFC] [PATCH] fuse: DIO writes always use the same code path
Message-ID: <ZKbTB+HgmtjnQqfe@infradead.org>
References: <20230630094602.230573-1-hao.xu@linux.dev>
 <a77b34fe-dbe7-388f-c559-932b1cd44583@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a77b34fe-dbe7-388f-c559-932b1cd44583@fastmail.fm>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 05, 2023 at 12:23:40PM +0200, Bernd Schubert wrote:
> @@ -1377,37 +1375,10 @@ static ssize_t fuse_cache_write_iter(struct kiocb
> *iocb, struct iov_iter *from)
>  	if (err)
>  		goto out;
> 
> -	if (iocb->ki_flags & IOCB_DIRECT) {
> -		loff_t pos = iocb->ki_pos;
> -		written = generic_file_direct_write(iocb, from);

After this generic_file_direct_write becomes unused outside of
mm/filemap.c, please add a patch to the series to mark it static.

> +	written = fuse_perform_write(iocb, mapping, from, iocb->ki_pos);
> +	if (written >= 0)
> +		iocb->ki_pos += written;

This needs to be updated to the new fuse_perform_write calling
conventions in Linus tree.

