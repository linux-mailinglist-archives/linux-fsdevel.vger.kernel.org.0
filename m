Return-Path: <linux-fsdevel+bounces-48946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0B8AB66B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 11:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683DC19E58D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 09:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9258F1F4C96;
	Wed, 14 May 2025 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+eUJY+T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4776618E1F
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747213266; cv=none; b=pRCRV8AHwxsJQwJ7Ht19iFGKOJn6UjSd5zIeM1Ydnme4x1g57HQk9fKdwP7h79cei1XCRS0DMm5wGOnHBr1sjw5HbRkMXKRVdjOubrYg4GGcySxTLke9wGWMrybMf6ZAN/xzK6I8y0RsVSfiLrzEBJqBHfVZbqhxwZojkA9NOk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747213266; c=relaxed/simple;
	bh=DmRcfY5difW6YC1dNAh7yzNRHOnS1c0CA4q0VXjmvcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdoWk25uwH0tCtJsDGaD3jaJo4qmXrS44WsypwWhd9xw8kqk9dX0ele3VNI4ud0yi3yYY1mb0IEsWrSw0l2oRIVAyOEOsz7WWNhTrn5RUMo9XuKbBgZgq5HMJJqSG4smLbbJsXbbIbIV3OHFikx/baq8qGOVaTWIOvZDlFESqNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+eUJY+T; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5fbf534f8dbso10012663a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 02:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747213262; x=1747818062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmRcfY5difW6YC1dNAh7yzNRHOnS1c0CA4q0VXjmvcw=;
        b=R+eUJY+TI7YrGavL+QbXkM40u8tFdSUHcy3McwTTW0uxzuAsFSCU1TwwwyiLXYSFvt
         KqOd3tDmy3e9rksUnCk4siifJn1j/q9MLfvTFMxW5TQyTPfKMGtEmdqQQ0juErO4SfXg
         AgtVTOFeLLLOet/AOu8GpoQSady6Sue0Ll+lXw9//NzMLWtlkXNe4zyX4TQl2+inbriY
         /D/2mm9l7VyBKMBEyWpX3OWHj0o3PlWq4vbAVt0MKz+iSp1RV5HpaXCPlcHI+Qf0f0OK
         jbnWl7S7JiW/41yx6HXGFi98iXVRN5tSU4kIWGKAQ/hoYoipGyb7kVmiEQ4/2eHVhao1
         z/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747213262; x=1747818062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmRcfY5difW6YC1dNAh7yzNRHOnS1c0CA4q0VXjmvcw=;
        b=coMs9UhtGDobXKCB6Bb+9v6QVrzCHx3IWmOZTpCA3s7rzSApcew+2JtRgtulb8tzZK
         Vd9NT2EGqNQgyZDiwk07nUrlILs0vYiSnlZ8yRKxMLV/9KzIm1n7Xvp0impnQy+iJ37V
         RnqTTDMA0ifWjkI8JcC/0GIA1u+Uyrw+Jeo+Gld701Ax580Bfs2JDvXjn0N9ojSSdl6i
         vCj9f4t+/ckGh6O/w5VqIiNJ72PQMDeV7wZ/BnsxBOj3IVRZnhkUEL8sKVj+yOODQgnk
         6MkJ0pJRBcPDYwIBcbtetI2Ghpfn+1Xg/YCGAUPE/l2SjR30IbhjuBBH7MSUt46vAjKO
         DPSA==
X-Forwarded-Encrypted: i=1; AJvYcCVeYr7qO3c2zVuyN49x/FRWhdUwsPECtD/qlGePsGgKBEYpHzbZsU0cIfq/phY2OVI5h2qwrVREfsDfRogE@vger.kernel.org
X-Gm-Message-State: AOJu0YxBsIPYsDGKIBSsMiDaIltmbAidcR41tj08R1sqan6w6WJdJG5P
	VLSUEvi8ehsfVWxXku9PJjKXqHKyOVBKgJW80vLsIsg+kFoWbFMNbWho+rycbh2mLY5W7IDtRFk
	0UFTOfa0IzKRQIw7VSp2WuFFS/pc=
X-Gm-Gg: ASbGncvhMdbOdH/51TkPvusXNdU9v9FV/R6CmqGJGBVJdYYHe5D9B5LAAGrE4Ft/vEc
	OXA5WCOHUmdjk6hMS67rnJZ5yVI3riUJYeJS055KwWUnqNyuwUpawq57Y6p7juDfWIOdh18NIG1
	LjopfrGTJmMbN3+3sMnt12vpmaM81Ibmit
X-Google-Smtp-Source: AGHT+IFV4CCrZPhJCvx/kV0U1eMlsJ7nJopSm1CJHvvDGDBZYQMORaILyqyGB7/IybQn3KIWerrxS6ZmqnbASEaFfAs=
X-Received: by 2002:a17:907:9725:b0:ad2:43b6:dd6d with SMTP id
 a640c23a62f3a-ad4f70f5ef6mr275092066b.12.1747213262147; Wed, 14 May 2025
 02:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419100657.2654744-1-amir73il@gmail.com> <CAOQ4uxj1-8uFp1ShzcC5YXOXfvOrEMLCcB=i1Dr4LaCax03HDQ@mail.gmail.com>
 <CAOQ4uxi+pxS74QCLi5H8f0rj8A_1-kRxVs6qf_-C_0rwS66wfg@mail.gmail.com>
In-Reply-To: <CAOQ4uxi+pxS74QCLi5H8f0rj8A_1-kRxVs6qf_-C_0rwS66wfg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 May 2025 11:00:51 +0200
X-Gm-Features: AX0GCFtNUbRqMMalw3LsIMZPWRQy8GmMiLK90iVgYy235iccG1k8Y2L1UIusrpM
Message-ID: <CAOQ4uxhQdUgFnVMuFTyWr60unww40-avGb4NzUUACcvBF4Yx7w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] User namespace aware fanotify
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 10:46=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Sat, Apr 19, 2025 at 1:48=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Sat, Apr 19, 2025 at 12:07=E2=80=AFPM Amir Goldstein <amir73il@gmail=
.com> wrote:
> > >
> > > Jan,
> > >
> > > This v2 is following a two years leap from the RFC path [1].
> > > the code is based on the mntns fix patches I posted and is available
> > > on my github [2].
> > >
> > > Since then, Christian added support for open_by_handle_at(2)
> > > to admin inside userns, which makes watching FS_USERNS_MOUNT
> > > sb more useful.
> > >
> > > And this should also be useful for Miklos' mntns mount tree watch
> > > inside userns.
> > >
> > > Tested sb/mount watches inside userns manually with fsnotifywatch -S
> > > and -M with some changes to inotify-tools [3].
> > >
> > > Ran mount-notify test manually inside userns and saw that it works
> > > after this change.
> > >
> > > I was going to write a variant of mount-notify selftest that clones
> > > also a userns, but did not get to it.
> > >
> > > Christian, Miklos,
> > >
> > > If you guys have interest and time in this work, it would be nice if
> > > you can help with this test variant or give me some pointers.
> > >
> > > I can work on the test and address review comments when I get back fr=
om
> > > vacation around rc5 time, but wanted to get this out soon for review.
> > >
> >
> > FWIW, this is my failed attempt to copy what statmount_test_ns does
> > to mount-notify_test_ns:
> >
> > https://github.com/amir73il/linux/commits/fanotify_selftests/
> >
>
> Hi Jan,
>
> This selftests branch is now updated.
> The test is working as expected and verifies the changes in this patch se=
t.
>
> Would you consider queuing the fanotify patches for v6.6?
>
> We need to collaborate the merge of the selftests with Christian
> because my selftests branch has some cleanups with a minor
> conflict with Christian's vfs/vfs-6.16.mount branch.
>
> Maybe you will carry only the fanotify patches to v6.6 and
> Christian will carry the tests in a separate branch?
> because the fanotify patches and the tests do not actually depend
> on each other to build, only for the test to pass.

FYI, the selftests to verify these fanotify patches have been queued
on Christian's vfs-6.16.selftests branch.

Thanks,
Amir.

