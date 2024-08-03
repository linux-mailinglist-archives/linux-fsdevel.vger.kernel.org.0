Return-Path: <linux-fsdevel+bounces-24929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0082A946B6B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 01:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E711CB216FD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 23:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96765589C;
	Sat,  3 Aug 2024 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cc7K+iiN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DC014A84
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Aug 2024 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722726388; cv=none; b=O0NeGxSdzYdKyRZFpZWYk9XLrRK8a0uLH7T/SI+IPX6G+Cks+RPfws/mkGKl8LnTk+/3/XKpD0plPxSpY8Js7tXNkYTFezrc3iJsdlpax6xZX1v+MBvGUjaY7K02zQNdXsUwtb7rI50XKWltpSC9vlPtrLp3f1swBKnEKfQAwK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722726388; c=relaxed/simple;
	bh=qjxghHYxV9h92nOe/e7bwtEJEAqvD3sb1CzNkSuxH2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apO1vPHiuBXqVRIPne6L7BBzZVYc/zFOTtz1muUAeNmLNw5yBMhuoG2MJiYibJgvcFGO6J/waUIWCRNM2JkZAzTWTAAEBpz8PRK1Lb1j23qLwXezE9AdRJxajrn6HiStWuG/4Wvtx1bn7S70i3PtChiVdJdMo78QOTU62g5PFVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cc7K+iiN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qjxghHYxV9h92nOe/e7bwtEJEAqvD3sb1CzNkSuxH2U=; b=cc7K+iiNOgJORQnFyKjaThzg/7
	kquQqFuC8sDZJF+qc4SvOswntGjiZawc/8pcj/60O7QWQfyWd//CHBPLeZRx7mM8PO3ntWlkyG076
	UdwgrPBPwJdMnIJzCgvRPmSSqP4IF57trCDc2C3xNGW2KYXEP26dQA9Yt7gsvorZV66PKoZp0phlD
	yU2nr2B2IAOvIizdHDnu88sGx/Om8u/BeYBrUJIqK8/03mVA2b2UDV/y6+1haA17boHeS55UMCuVs
	uk4U8GkJYrchGYJxW0UINZaM4cKBLA+rg566PgqOBSD3QA7H/tSJMnOfRfNyWS1fEypcE4ib1JHGq
	ZrH7iJWw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1saNpP-00000001QMa-2ELw;
	Sat, 03 Aug 2024 23:06:23 +0000
Date: Sun, 4 Aug 2024 00:06:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix bitmap corruption on close_range() with
 CLOSE_RANGE_UNSHARE
Message-ID: <20240803230623.GZ5334@ZenIV>
References: <20240803225054.GY5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803225054.GY5334@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Aug 03, 2024 at 11:50:54PM +0100, Al Viro wrote:

> The best way to fix that is in dup_fd() - there we both can easily check
> whether we might need to fix anything up and see which word needs the
> upper bits cleared.

PS: we could try and handle that in copy_fd_bitmaps() instead, but there
it's harder to tell whether we need to bother in the first place, so that
add overhead on a fairly hot paths.

