Return-Path: <linux-fsdevel+bounces-15756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5164C892897
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E651F22281
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4204430;
	Sat, 30 Mar 2024 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4I1SvwBV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB5A1869
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Mar 2024 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711760387; cv=none; b=aBm9Xv5cEwmw66PO3kumunAeKPzJtWQPwxUAj8Cpy5TkSGg04bqrTyxKb/pb8dXI1iwILzLs2nz58ENP0hh6RUSp6TecCptgtXgTTfVEauuUkkowv1hPgScfYikXkQlTevaSZen+oqMI/QZAVFM5W9UZPIQCUj/vmqrimu1wZ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711760387; c=relaxed/simple;
	bh=uNZdNcX9/iroWo3FyJaRCAOgU46ZuzE0lebtkWKYFL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwGTeJC+P+559q2yMUPa2El1FtFmZqNjzGutBnJIKSYsH32Yfe0BoAE7nmMJWiRDD7gMu2OeAVwqSyYWCJidF/sLG0QdHE/+IzJy5L1S6SXXXiuEeyvYrBOk3wEeBIP16wZwUblvhmTHWd4seyvF3i8Fj7qmZ8zsgx49PYwtozY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4I1SvwBV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3416a975840so1859256f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 17:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711760384; x=1712365184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNZdNcX9/iroWo3FyJaRCAOgU46ZuzE0lebtkWKYFL4=;
        b=4I1SvwBVGoq4hHVZqk9OHvp4M2fm0MN/NDUGXzD6iffrAQuukF9cVD0VgX2oX75ImR
         8M58QKON58QoPCaut8GNZe9zkDZ6tzD2WFb4aJkJCLoYWUBEFk50hY7Gxs6u8MtRdY8f
         /Fw53PwrAqxW2FDdW9kibmLDdCv1PmzK/uut/UPc/Ox/cUxqF9JNizDBpXkKE6kg4ycV
         u2Zhpx19Aj6s3RfefsYR3npWeZJSw2n/i6JXe1HMRAB2YGrUgxqiqK6b3cUNkwrFkrkV
         tsicKP84YjaojsUO9/XrxBAbXkheNFY4tpXq03P3Dx5+/pm15K1jL+ZhspCubzGBG3EW
         PM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711760384; x=1712365184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNZdNcX9/iroWo3FyJaRCAOgU46ZuzE0lebtkWKYFL4=;
        b=Y5fROtojAJJMw+8oSSPeAIqCbI1cGjbQQqxzKX8d5qthExTcNsYeW8A1JiyAph3IgU
         X6J+9fcIoV94oZj+une+Z0HcQZO3Llj0rCdSnK+IwuTTNj9Geg+6j5zFivG/1SJyLBvh
         YfIiMN67+Sb/Wd2/Ft8OK4C32iBfsnP5nXgET6XCV2joLCMBc3/MAEWucMUun+FZyP0r
         Y6aAqEgte8laCQgSG9GbWHrPBFjrTgX9P6RWhD8ST9Vrq56PjBaww8dQ6iCzGn//JEHx
         3UiduSbV039MWCZfUKJsK6VzQNnBIgpbZvIj21wa62NHK87ClnOm6dpAw9TgI2JCUfQ/
         je1g==
X-Forwarded-Encrypted: i=1; AJvYcCV0u4KVAOnusoLNIDJ4fg6wy2+rPIbCo07vd7LAwBKL+9dyKJEwUwDvaV6/IE/RYRatJ9YYdzkCWEiseTpULC1paHleumSlnZP5E7YFGA==
X-Gm-Message-State: AOJu0YxCpB4GmZYtkd2ORBP6rXN8Mgjcju7emqFOUmYTwiaPS4aSDHS+
	CY0mye/IdPHYw0QyOik9lPIVoUoFydC5hWE2HEnFAt+dorRfyIF4SnP33McAGb/SlBrw1eyhz/Y
	qUHOUHGFtxkUwf+FoTbsvx9jUsBhugA29QyiI
X-Google-Smtp-Source: AGHT+IGIPqolQwpHSX+ihYnJ0wVakUMRORlII1tHrJ8qiOdMXwNJEAEjlpAvn3m2jWN7AU3Y15/7gDmsWFTWJwPsyyM=
X-Received: by 2002:adf:f18e:0:b0:33d:64c7:5619 with SMTP id
 h14-20020adff18e000000b0033d64c75619mr2622657wro.70.1711760383544; Fri, 29
 Mar 2024 17:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com> <CAOQ4uxhLPw9AKBWmUcom3RUrsov0q39tiNhh2Mw7qJbwKr1yRQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhLPw9AKBWmUcom3RUrsov0q39tiNhh2Mw7qJbwKr1yRQ@mail.gmail.com>
From: Daniel Rosenberg <drosen@google.com>
Date: Fri, 29 Mar 2024 17:59:30 -0700
Message-ID: <CA+PiJmQR17nwkHaZXUhw=YRM06TfF14bhozc=nM9cw51aiiB6g@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/36] Fuse-BPF and plans on merging with Fuse Passthrough
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 11:45=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> My plan was to start from passthrough ioctl with O_PATH fd on lookup
> and deal with performance improvements later when there are actual
> workloads that report a problem and that depends where the overhead is.
>
> Is it with the opening of O_PATH fds?
> Is it with the passthtough ioctls?
> If latter, then when fuse uring is merged, I think we could get loose
> the ioctls anyway.
>

I'm not terribly sure. Ideally I would have cc'ed them on this email,
but I didn't take down contact info with my notes. I was under the
impression that it was triggering all of the opens before an actual
open was needed, for example, during ls -l, but I don't know if that
was with O_PATH fds. I was a bit concerned that a performance fix
there might end up needing a different interface, and managing
multiple of those could get pretty cluttered. But I agree that it
doesn't make sense to do anything there without a concrete use-case
and issue.

>
> The original reason was to mitigate an attack vector of fooling a
> privileged process into writing the fd (number) to /dev/fuse to
> gain access to a backing file this way.
>
> The fuse-bpf way of doing all responds with ioctls seems fine for
> this purpose, but note that the explicit setup also provides feedback
> to the server in case the passthrough cannot be accomplished
> for a specific inode (e.g. because of stacking depths overflow)
> and that is a big benefit IMO.
>

That certainly informs the daemon of the error earlier. So long as we
can still run the complete passthrough mode serverless that's fine by
me. I've found that mode helpful for running filesystem tests on pure
backing mode, plus I imagine some simple Fuse filesystems could get
away with only the bpf programs.

>
> Using a global cred should be fine, just as overlayfs does.
> The specific inode passthrough setup could mention if the global
> cred should be used.
>
> However, note that overlayfs needs to handle some special cases
> when using mounter creds (e.g.: ovl_create_or_link() and dropping
> of CAP_SYS_RESOURCE).
>
> If you are going to mimic all this, better have that in the stacking fs
> common code.
>

Sure. The less duplicate code the better :)

>
> That sounds like a good plan, but also, please remember Miklos' request -
> please split the patch sets for review to:
> 1. FUSE-passthrough-all-mode
> 2. Attach BPF program
>
> We FUSE developers must be able to review the FUSE/passthough changes
> without any BPF code at all (which we have little understanding thereof)
>
> As a merge strategy, I think we need to aim for merging all the FUSE
> passthrough infrastructure needed for passthrough of inode operations
> strictly before merging any FUSE-BPF specific code.
>
> In parallel you may get BPF infrastructure merged, but integrating FUSE+B=
PF,
> should be done only after all infrastructure is already merged IMO.
>

Ok. I'll probably mess around with the module stuff at least, in order
to work out if everything I need is present on the bpf side. Do you
know if anyone is actively working on extending the file-backing work
to something like inode-backing? I don't want to duplicate work there,
but I'd be happy to start looking at it. Otherwise I'd focus on the
bpf end for now. I expect we'll want to be able to optionally set the
bpf program at the same place where we set the backing file/inode.
Hence the spit into a file and inode program set. I'm still thinking
over what the best way to address the programs is...

>
> So I don't think there is any point in anyone actually reviewing the
> v4 patch set that you just posted?
>

Correct. The only reason I included it was as a reference for the sort
of stuff fuse-bpf is currently doing.

>
> Please explain what you mean by that.
> How are fuse-bpf file operations expected to be used and specifically,
> How are they expected to extend the current FUSE passthrough functionalit=
y?
>
> Do you mean that an passthrough setup will include a reference to a bpf
> program that will be used to decide per read/write/splice operation
> whether it should be passed through to backing file or sent to server
> direct_io style?
>

So in the current fuse-bpf setup, the bpf program does two things. It
can edit certain parameters, and it can indicate what the next action
should be. That action could be queuing up the post filter after the
backing operation, deferring to a userspace pre/post filter, or going
back to normal fuse operations.
The latter one isn't currently very well fleshed out. Unless you do
some specific tracking, under existing fuse-bpf you'd have a node id
of 0, and userspace can't make much out of that. With that aside,
there's all sorts of caching nightmares to deal with there.

We're only using the parameter changing currently in our use cases. I
wouldn't be opposed to leaving the falling back to fuse for specific
operations out of v1 of the bpf enhancements, especially if we have
the userspace pre/post filters available.
So you'd optionally specify a bpf program to use with the backing
file. That would allow you to manipulate some data in the files like
you might in Fuse itself. For instance, data redaction. You could null
out location metadata in images, provided a map or something with the
offsets that should be nulled. You could also prepend some data at the
beginning of a file by adjusting offsets and attrs and whatnot. I
could imagine having multiple backing files, and the bpf program
splitting a read into multiple parts to handle parts of it using
different backing files, although that's not in the current design.

>
> I just wanted to make sure that you are aware of the fact that direct io
> to server is the only mode of io that is allowed on an inode with an atta=
ched
> backing file.
>
> Thanks,
> Amir.
>

Can you not read/write without interacting with the server? Or do you
mean FOPEN_DIRECT_IO sends some file ops to the server even in
passthrough mode? At the moment I'm tempted to follow the same
mechanics passthrough is using. The only exception would be possibly
tossing back to the server, which I mentioned above. That'd only
happen for, say, read, if we're not under FOPEN_DIRECT_IO. I've not
looked too closely at FOPEN_DIRECT_IO. In Fuse bpf we currently have
bpf mode taking priority. Are there any email threads I should look at
for more background there?

-Daniel

