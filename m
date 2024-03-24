Return-Path: <linux-fsdevel+bounces-15183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD02E887F77
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 23:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C761C2105A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 22:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBBADF60;
	Sun, 24 Mar 2024 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jvhVb9dC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5fS4Wrel";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jvhVb9dC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5fS4Wrel"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB5633EE
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Mar 2024 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319533; cv=none; b=cEW3A9Iz6CnqgTDTCu+7mjioG6OdvCG/m9JdXJyBzArUx5zdZ91YpJC14Rtc8KRmhSkuHzBwssktluQm3BujzIcSCHpXi3SG3umYKYFXAZW33TvNalu6Appatk+RAY7hYDtiOgow64bHQeMjZ/WTIdaOpNVqMgpVuvc10QdwkD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319533; c=relaxed/simple;
	bh=3RvofINqfxOlc3jJ3U0ZkDy7XLLLHKqrpV3bA8j4QQM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=MOKF7Oc/WDeS7iAhVT1/yo3B+Wi+DnK9LOmL1QQDZ4J2QOVY+TPMxhXzG69dKeHCk2+zWX7bI4fwOlwXznrcx48w5w1FRhve8tRt79aFrNwpZyBQOpiAVhqu+O4rrg06aZ7fFa8cOTObspXoF6ULdZ33WavSHxctMOlmgVwEUcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jvhVb9dC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5fS4Wrel; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jvhVb9dC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5fS4Wrel; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 43DB73497A;
	Sun, 24 Mar 2024 22:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711319529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3x2fH80xwTkZxJqVhWR9l/YQmasWQHczWuqXjNJsFXk=;
	b=jvhVb9dC8c9rBnQhVZkI6IY6+y+rnnsHgLTQKjlNSmIY9YfvIKR+UCP+a2aqQknj7zcR57
	7dQS1w4s3kV6KnCaVi+xHXsgJPkFLakrzZA/OHLyovRKl4SaQ/b+TDN2LwVkNITbUaOmmY
	cLb1Qve0fW/qlTcsFL4hQWUn8dGYljY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711319529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3x2fH80xwTkZxJqVhWR9l/YQmasWQHczWuqXjNJsFXk=;
	b=5fS4Wrel5FtNNRdEMIRLlyrQPbPoWBfnesnsTD7tmGP2WI33mAwbpXcxPhS4TJJrjc5var
	2y/liehtYfQwf5DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711319529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3x2fH80xwTkZxJqVhWR9l/YQmasWQHczWuqXjNJsFXk=;
	b=jvhVb9dC8c9rBnQhVZkI6IY6+y+rnnsHgLTQKjlNSmIY9YfvIKR+UCP+a2aqQknj7zcR57
	7dQS1w4s3kV6KnCaVi+xHXsgJPkFLakrzZA/OHLyovRKl4SaQ/b+TDN2LwVkNITbUaOmmY
	cLb1Qve0fW/qlTcsFL4hQWUn8dGYljY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711319529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3x2fH80xwTkZxJqVhWR9l/YQmasWQHczWuqXjNJsFXk=;
	b=5fS4Wrel5FtNNRdEMIRLlyrQPbPoWBfnesnsTD7tmGP2WI33mAwbpXcxPhS4TJJrjc5var
	2y/liehtYfQwf5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4F7613695;
	Sun, 24 Mar 2024 22:32:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N0HoGeSpAGYPNQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 24 Mar 2024 22:32:04 +0000
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
 "linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Jiri Pirko" <jiri@resnulli.us>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
In-reply-to: <fa490acb-2df6-435d-a68f-8db814db4685@moroto.mountain>
References:
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>,
 <Zd-LljY351NCrrCP@casper.infradead.org>,
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>,
 <ZeFtrzN34cLhjjHK@dread.disaster.area>,
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>,
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>,
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>,
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>,
 <22363d0a-71db-4ba7-b5e1-8bb515811d1c@moroto.mountain>,
 <171107206231.13576.16550758513765438714@noble.neil.brown.name>,
 <fa490acb-2df6-435d-a68f-8db814db4685@moroto.mountain>
Date: Mon, 25 Mar 2024 09:31:53 +1100
Message-id: <171131951305.13576.14679515391685379475@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,fromorbit.com,infradead.org,gmail.com,kernel.org,lists.linux-foundation.org,kvack.org,vger.kernel.org,suse.cz,resnulli.us];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri, 22 Mar 2024, Dan Carpenter wrote:
> On Fri, Mar 22, 2024 at 12:47:42PM +1100, NeilBrown wrote:
> > On Thu, 21 Mar 2024, Dan Carpenter wrote:
> > > On Mon, Mar 04, 2024 at 09:45:48AM +1100, NeilBrown wrote:
> > > > I have in mind a more explicit statement of how much waiting is
> > > > acceptable.
> > > > 
> > > > GFP_NOFAIL - wait indefinitely
> > > 
> > > Why not call it GFP_SMALL?  It wouldn't fail.  The size would have to be
> > > less than some limit.  If the size was too large, that would trigger a
> > > WARN_ON_ONCE().
> > 
> > I would be happy with GFP_SMALL.  It would never return NULL but might
> > block indefinitely.  It would (as you say) WARN (maybe ONCE) if the size
> > was considered "COSTLY" and would possibly BUG if the size exceeded
> > KMALLOC_MAX_SIZE. 
> 
> I'd like to keep GFP_SMALL much smaller than KMALLOC_MAX_SIZE.  IIf
> you're allocating larger than that, you'd still be able to GFP_NOFAIL.
> I looked quickly an I think over 60% of allocations are just sizeof(*p)
> and probably 90% are under 4k.

What do you mean exactly by "keep"??
Do you mean WARN_ON if it is "too big" - certainly agree.
Do you mean BUG_ON if it is "too big" - maybe agree.
Do you mean return NULL if it is "too big" - definitely disagree.
Do you mean build failure if it could be too big - I would LOVE that,
but I don't think we can do that with current build tools.

Thanks,
NeilBrown



> 
> > 
> > > 
> > > I obviously understand that this duplicates the information in the size
> > > parameter but the point is that GFP_SMALL allocations have been
> > > reviewed, updated, and don't have error handling code.
> > 
> > We are on the same page here.
> > 
> > > 
> > > We'd keep GFP_KERNEL which would keep the existing behavior.  (Which is
> > > that it can sleep and it can fail).  I think that maps to GFP_RETRY but
> > > GFP_RETRY is an uglier name.
> > 
> > Can it fail though?  I know it is allowed to, but does it happen?
> > 
> 
> In some sense, I don't really care about this, I just want the rules
> clear from a static analysis perspective.  Btw, you're discussing making
> the too small to fail rule official but other times we have discussed
> getting rid of it all together.  So I think maybe it's better to keep
> the rules strict but allow the actual implentation to change later.
> 
> The GFP_SMALL stuff is nice for static analysis because it would warn
> about anything larger than whatever the small limit is.  So that means I
> have fewer allocations to review for integer overflow bugs.
> 
> Btw, Jiri Pirko, was proposing a macro which would automatically
> allocate the 60+% of allocations which are sizeof(*p).
> https://lore.kernel.org/all/20240315132249.2515468-1-jiri@resnulli.us/
> I had offered an alternative macro but the idea is the same:
> 
> #define __ALLOC(p) p __free(kfree) = kzalloc(sizeof(*p), GFP_KERNEL)
>         struct ice_aqc_get_phy_caps_data *__ALLOC(pcaps);
> 
> Combining no fail allocations with automatic cleanup changes the way you
> write code.
> 
> And then on the success patch you have the no_free_ptr() which I haven't
> used but I think will be so useful for static analysis.  I'm so excited
> about this.
> 
> regards,
> dan carpenter
> 
> 
> 


