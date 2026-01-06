Return-Path: <linux-fsdevel+bounces-72491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FFBCF86CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 14:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D55FB301B590
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 13:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D518632E13A;
	Tue,  6 Jan 2026 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bixDvBWy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60632E6B4
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767704951; cv=none; b=JLh1OLDIj0Zu77qeDoP6Ztpc5ZmhwXyUhjKTCDiD26iNgh7+ExKgZa6f9Z9pNy5SCOwmhBNyiE6tz0aYOlp3HfSdk9OGLmBhA3vF5WVWmHShfSBHvfmWQ2X+vbONXunrcmvDX7Ie1BiJND12icxh5cIVZJg8a8GCPU3j7Y5sjNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767704951; c=relaxed/simple;
	bh=o7Fz/xjhhyAfYaDaPdZMeqQ5JFH0kftLC+VcdxYCtfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWzBaA3UxMdm+qxX/klR1dPMCPyFOIQoz+v9XbAHLnAYhRw771AiTx0v+PQ+Mo7L32VkQimJQPXILlKkDrU+Lzk5J8cJ4KlrTOWHpdUPprx5w3Hrad/iwQfZcHyRLlAAm8zsWU0TdOWebhvlRHRCRmo8/aCzX5d3sld2HP2SyUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bixDvBWy; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5eb8f9be588so699957137.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 05:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767704948; x=1768309748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o7Fz/xjhhyAfYaDaPdZMeqQ5JFH0kftLC+VcdxYCtfI=;
        b=bixDvBWyOv4mAALGMb7D5YNkwa+m3FfHwx91D+vCET3Y+t4UeVe12jOTYS+BipfHve
         lhU9NrW8XM6ftAPvnJ7M6bbz2hTtWvxCL55+O0vgrVHFQB/koKYkv89A0IfjBT7+ohec
         D0lZ6ZOQaSd0+W4dhw41n5bem7AiZOJsyFyRVl2OJJR7GIYQOOT7fGKXxJJNKuy0Y7XW
         rD4ue22DXJ6VhW1rjGq0afP3IKRh/PCM3o56rPH7PDPJvUEw/IDR9VKoGGHZAC6doVoc
         VBjc/v8bGvZhe7Kz5gMAWsokv0yFGNy17Ce6NRFzWzn+oTcefg0xZe2RhNnWXGTGZNQI
         yluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767704948; x=1768309748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7Fz/xjhhyAfYaDaPdZMeqQ5JFH0kftLC+VcdxYCtfI=;
        b=veyhadNH6YXaColSdivhFW6DWNMsFkRdEBhC7JV9zgJIWkSE4xGSeOjZb/tndp0HwJ
         O7eQzKPp/A/n4bonSkGkUHrAUmtq4m7MQGBvJcR0DZXOe63L1vcdZYxK7l2mQQ618FMa
         F1U9dt6SP9pRFkaWMfnss8AffNUaj/gt300xqinNo3D8nDoH6BHcV29irnDQsoNZSzWT
         +Q6pZ8t8iuYHn23aYhCtMgNXp/4wQ64gfVyQXmM02vqnsUMToZoK0cy+7UlVmkLyAqlz
         +bH2AqP1SbMsuUIVMyhqAbvQdJ+nI+q8ppFjvOpAUB3gIMtJojGdkIelaQSnd0uVf06x
         ARKg==
X-Forwarded-Encrypted: i=1; AJvYcCXBVfkUcp7y4SOR3krXfzO0x9R1JrmJqSmZvJBYv9CGt4fA60zS5veuQkgwZhustHAbaXv/6lHb0MZcQEhi@vger.kernel.org
X-Gm-Message-State: AOJu0YwmrFwbytCI264PBoALonTDeYPd8GSmfUs6zrZ29Cj6Tvh1r38p
	mxiTsrU3EkNznVsttfr2yr6V1aqLJEVx4R5Z4zFj4X/EYYMSuBBedVLAqozjBhpIggv2HPuEShs
	r2k7V7fVtRQfXUWcaWJ1SNLA6jmlyr6tLt88W2Fa6nQ==
X-Gm-Gg: AY/fxX6muS58cYLnStF6xECCi9X1vCXUkkEQnWFeux6yFYws7CVBgkyMg57umqcTYFI
	1ax9qtzpcYyNq6kn+EyLd5TsvZu2J/ZsrzsXj/kd3C4wjMwGzYgzG5rkXA8EPw2AoTHNFr0LxRB
	M9kd7y9O5GY9TdpFpV90K8WNOKpT91JUOcTwkOiMkxaP3Gy3yYx5GOzwXfubJ2KhUgYGvZ99YQK
	UH22tG8FdLuSwxO2XtB574+a4XmzHhdba2j3cCQBsGafYRdcS+WzBdh0NJ00lV4V9iA08hhrUMp
	XJ42F0uyx7Vksk4Sm1AtO9QX4ys2lCGsBNr6zZ0=
X-Google-Smtp-Source: AGHT+IE+q53QRcrwa1X/P2rGt0w5PqjH9BdnPnB9kQyI+2KZqEtLpu+X2QQ2N5km3AlrsGYd8/6HCfpH0EmY/KsMAEA=
X-Received: by 2002:a05:6102:3050:b0:5db:23d0:65e7 with SMTP id
 ada2fe7eead31-5ec74524505mr976101137.27.1767704948553; Tue, 06 Jan 2026
 05:09:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com> <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com> <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
 <58a89dc4-1bc9-4b38-a8cc-d0097ee74b29@oracle.com>
In-Reply-To: <58a89dc4-1bc9-4b38-a8cc-d0097ee74b29@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Tue, 6 Jan 2026 16:08:57 +0300
X-Gm-Features: AQt7F2qgRlmnXSCMJz7lKw8ZBRZc8vluWO41oBPbsEaM3ovL2_DdxgbKzkrNO78
Message-ID: <CAPqjcqq+DFc4TwAPDZodZ61b5pRrt4i+moy3K1dkzGhH9r-2Rw@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> For ext4, the maximum atomic write size is limited to the bigalloc
> cluster size. Disk blocks are allocated to this cluster size granularity
> and alignment. As such, a properly aligned atomic write <= cluster size
> can never span discontiguous disk blocks.

Ok, thank you for the explanation.

But it seems that it's an internal implementation detail of ext4,
right? So this check should be done inside ext4 code. And in fact I
suspect it's actually already done there because generic checks which
I suggest to remove can't take ext4 cluster size into account, so at
least some atomic write validation is already done inside ext4. The
only thing that's left is to move the write alignment check there too.

Another thing that suggests that it's an internal implementation
detail is that a CoW filesystem like ZFS or btrfs can probably provide
atomic write guarantees for unaligned writes too, and probably even
without hardware atomic write support.

Can my change be limited to raw block devices then? Thanks to your
explanation now I understand the motivation for these checks with
ext4, but they still make no sense for the raw NVMe disk.

I mean, can you approve my change if I rework it to only lift 2^N and
alignment checks for raw block devices and not for file systems? For
example if I move these checks directly to the related ext4 and xfs
code? I think it's the right place to do them.

