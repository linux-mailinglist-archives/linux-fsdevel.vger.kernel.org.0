Return-Path: <linux-fsdevel+bounces-35109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4729D14DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 16:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C28FB2BC6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856411BC077;
	Mon, 18 Nov 2024 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YwGR+Ap4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5A1AE01D;
	Mon, 18 Nov 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944664; cv=none; b=HFFUeghJI0fy9mFyDAIoNqKpXIQ0dcTRpv7JWhB0mhtl2f18f3G+JvCwYB2hh831M3NThBBDecRBPG4yJ8vJPH1OcrfPbL5JOrVX+fA9zWyKv9eBc4nXGO6+mEL+NTIdR23PD8CmxwaGphGhjeNRw9QefRKs0xYBSiJ+ll/eaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944664; c=relaxed/simple;
	bh=1S4kc4XaVfOflWXcjf8x0Za3BP+BFQ/ELMboQd8SWlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZSQcXkDdjF8cJLN4uzoosvyy6wiUmB6dejEV4DvzIr2WNM+y8nbV1ArfpMXveLaP6FClGcG/Q8w0PfaUhUeOEtN9mYpSNotBg00+eTUWlHhrLV0BmXItthFNkz6A/7vtmvee13nY2akA9n7QMQ0wguI0xl/rg8hu1+N0FIwGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YwGR+Ap4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U4YplOiZXPPZzPsqHuvWsfd3v86LFROZH/s6gwRNhlk=; b=YwGR+Ap41VqK4Cym6epNZe/X7h
	fj2/Qm0QkK7vvVuE0fRLDNKSvm1JZfU8SXfhb/+kQJjvPeAgMtRJA9Ws6jcuduvW+KDZszAktYDUL
	uUCgOiQplQU4y+ijQwQYPxseMIACNqgr1mIlsI+CTTO9w8594Jjz0KQohzt0uch9o+wjQrfrVy8Sq
	rhdJvNmYElDJnzjfFQkRwFkQIDHXIXy4L9iehy2dEP0/vJcs18DDtxVrTUgMwRSCkEWBz4NIj0d9o
	neHZ4w30kjfrCuGSIUd/X2ZWhNPTxvO92aa3n0TCx6LTBQbmXGNl+NHS3CSMycI67IgBVtYkbfymh
	XRPISbRQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tD3vG-0000000GQWu-3ewp;
	Mon, 18 Nov 2024 15:44:18 +0000
Date: Mon, 18 Nov 2024 15:44:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: dodge strlen() in vfs_readlink() when ->i_link
 is populated
Message-ID: <20241118154418.GH3387508@ZenIV>
References: <20241118085357.494178-1-mjguzik@gmail.com>
 <20241118115359.mzzx3avongvfqaha@quack3>
 <CAGudoHHezVS1Z00N1EvC-QC5Z_R7pAbJw+B0Z1rijEN_OdFO1g@mail.gmail.com>
 <20241118144104.wjoxtdumjr4xaxcv@quack3>
 <CAGudoHECQkQQrcHuWkP2badRP6eXequEiBD2=VTcMfd_Tfj+rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHECQkQQrcHuWkP2badRP6eXequEiBD2=VTcMfd_Tfj+rA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 18, 2024 at 03:51:34PM +0100, Mateusz Guzik wrote:

> This is only 1.5% because of other weird slowdowns which don't need to
> be there, notably putname using atomics. If the other crap was already
> fixed it would be closer to 5%.

Describe your plans re putname(), please.  Because we are pretty much
certain to step on each other's toes here in the coming cycle.

