Return-Path: <linux-fsdevel+bounces-5758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6817880FA50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 23:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2970B20FD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 22:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB7B39E;
	Tue, 12 Dec 2023 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OG7D9bT5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LF/0RfIA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OG7D9bT5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LF/0RfIA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84581B3;
	Tue, 12 Dec 2023 14:31:26 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B128822237;
	Tue, 12 Dec 2023 22:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702420284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfyNTv0q9L99BcY0TdZcp1EQZHyTtPWABobfyevh1ic=;
	b=OG7D9bT5X1kE4DjBZm+TemH/jvRhMbjRB3XoT8HxXqkwEwc+eP5GyhNjT71ZaVBGl6RzZ4
	p+l1oJNf2wdlADg4Hzo4n2zLeKJeMtNu0R5JAVLUljfi2yeC+TAUuo8AdaOzJJULOpATBw
	oOh1SwZYX2ZBxVq7/PEBI53kf/FVPV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702420284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfyNTv0q9L99BcY0TdZcp1EQZHyTtPWABobfyevh1ic=;
	b=LF/0RfIAVPbWGRlS458BfpEmtLymVsENO4LCsKdzeMwrhj7WQ8cghIa8QbhebwO8FrlEw9
	GlqaJDGHErPU+lBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702420284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfyNTv0q9L99BcY0TdZcp1EQZHyTtPWABobfyevh1ic=;
	b=OG7D9bT5X1kE4DjBZm+TemH/jvRhMbjRB3XoT8HxXqkwEwc+eP5GyhNjT71ZaVBGl6RzZ4
	p+l1oJNf2wdlADg4Hzo4n2zLeKJeMtNu0R5JAVLUljfi2yeC+TAUuo8AdaOzJJULOpATBw
	oOh1SwZYX2ZBxVq7/PEBI53kf/FVPV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702420284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfyNTv0q9L99BcY0TdZcp1EQZHyTtPWABobfyevh1ic=;
	b=LF/0RfIAVPbWGRlS458BfpEmtLymVsENO4LCsKdzeMwrhj7WQ8cghIa8QbhebwO8FrlEw9
	GlqaJDGHErPU+lBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D8F313725;
	Tue, 12 Dec 2023 22:31:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5Y8EMDTfeGX4GQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 12 Dec 2023 22:31:16 +0000
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
In-reply-to: <ZXjaWIFKvBRH7Q4c@dread.disaster.area>
References: <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>,
 <170233460764.12910.276163802059260666@noble.neil.brown.name>,
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>,
 <170233878712.12910.112528191448334241@noble.neil.brown.name>,
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>,
 <170234279139.12910.809452786055101337@noble.neil.brown.name>,
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>,
 <20231212152153.tasaxsrljq2zzbxe@moria.home.lan>,
 <ZXjHEPn3DfgQNoms@dread.disaster.area>,
 <20231212212306.tpaw7nfubbuogglw@moria.home.lan>,
 <ZXjaWIFKvBRH7Q4c@dread.disaster.area>
Date: Wed, 13 Dec 2023 09:31:13 +1100
Message-id: <170242027365.12910.2226609822336684620@noble.neil.brown.name>
X-Spam-Level: 
X-Spam-Score: -1.11
X-Spam-Level: 
X-Spam-Flag: NO
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.11 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.01)[50.12%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -1.11

On Wed, 13 Dec 2023, Dave Chinner wrote:
> 
> What you are suggesting is that we now duplicate filehandle encoding
> into every filesystem's statx() implementation.  That's a bad
> trade-off from a maintenance, testing and consistency POV because
> now we end up with lots of individual, filehandle encoding
> implementations in addition to the generic filehandle
> infrastructure that we all have to test and validate.

Not correct.  We are suggesting an interface, not an implementation.
Here you are proposing a suboptimal implementation, pointing out its
weakness, and suggesting the has consequences for the interface
proposal.  Is that the strawman fallacy?

vfs_getattr_nosec could, after calling i_op->getattr, check if
STATX_HANDLE is set in request_mask but not in ->result_mask.
If so it could call exportfs_encode_fh() and handle the result.

No filesystem need to be changed.

NeilBrown

