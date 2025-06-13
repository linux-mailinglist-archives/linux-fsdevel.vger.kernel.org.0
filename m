Return-Path: <linux-fsdevel+bounces-51544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB364AD8154
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 05:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511B63B6944
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 03:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C66242D63;
	Fri, 13 Jun 2025 03:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OxsZzx0Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314AC18DB1A;
	Fri, 13 Jun 2025 03:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749783861; cv=none; b=MFZ8EioWoz4Rm05bWR9Zd+2HTcZze8hduXjNuz0FhwAqb14Slwte7QjtcXWZ0N8DY2JzPAXpfgiVWeG0e52U4cvnRjfefVXj/VEwwBN8sgVNhuxHxcAm+TyNDV2cvud3DCTIg2RmAkXMMey85JiktARSN32GuDn0uefjRi0j4vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749783861; c=relaxed/simple;
	bh=b+WBJALyCdn7uQ8UwOQm1wki4o//U+MZ1hPIT/kf9vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqrGfHSM43ZmU/oQxLQg0rcGwhgVTr2fmgt9fL1Qglj2Mdzb9wp+iiWLraHlPY89aRrwd8cljnfH0Il5RG0xVBaaTjFeASzu2MOFAS+ojzPozaMgF7qBol9/cYX3xEioqafU5q0E4JDtvig9eWj6TkIJAHk5yfP5GP0hhN+hyuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OxsZzx0Q; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mHaNPjVdIOAREGXcLUPdHns4K44mWe2ogcbuFk3vZW8=; b=OxsZzx0Qi3rgpFqe1HZKxC/CCn
	0OJDj5lSoBFLbNUt1ObrTrojco0zVvooEK/h0pVEtn7SnRu9pWZZgU6EL+YpoCxGDs9AT/kjqRKK7
	yZjorjvsuupZASMWebuz2d3siRgsEAzEHlGT8b9ldiWAKKH+TMMS/Jn3TNIb90HuA/EnCPyj4ehn0
	9QRhy5RsBPy3UB+fnIjdJqYq3k/rFqevPuDlhbkdig/eRCzfly9NhQCcJwPMzZDBpQtjobkc6FvSu
	BFY/LkRY/Wy1/nCHC5fpY8XYFK+GUhch4pp9MRmnxA4t8JMmChYxo9DMAeaI86YbZYdfGdE83Rfbc
	QYzhXJ8w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPuiH-00000005HyZ-1TNk;
	Fri, 13 Jun 2025 03:04:17 +0000
Date: Fri, 13 Jun 2025 04:04:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc_sysctl: remove RCU annotations for accessing
 ->sysctl
Message-ID: <20250613030417.GG1647736@ZenIV>
References: <174978315268.608730.1330012617868311392@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174978315268.608730.1330012617868311392@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 13, 2025 at 12:52:32PM +1000, NeilBrown wrote:
> 
> The ->sysctl field of a procfs inode is only set when the inode is
> created, and when it is being evicted.  In both these cases there cannot
> be concurrent accesses and so using RCU_INIT_POINTER() and
> rcu_dereference() is misleading.

Wait a minute.  Why can't there be concurrent accesses?  ->evict_inode()
is *before* RCU delay, not after it.

Sure, you can't hit it from d_alloc_parallel(), but you very much can
in normal dcache lookup...

