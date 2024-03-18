Return-Path: <linux-fsdevel+bounces-14765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B77CF87EFF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 19:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968B21C22074
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 18:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED1156468;
	Mon, 18 Mar 2024 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q2FObs2O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dT6tgLg2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q2FObs2O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dT6tgLg2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5B356462
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787736; cv=none; b=R9XuN4avGdjMKnOd0xMZAePKZFE4nXHZIiDcp+mpcKUWcHEPSZOAPkCDLNCmoZkp93ssyUWqZ3MVr4yFv3slfRFI1//cuW+Lbl+zP6tuC3WTfLCzopDupLvjJPkY8rk+5Pr7dticC84AzfTtVm88wM1+fSYDzqt1XgLWXCB8aiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787736; c=relaxed/simple;
	bh=JmlJFpAM2RoINtTtYZLu5wC7Bt+LRtGXt5zSephhVf0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PIAfeEuFyvhlJ0AX/SPzgF4JwBSu2/ZNyhwpgZniGDqQAGZc8iyFMHkRvW2GlXR5LCWm34HqO+NMP/w/zljy1t79euER5Js/xTU042wA+OkWHWYcxegroCmtAkdVhls8AiQE771ld/B5x7g2CjWe1BnfawyLLCOGH4jU3G6gSZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q2FObs2O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dT6tgLg2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q2FObs2O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dT6tgLg2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71C4634DDA;
	Mon, 18 Mar 2024 18:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710787732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ayet3oedNBW1SkDoKToreyGDhd5DvaUI0W9XW30cdGs=;
	b=Q2FObs2OtCGrZBTyhiiqL5AQmem+eZrQehtXtrnuwPVWerUoWXeLB3YSbkk26M9Wz5HOU8
	cVjavyYJUqNvvbOsXdJms8zmhGggnVK/vkzDGKP6e91dctv1UvJFiTnYwsuZkW0x/HnYuu
	SN64WV84eKL0T9mzRLIVONgnfABXizU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710787732;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ayet3oedNBW1SkDoKToreyGDhd5DvaUI0W9XW30cdGs=;
	b=dT6tgLg2MxjM5hbTZjLEMToy/GEmI3BCwpi7xXpQMkv30lbyN/1UzMvSDe3SsWwuR5ALQ3
	ZWjoqcfLIOY7zoBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710787732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ayet3oedNBW1SkDoKToreyGDhd5DvaUI0W9XW30cdGs=;
	b=Q2FObs2OtCGrZBTyhiiqL5AQmem+eZrQehtXtrnuwPVWerUoWXeLB3YSbkk26M9Wz5HOU8
	cVjavyYJUqNvvbOsXdJms8zmhGggnVK/vkzDGKP6e91dctv1UvJFiTnYwsuZkW0x/HnYuu
	SN64WV84eKL0T9mzRLIVONgnfABXizU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710787732;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ayet3oedNBW1SkDoKToreyGDhd5DvaUI0W9XW30cdGs=;
	b=dT6tgLg2MxjM5hbTZjLEMToy/GEmI3BCwpi7xXpQMkv30lbyN/1UzMvSDe3SsWwuR5ALQ3
	ZWjoqcfLIOY7zoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37A1D136A5;
	Mon, 18 Mar 2024 18:48:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rglZB5SM+GW+FQAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 18 Mar 2024 18:48:52 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
  lsf-pc@lists.linux-foundation.org,  linux-fsdevel@vger.kernel.org,
  Naresh Kamboju <naresh.kamboju@linaro.org>,  Disha Goel
 <disgoel@linux.ibm.com>
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem testing
In-Reply-To: <87h6h4sopf.fsf@doe.com> (Ritesh Harjani's message of "Sun, 17
	Mar 2024 23:52:36 +0530")
References: <87h6h4sopf.fsf@doe.com>
Date: Mon, 18 Mar 2024 14:48:51 -0400
Message-ID: <87cyrre5po.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,lists.linux-foundation.org,vger.kernel.org,linaro.org,linux.ibm.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Leah Rumancik <leah.rumancik@gmail.com> writes:
>
>> Last year we covered the new process for backporting to XFS. There are
>> still remaining pain points: establishing a baseline for new branches
>> is time consuming, testing resources aren't easy to come by for
>> everyone, and selecting appropriate patches is also time consuming. To
>> avoid the need to establish a baseline, I'm planning on converting to
>> a model in which I only run failed tests on the baseline. I test with
>> gce-xfstests and am hoping to automate a relaunch of failed tests.
>> Perhaps putting the logic to process the results and form new ./check
>> commands could live in fstests-dev in case it is useful for other
>> testing infrastructures.
>
> Nice idea. Another painpoint to add - 
> 4k blocksize gets tested a lot but as soon as we switch to large block
> size testing, either with LBS, or on a system with larger pagesize...
> ...we quickly starts seeing problems. Most of them could be testcase
> failure, so if this could help establish a baseline, that might be helpful.
>
>
> Also if could collborate on exclude/known failures w.r.t different
> test configs that might come handy for people who are looking to help in
> this effort. In fact, why not have different filesystems cfg files and their
> corresponding exclude files as part of fstests repo itself?  
> I know xfstests-bld maintains it here [1][2][3]. And it is rather
> very convinient to point this out to anyone who asks me of what test
> configs to test with or what tests are considered to be testcase
> failures bugs with a given fs config.
>
> So it will very helpful if we could have a mechanism such that all of
> this fs configs (and it's correspinding excludes) could be maintained in
> fstests itself, and anyone who is looking to test any fs config should
> be quickly be able to test it with ./check <fs_cfg_params>. Has this
> already been discussed before? Does this sound helpful for people who
> are looking to contribute in this effort of fs testing?
>
>
> [1] [ext4]:
> https://github.com/tytso/xfstests-bld/tree/master/test-appliance/files/root/fs/ext4/cfg

Looking at the expunge comments, I think many of those entries should
just be turned into inline checks in the test preamble and skipped with
_notrun.  The way I see it, expunged tests should be kept to a minimum,
and the goal should be to eventually remove them from the list, IMO.
They are tests that are known to be broken or flaky now, and can be safely
ignored when doing unrelated work, but that will be fixed in the
future. Tests that will always fail because the feature doesn't exist in
the filesystem, or because it asks for an impossible situation in a
specific configuration should be checked inline and skipped, IMO.

+1 for the idea of having this in fstests.  Even if we
lack the infrastructure to do anything useful with it in ./check,
having them in fstests will improve collaboration throughout
different fstests wrappers (kernelci, xfstests-bld, etc.)

> [2] [xfs]: https://github.com/tytso/xfstests-bld/tree/master/test-appliance/files/root/fs/xfs/cfg
> [3] [fs]: https://github.com/tytso/xfstests-bld/tree/master/test-appliance/files/root/fs/



>
> -ritesh

-- 
Gabriel Krisman Bertazi

