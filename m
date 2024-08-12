Return-Path: <linux-fsdevel+bounces-25665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D990894EC54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 14:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99721282DBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 12:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2D4178365;
	Mon, 12 Aug 2024 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v2/3nuYB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7538A1366;
	Mon, 12 Aug 2024 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464416; cv=none; b=hwRXziQN+wBeDDbKUFYFJeyHyyxPc+1pzP8TzSJEBLCYAzynplpl1OoCPMMp/iWGXXy8JicENfFdBEXxoGSLLhLFhjNjMoOVQMHEebBOT87o68pKqg3rn3wZIljdVMQ0wEKDQxFQpZVaFFToR0MTAphBjsdHfmCLAe+CU5V79cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464416; c=relaxed/simple;
	bh=DpsWiChxjmyaux6BErQaGcKkKVsEvrMOcnsF9pgLe9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOIioZqBVlRYY+bcAe0VdhRxCph8I7I4S9I9QW7xuUKxKtrit7U606sAwbTL0h7P2OdqpW1qErSD1tnjKlX64493u8nISIvrz0+EaV3zGc60tylGrVng8R5ow9zpQfXpTvPC+czL456dq3T3eC5YMUyuBtI8eGMMUFy8rDl4gvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v2/3nuYB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dBkuWRNxbprsxyhwSb3kIAaUhL+qnnV0bqBWm5ijRJA=; b=v2/3nuYBIKPReHq0uiNMarVJGq
	dQyXkmQrU28XYj+FPS+LnhFaUjPgqHyswbM1er4YwzjnxpZHCyxdVbOpJNMgiJWk92E4v0EF/o03W
	Sir35uBJhXl6mhk2vbK7TgNm+/uTDiL4wazqpdH5v6Jtrf8I5QuU113Vf4NqlKLtrgC6mgHTj55HU
	vdpAuDDcYhU5HTUL3vc4tCYfXvvOtZwnVq25xtoQBwkcb8PzEdBQ3zNYDBN5gaH6xwT9trshAMXYc
	8ov1k7JA25bkFfNQ1RuLDuKHb/M0TQ2TsJb/5HG2YuGSMfU3YQ/ex6PF8JBsWD1Mh4Kd2zwbpZIb+
	5dENnoyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdTp6-00000000CrL-035Y;
	Mon, 12 Aug 2024 12:06:52 +0000
Date: Mon, 12 Aug 2024 05:06:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dongliang Cui <dongliang.cui@unisoc.com>
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com, ke.wang@unisoc.com,
	cuidongliang390@gmail.com, Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: Re: [PATCH v4] exfat: check disk status during buffer write
Message-ID: <Zrn622M2F1x-fH3n@infradead.org>
References: <20240808063648.255732-1-dongliang.cui@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808063648.255732-1-dongliang.cui@unisoc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> Apart from generic/622, all other shutdown-related cases can pass.
> 
> generic/622 fails the test after the shutdown ioctl implementation, but
> when it's not implemented, this case will be skipped.
> 
> This case designed to test the lazytime mount option, based on the test
> results, it appears that the atime and ctime of files cannot be
> synchronized to the disk through interfaces such as sync or fsync.
> It seems that it has little to do with the implementation of shutdown
> itself.
> 
> If you need detailed information about generic/622, I can upload it.

generic/622 tests that file systems implement at least lazytime
semantics.  If exfat fails that it probably has timestamp handling
issue which are unrelated to the shutdown support, but which are only
exposed by this test that requires shutdown support.  It would be great
if someone could look into that, but that's not a precondition for
your patch.


