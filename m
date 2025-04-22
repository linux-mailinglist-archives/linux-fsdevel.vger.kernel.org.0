Return-Path: <linux-fsdevel+bounces-46987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA8EA972AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 18:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3795E16D5AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5E3290BC5;
	Tue, 22 Apr 2025 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSlhyESQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38AB28936D
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339131; cv=none; b=VXbKCwu6qjvFF9H7xr218hsosFT0k97UIknrax/CnL2f7TZxKxZBiyU41KvvN7obC7nmD5XQXTTuSy3qsCSB03mamA0NBBMfa1uS7Ocbm2qSUIgXMOe2G/6dQS8V+uTZh6HM9mONcQnGV9AQ3TX0cM2UCEsrjv9HJcaJj9ywQBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339131; c=relaxed/simple;
	bh=1QUlxNNx8LR+5U1cLT9iswh0t0KTmdvyJUgpbH4KjVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YV6Q29DP2zkEtu2GLLCJL7KySRbm+F/N84HIyJ8CdtX7epTbhIwi4Cw75rCBchk/hTSbMUY9rUFDmVcofacMSSY95FC/AtV6sJhH11mGHU7sNzCUfiSkpT2hcBVlWPR5XfiAUTRfx++K1/K4DplTZSTgtAMWCGPA0+p5KlTvQwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSlhyESQ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4766631a6a4so58677071cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 09:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745339128; x=1745943928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THME+WFCyZtSYl2kFL74ZfwBfrtsrr6ClhKpjM2/g58=;
        b=eSlhyESQlF4xhkLd3xYBtDB/q2WVaKBpHc/YqScuxDrL+2daq12EhJFuPozgKad++i
         ayDPs64HAEL98a0Dqw+qTg2+U0lQZd2hIXu/rWVeQ4bkCwSg4fyFVRJVYpHYKk26Br3I
         ypaTai56DIs5PFYM2ESvdTnQ1n2kZ/hj+4yjQ1w8LAUECeIDboDNu9UDkqKyI7eDWtlb
         kBAbraYV69Sk1gBUL4sf89Vb4VQnzri6kZG3TOV+0dzigxdKh8F33PN9kdA2dqtSk+NU
         B5pTYlmvZMaC4v973z89El0P4DTz9QR/aGHXGVhU46cxiS+r67Euz3uu6D6tIQJnH48I
         Nsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339128; x=1745943928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THME+WFCyZtSYl2kFL74ZfwBfrtsrr6ClhKpjM2/g58=;
        b=VTs4Er0Xx2vkS20bV/1nsrEc3dni97N9g0MBWLG55PpIkNuLR8FRUnUxqpDkNU/mFw
         Km31OPOGsPn7Nao03JfWH5N6W0KObl1XonoQYD5TxXVnD8KGsxaCFEwye4UQUXM+71Sk
         MR09rp97ujYMe6suqR72NOgQ8wK+gAtygoE0kPDpZSJr3YkPHoEU234ZBPrtDRhMqAWB
         yyG4qogZ4Sxoix+klKgIq7hKe7sOtyaTxY3fV8IiZaZwlRRTXqo6dLhtsp1lc72BT9bV
         uOq3fOPkSzJS76arDMVah/z/hAQqAT5J729mh5mp8+pd3IULacSWhW9zkKucDSX0D8bm
         jwzA==
X-Forwarded-Encrypted: i=1; AJvYcCVWsLR0FLzQbZyz5c0MWOPCO/r4rz99vnArdxtUAbvQnFI/W5ToUwM9EiwJe7qvNCsxVfEd1m16abSJNrQI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+IFsLbeUP+CM69lumf7zXEoHGrv7YD9CNezk0CdMM4qvlMcof
	rZNqGzjwLVNIQenaPaja1EhljhcN/In+8mwN5lMTvD/qMj01p33S+cDOzXXHHODe3KIvgAwcL8y
	bCNqBakEj6mlikIZVW/26mUAyaAo=
X-Gm-Gg: ASbGnct3Fk+v0cIZesOgcWJRcKTD99Q5qEHMiJ4isg++FcII9xY1gm3zWPKWe0UyzXG
	lcWj4p04rF1WZdaHWBLiwzmcefVyz086wSsZAm8LzT4bLIp7SSOJfg1/fvlp7dLp7V5Hkx8THpc
	w0VdWAjyj/HCa/9PSGEHyQSyNAxMTEGvyYGQ/r/g==
X-Google-Smtp-Source: AGHT+IHQjyYsXcdYAiDvK4pdQotn5VPHKN2HcHIK58Lvu+UQnygFMCcAc94NEvMakWeev2DrocB80HQzokwZseuvvO8=
X-Received: by 2002:ac8:7f10:0:b0:477:5c21:2e1f with SMTP id
 d75a77b69052e-47aec4b74a8mr271478931cf.34.1745339128578; Tue, 22 Apr 2025
 09:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418210617.734152-1-joannelkoong@gmail.com> <0cdd1c6a-ad51-48c5-846e-f61b811fc7ad@linux.alibaba.com>
In-Reply-To: <0cdd1c6a-ad51-48c5-846e-f61b811fc7ad@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 22 Apr 2025 09:25:17 -0700
X-Gm-Features: ATxdqUE7l8PkY9jwiwyCmUbB3OB-KbQoycxuLvU5uPo6XqpcBJMlsnIhRLGxN8c
Message-ID: <CAJnrk1ZN3MwWX8gdR7bu5jX5BpDzS_hyTs_V8S_oMh1fcm0J1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: optimize struct fuse_conn fields
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 7:07=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
>
>
> On 4/19/25 5:06 AM, Joanne Koong wrote:
> > Use a bitfield for tracking initialized, blocked, aborted, and io_uring
> > state of the fuse connection. Track connected state using a bool instea=
d
> > of an unsigned.
> >
> > On a 64-bit system, this shaves off 16 bytes from the size of struct
> > fuse_conn.
> >
> > No functional changes.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/fuse_i.h | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index b54f4f57789f..6aecada8aadd 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -690,24 +690,24 @@ struct fuse_conn {
> >        * active_background, bg_queue, blocked */
> >       spinlock_t bg_lock;
> >
> > -     /** Flag indicating that INIT reply has been received. Allocating
> > -      * any fuse request will be suspended until the flag is set */
> > -     int initialized;
> > -
> > -     /** Flag indicating if connection is blocked.  This will be
> > -         the case before the INIT reply is received, and if there
> > -         are too many outstading backgrounds requests */
> > -     int blocked;
> > -
> >       /** waitq for blocked connection */
> >       wait_queue_head_t blocked_waitq;
> >
> >       /** Connection established, cleared on umount, connection
> >           abort and device release */
> > -     unsigned connected;
> > +     bool connected;
>
> Why not also convert connected to bitfield?

fuse_drop_waiting() checks the connected state locklessly through
READ_ONCE(fc->connected). The smallest size READ_ONCE supports is a
byte, I don't think it works on bitfields.


Thanks,
Joanne
>
>
> --
> Thanks,
> Jingbo

