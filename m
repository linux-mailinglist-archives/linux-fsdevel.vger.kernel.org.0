Return-Path: <linux-fsdevel+bounces-7580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50805827C5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 02:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001DC284BBD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 01:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6509846A8;
	Tue,  9 Jan 2024 01:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KTAy93Wz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B214415
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28b1095064so260949966b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jan 2024 17:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704762186; x=1705366986; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SK/U7sMdUF0m3232sJNLcxLQzzyq9KpShnd9w+HBMfo=;
        b=KTAy93WzaS0nEYohR0bwVB5dTBpdtnmmFs+bQl6J/Gzf9idhpsTuoJJNvN9jFcy3D1
         3Bgu+a0Jv9ccXsbOcLN8aEK3mL+zPKtptAXf2SKdI/v6INoolAILQKug5B/PpQeFxugD
         8dc9uDyQgjVb3qzIi8U2dHtt4U7BCE9c42MM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704762186; x=1705366986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SK/U7sMdUF0m3232sJNLcxLQzzyq9KpShnd9w+HBMfo=;
        b=tB/YttTpJUwh5y4zpzPpizk4Lcbznh3RWTSR1Q9abfAUYpy/3pSdPRPW0eMSES+FVO
         MX3NsnGhNH8YvxcYfLJjDU1X3Cel2KT4F4DMBbaU53FGGMJJKTArQpl38KPXlOzXjtof
         JkeGzHLoh6y6HH9t57/SsKwppN8PUeiPqW+F1laYxmNsE7n0mpuc5l2rUnIftkhQBZbH
         UU8XACntgkogVMIUtfsQ/ErZYHKo5cusYhjHiiFuGa6B9nw7w0fiA+B5pqyveYhyRqMA
         KmM3aP95zQcPGqAJl6HSGRaGjBW++Hwx25R6gi12YVdnyqP7eGi6tlZu82hmIOlwG68j
         rJjA==
X-Gm-Message-State: AOJu0Yyi5SpfB2TFY8tMPz1yajRwQIH+QJ7GqROTg1KKbjbkcGvBI6ti
	ETXRXo4qFotnrJ9DODPF+XPitFnEMh4mv1qj1evC33o8smJfgWXd
X-Google-Smtp-Source: AGHT+IGuPq8erj3sV1YaqmMBl7j2KbFGnHd+lXvLxDMTbD+FDdHSJPOwrmEoMt5wgf6U/NtbEUiSkw==
X-Received: by 2002:a17:906:f589:b0:a2b:3da:cea with SMTP id cm9-20020a170906f58900b00a2b03da0ceamr84381ejd.141.1704762186398;
        Mon, 08 Jan 2024 17:03:06 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id jw11-20020a17090776ab00b00a26d804eb8dsm424427ejc.200.2024.01.08.17.03.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 17:03:05 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a294295dda3so265210066b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jan 2024 17:03:05 -0800 (PST)
X-Received: by 2002:a17:906:1389:b0:a19:a1ba:bad0 with SMTP id
 f9-20020a170906138900b00a19a1babad0mr58005ejc.118.1704762184865; Mon, 08 Jan
 2024 17:03:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105-vfs-mount-5e94596bd1d1@brauner>
In-Reply-To: <20240105-vfs-mount-5e94596bd1d1@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Jan 2024 17:02:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjfbjuNxx7jWa144qVb5ykwPCwVWa26tcFMvE-Cr6=vMg@mail.gmail.com>
Message-ID: <CAHk-=wjfbjuNxx7jWa144qVb5ykwPCwVWa26tcFMvE-Cr6=vMg@mail.gmail.com>
Subject: Re: [GIT PULL] vfs mount api updates
To: Christian Brauner <brauner@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 04:47, Christian Brauner <brauner@kernel.org> wrote:
>
> This contains the work to retrieve detailed information about mounts via two
> new system calls.

Gaah. While I have an arm64 laptop now, I don't do arm64 builds in
between each pull like I do x86 ones.

I *did* just start one, because I got the arm64 pull request.

And this fails the arm64 build, because __NR_statmount and
__NR_listmount (457 and 458 respectively) exceed the compat system
call array size, which is

arch/arm64/include/asm/unistd.h:
  #define __NR_compat_syscalls            457

I don't think this is a merge error, I think the error is there in the
original, but I'm about to go off and have dinner, so I'm just sending
this out for now.

How was this not noted in linux-next? Am I missing something?

Now, admittedly this looks like an easy mistake to make due to that
whole odd situation where the compat system calls are listed in
unistd32.h, but then the max number is in unistd.h, but I would still
have expected this to have raised flags before it hit my tree..

                Linus

