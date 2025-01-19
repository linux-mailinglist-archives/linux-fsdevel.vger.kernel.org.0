Return-Path: <linux-fsdevel+bounces-39609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA168A16252
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 15:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C919B3A5999
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 14:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6441DF254;
	Sun, 19 Jan 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="OaU0s+tZ";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ISx6lrkq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF3063CB;
	Sun, 19 Jan 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737298627; cv=none; b=R1A4mWz+DJ+MyShPAEpxypiLhC+0yzlOPONA4MuPXNByU1Nyoti2ghWjVqgxSo7Rs5MJ7Jn34EhJ9NTAUvIIlHFIYEdu3P6AX7N4+r+8C16SUF5N4cYDzQOLx6B3d8WZHCOk0MJk+zYVNLZcEeHRPPL+UTnljqSTWIqJlwqpdPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737298627; c=relaxed/simple;
	bh=D+o5VDMb7r2W/iuBbkbTHZGHE6Su8+rzVGxHstMbY54=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HA06ddw/21IL0EGeAzRpJpUJGrRQb6NN9aN0U7wDyeF6hYPPLjCGUccIk14veD07cawUB7Zz5ArDeBoCP3XxTD3c+0pFegt6pQn2kcyXIuarlA23NNOciLiv6d8r7tHTdPYd5tsON1CxO9cdVkgAES5ofhjP/UC+LhKWeufTZjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=OaU0s+tZ; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ISx6lrkq; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737298624;
	bh=D+o5VDMb7r2W/iuBbkbTHZGHE6Su8+rzVGxHstMbY54=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=OaU0s+tZDG1EN0OlTcz73P2pV3cjNJJDuyfwa1yjxyQfmagFCwH6/HPHtc+KSz9/A
	 EVrMV7ph3E+J2SLu8R7qkH64NK4kwuyXecwOzQ7k5ICcGFWDOzx+lD6PocIHtOejkm
	 F2DGwQP2fpTDePoDAFyOjILWhovo6BxtOk3IiQfs=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1CFD8128650C;
	Sun, 19 Jan 2025 09:57:04 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id lOFobDMH3MNb; Sun, 19 Jan 2025 09:57:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737298623;
	bh=D+o5VDMb7r2W/iuBbkbTHZGHE6Su8+rzVGxHstMbY54=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ISx6lrkqwq84srrgaS+TDD7PIieqlbGXKMuZnVa9LGzF3rMqGQ1iRyRV9O4UaEcYR
	 vniqHTpAoX8sjlWLgx+AnRm+4TKLxXh7vAxIHujFQNFk71+b/tPP+AQkIGIlgT5aGg
	 XEUXO7SzLQd6XJG9U21OQGzkIKKbEC/4uQDK8Vk8=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 454E512863BD;
	Sun, 19 Jan 2025 09:57:03 -0500 (EST)
Message-ID: <45d245a9db73f3c41f31626a675d6356704198ef.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 4/6] efivarfs: move freeing of variable entry into
 evict_inode
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>, Christian Brauner
	 <brauner@kernel.org>
Date: Sun, 19 Jan 2025 09:57:00 -0500
In-Reply-To: <CAMj1kXGH4o50xfb_Rv3-gHxq_s2OeSWOpa9CaSf7v5vSrC9eDg@mail.gmail.com>
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
	 <20250107023525.11466-5-James.Bottomley@HansenPartnership.com>
	 <20250116183643.GI1977892@ZenIV>
	 <0b770a342780510f1cd82a506bc67124752b170c.camel@HansenPartnership.com>
	 <ae267db4fe60f564c6aa0400dd2a7eef4fe9db18.camel@HansenPartnership.com>
	 <CAMj1kXGH4o50xfb_Rv3-gHxq_s2OeSWOpa9CaSf7v5vSrC9eDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 2025-01-19 at 15:50 +0100, Ard Biesheuvel wrote:
> On Thu, 16 Jan 2025 at 23:13, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > On Thu, 2025-01-16 at 14:05 -0500, James Bottomley wrote:
> > > On Thu, 2025-01-16 at 18:36 +0000, Al Viro wrote:
> > > > On Mon, Jan 06, 2025 at 06:35:23PM -0800, James Bottomley
> > > > wrote:
> > > > > Make the inodes the default management vehicle for struct
> > > > > efivar_entry, so they are now all freed automatically if the
> > > > > file is removed and on unmount in kill_litter_super(). 
> > > > > Remove the now superfluous iterator to free the entries after
> > > > > kill_litter_super().
> > > > > 
> > > > > Also fixes a bug where some entry freeing was missing causing
> > > > > efivarfs to leak memory.
> > > > 
> > > > Umm...  I'd rather coallocate struct inode and struct
> > > > efivar_entry; that way once you get rid of the list you don't
> > > > need - evict_inode() anymore.
> > > > 
> > > > It's pretty easy - see e.g.
> > > > https://lore.kernel.org/all/20250112080705.141166-1-viro@zeniv.linux.org.uk/
> > > > for recent example of such conversion.
> > > 
> > > OK, I can do that.  Although I think since the number of
> > > variables is usually around 150, it would probably be overkill to
> > > give it its own inode cache allocator.
> > 
> > OK, this is what I've got.  As you can see from the diffstat it's
> > about 10 lines more than the previous; mostly because of the new
> > allocation routine, the fact that the root inode has to be special
> > cased for the list and the guid has to be parsed in efivarfs_create
> > before we have the inode.
> > 
> 
> That looks straight-forward enough.
> 
> Can you send this as a proper patch? Or would you prefer me to squash
> this into the one that is already queued up?

Sure; I've got a slightly different version because after talking with
Al he thinks it's OK still to put a pointer to the efivar_entry in
i_private, which means less disruption.  But there is enough disruption
that the whole of the series needs redoing to avoid conflicts.

> I'm fine with either, but note that I'd still like to target v6.14
> with this.

Great, but I'm afraid the fix for the zero size problem also could do
with being a precursor which is making the timing pretty tight.

Regards,

James


