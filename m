Return-Path: <linux-fsdevel+bounces-79507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHgxCYeuqWn+CAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 17:25:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8E9215667
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 17:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39D2A3045E36
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A1E3C3BFF;
	Thu,  5 Mar 2026 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SboluI84";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gy8yt13D";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SboluI84";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gy8yt13D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5B13A63ED
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727935; cv=none; b=aGfVZlhe6gj3DQA2bbIaDXb/IyMV3V+HVTXyyutymwe/aia6Pgh4Kr0fvvzn4jg+TKbJhepNas4incHKy8s2pW1tF4xGFfCmAgENFE2mf9ym6q0EIBVven+my+3zoUmv5e48VrWP77PL6+EOAamJ1TUWoZcdmroVasmZJoiidjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727935; c=relaxed/simple;
	bh=ZzsSI0w+rux6IOJnseXJKev4Ps/FTPFRAuHYZ0+oVD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npzVH5avxkLzX1rrJ+if8eKz9hvXpt2NVhVwbl55RgMM3XV529bA6qlC3tNxlfcuh6YLsmjjVaKerU3eUeUMNWNrHktcp7K3dJgxzBalLrN3unU8g/39huox5QGdNtWQNlrvBXOtq5kqwWI/LelX7MZ6yDzSAKufPdz0VbPcjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SboluI84; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gy8yt13D; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SboluI84; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gy8yt13D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 112053E772;
	Thu,  5 Mar 2026 16:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772727932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bsjlUJ/oFS4TNjkXPGzAAnIHdkWC3Rf5TrIvhsGPzhY=;
	b=SboluI84xt3BVro1Qrfv//gEBdxpuyvOrS5zv9/1UlMb4heq9BdlRXi75vYfAqxbPCcEt2
	NMAuWyoFffEHapzyrh/Yy25gyoE4suu0d281hlJ3xNG0Tl9NhztMU0HhknRDHDlLDPeJXf
	jSZim/T6jUhymxio+fYxWI+a2Lo+B5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772727932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bsjlUJ/oFS4TNjkXPGzAAnIHdkWC3Rf5TrIvhsGPzhY=;
	b=Gy8yt13DSrWYD4RnUxIQRMPyTp6tOsVvzBR3E4qeCRMM7AA5rcdCgF+Wu65+nz8+sDyDyQ
	RyKJR1V0wqlAW9Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SboluI84;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Gy8yt13D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772727932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bsjlUJ/oFS4TNjkXPGzAAnIHdkWC3Rf5TrIvhsGPzhY=;
	b=SboluI84xt3BVro1Qrfv//gEBdxpuyvOrS5zv9/1UlMb4heq9BdlRXi75vYfAqxbPCcEt2
	NMAuWyoFffEHapzyrh/Yy25gyoE4suu0d281hlJ3xNG0Tl9NhztMU0HhknRDHDlLDPeJXf
	jSZim/T6jUhymxio+fYxWI+a2Lo+B5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772727932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bsjlUJ/oFS4TNjkXPGzAAnIHdkWC3Rf5TrIvhsGPzhY=;
	b=Gy8yt13DSrWYD4RnUxIQRMPyTp6tOsVvzBR3E4qeCRMM7AA5rcdCgF+Wu65+nz8+sDyDyQ
	RyKJR1V0wqlAW9Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08B923EA68;
	Thu,  5 Mar 2026 16:25:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tksdAnyuqWmXcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Mar 2026 16:25:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CBAABA0A8D; Thu,  5 Mar 2026 17:25:31 +0100 (CET)
Date: Thu, 5 Mar 2026 17:25:31 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, David Sterba <dsterba@suse.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
	linux-aio@kvack.org, Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [PATCH 31/32] kvm: Use private inode list instead of
 i_private_list
Message-ID: <norxrkgyn2t4qzcplhh7y6iat5ljhaexc75biwyqshq362yuor@etddmzwqvtht>
References: <20260303101717.27224-1-jack@suse.cz>
 <20260303103406.4355-63-jack@suse.cz>
 <20260304-mahnung-ableisten-50d5c4e71013@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-mahnung-ableisten-50d5c4e71013@brauner>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 8F8E9215667
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79507-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,zeniv.linux.org.uk,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kernel.org,kvack.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed 04-03-26 14:40:33, Christian Brauner wrote:
> On Tue, Mar 03, 2026 at 11:34:20AM +0100, Jan Kara wrote:
> > Instead of using mapping->i_private_list use a list in private part of
> > the inode.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  virt/kvm/guest_memfd.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 017d84a7adf3..6d36a7827870 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -30,6 +30,7 @@ struct gmem_file {
> >  struct gmem_inode {
> >  	struct shared_policy policy;
> >  	struct inode vfs_inode;
> > +	struct list_head gem_file_list;
> 
> I think that needs to be gMem_file_list not, gem_file_list.

Right, fixed. Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

