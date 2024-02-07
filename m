Return-Path: <linux-fsdevel+bounces-10592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7104C84C8E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 11:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC6C6B229E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 10:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD66168B1;
	Wed,  7 Feb 2024 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VSE8d5DD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lx225Vm5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VSE8d5DD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lx225Vm5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8514AB0
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302680; cv=none; b=FsZA8eQtt8epvTjE9EK5ktobIJs4g5tNbGJCSGc4aTqURx5LA5OufSjQ85dLpxywNirUP7y2HVes7pW/lcjgYi9fDg5SrzD34bvgW+aGAkNfB7y19z6l54i9EnGGjL9u/ZrEKc2B0G0i01WXHdEJ2ea/wZkcx+V4csTOo7+NElE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302680; c=relaxed/simple;
	bh=nazHQlpQrhv16bQ7yxUpZJ8uIf1n4UP8VEMsII3IOV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qdcjd7p5/4b9ShivsRPjR3M8JAHVGzkisP0brGVpyaXpJSXYiO8Dx9CrEcw9ztgotEzR8aJbZjQA+Ns5FJrUDpBwenshxkReg7EYQiB8ElW1eUnCZSp2eHPilKVeMaMqbvgQO4j1lqnxfz4hxrVztTu5GNYYxvZdx5JCESmuIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VSE8d5DD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lx225Vm5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VSE8d5DD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lx225Vm5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 19237221C8;
	Wed,  7 Feb 2024 10:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707302677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bquZc0hGZhNH1g3mvUm/XlxciSLDiEFFXRru6UpQM2Y=;
	b=VSE8d5DD0E6pRRd7ZqnA21bCR+QMWoXJRFud9FzapmSLKU03NNzN3w1z4eugi0esmfVc5Y
	6w7WNPbbrcwKqmBAY7Cet4Z19UtzXoLdyQin/PmKLjs719mFcMLLMe70NoCPy3rwjLtBi7
	b6cgPXi5GJp8IrqKpjfqCczYIW+d0cQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707302677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bquZc0hGZhNH1g3mvUm/XlxciSLDiEFFXRru6UpQM2Y=;
	b=Lx225Vm5Z8GlRNvtyvVFnnifCY1DLpNMr1RqWX1ZbckYl1U/QPaj1P3APXRU37Zyhs6vxF
	TQozvPmFmMFPuaCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707302677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bquZc0hGZhNH1g3mvUm/XlxciSLDiEFFXRru6UpQM2Y=;
	b=VSE8d5DD0E6pRRd7ZqnA21bCR+QMWoXJRFud9FzapmSLKU03NNzN3w1z4eugi0esmfVc5Y
	6w7WNPbbrcwKqmBAY7Cet4Z19UtzXoLdyQin/PmKLjs719mFcMLLMe70NoCPy3rwjLtBi7
	b6cgPXi5GJp8IrqKpjfqCczYIW+d0cQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707302677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bquZc0hGZhNH1g3mvUm/XlxciSLDiEFFXRru6UpQM2Y=;
	b=Lx225Vm5Z8GlRNvtyvVFnnifCY1DLpNMr1RqWX1ZbckYl1U/QPaj1P3APXRU37Zyhs6vxF
	TQozvPmFmMFPuaCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AD7013A41;
	Wed,  7 Feb 2024 10:44:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id khKiAhVfw2X+ZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Feb 2024 10:44:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ACE28A0809; Wed,  7 Feb 2024 11:44:36 +0100 (CET)
Date: Wed, 7 Feb 2024 11:44:36 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Sargun Dhillon <sargun@sargun.me>, Jan Kara <jack@suse.cz>,
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
	Sweet Tea Dorminy <thesweettea@meta.com>
Subject: Re: Fanotify: concurrent work and handling files being executed
Message-ID: <20240207104436.q7c4s4b53sal2d4q@quack3>
References: <CAMp4zn8aXNPzq1i8KYmbRfwDBvO5Qefa4isSyS1bwYuvkuBsHg@mail.gmail.com>
 <CAOQ4uxgPY_6oKZFmWitJ-FTuV1YUWHMcNqppiCiMMk46aURMUA@mail.gmail.com>
 <20240206135028.q56y6stckqnfwlbg@quack3>
 <CAMp4zn_EtdB2XHsWtNQ72hzruRFGCCCYc7vaRV8W-K7W4v61uw@mail.gmail.com>
 <CAOQ4uxhuPBWD=TYZw974NsKFno-iNYSkHPw6WTfG_69ovS=nJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhuPBWD=TYZw974NsKFno-iNYSkHPw6WTfG_69ovS=nJA@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_ALL(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue 06-02-24 18:44:47, Amir Goldstein wrote:
> On Tue, Feb 6, 2024 at 6:30 PM Sargun Dhillon <sargun@sargun.me> wrote:
> >
> > On Tue, Feb 6, 2024 at 6:50 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 06-02-24 09:44:29, Amir Goldstein wrote:
> > > > On Tue, Feb 6, 2024 at 1:24 AM Sargun Dhillon <sargun@sargun.me> wrote:
> > > > >
> > > > > One of the issues we've hit recently while using fanotify in an HSM is
> > > > > racing with files that are opened for execution.
> > > > >
> > > > > There is a race that can result in ETXTBUSY.
> > > > > Pid 1: You have a file marked with FAN_OPEN_EXEC_PERM.
> > > > > Pid 2: execve(file_by_path)
> > > > > Pid 1: gets notification, with file.fd
> > > > > Pid 2: blocked, waiting for notification to resolve
> > > > > Pid 1: Does work with FD (populates the file)
> > > > > Pid 1: writes FAN_ALLOW to the fanotify file descriptor allowing the event.
> > > > > Pid 2: continues, and falls through to deny_write_access (and fails)
> > > > > Pid 1: closes fd
> > >
> > > Right, this is kind of nasty.
> > >
> > > > > Pid 1 can close the FD before responding, but this can result in a
> > > > > race if fanotify is being handled in a multi-threaded
> > > > > manner.
> > >
> > > Yep.
> > >
> > > > > I.e. if there are two threads operating on the same fanotify group,
> > > > > and an event's FD has been closed, that can be reused
> > > > > by another event. This is largely not a problem because the
> > > > > outstanding events are added in a FIFO manner to the outstanding
> > > > > event list, and as long as the earlier event is closed and responded
> > > > > to without interruption, it should be okay, but it's difficult
> > > > > to guarantee that this happens, unless event responses are serialized
> > > > > in some fashion, with strict ordering between
> > > > > responses.
> > >
> > > Yes, essentially you must make sure you will not read any new events from
> > > the notification queue between fd close & writing of the response. Frankly,
> > > I find this as quite ugly and asking for trouble (subtle bugs down the
> > > line).
> > >
> > Is there a preference for either refactoring fanotify_event_metadata, or
> > adding this new ID type as a piece of metadata?
> >
> > I almost feel like the FD should move to being metadata, and we should
> > use ID in place of fd in fanotify_event_metadata. If we use an xarray,
> > it should be reasonable to use a 32-bit identifier, so we don't need
> > to modify the fanotify_event_metadata structure at all.
> 
> I have a strong preference for FANOTIFY_METADATA_VERSION 4
> because I really would like event->key to be 64bit and in the header,
> but I have a feeling that Jan may have a different opinion..

I also think 64-bit ID would be potentially more useful for userspace
(mostly because of guaranteed uniqueness). I'm just still not yet sure how
do you plan to use it for persistent events because there are several
options how to generate the ID. I'd hate to add yet-another-id in the near
future.

Regarding FANOTIFY_METADATA_VERSION 4: What are your reasons to want the ID
in the header? I think we'd need explicit init flag to enable event ID
reporting anyway? But admittedly I can see some appeal of having ID in the
header if we are going to use the ID for matching responses to permission
events.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

