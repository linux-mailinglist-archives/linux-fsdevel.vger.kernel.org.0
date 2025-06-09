Return-Path: <linux-fsdevel+bounces-51039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1182AD226D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 17:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84AD18870A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2069E1DF97D;
	Mon,  9 Jun 2025 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P1VJmzhT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J8To20ht";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A4JCmg01";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GPvlE897"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FFF1AA1F4
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749482933; cv=none; b=fRuFeJGanGfjjtA+8zOagELD92j+5FsIk/QzxRwMv9gBuerEITU0pAS5pulmqmfL8ztGFn348crEwSD5Tmz+R1d5bnZn0LKE1rk4A+LfYGUmyHDC+n3lyhmmA+RPGI/wpJnWN9NJ4rBQNsvV6EUHVJaEBM/iFf6skJI9zwH/WBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749482933; c=relaxed/simple;
	bh=AS3BcHkXywjf/cPF64fYh6OqRQ8DodiXQyFgo1dvS2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RnGBmXyDPxSo185sBndomtwXUA4j8JdX5HtrMi+PYp3wxcJi18nY874aeQYDFdhWPMbLSjtYNRudOqge7xapzbMUMvQ+0z/zldkyq9EnJWPkaopB9HjqTfefhRMCADa+RyC3MuYoXAy2dIKhUuv8eGnLNhBNoO3eVDowvCVbfSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P1VJmzhT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J8To20ht; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A4JCmg01; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GPvlE897; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5FD921114;
	Mon,  9 Jun 2025 15:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749482929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEKzaDerLDVJJ9hauw1LL+fRqRFfcITgq70KVVz91Q8=;
	b=P1VJmzhT6++wjBWDdKBgJdE3D6e4ZC8whF4i6Nym9qybaSKp5GobQfswc/ZxyW3Sqw8zoA
	kFIiedZ0jwB7yMfysUQLek0QqemBrS4rSNy8k0j59HdevNNr3aog/yoU5Ku6nNd6iFjPcq
	mIlncuicZ8MafUdB6PNci6qMuvFXpYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749482929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEKzaDerLDVJJ9hauw1LL+fRqRFfcITgq70KVVz91Q8=;
	b=J8To20ht2/6cZXq/ByGjxwDBLJAere1YVjhEwVf/3Fz/FWmGNM4pXiZNEDojTFsH9E/913
	vHyncuoeM8Nis5BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A4JCmg01;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GPvlE897
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749482928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEKzaDerLDVJJ9hauw1LL+fRqRFfcITgq70KVVz91Q8=;
	b=A4JCmg01IyBUKO0mjrK8gsF27mln13RejKKf6+KC+pNs55lScaye1zz1l/EqFt5vVqJNnY
	R3nnA15hp+OrckU3BJfa/Sm0LLYPtc3vFOFfqQyZ0vCa/s2wpKrvluT1O1d0UqyNdTbMuT
	jYMDMbIHM6ezXckKLsRYeQkc4LyMigA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749482928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEKzaDerLDVJJ9hauw1LL+fRqRFfcITgq70KVVz91Q8=;
	b=GPvlE897KZKPd1zYIIt8lJYBeFkPRFxpMoRRkKq1/sulC8vP0CnyAE7WJd8Z1g7J8GJPD1
	hNpf7JLd/CCBC4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63995137FE;
	Mon,  9 Jun 2025 15:28:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7umGEbD9Rmh2fwAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 09 Jun 2025 15:28:48 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Theodore Ts'o <tytso@mit.edu>,  Cedric Blancher
 <cedric.blancher@gmail.com>,  Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>,  linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: LInux NFSv4.1 client and server- case insensitive filesystems
 supported?
In-Reply-To: <a44ebcd9-436b-436f-a6f5-dea8958aaf2f@oracle.com> (Chuck Lever's
	message of "Sun, 8 Jun 2025 17:52:36 -0400")
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
	<CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
	<44250631-2b70-4ce8-b513-a632e70704ed@oracle.com>
	<20250607223951.GB784455@mit.edu>
	<643072ba-3ee6-4e5b-832a-aac88a06e51d@oracle.com>
	<20250608205244.GD784455@mit.edu>
	<a44ebcd9-436b-436f-a6f5-dea8958aaf2f@oracle.com>
Date: Mon, 09 Jun 2025 11:28:46 -0400
Message-ID: <875xh5ylw1.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A5FD921114
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,gmail.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:dkim,mailhost.krisman.be:mid]
X-Spam-Score: -2.01
X-Spam-Level: 

Chuck Lever <chuck.lever@oracle.com> writes:

> On 6/8/25 4:52 PM, Theodore Ts'o wrote:
>> On Sun, Jun 08, 2025 at 12:29:30PM -0400, Chuck Lever wrote:
>>>
>>> For some reason I thought case-insensitivity support was merged more
>>> recently than that. I recall it first appearing as a session at LSF in
>>> Park City, but maybe that one was in 2018.

Hi Chuck,

The first LSF discussion on this implementation was Park City, 2018. It
was merged early 2019.

> Ted, do you happen to know if there are any fstests that exercise case-
> insensitive lookups? I would not regard that simple test as "job done!
> put pencil down!" :-)

generic/556 tests basic semantics and many corner cases of casefolded
lookups.

-- 
Gabriel Krisman Bertazi

