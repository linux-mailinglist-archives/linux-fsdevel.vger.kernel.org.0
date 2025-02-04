Return-Path: <linux-fsdevel+bounces-40766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 886EBA27440
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 15:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F30A161EC2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 14:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16833213253;
	Tue,  4 Feb 2025 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwghfkMC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D210B20A5E0;
	Tue,  4 Feb 2025 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738678894; cv=none; b=FyAeQV0HyAVwXD976yKQXyA3sdu/rZearvw/xAx+4eep35pKFfMmS9GbJBkYjzCXbKx7rh++i+K9zIBtFhUrviw8VUMhIfPmfFigsp7YE8nXhFSxJ6PqD4zj3LCWtF4p/X3LiA2KDgJXcXaKc8+Y2soFZDTuamo6btjZIYfVq3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738678894; c=relaxed/simple;
	bh=7EgsdMfcV4vGiFh2AIIrSMa7Tc+fni+9VTKuHb3Yf6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTyqUSf7Hnz8YjyNhyNcrtohedfd/QsQlf6SsOBUNP+HmwfiTIsnRm6EdWRlmafIF8e8UK87XuJdScvPod9YPNXDiLATa2gkrnwbdozKYU7ilPYkAxGhkWZ8FdsUxCcqrXHJ1WigdjDNkR6TX7+u8hp9bFhuJOdAyxvPWOwMvo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwghfkMC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dc82e38c10so8662690a12.3;
        Tue, 04 Feb 2025 06:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738678891; x=1739283691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAU/khvkEkGYKaXJqu6wZlGFDq0YwEFuATwA43lhkgc=;
        b=hwghfkMCAL5yeBhW+iGBnxuPXn3PxGpte/4r/QHE8sFHAdifTxm4zA8AkSHFZsgkit
         TQ3Xz4M6Y6Ej2vu0ZQdV1qQBmMYhRFmXue0D9viyRnFg4GQHnqjCXDJqyjbdp7DlbEBB
         4QjgXP4QmB8TKSxsws/+6YG8TWvQu2oDPHervZsDtrdl30h5wtobE6vzOrocM6wNq5FD
         2C2/v1rXOqPMHzE2H0rpWp91FfKhgSucKA+dtzzjcWZ7+PejbmoKiq81VSInyQvvb4y+
         ijnu7WaVBV90t1A5WVcd6Tt/kJwB1lR2iRdeDNCelvIKpJN+IS6LSKeHWKSxkRspsJL/
         +8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738678891; x=1739283691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAU/khvkEkGYKaXJqu6wZlGFDq0YwEFuATwA43lhkgc=;
        b=YC/gKYrU4XSyQyWq0tVGUXsZMj7gQUP2JHTXChlqPdFzBR+BKZ53ZqFIxDax3Dy/3O
         /N+SqnFtaz2i3KTdxSzMB1sBbyIgf6YnESOJO/rrh4xn80mC0HBpHYL2urpbbJlCpLU7
         GoDFeEMV7tujlT4BJbwdrVr8iChV9REJx1XcGEh9I5B8xnl/EujGCD+L09/JRMLbaTgU
         HutPw73SKn3u/GYpocSrRE6L33IDr17fgF+qSL4xy8I02gOImF3aUxwqLzN2ezm0tsEe
         6UwmyAdpxDmIsdaQicO3OewNuwzyhNid8l6F+ZjPpeGgsFRGm4ja57cs0zOkd3COwBCh
         U5zg==
X-Forwarded-Encrypted: i=1; AJvYcCUAikUP1V1OUjDDiQ/mfbUYZMTHoqTyrfXNC2W8N/AB/DGUJGTg6jjZlDZt9YB9IVdK605cZSbQmEz8Odi1@vger.kernel.org, AJvYcCWOIu3yOF1wPIcTAm7jquX6VQssfIc6MoXAlfZXkunpt6SaWbhZ1idxgrDq7orE0PEejsLwoCTZcq0dS46O@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq2VZVFNGvWP+Ljs74LeuNE2zOrZ25mk1X2Vh0g2ni10KF5eXE
	vxhXyXRXS+O+mtuw2879cT3pgpp571lUGoOlUzKwpG8SZ3QlcStBvPqWXTDfyMFNojsKbyck1d9
	vzHC1nUCOHpewkuJjm9tvVVVjlv4=
X-Gm-Gg: ASbGncv+DkwsDGHmNqsO6dywKT53clY8j299Ci0CcS5pgMs9n5L40omdPT9l+j94eqf
	dZhU84YSB6v0+7HKu8YRw7rG/w5Ajq/9iKRK6X7Ne8xLr/dLstVOW/YB4kY/RtWiPJk80nYs=
X-Google-Smtp-Source: AGHT+IF/q4bBj5aa34lolX+UIcNU6oAzlIn30lY0mEpxYV+FyDTBW9ScKS/kS7GxR8XFIVRlVvzxCLD6oSJeM0K6+ko=
X-Received: by 2002:a05:6402:50ca:b0:5d0:b2c8:8d04 with SMTP id
 4fb4d7f45d1cf-5dc5efcab34mr28459251a12.18.1738678890823; Tue, 04 Feb 2025
 06:21:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204132153.GA20921@redhat.com>
In-Reply-To: <20250204132153.GA20921@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 4 Feb 2025 15:21:18 +0100
X-Gm-Features: AWEUYZnDtRxpWTYT0cLGOMzQH7fJ1XMKm8b2Z-vEOKAfQVCWgWCRY1RdUttezkk
Message-ID: <CAGudoHGptAB1C+vKpfoYo+S9tU2Ow2LWbQeyHKwBpzy9Xh_b=w@mail.gmail.com>
Subject: Re: [PATCH] pipe: don't update {a,c,m}time for anonymous pipes
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	David Howells <dhowells@redhat.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, 
	Oliver Sang <oliver.sang@intel.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 2:22=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
> These numbers are visible in fstat() but hopefully nobody uses this
> information and file_accessed/file_update_time are not that cheap.

I'll note majority of the problem most likely stems from
mnt_get_write_access rolling with:
        preempt_disable();
        mnt_inc_writers(mnt);
        /*
         * The store to mnt_inc_writers must be visible before we pass
         * MNT_WRITE_HOLD loop below, so that the slowpath can see our
         * incremented count after it has set MNT_WRITE_HOLD.
         */
        smp_mb();

Unfortunately as is the MNT_WRITE_HOLD thing gets set under a
spinlock, so it may be this will be hard to rework in the same vein in
which percpu rwsems are operating, but perhaps someone(tm) may take an
honest shot?

Would be of benefit everywhere and possibly obsolete this patch.

> +       if (ret > 0 && !is_pipe_inode(file_inode(filp))) {

Total nit in case there is a v2:

ret is typically > 0 and most of the time this is going to be an
anonymous pipe, so I would swap these conditions around.

A not nit is that "is_pipe_inode" is imo misleading -- a named pipe
inode is also a pipe inode. How about "is_anon_pipe"?

--=20
Mateusz Guzik <mjguzik gmail.com>

