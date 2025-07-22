Return-Path: <linux-fsdevel+bounces-55638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 004E5B0D18F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 07:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F04168752
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 05:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA0828D8C9;
	Tue, 22 Jul 2025 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P3kDcJ1c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5D928CF6B;
	Tue, 22 Jul 2025 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163955; cv=none; b=OPLD2Kc3xM0BNy4GJXw03fV2AWxHKySw40PLZwZU7Q3YKCZkvzCqKGoNz1CwkvW812xTpmvV4fDtyGxZRBJCcNLhITovMPHxz8J0QFYL7I4yUkTu/wf5O8mx5eu87UO2XN++dFKyiQyZ1TOXfr1FgPsAufEvrsitVdWM3/T5AG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163955; c=relaxed/simple;
	bh=dinlk1QJwMX/+sI/SBiMKZoOUaM/VmxQzR0V0OiFN4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKUvR7rUWgrfjUJFHvAO60rbSZTzYmpqcPN3oopCPijyv9k4QHgsJBHkgsysDXeKPy9H3LfeqRsbFeOvhx0cEDszk4jdl3C3HXmPj/HYunK4Gq858ykTfmSFRtGG2YgXdYLRHbbAhH/UUoucr2ZgMgaCmV53M7thQfYpPnjBe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P3kDcJ1c; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dinlk1QJwMX/+sI/SBiMKZoOUaM/VmxQzR0V0OiFN4E=; b=P3kDcJ1cLjlA778aEHPIId4xkO
	GxsWuvToia4Ks95bIa7pLdq4Acyf2auvafrCcuUlkYTTBqCW95+KF4/4rtiaZm3oe4MwoZ8s0upjP
	5hiRLEnh55Doc367UoyTJsC7Jhayk0R9BSfLLkrN3ClYGWLpCcAt2bK2w0LDYTTWyB2/C3XBUjwSA
	vgQQfpsDuSrIxvOKrIH+lgU/536FjD5tRv32M+5+9o5RxMVvXzQPKE5uc9m5PBXKAx5kD47lmRCb7
	i3SSQ9s1vXLzpkAGs20tLhdWeb6PjH/irCdFxpipNs8aFmUROLmoeCnClBdNF90t7c9vaq7y6QQKe
	vAYyy4Ug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue61x-00000001Nkf-1F3m;
	Tue, 22 Jul 2025 05:59:13 +0000
Date: Mon, 21 Jul 2025 22:59:13 -0700
From: 'Christoph Hellwig' <hch@infradead.org>
To: hoyoung seo <hy50.seo@samsung.com>
Cc: 'Christoph Hellwig' <hch@infradead.org>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
	avri.altman@wdc.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
	beanhuo@micron.com, bvanassche@acm.org, kwangwon.min@samsung.com,
	kwmad.kim@samsung.com, cpgs@samsung.com, h10.kim@samsung.com,
	willdeacon@google.com, jaegeuk@google.com, chao@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] writback: remove WQ_MEM_RECLAIM flag in bdi_wq
Message-ID: <aH8osRbuecxTLur4@infradead.org>
References: <CGME20250721062037epcas2p25fd6fcf66914a419ceefca3285ea09f3@epcas2p2.samsung.com>
 <20250721064024.113841-1-hy50.seo@samsung.com>
 <aH3on5GBd6AfgJuw@infradead.org>
 <000001dbfa1a$a2a1ad80$e7e50880$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001dbfa1a$a2a1ad80$e7e50880$@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 21, 2025 at 05:37:03PM +0900, hoyoung seo wrote:
> No way..
> It's because i just don't know much about this part.
> And WQ_MEM_RECLAIM flag is absolutely necessary.

As a rule of thumb try to write an explanation why a change is safe.
That usually kicks of a process to think about the implications.


