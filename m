Return-Path: <linux-fsdevel+bounces-21606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EDC9065D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 09:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349F91C237FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 07:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273A313D27B;
	Thu, 13 Jun 2024 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Dx69/VWi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FB413D241
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 07:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265363; cv=none; b=Q90w18wiW7Bx59lVsNQ91G2P6nv1kO8H7lkAuddKhYlmzEsNiiSU9rfis03PBaUEqnTGSP4jOjf6ayt0eBc5YKZJP2bQWiZqrfwGAQpSD6DUIgBtapf51vmA7RTk2n9siy4+8cwQIO/IXgsC5bPztWjeCc1z7bo34V4PgT4biII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265363; c=relaxed/simple;
	bh=VwSchH8vw115gFFiyiM0sISl9GzhL9ClIo782HZvRYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I60ddzP+QJdUQouHZelhbwp1ApwD3SDtpVLyKxLae60nj9jOoN//yRsA0QSIQi/5rg3Xrlrwcu55RbeDKTfppPjxcTE854NvPOMb9XN7ytZU4ct6ukzj8Ub24b6K/18rFK3C+qqZMNiGCgaA8bwYllCoCGgMBLEimAGM2cuV99A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Dx69/VWi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6266ffdba8so69717166b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 00:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1718265359; x=1718870159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VwSchH8vw115gFFiyiM0sISl9GzhL9ClIo782HZvRYc=;
        b=Dx69/VWibJWW4zZhdTKxPJZrAJIyuvG/fSV55OgHm8s1zdr/heWBEEE65fYh0h6EbS
         IKwEEjiokYtcr5aiPIUWygE/u/m0FUvfhu+2x/YQCgS8eHFwz8h0nMmja61FtF/7AdA5
         3o35KtByhGUe1elrIcM9SPespGkuQJwTKaNtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718265359; x=1718870159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwSchH8vw115gFFiyiM0sISl9GzhL9ClIo782HZvRYc=;
        b=Kj3A9CFvIUicP2DUUKzShxPEbF/KkrSBYq3O68iyBTxH85LkFXt4HHFVaY53OxTF5D
         NhtPICRJPMyp4nqMq6j5W5t154BLTat7O5vHu+8Enu0HHnBmoSIA9o8A8hV5+NdpzbXx
         GkG8TJarJneBFWEHrWaqmkkI5vBftYCKZ2i4ZScJa4vXbpjR7MFN7FWpyx8CcMJCGtlz
         AKryzP25depD/lqPPjuF+Rrw1R4SeMJD9jvyXV52NMYrdHJ8BMrgr+vZ0q4Us7kVBDHp
         oZjjxW46PiKVQqeXfdxizfqwBf+b0hM0f6WnR9H6IaP9Vm0kWFUCOAAzbwE1/BknfDHl
         3NHA==
X-Gm-Message-State: AOJu0YznLlDtU/bqInGQvGIxMLKzhW93wDzYIU6bgEQE1QeqUqBNCKoG
	E56oIXSIJV6V7hYCv8LpCSaux3ABAWS+fEsDVBcx9Qvx1EjEMXclqyvhC3mfLnxWZsNmFovKuqd
	IIb3riRHVJIG5nWoiXgsLpRP63hU9tqaGo9QOLg==
X-Google-Smtp-Source: AGHT+IFBffLK/T+HOB+s9NUl/Nq+MivqCuS/IlRhMO9xpJaqZQPdxkQy+mJjb4tMoJz/joMDf73k/D8tVpt3UbN65yQ=
X-Received: by 2002:a17:907:9445:b0:a6e:f869:dfcd with SMTP id
 a640c23a62f3a-a6f47f52d65mr309255266b.6.1718265358828; Thu, 13 Jun 2024
 00:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613040147.329220-1-haifeng.xu@shopee.com>
In-Reply-To: <20240613040147.329220-1-haifeng.xu@shopee.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Jun 2024 09:55:47 +0200
Message-ID: <CAJfpegsGOsnqmKT=6_UN=GYPNpVBU2kOjQraTcmD8h4wDr91Ew@mail.gmail.com>
Subject: Re: [RFC] fuse: do not generate interrupt requests for fatal signals
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 06:02, Haifeng Xu <haifeng.xu@shopee.com> wrote:
>
> When the child reaper of a pid namespace exits, it invokes
> zap_pid_ns_processes() to send SIGKILL to all processes in the
> namespace and wait them exit. But one of the child processes get
> stuck and its call trace like this:
>
> [<0>] request_wait_answer+0x132/0x210 [fuse]
> [<0>] fuse_simple_request+0x1a8/0x2e0 [fuse]
> [<0>] fuse_flush+0x193/0x1d0 [fuse]
> [<0>] filp_close+0x34/0x70
> [<0>] close_fd+0x38/0x50
> [<0>] __x64_sys_close+0x12/0x40
> [<0>] do_syscall_64+0x59/0xc0
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae

Which process is this?

In my experience such lockups are caused by badly written fuse servers.

> The flags of fuse request is (FR_ISREPLY | FR_FORCE | FR_WAITING
> | FR_INTERRUPTED | FR_SENT). For interrupt requests, fuse_dev_do_write()
> doesn't invoke fuse_request_end() to wake the client thread, so it will
> get stuck forever and the child reaper can't exit.
>
> In order to write reply to the client thread and make it exit the
> namespace, so do not generate interrupt requests for fatal signals.

Interrupt request must be generated for all signals. Not generating
them for SIGKILL would break existing filesystems.

Thanks,
Miklos

