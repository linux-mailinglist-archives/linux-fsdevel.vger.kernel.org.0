Return-Path: <linux-fsdevel+bounces-40774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C6EA275CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 16:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5733A6A51
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 15:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F502144C2;
	Tue,  4 Feb 2025 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UAPWjbnF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB829213E93
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738682952; cv=none; b=ZxtacNWZnKsCU2os3mPnu3m1l2uAD0YlxCrHG+ic74KJykbmmnGIEbPcQ/Lrp30yaMjq+/xwZZohkuuegEYFNdGM5SDUK4VO0eDyn3Qeu9ZoDUQ3+r69JA0Xq33xo4VpOZ8X1q1lOx9ID8Ip0YKobuMk6zqEXbUUUWEJbKzOF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738682952; c=relaxed/simple;
	bh=hdVkR2fbEnn9MFCfmyF3oYEzkatoH2fAGmL02XOR8Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRLs3IrBllczyOPBk0ICQjZ7qjmeG75Bkb9oIJd5XdhyVrR5rhAQeoypOvYQGmUOqeH2GHb/kRqS5rXbom1HYQ4ES1rnZ9FARE05/S7DysosCyALBwoBW19u3Jgb7ZKJqd2mVXVUs3rlbSO1s55zDnJWe73dWt9pBFfaxMWwHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UAPWjbnF; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d982de9547so11063472a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 07:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738682948; x=1739287748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yrA6Lgj79fY+XnGOlvkpe0HoqZ2OKX6I5kMfzwHvccY=;
        b=UAPWjbnFpqpDlqQA7BenatXPUufJiYK+n7ZENSHe86fmxXe/MRfLe06yEz/Hn+PnTQ
         UGy3GyyN8oRMQu42om32dKo1EPwBtoX5d889GcnhctWv25h/sU8sdWTIihflUuE5hqnL
         FDNTDugpLO1VcmkLzh61y8/3yio9BIgFMjEao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738682948; x=1739287748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrA6Lgj79fY+XnGOlvkpe0HoqZ2OKX6I5kMfzwHvccY=;
        b=WLkg4lb8Y5dk+Tblgc9AsPv4NTUqSE4pUIbBEc3pUTL41XpQV6HIPxou2Edg/sIazq
         BMIlNgh+qEFiznC5Mj9zptrycJuU7fYhUZB4evClLtbCcvhetsXI0MdvZRLOQh6TYSg+
         TxZ0hGS1J7Z8wn20OLLqumh6A4PCoZxZx2SsPYnrNd3dPOAsixDhNplcIAf9HtnKwq6d
         +04s/lJJqbxBSJLuRyr7jhN4tklFh9cIkeQkT5U0GzMKF3Em76GAntsJftc+nNlOcMoP
         jW2M//Vkh1RN9fCdTcV+S1V9qer40Tb1n6WFx2eU9bekhAE6TyCXdKwMkbqiw5QxoAGP
         Rgng==
X-Forwarded-Encrypted: i=1; AJvYcCXUNEZpdWa2aoMvQWposiF1F0WlLix5AqfL47IzLTogqUsFWqqaK2sIFB07RI5YHVdVBe3WzztwW9Gfxsbs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3scltg94J8oo8quHBD7VdL3QXYswy4vg+3y+baDyKRsKy3ZAE
	lKoGHnim6l5NtVh79c+9Mp9siNQ7uHgTxSzra1qNykK86vQbFAx1MbScMEMlQLDfgjTRaFAC6OR
	L
X-Gm-Gg: ASbGncunhJSKny1avLYecdfHZ1vk7HpbQbBt4ttinS5oIOjh5YO3/e65nNrY80893Cg
	we31qH9bsAQV4EXdu3b/b+9P8Fl3pveklbusVDAv8DNaGz7GYaglIci/me2afwXswtwHrzI1p/i
	jx2ap5R7Uwdoq4nIcBRwBTSsmltBj814sEZjY4O/pw/mcCYG4hx8aZFBw5LV5xYisIdA7VrrVkg
	oRygQp9I42L6ROA/WloKo1Kxs/5oQGItpJS3b7NuDCry6o9MVp29tZX6HoRygRS/px8xXZ3YfVh
	lpFPvnI8XCXVn70vndpVNUlo6Pb1Zl0ku2UNX5W0FGp8ysb6QKg01yusyt38JzesGw==
X-Google-Smtp-Source: AGHT+IHU0pt1mvV6rbmHOyPk/4MNU9O9lhH5Ptv6fhQ1uMbDsrJcRnwCtwZWNibBCB8XX8AccDZ8iQ==
X-Received: by 2002:a17:906:3697:b0:ab6:de35:730a with SMTP id a640c23a62f3a-ab6de35741bmr2596471266b.8.1738682948002;
        Tue, 04 Feb 2025 07:29:08 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6fe37da7bsm766665066b.109.2025.02.04.07.29.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 07:29:06 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab2c9b8aecaso974270766b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 07:29:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXygwu9P8onoBkBY3TNuRj2j6SToHTQdAbHQ+XxAmoBab2YR0quAocdnM3MdNU4M4nckzsKpYSb9B4Tnjv+@vger.kernel.org
X-Received: by 2002:a17:907:320c:b0:aae:b259:ef63 with SMTP id
 a640c23a62f3a-ab6cfd10a02mr3654141466b.34.1738682945934; Tue, 04 Feb 2025
 07:29:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204132153.GA20921@redhat.com>
In-Reply-To: <20250204132153.GA20921@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Feb 2025 07:28:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=whwYt=hRk3EG7ASM-=xi3Xp7f82Ltqa=dtbVfZnGhN9ow@mail.gmail.com>
X-Gm-Features: AWEUYZmUYfzAccET_47o6avzVE9XrIdskZ_I7yuPc5k_QPJG0dx-dTFhKbX44Do
Message-ID: <CAHk-=whwYt=hRk3EG7ASM-=xi3Xp7f82Ltqa=dtbVfZnGhN9ow@mail.gmail.com>
Subject: Re: [PATCH] pipe: don't update {a,c,m}time for anonymous pipes
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, 
	Oliver Sang <oliver.sang@intel.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Feb 2025 at 05:22, Oleg Nesterov <oleg@redhat.com> wrote:
>
> @@ -404,7 +409,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>         if (wake_next_reader)
>                 wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
>         kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> -       if (ret > 0)
> +       if (ret > 0 && !is_pipe_inode(file_inode(filp)))
>                 file_accessed(filp);
>         return ret;
>  }

So I really don't kike that "is_pipe_inode()" thing.

Yes, it has superficial naming problems (it should be about
*anonymous* pipes, and that should be reflected in the name), but I
think the deeper problem is that I think this should just be a
different set of read/write functions entirely.

IOW, we should have "anon_pipe_read()" and "anon_pipe_write()", and
then the named pipes just do

    int ret = anon_pipe_read(...);
    if (ret > 0)
        file_accessed(filp);
    return ret;

instead. With no tests for "what kind of pipe is this" (same for the
write side, of course)

               Linus

