Return-Path: <linux-fsdevel+bounces-4814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03278041CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 23:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B23D28133D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 22:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547493C463
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fW4fGWBh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8xKBkI7z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AACBE;
	Mon,  4 Dec 2023 14:27:33 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 40D9422120;
	Mon,  4 Dec 2023 22:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701728852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+U0veRC3YO68gYCzKjl6VJ3GNpvNjD2lSxDRtZecH0=;
	b=fW4fGWBhERN8cT1gWRFwZlsRIPSI6hqXSE9BBu0NMjfHL3Ns8/Ic8JXlbSfq29ZBH/KiF4
	kUh3WKo4LvHktxkaV1SsjVyg5uhM11aPVCprIjd5sx2cFuPY7TzwPfWXcLWS9DVq9WL/4k
	YjqE5VpZe0IpzF9oSxSWsB3m0k8UrN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701728852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+U0veRC3YO68gYCzKjl6VJ3GNpvNjD2lSxDRtZecH0=;
	b=8xKBkI7zBh+UzVTfgp838Fv5o1jukL3AsNAwNoAz43c0/rws5OQC88UqpS+PXZ03CDeCyQ
	/QSBHx/xW0JZYyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50334139AA;
	Mon,  4 Dec 2023 22:27:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yt2SOU5SbmUEbwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Dec 2023 22:27:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jens Axboe" <axboe@kernel.dk>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Oleg Nesterov" <oleg@redhat.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
 "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH 1/2] Allow a kthread to declare that it calls task_work_run()
In-reply-to: <a070b6bd-0092-405e-99d2-00002596c0bc@kernel.dk>
References: <20231204014042.6754-1-neilb@suse.de>,
 <20231204014042.6754-2-neilb@suse.de>,
 <e9a1cfed-42e9-4174-bbb3-1a3680cf6a5c@kernel.dk>,
 <170172377302.7109.11739406555273171485@noble.neil.brown.name>,
 <a070b6bd-0092-405e-99d2-00002596c0bc@kernel.dk>
Date: Tue, 05 Dec 2023 09:27:19 +1100
Message-id: <170172883971.7109.15813436459590259773@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.996];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[40.27%]
X-Spam-Score: -1.30

On Tue, 05 Dec 2023, Jens Axboe wrote:
> On 12/4/23 2:02 PM, NeilBrown wrote:
> > It isn't clear to me what _GPL is appropriate, but maybe the rules
> > changed since last I looked..... are there rules?
> > 
> > My reasoning was that the call is effectively part of the user-space
> > ABI.  A user-space process can call this trivially by invoking any
> > system call.  The user-space ABI is explicitly a boundary which the GPL
> > does not cross.  So it doesn't seem appropriate to prevent non-GPL
> > kernel code from doing something that non-GPL user-space code can
> > trivially do.
> 
> By that reasoning, basically everything in the kernel should be non-GPL
> marked. And while task_work can get used by the application, it happens
> only indirectly or implicitly. So I don't think this reasoning is sound
> at all, it's not an exported ABI or API by itself.
> 
> For me, the more core of an export it is, the stronger the reason it
> should be GPL. FWIW, I don't think exporting task_work functionality is
> a good idea in the first place, but if there's a strong reason to do so,
> it should most certainly not be accessible to non-GPL modules. Basically
> NO new export should be non-GPL.

An alternate to exporting task_work_run() might be to call it from
try_to_freeze().  I think that too should only be called from a context
where no locks are held etc.  Obviously try_to_freeze would only call
task_work_run() if PF_RUNS_TASK_WORK were set.
I'm not sure this is a *good* idea, but it is an idea that would avoid
the export.

For now I change the export to _GPL.

Thanks,
NeilBrown

