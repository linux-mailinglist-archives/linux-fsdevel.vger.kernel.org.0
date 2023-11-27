Return-Path: <linux-fsdevel+bounces-3996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9473C7FAC6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 22:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54881C20F9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 21:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE92C46437;
	Mon, 27 Nov 2023 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6nJAGzz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A6F31735;
	Mon, 27 Nov 2023 21:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB329C433CD;
	Mon, 27 Nov 2023 21:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701119591;
	bh=O7B53ahSsXYZv0/3GtytayozB/LdwWtvoTPV/D9zgKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E6nJAGzzU+y1vd2Te3ZQJmiqo+LPPSj9NjgaLfueRXcQ10DmnLOZolPq/Ew9HhxFk
	 d/fBJcv3pA8khk2kENXTvZsUzrEBCvSeD2OjYxkPRgtUU5cOz7MuxOnJQckSZMN761
	 fhPBLu/5s78qjmC+n0APxGm6IMeWipjDMJgacsOZMlWdqhdcW8W1E2V5ve+ZMvOp9N
	 Wx/GNW/1fIXNE15nOd2N/RgKQynU3gh63gEGV3DZM6b+GnQsINK7NMoHUwdKCXWKhx
	 AuMyKBCa7/psA+u2MoeD931lWCL2KumVQB0O7TDRdGSGGu5RXH/aBniO1VDVfDULYI
	 hXdz7yi8k4IsA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-507e85ebf50so6406349e87.1;
        Mon, 27 Nov 2023 13:13:11 -0800 (PST)
X-Gm-Message-State: AOJu0YxkddygyDHX5AwR15uHgrlc66Uk9W1tB9pIUJLaI7uagwzAoljB
	cLxQkKY8BmdfxPQyRpphQhXiP/xzzDFxRpmm59A=
X-Google-Smtp-Source: AGHT+IHv8e6noXFC9uvnadiggk6Xhu6Uimbht251vU7wvruHM56yuqTGHcwt7VVU19mRALhez0VMAqJmWQOn7BE/rhY=
X-Received: by 2002:a05:6512:3a82:b0:509:489f:d84e with SMTP id
 q2-20020a0565123a8200b00509489fd84emr12046812lfu.37.1701119589893; Mon, 27
 Nov 2023 13:13:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123233936.3079687-1-song@kernel.org> <20231123233936.3079687-2-song@kernel.org>
 <20231124-heilung-wohnumfeld-6b7797c4d41a@brauner> <CAPhsuW7BFzsBv48xgbY4-2xhG1-GazBuQq_pnaUrJqY1q_H27w@mail.gmail.com>
 <20231127-auffiel-wutentbrannt-7b8b3efb09e4@brauner> <CAPhsuW4qP=VYhQ8BTOA3WFhu2LW+cjQ0YtdAVcj-kY_3r4yjnA@mail.gmail.com>
In-Reply-To: <CAPhsuW4qP=VYhQ8BTOA3WFhu2LW+cjQ0YtdAVcj-kY_3r4yjnA@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 27 Nov 2023 13:12:57 -0800
X-Gmail-Original-Message-ID: <CAPhsuW64QYs3pk7Uva5kWhSm4f+25CektGYn9PB6_G1cLb67RQ@mail.gmail.com>
Message-ID: <CAPhsuW64QYs3pk7Uva5kWhSm4f+25CektGYn9PB6_G1cLb67RQ@mail.gmail.com>
Subject: Re: [PATCH v13 bpf-next 1/6] bpf: Add kfunc bpf_get_file_xattr
To: Christian Brauner <brauner@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, ebiggers@kernel.org, andrii@kernel.org, 
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, casey@schaufler-ca.com, 
	amir73il@gmail.com, kpsingh@kernel.org, roberto.sassu@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 10:05=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> Hi Christian,
>
> Thanks again for your comments.
>
> On Mon, Nov 27, 2023 at 2:50=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
> >
[...]
> Going back to xattr_permission itself. AFAICT, it does 3 checks:
>
> 1. MAY_WRITE check;
> 2. prefix check;
> 3. inode_permission().
>
> We don't need MAY_WRITE check as bpf_get_file_xattr is read only.
> We have the prefix check embedded in bpf_get_file_xattr():
>
>        if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
>                return -EPERM;
>
> inode_permission() is a little trickier here, which checks against idmap.
> However, I don't think the check makes sense in the context of LSM.
> In this case, we have two processes: one security daemon, which
> owns the BPF LSM program, and a process being monitored.
> idmap here, from file_mnt_idmap(file), is the idmap from the being
> monitored process. However, whether the BPF LSM program have the
> permission to read the xattr should be determined by the security
> daemon.

Maybe we should check against nop_mnt_idmap? Would something like
the following make more sense?

Thanks,
Song

diff --git i/kernel/trace/bpf_trace.c w/kernel/trace/bpf_trace.c
index 0019e990408e..62fc51bc57af 100644
--- i/kernel/trace/bpf_trace.c
+++ w/kernel/trace/bpf_trace.c
@@ -1453,6 +1453,7 @@ __bpf_kfunc int bpf_get_file_xattr(struct file
*file, const char *name__str,
        struct dentry *dentry;
        u32 value_len;
        void *value;
+       int ret;

        if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
                return -EPERM;
@@ -1463,6 +1464,9 @@ __bpf_kfunc int bpf_get_file_xattr(struct file
*file, const char *name__str,
                return -EINVAL;

        dentry =3D file_dentry(file);
+       ret =3D inode_permission(&nop_mnt_idmap, dentry->d_inode, MAY_READ)=
;
+       if (ret)
+               return ret;
        return __vfs_getxattr(dentry, dentry->d_inode, name__str,
value, value_len);
 }

