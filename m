Return-Path: <linux-fsdevel+bounces-40356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED44A227AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 03:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4EA18857D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 02:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E8882899;
	Thu, 30 Jan 2025 02:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnFs2Ftl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454A0819;
	Thu, 30 Jan 2025 02:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738204526; cv=none; b=XsTY6VMxWc3nWLsLPChr6QfyXbEc1xjwY8M3bpExI3gcBm7RwDWPEIKh+cZ766iQkNaFHF8q1M5AnOTN3W+BW6ZKAPDxujg617DZ0UyyOrPgbEvqMhxWnKtsqqIThdPkHCnEx6eGpmF4vfkaI0n9XSravuxcFSmjVMf7R0m+wxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738204526; c=relaxed/simple;
	bh=fBJjKAJ3egiwu1hlVODofpNLLc1bFyDGjEvg0qYGjLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlFC8QWGKkVX0nD/rd04ih5C59Y9GmQcevr4TS3wmrYT1o7Twypxk3QEfQzZUJUP5zUrVSbfR3x+v5Ru8sPCkDxbMcyckmQdOOUZsukAV0pA+klajLR9XNG/Lwk9P3cfKtwBgNjf/nkFtXW90LMhjTget0GR2NmWRdObtJ6VE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnFs2Ftl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436281c8a38so1525675e9.3;
        Wed, 29 Jan 2025 18:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738204523; x=1738809323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBJjKAJ3egiwu1hlVODofpNLLc1bFyDGjEvg0qYGjLY=;
        b=JnFs2FtlVkqDL3tyXqJg9WZNPiNHIMCmN0Ds4SAPfxqwR+ZUZbh1GiOkBdMjfEsXF3
         p4NMFdCNzl5koJ0C8bmPuHvJQ6OqFaT8D9rfFtl8ZwYjqkoClYnNUSs1fK2cGBbRe03z
         IIQdapdRtaPmCT3ehqgR1SEDq2uKowgavt2Qs9ibzIQmyMoOYmYeDwMKkLfYTF/5XNHU
         smPR5klEIxBsMGiVy1qXS7OGkQ4PRUmlMG0T+cOPnaqELMG55QjsoxlHDq++iJxv3Jdt
         lTNJMOCkXTSjwplGxksxtcc6643YghQSM+RfD5eRod+v+G4HYndSWR46j3WzqERcGgIB
         6iwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738204523; x=1738809323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBJjKAJ3egiwu1hlVODofpNLLc1bFyDGjEvg0qYGjLY=;
        b=oODTmQhOsjVhOMBFR6A+MPQASwCo3DD1/8nMox9rMdMb/c8VT1TPCJWOloK1ENyd8E
         utYihsaadzeeGDcHpO4SyB8SchqnPPKjPe2UkcZM0NMCkzE1eYpXGEeNWTYPuByDRbUm
         HEOSZadeNKdDgJssMdzTqqZyPTuTZE4oWZuah4styatmwfMuL3MecxSI0bilDY+WyUH2
         wiPXnkwP6KzPgQ+StW/Srz+vi8A63Cqh+ufPyFYS5fJ+IRpvll60ulBZrX4nrgn3+8I6
         JZxIUAta63IxXXOA72WtLwTijYyCgNhVyZzcDj0K1fmWWC0Yrhodgh462l7l055AdNBq
         eJUw==
X-Forwarded-Encrypted: i=1; AJvYcCUMaSF03dnOYFgxDtVXY3YApfg7XBeELXfBZbya+mnk17sTl0h+hRATfCsS/p5qJuT74WzaJK6VWXhfEbjMGg==@vger.kernel.org, AJvYcCWc8YzjeVRy8BijT7zMy/2JwFrEWYtXkHkN5lhJnI80Db3sNg4SSpzIYS1pUt5HQlfTcEk=@vger.kernel.org, AJvYcCXUdHLKib86iM8qHSJ9jtw3dFqSNYB+FbxIGGUiVqc1Vy2sAbTwZVOLSF6FLNHQACMkh3jhJSXqiDv50ttE@vger.kernel.org
X-Gm-Message-State: AOJu0YwwlrByVZr3R2NtOFcCghvIcErGD4QO9ckSe9/11QzX6+OnKwNW
	nGohq0oFOYTKc2RvquPbT1kfkV1hNf5EbAjtqow+5Qcwn2IoDnb4tCkf3JGzYRGex6k3eownhfc
	QxosofB8mrR60RduIVRNnbwfZcBA=
X-Gm-Gg: ASbGncteSwwcvvGaPyt4+93/qEacqatwWPAXmri8ZiNJq6rajGgTLhO7td++KK40VNh
	nwvzoEAAh5RcRUgqvRvJ+y/TZCv2kpcaa/SqdhT2mU1aRJGRKquo7vhlTwBDGTLmNRkWVvSXeAr
	E+QCPW8ix0XcQE+xpMT/kcuJ+B00Bu
X-Google-Smtp-Source: AGHT+IHJ5UAXPc1/Fkonqr81ZCwHuenKNkZNs6BZpfnYwx7w2AhDI6ydTwnrWyXz7YosdCjWqpBcc6ZJimoMYnGLkTU=
X-Received: by 2002:a05:600c:3c98:b0:434:fb65:ebbb with SMTP id
 5b1f17b1804b1-438dc3c38dcmr48651585e9.17.1738204523406; Wed, 29 Jan 2025
 18:35:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50802EA81C89D22791CCF09099EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB50802EA81C89D22791CCF09099EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Jan 2025 18:35:12 -0800
X-Gm-Features: AWEUYZnxb00SguksiM3VsOggcnZUnjSxiZMYa3QBhUMg8UFqcCyjdvdvm50HYJs
Message-ID: <CAADnVQ+i25D9VVrL=Hst0x9GFz_-8i5U-TV3yLtqEFRzhYfmGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 1/5] bpf: Introduce task_file open-coded
 iterator kfuncs
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, 
	Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 3:48=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> This patch adds the open-coded iterator style process file iterator
> kfuncs bpf_iter_task_file_{new,next,destroy} that iterates over all
> files opened by the specified process.
>
> bpf_iter_task_file_next returns a pointer to bpf_iter_task_file_item,
> which currently contains *task, *file, fd. This is an extensible
> structure that enables compatibility with different versions
> through CO-RE.
>
> The reference to struct file acquired by the previous
> bpf_iter_task_file_next() is released in the next
> bpf_iter_task_file_next(), and the last reference is released in the
> last bpf_iter_task_file_next() that returns NULL.
>
> In the bpf_iter_task_file_destroy(), if the iterator does not iterate to
> the end, then the last struct file reference is released at this time.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>

All patches look fine,
but we need an ack from Christian for patches 3 and 4 to proceed.

