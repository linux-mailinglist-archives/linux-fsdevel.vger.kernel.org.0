Return-Path: <linux-fsdevel+bounces-71708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 351A8CCE4A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 03:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F50D3022822
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 02:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FFB222560;
	Fri, 19 Dec 2025 02:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKNbzVFR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75AD18A6A8
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 02:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766112455; cv=none; b=pZ1/2CuG9MPZQf4XI7g3R5ip/UC+mYU2dKAQ24qJyyZGXzyUx4loU32neQ3qY05chyQLce3Fjg3Bx7ynYqLz1M5KxFNqkYnQEkhaEal0Avm2qHkZqyV779pXJLZdEkl9m5sknAhAVaO7hHvQ1463pn6cUPmenSBwdwIKZ9JRfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766112455; c=relaxed/simple;
	bh=qd9I072DrCVd6BXLMQDGn9okKczbFVwBvUCnRffnu74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc65HBI33U+a+eM29y8Q6dAiHq+sIQgvmDkxCZOvJeeUv7kF8Y0GZ8qSuCRHRahlojmjD9acgIbzhGZK+N/ColmsZCM0vRol1YhQN10HKbIRVCe6y6u+GrhVq9UyHX16+ukPjsM2vXJzy6R6QwBumI+yac0mGTrbefsliu3GMLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKNbzVFR; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4f1b4bb40aaso6827941cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 18:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766112451; x=1766717251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxMr/2r0sHBGapCgWZS52F9/vMvoFhaKmDMbNpeqFlc=;
        b=RKNbzVFRvsVPkg0Q3mMDSBgiN4YPzZ8I/w0Ic4/IANpTXWzzx6nNeza+LP1gPcEmQG
         Lz5Pp/ONfQcTqr5AgN5f5oaV3nY0SjoldL/Bjl1Rrw6Kk+BbqgqJ7hasVKC6GCikWw2W
         Tl2MWBh7ndc7HTExq1SzJ25BtcqJFfMxH+f4tGG3dElN96ZMCDdFDDhT4ppphxRQa1Nj
         id9xxlE+Wy4FvCoxDCIssiPbOF/7tdeN5kCj4X8P+jnpXb8x1bd+9pKDT7pCpLcSPeNb
         GUO9ODecwRcd3+XQH1TK9/XPRpD53FcmOvYSUhAr7Im4C7DpSkjKu5Zqd4wr5EvS5/bE
         HYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766112451; x=1766717251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YxMr/2r0sHBGapCgWZS52F9/vMvoFhaKmDMbNpeqFlc=;
        b=veA8DPcjCSgdMoZEqzgexVz/nuJFho5SyzyV1XUSl9867iaGrp3wZ6mgTLLzteWn7t
         5+r/qahSaGZO7X88Hqx1kmZ0meub8mLGBw8c84mXEfNzCKPQSfmtD2q4FuRq7eNtMtJy
         yNhswdWFnJI0YIDefy+SBp6+89QayWXPoqtSpICWGvx/o5sH1PJwF1WjL1ce1770NFJg
         yY6JVusIsv0xkPjTHqi/samYs/6ZtikL/pOQ9d0PPkFomqn+f1cKsLe4Qh2KJd56gBlf
         eKHjSNDtF6fblNQn5yp5OYvK/kPBgdWvq/7nsqZWkMYTZQ8Vfgs4eqa/7I6FqGz/yaNY
         xwAg==
X-Forwarded-Encrypted: i=1; AJvYcCXuST+WygVze+WNwGG+nCHQZTRlP2WNsGZTHQ25FS8a5kzpf1RWNBPI9m9Ro6vCMV4CtOYqf44FWJ04MeVT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/9ZKZyzMq8MU5KXfVH8Dj39d3e+SnrRH/sEV3SqJek1HypwVq
	xZU5DGS47TgdXizI0ze7+BwhuTl+xJ/LA26vs4qxvARBvDNPfqaSir0hzACXRr26cgwniCZsNzS
	Pztbb8x1zuHEwbETmztL2HvfTtJCovYc=
X-Gm-Gg: AY/fxX7eyCUu6NwqDYQOxoy/1bpoAuB3UfN6Au5ZiuKvrZNT0ChcTFRvGnEHPWJaHkc
	3wNUjEEGWrMQ3mYuwCtOwwBI8IUa8izXDIurSx9ORy7gsp2Jwvsf8oUYeWkgYiBMPgJsoao2YpQ
	m3oq6hbXbxjjPtrejildG6hQYnQL3MTHUXJlcTYliAAh9fY2wthsXd9nhDQ5SQ7CwRzZQgAO+hp
	Njctoq9F0AoBWmkJWUkCMfS8fhso3YNOKyJo2uZhGS+VD0OZPFtH5/3ljgZqh3cbtU1iGyFmA7L
	B74O3A6pnO8=
X-Google-Smtp-Source: AGHT+IEabtQBUC14kVZXd/Upy1uw3F3xJv++19KSKwVIY1RJOpOGBMj+hfbVbmCIvOBpuiR8+L/Qm30MXIAWMUmSkXc=
X-Received: by 2002:ac8:7f13:0:b0:4ee:15e7:d9c6 with SMTP id
 d75a77b69052e-4f4abd60ceamr24848861cf.53.1766112451368; Thu, 18 Dec 2025
 18:47:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPr64AJFZVFTHnuY=AH3aMXb2-g1ypzheNbLtfu5RxyZztKFZg@mail.gmail.com>
 <e6a41630-c2e6-4bd9-aea9-df38238f6359@ddn.com> <CAPr64AJXg9nr_xG_wpy3sDtWmy2cR+HhqphCGgWSoYs2+OjQUQ@mail.gmail.com>
 <ea9193cd-dbff-4398-8f6a-2b5be89b1fa4@bsbernd.com> <CAPr64A+=63MQoa6RR4SeVOb49Pqqpr8enP7NmXeZ=8YtF8D1Pg@mail.gmail.com>
 <CAPr64AKYisa=_X5fAB1ozgb3SoarKm19TD3hgwhX9csD92iBzA@mail.gmail.com>
 <bcb930c5-d526-42c9-a538-e645510bb944@ddn.com> <06ab8a37-530d-488f-abaf-6f0b636b3322@bsbernd.com>
 <CAJnrk1aSEaLo20FU36VQiMTS0NZ6XqvcguQ+Wp90jpwWbXo0hg@mail.gmail.com> <CAPr64AJW35BHBrOuZZfiB+SBL+bRmfNj3h7zY+ge8aZHgYU8rA@mail.gmail.com>
In-Reply-To: <CAPr64AJW35BHBrOuZZfiB+SBL+bRmfNj3h7zY+ge8aZHgYU8rA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 19 Dec 2025 10:47:19 +0800
X-Gm-Features: AQt7F2olhtIUg1naa6ygjH4eyovPIGMwhCc94xb-h0mHqd6wrxodI4EpEO7OSds
Message-ID: <CAJnrk1b1HqjOsXdjMn4DhZLgwyjh3+zz7oAZuYdw7dMZh-oUXg@mail.gmail.com>
Subject: Re: FUSE: [Regression] Fuse legacy path performance scaling lost in
 v6.14 vs v6.8/6.11 (iodepth scaling with io_uring)
To: Abhishek Gupta <abhishekmgupta@google.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "miklos@szeredi.hu" <miklos@szeredi.hu>, 
	Swetha Vadlakonda <swethv@google.com>, "Vikas Jain (GCS)" <vikj@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 5:17=E2=80=AFPM Abhishek Gupta
<abhishekmgupta@google.com> wrote:
>
> Hi Joanne, Bernd,
>
> I'm seeing this regression on passthrough_hp as well. Checked it on
> 6.14.0-1019-gcp and I was getting 11.7MiB/s with iodepth 1 & 15.6
> MiB/s with iodepth 4. To remove ambiguity (due to kernel versions), I
> tried it on stock kernel 6.17 as well. Please find below more details:
>
> # Installed stock kernel 6.17
> $ uname -a
> Linux abhishek-ubuntu2510.us-west4-a.c.gcs-fuse-test.internal 6.17.0
> #2 SMP Tue Dec 16 12:14:53 UTC 2025 x86_64 GNU/Linux
>
> # Running it as sudo to ensure passthrough is allowed (& we don't get
> permission error for passthrough)
> $ sudo ./example/passthrough_hp --debug ~/test_source/ ~/test_mount/
> DEBUG: lookup(): name=3Dtest2.bin, parent=3D1
> DEBUG:do_lookup:410 inode 3527901 count 1
> DEBUG: lookup(): created userspace inode 3527901; fd =3D 9
> DEBUG: setup shared backing file 1 for inode 136392323632296
> DEBUG: closed backing file 1 for inode 136392323632296
>
> # iodepth 1
> $ sudo fio --name=3Drandread --rw=3Drandread --ioengine=3Dio_uring --thre=
ad
> --filename_format=3D'/home/abhishekmgupta_google_com/test_mount/test.bin'
> --filesize=3D1G --time_based=3D1 --runtime=3D15s --bs=3D4K --numjobs=3D1
> --iodepth=3D1 --group_reporting=3D1 --direct=3D1
> randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, =
(T)
> 4096B-4096B, ioengine=3Dio_uring, iodepth=3D1
> fio-3.39
> Starting 1 thread ...
> Run status group 0 (all jobs):
>    READ: bw=3D11.4MiB/s (11.9MB/s), 11.4MiB/s-11.4MiB/s
> (11.9MB/s-11.9MB/s), io=3D170MiB (179MB), run=3D15001-15001msec
>
> #iodepth 4
> $ sudo fio --name=3Drandread --rw=3Drandread --ioengine=3Dio_uring --thre=
ad
> --filename_format=3D'/home/abhishekmgupta_google_com/test_mount/test.bin'
> --filesize=3D1G --time_based=3D1 --runtime=3D15s --bs=3D4K --numjobs=3D1
> --iodepth=3D4 --group_reporting=3D1 --direct=3D1
> randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, =
(T)
> 4096B-4096B, ioengine=3Dio_uring, iodepth=3D4
> fio-3.39
> Starting 1 thread ...
> Run status group 0 (all jobs):
>    READ: bw=3D18.3MiB/s (19.2MB/s), 18.3MiB/s-18.3MiB/s
> (19.2MB/s-19.2MB/s), io=3D275MiB (288MB), run=3D15002-15002msec

Which commit are you on top of? I just tried your setup on top of the
fuse origin/for-next branch (commit 8da059f2a497a2) and that's not
what I'm seeing:

run server:
sudo ~/libfuse/build/example/passthrough_hp ~/source ~/mounts/tmp2
--debug  --foreground

io-depth =3D 1:
sudo fio --name=3Drandread --rw=3Drandread --ioengine=3Dio_uring --thread
--filename_format=3D'/home/vmuser/mounts/tmp2/hi.bin' --filesize=3D1G
--time_based=3D1 --runtime=3D15s --bs=3D4K --numjobs=3D1 --iodepth=3D1
--group_reporting=3D1 --direct=3D1
   READ: bw=3D17.7MiB/s (18.6MB/s), 17.7MiB/s-17.7MiB/s
(18.6MB/s-18.6MB/s), io=3D266MiB (279MB), run=3D15001-15001msec

io-depth =3D 4:
sudo fio --name=3Drandread --rw=3Drandread --ioengine=3Dio_uring --thread
--filename_format=3D'/home/vmuser/mounts/tmp2/hi.bin' --filesize=3D1G
--time_based=3D1 --runtime=3D15s --bs=3D4K --numjobs=3D1 --iodepth=3D4
--group_reporting=3D1 --direct=3D1
   READ: bw=3D87.1MiB/s (91.4MB/s), 87.1MiB/s-87.1MiB/s
(91.4MB/s-91.4MB/s), io=3D1307MiB (1371MB), run=3D15001-15001msec

Thanks,
Joanne
>
> Also, I tried to build the for-next branch against both kernel 6.18 &
> 6.17 (to figure out the culprit commit), but I got compilation errors.
> Which kernel version should I build the for-next branch against?
>
> Thanks,
> Abhishek
>

