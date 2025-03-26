Return-Path: <linux-fsdevel+bounces-45101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7E0A71E93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 19:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171843B99A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 18:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECB52512EE;
	Wed, 26 Mar 2025 18:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aDaEq4wq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3kqJHdvb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aDaEq4wq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3kqJHdvb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16424CEEE
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743014543; cv=none; b=DROWWCk7EJa/QtgZ+sWEX6HA7szpd8iSuJW+53/FgcKpuc+l7EyRf8oKPzX44h0BSn02brjBorR9LhEcWaeQwvFnnfYIgtyQPn3MEK1ncEfajLuoh6ObSs0r9qx1+1E8HG/FhIa58Ult8L02K7dobZ1dKMgXkvbQ69pZtyg5K+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743014543; c=relaxed/simple;
	bh=BEeWzFcMmpNgrb1iV0rUA2ppfK/qpOxilt/ccNq7njk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9pwOorPE0CapW2Qrd+Ld7P/igXvaE/gX+zWJscgtRHdseqtWgsbsgZVOOQ2z8X0+gZgS1m1cDzDLbuRjtyNWSw2jFn/G8CEMBIwjTTCJWDmnhKx+NLcYiKLpQyjJqvHPptBHPvj2s7/wM2r8NNIqTJATqm/MzKzd4gBwaGVbnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aDaEq4wq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3kqJHdvb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aDaEq4wq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3kqJHdvb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 645B31F391;
	Wed, 26 Mar 2025 18:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743014539;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9qLH0qpM4x0RyvH9l3nS9+y/Bxb/6gbHoq6XOzakpA=;
	b=aDaEq4wq9W0uSnAg92BHuG5G+GM2WB7iX3whuDAa46OK9fwbor3OSL5iWzP3L0czOsHr4x
	IgTaTAL50wobvR46x0UjQizVXmGAXCqrH9iAihvaQg8pPoPliKd4WSyZhh96F+oPMZLOnu
	v/RlBEtTDGeqDKZeio4JAQSFg8qM7BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743014539;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9qLH0qpM4x0RyvH9l3nS9+y/Bxb/6gbHoq6XOzakpA=;
	b=3kqJHdvbGSK/a67Ulvl+95Sey+QWdMkCUsBlhkZj5egLN/xjROclsCZANmcv5oVd0jlcSo
	K6uxe84DKP1Uc8DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743014539;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9qLH0qpM4x0RyvH9l3nS9+y/Bxb/6gbHoq6XOzakpA=;
	b=aDaEq4wq9W0uSnAg92BHuG5G+GM2WB7iX3whuDAa46OK9fwbor3OSL5iWzP3L0czOsHr4x
	IgTaTAL50wobvR46x0UjQizVXmGAXCqrH9iAihvaQg8pPoPliKd4WSyZhh96F+oPMZLOnu
	v/RlBEtTDGeqDKZeio4JAQSFg8qM7BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743014539;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9qLH0qpM4x0RyvH9l3nS9+y/Bxb/6gbHoq6XOzakpA=;
	b=3kqJHdvbGSK/a67Ulvl+95Sey+QWdMkCUsBlhkZj5egLN/xjROclsCZANmcv5oVd0jlcSo
	K6uxe84DKP1Uc8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2748A13927;
	Wed, 26 Mar 2025 18:42:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4TwoCItK5Gf6GQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 26 Mar 2025 18:42:19 +0000
Date: Wed, 26 Mar 2025 19:42:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [LTP] [PATCH] ioctl_ficlone03: fix capabilities on immutable
 files
Message-ID: <20250326184208.GA53635@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250326-fix_ioctl_ficlone03_32bit_bcachefs-v1-1-554a0315ebf5@suse.com>
 <20250326134749.GA45449@pevik>
 <7ry7netcdqchal5pyoa5qdiris5klyxg6pqnz3qj6toodfgyuw@zder35svbr7v>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ry7netcdqchal5pyoa5qdiris5klyxg6pqnz3qj6toodfgyuw@zder35svbr7v>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:replyto];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -3.50
X-Spam-Flag: NO

Hi Kent,

> On Wed, Mar 26, 2025 at 02:47:49PM +0100, Petr Vorel wrote:
> > Hi all,

> > [ Cc Kent and other filesystem folks to be sure we don't hide a bug ]

> I'm missing context here, and the original thread doesn't seem to be on
> lore?

I'm sorry, to put more info: this is an attempt to fix of LTP test
ioctl_ficlone03.c [1], which is failing on 32 bit compatibility mode:

# ./ioctl_ficlone03
tst_test.c:1833: TINFO: === Testing on bcachefs ===
..
ioctl_ficlone03.c:74: TBROK: ioctl .. failed: ENOTTY (25)
ioctl_ficlone03.c:89: TWARN: ioctl ..  failed: ENOTTY (25)
ioctl_ficlone03.c:91: TWARN: ioctl ..  failed: ENOTTY (25)
ioctl_ficlone03.c:98: TWARN: close(-1) failed: EBADF (9)

Original thread of this is on LTP ML [2].

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
[2] https://lore.kernel.org/ltp/20250326-fix_ioctl_ficlone03_32bit_bcachefs-v1-1-554a0315ebf5@suse.com/

> > > From: Andrea Cervesato <andrea.cervesato@suse.com>

> > > Make sure that capabilities requirements are satisfied when accessing
> > > immutable files. On OpenSUSE Tumbleweed 32bit bcachefs fails with the
> > > following error due to missing capabilities:

> > > tst_test.c:1833: TINFO: === Testing on bcachefs ===
> > > ..
> > > ioctl_ficlone03.c:74: TBROK: ioctl .. failed: ENOTTY (25)
> > > ioctl_ficlone03.c:89: TWARN: ioctl ..  failed: ENOTTY (25)
> > > ioctl_ficlone03.c:91: TWARN: ioctl ..  failed: ENOTTY (25)
> > > ioctl_ficlone03.c:98: TWARN: close(-1) failed: EBADF (9)

> > > Introduce CAP_LINUX_IMMUTABLE capability to make sure that test won't
> > > fail on other systems as well.

> > > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > > ---
> > >  testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)

> > > diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> > > index 6a9d270d9fb56f3a263f0aed976f62c4576e6a5f..6716423d9c96d9fc1d433f28e0ae1511b912ae2c 100644
> > > --- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> > > +++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> > > @@ -122,5 +122,9 @@ static struct tst_test test = {
> > >  	.bufs = (struct tst_buffers []) {
> > >  		{&clone_range, .size = sizeof(struct file_clone_range)},
> > >  		{},
> > > -	}
> > > +	},
> > > +	.caps = (struct tst_cap []) {
> > > +		TST_CAP(TST_CAP_REQ, CAP_LINUX_IMMUTABLE),
> > > +		{}
> > > +	},

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > LGTM, obviously it is CAP_LINUX_IMMUTABLE related.

> > This looks like fs/bcachefs/fs-ioctl.c

> > static int bch2_inode_flags_set(struct btree_trans *trans,
> > 				struct bch_inode_info *inode,
> > 				struct bch_inode_unpacked *bi,
> > 				void *p)
> > {
> > 	...
> > 	if (((newflags ^ oldflags) & (BCH_INODE_append|BCH_INODE_immutable)) &&
> > 	    !capable(CAP_LINUX_IMMUTABLE))
> > 		return -EPERM;


> > We don't test on vfat and exfat. If I try to do it fail the same way (bcachefs,
> > fat, exfat and ocfs2 use custom handler for FAT_IOCTL_SET_ATTRIBUTES).

> > I wonder why it does not fail for generic VFS fs/ioctl.c used by Btrfs and XFS:

> > /*
> >  * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values and reject
> >  * any invalid configurations.
> >  *
> >  * Note: must be called with inode lock held.
> >  */
> > static int fileattr_set_prepare(struct inode *inode,
> > 			      const struct fileattr *old_ma,
> > 			      struct fileattr *fa)
> > {
> > 	int err;

> > 	/*
> > 	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
> > 	 * the relevant capability.
> > 	 */
> > 	if ((fa->flags ^ old_ma->flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
> > 	    !capable(CAP_LINUX_IMMUTABLE))
> > 		return -EPERM;


> > Kind regards,
> > Petr

> > >  };

> > > ---
> > > base-commit: 753bd13472d4be44eb70ff183b007fe9c5fffa07
> > > change-id: 20250326-fix_ioctl_ficlone03_32bit_bcachefs-2ec15bd6c0c6

> > > Best regards,

