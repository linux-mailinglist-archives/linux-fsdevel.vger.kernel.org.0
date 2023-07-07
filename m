Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253EA74AFCE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 13:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjGGL3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 07:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjGGL3V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:29:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD202100;
        Fri,  7 Jul 2023 04:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wJgsDHh5HYYtVRdMHx8zuGrawKX6Ed1TZktUw5oGUnQ=; b=wfT3+DZI080k0A8y1McdGcpf+T
        UyRlzKpGhViBsX83jEcEhSM3A2l0/aiTSwVjOTfjSMf+3Mx2gBooURlgMO5cFnQAGB+mJUIItdxFm
        DWuGUzaONVUrfeSJs3+ox7/+1QusGVCF88aE+KSmgV3FMvL+XKIXuR0lbAbtVA9XlYLtkLOVtG1AH
        DyHHW+GURQodu2Ss/tZddHWarGcgDWx2AwIqixZUFOKtNHeBQT/2xQZXeLHZwPI2UK5V/OOAhjUx2
        51cfhbA3+5DN+I/3uD1EGLNg+f0YoP/Ytd6ynq1ndEzk2ffovTRTDuo9a6Ahx/+j6raqFpnWyGaTg
        P/52PkkQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHjeK-004Vx0-2T;
        Fri, 07 Jul 2023 11:29:20 +0000
Date:   Fri, 7 Jul 2023 04:29:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 02/32] block: Use file->f_flags for determining exclusive
 opens in file_to_blk_mode()
Message-ID: <ZKf3EFhozU8H60wr@infradead.org>
References: <20230629165206.383-1-jack@suse.cz>
 <20230704122224.16257-2-jack@suse.cz>
 <ZKbfO5eFJ9hVueb/@infradead.org>
 <20230706163556.7ygts5dhfhgj53zl@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706163556.7ygts5dhfhgj53zl@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 06, 2023 at 06:35:56PM +0200, Jan Kara wrote:
> > While this looks a lot nicer, I don't think it actually works given that
> > do_dentry_open clears out O_EXCL, and thus it won't be set when
> > calling into blkdev_ioctl.
> 
> Aha, good point! So I need to workaround this a bit differently. I think
> the best would be to have file_to_blk_mode() for blkdev_open() only and
> make the other places (which already have bdev_handle available from
> struct file) use bdev_handle->mode.

Exactly.

> But I have to come up with a sane
> transition to that state :).

I think you can simply do it in the patch switching the block device
to be handle based.
