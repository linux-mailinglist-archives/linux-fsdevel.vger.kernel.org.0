Return-Path: <linux-fsdevel+bounces-71047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A406CB29C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 10:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1646E302532A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 09:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221B6302168;
	Wed, 10 Dec 2025 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CO2WntF1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kpbXqxou";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CO2WntF1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kpbXqxou"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000752FE041
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765360552; cv=none; b=WsMIdAr7VC/i27F6vUdF0rkF4Zsvj1l+hKKjAM3VuB2DQDCGzPCPDDb/dj/IBRLSjbsvy+ivzfKxc+OgOiOW+xeW9xoh5hF1VgOIJxgEESb74SgFmhc39NOSPRecPzJUnZKdoC88fa2a7C4QMvf4yKadq29yQsjhVPWkHv8C80U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765360552; c=relaxed/simple;
	bh=AF0yC49fOFQCrKHokjRIPRZTQYb6wu4/QnCPnNSRrXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfDd4R5EpRIOoh2lmisUqNH2bpeUArpTkEyUG+R4IUWcL4FZDy5fvWOL1S0VhrECGJL6jxqEOLIPi0TgzvDt4Is35iSf37gnk3oye+EY7r7NPsMj0v8ayAXGN+HrdDQMFOvuZgQe7Nef9ilcp2GdyW/8r+OXXXqlasM8Wx0UiJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CO2WntF1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kpbXqxou; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CO2WntF1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kpbXqxou; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 316BF338AD;
	Wed, 10 Dec 2025 09:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765360543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMeR+6F3WeucAMPqM0tjvM4fOhznr3OcpRNVrvovJfk=;
	b=CO2WntF1Ch9fgZuCcBJh4n6vUF7imDzex2gvpOW0sogSPiUsKchR7xZ7phQN7k8b+N8HJN
	dttvsduDoT3GUsiKx0DKYSQH405sahPM7/8l3dhQ3s6k3l0F/7mf79D4RGhzUd8GH8voQ+
	gtiZR+Iu3dVCE9d3CyPe3Wt2KYLIpwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765360543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMeR+6F3WeucAMPqM0tjvM4fOhznr3OcpRNVrvovJfk=;
	b=kpbXqxouFpnfhAtKv4s2f/+yF35O/zeCnrmXwSLiAZQlmecRv+9YhYzjpPzxuvUaaJ04Zx
	peTu+z9ENAvDP8BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765360543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMeR+6F3WeucAMPqM0tjvM4fOhznr3OcpRNVrvovJfk=;
	b=CO2WntF1Ch9fgZuCcBJh4n6vUF7imDzex2gvpOW0sogSPiUsKchR7xZ7phQN7k8b+N8HJN
	dttvsduDoT3GUsiKx0DKYSQH405sahPM7/8l3dhQ3s6k3l0F/7mf79D4RGhzUd8GH8voQ+
	gtiZR+Iu3dVCE9d3CyPe3Wt2KYLIpwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765360543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMeR+6F3WeucAMPqM0tjvM4fOhznr3OcpRNVrvovJfk=;
	b=kpbXqxouFpnfhAtKv4s2f/+yF35O/zeCnrmXwSLiAZQlmecRv+9YhYzjpPzxuvUaaJ04Zx
	peTu+z9ENAvDP8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0477A3EA65;
	Wed, 10 Dec 2025 09:55:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wILRAJ9DOWllaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Dec 2025 09:55:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AFC9DA0A61; Wed, 10 Dec 2025 10:55:42 +0100 (CET)
Date: Wed, 10 Dec 2025 10:55:42 +0100
From: Jan Kara <jack@suse.cz>
To: Deepak Karn <dkarn@redhat.com>
Cc: Jan Kara <jack@suse.cz>, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+e07658f51ca22ab65b4e@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
Subject: Re: [PATCH v2] fs: add NULL check in drop_buffers() to prevent
 null-ptr-deref
Message-ID: <ujd4c2sadpu3fsux2t667ef3zz2i2nyiqvhes4ahbtpay4ba3f@unn3uh57fxdk>
References: <20251208193024.GA89444@frogsfrogsfrogs>
 <20251208201333.528909-1-dkarn@redhat.com>
 <enzq67rnekrh7gycgvgjc4g5ryt7qvuamaqj3ndpmns5svosa4@ozcepp4lpyls>
 <CAO4qAqK-6jpiFXTdpoB-e144N=Ux0Hs+NOouM6cmVDzV8V-Dcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO4qAqK-6jpiFXTdpoB-e144N=Ux0Hs+NOouM6cmVDzV8V-Dcw@mail.gmail.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[e07658f51ca22ab65b4e];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Tue 09-12-25 22:00:04, Deepak Karn wrote:
> On Tue, Dec 9, 2025 at 4:48 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 09-12-25 01:43:33, Deepakkumar Karn wrote:
> > > On Mon, 8 Dec 2025 11:30:24 -0800, Darrick J. Wong wrote:
> > > > > drop_buffers() dereferences the buffer_head pointer returned by
> > > > > folio_buffers() without checking for NULL. This leads to a null pointer
> > > > > dereference when called from try_to_free_buffers() on a folio with no
> > > > > buffers attached. This happens when filemap_release_folio() is called on
> > > > > a folio belonging to a mapping with AS_RELEASE_ALWAYS set but without
> > > > > release_folio address_space operation defined. In such case,
> > >
> > > > What user is that?  All the users of AS_RELEASE_ALWAYS in 6.18 appear to
> > > > supply a ->release_folio.  Is this some new thing in 6.19?
> > >
> > > AFS directories SET AS_RELEASE_ALWAYS but have not .release_folio.
> >
> > AFAICS AFS sets AS_RELEASE_ALWAYS only for symlinks but not for
> > directories? Anyway I agree AFS symlinks will have AS_RELEASE_ALWAYS but no
> > .release_folio callback. And this looks like a bug in AFS because AFAICT
> > there's no point in setting AS_RELEASE_ALWAYS when you don't have
> > .release_folio callback. Added relevant people to CC.
> >
> >                                                                 Honza
> 
> Thank you for your response Jan. As you suggested, the bug is in AFS.
> Can we include this current defensive check in drop_buffers() and I can submit
> another patch to handle that bug of AFS we discussed?

I'm not strongly opposed to that (although try_to_free_buffers() would seem
like a tad bit better place) but overall I don't think it's a great idea as
it would hide bugs. But perhaps with WARN_ON_ONCE() (to catch sloppy
programming) it would be a sensible hardening.

Also I think mapping_set_release_always() should assert that
mapping->a_ops->release_folio is non-NULL to catch the problem early (once
you fix the AFS bug).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

