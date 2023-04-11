Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7B86DD2BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 08:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjDKGYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 02:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDKGYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:24:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05201722;
        Mon, 10 Apr 2023 23:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vvvoVTo6uRRuAg1HUjBDI7dU65PXUKEZopfNrSUkhqg=; b=M41HlpoCT9nDSlGvPd3jf1Y3K6
        3v4Qtki/KgoPE59M8XiUAoqAtQfmwoQI3I+7u4kt28lRteSbVrSyrXmnerX5cTOkcX2+rDEx6yHE+
        i6B4SKBCYeWr/706bXwYwznLJYTUBRprmtiiJRyCUFGpROymaxZ2OMtD9hJl0NvLS5FfZWk+djfcV
        N4n2b6y8GRzx1aHKn89+DlNeCz/b73dyKmkImyXJFGAZGyOApbrmsYX+r8Ov2PjV4JM1Wl0qqb3Zo
        lNx7c/P7DyK0jzi/Yxqc8qn+bPqbTCD0GL/CdNYMM1Ahky2IC9WfO4CIeh4K0R39jwMdyxTOJznQ0
        qQw2JGDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pm7Pm-00GZYc-05;
        Tue, 11 Apr 2023 06:23:38 +0000
Date:   Mon, 10 Apr 2023 23:23:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Donald Buczek <buczek@molgen.mpg.de>
Cc:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        hch@infradead.org, corbet@lwn.net, snitzer@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org,
        ming.lei@redhat.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 02/11] block: Block Device Filtering Mechanism
Message-ID: <ZDT86vCXcszoBh4e@infradead.org>
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
 <20230404140835.25166-3-sergei.shtepa@veeam.com>
 <be98bee0-4ddc-194f-82be-767e0bb9f60f@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be98bee0-4ddc-194f-82be-767e0bb9f60f@molgen.mpg.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 08, 2023 at 05:16:42PM +0200, Donald Buczek wrote:
> Hi, Sergei,
> 
> On 4/4/23 16:08, Sergei Shtepa wrote:
> > The block device filtering mechanism is an API that allows to attach
> > block device filters. Block device filters allow perform additional
> > processing for I/O units.
> > [...]
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index b7b56871029c..1848d62979a4 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -185,6 +185,11 @@ struct fsxattr {
> >   #define BLKROTATIONAL _IO(0x12,126)
> >   #define BLKZEROOUT _IO(0x12,127)
> >   #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
> > +/* 13* is defined in linux/blkzoned.h */
> 
> nit: This is already explained in the comment below your insert.

My faul.  But indeed, no need to duplicate that, instead the new
ioctl opcodes should move below that existing comment.
