Return-Path: <linux-fsdevel+bounces-76781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC0eOrR9imnVLAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:37:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C31D115AB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EF653023DB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2139231829;
	Tue, 10 Feb 2026 00:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E+ql7Ujh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA9B665
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 00:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683822; cv=none; b=NUDFjewq7245zEmePbTx3A/SrDh9+qzJuztjCW/6zx5ylXs7HKjSAwQmUZEOi06FkRvP22iq0FLsRgEh90gOXCLqAfFNH2SU5hnVnEOz2Oum2NJuLSRsBvZJOEr/2/sej2lsrgNI0Dy7WjSwGhugtBs3L55UigEgFobhYxk0UmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683822; c=relaxed/simple;
	bh=IiKPsgR7QfCi4vKtDqZPqOSZWD+sEkHdcjplQQv+he4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZVME4wANUxFL/nJHXs5E3oAGx7GB6WyoBvFLsAzPqboDe6g4+qOL37qJ+Ef+E45iPbQmaB8Av3EoZlhrsaxUksdkZSFtiGdjxIMrRU/2hBR20377H8M3cfmmoT6vNvPdNZqxxVcpSJHtei+IAgUOGhVyMNiFa9WQetvfXAmRRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E+ql7Ujh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-658f1fde4bfso9343524a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 16:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1770683819; x=1771288619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oBG+UMiNUvVZrktDtgKPd2k9tfXICj0gH6B6DW/z9+8=;
        b=E+ql7Ujh4FSIfgsm34gbH36gWDAxKCLm21WM3a4DMMTvyZQV27oN8ePWVSQ4cHD0BZ
         e6qokLWRmZttd/n4Y2kjSaWmlkxcqDVWxnlR+s0W9C8iagTyMrIxNsJJ0ZD2NIxFZiRU
         DyVI7K5hl75cAbYfY2PySumkpYjyr1zJifXp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770683819; x=1771288619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBG+UMiNUvVZrktDtgKPd2k9tfXICj0gH6B6DW/z9+8=;
        b=f9ANWkx/HSZSC/rOmyEvnXRCclF3oNk71+28ggtOYyiOAyS8dBJdIudq7lJgn7lf8M
         ZqwOA67760gsNKXWTgt+oOvEqH0temm9JQwzYJ2AdB50AjL2RTpPgNuU9wcIsejtQgzz
         ClGMKr+dzddXRa/ERSqisVsf9i8HHYv0Ag/1owc8hL+CMMLsWtnsTIwiQaKo3IrgqYev
         eflZyi/1hlVOzhoPgAXwslpD9FrioqjkaLG44uId3AAuWoplWaFfFPl1tgrmF4vLRzgJ
         Q+jo6Hw4Rh7+SQzDBBE/aLDEydrwZvcJyw+MVjBFZ0wlK0ODAUfLyKh5C5IWK6T87Hhu
         gFHA==
X-Gm-Message-State: AOJu0YzVdqnXqyTcv+Lan2989e+7NA7/XJ1QNXyCtBQKhhC7sjG0BMgg
	6tYjAxh8cnyfM8gpwujocrSXwdpFZUUZ3v3LKtoAJ0oZV9jTGITmm/WJHNs9MAG7SIIsdZpb7fM
	N8PydONE=
X-Gm-Gg: AZuq6aKJeR+YDYb9BgVDCMHGaUmwsUlnRKIut1dsa4HzLW1+9Az+5PjN5NyiY6XIqmV
	q/legaqPwNs99Qd7yuMiXKjjyk/tyeQCbtu8QiNiLNnnYBALVMoAt5pVbqZ6Qe7yV68vsNyGMkH
	yi+ihbpI64/GhWFXxnaJYIj6pjpgSlcbtvGebkkWn9Uxvoa+73BQ8mOPA4mq0nW6Ove7tVwUK6U
	Yo4Eu1slyETiSypev5Uxvm8YWyA/GsU4xBVfBX1F6MGoPivepepcOtOsXBB7WfKv3jL/l4wT1mY
	jVI7Ud/h8vYfIEMhIiHAD5fLK0NBeuoOm227/0xtK/mrBU7zTfU3fNEkErKW2V+1L2qHjvMvV2j
	I4rEbBGSczrXfJ9D5mXV46rP5n1+8YcrlJJH3tIkAv0kF/wdx63XtotG2kKkmyKiKCkQc7K9uKY
	ReNoSkCLB20GyxBpxgwL1vcQtbalpzRlMLJEtrhuT5puPy6r/W5+crVgDWkXBy
X-Received: by 2002:a17:907:d8e:b0:b8e:fc90:7119 with SMTP id a640c23a62f3a-b8f50cba4aamr33514166b.30.1770683819157;
        Mon, 09 Feb 2026 16:36:59 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8edacb18c5sm463209866b.43.2026.02.09.16.36.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 16:36:58 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso7899721a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 16:36:58 -0800 (PST)
X-Received: by 2002:a05:6402:3514:b0:64b:5851:5e7b with SMTP id
 4fb4d7f45d1cf-65a0cf6c05amr292173a12.14.1770683818381; Mon, 09 Feb 2026
 16:36:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6dd35359-3ffa-8cd5-a614-5410a25335c0@redhat.com>
In-Reply-To: <6dd35359-3ffa-8cd5-a614-5410a25335c0@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Feb 2026 16:36:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjmFiptPgaPx9vY3RG=rqO452UmOAPb1y_f9GQBtuJVjg@mail.gmail.com>
X-Gm-Features: AZwV_Qj31AKvgX6i0EqL83vWr7BDyctcVB1HOmPz5Wh105T9Qo_ZXZMN2CgkPyI
Message-ID: <CAHk-=wjmFiptPgaPx9vY3RG=rqO452UmOAPb1y_f9GQBtuJVjg@mail.gmail.com>
Subject: Re: [git pull] HPFS changes for 6.20
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76781-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5C31D115AB9
X-Rspamd-Action: no action

On Mon, 9 Feb 2026 at 09:01, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>   hpfs: disable the no-check mode (2026-02-02 18:06:33 +0100)

This looks like a totally bogus commit.

If "check=none" suddenly means the same as "check=normal", then why
does that "none" thing exist at all?

None of this makes any sense.

             Linus

