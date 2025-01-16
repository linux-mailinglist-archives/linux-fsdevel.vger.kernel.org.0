Return-Path: <linux-fsdevel+bounces-39438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48F7A141F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 20:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1984116A949
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 19:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02B622D4EB;
	Thu, 16 Jan 2025 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UKNMwt04";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UKNMwt04"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00F1547E2;
	Thu, 16 Jan 2025 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737054335; cv=none; b=E7yfndiAY/PoLlp+f62FjQNFHnRXFRFMBGb6oDtOhKA9OE0k1ZU+8zXRfqSnAnvAmErfdkNJk19ABGQaNbERnMdRpeAHQZMcBkVlbHLQGZ6sxLvPVonmhJBUFCxekbmY8FDiPD1+IjCEkEUkoMx/kbKWcATyHKo+GSWL3TX4+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737054335; c=relaxed/simple;
	bh=aMWee4bs85azPLrRwi0ucbG8vhi2MwrOvF57x3qyBZc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qTlc70iq1eWVb6gTZBg8vEoe9+NjjfQSPVrErozAcWZZuSj4eoNPW5UbfnU/KC/65xTj2YH8tX7f8cIHx2EGQqZZTCWoSIXPPek2iOLAnfsOyNalcPJuigmT3wHtLYM4oud5CbHNef+SOdtnI0ZSzzOx5odILWUJvN8WSxcQhok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=UKNMwt04; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=UKNMwt04; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737054333;
	bh=aMWee4bs85azPLrRwi0ucbG8vhi2MwrOvF57x3qyBZc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=UKNMwt04vM3v/DfCiFuQ6gzp2WGAVnfrPeMKQpVV3xR4nHkUqlR9OeSCOlAedYuH4
	 uv5t/1z2/BpVF5gStWCwXVMnn2IOq85mtQN8GDV17Wcj6FgZ5poCc2eCv8wbZ5vnfL
	 EQI0WGyOTpj77PZnM1hQIs5vxIYvl51vveOhIMg0=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4D8A212871E0;
	Thu, 16 Jan 2025 14:05:33 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id VcQnKcZsY97u; Thu, 16 Jan 2025 14:05:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737054333;
	bh=aMWee4bs85azPLrRwi0ucbG8vhi2MwrOvF57x3qyBZc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=UKNMwt04vM3v/DfCiFuQ6gzp2WGAVnfrPeMKQpVV3xR4nHkUqlR9OeSCOlAedYuH4
	 uv5t/1z2/BpVF5gStWCwXVMnn2IOq85mtQN8GDV17Wcj6FgZ5poCc2eCv8wbZ5vnfL
	 EQI0WGyOTpj77PZnM1hQIs5vxIYvl51vveOhIMg0=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 746B712871CC;
	Thu, 16 Jan 2025 14:05:32 -0500 (EST)
Message-ID: <0b770a342780510f1cd82a506bc67124752b170c.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 4/6] efivarfs: move freeing of variable entry into
 evict_inode
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, Ard Biesheuvel
	 <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, Christian Brauner
	 <brauner@kernel.org>
Date: Thu, 16 Jan 2025 14:05:31 -0500
In-Reply-To: <20250116183643.GI1977892@ZenIV>
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
	 <20250107023525.11466-5-James.Bottomley@HansenPartnership.com>
	 <20250116183643.GI1977892@ZenIV>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2025-01-16 at 18:36 +0000, Al Viro wrote:
> On Mon, Jan 06, 2025 at 06:35:23PM -0800, James Bottomley wrote:
> > Make the inodes the default management vehicle for struct
> > efivar_entry, so they are now all freed automatically if the file
> > is removed and on unmount in kill_litter_super().  Remove the now
> > superfluous iterator to free the entries after kill_litter_super().
> > 
> > Also fixes a bug where some entry freeing was missing causing
> > efivarfs to leak memory.
> 
> Umm...  I'd rather coallocate struct inode and struct efivar_entry;
> that way once you get rid of the list you don't need ->evict_inode()
> anymore.
> 
> It's pretty easy - see e.g.
> https://lore.kernel.org/all/20250112080705.141166-1-viro@zeniv.linux.org.uk/
> for recent example of such conversion.

OK, I can do that.  Although I think since the number of variables is
usually around 150, it would probably be overkill to give it its own
inode cache allocator.

Regards,

James


