Return-Path: <linux-fsdevel+bounces-5768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501AE80FBB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 01:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E23282300
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 00:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D58715A7;
	Wed, 13 Dec 2023 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bZFAtBt2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="STQ3sQiP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WKxirnNX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FPSaOWmH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9208E92;
	Tue, 12 Dec 2023 16:03:33 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C679224D5;
	Wed, 13 Dec 2023 00:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702425812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/YCtkxomysorMe8+B3LPHGQoAWAMi5aJjY5jm68VOU=;
	b=bZFAtBt2SjSvz+LuIlFMHmMnkrUj/itQLlps6WOrBJS0WAr8gYh9KLbEg9ElMK1C9p+6KT
	LCRtVaO2Sbt1pj6l/TlWQZ3X3U8GiiPnBJa73LIsFQPS4pNLxhl0pr0D4WFUx8jpWqKpeP
	nl5U7/SFJrMpMO5ejr+9wcRn4R5M7OA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702425812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/YCtkxomysorMe8+B3LPHGQoAWAMi5aJjY5jm68VOU=;
	b=STQ3sQiPpL7US3zzzlTHy9+53CGV1WdRy0AEfz14meD5GY/ZEfMt0BNSpRdu5NoBvggc17
	nRpKInQ9BMk+idBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702425810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/YCtkxomysorMe8+B3LPHGQoAWAMi5aJjY5jm68VOU=;
	b=WKxirnNXCs3tl/vG9Gv2mj+lIPRrHytqEhVpDNsihbWf+245NEQ5R+WhtnvmXPWZbRDXUT
	VuG8RjYs9X7Mf1FfyGehv5wwkEJBSg/6IpK5xnxSbgHbyxbiwP70i85HmFt4yIDHyP82qf
	3ifOvB+ltUJjQoPZzFBb5J6yo5tL1x0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702425810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/YCtkxomysorMe8+B3LPHGQoAWAMi5aJjY5jm68VOU=;
	b=FPSaOWmHy3apG6a5Ypi3JbwpAvsUaGyVNqRhZkHsJrkMLNeVWjCBnVbOuUJwBq3m3cs2vp
	SsbJxKIgBP6DObDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9953F137E8;
	Wed, 13 Dec 2023 00:03:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GfmmEs/0eGU2NwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 13 Dec 2023 00:03:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dave Chinner" <david@fromorbit.com>
Cc: "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Donald Buczek" <buczek@molgen.mpg.de>, linux-bcachefs@vger.kernel.org,
 "Stefan Krueger" <stefan.krueger@aei.mpg.de>,
 "David Howells" <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
In-reply-to: <ZXjnffHOo+JY/M4b@dread.disaster.area>
References: <20231211233231.oiazgkqs7yahruuw@moria.home.lan>,
 <170233878712.12910.112528191448334241@noble.neil.brown.name>,
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>,
 <170234279139.12910.809452786055101337@noble.neil.brown.name>,
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>,
 <20231212152153.tasaxsrljq2zzbxe@moria.home.lan>,
 <ZXjHEPn3DfgQNoms@dread.disaster.area>,
 <20231212212306.tpaw7nfubbuogglw@moria.home.lan>,
 <ZXjaWIFKvBRH7Q4c@dread.disaster.area>,
 <170242027365.12910.2226609822336684620@noble.neil.brown.name>,
 <ZXjnffHOo+JY/M4b@dread.disaster.area>
Date: Wed, 13 Dec 2023 11:03:24 +1100
Message-id: <170242580446.12910.2698499391937550745@noble.neil.brown.name>
X-Spam-Level: **********
X-Spam-Score: 10.05
X-Spam-Level: 
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 2C679224D5
X-Spam-Flag: NO
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WKxirnNX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FPSaOWmH;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of neilb@suse.de) smtp.mailfrom=neilb@suse.de
X-Spamd-Result: default: False [-8.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.00)[10.54%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_SPF_SOFTFAIL(0.00)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 WHITELIST_DMARC(-7.00)[suse.de:D:+];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,fromorbit.com:email];
	 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -8.81

On Wed, 13 Dec 2023, Dave Chinner wrote:
> On Wed, Dec 13, 2023 at 09:31:13AM +1100, NeilBrown wrote:
> > On Wed, 13 Dec 2023, Dave Chinner wrote:
> > > 
> > > What you are suggesting is that we now duplicate filehandle encoding
> > > into every filesystem's statx() implementation.  That's a bad
> > > trade-off from a maintenance, testing and consistency POV because
> > > now we end up with lots of individual, filehandle encoding
> > > implementations in addition to the generic filehandle
> > > infrastructure that we all have to test and validate.
> > 
> > Not correct.  We are suggesting an interface, not an implementation.
> > Here you are proposing a suboptimal implementation, pointing out its
> > weakness, and suggesting the has consequences for the interface
> > proposal.  Is that the strawman fallacy?
> 
> No, you simply haven't followed deep enough into the rabbit hole to
> understand Kent was suggesting potential implementation details to
> address hot path performance concerns with filehandle encoding.

Yes, I missed that.  Sorry.

NeilBrown


> 
> > vfs_getattr_nosec could, after calling i_op->getattr, check if
> > STATX_HANDLE is set in request_mask but not in ->result_mask.
> > If so it could call exportfs_encode_fh() and handle the result.
> >
> > No filesystem need to be changed.
> 
> Well, yes, it's pretty damn obvious that is exactly what I've been
> advocating for here - if we are going to put filehandles in statx(),
> then it must use the same infrastructure as name_to_handle_at().
> i.e. calling exportfs_encode_fh(EXPORT_FH_FID) to generate the
> filehandle.
> 
> The important discussion detail you've missed about
> exportfs_encode_fh() is that it *requires* adding a new indirect
> call (via export_ops->encode_fh) in the statx path to encode the
> filehandle, and that's exactly what Kent was suggesting we can code
> the implementation to avoid.
> 
> Avoiding an indirect function call is an implementation detail, not
> an interface design requirement.
> 
> And the only way to avoid adding new indirect calls to encoding
> filesystem specific filehandles is to implement the encoding in the
> existing individual filesystem i_op->getattr methods. i.e. duplicate
> the filehandle encoding in the statx path rather than use
> exportfs_encode_fh().....
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 


