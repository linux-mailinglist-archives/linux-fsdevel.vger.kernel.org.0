Return-Path: <linux-fsdevel+bounces-509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E8A7CBA72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 07:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419352817D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 05:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC20FC2D0;
	Tue, 17 Oct 2023 05:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jZ6IBs+M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0182BC2C4
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 05:57:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AFEB6;
	Mon, 16 Oct 2023 22:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0hqF3FraEYnMxfUj7zieQAPfPsyUthCr8j2icFG69Sw=; b=jZ6IBs+M3rhjBo/0CdifPyIvYZ
	/w3tQj91UkMeV2ROPIYtSs/N38BlCH9fKOOSnffUUqMvt+vl5+XkDpXQ/c56dXbcSDzhXXaFEx/aA
	+QN0bV8EkXFHdk2+suE38nCixOOUNDeQYMUBQrxaANcaHbMxHzTGpfXf2zG8x6jYWtoT9wgLsr9yg
	+fCmpgKw/U+CnjPDprT0+e7RyGYDu+8nWXD/1I1w0rFYwwWOKKnaCJU1AW/QmvO3Co8OwvnidHQpq
	v68AtPlCb4cp/0JLwW9eFv20k0KKfF4kDI54s0Wv9f50YI91tTwjFJL0Y7xeNaj1JhbT0WXx57i5+
	Vp2D/mRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qsd5N-00BL5C-35;
	Tue, 17 Oct 2023 05:57:45 +0000
Date: Mon, 16 Oct 2023 22:57:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
	djwong@kernel.org, david@fromorbit.com, dchinner@redhat.com,
	willy@infradead.org
Subject: Re: [PATCH v3 07/28] fsverity: always use bitmap to track verified
 status
Message-ID: <ZS4iWdsXQT7CaxS6@infradead.org>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-8-aalbersh@redhat.com>
 <20231011031543.GB1185@sol.localdomain>
 <q75t2etmyq2zjskkquikatp4yg7k2yoyt4oab4grhlg7yu4wyi@6eax4ysvavyk>
 <20231012072746.GA2100@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012072746.GA2100@sol.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 12:27:46AM -0700, Eric Biggers wrote:
> Currently there are two options: PG_checked and the separate bitmap.  I'm not
> yet convinced that removing the support for the PG_checked method is a good
> change.  PG_checked is a nice solution for the cases where it can be used; it
> requires no extra memory, no locking, and has no max file size.  Also, this
> change seems mostly orthogonal to what you're actually trying to accomplish.

Given that willy has been on a (IMHO reasonable) quest to kill off
as many as possible page flags I'd really like to seize the opportunity
and kill PageCheck in fsverity.  How big are the downsides of the bitmap
vs using the page flags, and do they matter in practice?


