Return-Path: <linux-fsdevel+bounces-15045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB078864E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 02:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F66128396D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 01:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B0D138E;
	Fri, 22 Mar 2024 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Df6szJWA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0DKNwIPQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Df6szJWA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0DKNwIPQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7D10E3
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711072074; cv=none; b=V1hxLVoOiToMcYkn7SPG0+mHFhg6GNtnRDJzWKwoUQvpnoRrgFPExIYE6xTSKCrm1ypRSM3mby6NfVh5f7F95XtvIwJCtf66aNuw5hLD78/GcYlp2F9tLZ4Mla6ukj29DL3D3FC/NBkAgLTOldMJ6Ot5yYcSE2A6kAwHf6B6RLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711072074; c=relaxed/simple;
	bh=RSytXHPUrUpVCXUexDd+NhSJrC25Y2MvJilI1pY4/6s=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qvBHsHMldDT5LhZdCeEvFDWIYqXIGlC5h77So5GV+kIjSclTh2oGVyjOC9b3aTIjNWxSpstAb2dXrTvGyObpS+j3kfcsDz6xE1fsKnCbg9R+52a0kKvkZmlP2mNuAUN2B1HXSPNRtiRFAozo59jvcyS/whmiVjqRwWyGrnBIsrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Df6szJWA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0DKNwIPQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Df6szJWA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0DKNwIPQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C39D37DFF;
	Fri, 22 Mar 2024 01:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711072070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qB5h1cXTtBf6CkxlPpVgndnqzX6pa6NxOnKxnnwpgIQ=;
	b=Df6szJWA4yMVMZXXaZKpkO+RDk4HiHOW6p6036TJcmuxfZxc+4N3HO605+iDXusIA0JeAq
	FajK1eVzkk0k68ZmQyM75+qUNegxJWX9n6LDaUuuNZ4jLgDx4NM9mtOAJyKXFkgXyTIsFZ
	HTi2uVe6yJIcTMUAVOkWFgCtrXWqCAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711072070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qB5h1cXTtBf6CkxlPpVgndnqzX6pa6NxOnKxnnwpgIQ=;
	b=0DKNwIPQWBjFSjGgBFfQDYwn+HRVOUocDDR2vfX34H/fqKBbCivDSBb9P5K6CH3kYgrPBA
	4Pqr/djfAixVdKBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711072070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qB5h1cXTtBf6CkxlPpVgndnqzX6pa6NxOnKxnnwpgIQ=;
	b=Df6szJWA4yMVMZXXaZKpkO+RDk4HiHOW6p6036TJcmuxfZxc+4N3HO605+iDXusIA0JeAq
	FajK1eVzkk0k68ZmQyM75+qUNegxJWX9n6LDaUuuNZ4jLgDx4NM9mtOAJyKXFkgXyTIsFZ
	HTi2uVe6yJIcTMUAVOkWFgCtrXWqCAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711072070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qB5h1cXTtBf6CkxlPpVgndnqzX6pa6NxOnKxnnwpgIQ=;
	b=0DKNwIPQWBjFSjGgBFfQDYwn+HRVOUocDDR2vfX34H/fqKBbCivDSBb9P5K6CH3kYgrPBA
	4Pqr/djfAixVdKBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15349137D4;
	Fri, 22 Mar 2024 01:47:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /D6+KkHj/GUHPQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 22 Mar 2024 01:47:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dan Carpenter" <dan.carpenter@linaro.org>
Cc: "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Dave Chinner" <david@fromorbit.com>, "Matthew Wilcox" <willy@infradead.org>,
 "Amir Goldstein" <amir73il@gmail.com>, paulmck@kernel.org,
 lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 "linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "Jan Kara" <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
In-reply-to: <22363d0a-71db-4ba7-b5e1-8bb515811d1c@moroto.mountain>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>,
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>,
 <Zd-LljY351NCrrCP@casper.infradead.org>,
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>,
 <ZeFtrzN34cLhjjHK@dread.disaster.area>,
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>,
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>,
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>,
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>,
 <22363d0a-71db-4ba7-b5e1-8bb515811d1c@moroto.mountain>
Date: Fri, 22 Mar 2024 12:47:42 +1100
Message-id: <171107206231.13576.16550758513765438714@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Df6szJWA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0DKNwIPQ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[linux.dev,fromorbit.com,infradead.org,gmail.com,kernel.org,lists.linux-foundation.org,kvack.org,vger.kernel.org,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 2C39D37DFF
X-Spam-Flag: NO

On Thu, 21 Mar 2024, Dan Carpenter wrote:
> On Mon, Mar 04, 2024 at 09:45:48AM +1100, NeilBrown wrote:
> > I have in mind a more explicit statement of how much waiting is
> > acceptable.
> > 
> > GFP_NOFAIL - wait indefinitely
> 
> Why not call it GFP_SMALL?  It wouldn't fail.  The size would have to be
> less than some limit.  If the size was too large, that would trigger a
> WARN_ON_ONCE().

I would be happy with GFP_SMALL.  It would never return NULL but might
block indefinitely.  It would (as you say) WARN (maybe ONCE) if the size
was considered "COSTLY" and would possibly BUG if the size exceeded
KMALLOC_MAX_SIZE. 

> 
> I obviously understand that this duplicates the information in the size
> parameter but the point is that GFP_SMALL allocations have been
> reviewed, updated, and don't have error handling code.

We are on the same page here.

> 
> We'd keep GFP_KERNEL which would keep the existing behavior.  (Which is
> that it can sleep and it can fail).  I think that maps to GFP_RETRY but
> GFP_RETRY is an uglier name.

Can it fail though?  I know it is allowed to, but does it happen?

I think I would prefer the normal approach for allocations that are (or
might be) too large for GFP_SMALL was to *not* risk triggering oom.
So I'd rather we didn't have GFP_KERNEL (which I think does have that
risk) and instead (maybe) GFP_LARGE which sleeps but will return NULL
when an OOM condition is looming.

So we only get OOM for GFP_SMALL allocations (because not failing
simplifies the code), and where it is explicitly requested - like for
user-space allocations and probably for file cache allocations.

But I think that keeping it simple and only adding GFP_SMALL as we have
discussed would be a big step in the right direction and we don't need
to complicate it with other ideas.

Thanks,
NeilBrown


> 
> People could still use __GFP_NOFAIL for larger allocations.
> 
> regards,
> dan carpenter
> 
> 
> 


