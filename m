Return-Path: <linux-fsdevel+bounces-76688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D1OInqCiWkg+QQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 07:45:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A1210C344
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 07:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCEDE301440A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 06:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D6331A572;
	Mon,  9 Feb 2026 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FAKwOm/z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E862318B8D
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770619491; cv=none; b=inkTmi/NJIw8gVdsVvg3BJqIpZKKdtHeh6ZB+8/yizIuaAZVRx+skSBa7lPPnsqstQ9dsaMDlIUHhJrMq4JVMLomBp0Lp4jpwU8/ecYLnNaVQNRfDJ+/QYoHi1FH6EfruHpbumC/+YfgwARgHb4PMn42I2rRbJtDMdV8gAyah0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770619491; c=relaxed/simple;
	bh=IbSLzO9z1E8QU21Op+Z1uoXchU3QUF6sGQn6/NRNW3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIEBXg5NUQY/bvsqKj68YAN0GoSQNTV8rXlrvH7uGwUuhQqftbbW/j/m2FcadWr5o+5/RQZd1So9PI6JG/y8uRh3pcrO2GniTHVOFU0Pl9vb7bR3rJ29t4B4FWOkaiS81Lm4lTRWJorbgjgJspckeM3hcFSVq5Lu8Q0jMBJh4VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FAKwOm/z; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65378ba2ff7so3656484a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Feb 2026 22:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1770619489; x=1771224289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U5uJzlA/K+4sxP5U8qeacmDIKj6ZO0FlHnPUzOkY2k8=;
        b=FAKwOm/zaZBQFG18avn4vW2tiBXqFw1q/PbUOvHaiQrsPomnw0LjKVyxwjvLyT3ORf
         87ZPOetsAWE5ZdH48qyqekIDAQOfokjfg9Q6+bEG7DVZiwXRx5BXojGdwtVK6ku5X018
         wTKV2ftny/tTFdZC9/PPTfxiJ1qTQ1uyCIpi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770619489; x=1771224289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5uJzlA/K+4sxP5U8qeacmDIKj6ZO0FlHnPUzOkY2k8=;
        b=bmq1NSNhGZE+MwAUKDSgwKEFdiSG1d28rw18wxs3L4iNatt5WKxgnLKp+29o6g34gC
         FdV1z92Fz4f2SnTVROXWdhW0bU0cTkppIWoGr0MBWrKZmdrkxhXACIweSofCtUlzz0f9
         e4AqPVp9MUrs9b2dJdrsVqRB1xJxotbsZQZgPRN/GQUBsYC0aRVf21aICZugi+x+Tp27
         OVb0IctL3OfycHA1zOGe8+kGwk10CXB3MxhyvIITVO9tpECH/Oh4jochAEF9MsoID55I
         wJGmAiyXmm968NVtAvBzQWa/t2isio75EQHwz/npAHADp7sAur+UHBJ6IQb3GY/TodNg
         nTgA==
X-Gm-Message-State: AOJu0Yzu+SmGhdWxP6PB7Yh/neAcDadKOo3jhFjlNXL+/IB0s359n59h
	EWHYLiCtzMwfQGvJH7UzB1GxcwlR65aJgbG5vlE6JRnsCvA0N49gMxYui3CUXwkXzGzhEVrOxPV
	dg425tv0=
X-Gm-Gg: AZuq6aLHvnZ5u1yjq32JRtIIBT5QE65XfA+s0VfSA0O99fulvtnwK8Sa4cccqyIc7Qe
	rI9Qmbifp/aYDmU9GjL402+iJjUEK/fEE7eybC4CYaSplqBbhcYhJDmIqYHjDbxhWuqFs+SycOA
	TfX3tcXr8ahbNIlWgfsrVABz3GFg6MbUIVNW41gmmm81J58lD/ppnIo94ytjhU+hrBSccAd8QxE
	ugKyuZnB/wOXl9ghzqzBcp/ZXNvmz4DSFtTvlHxSCBWNN3eu6IG83tOc9T98WGzN43lNzlpg8GF
	hZXEaGdFqqXm/v5+hAzwqXZ75XDA5L76m87XFISsUztnq9MCf4W0Erxvu8tfiMa/yAYxbV/0GUs
	PzQAXA8E/I1cx/NC7T4a0Nmxq8DrhPvRFzlZjccUwnSobCvLlbU5RlGsRlqY5qEOLQFk4Chhb7m
	zSkyGQDcssNvLUKYNIvcYRUrnR+XMM/GyDjTGKm3WYmmiucWb8ISxWWFrmA7rn
X-Received: by 2002:a17:907:6d0f:b0:b88:713e:78a5 with SMTP id a640c23a62f3a-b8edf25ccebmr552353966b.28.1770619489349;
        Sun, 08 Feb 2026 22:44:49 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda7dd3acsm350831666b.28.2026.02.08.22.44.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 22:44:48 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-659428faa2bso4044962a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Feb 2026 22:44:48 -0800 (PST)
X-Received: by 2002:a17:907:97cc:b0:b87:2d0f:d42c with SMTP id
 a640c23a62f3a-b8edf456657mr582691766b.63.1770619488345; Sun, 08 Feb 2026
 22:44:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209003437.GF3183987@ZenIV> <CAHk-=whoVEhWbBJK9SiA0XoUbyurn9gN8O0gUAne88a4gXDLyQ@mail.gmail.com>
 <20260209063454.GI3183987@ZenIV>
In-Reply-To: <20260209063454.GI3183987@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 8 Feb 2026 22:44:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wikNJ82dh097VZbqNf_jAiwwZ_opzfvMr-8Ub3_1cx3jQ@mail.gmail.com>
X-Gm-Features: AZwV_QgGkJrW00l4pCXwoQcb6W71h7KqMNo7yc4xK07MWuCgrTU7g0F6A-0ntIc
Message-ID: <CAHk-=wikNJ82dh097VZbqNf_jAiwwZ_opzfvMr-8Ub3_1cx3jQ@mail.gmail.com>
Subject: Re: [RFC] pivot_root(2) races
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <christian@brauner.io>, 
	Jan Kara <jack@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, 
	Werner Almesberger <werner@almesberger.net>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76688-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.org.uk:email,linux-foundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04A1210C344
X-Rspamd-Action: no action

On Sun, 8 Feb 2026 at 22:32, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Not really - look at those check_mnt() in pivot_root(2).
> static inline int check_mnt(const struct mount *mnt)
> {
>         return mnt->mnt_ns == current->nsproxy->mnt_ns;
> }
>
> SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
>                 const char __user *, put_old)
> {
>         ...
>         if (!check_mnt(root_mnt) || !check_mnt(new_mnt))
>                 return -EINVAL;
>
> IOW, try to do that to another namespace and you'll get -EINVAL,
> no matter what permissions you might have in your namespace
> (or globally, for that matter).

It's more that you can affect *processes* in another namespace if I
read things right. Not other processes' namespaces, but basically
processes that you have no business trying to change...

Yes, both the old and new root need to be in your own namespace, but
imagine that you are a process in some random container, and let's say
that root (the *real* root in the init namespace) is looking at your
container state.

IOW, imagine that I'm system root, and I've naively done a "cd
/proc/<pid>/cwd" to look at the state of some sucker, and now...

Am I mis-reading things entirely, or can a random process in that
container (that has mount permissions in that thing) basically do
pivot_root(), and in the process change the CWD of that root process
that just happens to be looking at that container state?

I'm just naively looking at that for_each_process_thread() loop that does that

                hits += replace_path(&fs->pwd, old_root, new_root);

but the keyword here is "naively".

Is there some other check that I'm missing?

             Linus

