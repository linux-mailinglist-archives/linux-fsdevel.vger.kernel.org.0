Return-Path: <linux-fsdevel+bounces-63103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68135BAC229
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 10:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF2F3B840A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 08:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6962F39CC;
	Tue, 30 Sep 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jm+bq1Jj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gsOIFj+w";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1zmP7H00";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SPoWrDLc";
	dkim=neutral (0-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF4urpEP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E122F3C3A
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222408; cv=none; b=mGwRe2iPPo6rM7LTKXSG27Chj/9TXVkPdTRUVL3zYjpeAGDZL/X9nv2ytokaMIJc7uoi2JCdya3+k2UFVQGynKnvyPljQeHbDDiijBhZJHwy8MqxP9d3RfkdTEzGCGvPPl0c89kGAi5LomyE3pKMr6AHgSP3o8iQplJ4aSYbncA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222408; c=relaxed/simple;
	bh=hZx/v3Tx3TqzZD0VL9Ra24ov7w+DckGb9Tjt6rLF/uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3pe8YZXR0fOI0aotH46L7wb9HVsSFJqQmBbwsMO6jPp0EVdruMHXwHWWahzmAi31xcNtOjmBknAvGVRN+2umdmWKBSGd76Ipw5wwC/7cDhyLv8NQVdd0qbCMUl7+Ie0S+J8dyGKE+FPvJrDd47FLuPThmHOOS40BxVac6BT2pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jm+bq1Jj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gsOIFj+w; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1zmP7H00; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SPoWrDLc; dkim=neutral (0-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF4urpEP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4862B1F7A1;
	Tue, 30 Sep 2025 08:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759222404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=Ul69TxMqmJ19+cT05Juuu2la44Qg0Kg/oIsb5aQNOfU=;
	b=Jm+bq1Jj0HNYejQxS5IY0iWJP8531KOHc7su1QkdF1mRZwHUKvFNsvLpN26FG5V/XuifyS
	clxpHXhnZVfLFw9h5LMTW1LCo+OCsMbGf5dij0xzMftBpNekVRNjV2U4j8xc2zZZmj+dP8
	4nAof+w0wVww0htASwWye+vICGvb7/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759222404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=Ul69TxMqmJ19+cT05Juuu2la44Qg0Kg/oIsb5aQNOfU=;
	b=gsOIFj+wtGKaaVAU1Ufe34briY4xkCKq0zjYr5CjL1KzPSfXeNylYhd0/pn996ZjdfyVE/
	Isq7xulhju/37vBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1zmP7H00;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SPoWrDLc;
	dkim=fail ("body hash did not verify") header.d=kernel.org header.s=k20201202 header.b=LF4urpEP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759222403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=Ul69TxMqmJ19+cT05Juuu2la44Qg0Kg/oIsb5aQNOfU=;
	b=1zmP7H00IVXO0lnw4LpdAvANkhmdeRKH3EPxA969q43sBgjnN/ZnBvUn7fxBr92tZ/LkZk
	f8I26KGsOc/jAa3E8UYWdVcBuFmT5wQyE6diP2EgeYSJ13QonRgPpwD7B4rbsUB5o+LDT3
	47T3o+fUgBiMrTc9tG6+d6yJHkta3DI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759222403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=Ul69TxMqmJ19+cT05Juuu2la44Qg0Kg/oIsb5aQNOfU=;
	b=SPoWrDLcirgvPpDdkPwReDiub/jS2fqQ66Urc4Ae3rNlKI++DHVBYrWNZm+BVLYOY+oajN
	LJNE/e74TUz/vjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5A8D13A3F;
	Tue, 30 Sep 2025 08:53:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P1M2MYKa22hEawAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 30 Sep 2025 08:53:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: brauner@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Cc: cyphar@cyphar.com,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC 0/6] proc: restrict overmounting of ephemeral entities
Date: Tue, 30 Sep 2025 10:53:18 +0200
Message-ID: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
References: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201]) (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0763980043 for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 16:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4DFC32786; Tue,  6 Aug 2024 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org; s=k20201202; t=1722960157; bh=OQaVs3g2ZQwgR9Eb5FPuOoMg0In4wTMM6R4GmWMEhEE=; h=From:Subject:Date:To:Cc:From; b=LF4urpEPTKTieez82+He9OFtTtmg8znBmRWTWO3H6Bzmv1qmMgEyunpgspjVMOsXM BCSkwqx+kIXzTShUMQ0iPvMqXDmjayY8G8meu7Jh41+Age9eVhVNNWxdsmec6WZqzj QpqOU+/4o0GLl2jms3Wk4UNN2XRSuAW64FtHMoYho9VEIIXINdAbJZDuDnfeZWJNQI UELlXdo9WjC8pK43Z/tbpto0XCAEEMRAEFxcQb32/v9ZyeYAr12BPlDrbU4Y1vyLfq hiQQKa9gM728br7W6EprjXrjAcm8iJeelOZC2gykM3qzXAmOYe0cETSYp9avrvznTT dqKKCG+/+DR1Q==
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=4973; i=brauner@kernel.org; h=from:subject:message-id; bh=OQaVs3g2ZQwgR9Eb5FPuOoMg0In4wTMM6R4GmWMEhEE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRt8pQuSnDcxJP+6maNm9s87hj29atjTW4bFPeaLro74 fECv85FHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOprWH4X85juyDzUPif6qnX P3dtCNRvXcDwluNf6/0v+6cXGiaJLmX473PyxJz1avtvF3Jo6Hz28qu/GjwnZ+6knDfB1e5eqRa czAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.77 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_MATCH_TO(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MAILLIST(-0.15)[generic];
	SUSE_ML_WHITELIST_VGER(-0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+,kernel.org:-];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-fsdevel@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	DKIM_MIXED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cyphar.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 4862B1F7A1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.77

From: Christian Brauner <brauner@kernel.org>

Hi Christian, all,

> (Preface because I've been panick-approached by people at conference
>  when we discussed this before: overmounting any global procfs files
>  such as /proc/status remains unaffected and is an existing and
>  supported use-case.)

> It is currently possible to mount on top of various ephemeral entities
> in procfs. This specifically includes magic links. To recap, magic links
> are links of the form /proc/<pid>/fd/<nr>. They serve as references to
> a target file and during path lookup they cause a jump to the target
> path. Such magic links disappear if the corresponding file descriptor is
> closed.

> Currently it is possible to overmount such magic links:

> int fd = open("/mnt/foo", O_RDONLY);
> sprintf(path, "/proc/%d/fd/%d", getpid(), fd);
> int fd2 = openat(AT_FDCWD, path, O_PATH | O_NOFOLLOW);
> mount("/mnt/bar", path, "", MS_BIND, 0);

> Arguably, this is nonsensical and is mostly interesting for an attacker
> that wants to somehow trick a process into e.g., reopening something
> that they didn't intend to reopen or to hide a malicious file
> descriptor.

> But also it risks leaking mounts for long-running processes. When
> overmounting a magic link like above, the mount will not be detached
> when the file descriptor is closed. Only the target mountpoint will
> disappear. Which has the consequence of making it impossible to unmount
> that mount afterwards. So the mount will stick around until the process
> exits and the /proc/<pid>/ directory is cleaned up during
> proc_flush_pid() when the dentries are pruned and invalidated.

> That in turn means it's possible for a program to accidentally leak
> mounts and it's also possible to make a task leak mounts without it's
> knowledge if the attacker just keeps overmounting things under
> /proc/<pid>/fd/<nr>.

> I think it's wrong to try and fix this by us starting to play games with
> close() or somewhere else to undo these mounts when the file descriptor
> is closed. The fact that we allow overmounting of such magic links is
> simply a bug and one that we need to fix.

> Similar things can be said about entries under fdinfo/ and map_files/ so
> those are restricted as well.

> I have a further more aggressive patch that gets out the big hammer and
> makes everything under /proc/<pid>/*, as well as immediate symlinks such
> as /proc/self, /proc/thread-self, /proc/mounts, /proc/net that point
> into /proc/<pid>/ not overmountable. Imho, all of this should be blocked
> if we can get away with it. It's only useful to hide exploits such as in [1].

> And again, overmounting of any global procfs files remains unaffected
> and is an existing and supported use-case.

> Link: https://righteousit.com/2024/07/24/hiding-linux-processes-with-bind-mounts [1]

this is fixing a security issue, right? Wouldn't it be worth to backport these
commits to active stable/LTS kernels. I guess it was considered as a new feature
that's why it was not backported (looking at 6.11, 6.6 and 6.1).

Kind regards,
Petr

...

> Co-developed-by: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

