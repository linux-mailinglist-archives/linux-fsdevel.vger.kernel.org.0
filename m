Return-Path: <linux-fsdevel+bounces-63343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A356BB61F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 09:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC9719C6207
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 07:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90996226863;
	Fri,  3 Oct 2025 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pozo5R/G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C768D1DDA18;
	Fri,  3 Oct 2025 07:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475051; cv=none; b=Y9cy21PiqubWpf/MtgbXmtQ5NTiEAtSc6XV6dSPNIS5+BOOWstqDq5pznn/PvWwp+H9rBf8wLW/jO52cqUdozkGJKJFxA9uKDsiXMXdQCEETLPxG3ciOw1Ox+4EgBeoJer4PR7FOx+G6L7NjkPDLSwtwgw3zlICZBo+OrZ68TtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475051; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDdLuPyCNIvn5FEJfYfz8sI7w7U/+ESe2sK1CsujHyxMcoch0HeqolvglYddDYId2ywsjaDj+4rTa+kUGLByH7GBPJR35nBfU0+uggtwgz/12ilMN352lKajdpVep34vnypDcBbmhncqvl8MsdO6KnwPdGmy5GgVzv+O1ddBYE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pozo5R/G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=pozo5R/GzGGOusqqh99cm79Eiq
	OrUCAtFhMdeH7+HdgdMT+Qs9ocduSVIPveyJm5EKfcBR9K3qjjQaNfYw1Zhnwf6qHQtjyK6pFLYKi
	banq9FpDWd9VxxKkFT38DtDZNNuZ/c/aWdXD+gKt9qeA273asBsH0kspFzh1FioBZacM/kJcQdNT1
	MNYNp340XGK1WdHWPUb4U7RyAXIWxCiiXNqD7F/R2oYz2i+GRhKfXXgEgPzvGZBAukduLhppBb5cE
	IN8+golBlmp8aVVdl5DIv20fg1UKPagKLyVaPM36mYckXNUaqNBYMHTpavATQRMCKOYhNYmaTASSu
	tto46Dfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4Zpl-0000000BmmO-40FO;
	Fri, 03 Oct 2025 07:04:05 +0000
Date: Fri, 3 Oct 2025 00:04:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 1/6] loop: add helper lo_cmd_nr_bvec()
Message-ID: <aN91ZTKe1wOwGwsB@infradead.org>
References: <20250928132927.3672537-1-ming.lei@redhat.com>
 <20250928132927.3672537-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928132927.3672537-2-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


