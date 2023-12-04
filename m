Return-Path: <linux-fsdevel+bounces-4806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E02A8041C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 23:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9491C201EE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 22:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB60935EEF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="daRBJWO3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="avN6osno"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74023AA;
	Mon,  4 Dec 2023 13:03:02 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 180EC1FE74;
	Mon,  4 Dec 2023 21:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701723781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsLwsNtdkmuucbEXjp6pw6Bn1D5j+2R8zGQA6GECR0E=;
	b=daRBJWO3vYwZ6bUHeXjchBwDfoFKol485mlEEotYe5jiv+GYXGa+jFjwM/QdqoYL6PP4J7
	j71nhukZbwvvL35g3EU+/qTDV1zYEQRu4AlseXW+mMLz28i6+SffK5kpp0UMvVCls3ubpE
	fsP0Tk9USLikUPHArNrEisc3mG/NnZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701723781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsLwsNtdkmuucbEXjp6pw6Bn1D5j+2R8zGQA6GECR0E=;
	b=avN6osnos0oqLj4oZ4HPLPf2rCPw0HDNqKEOVfdX2ZSOnhzx/GV5j/W3L5+GeFktGOvaI9
	iHKybsb4kVApq7CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 924971398A;
	Mon,  4 Dec 2023 21:02:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R7dBEIA+bmUAUgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Dec 2023 21:02:56 +0000
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
In-reply-to: <e9a1cfed-42e9-4174-bbb3-1a3680cf6a5c@kernel.dk>
References: <20231204014042.6754-1-neilb@suse.de>,
 <20231204014042.6754-2-neilb@suse.de>,
 <e9a1cfed-42e9-4174-bbb3-1a3680cf6a5c@kernel.dk>
Date: Tue, 05 Dec 2023 08:02:53 +1100
Message-id: <170172377302.7109.11739406555273171485@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.10
X-Spamd-Result: default: False [-4.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Mon, 04 Dec 2023, Jens Axboe wrote:
> On 12/3/23 6:36 PM, NeilBrown wrote:
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index e157efc54023..46d640b70ca9 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -1328,7 +1328,7 @@ static void mntput_no_expire(struct mount *mnt)
> >  
> >  	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
> >  		struct task_struct *task = current;
> > -		if (likely(!(task->flags & PF_KTHREAD))) {
> > +		if (likely((task->flags & PF_RUNS_TASK_WORK))) {
> 
> Extraneous parens here.

Thanks - and thanks to Matthew Wilcox too.   Fixed.

> 
> > diff --git a/kernel/task_work.c b/kernel/task_work.c
> > index 95a7e1b7f1da..aec19876e121 100644
> > --- a/kernel/task_work.c
> > +++ b/kernel/task_work.c
> > @@ -183,3 +183,4 @@ void task_work_run(void)
> >  		} while (work);
> >  	}
> >  }
> > +EXPORT_SYMBOL(task_work_run);
> 
> If we're exporting this, then I think that function needs a big
> disclaimer on exactly when it is safe to call it. And it most certainly
> needs to be a _GPL export.

I've added

 * Can be used by a kernel thread but only when no locks are held and the
 * thread won't be waited for by other code that might hold locks.  It
 * can be useful in the top-level loop of a file-serving thread to ensure
 * files get closed promptly.

to the documentation comment.
It isn't clear to me what _GPL is appropriate, but maybe the rules
changed since last I looked..... are there rules?

My reasoning was that the call is effectively part of the user-space
ABI.  A user-space process can call this trivially by invoking any
system call.  The user-space ABI is explicitly a boundary which the GPL
does not cross.  So it doesn't seem appropriate to prevent non-GPL
kernel code from doing something that non-GPL user-space code can
trivially do.

But if there are other strong opinions, or clearly documented rules that
contradict my opinion, I have not problem with adding _GPL.

Thanks,
NeilBrown


> 
> -- 
> Jens Axboe
> 
> 


