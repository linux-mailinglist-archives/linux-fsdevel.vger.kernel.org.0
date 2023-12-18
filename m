Return-Path: <linux-fsdevel+bounces-6363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4DF8173AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 15:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0583B1C231F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056E41E52B;
	Mon, 18 Dec 2023 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sGjEXgje";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tugaPgq8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sGjEXgje";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tugaPgq8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED29372
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Dec 2023 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B16E21ED0;
	Mon, 18 Dec 2023 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702910105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bMuh5jcpFoinSzkEI75kWe1GPCwnkEadbozfpX3LTE=;
	b=sGjEXgjeoL1BOT9A624a2Q58uiTuPgf3t9Ybeax21QnzFGsq3yepihNwI5Jd7F1mkUHPPi
	xtat0qumD21025Xkcr3cNHFaGZTNUd3CtVbssOb2z8Q/JGUqFFocvsBSatMsBnwYtw5b4/
	30Scps+rZO6HKBaQJCZ1TSl19bXwTJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702910105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bMuh5jcpFoinSzkEI75kWe1GPCwnkEadbozfpX3LTE=;
	b=tugaPgq8uKUEMjvDOP2Afhl8HD0xrBg7cfyUbYLr+raYfWWQZibGIvnzG2k2Yacfg0sbJU
	BK/rhp5V2pq+esDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702910105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bMuh5jcpFoinSzkEI75kWe1GPCwnkEadbozfpX3LTE=;
	b=sGjEXgjeoL1BOT9A624a2Q58uiTuPgf3t9Ybeax21QnzFGsq3yepihNwI5Jd7F1mkUHPPi
	xtat0qumD21025Xkcr3cNHFaGZTNUd3CtVbssOb2z8Q/JGUqFFocvsBSatMsBnwYtw5b4/
	30Scps+rZO6HKBaQJCZ1TSl19bXwTJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702910105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bMuh5jcpFoinSzkEI75kWe1GPCwnkEadbozfpX3LTE=;
	b=tugaPgq8uKUEMjvDOP2Afhl8HD0xrBg7cfyUbYLr+raYfWWQZibGIvnzG2k2Yacfg0sbJU
	BK/rhp5V2pq+esDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E02613927;
	Mon, 18 Dec 2023 14:35:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id TxEwC5lYgGUSbwAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 18 Dec 2023 14:35:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B5359A07E0; Mon, 18 Dec 2023 15:35:04 +0100 (CET)
Date: Mon, 18 Dec 2023 15:35:04 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] fanotify: allow to set errno in FAN_DENY permission
 response
Message-ID: <20231218143504.abj3h6vxtwlwsozx@quack3>
References: <20231208080135.4089880-1-amir73il@gmail.com>
 <20231213172844.ygjbkyl6i4gj52lt@quack3>
 <CAOQ4uxjMv_3g1XSp41M7eV+Tr+6R2QK0kCY=+AuaMCaGj0nuJA@mail.gmail.com>
 <20231215153108.GC683314@perftesting>
 <CAOQ4uxjVuhznNZitsjzDCanqtNrHvFN7Rx4dhUEPeFxsM+S22A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjVuhznNZitsjzDCanqtNrHvFN7Rx4dhUEPeFxsM+S22A@mail.gmail.com>
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sGjEXgje;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tugaPgq8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,suse.com:email,suse.cz:dkim,suse.cz:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 3B16E21ED0
X-Spam-Flag: NO

On Fri 15-12-23 18:50:39, Amir Goldstein wrote:
> On Fri, Dec 15, 2023 at 5:31 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Wed, Dec 13, 2023 at 09:09:30PM +0200, Amir Goldstein wrote:
> > > On Wed, Dec 13, 2023 at 7:28 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Fri 08-12-23 10:01:35, Amir Goldstein wrote:
> > > > > With FAN_DENY response, user trying to perform the filesystem operation
> > > > > gets an error with errno set to EPERM.
> > > > >
> > > > > It is useful for hierarchical storage management (HSM) service to be able
> > > > > to deny access for reasons more diverse than EPERM, for example EAGAIN,
> > > > > if HSM could retry the operation later.
> > > > >
> > > > > Allow userspace to response to permission events with the response value
> > > > > FAN_DENY_ERRNO(errno), instead of FAN_DENY to return a custom error.
> > > > >
> > > > > The change in fanotify_response is backward compatible, because errno is
> > > > > written in the high 8 bits of the 32bit response field and old kernels
> > > > > reject respose value with high bits set.
> > > > >
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > So a couple of comments that spring to my mind when I'm looking into this
> > > > now (partly maybe due to my weak memory ;):
> > > >
> > > > 1) Do we still need the EAGAIN return? I think we have mostly dealt with
> > > > freezing deadlocks in another way, didn't we?
> > >
> > > I was thinking about EAGAIN on account of the HSM not being able to
> > > download the file ATM.
> > >
> > > There are a bunch of error codes that are typical for network filesystems, e.g.
> > > ETIMEDOUT, ENOTCONN, ECONNRESET which could be relevant to
> > > HSM failures.
> > >
> > > >
> > > > 2) If answer to 1) is yes, then there is a second question - do we expect
> > > > the errors to propagate back to the unsuspecting application doing say
> > > > read(2) syscall? Because I don't think that will fly well with a big
> > > > majority of applications which basically treat *any* error from read(2) as
> > > > fatal. This is also related to your question about standard permission
> > > > events. Consumers of these error numbers are going to be random
> > > > applications and I see a potential for rather big confusion arising there
> > > > (like read(1) returning EINVAL or EBADF and now you wonder why the hell
> > > > until you go debug the kernel and find out the error is coming out of
> > > > fanotify handler). And the usecase is not quite clear to me for ordinary
> > > > fanotify permission events (while I have no doubts about creativity of
> > > > implementors of fanotify handlers ;)).
> > > >
> > >
> > > That's a good question.
> > > I prefer to delegate your question to the prospect users of the feature.
> > >
> > > Josef, which errors did your use case need this feature for?
> > >
> > > > 3) Given the potential for confusion, maybe we should stay conservative and
> > > > only allow additional EAGAIN error instead of arbitrary errno if we need it?
> > > >
> > >
> > > I know I was planning to use this for EDQUOT error (from FAN_PRE_MODIFY),
> > > but I certainly wouldn't mind restricting the set of custom errors.
> > > I think it makes sense. The hard part is to agree on this set of errors.
> > >
> >
> > I'm all for flexibility here.
> >
> > We're going to have 2 classes of applications interacting with HSM backed
> > storage, normal applications and applications that know they're backed by HSM.
> > The normal applications are just going to crash if they get an error on read(2),
> > it doesn't matter what errno it is.  The second class would have different
> > things they'd want to do in the face of different errors, and that's what this
> > patchset is targeting.  We can limit it to a few errno's if that makes you feel
> > better, but having more than just one would be helpful.
> 
> Ok. In another email I got from your colleagues, they listed:
> EIO, EAGAIN, ENOSPC as possible errors to return.
> I added EDQUOT for our in house use case.

OK, so do I get it right that you also have applications that are aware
that they are operation on top of HSM managed filesystem and thus they can
do meaningful things with the reported errors?

> Those are all valid errors for write(2) and some are valid for read(2).
> ENOSPC/EDQUOT make a lot of sense for HSM for read(2), but could
> be surprising to applications not aware of HSM.
> I think it wouldn't be that bad if we let HSM decide which of those errors
> to return for FAN_PRE_ACCESS as opposed to FAN_PRE_MODIFY.

Yeah, I don't think we need to be super-restrictive here, I'd just prefer
to avoid the "whatever number you decide to return" kind of interface
because I can see potential for confusion and abuse there. I think all four
errors above are perfectly fine for both FAN_PRE_ACCESS and FAN_PRE_MODIFY
if there are consumers that are able to use them.
 
> But given that we do want to limit the chance of abusing this feature,
> perhaps it would be best to limit the error codes to known error codes
> for write(2) IO failures (i.e. not EBADF, not EFAULT) and allow returning
> FAN_DENY_ERRNO only for the new FAN_PRE_{ACCESS,MODIFY}
> HSM events.
> 
> IOW, FAN_{OPEN,ACCESS}_PERM - no FAN_DENY_ERRNO for you!
> 
> Does that sound good to you?

It sounds OK to me. I'm open to allowing FAN_DENY_ERRNO for FAN_OPEN_PERM
if there's a usecase because at least conceptually it makes a good sense
and chances for confusion are low there. People are used to dealing with
errors on open(2).

> Furthermore, we can start with allowing a very limited set of errors
> and extend it in the future, on case by case basis.
> 
> The way that this could be manageable is if we provide userspace
> a way to test for supported return codes.
> 
> There is already a simple method that we used for testing FAN_INFO
> records type support -
> After fan_fd = fanotify_init(), userspace can write a "test" fanotify_response
> to fan_fd with fanotify_response.fd=FAN_NOFD.
> 
> When setting fanotify_response.fd=FAN_DENY, this would return ENOENT,
> but with fanotify_response.fd=FAN_DENY_ERRNO(EIO), upstream would
> return EINVAL.
> 
> This opens the possibility of allowing, say, EIO, EAGAIN in the first release
> and ENOSPC, EDQUOT in the following release.

If we forsee that ENOSPC and EDQUOT will be needed, then we can just enable
it from start and not complicate our lives more than necessary.

> The advantage in this method is that it is very simple and already working
> correctly for old kernels.
> 
> The downside is that this simple method does not allow checking for
> allowed errors per specific event type, so if we decide that we do want
> to allow returning FAN_DENY_ERRNO for FAN_OPEN_PERM later on, this method
> could not be used by userspace to test for this finer grained support.

True, in that case the HSM manager would have to try responding with
FAN_DENY_ERRNO() and if it fails, it will have to fallback to responding
with FAN_DENY. Not too bad I'd say.

> In another thread, I mention the fact that FAN_OPEN_PERM still has a
> potential freeze deadlock when called from open(O_TRUNC|O_CREATE),
> so we can consider the fact that FAN_DENY_ERRNO is not allowed with
> FAN_OPEN_PERM as a negative incentive for people to consider using
> FAN_OPEN_PERM as a trigger for HSM.

AFAIU from the past discussions, there's no good use of FAN_OPEN_PERM
event for HSM. If that's the case, I'm for not allowing FAN_DENY_ERRNO for
FAN_OPEN_PERM.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

