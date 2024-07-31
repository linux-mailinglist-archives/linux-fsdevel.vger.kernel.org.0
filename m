Return-Path: <linux-fsdevel+bounces-24699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487699433B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 17:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87D11F26510
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 15:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022671BBBEE;
	Wed, 31 Jul 2024 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JRqAY2g4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD9A1799F;
	Wed, 31 Jul 2024 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441296; cv=none; b=UL2VpWocLZmD+1JTcxa/juneLevoc1gHAWutTmGemPHpw40sdoxux7K45ipFvwSnzJE85piAnO5WSWls/nhqgGVqDM1dAfcwn36/pTV6uEh7ivNgrTTf2L4tlQReMdbOiiXRfQRG1+iUCAiHVbFFAyf95W3UQS9I6SQNb2B0gWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441296; c=relaxed/simple;
	bh=18/UMq8EJj3RydzQiisL2ZuorE1XGAfvTcjjkSYiTEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRvbdNf03ennBGFV2bfF933U1lo3VZIk84QnnDWxv+ougEukiG3V+kyrhhNRhtffmUPA0GwdesDM0FlqmvE91sMzEmvGJicV2WoCDgmAUS6dihbYBdXIb0Q9PcGH7lBP+TF74F5uAgIr7u0Ntqp87PbL+ht3Mk+HfIXZztopiCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JRqAY2g4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=18/UMq8EJj3RydzQiisL2ZuorE1XGAfvTcjjkSYiTEo=; b=JRqAY2g43ZA6+38/TEL7PsUtRZ
	/AKmPwMnY91ZSyijHWifeMlJiPaFDzeFri13YYiMK8vFSLCM8B55hH7cgmIcXi37noTkUKuUmLkqR
	zlu6Fo/iW6O+qZRgmPGy532gc9nNesxhbQjMxtTuyeynRKxZH5HU3Y6v2RpbxDL4i0zjZio978gi3
	dBYWitgm2HpU1raA+vgUyroSFa6mbkXMsYWu4wxsv9UHWhKhvjPcXiKwMltEuSTOYHcFo5zFCp0e3
	7SqAj1OXS1+eQ14vXT6/F+S+t6M+2+SNxI4W+i+JghhWx4/ohQRLIZ29mwee63TmVOQDn3ZThrs6E
	pNq7lGMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZBf8-00000001n7z-25uz;
	Wed, 31 Jul 2024 15:54:50 +0000
Date: Wed, 31 Jul 2024 08:54:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dongliang Cui <dongliang.cui@unisoc.com>
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com, ke.wang@unisoc.com,
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: Re: [PATCH v3] exfat: check disk status during buffer write
Message-ID: <ZqpeSvEgVtIWrWVr@infradead.org>
References: <20240731022715.4044482-1-dongliang.cui@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731022715.4044482-1-dongliang.cui@unisoc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Besides the additional checks for the shutdown flag already mentioned
the subject is now incorrect I think, it should talk about implementing
shutdown handling.

In case you haven't done so yet, please also see if exfat now passes
the various testcases in xfstests that exercise the shutdown path.

Otherwise this looks reasonable to me, thanks for the work!

