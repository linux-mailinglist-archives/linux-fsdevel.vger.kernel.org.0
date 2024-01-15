Return-Path: <linux-fsdevel+bounces-8009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6857B82E285
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 23:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F28C283AE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 22:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FA11B7E5;
	Mon, 15 Jan 2024 22:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CtGckjyW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06A11B7E0
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QiGKtmgcE8jzkuRaruVyoA8kGC+xawHe1zvf8F3VIFE=; b=CtGckjyWPR83vmNWxm+0loi4/N
	vEPZDV4dRdG5ullRCAKvExs8coIprvxH7yWnm7EXHw6V4MOoZXn6dpNvv4D2ySeWOj+RcjA0zYESK
	BRKkS4RRqMrJDzpTSAclNa3KqVFeCxOkf7PU+CwiMOhsHaBC/rrbaSOl4LFqtYrx8Ml7i7iHj7IqI
	qhXUA8JM4HCKQCnNxtXpvrbTMwC56SoCaRWaxjFn+SwlFOxbIAhqCqegbHOFuDt+AXFHz2b2zJeMs
	Fc55WIe63Xi+aIf4i7CB+Y3ShlabidzmlBG9d8CLccHks9fXTwlauHQwseAbBr97YnsF8NoTFS2FC
	T7hMmVPw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rPVLY-003Vrs-2M;
	Mon, 15 Jan 2024 22:22:20 +0000
Date: Mon, 15 Jan 2024 22:22:20 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Bruno Haible <bruno@clisp.org>
Cc: Evgeniy Dushistov <dushistov@mail.ru>, linux-fsdevel@vger.kernel.org
Subject: Re: ufs filesystem cannot mount NetBSD/arm64 partition
Message-ID: <20240115222220.GH1674809@ZenIV>
References: <4014963.3daJWjYHZt@nimes>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4014963.3daJWjYHZt@nimes>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 15, 2024 at 11:05:51PM +0100, Bruno Haible wrote:

> Whereas this partition can be mounted fine on FreeBSD, NetBSD, OpenBSD.
> FreeBSD 11:
> # mount -r -t ufs /dev/ada1s2 /mnt
> NetBSD 9.3:
> # mount -r -t ffs /dev/wd1a /mnt
> OpenBSD 7.4:
> # mount -r -t ffs /dev/wd1j /mnt
> 
> The source code line which emits the
>   ufs: ufs_fill_super(): fragment size 8192 is too large
> error is obviously linux/fs/ufs/super.c:1083.

Lovely...  Does it really have 8Kb fragments?  That would be painful
to deal with - a plenty of places in there assume that fragment fits
into a page...

