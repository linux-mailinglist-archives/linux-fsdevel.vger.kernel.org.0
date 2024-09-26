Return-Path: <linux-fsdevel+bounces-30207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C65A987B5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 00:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D061F24DB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 22:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD6B1B1425;
	Thu, 26 Sep 2024 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WPyjguf2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043741B0121;
	Thu, 26 Sep 2024 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727391136; cv=none; b=rE6ycJKLavyQhfbi/GJLrygoV6mN+QExlNIwc3vA1RREWwGWiD6++zGtGjIbgGXlxN52m7fi74hXpqNnY5a9sr/xn0+d0VPdX1vGhPyeDiSDoARsLfJStgUyw///lqFhjiEH8Q5r200FtgHcTdzJWmZZiyfZSpEH3siIIE57mDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727391136; c=relaxed/simple;
	bh=VCbTnMiHNm4Flj+gMSQ+nEElI5SKsV17XjU0Pr5hnc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKFDG8Z+yDLJV4NEmM4MByDKVcwEU6q0noO8PWMGtRxQzOsoV/K5+7NRkZhVDvSEEAD1BFUFwP0SXkBxB3l8zSmaxnJHJ+UM7qfplFqS4/qsTd11sQBJm90mDOSBN1dt/Cxu2uOvLvgHe7GbHVVqcAQyXx9l8B78IOAjg6eKHrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WPyjguf2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VCbTnMiHNm4Flj+gMSQ+nEElI5SKsV17XjU0Pr5hnc8=; b=WPyjguf29TLlRFcuPyz+N+lH6D
	5P7JVsxD9o+lqyujLxsSZY7GQcTDjVCF/u9pw2jyR76ksyW8VYFjfr4Wpd6s0ecJJn/1tMXXeG4iH
	toMaVHupLvBruDKrw3ERPRPj95xmcZMuwR5QaRiIwizC8pGXAlfxsab0SlCK3Sk3ldg7vBw6jxjI0
	PbAylvG67oVk2XvPydDTV4OV4wvis3Uh59qtnutFPxyeHmZA3iGWFg0pNNslXRQmRawtmvhl9MrnB
	HW3m8uSQUsFerJ3rS9Q0kA2s40BRNEpVYKYWj0Amihs/H+lmpY+BiB5bOjcH/Tzmc97S77g3FPXQ4
	rgVmXTxA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1stxLE-0000000Fo3y-0nFg;
	Thu, 26 Sep 2024 22:52:08 +0000
Date: Thu, 26 Sep 2024 23:52:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: file: add f_pos and set_f_pos
Message-ID: <20240926225208.GR3550746@ZenIV>
References: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
 <20240926-b4-miscdevice-v1-2-7349c2b2837a@google.com>
 <20240926220821.GP3550746@ZenIV>
 <20240926224733.GQ3550746@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926224733.GQ3550746@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Sep 26, 2024 at 11:47:33PM +0100, Al Viro wrote:
> time ->llseek() should be using one of the safe instances from fs/libfs.c

d'oh... s/libfs.c/read_write.c/ - sorry.

