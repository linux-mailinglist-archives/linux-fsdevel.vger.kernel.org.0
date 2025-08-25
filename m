Return-Path: <linux-fsdevel+bounces-59018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B312FB33F07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48CD61731C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6540F2D9ED0;
	Mon, 25 Aug 2025 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EXsnOBUI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADD428466D
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123862; cv=none; b=okFKUzR769whUqetoRmdVh1zJqlZADQIvL/w1mi41jbQB/9kdTXe1iSRldbMBXXU8Mh1SqZ+vGpo7aFMWHbMLkdZwz7YuiY5qaUvvcA/012aqo796DKPfP/TA3me4PyIL6LTj+GIgO+O8AqURkoLH9ivBJ6B2PSMI37N952+828=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123862; c=relaxed/simple;
	bh=ZELCh/D+zvbWXmi/vnLHq3ROheCzOje8RshmDa5E5SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwhnEeM7TxfuiIDqfo4A0MzV7ZOI8d6F3KiuclgrVe/VUgI3vQu9IxkNANbwZpYO3Q8PYlK3J0MFVMFvsMeknilrWVeVUt4RwzHz8gTihr8MKSRpPspk5INMJuqMHHQCb1sCWkg65hM+r6hGLygDNWT9HnPNdZ+i+VWMtj9qPpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EXsnOBUI; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61c26f3cf0dso4202134a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 05:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756123858; x=1756728658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c7qE1QXaZwWjH9fqfq6LhKop+aIZ2HU5wia0HyWc8yw=;
        b=EXsnOBUIQeD/CRdYBg8nh5AqlISP2Hy6ZCKcXI+tpDaYC8V5PCLxwfux7utCI4i160
         weUPk6Msl1yTuoomW01hTRpTiHjBnN57xCVFJssrXltmSRlRVNYxXrQH2/cw3YVVNiHy
         kk7txilKoO6YM8M5ns7IX8KhDMnv7J6XYZRJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756123858; x=1756728658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7qE1QXaZwWjH9fqfq6LhKop+aIZ2HU5wia0HyWc8yw=;
        b=PCkF8NVHQuaf0lDyu0Qd3LY/vZD9LmkMjN6nZJF0BdaiUtWz+2oQupE1tMB8yP6+Se
         xB1sSANJs/M00vZ+AtdYMaM8A4pHyb5u2ro+5o4TxhCJixAi4XQn4x7q/eVoE2RF5rTf
         QLCjT6phRaOQvccZAIUETRok6HCo9dlBuzHs7dpTXvvxy4p5VUxphG0jRsIlW6iSewNq
         6kasTjVYfUNruhhshSKiQxuKTGu3gzqwSD55oxXwHzcuWkswClMf7Md7V3W7StiTt8yw
         YcGYx+WMW4S/Of/7hCpAT9QqBTjdyot9UOCT3/ERm5XtcSr6HsCllUW7D2RsfULB4nsf
         higw==
X-Gm-Message-State: AOJu0YyG9y2kc4KhvUfN97fC5jI6r5cYIKCoAmT2Cq8lKK965i1kozlw
	K/3EPAOxY/TRmeQgZljSuY+OOxHZGxyr3CwR9KbwNdpO1jO5l7Kb0WkKVbEF7Il0sxhTRy2E1qS
	AnnnI0pw=
X-Gm-Gg: ASbGnctIl6W40oHiOgU/wxr301cjTl0TtAhgNfR7g1SKEcqpTb56L0FTEFDJgvqmhGq
	ElGcMxJKYAe5UTah8og7w7XvoJN85WMxcsAzp68bUOznuCi+IqqkGoiRNMgcPDpRakjkdMXgkav
	yA52FbtgmbDwKIMpnmXvh0AztMsDrAng7/AWXgazZGOzYd8rvkV+HNycxZ/T7KPIdF7JL/PeQPZ
	QPsVr/UVuX2NomnE+ktKTzXVfTcgdEG+DwnkicU+i/73gU0LknpuFTUlB9HDk1EqnVjbKjBjqJ7
	xy8mgs/v8oL26PfnpNnGlrOgrifH4youFj4sMlEAbq1cYNz/5SLl5XcarAtf63vCijyNirXbbSO
	l3mCoV2LaAxzFAG4hpxSLSQE4H7j4S+s84m3fA/f4jmoutLahTwI1o647kLmriWU2s6gbCFQH
X-Google-Smtp-Source: AGHT+IH3cplpjGExbae8pl+TAF1+dvUodzQ8yqN3qgALafwKbYXmTktAbePCHsPxH/Dxu8aLdE6Y6Q==
X-Received: by 2002:a05:6402:348f:b0:61c:8742:21dc with SMTP id 4fb4d7f45d1cf-61c8742249dmr263958a12.17.1756123858496;
        Mon, 25 Aug 2025 05:10:58 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c312ad9e4sm4968607a12.17.2025.08.25.05.10.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 05:10:57 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61c26f3cf0dso4202069a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 05:10:57 -0700 (PDT)
X-Received: by 2002:a05:6402:4316:b0:61c:7743:7fb3 with SMTP id
 4fb4d7f45d1cf-61c77438553mr1227430a12.1.1756123857233; Mon, 25 Aug 2025
 05:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825044046.GI39973@ZenIV> <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-20-viro@zeniv.linux.org.uk>
In-Reply-To: <20250825044355.1541941-20-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Aug 2025 08:10:40 -0400
X-Gmail-Original-Message-ID: <CAHk-=witRb_kEiWmwuaF4Fxz7gWuefn8Nxer05SHMOYxePUZSg@mail.gmail.com>
X-Gm-Features: Ac12FXxl6L4JNGde4jQKUnV41a1IddBJUfMMALyJOYf4NEy6z9IX0E1_MzqV5lk
Message-ID: <CAHk-=witRb_kEiWmwuaF4Fxz7gWuefn8Nxer05SHMOYxePUZSg@mail.gmail.com>
Subject: Re: [PATCH 20/52] move_mount(2): take sanity checks in 'beneath' case
 into do_lock_mount()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Aug 2025 at 00:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>                 if (beneath) {
>                         path_put(&under);
>                         read_seqlock_excl(&mount_lock);
> +                       if (unlikely(!mnt_has_parent(m))) {
> +                               read_sequnlock_excl(&mount_lock);
> +                               return -EINVAL;
> +                       }
>                         under.mnt = mntget(&m->mnt_parent->mnt);
>                         under.dentry = dget(m->mnt_mountpoint);
>                         read_sequnlock_excl(&mount_lock);

Well, *this* would look a lot cleaner with a
"scoped_guard(mount_locked_reader)", but you didn't do that for some
reason. Am I missing something?

              Linus

