Return-Path: <linux-fsdevel+bounces-71794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AF2CD2B41
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 09:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40A803011EF1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 08:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B2D2F99A8;
	Sat, 20 Dec 2025 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GYm4pBjg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7910B2F744F;
	Sat, 20 Dec 2025 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766221067; cv=none; b=Bis3waV9Z8JJ1TFSqkLAj1YD2lcMkfMW9c3ma2SDPHkFejOaTPuEI8NjAdm4OgOTs4xJKWbMYlss4rGN27wgGY0qy3QHDwltAlfF249fij0VM20r7kbR6aTyOxdg5J9z12mqvhe7Sa6JHYEXAcid8XWuICcX8o41iNLAmBebmzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766221067; c=relaxed/simple;
	bh=uCk4SUN+LmLa7f0O4j5etZ9Z8BFI65YaN0nn28+rFL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W016kueDvQ2rX1mk3pw4wQm8zyoyD09ECFDXZd9WNJlsGf1EYjiPtxcTY+aZ53A7UhpvXEc7RXxs5isTc0B+XobhcmCLFKE08g06j5k/VhtS5gvYLw3YCujiETOhgXavqj7FtA7nqu6/ItWMx75oC7WwBTurTLYhp3QkjGKYjHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GYm4pBjg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q8PqCZ/cuo8Pu0LF/R0nWY2/0wveVOnYRL5w5cbf/ds=; b=GYm4pBjgKWhQcjO+dY8d66zyLE
	aI7v2pn57Wx+vreWE6x8v0LVLPk36AD0Zc0JkflTbSLmrpRlL1wZh/RXrlygvABkpwk7m3BvasDQ4
	3v8cXE6jaPcWtTNBQ7m4EeqPj5TAJMFDDyGODKaXIy5yy1SKaq6c9tk9PGT2uU+Pp7/OnMbSPc1rt
	zJHSnmueYciLFJfmrToVQ8vTuQK0LWtaLDe4fZ+XuSE+9RWqKEYWxWA/usFtMluFpSifODT+WsidX
	+gAPMHx0fE4I8iLp8XUcr1o1zmfw9pGfiTD211s6XAPTDMuIrgagQksdzQpdVlYT/2uhbpPlwg4UE
	bNOaXDaw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vWsnC-00000001nm2-1YFl;
	Sat, 20 Dec 2025 08:58:26 +0000
Date: Sat, 20 Dec 2025 08:58:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, clm@meta.com
Subject: Re: [PATCH v3] fs: make sure to fail try_to_unlazy() and
 try_to_unlazy() for LOOKUP_CACHED
Message-ID: <20251220085826.GB1712166@ZenIV>
References: <20251220054023.142134-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220054023.142134-1-mjguzik@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Dec 20, 2025 at 06:40:22AM +0100, Mateusz Guzik wrote:
> Otherwise the slowpath can be taken by the caller, defeating the flag.
> 
> This regressed after calls to legitimize_links() started being
> conditionally elided and stems from the routine always failing
> after seeing the flag, regardless if there were any links.
> 
> In order to address both the bug and the weird semantics make it illegal
> to call legitimize_links() with LOOKUP_CACHED and handle the problem at
> the two callsites.

I still don't get what's weird about the semantics involved, but
the only question I've got is the location of this VFS_BUG_ON().
A way to ensure that we don't forget to check LOOKUP_CACHED early,
in both (seriously similar) callers?

Anyway, it does fix the regression.

