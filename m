Return-Path: <linux-fsdevel+bounces-66370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6209FC1D42C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 21:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3ED054E1FF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 20:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4179536334B;
	Wed, 29 Oct 2025 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZIT8FZH5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5D835A141
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770667; cv=none; b=D+JKwcWE9dUIS2joaFxqvt6xdNEDzD38Zal21AnCvJmAACT1anqqAiNYx3WcA0/k5QVDKM/FqObwPDG9BHAaomB/dYLj6MkAk3uw+R/03CRwryvpemG7KZFtir78yEzLn5hLvVZGqymVRUP+TKEMcTAzs54EYwfhCX+0ls1Bw0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770667; c=relaxed/simple;
	bh=/nRyrHH69bDwdkUwV+ZvUiMlkERSxLC5qY0L4yNkpAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqKO2JP02B/6FvE95ncwlphdP9HlRDeoh3rY1DmUiClj7sZo4g0X75mH4GlMiqnq2fVXJ3kOA2khUDBGwn0gE7LTsbpyeOHIUc80GMhygKKOgHbbLKvv7nC7fX7fDJmYM97nLsiI55lYtnXYXxeAG+FLpKYXdbiA60YwtX3Km0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZIT8FZH5; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-378f010bf18so14819131fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 13:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761770664; x=1762375464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nRyrHH69bDwdkUwV+ZvUiMlkERSxLC5qY0L4yNkpAA=;
        b=ZIT8FZH51950wDS/bjbvoKGOA8qhHonV7KO9v4ASHE/9xRn3ynMtghPFcpBjOistJH
         2lDJC8qO5e33qWIzdICHnbPQyQbleSTxhRTXXmBRLGOGCyZzy+q1Sd+c4kD9S/keZClS
         MZt8ZPz7P4MLIzfxWg2TmnOnQZh1igfmm8ZEeJ8srgrqVAyq+4zbSyFWUbE7XBWoPObj
         jw6yyodMDdTkDAscIF6SN8BwOhAbZUdl9M4vi15xPNeKdSfMqdZWqtIpGdFgtw+Sa8tW
         WjRpVWRJwEG8tvxYBPzUBdlm27ROSFhNUxSh/hDPDKJJLfUfuJmwJAxMt1X6eC6zK8u7
         BRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761770664; x=1762375464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nRyrHH69bDwdkUwV+ZvUiMlkERSxLC5qY0L4yNkpAA=;
        b=A4TVOf+p2yAxF1T15TZOkMd9TRFmpwUEcKljtaCLN0wrWQTuPwa0Sn2FCpR3HDhRol
         1Y5+P0Iy8z3gDE1XJ3TcrL1+s3sanhU0/bEwvC2pzXKyNPTxJ7+6SZLfyrmv+wX4Fh8j
         Z0XG9nfau05Iiq79mCznbhlREEIecUrDV6KxEXA4G5PEdXWYSU330I916wfnx1KJ5WAx
         /+EhnuonFJMLZSUSQXxH5APfK6DHvhryhZ4XPYdrhsGk1OzOjPniDIbcZTY13mEUipGZ
         WtbwrGzDF8xqsehu5otGCixgCDdw65qQ+fIpPB58sYeCTrniflAV5KLbFMLjrGdOli+i
         Ef0A==
X-Forwarded-Encrypted: i=1; AJvYcCVjW5WTsozjO255rYLoDQBKfafcJXvQQsKMmwc38/kB7tl2CLQn7BDCEwlF9IUGwJgiMkyBIsEI1FFlyuJ6@vger.kernel.org
X-Gm-Message-State: AOJu0YytaTT45IUD+68iMLKQFticYGpU4Ff+z0NLhJGD4EX3OfPw+6Rg
	fr/b3moKlTs6JJ2ONzaS9vcPAx682WdhD0ki5noqYF6kHLtFJlbAbtJRx32GPH0GCNmCMdDf9PV
	xRzszE1v9Kit6FKGl4yHDJgCvsuOMeK74UWxe7PhX
X-Gm-Gg: ASbGncvRUpdjK5XHhZuTIXnGmgoNrjdr6w7zxxpduDeHF3RFJ+0R7IqFbouefYFBeNK
	KxUH8q1DKTfs1rY/tLFLZnzyKf5JNVyE+rlzALzXKupekG32ShBJyc6KfOr58sDBkbufkNtg7tO
	T8qXgFv8kzDyx78SFHElpldunDFaczeke/hvqQDAMWz+FnJ0ziREiwxTONXIm/Jym/qQMl7588M
	OL0Ys2GNrJG7Y6k4vior8Bi31EuHwUsyYw8T0RdOD1s8LWM1EaO9VmB76TZ
X-Google-Smtp-Source: AGHT+IFRYtH5XfTJnxxGfkJO0Gi6f1H2nFBXWvOk+OBKFsn98ppWQIAtWYQQwdGEa9VK8XbxcXnwXcPQMdyC3mUpVtI=
X-Received: by 2002:a05:651c:32a6:b0:378:d020:b6b3 with SMTP id
 38308e7fff4ca-37a1068ccefmr2106821fa.7.1761770663502; Wed, 29 Oct 2025
 13:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-15-pasha.tatashin@soleen.com> <mafs0tszhcyrw.fsf@kernel.org>
 <CA+CK2bBVSX26TKwgLkXCDop5u3e9McH3sQMascT47ZwwrwraOw@mail.gmail.com>
In-Reply-To: <CA+CK2bBVSX26TKwgLkXCDop5u3e9McH3sQMascT47ZwwrwraOw@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 29 Oct 2025 13:43:56 -0700
X-Gm-Features: AWmQ_blzsfm8AU4aSmOo38Baxqd-QolYtNvPxHfj3yJKEB0u3KTJVZdMqBMfTX4
Message-ID: <CALzav=d_Gmb8xKCwWCGsQQrdxHJrnk5VP-8hvO6FugUP7_ukAw@mail.gmail.com>
Subject: Re: [PATCH v4 14/30] liveupdate: luo_session: Add ioctls for file
 preservation and state management
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 1:13=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
> On Wed, Oct 29, 2025 at 3:07=E2=80=AFPM Pratyush Yadav <pratyush@kernel.o=
rg> wrote:
> > Also, I think the model we should have is to only allow new sessions in
> > normal state. Currently luo_session_create() allows creating a new
> > session in updated state. This would end up mixing sessions from a
> > previous boot and sessions from current boot. I don't really see a
> > reason for that and I think the userspace should first call finish
> > before starting new serialization. Keeps things simpler.
>
> It does. However, yesterday Jason Gunthorpe suggested that we simplify
> the uapi, at least for the initial landing, by removing the state
> machine during boot and allowing new sessions to be created at any
> time. This would also mean separating the incoming and outgoing
> sessions and removing the ioctl() call used to bring the machine into
> a normal state; instead, only individual sessions could be brought
> into a 'normal' state.
>
> Simplified uAPI Proposal
> The simplest uAPI would look like this:
> IOCTLs on /dev/liveupdate (to create and retrieve session FDs):
> LIVEUPDATE_IOCTL_CREATE_SESSION
> LIVEUPDATE_IOCTL_RETRIEVE_SESSION
>
> IOCTLs on session FDs:
> LIVEUPDATE_CMD_SESSION_PRESERVE_FD
> LIVEUPDATE_CMD_SESSION_RETRIEVE_FD
> LIVEUPDATE_CMD_SESSION_FINISH

Should we drop LIVEUPDATE_CMD_SESSION_FINISH and do this work in
close(session_fd)? close() can return an error.

I think this cleans up a few parts of the uAPI:

 - One less ioctl.
 - The only way to get an outgoing session would be through
LIVEUPDATE_IOCTL_CREATE_SESSION. The kernel does not have to deal with
an empty incoming session "becoming" an outgoing session (as described
below).
 - The kernel can properly leak the session and its resources by
refusing to close the session file.

