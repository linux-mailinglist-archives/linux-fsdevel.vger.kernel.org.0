Return-Path: <linux-fsdevel+bounces-36733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3E59E8C6C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 08:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB98418863B6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 07:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCD721505D;
	Mon,  9 Dec 2024 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kgXc4nCZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DFC215046
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730122; cv=none; b=qzYs0q4qQDpgsbr03t6ew87qbqtBPJifdW/GC659u554XT1I8ec41wIwFS+jrqDP5affozlVj9mPueo5Rae2Vb9kvZ51F9UpOtVvJbXwcgud/vOzncsOnwzg2P/2ptrEQ65fMOxXmmt/CRp6rgN0mqGaDKuw53KUfxOOtVfZspI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730122; c=relaxed/simple;
	bh=hx3BhPJ4U1TtscFU+6yPo9/8AH9GSFLEiIgcOcP/22Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7EMFkaZGY7p8spa6ClErFLYL5H68gjkEmeNDOI5ma7u8+XInZhQQ/4broeErFaKa5k34VpWM95Dp3Id33hsfns6OP5r9i52qc7qI1/jD4ZFHfyGOWx3L4BiewoT63IVC8RaA3ohOjQXt2M2OPbblCD8TglvMuqRFJx4dodfcnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kgXc4nCZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5Rs1try2G9iifMPQmjSzmZru1XPwcH+0c/Rv02cvaV0=; b=kgXc4nCZwApy4aTjx385C/zGy2
	CTJKMGmra8CsNw4x98+GqBPQ1+zH4tvZttpOYPKJrpIE5d8zxFVZhQkExAo/CFsZpi69RwGO9ECP9
	MS58hgxcTNwpcsth1Zi6edlJOUfbLZkjc+MYb3fVGSnXrdRfHhqv+l9ePG69N1CoTzOB/foOJy/4I
	fD3aVbT3Ts+2CeapV8bgx3wkao9qg567zqpt2W2AsU20uPEGMwZpAUdxOj7HjIiq+4fMDxDDuGtQO
	gig/RdSgDS/Egm7Z3sm8vvoR9MbN0nSUB+Tcyz+5Cu28gq+zbfhefov67LEtWL0tX5TSvskHFoYgr
	RsyU1wMw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKYP0-00000006Tyz-0RRT;
	Mon, 09 Dec 2024 07:41:58 +0000
Date: Mon, 9 Dec 2024 07:41:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
Message-ID: <20241209074158.GX3387508@ZenIV>
References: <20241209035251.GV3387508@ZenIV>
 <gopibqjep5lcxs2zdwdenw4ynd4dd5jyhok7cpxdinu6h6c53n@zalbyoznwzfb>
 <20241209065859.GW3387508@ZenIV>
 <CAGudoHHAxDpQb9TVTPuBc-NnJkuu3hJJ8iB2Z5QRdSCPiVDLRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHHAxDpQb9TVTPuBc-NnJkuu3hJJ8iB2Z5QRdSCPiVDLRA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 09, 2024 at 08:18:35AM +0100, Mateusz Guzik wrote:

> I'm not caught up on the lists, I presume this came up with grabbing
> the name on execve?

Not at all.  fexecve() nonsense can use either variant (or go fuck itself,
for all I care) - it's not worth optimizing for.

No, the problem is in the things like ceph_mdsc_build_path()...

