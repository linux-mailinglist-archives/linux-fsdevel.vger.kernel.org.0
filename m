Return-Path: <linux-fsdevel+bounces-8365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5848356AB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 17:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144F71F22031
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 16:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691F436B15;
	Sun, 21 Jan 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xMu7ZpZk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bt3S6p1p";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xMu7ZpZk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bt3S6p1p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C818E13FE2
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705854860; cv=none; b=pXyBGtNY8fsqPWHU8BrCS8bOWRqsQPSp+rV4/Eo0VdbMXJaemLpX4UcD9EV7G3VcI5+BHZXD/4qEL5Uh496cbRaprUcIEz+tWyVHzIQMWXLMjMwoCEHXc1DsdV4Pi0wwrFcOsd9IIU2BNgxWknVA6AAyYAmM04mzBaFMz1rEsw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705854860; c=relaxed/simple;
	bh=4RHt3e8TM1yvQaFH1svvruN/gpLmVvwyy2z/LutN4Vg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JJmbAPRjBeTjNkSM8TZAh7j3tGrcURw/oQ6wVFNRnkWoUH3mkM052ndUpebhNNzqp1whkKacok9nZj67b3O6r3PR7dE8csX38b57Yd6ud6auissP8kobbxk5i+mME5AtkdYWdZ5k39VSgPDCKOBoiP9JQXFb0XIXdzrJcyZBTZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xMu7ZpZk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bt3S6p1p; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xMu7ZpZk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bt3S6p1p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3605E1FBA8;
	Sun, 21 Jan 2024 16:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705854851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Go+rG5Q4H7/O7Kku1l06r1GPdr2LW3PZlv1WQzt3INk=;
	b=xMu7ZpZkagrYpC4V1YXh7/8w2Fs0SUNxLYmKpbeMzadSvXqcKBgf1jigdtatFp0WQEHYtU
	FU7JUQJkUV70re9Vfb+rGdM1k5m2CjNE0LR9dZ27z4Rf8RmYDoxTn1GV0revK9f4oQqmNJ
	QH4PViVw4KQYiSxIDWsOfw1Sv7533cM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705854851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Go+rG5Q4H7/O7Kku1l06r1GPdr2LW3PZlv1WQzt3INk=;
	b=bt3S6p1pIjlXlyLa5BX9xYxIgzLGEpD4//+bwnDZ/YnkoESElxq/6dNprnLIpUHorJRQNB
	9gHPsU80yqHFhEBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705854851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Go+rG5Q4H7/O7Kku1l06r1GPdr2LW3PZlv1WQzt3INk=;
	b=xMu7ZpZkagrYpC4V1YXh7/8w2Fs0SUNxLYmKpbeMzadSvXqcKBgf1jigdtatFp0WQEHYtU
	FU7JUQJkUV70re9Vfb+rGdM1k5m2CjNE0LR9dZ27z4Rf8RmYDoxTn1GV0revK9f4oQqmNJ
	QH4PViVw4KQYiSxIDWsOfw1Sv7533cM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705854851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Go+rG5Q4H7/O7Kku1l06r1GPdr2LW3PZlv1WQzt3INk=;
	b=bt3S6p1pIjlXlyLa5BX9xYxIgzLGEpD4//+bwnDZ/YnkoESElxq/6dNprnLIpUHorJRQNB
	9gHPsU80yqHFhEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8ACC9136F5;
	Sun, 21 Jan 2024 16:34:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bKZcD4JHrWVAfgAAD6G6ig
	(envelope-from <krisman@suse.de>); Sun, 21 Jan 2024 16:34:10 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ebiggers@kernel.org,  viro@zeniv.linux.org.uk,  tytso@mit.edu,
  linux-fsdevel@vger.kernel.org,  jaegeuk@kernel.org
Subject: Re: [PATCH v3 1/2] dcache: Expose dentry_string_cmp outside of dcache
In-Reply-To: <CAHk-=whW=jahYWDezh8PeudB5ozfjNpdHnek3scMAyWHT5+=Og@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 19 Jan 2024 12:48:51 -0800")
Organization: SUSE
References: <20240119202544.19434-1-krisman@suse.de>
	<20240119202544.19434-2-krisman@suse.de>
	<CAHk-=whW=jahYWDezh8PeudB5ozfjNpdHnek3scMAyWHT5+=Og@mail.gmail.com>
Date: Sun, 21 Jan 2024 13:34:03 -0300
Message-ID: <87mssywsqs.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[12.85%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.10

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 19 Jan 2024 at 12:25, Gabriel Krisman Bertazi <krisman@suse.de> wrote:
>>
>> In preparation to call these from libfs, expose dentry_string_cmp in the
>> header file.
>
> Let's not make these header files bigger and more complex.
>
> Particularly not for generic_ci_d_compare() to inline it, which makes
> no sense: generic_ci_d_compare() is so heavy with a big stack frame
> anyway, that the inlining of this would seem to be just in the noise.
>
> And when I look closer, it turns out that __d_lookup_rcu_op_compare()
> that does this all also does the proper sequence number magic to make
> the name pointer and the length consistent.

Ok. I see that we retry the read before calling d_compare here:

    /* we want a consistent (name,len) pair */
    if (read_seqcount_retry(&dentry->d_seq, seq)) {
	cpu_relax();
	goto seqretry;
    }

for RCU and for d_same_name we are holding the d_lock.

So, I guess I was right for the wrong reason in the earlier
versions. which doesn't really do me any good.

> So I don't think we need the careful name compare after all, because
> the caller has fixed the consistency issue.
>
> I do also wonder if we should just move the "identical always compares
> equal" case into __d_lookup_rcu_op_compare(), and not have
> ->d_compare() have to worry about it at all?

I considered that, and I can do it as a follow up.  I'd like to audit
d_compare to ensure we can change its semantics by only calling it if
the exact-match d_compare failed.  Is there a filesystem where that
really matters?  If so, we can add a new ->d_weak_compare hook.
Considering the ones I looked already will do fine with this change,
it's likely possible.

Are you ok with the earlier v2 of this patchset as-is, and I'll send a
new series proposing this change?

Thank you,

-- 
Gabriel Krisman Bertazi

