Return-Path: <linux-fsdevel+bounces-75356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEohMHAFdWnx/wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 18:46:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAE27E602
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 18:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 905963006394
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 17:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735C815E5BB;
	Sat, 24 Jan 2026 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DZSPp5m3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4718B3EBF0E
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769276776; cv=none; b=ld1Br54u+QEmgbe7C8jbaZpWKGLdjgLSNXV/t5+vzPZCN+0E9gKMOjDGFWP8BLoIyNgp6S4khINMJHLerL6ANG6FXyxkKbx/y5ornPBVp18/F/zU2BRo3TX7sT1+wNlEAWBBRlk9lTYzGioyk4bhoKNF+LyT/n6rpKusvvfOfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769276776; c=relaxed/simple;
	bh=s7vUhsuQcI6ljWpTeXUTHbT3be4LrJOFULQfFIUNsx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpKNbZ95if15q2pY2+Zo/EWk/awLP9Gm1HLCl3MLHvaqEByPnd+j3bjz2sii9FxdZUDZHTFthUyVfWjl4ELhvd6HWyY359qoZ7BtjJWDWiTdfWos+W/IMuS5ytGQpMeYxTH6W8y2QpsnOvdITvmWb3SPV1MJ3hHcb/Tp16d/gBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DZSPp5m3; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so4964408a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 09:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769276772; x=1769881572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a860oab+rFNYoCqrwGo7YpHA3uci+MoPPUl+nEJ6f0s=;
        b=DZSPp5m3CNHxRsxawnIU24zpujdJ7lPjVbAMGFF6cLPmvIC8KDGPDp0uSniZWp0rp3
         x8KBpjAsqdb/ulsyNjN84V5CG6UQiV/QwYZ6sfZgNr+BTeVdEemq6HylUxeiiwZo/0aM
         5Sk4q0z+cU4shXKshkOI0fo0OzGHa3Rms3Fqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769276772; x=1769881572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a860oab+rFNYoCqrwGo7YpHA3uci+MoPPUl+nEJ6f0s=;
        b=QgG4OdorBAzR0axQcc0+TBf7zihgkHgnN/xsSi1Aun0sOgvS9pMQyQg+FAvDmT4U9j
         8eP1yDAEDL0SwTKo9G1Ua6tgGGGa7Z8R/kdRPKTCy1Jx3tXQrVWv0UXARpF+t4TLfPI9
         k8/KQTIn9pfzhhodmM12cw/hHviLpQgktZ1lkXvd4kiVmtvneUg6I8hX1CS4lB1Og8wd
         3oLgdEp2nTxiyc6OGh8SGtWeXwurHHVnLCpPzJ1o5LMYVopg8mN5+F8nBo0i2ua5whVj
         B2W45gQ3WxyrZdriYiBpgc4EUru/CvR554aG3odA8NX8hkMgnsOVq6E4SNBiuScrIR9N
         9GJw==
X-Gm-Message-State: AOJu0YwoKtlzUGsTFFSh8y006fCDETUMzRxzwIJWKXRtNWMqAik42ZYj
	+Bx/r+fuVa+yNt9gKnxJBHlieU7ZQU7xW82wyew48RboZ0xeKjGyXTKR3bQDpRH6Y7jjwmvW/gI
	DLHv9Tq8=
X-Gm-Gg: AZuq6aKV547rGtRGw0CNNym6L3RAhkr/yunJxFLXkXlWZXuq2imeoAp1hsjFBZyAJSM
	E3qURqgtIH/7qoIf2y72NbVyql2+rHEC9ORH4LH6Ey7ncWJvwFF6VcH0wemcJ5Cbxozz4WwfBwm
	JdPtvRHckHpnBcSxxM+lnadRBbf8xQeqcxkVqxbgzyddSGpo8ssd5x2UwqKJgJ+sdng6MoPPUb/
	wVnHBv0C8J6dafXiDSSytLNb0im7+RrxeOPd5YPmar+nSFWHZ9xW2dsxpQXJYIpeikRRo82jBGe
	MMQzs/U3sXz6nl0UE34pRGy6Ssja9/e0dhXCUJmO5oSu9PeFB0tbHs9EiQ9EAdB4QRjn1EPqT+Q
	DSTsJvubyZuRb2r1/+lnq6S5KDfIssIYLMEtFTEr+sbNCrYmRA5DDPHAo9qEWZBF/mHH9+fjN09
	D4vk/uhgsuX1U9rNJ5fSWJcBYt8LaYIA4587GyQvJkC26kl47Vz/r4Ks01HIpa
X-Received: by 2002:a17:906:6a07:b0:b88:599f:703e with SMTP id a640c23a62f3a-b885ac0fc30mr442978166b.2.1769276772285;
        Sat, 24 Jan 2026 09:46:12 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8872854909sm193500466b.44.2026.01.24.09.46.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 09:46:11 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b885a18f620so368698366b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 09:46:11 -0800 (PST)
X-Received: by 2002:a17:907:944e:b0:b7c:e320:5232 with SMTP id
 a640c23a62f3a-b885ac0ffc4mr485625666b.5.1769276771121; Sat, 24 Jan 2026
 09:46:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122202025.GG3183987@ZenIV> <CAHk-=wj1nKArJE8dj+mwF2bGu+N2-DL0P2ytaLYJRrDdPpa9MA@mail.gmail.com>
 <20260123003651.GH3183987@ZenIV> <20260124043623.GK3183987@ZenIV>
 <CAHk-=wgkSAHswtOzvTXeBOz1GLNfsohSPdyzZmnVYe2Qx4fetQ@mail.gmail.com> <20260124053639.GL3183987@ZenIV>
In-Reply-To: <20260124053639.GL3183987@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Jan 2026 09:45:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgGCyjEC9ookrcVou4__nkPbSosP7RG6AwntBZbdeAjuA@mail.gmail.com>
X-Gm-Features: AZwV_QipVsyxObYyhvCmtoZ7WIApowDzsCOO9OBU0SPdlsuWvW_TMdKYgQks_AQ
Message-ID: <CAHk-=wgGCyjEC9ookrcVou4__nkPbSosP7RG6AwntBZbdeAjuA@mail.gmail.com>
Subject: Re: [PATCH][RFC] get rid of busy-wait in shrink_dcache_tree()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>, 
	Max Kellermann <max.kellermann@ionos.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75356-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.org.uk:email]
X-Rspamd-Queue-Id: DEAE27E602
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 at 21:34, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> The only trouble is that as soon as some joker slaps __randomize_layout
> on struct hlist_node they'll start flipping from sharing with ->next to
> sharing with ->pprev, at random.

If somebody starts using randomize_layout on core data structures,
they get what they deserve.

We have tons of data structures that are *NOT* randomizable.

In fact, RANDSTRUCT is so broken in general that we actually taint the
kernel if you enable that crazy option in the first place. So no,
"what if somebody enables it on random things" is not even remotely
worth worrying about.

            Linus

