Return-Path: <linux-fsdevel+bounces-29535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E5D97A914
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 00:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6A01F291FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 22:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B422A15C131;
	Mon, 16 Sep 2024 22:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PFfymQjH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E4F13E41D;
	Mon, 16 Sep 2024 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726524737; cv=none; b=TCnYihp4WDmHc56CJWj3GWOmXa50VgIzlkr8rzeAE93H0qZO4a2d7uQoQC+JrAeNNGOApKTOTECFnl32MyPuHXU3Wptqt+xTntTFRJexaKsGqWeBH7vtUzNz6eU2kItjDWraz4peq4n124Tr5KA0PAQ9XdifHKpkLccDNC/FKGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726524737; c=relaxed/simple;
	bh=2DFtUVulRNTdSz+07OwX25/zVMh+qxK9LJFbwUzFXUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6ylRLOr5zL3HfYinDX99YyBDULI14M/BcTgMyrkMdBXlVWpJOuCssjDdxV+o0L6skQKQ75T/uwQZ4vLrh+Zx0cvRYuErgGg7OmAwdstyNR1k29IJ3Cq2g5ljNn/XW3aAB+syxjOzTOVAUmVE58INOK3H/zwAED4WsBLeVQc9uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PFfymQjH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SGt/5yXU2YrKkFcDYi5Hh5OdKKwpmBcF5le0kvs94Q0=; b=PFfymQjHmaS7Ej02J3GntvbeBV
	VcVYJvDpGS6ezjlyh4XLmSRbzoN7o5bFjT5yY7d8Hj/vIXDJIXCh0/UKAkZiLTxrcCRpkJ5g0hOwM
	XxUf+gCNsqe3uwW+i8GBBbWPuX3NLuUDICw34223D24d6MxTujyQ6bmSvQwWNe3zbuBYUQ8H6Y7/Y
	yDvGZ6Plt6i1uYz8qOP4vWEZ+3buWWVBy5vqTB16gxzqreJ1n/al+fwRqjB++jX9Zb1gI0vrlU/qE
	74HMvJZGSMOW4hm3C7Q/PUkJfArWbvNklFnIhgHbtGoMvXMhULs3qpUKN8rnCH8L5V6rjktXFjCQG
	hRBfTy8A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqJx5-0000000D3Oe-39rk;
	Mon, 16 Sep 2024 22:12:11 +0000
Date: Mon, 16 Sep 2024 23:12:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] fs/exfat: resolve memory leak from
 exfat_create_upcase_table()
Message-ID: <20240916221211.GC3107530@ZenIV>
References: <20240916052128.225475-1-danielyangkang@gmail.com>
 <CAKYAXd_M1x-Lzsozp=o_wqR4gODpdf8SbMwLYrLmPs_hN=p8Kg@mail.gmail.com>
 <CAGiJo8SBf4zsY-ZrZQh_hxYZ7=xObfcgFxbTnWOtcz9DORGueA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGiJo8SBf4zsY-ZrZQh_hxYZ7=xObfcgFxbTnWOtcz9DORGueA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Sep 16, 2024 at 02:58:43PM -0700, Daniel Yang wrote:

> In exfat_create_upcase_table, ENOMEM and EINVAL result in a jump to
> exfat_load_default_upcase_table where memory is also allocated. Since
> ENOMEM doesn't allocate memory, freeing null addresses will result in a
> double free.

Freeing null address is a no-op.  Explicitly guaranteed, for the
same reason why C standard guarantees that free(NULL) is a no-op.
So you don't need to check if allocation had been done.

