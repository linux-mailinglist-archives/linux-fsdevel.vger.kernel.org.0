Return-Path: <linux-fsdevel+bounces-38072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C32C19FB562
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 21:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2174F18812B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 20:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859A11CDFDC;
	Mon, 23 Dec 2024 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KAfDNvnW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gLAz3juR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KAfDNvnW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gLAz3juR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F301AE01E;
	Mon, 23 Dec 2024 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734986193; cv=none; b=m7ULdep2tYZhcu/GWEZMAVIwnvkpEoh4K7OvnH0tHAeEZ0BAciybWaPZpRoulOcJ0Wd4gk7k9N5OVH0/bTDLDsYhX1s2a2xaetY/u+a3c+Yu9RKtBpD+31auSMsDZZ0O2zJZfTQXTJOLVK3ztCWJhepM7L67WomoyV3DKHhHVUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734986193; c=relaxed/simple;
	bh=iWPMVyQbdAqMR4Wq2hU03Mkiyvflvwq7XL9PME055N0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=YfoktDeFEnkHGSgVUrEEdz8vFBX31UqCBg7wZS71+tQkarDNfCxzBbVo7cY7+jgPRdOTkiO//gCbW2ZhbzjFAIf9bsx9WTE+BHUMm2zMX2expJzK8aEeJWttIBQFvf7KOtdmAmbsFmcOtC1spkdTDZTu2bHZy727chJL/aFrUaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KAfDNvnW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gLAz3juR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KAfDNvnW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gLAz3juR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5AFD322448;
	Mon, 23 Dec 2024 20:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734986190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3ZPztEOINWo5t2auZp6Pwm15N22ERZv/xHDAQnz/uw=;
	b=KAfDNvnW27j/g9HY8v7vQkLOC6wvwAHWSECBjPEh5hvrbQowBtWLHsilz/m7cxeIH7r1Gj
	TkxCOkvbq3USD8baeE5afkq+h4TFLudjqbFYN3MF/f4oJubFJwNORpcqElkCs1nmwcutyA
	emwWqvUi4w+KbGegxKBKFn/haeyawUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734986190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3ZPztEOINWo5t2auZp6Pwm15N22ERZv/xHDAQnz/uw=;
	b=gLAz3juRJU8UTw18KTkJmNubX1Nc2aX7hPC7T7cn+Sj8C6KYshVIrXtD1hA648QITnfcWO
	3+eWayE5M34iEWAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734986190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3ZPztEOINWo5t2auZp6Pwm15N22ERZv/xHDAQnz/uw=;
	b=KAfDNvnW27j/g9HY8v7vQkLOC6wvwAHWSECBjPEh5hvrbQowBtWLHsilz/m7cxeIH7r1Gj
	TkxCOkvbq3USD8baeE5afkq+h4TFLudjqbFYN3MF/f4oJubFJwNORpcqElkCs1nmwcutyA
	emwWqvUi4w+KbGegxKBKFn/haeyawUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734986190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3ZPztEOINWo5t2auZp6Pwm15N22ERZv/xHDAQnz/uw=;
	b=gLAz3juRJU8UTw18KTkJmNubX1Nc2aX7hPC7T7cn+Sj8C6KYshVIrXtD1hA648QITnfcWO
	3+eWayE5M34iEWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7283137DA;
	Mon, 23 Dec 2024 20:36:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jK8dF8vJaWf8fQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 23 Dec 2024 20:36:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Hillf Danton" <hdanton@sina.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] VFS: add inode_dir_lock/unlock
In-reply-to: <20241223111225.389-1-hdanton@sina.com>
References: <20241220030830.272429-1-neilb@suse.de>,
 <20241221012128.307-1-hdanton@sina.com>,
 <20241223111225.389-1-hdanton@sina.com>
Date: Tue, 24 Dec 2024 07:36:08 +1100
Message-id: <173498616860.11072.11978717859547245956@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_TO(0.00)[sina.com];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[sina.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 23 Dec 2024, Hillf Danton wrote:
> On Mon, 23 Dec 2024 14:10:07 +1100 NeilBrown <neilb@suse.de>
> > On Sat, 21 Dec 2024, Hillf Danton wrote:
> > > Inventing anything like mutex sounds bad.
> > 
> > In general I would agree.  But when the cost of adding a mutex exceeds
> > the cost of using an alternate solution that only requires 2 bits, I
> > think the alternate solution is justified.
> > 
> Inode deserves more than the 2 bits before such a solution is able to
> rework mutex.

I'm sorry but I don't understand what you are saying.  Could you please
give more details about your concern?
Are you concerned about correctness?  Performance?  Maintainability?
Something else?

Thanks,
NeilBrown

