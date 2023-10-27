Return-Path: <linux-fsdevel+bounces-1381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D8F7D9D51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 17:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA64EB21483
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 15:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD4F37CBE;
	Fri, 27 Oct 2023 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TSswc8Di";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IaX1h+tL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A312A1F5E7
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 15:47:33 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2618C121;
	Fri, 27 Oct 2023 08:47:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C8D851F88E;
	Fri, 27 Oct 2023 15:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698421649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Nmj/s/loPouymwiRbhBMVtrXINMw6cnS/bvt4Esb7k=;
	b=TSswc8DiP9DxpCuRz3PwSblMhtz6wRCdufkFPVf/1Kx168M3T7e6n2I2SibvZeuJEAzNLg
	AwtF+SQEg3x4eWZixa8Ma4MFMIt37UdGCitoAMxKewF6xYy6leV231IUYY0fzgrMfb+Omt
	gVpVvKL3Zh9KTEyRImIvwZcMeXYtFmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698421649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Nmj/s/loPouymwiRbhBMVtrXINMw6cnS/bvt4Esb7k=;
	b=IaX1h+tL2UqX2aL+ig0w7SNmVK1iUtrcXOBiQJZuxHJEwUnP3NAJJpvctNa+t81r3K/Dlx
	Ti50Ml7gdp397GCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8A371358C;
	Fri, 27 Oct 2023 15:47:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +dYLLZHbO2W1JAAAMHmgww
	(envelope-from <jack@suse.cz>); Fri, 27 Oct 2023 15:47:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3ACE2A05BC; Fri, 27 Oct 2023 17:47:29 +0200 (CEST)
Date: Fri, 27 Oct 2023 17:47:29 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231027154729.cxb5ojwqj7ss2gwl@quack3>
References: <20231026155224.129326-1-amir73il@gmail.com>
 <ZTtOz8mr1ENl0i9q@infradead.org>
 <CAOQ4uxjbXhXZmCLTJcXopQikYZg+XxSDa0Of90MBRgRbW5Bhxg@mail.gmail.com>
 <ZTtTy0wITtw2W2vU@infradead.org>
 <CAOQ4uxigdYYCWopKjonxww-be9Rxv9H3_KfcMe3SktXAKoXq4g@mail.gmail.com>
 <ZTtnFe2W9vB04z46@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTtnFe2W9vB04z46@infradead.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,fb.com,toxicpanda.com,suse.com,vger.kernel.org]

On Fri 27-10-23 00:30:29, Christoph Hellwig wrote:
> On Fri, Oct 27, 2023 at 09:33:19AM +0300, Amir Goldstein wrote:
> > OK. You are blaming me for attempting to sneak in a broken feature
> > and I have blamed you for trying take my patches hostage to
> > promote your agenda.
> 
> I'm not blaming you for anything.  But I absolutely reject spreading
> this broken behavior to core.  That's why there is hard NAK on this
> patchs. 
> 
> > 
> > If that is the case, fanotify will need to continue reporting the fsid's
> > exactly as the user observes them on the legacy btrfs filesystems.
> > The v2 patches I posted are required to make that possible.
> 
> The point is tht you simply can't use fanotify on a btrfs file system
> with the broken behavior.  That's what btrfs gets for doing this
> broken behavior to start with.

Well, fanotify was never disabled on btrfs and presumably there are users.
What we blocked (exactly out of caution to not spread questionable
behavior) is placing of marks using a path whose fsid (from statfs(2)) is
different from filesystem root fsid when using FID-mode fanotify group
(i.e. groups where we report fsid + fhandle for each event instead of open
file descriptor). So effectively people currently cannot place marks on
non-root subvolume paths of btrfs for such fanotify groups.

Now given it is uncertain how exactly will filesystems end up presenting
subvolumes to VFS (and consequently to userspace) I agree it is probably
premature to allow placing superblock or mount marks on such paths because
the meaning could change when btrfs changes its presentation and we'd be
just adding ourselves more headaches with backward compatibility for no
great reasons. But so far I see no good reason to keep forbidding adding
inode marks on such paths as Amir suggests. I'll think about that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

