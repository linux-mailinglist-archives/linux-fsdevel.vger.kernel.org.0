Return-Path: <linux-fsdevel+bounces-16818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527598A32C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 17:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B551F2337B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 15:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6770148823;
	Fri, 12 Apr 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fBcd5A1G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0286147C90
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936656; cv=none; b=C4N3b0U+diqSfUqfy86gMu7M+brodPlGN7C0PF8NvrnkuBhxf+dNtOEmJHqIDde9TkUrfCqgYETG39fUwrT9I4d0x9+G3RnQQBpIasi1SDDlWDBmtw2hoIJQ6rMRzBzev41gdbfOmGY6xvV+ZeH5QtoGaWBG0QDRIPgLiT/o/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936656; c=relaxed/simple;
	bh=eyKgQBpnmdVjpqa3281J5u2QDz7Bvs3RTzDI2S5yZQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICZrlLdAWhRRMIA45hEPTQqqOpGrBwErYwhfuFnaFZBoQEswRahuc20oEcb4VnUjm5E6VdFjjrWnEaREznkb+cpst3AccEAmlEyoKWrbIrdrDb/SvL2DNMZWxXNCX4FHlkhEn6jmpAsaC6eI+kGxNtYQwmYZf/reBpT1RuVuC20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fBcd5A1G; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43CFhg9b021405
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 11:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1712936626; bh=hNR9hJ5imm7pvcdn12hJQLsjPCdfcIBeTF5ThDzB0+I=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=fBcd5A1Gip2tvL3Hz8hd/OCcm4kh0QbVReEEeSxMB6gN7sXjwlbNkLLOsJICUoTjf
	 n78kpNa42Efu5x5posRsHr3q3XsjA7UJBxmtGbm98Hm17gLYmVo6FmWcfWZOnz/9Vg
	 n8oLYZ5FC0jaFQy8+ve4Vx0ua+k08ctd5jwXwCeVVzJWter0l+8FW9e+C8Td99ZpGi
	 wGM0TpyYXT3dFiJ9NXgSemr/U+cfBA/t2GJ5Fy5+MC/AnlpxdZvRb0auFAL550oGec
	 hFuGDfTviPwo/nUQnGw3aIiBxP2X6xP2R3NIe1GomQi+qSRtPmDfKRMScryidg4KAu
	 iVCG5vGDFz0ww==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4A4FD15C00DE; Fri, 12 Apr 2024 11:43:42 -0400 (EDT)
Date: Fri, 12 Apr 2024 11:43:42 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        Conor Dooley <conor@kernel.org>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <20240412154342.GA1310856@mit.edu>
References: <878r1ibpdn.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878r1ibpdn.fsf@all.your.base.are.belong.to.us>

On Fri, Apr 12, 2024 at 04:57:08PM +0200, Björn Töpel wrote:
> Hi!
> 
> I've been looking at an EXT4 splat on riscv32, that LKFT found [1]:

I'm getting a "page not found" for [1]?

> This was not present in 6.7. Bisection wasn't really helpful (to me at
> least); I got it down to commit c604110e662a ("Merge tag 'vfs-6.8.misc'
> of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs"), and when I
> revert the commits in the vfs merge the splat went away, but I *really*
> struggle to see how those are related...

It sounds like you have a reliable repro; is it something that can be
streamlined into a simple test program?  If so, is it something that
can be reproduced on other architectures?  And could you make it
available?

Thanks,

					- Ted

