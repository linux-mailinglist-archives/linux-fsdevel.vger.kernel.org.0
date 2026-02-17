Return-Path: <linux-fsdevel+bounces-77475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCD7KpT9lGkUJwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:45:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 510F2152006
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CEC7302A2DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED1A2F5485;
	Tue, 17 Feb 2026 23:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bYlq5KV9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30F832E758
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 23:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771371914; cv=none; b=iNe/odOzyW7s0umAqtBDp0D3u8qG8CsRNtfcSijONY1p4F7FglS8XQYWJ1P3nAUe5w2xKFu6CjrDSXfv2mv92zGL3hZNt6zZ5YjY7tObF9MCvxcTa/MKgWQ3eifJx82F0gYw4HhqWC+w/Po0DtBVjaC9/PIDQSytazr0zejcBgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771371914; c=relaxed/simple;
	bh=OvqXXTPdxfmOoIn5hoNaTIGbVFqcQOrGChB/0aaijGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPaeDBLaZvZDYnvHEa1p6R/KjdvMjozoaJb3RTzN5URzfLkwBedImcBnjbT6fas9haqnDuoZU2qKGfqweoGBWxwRi1S8e216BjL7vT5eSFTgGuxzfXwqrpOEeeARcVYH4FjX1WMV6NyXF5G84tC2EPBnYk3ECoycU3+mQ1D3kWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bYlq5KV9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65b9d8d6b7dso6246788a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 15:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771371910; x=1771976710; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2W5hq4vSopSGDhHlvQpYHBQQg/nJJXPOdc+2UKw8HtE=;
        b=bYlq5KV9E91ez/K4E7l3d44LaEs3aaw0MxYIGtmyd8lhXlNU6vTdvoUPfapqefcUtl
         yeDCUm3irR/cfumoUAL6ZarQnIPz9yghcuJo+xe6HTcdlFnJjy6+kF/K6XJyhiE4tCST
         cMKdwGofOn1gOx4YGsIoDOmdr1wyggLyPTkE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771371910; x=1771976710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2W5hq4vSopSGDhHlvQpYHBQQg/nJJXPOdc+2UKw8HtE=;
        b=kzwPngGz7s7tLSjQ0KDSxdIlE29+pUDqSmOA4gjdqK304muSnUYbi6hhI/s5idmVeX
         OH0Smhd5btDkO4LFAbSGYZBVipqOiTHHLD1VNNDJbDyc06+kAl3HkbZIPXnok0iSjCXb
         RWT/fNsoykRJFa9XrhVBKhwLxWVsV2klGbIIQykvDYGiQiXIJZ5S/oMCyEJ9fW7HMavW
         KqRVvcATVynoLGOb8JUsIvpwjUU0nV/l4nEDTB2rETptDBniabHHtTAf7QQ0x/yubWdk
         U1um91vNTgZXneYyV+mudmago5ZiOHlzZnVp8Xv/D2/5HsAnhpYex8rQMCQzXjSaWemN
         auQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIc0DeJws2QGSzNASaWV+t1Tvj4f0kl0X1W4En3gEoEezeSrUNfg8yqnTVBqx58nXy/WMwjn5ZAvSVCq+6@vger.kernel.org
X-Gm-Message-State: AOJu0YxeKLHG2wcdx7dq2hpW2Z7qUEfQTudFaS7AlVDJQcuOm4LyWc/y
	2Ehzs++BYPjc61eihEFrYqp8/Oj3DkGKrOqVF0TYK3mGB2wGr6m66e6X435FdbnXfsLGOrPx16R
	gBbIvrIpwcQ==
X-Gm-Gg: AZuq6aK1fFZoS1p9GzZ9RGnwRitDQJZEl0AqV9KdLpAUpW2qBj0n4bR32RZqW/Q8SFh
	QQOVzXYykmdt3Dk/+CcocjZQ4boFlq0O+l4lLIz3p8g9csqR+LjNTWnw4sX+O2U8YZlqcxJleB2
	UkS5w976XcydKTp5e3rN+LtXJgXa4b9y3m8ryEcBlOB4HDUIoir6GNzfZJbOhCN8Tm1/LpiEmTE
	GRlzaA7YP+CyHtUmGasan4CLul5JjgQdUHgGuTG63C6T1cjOazyUYGp4qMNtEHAhZtLV91hVaqK
	4dyf9bPFvx3QcwbeD3HkVr0yggHDelgUAci8BKtHCdSlfKSMYVjl4CJNnjfZtq4ZQJd/kRjj2nB
	73ndjTVen1VFxoU8Jev7C53ZMytSH21ws/c1T4u3iq9XH2msdi752SxLTTpF/kEL5OWtlzsoSXO
	kIpthqxJnxiBdysJOC40PlLnH/KlvfI7MSDnVPfLar6ks8V1FB+VjCLOFriGH5XMEKTel7qvnQ
X-Received: by 2002:a05:6402:27c9:b0:65c:14a3:2aea with SMTP id 4fb4d7f45d1cf-65c7693d129mr140254a12.5.1771371909096;
        Tue, 17 Feb 2026 15:45:09 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad3f0b55sm2760925a12.23.2026.02.17.15.45.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 15:45:08 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8f992167dcso590830666b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 15:45:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWp68N1a1mdxnsDLT5DSATkTIEN9ZW1nURXZnJ/xNZZILtBG44Phea3a9i+jZkwkcyxVQqioLbqIYA5PjDU@vger.kernel.org
X-Received: by 2002:a17:906:f5aa:b0:b87:3cac:cd4b with SMTP id
 a640c23a62f3a-b8fb41d56c8mr798936466b.15.1771371908306; Tue, 17 Feb 2026
 15:45:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org>
 <20260217-work-pidfs-autoreap-v3-2-33a403c20111@kernel.org>
 <CAHk-=wj80zwxy=5jp5SAi64cqCZgRjY1cRokVuDPd9_t3XMvUw@mail.gmail.com> <CAG48ez2YiL7RZ1fm9vwOCDGr9OsDrCHrCmkyRRoGRMWUZjyyBg@mail.gmail.com>
In-Reply-To: <CAG48ez2YiL7RZ1fm9vwOCDGr9OsDrCHrCmkyRRoGRMWUZjyyBg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Feb 2026 15:44:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiPJfnTVq6vUF8K8kF0FfrY2svAqSwsL8xLEV76pVyEkg@mail.gmail.com>
X-Gm-Features: AaiRm51vFyrP0sUUpGaWBzMFybypzlMbl3_OfNWRp9mBeMKbP0brBQ-JnK7IoyE
Message-ID: <CAHk-=wiPJfnTVq6vUF8K8kF0FfrY2svAqSwsL8xLEV76pVyEkg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/4] pidfd: add CLONE_PIDFD_AUTOKILL
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77475-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 510F2152006
X-Rspamd-Action: no action

On Tue, 17 Feb 2026 at 15:38, Jann Horn <jannh@google.com> wrote:
>
> You can already send SIGHUP to such binaries through things like job
> control, right?

But at least those can be blocked, and people can disassociate
themselves from a tty if they care etc.

This seems like it can't be blocked any way, although I guess you can
just do the double fork dance to distance yourself from your parent.

> Also, on a Linux system with systemd, I believe a normal user, when
> running in the context of a user session (but not when running in the
> context of a system service), can already SIGKILL anything they launch
> by launching it in a systemd user service, then doing something [...]

Ugh. But at least it's not the kernel that does it, and we have rules
for sending signals.

> I agree that this would be a change to the security model, but I'm not
> sure if it would be that big a change.

I would expect most normal binaries to expect to be killed with ^C etc
anyway, so in that sense this is indeed likely not a big deal. But at
least those are well-known and traditional ways of getting signals
that people kind of expecy.

But it does seem to violate all the normal 'kill()' checks, and it
smells horribly bad.

            Linus

