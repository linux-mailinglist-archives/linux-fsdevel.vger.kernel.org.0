Return-Path: <linux-fsdevel+bounces-408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9427CA8AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 14:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086121C20B22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 12:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633E02770D;
	Mon, 16 Oct 2023 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BP/wvO6C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87765273FB
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 12:58:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E756CEB;
	Mon, 16 Oct 2023 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ObD2Urf5JwLy9ruZZLszt1TmvHtSWk9zNtD+iNIfaDI=; b=BP/wvO6CMNaMg6+OIiTW400rru
	FhQc7v9sEmZhj7p05vM0fC6kXz2vt9OxNEATzqE0FEmrdNczON81+IjCom+tWMRwWXj2TjpgvaVFC
	fu9A7A4RoWM1vwuR6JUfeU+SGW9EXigyMQ8DMbHojhOo+tdt3yhoyFhujfznhGDlE9C2KhBFhyrtL
	ijx64YH4cvArCxoR8VL71e2s7w3on4m1+Fpi9aqoaJr1d4ZQ9OBju/fCq8p2tVDTQ+/WFEVX7KFC+
	IQC9GWReNcX4ZukIkN1ySX3DPIDo44EHNOVq9enIQSa+JEPESyfd9th3lebXIRsj5lM1/wurDQCM2
	rbbr27vg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qsNAd-009fBL-2U;
	Mon, 16 Oct 2023 12:58:07 +0000
Date: Mon, 16 Oct 2023 05:58:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
	djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
	dchinner@redhat.com
Subject: Re: [PATCH v3 11/28] iomap: pass readpage operation to read path
Message-ID: <ZS0zX7BxxeZnKl05@infradead.org>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-12-aalbersh@redhat.com>
 <ZSz/FLK+tNIQzOA/@infradead.org>
 <xic2dogypvli45ku7nasuuszslvv55tadj6etpl7r3gubvw2o6@hms55yjiqsiq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xic2dogypvli45ku7nasuuszslvv55tadj6etpl7r3gubvw2o6@hms55yjiqsiq>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 02:32:25PM +0200, Andrey Albershteyn wrote:
> >From the discussion in v2 [1] I understood that btrfs would like to
> have this bio_set/submit_io interface for iomap transition;

For btrfs it would not be a transitional thing, but forever as it has
it's own equivalent of a device mapper at this level.  But now that
the fsverity interfaces work so that we don't have other file system
dependencies I would not want to design around it.  If/when btrfs
migrates to iomap for the buffer read path we can easily hook this
into the existing code.

> and any
> other filesystem deferrals would also be possible. Is it no more the
> case with btrfs? Would fs-verity verification in iomap_read_end_io
> combine both solutions (fs-verity verification in iomap +
> submit_io/bio_set interface).

btrfs does also need to do I/O completion from a workqueue, but it
needs it's own.  fsverity OTOH is a pretty generic feature.


