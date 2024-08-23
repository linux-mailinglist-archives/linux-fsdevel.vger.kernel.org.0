Return-Path: <linux-fsdevel+bounces-26870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CADB95C47E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 07:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F24C1C21D93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 05:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84242482FA;
	Fri, 23 Aug 2024 05:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h9hVvSIa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qmgo2PBQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h9hVvSIa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qmgo2PBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F6B24B29
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 05:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724389304; cv=none; b=KoW24KkIVmbeIKU/e5EZBriccr/brrwJDQGRNg/+AbLfxzy+jl8w6YaVRWuCYMcFjKCt9VWbowPTtq9X70iUABcJBz622OfXY/N74dYlQIRWy9N0XSzqTy6bz6MMtCgi5n+fmVu+TqwWDL+uOSIYO4b+ijf2AyRUMHZiZ8+H9Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724389304; c=relaxed/simple;
	bh=8RPXiWS8FmJ59ndKTbbeQXGAzOtvn9/iys3RAh/WtTo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=oa8e+u/vM4XF6sZRUHctmxC88q0TIpKDWknxaNh+QbS2s07KWTUTaObsbN+SMRLF1Qpxq3ncC4CofKoIKyBFqPQvZocC0PFuvKVGLP6vV/6hdM6Ho2aNEAfDHvejdOgSm2OZXGzab9owTSB4jWgSWmei6Ivj+OaaH+c2pp27SrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h9hVvSIa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qmgo2PBQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h9hVvSIa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qmgo2PBQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEF8E22604;
	Fri, 23 Aug 2024 05:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724389300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEIOB0wbXhc4isxBtBrI9AIDf+LjBN4kOtUD12NOsfA=;
	b=h9hVvSIaj1SHuyCYHPfXQm5pf7WFoJzSXOxzGC5ifEdr2Ydpa/6p3vtoEcjbOnpGp2Kl2C
	V7SERYA8hl1MIxrk4Kxbt7jQ/19dmWFWHXf9Q9D5MjETqXokpNh1jo4nSH9AruksRWdrOm
	YSa7WnxYWtwGLEcfu+y3Mnbf//kbMB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724389300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEIOB0wbXhc4isxBtBrI9AIDf+LjBN4kOtUD12NOsfA=;
	b=qmgo2PBQ047VCH7DjTASeaKst6KOX+M9W677IIqznJin+7uWjqbUvDggjCOFOCSwJ/L+O1
	O4K7Cf22Z5u2llDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=h9hVvSIa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qmgo2PBQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724389300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEIOB0wbXhc4isxBtBrI9AIDf+LjBN4kOtUD12NOsfA=;
	b=h9hVvSIaj1SHuyCYHPfXQm5pf7WFoJzSXOxzGC5ifEdr2Ydpa/6p3vtoEcjbOnpGp2Kl2C
	V7SERYA8hl1MIxrk4Kxbt7jQ/19dmWFWHXf9Q9D5MjETqXokpNh1jo4nSH9AruksRWdrOm
	YSa7WnxYWtwGLEcfu+y3Mnbf//kbMB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724389300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEIOB0wbXhc4isxBtBrI9AIDf+LjBN4kOtUD12NOsfA=;
	b=qmgo2PBQ047VCH7DjTASeaKst6KOX+M9W677IIqznJin+7uWjqbUvDggjCOFOCSwJ/L+O1
	O4K7Cf22Z5u2llDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 563D71333E;
	Fri, 23 Aug 2024 05:01:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bm4wA7IXyGaZUAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 23 Aug 2024 05:01:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/6] fs: add i_state helpers
In-reply-to:
 <CAHk-=wjTYN4tr9cjc2ROA1AJP5LzMh6OoNAz8pVSUMP0Kd7AFA@mail.gmail.com>
References:
 <>, <CAHk-=wjTYN4tr9cjc2ROA1AJP5LzMh6OoNAz8pVSUMP0Kd7AFA@mail.gmail.com>
Date: Fri, 23 Aug 2024 15:01:30 +1000
Message-id: <172438929098.6062.14613506152730044796@noble.neil.brown.name>
X-Rspamd-Queue-Id: BEF8E22604
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 23 Aug 2024, Linus Torvalds wrote:
> On Fri, 23 Aug 2024 at 08:14, NeilBrown <neilb@suse.de> wrote:
> >
> > Maybe inode_wake_up_bit() should not have a barrier and the various
> > callers should add whichever barrier is appropriate.  That is the model
> > that Linus prefers for wake_up_bit() and for consistency it should apply
> > to inode_wake_up_bit() too.
> 
> I think that for the wake_up_bit() cases in particular, it's fairly
> easy to add whatever "clear_and_wakeup()" helpers. After all, there's
> only so much you can do to one bit, and I think merging the "act" with
> the "wakeup" into one routine is not only going to help fix the memory
> ordering problem, I think it's going to result in more readable code
> even aside from any memory ordering issues.

That patterns that don't easily fit a helper include:

  - skipping the wake_up when there is no hurry.
    nfs_page_clear_headlock() does this is PG_CONTENDED1
    isn't set.  intel_recv_event() does something very similar
    if STATE_FIRMWARE_LOADED isn't set.
    I imagine changing these to
         if (need a wakeup)
             clear_bit_and_wakeup(...)
         else
             clear_bit()
    rpc_make_runnable() has three case and maybe each would need
    a separate clear_bit in order to have a clear_bit adjacent to
    the wake_up().  That might actually be a good thing, I haven't
    really tried yet.

  - key_reject_and_link() separate the test_and_clear from the
    wake_up_bit() for reasons that aren't completely obvious to me.
    __key_instantiate_and_link() does the same.
    Maybe they just move the wake_up outside the mutex....

> 
> The wake_up_var() infrastructure that the inode code uses is a bit
> more involved. Not only can the variable be anything at all (so the
> operations you can do on it are obviously largely unbounded), but the
> inode hack in particular then uses one thing for the actual variable,
> and another thing for the address that is used to match up waits and
> wakeups.
> 
> So I suspect the inode code will have to do its thing explcitly with
> the low-level helpers and deal with the memory ordering issues on its
> own, adding the smp_mb() manually.

The problem here is that "wake_up_var()" doesn't *look* like a
low-level helper.  Maybe we could replace the few remaining instances
with __wake_up_var() once the easy cases are fixed??

Thanks,
NeilBrown

