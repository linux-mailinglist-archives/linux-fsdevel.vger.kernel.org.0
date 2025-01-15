Return-Path: <linux-fsdevel+bounces-39237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 627B1A11AC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 08:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2DE1889F4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 07:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF6E2343B6;
	Wed, 15 Jan 2025 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3VuHiBKY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203F52343BC;
	Wed, 15 Jan 2025 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925347; cv=none; b=clnmHVRRdKUpQioEm1Ae88NJn3swo86KV8wAvN7okwF/bfmc9KF8giq5V5+SklKnsceVvtFTC/ed5IG0CpBbyHh33femDP/D7/xAQsiN+UPfwYJ4jiwGeJhB27DbuA8qtYKYbjnfgXnrXpZoOxm3gsekWJb4ZC2xwzjeqoLgsMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925347; c=relaxed/simple;
	bh=zqSPr0qE5kn9a4I6FJEmoK4VISKtbZHWYDAw0edVehk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWyCNWgKdmF8oJFQkvuc2lB7auvDLsTTQLoQbmGY8YKBcanCTklcDpiPK/f+oGd62hsfLFjec4tU6Ti/9U+80DEbtMKUHOKVxQTxYKRH3sxPPEcOJr5vMCDCO2rE/SvkdFu67CEsKobHdX4EwsQw48zAAnU60izDn+S3ehAzdPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3VuHiBKY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=R4qzS2zYTLs3sOb4/MVR/losKRadCW0XPU16E8aKGz8=; b=3VuHiBKYwG4jxoBye+nNpMHiJn
	RH08bGUM5Iu1Uvp3WLNAOH0X0jAcLB/L6mvIkypMNc9pH1hBDaDft8kpo+1tncS+VBguiWb0izeTj
	9GNrX/accdS918A9CBQidmmQtR9vrBj1vz3BtR09BRmRqX+sUKv7eAx/WSBV6iTnerJ2KIYXIj39S
	75tHmZMew0ua+clDtgbJAcCBfhjhMMpomvqHuI0B97WECK6Pq/Pgz6Byw0ymX91q4h+8+/D8s+Fft
	h3CX+C0iu3+V3m/TgI8+JfdjIMS0ZBhFyNgmFUJyPy+AQoemDEjZ8hsPA9F9ugoqZr0kEYZqbLpXA
	OQlW6eFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXxcs-0000000Auxu-3ycU;
	Wed, 15 Jan 2025 07:15:42 +0000
Date: Tue, 14 Jan 2025 23:15:42 -0800
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Dave Chinner <david@fromorbit.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	syzbot+34b68f850391452207df@syzkaller.appspotmail.com,
	syzbot+360866a59e3c80510a62@syzkaller.appspotmail.com,
	Ubisectech Sirius <bugreport@ubisectech.com>,
	Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v1 1/2] landlock: Handle weird files
Message-ID: <Z4dgnkCOc_LxMqq2@infradead.org>
References: <20250110153918.241810-1-mic@digikod.net>
 <20250110.3421eeaaf069@gnoack.org>
 <20250111.PhoHophoh1zi@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250111.PhoHophoh1zi@digikod.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jan 11, 2025 at 04:38:56PM +0100, Mickaël Salaün wrote:
> I guess it depends on the filesystem implementation.  For instance, XFS
> returns an error if a weird file is detected [1], whereas bcachefs
> ignores it (which is considered a bug, but not fixed yet) [2].

If a filesyste, returns an invalid mode that's a file system bug and
needs to be fixed there.  Warning in a consumer is perfectly fine.
But the right action in that case is indeed not to grant the access.


