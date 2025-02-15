Return-Path: <linux-fsdevel+bounces-41766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0948DA369E3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 01:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A302C1885C89
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 00:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F2F146A6F;
	Sat, 15 Feb 2025 00:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFoGy4Nx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DC613C809;
	Sat, 15 Feb 2025 00:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739578717; cv=none; b=Kdrn8HNF083Yw1GZCDdB2KQhmgPXpw3AMPTabPoTLGtJu90aTS6VUR+znIc4YaOklc9207Sa0zpCtSDBjQbBgFkg1QYqhFMGbarXWSj6uWKO99ETL0BkY3kxwiz4nwE0ZhdV3ArNifQPNZuus8JmIk9hsGSC61DWdD3E5fMZObY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739578717; c=relaxed/simple;
	bh=DP6GsL2kiXTrrcYvfd1/F15R3RNSwOVsk9p/xw6ZWpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZM0yHTALr9GlU8BxenTTVgDLpdexF7+rbJ0jYZA7PXWX7Hrv97jTwI87Ce6f+FJggySyqH+L6/hQVCprD8ZhmVso/HTFaYXG9Nedq9O8Wtn3YCe++yxU0bicALZgFhe3XmbR8AdhHMx3m5R28LtdEA5a8w6mLTDNSOZItIbSSXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFoGy4Nx; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5450f2959f7so2663163e87.2;
        Fri, 14 Feb 2025 16:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739578714; x=1740183514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5q0cGxquaLNwCjeJniPTIWT3xWlmuT23BV3wVLOJcDQ=;
        b=PFoGy4NxddWNwLRRFdHEDOO7GC1GybizWpFjbiiC3Gh9GSeIW56V/O+T7o6PvDSK/a
         VKSZS/UTPEr+NUzbc2Z4FHe2vkBeWlqIo65ufBUTKjJ7ZOlT6HoET2I3C2MxjnVnUrHV
         8U2qC2xYD50/GyaK+a9K6G4Y03NlovXvhRVXiZh8Gwj69f5vizI/CNrfZbE6vW1kugVF
         PJsBKR9qurse+LGwXRIWoatjwJ0OQqmyqRi1mk1/nt/4wQa+vMgDYkLaZUdefR9WeALp
         /UchtxrVdVT1mWBjyFOZkxKWqgs+BYJtOvlhCZyIwRQRd+mOv8HQS+C9btN1Mfvw9VOV
         Rn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739578714; x=1740183514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5q0cGxquaLNwCjeJniPTIWT3xWlmuT23BV3wVLOJcDQ=;
        b=fMxhf0BRIcLvbp88cuyjPgvhUQRXSwSfTVYgHsA4okkjO1xn5FS5sOHxtPIRrzPsdS
         GhPPVe4o99MnTIndqVJILSBCwq/T1OB7cg7wuugoT6wAyac0wYu46EXbfsFfnUZuGcDn
         nuHIhg1OLwySeWox45qy2kUe6BwEfXCfgeyHTMVvDbbX9HhIb8vLim2xtCkd+NoxZTEG
         nJbYNHcWfT7I2Rti8R+wVKFhn+lKe1IZY5Zkeu0loidTF8ncJC1hjFnmozaBbgf5cFYk
         RwsJhIBW3CF+5+cZO4htMvOzoymvPLe1Ua0L9TtvOhGCpHMv81OQU8RBUAyNTMXMjbZe
         CElw==
X-Forwarded-Encrypted: i=1; AJvYcCXKFTxyzGAjU7Ri+kvcNaZZRejnCn83EVyWLS6SbG/fwueXNO3aZt+BgnaMt0bQrLQ8wFfkh6Gilj4a2g==@vger.kernel.org, AJvYcCXOtvA0c7sVVaDeh/TeJklpHXTz644cnWAX/I9/TfbRET6dAuFzEuT/j8Pn/kD34cbnFdvO7PC+Ww7KYfIDyBk=@vger.kernel.org, AJvYcCXUHRlRvisei4kbIX5o7la/awgh4Ju/TjS1biWGhbDSvu0Zqm3mzKLAamSD0sKanYLG5uf3iL9CNdrbHlk/6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzGRDLCPwCgvhTAhUk8t74pyMKXd6z80f4YSNy4fK4KmgDUpOa
	2cyenI2Yr9w7edlm/SBmFjPbcCMmfVpjIv80hd2sFK7u3UFuxoGr1Mh3wH3pReYyLA9yH1Tl8Jt
	f4cjunVkHxwXOA2kKOXnZExyVBr0=
X-Gm-Gg: ASbGncv6smRp7Pswc/w30zrR8WuyPps+iwfhd5oWsXeAB7RRhgtT1Zhwa8RnDbqnyCT
	rSszpSdz3vKkKmx4EwuGOwfY4edz1eT0EbN0DxvFUMoK7VTENwvwj+yg0Z64WussbO/+QRFkQbf
	t0+ArptYA5tvgyqzxR4W5qBOwK8o+nhqY=
X-Google-Smtp-Source: AGHT+IFtmaqWPTKsjF9xPyuivvMTpfcSv9taFHOoRqpftBJxz5+gTjTkafOXFctObtPlzQyB3bqyopqomah5xPPCwn4=
X-Received: by 2002:a05:6512:3b8e:b0:545:4df:4c1d with SMTP id
 2adb3069b0e04-5452fe938b9mr498637e87.46.1739578713338; Fri, 14 Feb 2025
 16:18:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ldu9uiyo.fsf@kernel.org>
In-Reply-To: <87ldu9uiyo.fsf@kernel.org>
From: Steve French <smfrench@gmail.com>
Date: Fri, 14 Feb 2025 18:18:21 -0600
X-Gm-Features: AWEUYZnZelshUZNe61cfBSMPcuylKF3W5d60tuBaF_HvPU3xYbsEJ4yF2WnLyI0
Message-ID: <CAH2r5mvh7gFftj1rbZoocbLO9mGffOskVgAhJ3gwSb4ufO5cpA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Rust in FS, Storage, MM
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sounds like a good idea.

I would love to have some experimental helper drivers in Rust for
cifs.ko and/or ksmbd
(e.g. fs/smb/common module for improved compression support over
SMB3.1.1, or SMB3.1.1 over QUIC, or for optional protocol features
that could be segmented into a common module shared by client and
server in fs/smb/common)

On Fri, Feb 14, 2025 at 12:41=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> Hi All,
>
> On behalf of the Linux kernel Rust subsystem team, I would like to sugges=
t a
> general plenary session focused on Rust. Based on audience interest we wo=
uld
> discuss:
>
>  - Status of rust adoption in each subsystem - what did we achieve since =
last
>    LSF?
>  - Insights from the maintainers of subsystems that have merged Rust - ho=
w was
>    the experience?
>  - A reflection on process - does the current approach work or should we =
change
>    something?
>  - General Q&A
>
> Please note that unfortunately I will be the only representative from the=
 Rust
> subsystem team on site this year.
>
> Best regards,
> Andreas Hindborg
>
>


--=20
Thanks,

Steve

