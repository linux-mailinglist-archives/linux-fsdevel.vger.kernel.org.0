Return-Path: <linux-fsdevel+bounces-28739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9742196DADB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 15:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B390A1C23A50
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D57119DF79;
	Thu,  5 Sep 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d7Ur3DIo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kdOi11Sd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d7Ur3DIo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kdOi11Sd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001A419DF53;
	Thu,  5 Sep 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544440; cv=none; b=r9j160n3+0+dfQBCkbiDS/xlixsRoS+fVciYxtEJCw/6aAIurkqOQfH2YpDq2uZiuD4TAqjQUnmSIbSLoKoh6QgD2ElfVwupOQS+++snJC6UwzWooQWNOBr2Ivr39V8qKNM2m/Okc3Cy7Vlf7+fr1+6J8AAHBKHObjKArG7BXlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544440; c=relaxed/simple;
	bh=M45oi9J1dfDhftJaPMR7wqGDOQwsATiVb4pa/hy99zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcMMAy4gPXpiuhskf6F1cyWU5UyK3wmJvuAxaODEeCwVuKEBJ8dkYzlH1C6S8WCCDZbqxeRq5u1iXsfv8hOP4D37JgYWjj4ElAaiWLXA2yv5qYWHtyWs7FTHBlzeeFrNixOnE//kHU5n6R7v+XVRqgyKi+/T/K9Danrs6V2kkJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d7Ur3DIo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kdOi11Sd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d7Ur3DIo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kdOi11Sd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D7BB1F7D4;
	Thu,  5 Sep 2024 13:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725544437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=32xq7BN0U/AcKst9Zm4gHcrxMPt0DWtteNkUdQFWdqU=;
	b=d7Ur3DIoy5/tdxlhh2Eu7oqe51PTPhwi+LmkavWkAecY3rRub/QWQLQNSxKACCrZzxKgll
	6YPE95jsRh/aAaY/3Fg06Na5p1XkEhhpvDQRYM7anJoBCJZi2nqkxJVzqzzZDR+4eCxkel
	rfgKwFbew7XOs+ScWMawGNeNAnXjXnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725544437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=32xq7BN0U/AcKst9Zm4gHcrxMPt0DWtteNkUdQFWdqU=;
	b=kdOi11SdB4dd4VC2V2r4e4NKRLpQdMFC0LPJ0b1v4yjYZndVOHMujmCJ01s6+4/QC2jVUt
	qSGyH+dP2EJH/BDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=d7Ur3DIo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kdOi11Sd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725544437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=32xq7BN0U/AcKst9Zm4gHcrxMPt0DWtteNkUdQFWdqU=;
	b=d7Ur3DIoy5/tdxlhh2Eu7oqe51PTPhwi+LmkavWkAecY3rRub/QWQLQNSxKACCrZzxKgll
	6YPE95jsRh/aAaY/3Fg06Na5p1XkEhhpvDQRYM7anJoBCJZi2nqkxJVzqzzZDR+4eCxkel
	rfgKwFbew7XOs+ScWMawGNeNAnXjXnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725544437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=32xq7BN0U/AcKst9Zm4gHcrxMPt0DWtteNkUdQFWdqU=;
	b=kdOi11SdB4dd4VC2V2r4e4NKRLpQdMFC0LPJ0b1v4yjYZndVOHMujmCJ01s6+4/QC2jVUt
	qSGyH+dP2EJH/BDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10BF713419;
	Thu,  5 Sep 2024 13:53:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9YcOBPW32WaiDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Sep 2024 13:53:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 94ECBA0968; Thu,  5 Sep 2024 15:53:52 +0200 (CEST)
Date: Thu, 5 Sep 2024 15:53:52 +0200
From: Jan Kara <jack@suse.cz>
To: Jon Kohler <jon@nutanix.com>
Cc: Jan Kara <jack@suse.cz>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
	"josh@joshtriplett.org" <josh@joshtriplett.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: SRCU hung task on 5.10.y on synchronize_srcu(&fsnotify_mark_srcu)
Message-ID: <20240905135352.ooc5lh2zfcizsax6@quack3>
References: <1E829024-48BF-4647-A1DD-AC7E8BFA0FA2@nutanix.com>
 <20240904091912.orpkwemgpsgcongo@quack3>
 <CBB4A7F7-81F0-44E8-96D4-E1035E21BDE1@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CBB4A7F7-81F0-44E8-96D4-E1035E21BDE1@nutanix.com>
X-Rspamd-Queue-Id: 1D7BB1F7D4
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,vger.kernel.org,gmail.com,joshtriplett.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 04-09-24 14:40:07, Jon Kohler wrote:
> 
> 
> > On Sep 4, 2024, at 5:19 AM, Jan Kara <jack@suse.cz> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Tue 27-08-24 20:01:27, Jon Kohler wrote:
> >> Hey Paul, Lai, Josh, and the RCU list and Jan/FS list -
> >> Reaching out about a tricky hung task issue that I'm running into. I've
> >> got a virtualized Linux guest on top of a KVM based platform, running
> >> a 5.10.y based kernel. The issue we're running into is a hung task that
> >> *only* happens on shutdown/reboot of this particular VM once every 
> >> 20-50 times.
> >> 
> >> The signature of the hung task is always similar to the output below,
> >> where we appear to hang on the call to 
> >>    synchronize_srcu(&fsnotify_mark_srcu)
> >> in fsnotify_connector_destroy_workfn / fsnotify_mark_destroy_workfn,
> >> where two kernel threads are both calling synchronize_srcu, then
> >> scheduling out in wait_for_completion, and completely going out to
> >> lunch for over 4 minutes. This then triggers the hung task timeout and
> >> things blow up.
> > 
> > Well, the most obvious reason for this would be that some process is
> > hanging somewhere with fsnotify_mark_srcu held. When this happens, can you
> > trigger sysrq-w in the VM and send here its output?
> 
> Jan - Thanks for the ping, that is *exactly* what is happening here.
> Some developments since my last note, the patch Neeraj pointed out
> wasn't the issue, but rather a confluence of realtime thread configurations
> that ended up completely starving whatever CPU was processing per-CPU
> callbacks. So, one thread would go out to lunch completely, and it would
> just never yield. This particular system was configured with RT_RUNTIME_SHARE
> unfortunately, so that realtime thread going out to lunch ate the entire system.

Glad to hear this is explained (at least partially) :)

> What was odd is that this never, ever happened during runtime on some
> of these systems that have been up for years and getting beat up heavily,
> but rather only on shutdown. We’ve got more to chase down internally on
> that.
> 
> One thing I wanted to bring up here though while I have you, I have
> noticed through various hits on google, mailing lists, etc over the years that
> this specific type of lockup with fsnotify_mark_srcu seems to happen now
> and then for various oddball reasons, with various root causes. 
> 
> It made me think that I wonder if there is a better structure that could be
> used here that might be a bit more durable. To be clear, I’m not saying that
> SRCU *is not* durable or anything of the sort (I promise!) but rather
> wondering if there was anything we could think about tweaking on the
> fsnotify side of the house to be more efficient.

Well, fsnotify_mark_srcu used to be a big problem in the past where
fanotify code was waiting for userspace response to fanotify event with it
held. And when userspace didn't reply, the kernel got stuck. After we have
removed that sore spot couple years ago, I'm not aware of any more problems
with it. In fact your report is probably the first one in a few years. So
I'm hoping your google hits are mostly from the past / with old kernels :)

								Honza

> >> We are running audit=1 for this system and are using an el8 based
> >> userspace.
> >> 
> >> I've flipped through the fs/notify code base for both 5.10 as well as
> >> upstream mainline to see if something jumped off the page, and I
> >> haven't yet spotted any particular suspect code from the caller side.
> >> 
> >> This hang appears to come up at the very end of the shutdown/reboot
> >> process, seemingly after the system starts to unwind through initrd.
> >> 
> >> What I'm working on now is adding some instrumentation to the dracut
> >> shutdown initrd scripts to see if I can how far we get down that path
> >> before the system fails to make forward progress, which may give some
> >> hints. TBD on that. I've also enabled lockdep with CONFIG_PROVE_RCU and
> >> a plethora of DEBUG options [2], and didn't get anything interesting.
> >> To be clear, we haven't seen lockdep spit out any complaints as of yet.
> > 
> > The fact that lockdep doesn't report anything is interesting but then
> > lockdep doesn't track everything. In particular I think SRCU itself isn't
> > tracked by lockdep.
> > 
> > Honza
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

