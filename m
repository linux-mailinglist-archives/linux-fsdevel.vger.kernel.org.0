Return-Path: <linux-fsdevel+bounces-33832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEEF9BF8F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 23:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0318228452A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 22:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B078120CCF2;
	Wed,  6 Nov 2024 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niguz29O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78304824A3;
	Wed,  6 Nov 2024 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931241; cv=none; b=imdR2NHgyOrTKTSvxeVGQL6WQuHY9VHUIrpPfNetwOay0K1Q4cqh+GfXC3gf12zMxS3z+axosTT2+JtC/XDOF40S3zKIBw5WT8Oxxi/25SCA5Mnndm4ntfODLoRaWrY00mvmOzFc4Yx6iUzRmChW4ZseZ6ylBcMu4xTDPathPC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931241; c=relaxed/simple;
	bh=3TAxW4iLu7FEdZCLMZsXcu6CBgSL4sgzNjHckmB6DvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpawvOtupxgz2W1WmDV/Mc3tu9pfw4Md8Fv8k5JSF5EfDHO56EaKK6B1muLaMvpc7uZuIEoectrwwreQvNyc8GLQhAMCPoqKs9wSsDbzEwaDl7pUOHJA1tpeeEmHdog5jjEdDejI+2FlOjTwG5AdMAXi1r7kzT0sTtEjf06T9yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niguz29O; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d47eff9acso173050f8f.3;
        Wed, 06 Nov 2024 14:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730931238; x=1731536038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZpDtRtZooKd1iFzDtmdRZs1JzT6IjBLSrd8zk1Zy8o=;
        b=niguz29ONm1cc6oL1J4Nyd0On37QIeymKh2g6k/zgHu4MqKmV7arJc7nWEvH1lNBIh
         2Y4c7kfIccE6KHhqGf3x4Glns7m63k54KAMdRebu7NHf/oTU1eLDGJwwIJppOiQ7AfRj
         zLvmWYUfvoXMR1ML/RiRlu82KuxHG5maNH8Wmm9Nex+hWwHii/Lr4hd+jZ20sPe7YiT9
         MygbMPSSkuyiwafe/Xp16q07iMJ2Sk0IUlIZyX8HsUWKQ/IMKsvtA+mCBoyQ2v5+7NFX
         t75eeD8hKKP+T9eQYnJ17mYT0JVUI++5FXEe4UquOqRjmEEE/IMWg26BULYru/okJgVh
         FFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931238; x=1731536038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZpDtRtZooKd1iFzDtmdRZs1JzT6IjBLSrd8zk1Zy8o=;
        b=JB0XwaXzlpuc/83D9qmreEfLjWK1vbxoJ2+IOq1ugCg4yUbdjW2TKbcLPQNOWeT9Ca
         yW6yxafWfti6tR+i/tldZvXBXuEJczXP+Xu9Oj3y2NWK7wTuP5ZpT62q5IjhW+DiZXC3
         O2a+/wOaW5U0gwTBN3IybozT7Taar1562DlVQKQVXE9AhUpayswwF/ynw05TCGUcXGLh
         nzDXupwtjrnOf89VcmKgUUI8tKjUpQteajtZuq86G41lOgLPCqOxkqGUY5kR2KRhsUeY
         a+xGAvslPaM4SZdPT1t5PQFNKi367nZwaBMx6gc/kYrcL82ZQqdtNkzO/d52Z68CC7zU
         2O8g==
X-Forwarded-Encrypted: i=1; AJvYcCUjmBdeFBClNhP53udPkXpI3BdN3eICXKTpr1BWN++wWt/pj1aEaA6RUKzAXFA7OfFBshE=@vger.kernel.org, AJvYcCW57tThIP9rgUs2aQdQEQIryNG9WdrfdcgMOyXkYoJ1LBSs+Y/IJGMpecRGxFe2dtnrbMfysoW4HZdLqHr/IQ==@vger.kernel.org, AJvYcCXptu6gd0CxbN6k0DV7bHT5lPUgBMDBHTjwDAYZMqef9Pq4tQWuYDFbtqYvwlMczBNIgP54Q899hgFrQqt/@vger.kernel.org
X-Gm-Message-State: AOJu0YwFPl9OCxCV4tE5KG/S3EcdxY+U55F9CRuTIle9VEdfOOgvQH1O
	NeccSIL5aoQ5uCBn89T8bhUnkKJLkcKSysx7EqQydq/OnpSh/N2r7W+j5QTeQIz2YYGzAVIPCE/
	92JJJFmah5Ms+n6e64ZOpMEt0x3U=
X-Google-Smtp-Source: AGHT+IGWfz66X/M3XNQDfc44OJ7w7Vdqi9GnMhEQjIFr3fSxdqZX1ZOwEv3sZsY5fu0T1SPwMB59ZRC11BGU8vsOD8c=
X-Received: by 2002:a05:6000:1a8a:b0:37d:4a7b:eeb2 with SMTP id
 ffacd0b85a97d-381c7a6d600mr16954110f8f.35.1730931237601; Wed, 06 Nov 2024
 14:13:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <AM6PR03MB5848C66D53C0204C4EE2655F99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAADnVQKuyqY7J4iJ=FZVNoon2y_v866H9hvjAn-06c8nq577Ng@mail.gmail.com> <CAEf4BzYib5jyu90tJYSTEmhpZ-4aF135719V+A7J7pzMj7RpNA@mail.gmail.com>
In-Reply-To: <CAEf4BzYib5jyu90tJYSTEmhpZ-4aF135719V+A7J7pzMj7RpNA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Nov 2024 14:13:46 -0800
Message-ID: <CAADnVQ+0LUXxmfm1YgyGDz=cciy3+dGGM-Zysq84fpAdaB74Qw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf/crib: Introduce task_file open-coded
 iterator kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Juntong Deng <juntong.deng@outlook.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, 
	Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 2:10=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> > > +__bpf_kfunc int bpf_iter_task_file_new(struct bpf_iter_task_file *it=
,
> > > +               struct task_struct *task)
> > > +{
> > > +       struct bpf_iter_task_file_kern *kit =3D (void *)it;
> > > +
> > > +       BUILD_BUG_ON(sizeof(struct bpf_iter_task_file_kern) > sizeof(=
struct bpf_iter_task_file));
> > > +       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_file_kern) !=3D
> > > +                    __alignof__(struct bpf_iter_task_file));
> > > +
> > > +       kit->task =3D task;
> >
> > This is broken, since task refcnt can drop while iter is running.
>
> I noticed this as well, but I thought that given KF_TRUSTED_ARGS we
> should have a guarantee that the task survives the iteration? Am I
> mistaken?

KF_TRUSTED_ARGS will only guarantee that the task is valid when it's
passed into this kfunc. Right after the prog can call
bpf_task_release() to release the ref and kit->task will become
dangling.
If this object was RCU protected we could have marked this iter
as KF_RCU_PROTECTED, then the verifier would make sure that
RCU unlock doesn't happen between iter_new and iter_destroy.

