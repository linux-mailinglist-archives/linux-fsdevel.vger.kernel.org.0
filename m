Return-Path: <linux-fsdevel+bounces-33834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D3E9BF91B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 23:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB445281ECD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 22:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9406F20CCD7;
	Wed,  6 Nov 2024 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4AlvKgf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2967824A3;
	Wed,  6 Nov 2024 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931532; cv=none; b=ZK7SPEAn1LWDpcgCb2bmi3LQijPGkjwpXjRMJU87Sr8vwnUp8o0XTtUgHuG/aHbi2efEu1KWHwLN/el2kPeCFauoKH5ogeNMwipSESfkiRISxuV9pVGiSXMtowbuuGYeNYJp7oQL8FNHflG58PVfUm2FAxgtNh8SxQI8VoSGGTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931532; c=relaxed/simple;
	bh=aIFlKwth4J4OQ3bOZ2tIJdiR1MfWpvv7DpD+5ufnlM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4SzfzpyC0WDqVC852Sr5HiR0zkEk+efNZ230NGwpyD/OdohkYLM+oKDl/InzJoaC0WALS+gz94EnO9E21O+byfojD4/9CMbZ7Zb8tbF+plckLI6FmDoIXl1gmfHjqMivzaubR3dZXq4+OR8hxDAwxdnRGY5K+E/9R9mi+vGil8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4AlvKgf; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-720be27db27so171978b3a.2;
        Wed, 06 Nov 2024 14:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730931530; x=1731536330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIvbD0MdhpvC8ocX+R437pfHaRhuHn7RLCw1h6ZRFX8=;
        b=F4AlvKgfxnfzejd/5xkcQZu3CFOggO//1yyc0sqUT2PMJFyMR4Unq98uY99P7PK6dt
         kOPirU313lNwe8QX6y8QsreBq5x4tgWAzhcbCVwMLtjYjLAPvleo+ZMTNVSRe8uX5j9k
         6dU9jVhMHPNrux4u+9VgwXXWH8XEsjg+IgAluj9//I8XERqFhCXm/MhWfgpwHRLndafx
         R1KUpSQkqj9tRniXk+RVp90otH79KPLW9uDdHVyLdQcmPMw3N3l7jTqRXo+pYx0z6cI7
         6RTI7AW2CjsHmArbJhrtzsNGGRpZjYvN2bC2QUa8LNEl5JbzZbkNrDHnHcArLDjkxX3r
         7a1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931530; x=1731536330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIvbD0MdhpvC8ocX+R437pfHaRhuHn7RLCw1h6ZRFX8=;
        b=QRNCvhz7EZuZYII8hnCAtrEzaXnZUt8dFD2/dw0dUk3RyrDgcGlHIXHpcOEhh0+l/m
         pm3tK/nct98GfwIAfcwtGjP5CvAkfhzo6CU4+9F1sJJgjZuhadVD3Aono/7Q4CGm8a3D
         cdTdZnvYb1TUg9ANU/M7kAP/uLNHRU8TRTduMmrmSxR5qhg5+TDtpsIk/z5lMdY5Zqow
         gOdchsESfG2HVzsJKhh7NdHbbixcykU+XO2QSnctMw7+obY3MFVIS+PTLCDzmBviKt9D
         3wcZaOm1AyfGljQQad6o6kzdcrxkNCOGNoULhBtkkSOnnd9q9r1v1VmZYH3s58QSzRC2
         MthQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBlXgej3wZHMW8nhp7xoUytlX148+yBRLE6M2Pxm846rSBJV8K0gR3m63GxyfbWSgRNM3LNlL2Su7Ymb6Y@vger.kernel.org, AJvYcCUYqiYhqQnA+gaWyjBaPvJqUQ9dADCynsiExSK0tTSCEGLQMZ3imwLBwKUPnI0lGPBSBfs=@vger.kernel.org, AJvYcCUlrFmQHX45sjPAdmVFP5WOH7aJzBLvcN6JlUOksSPXrT70P5HHLGBYLmOlXjdByIHt0NzwavQsmIl+yvjgnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn5V0dBg40OcRhpFJ17LRExv1TG/frnKJAAaDpQgrZ2Zyg8wCv
	60m5MBubEsSP9QnheUQLnfqM2+FNr+EYrDVwINSr0MVQ8qAhoGPonj8iuQrUrXOdvh8uzMgQMnK
	uC8klGGwpMdKOa91Sz7MLY0BM+6M=
X-Google-Smtp-Source: AGHT+IF4M4JFgLDNFXgKa2s8x6f7mFYCFL0H1L34B6OWQ0KMdk+UAatRi6kVlmxKs+JysKaIEJauBtDicnrwX2ZdPXY=
X-Received: by 2002:a05:6a20:4328:b0:1db:dd9d:cd3f with SMTP id
 adf61e73a8af0-1dbdd9dce4dmr15547071637.28.1730931529945; Wed, 06 Nov 2024
 14:18:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <AM6PR03MB5848C66D53C0204C4EE2655F99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAADnVQKuyqY7J4iJ=FZVNoon2y_v866H9hvjAn-06c8nq577Ng@mail.gmail.com>
 <CAEf4BzYib5jyu90tJYSTEmhpZ-4aF135719V+A7J7pzMj7RpNA@mail.gmail.com> <CAADnVQ+0LUXxmfm1YgyGDz=cciy3+dGGM-Zysq84fpAdaB74Qw@mail.gmail.com>
In-Reply-To: <CAADnVQ+0LUXxmfm1YgyGDz=cciy3+dGGM-Zysq84fpAdaB74Qw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 14:18:37 -0800
Message-ID: <CAEf4Bza67tpBiquJr-+ZMTTa=+29iz6Ag2+vCKyhZQv4yj9m0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf/crib: Introduce task_file open-coded
 iterator kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Wed, Nov 6, 2024 at 2:13=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 6, 2024 at 2:10=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > > > +__bpf_kfunc int bpf_iter_task_file_new(struct bpf_iter_task_file *=
it,
> > > > +               struct task_struct *task)
> > > > +{
> > > > +       struct bpf_iter_task_file_kern *kit =3D (void *)it;
> > > > +
> > > > +       BUILD_BUG_ON(sizeof(struct bpf_iter_task_file_kern) > sizeo=
f(struct bpf_iter_task_file));
> > > > +       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_file_kern) !=
=3D
> > > > +                    __alignof__(struct bpf_iter_task_file));
> > > > +
> > > > +       kit->task =3D task;
> > >
> > > This is broken, since task refcnt can drop while iter is running.
> >
> > I noticed this as well, but I thought that given KF_TRUSTED_ARGS we
> > should have a guarantee that the task survives the iteration? Am I
> > mistaken?
>
> KF_TRUSTED_ARGS will only guarantee that the task is valid when it's
> passed into this kfunc. Right after the prog can call
> bpf_task_release() to release the ref and kit->task will become
> dangling.
> If this object was RCU protected we could have marked this iter
> as KF_RCU_PROTECTED, then the verifier would make sure that
> RCU unlock doesn't happen between iter_new and iter_destroy.

I see, it makes sense. I guess we'll need tryget_task_struct() here
and just return an error if we failed to get it.

