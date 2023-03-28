Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE076CCA54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 20:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjC1Szn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 14:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjC1Szm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:55:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E357E2139
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 11:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LLoGba4n/Ljmj34YCe/oWRPa+B1VMNuM/hnH6FqG084=; b=XTzRc4W/iQtRM8xBAS4CeLacwW
        P3obiadE121PvCyfMpIN24HFvwjShWnFlLCNOpuMqgHewv/aMOV12OCiITcP5e41QwJ2As/l21X9V
        1QWehpfenth/AUDADBks7D7RB2D2yI/cUaYMaEH9VlPQtGVdAKONZu+snZQifhKCYLQ/xmxWWVnIL
        a0pcgxffhG5Fpyk++cJGDzBUWpkoM340oq5MsaSzcmbO+qCQ2p0VjwLyzSbUoEpM55OzrLOtDTV1B
        FjLSwceuLctjMflWt7uI7KobddBsGaW4jt/e07MWru/8r28/qhd5nXXl1eJpibvxza+Wa1hdTQzzE
        qUr07XFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1phETq-008gKh-92; Tue, 28 Mar 2023 18:55:38 +0000
Date:   Tue, 28 Mar 2023 19:55:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 5/8] IB/hfi1: make hfi1_write_iter() deal with ITER_UBUF
 iov_iter
Message-ID: <ZCM4KsKa3xQR2IOv@casper.infradead.org>
References: <20230328173613.555192-1-axboe@kernel.dk>
 <20230328173613.555192-6-axboe@kernel.dk>
 <CAHk-=wj=21dt1ASqkvaNXenzQCEZHydYE39+YOj8AAfzeL5HOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj=21dt1ASqkvaNXenzQCEZHydYE39+YOj8AAfzeL5HOQ@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:43:34AM -0700, Linus Torvalds wrote:
>         -       size_t count;
>         -       union {
>         -               const struct iovec *iov;
>         -               const struct kvec *kvec;
>         -               const struct bio_vec *bvec;
>         -               struct xarray *xarray;
>         -               struct pipe_inode_info *pipe;
>         -               void __user *ubuf;
>         +
>         +       /*
>         +        * This has the same layout as 'struct iovec'!
>         +        * In particular, the ITER_UBUF form can create
>         +        * a single-entry 'struct iovec' by casting the
>         +        * address of the 'ubuf' member to that.
>         +        */
>         +       struct {
>         +               union {
>         +                       const struct iovec *iov;
>         +                       const struct kvec *kvec;
>         +                       const struct bio_vec *bvec;
>         +                       struct xarray *xarray;
>         +                       struct pipe_inode_info *pipe;
>         +                       void __user *ubuf;
>         +               };
>         +               size_t count;
>                 };
>                 union {
>                         unsigned long nr_segs;
> 
> and if you accept the above, then you can do
> 
>    #define iter_ubuf_to_iov(iter) ((const struct iovec *)&(iter)->ubuf)
> 
> which I will admit is not *pretty*, but it's kind of clever, I think.

I think it'll annoy gcc, and particularly the randstruct plugin.
How about:

	union {
		struct iovec ubuf;
		struct {
			const struct iovec *iov;
			size_t count; /* Also valid for subsequent types */
		};
		const struct kvec *kvec;
		const struct bio_vec *bvec;
		struct xarray *xarray;
		struct pipe_inode_info *pipe;
	}

