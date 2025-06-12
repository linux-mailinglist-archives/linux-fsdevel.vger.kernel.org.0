Return-Path: <linux-fsdevel+bounces-51399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD702AD66E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 06:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6843AD304
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 04:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267701D63DD;
	Thu, 12 Jun 2025 04:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1IUoNwuk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3E410E5;
	Thu, 12 Jun 2025 04:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749703329; cv=none; b=ZZFHHSoRin57gQ3OVLF65K0RpL26s3ZreoHSXCUT6I5GseLWBaxXzuXNc9EoNZaH6Q8BKmEyHgJqDfVLeFqhpFdHfYW0XxuTmLaFZevksIBD3SYO/sc5Y0Ryux8UDyOUimd80wX1xdux7uMxpoo0vWNKYohWJ6s0ZsVMIuMn6zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749703329; c=relaxed/simple;
	bh=tVpj/wkk6Oc+SQXgGXAr82FNsfge/FipnIuQpvI7K2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfrfewYPjb9Lu3x4YHO80MNcSF+GyA6JgAGMMYLiH5CwXoi4GKdzP49VKmPB2/pyS78L3C7vhHmT8ZFjfEQDLW5VCl3cxUMenNrGmMdakSiAXc4aIEvBdtB5AatEEFDWonakEWFwpG+RZyjjDAYmIT572ElSa9+Xo7bkNzJYupE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1IUoNwuk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sw52tFicz6QSeSNyZO+/IaSkFjn4ty5PJv8gCZfMXkc=; b=1IUoNwuk4iD1kkoZvgAdnksRvf
	wCfqokNvkfLmGv0INcs91jEikrAPq4A7LPQSPejPYe8FW0PxRo9GFjlS521HXCM/wtHb3kuX8XNVB
	5ovaC1aVApg6g45ud86qgH8tRqkuW6zDlexios7hrJHkKn1RA7O0cKN2Xz6tUB3jqpwLj6elhQeNZ
	tyCzT9AbDmHIU910k3ELkIeH87W3tUbHnIj/Qpf1f3jxS/JuldLBDCYDgMdFX2Z84+Wh8v8T+5b6Q
	ZtvCj/XS4WTT6mBCKDM4uApRjX4MDFO8VQCduYp3PQi+eiF/gv/LD+WVFLuCnrL6mushdD5L8VlEM
	ArVchiJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPZlO-0000000C9VY-2cgt;
	Thu, 12 Jun 2025 04:42:06 +0000
Date: Wed, 11 Jun 2025 21:42:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, miklos@szeredi.hu,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: Re: [PATCH v1 2/8] iomap: add IOMAP_IN_MEM iomap type
Message-ID: <aEpans4ltog7lU2Z@infradead.org>
References: <aEZm-tocHd4ITwvr@infradead.org>
 <CAJnrk1Z-ubwmkpnC79OEWAdgumAS7PDtmGaecr8Fopwt0nW-aw@mail.gmail.com>
 <aEeo7TbyczIILjml@infradead.org>
 <aEgyu86jWSz0Gpia@infradead.org>
 <CAJnrk1b6eB71BmE_aOS77O-=77L_r5pim6GZYg45tUQnWChHUg@mail.gmail.com>
 <aEkARG3yyWSYcOu6@infradead.org>
 <CAJnrk1b8edbe8svuZXLtvWBnsNhY14hBCXhoqNXdHM6=df6YAg@mail.gmail.com>
 <CAJnrk1au_grkFx=GT-DmbqFE4FmXhyG1qOr0moXXpg8BuBdp1A@mail.gmail.com>
 <20250611185039.GI6179@frogsfrogsfrogs>
 <CAJnrk1YcMvDZ6=xyyJcZ_LcAPu_vrU-mRND4+dpTLb++RUy9bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1YcMvDZ6=xyyJcZ_LcAPu_vrU-mRND4+dpTLb++RUy9bw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 04:08:42PM -0700, Joanne Koong wrote:
> Awesome, thanks for verifying
> 
> I'll submit v2 rebased on top of the linux tree (if fuse is still
> behind mainline) after Christoph sends out his patch

Where my patch is trying to come up with a good idea for the
read-modify-write in write_begin?  Still thinking hard about this,
so maybe just resend with your current approach for now.

