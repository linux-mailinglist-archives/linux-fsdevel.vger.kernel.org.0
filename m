Return-Path: <linux-fsdevel+bounces-77217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO0nNIegkGnkbgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 17:19:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E5A13C73E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 17:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A867301E6F8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 16:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3DB259C84;
	Sat, 14 Feb 2026 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bk1huQbZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C6A221F1F
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771085955; cv=none; b=IACplrpL6YFYqOzfjXqTgfhX/Edb9YClkSLyY/ShHqk+BHCY8XLz01vpSI1QNH0YBSxJz0nPxRwv4nCDMtFKajnmmAL0VQ99THrLmdqG0576PxCtjjn4a73sb9zIDFWKh35G2W1wQDo8C+4FC9tbMmb6xerJnNARiracxPwqOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771085955; c=relaxed/simple;
	bh=qxQX9emBfxvUkUNtELczv4elnJMZ8+ObsrUkG0p2x+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/xAtURlEnNnx92THTc/zMGTO/DCDkTqsoaEHjAY+QnbSm32pz2K/pq0pVPpJA21Sw8TAjUB7nQ2zrrsfxfG1z511br3NZvQ+vI3KK13gA1QW3zIKQIEtoF30B8X4C1aTFq1wNM7SSa4SO55LEthWB13iQfEUjUr8lQ2yqFoUPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bk1huQbZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65a3fdeb7d9so2806559a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 08:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771085952; x=1771690752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lMTkSuGrGkjDZX15xgRpxEd+7gPRM5+isFg0IFlexF0=;
        b=bk1huQbZBE8ChwyZLXiNs0bNfsBEl6M//bvX/M/iAEp43i6eEJk086PBxzwYJhBGUb
         b9WEFWysxVfIKo5GYbwTGepmegR4ELIHE0gpVAOdHM7hH4FR+6OaBZFs5Issgpv4zGaD
         rmP/IbIsNcmxFnG/B/ut6dTsbdplvXV0oWLnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771085952; x=1771690752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMTkSuGrGkjDZX15xgRpxEd+7gPRM5+isFg0IFlexF0=;
        b=LZD1T7w2JutIzZw2SmWOqIkYzFD/1AHqyplFPt2SPp6NfHCWkcEkn5c0PCs1v2OClm
         0yh7u1wFBQchMe8mY/POG8g48I2WBlqo9i1faR2sjCWOWxciTB4hs9sBDSR3VUhT92T6
         lrgcRUGK+dDqBg2Wc3GDbsCsvnpXyzdIWerEvsnLJWKb6AnL4NnEZRXGQ18hpnAXWZPx
         TlhavGZJh9TnXf3DSGg/2Ib4kKJrThe4PjVucQGSdXYtnBL0hBkTFUrZpZcLS2+2hcyk
         cYZWfJ5tAWGm/YBmR+81pneKYDiUDbPNgi9JSFroSsuTY3/lhSoyld65HLieyEyqz1Bz
         PvCA==
X-Forwarded-Encrypted: i=1; AJvYcCVwsU4kK719XYdFAEcz3NlQpxPRcdlh67o2gAADDgHSQVbp0cJz0Maw0oNl7QGo3mszFkEfFAt3t9DiRBtS@vger.kernel.org
X-Gm-Message-State: AOJu0YxPACUtTxLSsF/cg9VA5ShSG8cmonrC6lRFxoth9lCTpDwWON3Y
	1V/UV7SlAoNGIKaU10JTWqlhN9Hf15b4N0ZREAul1n+UkmxX/dBJn6ZHO7EvNnF2CAY27tMzCmf
	skyX0YFs=
X-Gm-Gg: AZuq6aJ6AzbNVjEdPd7NXsBoKH0Khzn35HKW5aUnPtMNGhCShwm36JQJCf/jP2ZdXCI
	KqiQJoVuhHMqfX+f42I+pAxufrnbFhMhPhofKTodpL29dZxNcUpyP0cnASLccy1YDyJPM36ZPR6
	a/6HXOjHF+RtUOb89s/gjuhRT6caZhdv0/h+ZvCltCFmdj4NQgFH1SdwCwUmWdMkJo8SFMIIpKQ
	FBMZx6bfWwxiLtZHlbEJGl6eN0l1cImMeN1PXxUv8fzNXhSHjJwbLIcwA0m5yXQeZArcXOArjxW
	UBZxMUbYNgNyxaBHqNiB18AzvoECIdI4S+or7v4JRfGi9uAsMu2vHbQvLU2u6V7xPnY68O+N+XZ
	MOoM+0C/XLfsBqBp0SjNPgB1Q5BrF/Dn3wTN9IzXeXGgFKRxraP/EijpPqphcQR435ERvnKTtCc
	w5Xc4roJ24ltGsif3W1QnoFq4AKW6VpvkU4Y09reHnX5ebrcntghmOY6qczHFWYlYOofrwZ4e7
X-Received: by 2002:a17:907:2dac:b0:b88:5ccf:5656 with SMTP id a640c23a62f3a-b8fb449d481mr350817166b.31.1771085952230;
        Sat, 14 Feb 2026 08:19:12 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7626bdbsm77881866b.40.2026.02.14.08.19.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 08:19:11 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65a3fdeb7d9so2806547a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 08:19:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqJJo0DMCd5hSMSQ4fsSIvL3cuUzmpgf22Pcyvy529B8JfymlJYkYI6UJtdXZpH+FwI6YmF854O9I18j4v@vger.kernel.org
X-Received: by 2002:a17:906:d54a:b0:b8f:1c:e815 with SMTP id
 a640c23a62f3a-b8fb44fd4b4mr299770466b.48.1771085951749; Sat, 14 Feb 2026
 08:19:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgQDOUff_F28xaTB-BvSHs9YC3bxXJa0HjpSTAUyPF-Ew@mail.gmail.com>
 <20260213182732.196792-1-safinaskar@gmail.com> <CAHk-=wiB7BN2BnBjk5y2Zim_vveYg7GAZA_N+XjrptY59Qnzzw@mail.gmail.com>
 <20260214-duzen-inschrift-9382ae6a5c2b@brauner>
In-Reply-To: <20260214-duzen-inschrift-9382ae6a5c2b@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Feb 2026 08:18:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiG5uhN1F7fxyEiEQdMtK_j8TCd7FoStbCFpNbn8qx7iQ@mail.gmail.com>
X-Gm-Features: AaiRm53C0q2fJhPXDmVbEG4QR1DzF14dU-8oy53MCoAIXro4-5Zg--e-5HZk6Io
Message-ID: <CAHk-=wiG5uhN1F7fxyEiEQdMtK_j8TCd7FoStbCFpNbn8qx7iQ@mail.gmail.com>
Subject: Re: [RFC] pivot_root(2) races
To: Christian Brauner <brauner@kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>, christian@brauner.io, cyphar@cyphar.com, 
	hpa@zytor.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, werner@almesberger.net
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,brauner.io,cyphar.com,zytor.com,suse.cz,vger.kernel.org,zeniv.linux.org.uk,almesberger.net];
	TAGGED_FROM(0.00)[bounces-77217-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 34E5A13C73E
X-Rspamd-Action: no action

On Sat, 14 Feb 2026 at 04:15, Christian Brauner <brauner@kernel.org> wrote:
>
> But my point has been: we don't need it anymore.

I don't think that makes much of a difference. We'd still need to have
pivot_root() around for the legacy case, and I do think we want to
make sure it can't be used as an attack vector (perhaps not directly,
but by possibly confusing other people).

Not that you should use containers as security boundaries anyway, but
I do think the current behavior needs to be limited. Because it's
dangerous.

Maybe just limiting it by namespace is ok.

Because even if the "white hat" users stop using pivot_root, we'd keep
it around for legacy - and we want to limit the damage.

            Linus

