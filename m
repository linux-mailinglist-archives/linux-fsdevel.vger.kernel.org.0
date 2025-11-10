Return-Path: <linux-fsdevel+bounces-67774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B5FC49B66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 00:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C12318886FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007082F6160;
	Mon, 10 Nov 2025 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RXDBiAkn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC81E2F4A0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816434; cv=none; b=cZQQZBGsiAJLaQCESJV/ObvwX9CIkBknfSbvCvsA8mik3Vv99uzVQ4W4ObkRYet2eNCW4FDTRTfAE8rxPQDqHQrSAqNVTnUCqjI8IpvqLaL+5yKwkFtErVT3KR+v50EuSOBJEeMuP3IPGgX8k/38hfh9LIslRBx/LJIBgkoqeGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816434; c=relaxed/simple;
	bh=6HrRYtMJ/Wfde6dGoSgVBHgpsjkZ4V5YvSNZm+omjEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fx1FczQDpQD7urq/lkoPOhTp3o7wb9rmCWarEKpoGpM1KPj1iE7r96VY2ZW+a2FXtZkiVjVdS/RU569UrKX12PkYUJKbgL4uPjuXXQBDVNxmq+pKXFZsHi1IYUdJLmkNNoQPBGfadFB3caGksrni+0to77SdR60lyaSjkyiaaA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RXDBiAkn; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-343684a06b2so2485158a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 15:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762816432; x=1763421232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3KPhXF0t2wnycc2aLqfqc1/q03aoID4kpmhgGyPorc=;
        b=RXDBiAkn2dVPauk49CpNDOtPnDvSFfSspcrEAPutbLHjiBHmU1W1Ub62avfwLMPtyK
         SQWjsersDoMq9bs4StfgDCQwkqwxJsZpLVnA8Y7kA2p22+B5UUBgOF+JcseAGc4jOlOm
         sMOeLSW22SdBJUHAIwlZdbuJRl52SOQJNJ6EV+6dDsItSbt25/KRq0tMVbY6XtdbU0vk
         MkBSyM0rHtyPpnsWE+kXlPOffLGxD1A83l5m33Qmn2cBrOz2TjaiIqyYb5DG2zTwFqpp
         7Hgh8M8LISoDLOpDJnzozZZRw5TPRWzY9PRCXUkrC0kG+r16N2mS+l8HkXl/13J8X0Mk
         L4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762816432; x=1763421232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q3KPhXF0t2wnycc2aLqfqc1/q03aoID4kpmhgGyPorc=;
        b=FfIncg9rehn92VwF5V312DXL0FicEB2j6dEUViDAF49B7CmPVEgWX1RNhSviaZgys0
         kpzKx7T6UforJY6zkh+mF+e5aOQfTu/ysxkS0+l5RIPrVk1Mjp0E9XGJkTnaNxUq5szc
         kUuxzophD3VE2w3yX0PLeOMUdFDmePX5w2iyjL7dzlIYL+V6efcodyPmiXvzwJdGr5u5
         B9ija/olQnSO7h47hHFbso4VRjRBhBQh28F1TOzmzN2yOfyh9BifTNTy4seWau1HewsP
         VOwnZeAb039yabRnB5c4bIKccLpbqB7Ly3iz4G63XFYPYMlIvTM5n7tGZJRPNYAKLUOZ
         RfRw==
X-Gm-Message-State: AOJu0Yxxk20ey8v7j+xRsg0gifw1IccV8om3ugryZJK6m5BOex0Q3ypI
	MjNVJR96KJdhzIgg1STKnP3Ge1K+GEOE+VgejGkrAy5uL254bp0zYcyJb6h4xaxxNiOKK6dWkIs
	vDvB/Ntz7fkHL26PO8740nUTI8H/79K/OcpSH+l0H
X-Gm-Gg: ASbGnctv0hXnySGB7Fng5Uyes6+HNVOwIkLnKBRsCsJzPVhmEqsF93SkAQ9EAWn4L07
	1Kl8GRRVsVdwbB1TrlHkrtWgF8DBfq4axOcRRGaKcZW8Q+aC+TjIKOEC1dXa36LsR0NUqSROY1k
	hPiSdBOWFJzBczEsFZGS9tGRGxWXCMuIAPSQTRp6TniQlX7ftXNZcCxOEtPEdAyiV5hl5RAAc6Y
	avEuk9bEIAHMbbblzY1+XTw+EFeuiBs0FU+pnNAU6oL8RR71OyMvkx3TjIy
X-Google-Smtp-Source: AGHT+IFYNRYOcq3lXTSLxepvhFlsqHyQOENBHvM+0XEW3jFrOeqIEOlKzMsifFBfU3mbMDgiQHfz3UnA14dsSUJ+7p0=
X-Received: by 2002:a17:90b:1809:b0:340:2a16:94be with SMTP id
 98e67ed59e1d1-3436cb73f03mr11262409a91.4.1762816432065; Mon, 10 Nov 2025
 15:13:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk> <20251109063745.2089578-11-viro@zeniv.linux.org.uk>
In-Reply-To: <20251109063745.2089578-11-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Nov 2025 18:13:39 -0500
X-Gm-Features: AWmQ_bnCgAh0ZKGySfJXTPcRIiGidW5nkGfPuxkAP29SXlrBtrADhb7UtVTCqhw
Message-ID: <CAHC9VhQjzt0nJnbwXuwT7UPBwtHjEOPZu6z=c=G=+-Wdkuj5Vw@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, mjguzik@gmail.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 1:37=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> Originally we tried to avoid multiple insertions into audit names array
> during retry loop by a cute hack - memorize the userland pointer and
> if there already is a match, just grab an extra reference to it.
>
> Cute as it had been, it had problems - two identical pointers had
> audit aux entries merged, two identical strings did not.  Having
> different behaviour for syscalls that differ only by addresses of
> otherwise identical string arguments is obviously wrong - if nothing
> else, compiler can decide to merge identical string literals.
>
> Besides, this hack does nothing for non-audited processes - they get
> a fresh copy for retry.  It's not time-critical, but having behaviour
> subtly differ that way is bogus.
>
> These days we have very few places that import filename more than once
> (9 functions total) and it's easy to massage them so we get rid of all
> re-imports.  With that done, we don't need audit_reusename() anymore.
> There's no need to memorize userland pointer either.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/namei.c            | 11 +++--------
>  include/linux/audit.h | 11 -----------
>  include/linux/fs.h    |  1 -
>  kernel/auditsc.c      | 23 -----------------------
>  4 files changed, 3 insertions(+), 43 deletions(-)

Looks reasonable to me.  Not sure if you've run it through the
audit-testsuite yet, but I'm building a test kernel as I write this,
I'll let you know how it goes.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

