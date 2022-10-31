Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28CE61379E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 14:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiJaNPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 09:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiJaNPk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:15:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CAA60C7;
        Mon, 31 Oct 2022 06:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IGoilmK91RhEEXcDDjLoScAYGtZO0SjZXqnGMsah/9M=; b=zUdWXkWxOcDFwpH6bgp0SA2FUf
        YL4M43p8pqwPiDjvRyV1bUGB7VDbGMyN+/cH7XpzfVcN7/o8wVebyBH7aXJxoJ40OkGcsUtmgaeFY
        V3/k4e8Scg13R1v3OLg3FQTu7cLwImXeaT+jayzw4C94tcl1ZHN8hpp2ySXsUGMnE+KZdOX4ZN/CM
        BtK7IxJcKvYENab6OMfZ4qWV2l5uAfFV4jFVbXHyH3CDLQNWI//bOWjOSIamGxTaJEOok4Hch5fYF
        sdvS9OO/SNms/w4Ap5gRPTJCqVT4N8arECslXeEgCMeYN+OU9/qfrM6kFRoR5pTMDRtTY2C8UqN0U
        GiVpdJuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opUdY-00BwK5-Vr; Mon, 31 Oct 2022 13:15:32 +0000
Date:   Mon, 31 Oct 2022 06:15:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     viro@zeniv.linux.org.uk, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix undefined behavior in bit shift for SB_NOUSER
Message-ID: <Y1/KdOyExwCdfCqb@infradead.org>
References: <20221029071745.2836665-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029071745.2836665-1-cuigaosheng1@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 29, 2022 at 03:17:45PM +0800, Gaosheng Cui wrote:
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1396,7 +1396,7 @@ extern int send_sigurg(struct fown_struct *fown);
>  #define SB_NOSEC	(1<<28)
>  #define SB_BORN		(1<<29)
>  #define SB_ACTIVE	(1<<30)
> -#define SB_NOUSER	(1<<31)
> +#define SB_NOUSER	(1U<<31)

Let's mark all of the flags as unsigned instead of just one so that
we don't mix types.  s_flags is already unsigned (although for some
reason long) already.

And while you touch this please add the proper whitespaces around the
shift operator everywhere.
