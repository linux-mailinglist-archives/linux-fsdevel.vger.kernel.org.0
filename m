Return-Path: <linux-fsdevel+bounces-4460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D577FF9C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7F728174E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8E65A0EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GHLBUrD1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="It08oP9y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5294D7F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 09:12:18 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 10F791FCF8;
	Thu, 30 Nov 2023 17:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701364337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WZeeIh04fDIk5KnkyAYQqT46cx0oYQ9WFlXOHsOAYHQ=;
	b=GHLBUrD1qRqm2mPBni6qfzJyV2l7mrvIZzokZwr/9aBtlvsijDYN7JU934YzegDeDVDmmN
	VV4rHC3IVtlAhbBGUeRV29EAakLzHU/SyZtOIt7Hofnz4XJ5/3HUaY3o40l5Ai42euPpRR
	IXoJjiK1ibz/jmaPjBTIXjYitY99Rb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701364337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WZeeIh04fDIk5KnkyAYQqT46cx0oYQ9WFlXOHsOAYHQ=;
	b=It08oP9yFMTBK+79nNWf2uZtVNiL7mkRlFdNc5rQsr2FEQvMy/pdDy/c97Eij3fHFBEBCe
	VAfxu54caYSFwdAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EDF71138E5;
	Thu, 30 Nov 2023 17:12:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id orsQOnDCaGUrHgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 17:12:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6DAE9A07E0; Thu, 30 Nov 2023 18:12:16 +0100 (CET)
Date: Thu, 30 Nov 2023 18:12:16 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fanotify: allow "weak" fsid when watching a
 single filesystem
Message-ID: <20231130171216.qrrtlitprrkrbt54@quack3>
References: <20231130165619.3386452-1-amir73il@gmail.com>
 <20231130165619.3386452-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130165619.3386452-3-amir73il@gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-2.72 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.93)[94.60%]
X-Spam-Score: -2.72

On Thu 30-11-23 18:56:19, Amir Goldstein wrote:
> So far, fanotify returns -ENODEV or -EXDEV when trying to set a mark
> on a filesystem with a "weak" fsid, namely, zero fsid (e.g. fuse), or
> non-uniform fsid (e.g. btrfs non-root subvol).
> 
> When group is watching inodes all from the same filesystem (or subvol),
> allow adding inode marks with "weak" fsid, because there is no ambiguity
> regarding which filesystem reports the event.
> 
> The first mark added to a group determines if this group is single or
> multi filesystem, depending on the fsid at the path of the added mark.
> 
> If the first mark added has a "strong" fsid, marks with "weak" fsid
> cannot be added and vice versa.
> 
> If the first mark added has a "weak" fsid, following marks must have
> the same "weak" fsid and the same sb as the first mark.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Yep, this is good. Can you please repost the whole series so that b4 can
easily pick it up from the list ;)? Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

