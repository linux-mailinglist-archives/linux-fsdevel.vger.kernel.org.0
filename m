Return-Path: <linux-fsdevel+bounces-41324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBE3A2DFE1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 19:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4F61885CE4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 18:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9BE1DFD91;
	Sun,  9 Feb 2025 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LqlASizn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FC0CA6F
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Feb 2025 18:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739125090; cv=none; b=tAkrJgUtZ56HQKnmS966EdiCieZMsydBNmCn2CptwuqCh9xVujx1EFXsmp5pBbJ9yI4RQ8v1dNgVPCylku9kQyRD613XxddQQ4ry8IQBngarKdbE1azEeLVFtUPU+XOXONu9r0mBw/0Pg6MXsBinjwBKPybCYAUWmvLOHlF4j4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739125090; c=relaxed/simple;
	bh=W3CtYi4Z88+6aVSD35NGtCbEIEaD6AszZa4ps3GQPE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sK6b2Rh7brf7R91IzFPokoT6w1dpgqtL+OAZjYtSqtLUUD6xGj3XRRzr9NkieV9MBiDsoeC5DcZHripDQOygGj4JgRUqVe2hTflYZPDyxNJoyUjrQk2KiyN+xwrV1KFWLKPp1PEWWFoLzjc5tSjDlbEjX8Krg99A76Wkt8rcFcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LqlASizn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab795ebaa02so334863666b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 10:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739125086; x=1739729886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C/ylRg0Jxp12DciqYX00fFGZholOPej5f3TNUZ4A9Rk=;
        b=LqlASizn0Lll+HAgDZB6u+ZNJO0krKR8NqVbT7rc/AreKbpsbtuFpjibEe4gzwRom8
         x0WMjuryvl7ePTLdFKhp9wlboozLz+qnx2KcGcyfwot26JsK6ijr/cwQFEyElArN1CEJ
         A69Vjei959b/KSRnkbuggpnDWn0kZmV39O3zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739125086; x=1739729886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/ylRg0Jxp12DciqYX00fFGZholOPej5f3TNUZ4A9Rk=;
        b=bplQzaivucqUBoyFTTlgeVyshereDU7YB5YqXas+jRLnGLFlyjhKD0e+tLLLQl72rY
         toDkhW9bfCcD3oHqnMvp7mvgnSqAbb1ucC/hDB9Ehb7fr6c9+5h9yvSaCpxrZtyinmbV
         lf9Qk84X5NxlnBMRQvt6S7FL7zhXl3PqMPpFy0ChCUYAJNhG6rIg/+WyHDrlMYW0STw+
         TERpGrennzX5w+r8TxcgkyTT6KPGkzvrckmnEywcCPIA/+cohMeCaC+riZafOwccUBYU
         U/cWtjnwUL0RPLLXp3WojGR714vcqLk8IHrKnWWhllcx8CoT03fmQNNtYhZs9996fpoy
         oGgA==
X-Forwarded-Encrypted: i=1; AJvYcCVvMvP47CMxB+bLaUdVY9R1V2ik7adKB7uRFMRbV6Im/ik1jm0sd3blbnOctG/CUSjX8ngnHhD1UWuFoyJz@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ0toxbV61I7Li3Ojclh/2nFveLgpZI1z3nvQjBu74o70pfoyE
	h1vthGye0m7SL2M2ES4blw23gfUdsqVIK88dP6SWUX+2Q1Qnx0j6daanjO5Zz4qCYjsFaT0qypt
	aA7k=
X-Gm-Gg: ASbGncuAGaS/KI6yfWF9XWjWl0zeDbRU4jHWWYb1Q3qRtRVsLA79CRjjmjtlEihsEzU
	nOePi6IQ0Ep6xhEvbOyLyAMOXmtx1Ik4wvymzjr+c+0jsbVhl5J4UYeGSm0mr0cgIVcr4T9Mq7F
	6Eaohmz1E7wLmtHy/WH0fgi/P4YpZnPzHXmmzxBhApfGCjHXHABDaJoMXvf+nUTZsLUk/gTNuDK
	9X3XDk2zaDZZtF9SEW1QyfhgUpp+bDHqJH3OzdoSNhyhpMMevjSveI97LY3zYwbQkEFt6ik88/+
	+P2TxGBNSaDbzRwDgwVdB4+fv/zUMfqYcL4RLLmfc/3zEb2maohTO+o2sLQB1IyMKg==
X-Google-Smtp-Source: AGHT+IEouEVhrYT2SiP168mxh9BN7k7YncezxpSLuEKaWvYyKcKo/z26BDQyB5PPoBWQS8nVQdVgeA==
X-Received: by 2002:a17:907:bb90:b0:ab7:9df1:e57e with SMTP id a640c23a62f3a-ab79df1e772mr549311566b.47.1739125086338;
        Sun, 09 Feb 2025 10:18:06 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab77dcb9336sm656462666b.27.2025.02.09.10.18.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 10:18:05 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5de3c29e9b3so4944618a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 10:18:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMV4uNfnTMyqg0N8qtLm0mIE5Sw9xVR4/JHx5w8+Pab396DLWF5lsna7yHdH3Pqlk8hZ6JJa8q5zzBuNt1@vger.kernel.org
X-Received: by 2002:a05:6402:26cf:b0:5dc:63d:b0c1 with SMTP id
 4fb4d7f45d1cf-5de4509ae3fmr12781548a12.29.1739125085104; Sun, 09 Feb 2025
 10:18:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209150718.GA17013@redhat.com> <20250209150749.GA16999@redhat.com>
 <CAHk-=wgYC-iAp4dw_wN3DBWUB=NzkjT42Dpr46efpKBuF4Nxkg@mail.gmail.com> <20250209180214.GA23386@redhat.com>
In-Reply-To: <20250209180214.GA23386@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Feb 2025 10:17:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=whirZek1fZQ_gYGHZU71+UKDMa_MYWB5RzhP_owcjAopw@mail.gmail.com>
X-Gm-Features: AWEUYZkGD7XWYHffjs-JYLiULY2lp9YzIIBQf0_AgiptO5vUBWe1f1MsKggjsyg
Message-ID: <CAHk-=whirZek1fZQ_gYGHZU71+UKDMa_MYWB5RzhP_owcjAopw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pipe: change pipe_write() to never add a zero-sized buffer
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	David Howells <dhowells@redhat.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, Oliver Sang <oliver.sang@intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Feb 2025 at 10:02, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Could you explain what do you think should I do if I keep this check?
> make pipe_buf_assert_len() return void? or just replace it with
> WARN_ON_ONCE(!buf->len) in its callers?

Just replace it with WARN_ON_ONCE() in any place where you really
think it's needed.

And honestly, if you worry so much about it, just allow the zero-sized
case. I don't see why you want to special-case it in the first place.

Yes, the zero sized buffer *used* to be a special case, but it was a
special case for writes.

And yes, splice wants to actually wait for "do we have real data" and
has that eat_empty_buffer() case, but just *keep* it.

Keeping that check is *better* and clearer than adding some pointless warning.

IOW, why warn for a case that isn't a problem, and you're only making
it a problem by thinking it is?

              Linus

