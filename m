Return-Path: <linux-fsdevel+bounces-29607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9231697B55D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 23:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE1A3B22BDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 21:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AB01922F9;
	Tue, 17 Sep 2024 21:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ewz06wkw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QyCWF3SH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ewz06wkw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QyCWF3SH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2980CF510;
	Tue, 17 Sep 2024 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726610058; cv=none; b=m5KcuU1R8bH6jpi3T4giAZTzgTj+WETRZ8GM7lJqFaTO+rER80FQAeCIJsMEhTxqqo3h6bRBnlcGv6AiZhty1WYuhmra+Kf5hed5DfX4hfAOpLAJ/yvCcXAKLerAJuJSW39+FqATYy+qHVZgC7ewSNJQ4/6nnMtBbSQma+9xbUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726610058; c=relaxed/simple;
	bh=hPp59baIO1umS+sO8KbuL90XTx5D2LnUMl+rf4lg+DY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Np6RI6X8fYb4EWMKLn7I30G3l/4KmPzNPHa+3TH1BNA/5N1mVXPprLEfZcLwpJ0aHa6tXrERqqLoBWxqMD1dVPaLC0Rp0LNfjGBdygazCsZFzBFH2hP3tlY+lWzNmPeeV3FWnEuAPnJasoSgbkyNMPVxdcw+JJWA6evttry8YVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ewz06wkw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QyCWF3SH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ewz06wkw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QyCWF3SH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C11322532;
	Tue, 17 Sep 2024 21:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726610055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHyYymU40LHB7ZgzKtdHyNesr3HYnr4DdIzhSI4l7ds=;
	b=Ewz06wkwEcEhM5k4mRLpXWquEssqZpH8q3k9CdodS6sTKPDkUgSK5YcQHlg8cZmfV1bfrQ
	IvSFYEd2+vg/zS/ezEhp4+8ck56c+00YvSrcta5bVxDjSmaNB8FZNq3CdMPo0ZuaPZfY4E
	ZS0JTlWX82pAvpMFXknAHo0prN9Bvbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726610055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHyYymU40LHB7ZgzKtdHyNesr3HYnr4DdIzhSI4l7ds=;
	b=QyCWF3SH8W0T347ycKGdYg0qAFagLsHdY4xAuKRJSk+8OPA28XKwT3emPXWunOjuZjQtL0
	6G13NjlE0Hs8btBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ewz06wkw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QyCWF3SH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726610055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHyYymU40LHB7ZgzKtdHyNesr3HYnr4DdIzhSI4l7ds=;
	b=Ewz06wkwEcEhM5k4mRLpXWquEssqZpH8q3k9CdodS6sTKPDkUgSK5YcQHlg8cZmfV1bfrQ
	IvSFYEd2+vg/zS/ezEhp4+8ck56c+00YvSrcta5bVxDjSmaNB8FZNq3CdMPo0ZuaPZfY4E
	ZS0JTlWX82pAvpMFXknAHo0prN9Bvbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726610055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHyYymU40LHB7ZgzKtdHyNesr3HYnr4DdIzhSI4l7ds=;
	b=QyCWF3SH8W0T347ycKGdYg0qAFagLsHdY4xAuKRJSk+8OPA28XKwT3emPXWunOjuZjQtL0
	6G13NjlE0Hs8btBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD1CD13A9B;
	Tue, 17 Sep 2024 21:54:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K9MrHIT66WYJOgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 17 Sep 2024 21:54:12 +0000
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
Cc: "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 1/7] block: change wait on bd_claiming to use a
 var_waitqueue, not a bit_waitqueue
In-reply-to: <68e8c574-1266-42e1-9d0d-ed837c7105b6@kernel.dk>
References: <>, <68e8c574-1266-42e1-9d0d-ed837c7105b6@kernel.dk>
Date: Wed, 18 Sep 2024 07:54:05 +1000
Message-id: <172661004540.17050.6252973409733219343@noble.neil.brown.name>
X-Rspamd-Queue-Id: 2C11322532
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 17 Sep 2024, Jens Axboe wrote:
> On 8/26/24 12:30 AM, NeilBrown wrote:
> > bd_prepare_to_claim() waits for a var to change, not for a bit to be
> > cleared.
> > So change from bit_waitqueue() to __var_waitqueue() and correspondingly
> > use wake_up_var().
> > This will allow a future patch which change the "bit" function to expect
> > an "unsigned long *" instead of "void *".
> 
> Looks fine to me - since this one is separate from the series, I can snag
> it and shove it into the block side so it'll make 6.12-rc1. Then at least
> it won't be a dependency for the rest of the series post that.

Thanks Jens!

NeilBrown

