Return-Path: <linux-fsdevel+bounces-43478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00277A5729F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 21:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4A03B0960
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 20:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D5D1A5B8C;
	Fri,  7 Mar 2025 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="H3C0Pnt5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531007346F
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377673; cv=none; b=QWOfIR5cuk8PF5kOTL3gx+IDUpZ/2qux1WuGYzdcbtG0kIaMGYgbZ5rKYe3IVSSKezXbJFkp6qZOmzIvI+3UPZ1lO2YTpzpk5iZF6SGdXTj0nHa95EC/Kavc+tbdROBH5bUH0arUzfj+y+zKqGxpGfet1FvN6gFP3tHnrkUkkPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377673; c=relaxed/simple;
	bh=wy70i9ppU2FswpMtwaAxlxYsky9O992YjZYuPR/RtY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyMsRdJI5TGymBl7o11iTEZik83YzDej7SyTaOi8d9rHHk61zwGfKbfA+Gf2EBxgb+/0BDfCGJ/IB5krFAr1+ukdkR6l9EUG6tzp82O29pRLtlKlv4nFjrnx6iOopUNCysbqFFluyeeFISP8QA8M9n27q1NdCUPxkGDjzPyhm4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=H3C0Pnt5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wy70i9ppU2FswpMtwaAxlxYsky9O992YjZYuPR/RtY8=; b=H3C0Pnt5hcPgCLnw5Ao9w97Ebn
	tmZqks3STIOoEDcp1DJXQIaVDMp+uT7mWsNiNFgLl+XThBblLzI8wqraKppkzRClg7kDJ0d5kciH7
	woxtS7leM05/EL5web9bdLvKBLKDZ2Vxbv2ObCvIjE+Ch9ag3Le3I1ZNPMYvJPXiVzeL51le2GaA5
	pIGRU8FZpV3LyRi1D9jVgUNrvZrIFhrb5y55jkCTI16WZUfyot4Qn9PRIG7h7cs/dXs2lMM/O+uW+
	sIugdptvspWrVOxO/FtBF9InfZXTXiYHrkyUQH3HggVyZXui+7uLnmegfxqW6w43LnleJ8MJUcZgi
	zvrCmsDA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqdsZ-00000006OdF-1JBY;
	Fri, 07 Mar 2025 20:01:07 +0000
Date: Fri, 7 Mar 2025 20:01:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] vfs: Remove invalidate_inodes()
Message-ID: <20250307200107.GJ2023217@ZenIV>
References: <20250307144318.28120-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307144318.28120-2-jack@suse.cz>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Mar 07, 2025 at 03:43:19PM +0100, Jan Kara wrote:
> The function is exactly the same as evict_inodes() and has only one
> user.

<pedantic>
nearly the same - evict_inodes() skips the inodes with positive
refcount without touching ->i_lock, but they are equivalent (evict_inodes()
repeats the refcount check after having grabbed ->i_lock).
</pedantic>

ACK, except that it might make sense to add a note in D/f/porting.rst -
or just add #defined invalidate_inodes evict_inodes for this cycle
and remove it (with obvious note in D/f/porting.rst) in the next one.

