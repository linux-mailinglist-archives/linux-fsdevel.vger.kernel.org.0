Return-Path: <linux-fsdevel+bounces-4180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7390F7FD6DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 13:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F6F1C20865
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 12:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1098F1DDC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjYPeSRD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449ED1C6BC;
	Wed, 29 Nov 2023 11:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA706C433CD;
	Wed, 29 Nov 2023 11:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701256838;
	bh=KUFCyIKDrWkKpHdCK1qNaFg2Eg/KOUrc6RUjBFQbwIo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BjYPeSRDNWOs+hUKEKp2KWFQSrSjNEQbOM83PXCggZSbxw5i7GCmb9p0aPc2RlRtM
	 Zx5Z6TXu22Lf8gFlzQOw7T5RkIXw3muK73LzHH0fQc8WSeccEpZtgY/zgkVS86D85G
	 hndBmAqkfapKu54uzibKM3zeds+IRGsZmpwpH652UpPAJZ9OW3DAtCwhkmmJbu8KT1
	 uZZaeVfY1TkwXrlvgG3gtlVW4BsjrOe6efYZb2LLN5DraJxF9tBVKiEy1E1GNGkUvt
	 z9OT5NQP4lHZjxeH9QroeNW0/yE97vBbBQGWDCiEWutqzQAG5TN5O7V41dRGuaREAq
	 DjtvBf8NI9P6Q==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2c8880fbb33so85676051fa.0;
        Wed, 29 Nov 2023 03:20:38 -0800 (PST)
X-Gm-Message-State: AOJu0Yy5x/DFYeZm7VePZKV1ko0FsZN5i0k032VbZx83+0hsz2kdusdj
	LOaqJQ5+ExCpEVVHJSmYnqI9jGyoXt9P35KpCmQ=
X-Google-Smtp-Source: AGHT+IEjdhP/jWajvm2a3me+Nb8Q/i1sz23TsNWjlSfv7oJFBl/SAzvensNAtTmNXoX9t96FXxBT3dwxmHMvrVy3Jb8=
X-Received: by 2002:a05:651c:1214:b0:2c9:c05b:9870 with SMTP id
 i20-20020a05651c121400b002c9c05b9870mr857219lja.23.1701256837010; Wed, 29 Nov
 2023 03:20:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129003656.1165061-1-song@kernel.org> <20231129003656.1165061-7-song@kernel.org>
 <CAADnVQJb3Ur--A8jaiVqpea1kFXMCd46uP+X4ydcOVG3a5Ve3Q@mail.gmail.com>
In-Reply-To: <CAADnVQJb3Ur--A8jaiVqpea1kFXMCd46uP+X4ydcOVG3a5Ve3Q@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 29 Nov 2023 03:20:23 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5Kvcj8cOFf0ZeLZ428+=pjXQfCqx7aYBCthVgtRN2J3g@mail.gmail.com>
Message-ID: <CAPhsuW5Kvcj8cOFf0ZeLZ428+=pjXQfCqx7aYBCthVgtRN2J3g@mail.gmail.com>
Subject: Re: [PATCH v14 bpf-next 6/6] selftests/bpf: Add test that uses
 fsverity and xattr to sign a file
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, fsverity@lists.linux.dev, 
	Eric Biggers <ebiggers@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, 
	Amir Goldstein <amir73il@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 10:47=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 28, 2023 at 4:37=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> > +char digest[MAGIC_SIZE + sizeof(struct fsverity_digest) + SHA256_DIGES=
T_SIZE];
>
> when vmlinux is built without CONFIG_FS_VERITY the above fails
> in a weird way:
>   CLNG-BPF [test_maps] test_sig_in_xattr.bpf.o
> progs/test_sig_in_xattr.c:36:26: error: invalid application of
> 'sizeof' to an incomplete type 'struct fsverity_digest'
>    36 | char digest[MAGIC_SIZE + sizeof(struct fsverity_digest) +
> SHA256_DIGEST_SIZE];
>       |                          ^     ~~~~~~~~~~~~~~~~~~~~~~~~
>
> Is there a way to somehow print a hint during the build what
> configs users need to enable to pass the build ?

Patch 5/6 added CONFIG_FS_VERITY to tools/testing/selftests/bpf/config.
This is a more general question for all required CONFIG_* specified in the
file (and the config files for other selftests).

In selftests/bpf/Makefile, we have logic to find vmlinux. We can add simila=
r
logic to find .config used to build the vmlinux, and grep for each required
CONFIG_* from the .config file. Does this sound like a viable solution?

Thanks,
Song

