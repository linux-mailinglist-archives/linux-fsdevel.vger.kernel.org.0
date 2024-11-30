Return-Path: <linux-fsdevel+bounces-36187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF329DF26F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 19:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA068162ED5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 18:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE641A9B33;
	Sat, 30 Nov 2024 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QUbR5MoW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE2719EEA1
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Nov 2024 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732989780; cv=none; b=BY8vOwnd9GmNQ+OM/ZKyaMnZ5t3mbN2+vXjAmq+fgIteSbz0JoRRjgRqCqedo4pMJjcDuj6mqEyZ6UqzVDWcKFVZgjb54uf1iFLqCHwnXhDDrJbSclNlbb9HT7ostqWKRYYHTx3+22/f+TrKVVViyYWpWCBbirQR+tPWR4B9+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732989780; c=relaxed/simple;
	bh=5COwjKHdAiMaJwK/Hx+9BfwsgIdb3l+pVKvrV5yLzNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqMKAnp1egFZMEvDtKYo45oIdWbES9cygQIeKEYkdVXs62LrknAyGCKM7s68gAaE7VcDfEEtEKQheVpT5Qql05/W92ElzSzjaq3qLbtYFxD+qe6xIrig6/XQxs1/Yo/iXVYBZ7TmwG6JxnTv1e98sO72T7s/neIzaPOeACudKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QUbR5MoW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d0d3dd3097so406511a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Nov 2024 10:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732989777; x=1733594577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RbB2vuXpy4jWACIjXNfh0gThH+CYe3wsKjjW9mdP8c8=;
        b=QUbR5MoWd9pSEZLRhF3Z06FH3jDIa9Gb8GhLVCi2qZ1PWhCngSQQON9Qhd8oUdxuLn
         JIIqntu1/TfJWtq2pC197dvPFAELBauziBYIPOo4tprLJyr/BHcKM/UEWLh63y3eQU1Q
         QrFKW1dRKKNaq++MY4tRkrjlfoSEMnEScnJik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732989777; x=1733594577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbB2vuXpy4jWACIjXNfh0gThH+CYe3wsKjjW9mdP8c8=;
        b=K8smxA9FI6zY0REvuRlG7AE58FJkP3iJ82e9axi2Nkg3EQH7GL3itvoHLLJcKczOG4
         XIFQFim2YD26HITzLBdpsSUxFUpZ1WZqfGchrk7VSb2aH/SgHVloImMigrkT1pRuPIz8
         g9S3Q8te3yBS4wlt2GQyV0UciM0/JsLDfNKaBPS1wiKNzozLO9CI1PhV5hthhM3Njc9I
         Y93sJQkn7zTYf1WKB4oo6jdznAqcEEKl88sK4gBeSBeOSW6bcG36NfTxogAZU0SFKNf2
         N8dKyjPOUur56bQA4htAp/ONqyn76m0WalYOXBBEKHCGc6TdYWcH210YQDy21WLWFf89
         5XfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1GhPcUs8bVkalrfJ2Z2XLJaY5gJA68dxrCX6VQb4+tZPVoe4xMsdOJlh7yHF3L+wi7ADuaBATWMNHaM5T@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Z8zDEWOpViO//ilpfB4jEmWE55HYxAkKecRX1afJfBC4ePLB
	xKGDtBphdIEySDv5H1DTqOEDPrhrAPcijg4E9JGd5jySRaAZgaZ4dC6SHCYqn90CNha86Htf0s4
	8NBhUTw==
X-Gm-Gg: ASbGncufBzdY3Cdl00GT8hiEiclWOqIj1TINkN5D0JXG0SVFbokR5WTK8Befuljtrqg
	5Fge2MvO+GZX71qiH7zLbO17grRr5yGXFsHgmBhHHqeYZJdY4/0FkN2h/Wi8W8onG+QeHVkJcDF
	n8l0BB5HqbwGse1GD4XQcOuX12WocmTvJVeg2+TZ3pEKDI/a1vSDKoqLh/g0eOkuEbeVUOj86Le
	uCgAc1tGEpAuQu/jcDTqw5ZCIJubjoR/7rC/VxGNj0r/S0K8Ur0QVsu6WU8+/j7yAeHJ3P7Oidu
	jaZN2BSNPcKryCdIfrH6eEcq
X-Google-Smtp-Source: AGHT+IGAN1cmMRBviMLtxHCGxiCuaXlMEuCggJm5/XUWa6phGN9jUAxLUQMNxzqmr4Dj9Ou0S1v6qg==
X-Received: by 2002:a17:907:784f:b0:aa4:a853:a65 with SMTP id a640c23a62f3a-aa580f22c2dmr1585677766b.21.1732989777009;
        Sat, 30 Nov 2024 10:02:57 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996d8b7asm300689966b.48.2024.11.30.10.02.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 10:02:54 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso552250966b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Nov 2024 10:02:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULIxBipINmpZpR9dzeItYsjmNF+ik2y9jFlbXwDbeFOAGVakg+j2LJ9fx3DkJub3UszHE/3TEaPtSIflFA@vger.kernel.org
X-Received: by 2002:a17:906:1ba9:b0:aa5:cec:2785 with SMTP id
 a640c23a62f3a-aa580f50e22mr1700257566b.25.1732989774448; Sat, 30 Nov 2024
 10:02:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130045437.work.390-kees@kernel.org> <20241130-ohnegleichen-unweigerlich-ce3b8af0fa45@brauner>
In-Reply-To: <20241130-ohnegleichen-unweigerlich-ce3b8af0fa45@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Nov 2024 10:02:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=uOYxfCp+fDT0qoQnvTEb91T25thpZQYw1vkifNVvMQ@mail.gmail.com>
Message-ID: <CAHk-=wi=uOYxfCp+fDT0qoQnvTEb91T25thpZQYw1vkifNVvMQ@mail.gmail.com>
Subject: Re: [PATCH] exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH)
 case
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Tycho Andersen <tandersen@netflix.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 04:30, Christian Brauner <brauner@kernel.org> wrote:
>
> What does the smp_load_acquire() pair with?

I'm not sure we have them everywhere, but at least this one at dentry
creation time.

__d_alloc():
        /* Make sure we always see the terminating NUL character */
        smp_store_release(&dentry->d_name.name, dname); /* ^^^ */

so even at rename time, when we swap the d_name.name pointers
(*without* using a store-release at that time), both of the dentry
names had memory orderings before.

That said, looking at swap_name() at the non-"swap just the pointers"
case, there we do just "memcpy()" the name, and it would probably be
good to update the target d_name.name with a smp_store_release.

In practice, none of this ever matters. Anybody who uses the dentry
name without locking either doesn't care enough (like comm[]) or will
use the sequence number thing to serialize at a much higher level. So
the smp_load_acquire() could probably be a READ_ONCE(), and nobody
would ever see the difference.

            Linus

