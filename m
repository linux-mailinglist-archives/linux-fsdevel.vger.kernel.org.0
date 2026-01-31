Return-Path: <linux-fsdevel+bounces-75972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIvkGJZJfWlZRQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 01:15:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9009DBF8C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 01:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E40F8300BC9C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 00:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5C82DB7AE;
	Sat, 31 Jan 2026 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VL7UTlDC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E472D8DBB
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 00:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769818511; cv=none; b=FX+MYtCqk8qONkOqHWCtOskXzC/lhu2oGZM2eGfgCfoIo07XMLC/Ts5zJnEZZ6qCwZGcCQuDk7taNgjW5hA9ledRTZ3lgE7SOFLLOwTUYd5ZuLjSOWJwoD0DVQn4tjMCVWgQyWhR0EUvd/XjVSUxTa97EXY1xInMLWOgllsDS2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769818511; c=relaxed/simple;
	bh=w7+B8N3XRoFg3Of/Fw9iyPoy/mghU2Qrl0CPBbBgDGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foWAod1NT8HGDh4Egz744nj6efnca1uQ9Tk1nlO4DIq8PPPs2O7CSqMDfdM0prL88gzKGXoonQo3oRfqWkGL2CZ3EFrRE01hsjRNOVOUPofWlyguW37JZ4bULlxFPX/K6I0FFRWmvJsUMj3tQjMFrSS+U/SkZbBPc3SnMgIf6KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VL7UTlDC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so3818118a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 16:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769818505; x=1770423305; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qV4mmOV+uOXX/Y9XduJfQAli873FtpKVEKD92eDGYCM=;
        b=VL7UTlDChcJa2PjZiznhPkBQ74jppyCs6t1eZZ+ZriJNhsFTdKenuCsI0e2iJuz+HY
         ZpfC4O+qJz9WVU/HzqY4q4DpaadaAYI5nA6gHHgjOZkoz18Ox8tOXoeAd5M/TZxcKSZs
         OupLGt/VcAOOflV/9RiYm+75G2NAxYO26YIRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769818505; x=1770423305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV4mmOV+uOXX/Y9XduJfQAli873FtpKVEKD92eDGYCM=;
        b=wZ/Jr9zV89wJshwsNTJKqjw38KIhs5952MirH+ypmR4koI5FEwTLFgEEkOdG6M2bT0
         Rp/b3p7VGY0dcjohxEbaqjZ8FZljs4TBNmdcW7nT9lUMfAQ2EQgSgrzniK6CUu4kzibs
         Te/D+TxC9qLfFf/1LPXD/oIO6NYIA4o+Qc7i00vbBQvZ/7DvoXe5k2sfKTCALOvxRWtl
         G6Mw1IXxqvhNZq3Q6I02bTIfLYtawubLGS9GeQ6AqCHNaX3BQ/YI05A6TF+XpAXV9mCQ
         8173B47NpXpOcS5AUJxUw7jt9DluiBMZE2mbholAuvtE7WL/bwj34PRuPen7Vo/xSQ/C
         8/fw==
X-Forwarded-Encrypted: i=1; AJvYcCXQCJEduF2FRQY7X1s9UjMR0Rrj4mse62f0a08hZjNUt6cCX/y/muwwmo4DjPHNWOUtISFfjKbUzqvS4pyL@vger.kernel.org
X-Gm-Message-State: AOJu0YwbqinnUDiNlHC4G2BjijOlZA6FfllqvxbhuvOPAtdnIQoHf1oO
	oWFoRVk4Wu0ROjo/dAuTR7K6S+pzkghG132JssOf4bSBIYBgtUf7slrW0hAEK2Q0cFis4RZb8Zy
	/BPwSf0g=
X-Gm-Gg: AZuq6aKM8EFjzOQaGOXZTAMRJeGwcbljkTrU0KpvS1NdTdULg9i9vRXS/ho0CFC+8Nb
	8/DfYKDG7gjUbV+parWkIQAqRPbAu7+zsSDamL+MNvzUy6PTmNZBe5H7raginq35FswpgXIbXhQ
	vuuhKhbYIL1EmnAP94+yT1SJpsrAV0RoFCjC7Nh/b5ZwHsnoafy/pj7Q8aia+PIvzimXXeiA160
	xaohA/6AKFEa/s8aVupQu4+QcgoSxjtXuB0G90kaQkCrn+2us3U7+87jEqXabOjZ5vLKoNxgqKS
	qA9DhQyWai4wc+ajB9BQVQfT/KIYI/7iODkfMEEbCcPQ+6K0etbkc7jUl233OuiNpPAC6nHwvzM
	VZziWdLTvqEyNoirGf3kr8+KDSEBvBhJvfvcZ+nmOy8d9ygwXRwcjrrY3/X3e+D49yDVUnwMhUv
	TVzxMmlplxdB2G8znu4u+2DfLJpMsQqWH9Dgnc8qZ7Fr52Sull+fga8UA+3E4l
X-Received: by 2002:a05:6402:2552:b0:658:b4b4:5c91 with SMTP id 4fb4d7f45d1cf-658de548596mr2991125a12.10.1769818505431;
        Fri, 30 Jan 2026 16:15:05 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4256a92sm4771457a12.5.2026.01.30.16.15.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 16:15:04 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6582e8831aeso4323505a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 16:15:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQ3+9bDZuQcvB5goYyBYt46WsGc5VFniKWXTtYfUx20n0xfxMp2fBIhjcypHPrvPZrWp2QLxMSvxlBWopH@vger.kernel.org
X-Received: by 2002:a05:6402:1d54:b0:64b:4f44:60ef with SMTP id
 4fb4d7f45d1cf-658de593957mr2779765a12.27.1769818504441; Fri, 30 Jan 2026
 16:15:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV> <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV>
In-Reply-To: <20260130235743.GW3183987@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 Jan 2026 16:14:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgk7MRBj4iwQLHocVCa94Jf0cMEz2HzUAS9+6rGtnp4JA@mail.gmail.com>
X-Gm-Features: AZwV_QjK3epqif7-e_sBGUc-n0f418Z3nV80PkvQC8yX5DIdQ4ynfWKt9EE0KMI
Message-ID: <CAHk-=wgk7MRBj4iwQLHocVCa94Jf0cMEz2HzUAS9+6rGtnp4JA@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Samuel Wu <wusamuel@google.com>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75972-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,mail.gmail.com:mid,linux.org.uk:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9009DBF8C4
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 at 15:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> So we have something that does O_NDELAY opens of ep0 *and* does not retry on
> EAGAIN?
>
> How lovely...

Actually, I think that is pretty normal behavior.

Generally, O_NDELAY and friends should *NOT* turn locks into trylocks
- because user space has no sane way to deal with kernel lock issues,
and user space simply shouldn't care.

So O_NDELAY should be about avoiding IO, not about avoiding perfectly
normal locks.

Of course, that horrendous driver locking is broken, since it holds
the lock over IO, so that driver basically conflates IO and locking,
and that's arguably the fundamental problem here.

But I suspect that for this case, we should just pass in zero to
ffs_mutex_lock() on open, and say that the O_NONBLOCK flag is purely
about the subsequent IO, not about the open() itself.

That is, after all, how the driver used to work.

                Linus

