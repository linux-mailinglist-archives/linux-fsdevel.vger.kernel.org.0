Return-Path: <linux-fsdevel+bounces-29531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15A097A85B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 22:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E641F2906C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 20:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9443515D5CA;
	Mon, 16 Sep 2024 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y0tgWXZA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YxROLVoM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y0tgWXZA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YxROLVoM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA3112CD96;
	Mon, 16 Sep 2024 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726519067; cv=none; b=LBo1MHYQOGsa+KHMyITPXc87mosakYbFrmgAlnSiXyScCMlQt5GQprmxAiMRvyLZHuC2V5Yw4N0z8Gsm9EdX2BdCi9XymX9VQJZScMqoiyvZPLOfbgcE4J39PW2a2ssf9LyDva8EA70emQ+qS3ins4tgrOEPn/c5t9NFcCb2Lo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726519067; c=relaxed/simple;
	bh=nbnZwalp4eyEfRfs4s0z9PKEAZqUlo6DH+zLXqfT+Po=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=gkSjAZg8QWcGQvlslsTn5QbNLxwav2z12mglTKr/wQWzg6eyKxMo0FFdSNg29BWhroNZ7TJNKAW5cxiCQd7n7rzUYWuFBvy7tFO4xTCIbCyv7jT9sqWn9gmbOKnxj1V6QC3P72OqaA9xdc4TeDZWLue4jgF3loBs1PbP/SFdqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y0tgWXZA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YxROLVoM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y0tgWXZA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YxROLVoM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 536BA1FD7D;
	Mon, 16 Sep 2024 20:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726519063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zAjemUAAhH9Xt5N1UkfUiSQVfRLpxsHJe3r8V+akKmM=;
	b=Y0tgWXZAtq1KB52O4djynI/CMZm4y2L0l1xHBVeMRDMaLvLEPLc+x4GCGEsnqn2FI5HjqS
	I12cVLmFUIbWwhqXkbyN8Mhkz+Z9V8ebGF0OSgGzWbcYwJSQxVxEch23fT1WrWqk2XtYJJ
	49MgNVWg8ehRQM6HhZS5vz+QeRvCGds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726519063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zAjemUAAhH9Xt5N1UkfUiSQVfRLpxsHJe3r8V+akKmM=;
	b=YxROLVoMw3ATr6FdEwSQCEOutZisms6HFi0H7AtPDEzEYTJygyRbypyB8eArrytdzAkH6u
	M/WE81+bUPy4sLCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Y0tgWXZA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YxROLVoM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726519063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zAjemUAAhH9Xt5N1UkfUiSQVfRLpxsHJe3r8V+akKmM=;
	b=Y0tgWXZAtq1KB52O4djynI/CMZm4y2L0l1xHBVeMRDMaLvLEPLc+x4GCGEsnqn2FI5HjqS
	I12cVLmFUIbWwhqXkbyN8Mhkz+Z9V8ebGF0OSgGzWbcYwJSQxVxEch23fT1WrWqk2XtYJJ
	49MgNVWg8ehRQM6HhZS5vz+QeRvCGds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726519063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zAjemUAAhH9Xt5N1UkfUiSQVfRLpxsHJe3r8V+akKmM=;
	b=YxROLVoMw3ATr6FdEwSQCEOutZisms6HFi0H7AtPDEzEYTJygyRbypyB8eArrytdzAkH6u
	M/WE81+bUPy4sLCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8C0913A3A;
	Mon, 16 Sep 2024 20:37:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t1LfJhSX6GZTHgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 16 Sep 2024 20:37:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Peter Zijlstra" <peterz@infradead.org>
Cc: "Ingo Molnar" <mingo@redhat.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jens Axboe" <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/7] sched: change wake_up_bit() and related function to
 expect unsigned long *
In-reply-to: <20240916181817.GF4723@noisy.programming.kicks-ass.net>
References: <>, <20240916181817.GF4723@noisy.programming.kicks-ass.net>
Date: Tue, 17 Sep 2024 06:37:33 +1000
Message-id: <172651905368.17050.16487291202431244979@noble.neil.brown.name>
X-Rspamd-Queue-Id: 536BA1FD7D
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 17 Sep 2024, Peter Zijlstra wrote:
> On Mon, Sep 16, 2024 at 09:48:11PM +1000, NeilBrown wrote:
> > On Mon, 16 Sep 2024, Peter Zijlstra wrote:
> > > On Mon, Aug 26, 2024 at 04:30:59PM +1000, NeilBrown wrote:
> > > > wake_up_bit() currently allows a "void *".  While this isn't strictly=
 a
> > > > problem as the address is never dereferenced, it is inconsistent with
> > > > the corresponding wait_var_event() which requires "unsigned long *" a=
nd
> > > > does dereference the pointer.
> > >=20
> > > I'm having trouble parsing this. The way I read it, you're contradicting
> > > yourself. Where does wait_var_event() require 'unsigned long *' ?
> >=20
> > Sorry, that is meant so as "the corresponding wait_on_bit()".
> >=20
> >=20
> > >=20
> > > > And code that needs to wait for a change in something other than an
> > > > unsigned long would be better served by wake_up_var().
> > >=20
> > > This, afaict the whole var thing is size invariant. It only cares about
> > > the address.
> > >=20
> >=20
> > Again - wake_up_bit().  Sorry - bits are vars were swimming around my
> > brain and I didn't proof-read properly.
> >=20
> > This patch is all "bit", no "var".
>=20
> OK :-)
>=20
> Anyway, other than that the patches look fine, but given we're somewhat
> in the middle of the merge window and all traveling to get into Vienna
> and have a few beers, I would much prefer merging these patches after
> -rc1, that okay?
>=20

Yes, that's OK.  Thanks for having a look.  Have fun in Vienna.

NeilBrown

