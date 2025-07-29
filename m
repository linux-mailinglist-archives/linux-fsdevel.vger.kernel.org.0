Return-Path: <linux-fsdevel+bounces-56232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E209B14960
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 09:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546041892B6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 07:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD1916F8E5;
	Tue, 29 Jul 2025 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4ynd7AoZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9F82676E9;
	Tue, 29 Jul 2025 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775374; cv=none; b=PLs5G8vXOjvg8B7IaKmAVQg3nlmvgKrpKPdS9/v3Zj4BMPCIengplSt0ZX3DIfh+OcbU8sGCOL9MwMggdgxcsi9qqZORGarYTHrgYdWl8jrIoq4Us4wG9eCQw7NC43tAYWRMBXim3CmpXUFE9I/eBbaTL+kcMJ1E+lqS39PWiDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775374; c=relaxed/simple;
	bh=8MopCd+/1CVSX7O9y88Cy1c3eogeYBhKqoqibKK0H6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yskwh7d2lgYFotFdw6jnOVO3RVLseLsfzQMS/kIbkUgMY0ffCX27awl5yB9FTOPawots3EvcAQZ9HNuCArkpi26HHtFG85s2Poip0OXu6KwU/RDrXazD09aaVu9jkA8+7AyU/c8s1lXhkC6F4ecLzc70iE55Gp60fXFHayazjbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4ynd7AoZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=64I4+SRz8Jb242tJ39NgDchbi8xfo9+9jvViHgrhKzo=; b=4ynd7AoZtY+/opRC/c2n7tkFdn
	x8aqXftqXV6cwXql0bIFJKTMVYgtL0AnTdsoAeELy5Jd7Gtm+FnSqsiPHLpNVcGOyLoT3C/Fh+4bC
	Cq9BBzn8Pfs+NI5xBxIqApgjT93BKpiGqSseLCKqlLKGBAPiyVuL5Sf7TkXbidmWxyFLELEZE2FmU
	SMZNpt8TYlgD7SynMQnRICjrEEn+K7xifuCJwe5Ixs5H0NkzQfnYaJ9b0u/AgDnVB2+LIzSFvG6wN
	mK4sI8qPvnFnjSbYEvK1drgYKAKqo86Ty1T2+CS6UUvmrQFKT4jIfCWk6kU1l3NW5WHtQ1xpIdHIZ
	b4XaDFew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugf5V-0000000GAWk-3BjG;
	Tue, 29 Jul 2025 07:49:29 +0000
Date: Tue, 29 Jul 2025 00:49:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>, Christian Brauner <brauner@kernel.org>,
	Klara Modin <klarasmodin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 11/14 for v6.17] vfs integrity
Message-ID: <aIh9CSzK6Dl1mAfb@infradead.org>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
 <20250725-vfs-integrity-d16cb92bb424@brauner>
 <0f40571c-11a2-50f0-1eba-78ab9d52e455@google.com>
 <CAHk-=wg2-ShOw7JO2XJ6_SKg5Q0AWYBtxkVzq6oPnodhF9w4=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg2-ShOw7JO2XJ6_SKg5Q0AWYBtxkVzq6oPnodhF9w4=A@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 28, 2025 at 03:21:21PM -0700, Linus Torvalds wrote:
> Bah. I *hate* this "call blk_get_meta_cap() first" approach. There is
> absolutely *NO* way it is valid for that strange specialized ioctl to
> override any proper traditional ioctl numbers, so calling that code
> first and relying on magic error numbers is simply not acceptable.
> 
> I'm going to fix this in my merge by just putting the call to
> blk_get_meta_cap() inside the "default:" case for *after* the other
> ioctl numbers have been checked.
> 
> Please don't introduce new "magic error number" logic in the ioctl
> path. The fact that the traditional case of "I don't support this" is
> ENOTTY should damn well tell everybody that we have about SIX DECADES
> of problems in this area. Don't repeat that mistake.
> 
> And don't let new random unimportant ioctls *EVER* override the normal
> default ones.

I don't think overrides are intentional here.  The problem is that
Christian asked for the flexible size growing decoding here, which
makes it impossible to use the simple and proven ioctl dispatch by
just using another case statement in the switch.


