Return-Path: <linux-fsdevel+bounces-45329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5E1A7645E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 12:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01CC1888611
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 10:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF771DC991;
	Mon, 31 Mar 2025 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pk9Jo+/N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bXPiNm7D";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pk9Jo+/N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bXPiNm7D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1921DA63D
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743417391; cv=none; b=uG3LSpKnbMZXCVwJJmOUs7TYpiM5N9zSsG/VxCtKumq+tSPQM3WEoPbE8w1V/pVavkZgNs9GOkSIMb22+bgrshwWBnCkKnt4VcuQe3wvfTxz/XGMifYu917mDW2V243JpBBP6wY8DeOQecG4MbCVWOCkfFMxrOzLa6JKbDKooCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743417391; c=relaxed/simple;
	bh=MvclKlUTFAY2FRea5IcuFEmeUu/GIV9SC4vZNOpZiZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E369iavW/Hknr5rWe/xridUdT9vm81Tp5p3d4mFTrzTlSpV0jDXSPI0Joj2dq8EtdcsxSYNO2GiZ9QJuhnyk7XzDpoVr2RDVESaYP2UiM9Ptvaql4tZL1eXmfxp6ZZU5Tss9Y7vnsQ/N6ZEAJdJSHOahlzHri694Xa5QV1XIo+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pk9Jo+/N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bXPiNm7D; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pk9Jo+/N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bXPiNm7D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BC06211A2;
	Mon, 31 Mar 2025 10:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743417388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOj7oLxaDIqqbWHUgl23Hbu3E43+z5o//2XDbqo/H0s=;
	b=pk9Jo+/N3wJeeofKXProk21N2+7+VlWynaNGX09XZgcPvoy1cvWFqyadednKwZy2deBh7N
	6ctf1kHeU0Df3/h8YXDGWyEs49ChSOf7THrsLHSHovSQfu9J5RZTJNP/n9lX2Gbr62m9Aj
	ZRniE+riKLQJe2kocC1LlVInSBp1be8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743417388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOj7oLxaDIqqbWHUgl23Hbu3E43+z5o//2XDbqo/H0s=;
	b=bXPiNm7DdgaFQyjj+XLAy9zSH3CTAyUFqsDxflIZDv1jfYIR4NP3gco21vSHwMb1ZdHkkB
	467kDO1Uem6xYIBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743417388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOj7oLxaDIqqbWHUgl23Hbu3E43+z5o//2XDbqo/H0s=;
	b=pk9Jo+/N3wJeeofKXProk21N2+7+VlWynaNGX09XZgcPvoy1cvWFqyadednKwZy2deBh7N
	6ctf1kHeU0Df3/h8YXDGWyEs49ChSOf7THrsLHSHovSQfu9J5RZTJNP/n9lX2Gbr62m9Aj
	ZRniE+riKLQJe2kocC1LlVInSBp1be8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743417388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOj7oLxaDIqqbWHUgl23Hbu3E43+z5o//2XDbqo/H0s=;
	b=bXPiNm7DdgaFQyjj+XLAy9zSH3CTAyUFqsDxflIZDv1jfYIR4NP3gco21vSHwMb1ZdHkkB
	467kDO1Uem6xYIBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 573BE139A1;
	Mon, 31 Mar 2025 10:36:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id At/9FCxw6me4ZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Mar 2025 10:36:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D9D89A08D2; Mon, 31 Mar 2025 12:36:27 +0200 (CEST)
Date: Mon, 31 Mar 2025 12:36:27 +0200
From: Jan Kara <jack@suse.cz>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, linux-kernel@vger.kernel.org, mcgrof@kernel.org, 
	hch@infradead.org, david@fromorbit.com, rafael@kernel.org, djwong@kernel.org, 
	pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, 
	boqun.feng@gmail.com
Subject: Re: [PATCH v2 0/6] Extend freeze support to suspend and hibernate
Message-ID: <7clcr53mw5bdd6lfocn6gw7nykqnqxknlaxaagwrb6hmxpyvmo@dxfk3jachnas>
References: <20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org>
 <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
 <12ce8c18f4e16b1de591cbdfb8f6e7844e42807b.camel@HansenPartnership.com>
 <9c0a24cd8b03539fd6b8ecd5a186a5cf98b5d526.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c0a24cd8b03539fd6b8ecd5a186a5cf98b5d526.camel@HansenPartnership.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,suse.cz,infradead.org,fromorbit.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Sat 29-03-25 13:02:32, James Bottomley wrote:
> On Sat, 2025-03-29 at 10:04 -0400, James Bottomley wrote:
> > On Sat, 2025-03-29 at 09:42 +0100, Christian Brauner wrote:
> > > Add the necessary infrastructure changes to support freezing for
> > > suspend and hibernate.
> > > 
> > > Just got back from LSFMM. So still jetlagged and likelihood of bugs
> > > increased. This should all that's needed to wire up power.
> > > 
> > > This will be in vfs-6.16.super shortly.
> > > 
> > > ---
> > > Changes in v2:
> > > - Don't grab reference in the iterator make that a requirement for
> > > the callers that need custom behavior.
> > > - Link to v1:
> > > https://lore.kernel.org/r/20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org
> > 
> > Given I've been a bit quiet on this, I thought I'd better explain
> > what's going on: I do have these built, but I made the mistake of
> > doing a dist-upgrade on my testing VM master image and it pulled in a
> > version of systemd (257.4-3) that has a broken hibernate.  Since I
> > upgraded in place I don't have the old image so I'm spending my time
> > currently debugging systemd ... normal service will hopefully resume
> > shortly.
> 
> I found the systemd bug
> 
> https://github.com/systemd/systemd/issues/36888
> 
> And hacked around it, so I can confirm a simple hibernate/resume works
> provided the sd_start_write() patches are applied (and the hooks are
> plumbed in to pm).
> 
> There is an oddity: the systemd-journald process that would usually
> hang hibernate in D wait goes into R but seems to be hung and can't be
> killed by the watchdog even with a -9.  It's stack trace says it's
> still stuck in sb_start_write:
> 
> [<0>] percpu_rwsem_wait.constprop.10+0xd1/0x140
> [<0>] ext4_page_mkwrite+0x3c1/0x560 [ext4]
> [<0>] do_page_mkwrite+0x38/0xa0
> [<0>] do_wp_page+0xd5/0xba0
> [<0>] __handle_mm_fault+0xa29/0xca0
> [<0>] handle_mm_fault+0x16a/0x2d0
> [<0>] do_user_addr_fault+0x3ab/0x810
> [<0>] exc_page_fault+0x68/0x150
> [<0>] asm_exc_page_fault+0x22/0x30
> 
> So I think there's something funny going on in thaw.

As Christian wrote, it seems systemd-journald does a memory store to
mmapped file and gets blocked on sb_start_write() while doing the page
fault. What's strange is that R state. Is the task really executing on some
CPU or it only has 'R' state (i.e., got woken but never scheduled)?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

