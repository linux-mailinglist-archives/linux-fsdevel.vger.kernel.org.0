Return-Path: <linux-fsdevel+bounces-39327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B65C2A12BE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 20:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8977A2A49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 19:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2541D86FB;
	Wed, 15 Jan 2025 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUjM5k2n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2071D6DA9
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 19:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970107; cv=none; b=c44uQIsWSqkIDjECSFwqvzwIzVgB4n6U8h/FU7ZT3eOcNiEbuNezMLqU/L6wFQ543YrekSco00IOK5uTzkJilhDPKR7xZyrt4HoTsKAdWq+X1qzHcVeOTWIscXr4HYf23N3K80/kUvuXYGry6yMGz4jriKwJMmz7Yo6ItgTe7KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970107; c=relaxed/simple;
	bh=1CepNm1EvZ8v0biMvtMnX7+Z8MS5vHYzEMsaceGKJ64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rj5Cg/UiAQbWJv2JTSMzHeIZlRH359+v0W+IP/CcOHXt/Vnxo43d/GJJMQfv0J8g6AhdB0/YvEN+ZB0rf+XF7KfoSP7VO16L3hfHFoyTY+U/KUM6DiCsWK5s/nv+RmKMjNtlgZq1I94SmE1SqiMiVp6C4NA2cPLZM9J1IhRNWJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUjM5k2n; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46defafbdafso2174461cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 11:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736970105; x=1737574905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KciV9bdPKhdWNavUL6XlrPX/IOUek6VCPeClw9BiTTM=;
        b=hUjM5k2nqqcgpkpcdFm7JTEAsPTVkQFT8zT9L8YStgXQfPDrl1sJIM4jtPvLlsxLFy
         gzTpq+pG1zN+zKuh+hP4bt6MxyCdOPpAtNOoRxvBObOYpdoInzUm5F11sDJCeIh1nRY5
         ZnnBTnhCdFyPOdaxzkZhLKXIlC2NS8uy22x5JnKKKHfbpTe5jcmrqV43TrWrEARjFOdO
         rIySaDdC48Q1/uuUSyg3DshleNNZglGwTQiSCeInQGHZm1iyw2yiNgcXovNh/0Ngb5Y9
         yZsE1A6PN61za8e1PLKwRq0ocYNkb0Cb3uMc55Uy9vnfjE1RdD81uiU0kZH6+x2isUoS
         Eeyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736970105; x=1737574905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KciV9bdPKhdWNavUL6XlrPX/IOUek6VCPeClw9BiTTM=;
        b=qnAKE24OEvm0D+mMteDgDby02wMNmbTnJNz2ciwptWVZOj0eUjJJ5YLrqfqjd7sUJI
         Wvt1UybqyLeCu45D+oSOJFURthhS2vuzjYUp7DdWrQ9m7zNZDZOOuaCKjclrNcgFG+r0
         nefwMhZyo9QisukKPK89XXU3/mLbqwDEKTWCM9RGRYsjCF87CQ/1vksw5pXbXXvIhF3g
         fT2X30L2/6eI2UjmeTSOOWACBmQURZTfXhOPEHVzEfFHfxL7sMBBeXRB4sedqHYUviWO
         undQWVnBQdoHw3su/6q9ZjbUyqiKiA8C53l9TKjoLZ4mYKGMSdKvsEGg4szJDnmb0p03
         QckA==
X-Forwarded-Encrypted: i=1; AJvYcCUlMS5eWBYd57uprdTsb0XByPtAWzORd5aCyt27VPDjydNU3TEm+5OJeANOODI4mwOfAl1JEPzC3uE1EAyL@vger.kernel.org
X-Gm-Message-State: AOJu0YwCzUr+DJM/DVVsHJNg6z8Nt5Uzzo+GPzpmaja/ozDhLzlWjXhw
	DYnuNlwTHM1sXgl8NqREO7IjVJX2buGuKp1lSIoJQ1cRKLRyigSs+Q07kNGB2Hdb1MCyGqZMBH/
	sg540T2AfBARWLtzk2LtCcXS7b4uTOQ==
X-Gm-Gg: ASbGnct7bK+HEED5bwI+b3bOOmyXUkPQnM681VcqRec6NTxSWWOVPTbu83YfuKFAxUZ
	wxVgrkAnkeZvFzsWNESFT4isrhop5iISHHS1XRmyb1m5Dqc1lGtXmZA==
X-Google-Smtp-Source: AGHT+IHfT4ThsOinmFp6BD0jwnEeIjPdmBh8YZidnwi8onlJLlM0wh4G6Pwnxo21/8bQ7gVPjWsa8mJRX/laaOizJXQ=
X-Received: by 2002:a05:622a:5cf:b0:46a:3176:f78b with SMTP id
 d75a77b69052e-46c710e570fmr484985881cf.38.1736970104679; Wed, 15 Jan 2025
 11:41:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218222630.99920-1-joannelkoong@gmail.com>
In-Reply-To: <20241218222630.99920-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Jan 2025 11:41:34 -0800
X-Gm-Features: AbW1kvbMEex4RAKWpzR5OpS2BYHdayuyI2EZINdqJ5iSa2f0-aXZLLas78GOVPk
Message-ID: <CAJnrk1YNtqrzxxEQZuQokMBU42owXGGKStfgZ-3jarm3gEjWQw@mail.gmail.com>
Subject: Re: [PATCH v11 0/2] fuse: add kernel-enforced request timeout option
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, jlayton@kernel.org, 
	senozhatsky@chromium.org, tfiga@chromium.org, bgeffon@google.com, 
	etmartin4313@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 2:27=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> There are situations where fuse servers can become unresponsive or
> stuck, for example if the server is in a deadlock. Currently, there's
> no good way to detect if a server is stuck and needs to be killed
> manually.
>
> This patchset adds a timeout option where if the server does not reply to=
 a
> request by the time the timeout elapses, the connection will be aborted.
> This patchset also adds two dynamically configurable fuse sysctls
> "default_request_timeout" and "max_request_timeout" for controlling/enfor=
cing
> timeout behavior system-wide.
>
> Existing systems running fuse servers will not be affected unless they
> explicitly opt into the timeout.

Miklos, is this patchset acceptable for your tree?

Thanks,
Joanne


>
> v10:
> https://lore.kernel.org/linux-fsdevel/20241214022827.1773071-1-joannelkoo=
ng@gmail.com/
> Changes from v10 -> v11:
> * Refactor check for request expiration (Sergey)
> * Move workqueue cancellation to earlier in function (Jeff)
> * Check fc->num_waiting as a shortcut in workqueue job (Etienne)
>
> v9:
> https://lore.kernel.org/linux-fsdevel/20241114191332.669127-1-joannelkoon=
g@gmail.com/
> Changes from v9 -> v10:
> * Use delayed workqueues instead of timers (Sergey and Jeff)
> * Change granularity to seconds instead of minutes (Sergey and Jeff)
> * Use time_after() api for checking jiffies expiration (Sergey)
> * Change timer check to run every 15 secs instead of every min
> * Update documentation wording to be more clear
>
> v8:
> https://lore.kernel.org/linux-fsdevel/20241011191320.91592-1-joannelkoong=
@gmail.com/
> Changes from v8 -> v9:
> * Fix comment for u16 fs_parse_result, ULONG_MAX instead of U32_MAX, fix
>   spacing (Bernd)
>
> v7:
> https://lore.kernel.org/linux-fsdevel/20241007184258.2837492-1-joannelkoo=
ng@gmail.com/
> Changes from v7 -> v8:
> * Use existing lists for checking expirations (Miklos)
>
> v6:
> https://lore.kernel.org/linux-fsdevel/20240830162649.3849586-1-joannelkoo=
ng@gmail.com/
> Changes from v6 -> v7:
> - Make timer per-connection instead of per-request (Miklos)
> - Make default granularity of time minutes instead of seconds
> - Removed the reviewed-bys since the interface of this has changed (now
>   minutes, instead of seconds)
>
> v5:
> https://lore.kernel.org/linux-fsdevel/20240826203234.4079338-1-joannelkoo=
ng@gmail.com/
> Changes from v5 -> v6:
> - Gate sysctl.o behind CONFIG_SYSCTL in makefile (kernel test robot)
> - Reword/clarify last sentence in cover letter (Miklos)
>
> v4:
> https://lore.kernel.org/linux-fsdevel/20240813232241.2369855-1-joannelkoo=
ng@gmail.com/
> Changes from v4 -> v5:
> - Change timeout behavior from aborting request to aborting connection
>   (Miklos)
> - Clarify wording for sysctl documentation (Jingbo)
>
> v3:
> https://lore.kernel.org/linux-fsdevel/20240808190110.3188039-1-joannelkoo=
ng@gmail.com/
> Changes from v3 -> v4:
> - Fix wording on some comments to make it more clear
> - Use simpler logic for timer (eg remove extra if checks, use mod timer A=
PI)
>   (Josef)
> - Sanity-check should be on FR_FINISHING not FR_FINISHED (Jingbo)
> - Fix comment for "processing queue", add req->fpq =3D NULL safeguard  (B=
ernd)
>
> v2:
> https://lore.kernel.org/linux-fsdevel/20240730002348.3431931-1-joannelkoo=
ng@gmail.com/
> Changes from v2 -> v3:
> - Disarm / rearm timer in dev_do_read to handle race conditions (Bernrd)
> - Disarm timer in error handling for fatal interrupt (Yafang)
> - Clean up do_fuse_request_end (Jingbo)
> - Add timer for notify retrieve requests
> - Fix kernel test robot errors for #define no-op functions
>
> v1:
> https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joannelkoo=
ng@gmail.com/
> Changes from v1 -> v2:
> - Add timeout for background requests
> - Handle resend race condition
> - Add sysctls
>
> Joanne Koong (2):
>   fuse: add kernel-enforced timeout option for requests
>   fuse: add default_request_timeout and max_request_timeout sysctls
>
>  Documentation/admin-guide/sysctl/fs.rst | 25 ++++++++
>  fs/fuse/dev.c                           | 85 +++++++++++++++++++++++++
>  fs/fuse/fuse_i.h                        | 32 ++++++++++
>  fs/fuse/inode.c                         | 35 ++++++++++
>  fs/fuse/sysctl.c                        | 14 ++++
>  5 files changed, 191 insertions(+)
>
> --
> 2.43.5
>

