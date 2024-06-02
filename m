Return-Path: <linux-fsdevel+bounces-20752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2C28D77BE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 22:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B1D1F20FA5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 20:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039FE7581F;
	Sun,  2 Jun 2024 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PbXUfgtG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62126D1B2
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jun 2024 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717359089; cv=none; b=ogIF4+Ol2hBTuH+SbE+1QINAfl7UwLdQCMXa2dPNc0Te+YZEsPiKnZVrquFzuanw1LQBmXL8Ny2u1nsrHFwlryTRGeeBQbdCmwDhtA7uq8oy9cor2BRnB01Xhie5ZytaoytL6oNDNy1ZIr/ctMQ6Lnj3OT5pEMfOX8GI9geNoBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717359089; c=relaxed/simple;
	bh=pPpQRofU4aUuWzH8F/QKbmIvQmhWX6HwGWlPQg5XjJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbox+ji2P3O8yRQbXOgFjJGrq7gaaISEAiz0L8Z9P+UHK4KUxxF4LGj7qz551nEWWjoYDgPHR0DsRxDWvm1wDHH5TN01jVjPoR+UFEkbQbcRK/yZMtS7+N9JWbl/NpGCMx+VRHVEb/5r7EqC7bE9RpdqfoaCPUaZVG6AmXX6dNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PbXUfgtG; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ea903cd11bso35521821fa.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jun 2024 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717359085; x=1717963885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ePqimL8VaYhHEJxz6pSQAbNa/K23yw/URyexsY++IVA=;
        b=PbXUfgtGG3WgRYt8xS/HOC8+XuynnEXPnzP+r2gKJjWqBP+kFvCii0YYIFgH0AcUCP
         bLhe+Zxt//4YOzN3Fz6TUlJqi6HZZAvgGTn9cyKf1CuW/aarUQ5g6PWlH5aCaAhNXu+2
         YCW2iqqI6VeFYyOBSIF1EHQ9/Xm6WgJxmy7zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717359085; x=1717963885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePqimL8VaYhHEJxz6pSQAbNa/K23yw/URyexsY++IVA=;
        b=WpbZSNbc/DEZqbDLec4aeWd4egEnRlkFUQ1W6ANdjZ29Sv/ov0RbsAJr9Ap35dzRxN
         bL5K/oCeJ0P9aM6vTQQk6q/nuswLdMHt//SLZmkIA/gPLzQLn4Gbs3ih1ZLBkOcEyS8g
         CVLPbKvo7uSRCm6pKIuPhaZoFDRZG/lCfuLyOvgIcZK83avZRzsiVX1ypzdMp0EtslAu
         tEX7X8jlxAeeE7XzIHyCF/8769xm8eZ4jQ9ABwOO41wSFqP9LEl5zIrsz3zRx26QWWbt
         3xmlDjOmWwapUeRb4YSQrfofjvxRZjvgsBeWrXuSf30dHZw+ArTaf+2xWJNEwoqrmvZ1
         drig==
X-Forwarded-Encrypted: i=1; AJvYcCV7sRwmqktMWRLSfEIAWdtbmlhiEL4Gg5/Pzkzk4aFCQ9ajQLGlnSkJ7Lg8J31zuHaxGb7LDmuVkR54h684uL/qFYrdUP1YLDPq8SnTUg==
X-Gm-Message-State: AOJu0YxHOfVMwsm1Zb838c9n+WK+qA//GBG6vpbbBR8WZjajZ3HY4Tzx
	oZ0N8osDddMArPasFYREKWU6Ulr5QcnniCr7KX4Xa8Ep8tKJf19hS+lpUUkM90lBvb6JeyfEvMU
	d
X-Google-Smtp-Source: AGHT+IHTTCJJ/MP6h3UFQDDNRW+scKyCoXHwQTM+g90zwPzv8+9mdeWLR6epa83d7DOGKvdqvHaqJA==
X-Received: by 2002:a05:651c:1991:b0:2ea:7603:af63 with SMTP id 38308e7fff4ca-2ea95163bc3mr57765261fa.26.1717359085618;
        Sun, 02 Jun 2024 13:11:25 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cc7fc7sm9746101fa.74.2024.06.02.13.11.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 13:11:24 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b8254338dso4199049e87.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jun 2024 13:11:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWM7tmDrKZT7BuidLi87QprSMEQi+KiO76M3UWcteiwkdXFWPi9uLNtYjV7oNErRcDqmpPkHL7V/Cv6nSbwpkae/9t1tdOjvMqdbnGPEw==
X-Received: by 2002:ac2:5dc3:0:b0:51a:f689:b4df with SMTP id
 2adb3069b0e04-52b896bde2emr5480833e87.44.1717359084107; Sun, 02 Jun 2024
 13:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-2-laoar.shao@gmail.com>
 <87ikysdmsi.fsf@email.froward.int.ebiederm.org> <CALOAHbAASdjLjfDv5ZH7uj=oChKE6iYnwjKFMu6oabzqfs2QUw@mail.gmail.com>
 <CAADnVQJ_RPg_xTjuO=+3G=4auZkS-t-F2WTs18rU2PbVdJVbdQ@mail.gmail.com> <874jabdygo.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <874jabdygo.fsf@email.froward.int.ebiederm.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 2 Jun 2024 13:11:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkgtCjr3aHFnFifYtKnvet0M9jehfMFYhYpL_F7Jbmtg@mail.gmail.com>
Message-ID: <CAHk-=wgkgtCjr3aHFnFifYtKnvet0M9jehfMFYhYpL_F7Jbmtg@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs/exec: Drop task_lock() inside __get_task_comm()
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yafang Shao <laoar.shao@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, audit@vger.kernel.org, 
	LSM List <linux-security-module@vger.kernel.org>, selinux@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 2 Jun 2024 at 10:53, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The read may race with a write that is changing the location
> of '\0'.  Especially if the new value is shorter than
> the old value.

It *shouldn't* happen.

So 'strscpy()' itself is written to be NUL-safe, in that if it ever
copies a NUL character, it will stop. Admittedly the byte loop at the
end might technically need a READ_ONCE() for that to eb strictly true
in theory, but in practice it already is.

And even if the new string is shorter, the comm[] array will always
have a NUL terminator _somewhere_, in how the last byte is never
non-NUL.

Now, the only real issue is if something writes *to* the  comm[] array
without following the rules properly - like writing a non-NULL
character to the end of the array before then filling it in with NUL
again.

But that would be a bug on the comm[] writing side, I feel, not a bug
on the reader side.

               Linus

