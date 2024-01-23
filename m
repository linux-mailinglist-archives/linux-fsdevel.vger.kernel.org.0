Return-Path: <linux-fsdevel+bounces-8518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 506968389F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 10:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABFCDB231A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 09:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D4B57894;
	Tue, 23 Jan 2024 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BQq/6WFP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kj+YwuHN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2kLWKy/q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BSsrTq7L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C33479DB;
	Tue, 23 Jan 2024 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706000725; cv=none; b=YJgkUz+lsE6iZK/ZCSBrKzi+CHiUzs2GnU6EFnmHklBUQbfPEBJF9DDWXnquv7MQqTzlAK8LMP5YspU2frTdPmymqMBuxPCblYxossFBsMs6OLexxEP3fu8Zc9bkb3Txvqn7a7MOpvEx9NSzPgQC3FOyCzvv6wO60JDW6NSbCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706000725; c=relaxed/simple;
	bh=JpeB9HkmS2uadCS+gWnCF7x5aWvwSC1P65jZVfIntGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUfIHZ1vIXFwTKzt7PBzx8e/Lj6xuppx8MwUq/wJsb0cJsDUvjX9Ben/PjXXKRlWYbqqOYx5cEfDc+oW9dPjddtIUztvkeK8eiDfwpi8CdOZu9fBrmz6RD0iXuazQgXztyIgjGzdsmgBEp8ZdG3XPBNpjevNACXeia04CC3zn88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BQq/6WFP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kj+YwuHN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2kLWKy/q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BSsrTq7L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C641F1FD48;
	Tue, 23 Jan 2024 09:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706000719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rV8HBudkXVPcg3VdgRXmTEvLoRv4fTV06BBAmJn8J/s=;
	b=BQq/6WFPLVZ9lNTCFfI/y1xUFiFj2y2sn4QqRVAfX6KJwNHpVF2oasTMhdYZtKMRbF+NgE
	LxdtP+5Ico9Jmv0AZo4wMeS9aJlSFekW+Mln9iKESmJsD54m/gLNyE4yDViSPAS05z6/y1
	48Ld4LaxqKuGhK6D9kQV/i+oTlqFY3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706000719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rV8HBudkXVPcg3VdgRXmTEvLoRv4fTV06BBAmJn8J/s=;
	b=kj+YwuHN+ZXSkF2Jq9hyNWg62jHa1GKiJq5fdj2ZjWbVFZdhQ9tcjbzrD51/BV3VkGUJmv
	LP43iWBc0gmOE3Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706000718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rV8HBudkXVPcg3VdgRXmTEvLoRv4fTV06BBAmJn8J/s=;
	b=2kLWKy/qWBUsJ+5BaznDvNHInGFnsg1lrk4V6fYE2n3jiDOZBXi3FkqRXgoAAbH2NWmUAG
	VAgXwsNujUxmmteh02+Ykb+b0QWF/Ux3hayS9Fd6LTFpo31aqdouCaNnWEGlO1bdfJFueW
	TSLVH2WkpR7/nkCOpnUeqwHRluWq+TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706000718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rV8HBudkXVPcg3VdgRXmTEvLoRv4fTV06BBAmJn8J/s=;
	b=BSsrTq7LYadgxyFkNMYRDLf6qUxJ/n5w50ehMLDlilCHSmdqWjsO5h126XsB6WYn6BejY+
	hhd6TjP/4hDc05BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B96BC136A4;
	Tue, 23 Jan 2024 09:05:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CAVALU6Br2WTfAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 09:05:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 660C3A0803; Tue, 23 Jan 2024 10:05:18 +0100 (CET)
Date: Tue, 23 Jan 2024 10:05:18 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+ed7d0f71a89e28557a77@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, axboe@kernel.dk, bobo.shaobowang@huawei.com,
	brauner@kernel.org, broonie@kernel.org, catalin.marinas@arm.com,
	cluster-devel@redhat.com, dominic.coppola@gatoradeadvert.com,
	dvyukov@google.com, gfs2@lists.linux.dev, jack@suse.cz,
	liaoyu15@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	liwei391@huawei.com, madvenka@linux.microsoft.com,
	rpeterso@redhat.com, scott@os.amperecomputing.com,
	syzkaller-bugs@googlegroups.com, will@kernel.org
Subject: Re: [syzbot] [gfs2?] INFO: task hung in gfs2_gl_hash_clear (3)
Message-ID: <20240123090518.bu3q2khkveknbcl3@quack3>
References: <000000000000d482ba05ee97d4e3@google.com>
 <00000000000081bcbd060f8128e2@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000081bcbd060f8128e2@google.com>
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="2kLWKy/q";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BSsrTq7L
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL7pfqg7h1m44jupjp7nguhfec)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[37.39%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=29fd3392a08741ef];
	 TAGGED_RCPT(0.00)[ed7d0f71a89e28557a77];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 1.49
X-Rspamd-Queue-Id: C641F1FD48
X-Spam-Flag: NO

On Sun 21-01-24 20:21:05, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=137b2d43e80000
> start commit:   3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=29fd3392a08741ef
> dashboard link: https://syzkaller.appspot.com/bug?extid=ed7d0f71a89e28557a77
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b6f3f8a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1688b6d4a80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense:

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

