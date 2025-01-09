Return-Path: <linux-fsdevel+bounces-38759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA22A0808C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 20:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0C83A9260
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 19:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3D31F427A;
	Thu,  9 Jan 2025 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auqxbQk+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E4D189BBB;
	Thu,  9 Jan 2025 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736450654; cv=none; b=P5QtCc6PAHSko1abzTJ+HXLKvh+pnLnJJ+KPWN+jIzSlchZDCga+9i0mLCWK7AgxN1JwG+iv+Fjll2FzridgSmTgGq6lYKsIoE+Fp6j0I+WoxUmFP3qQXgzQNTLbEmO2eoH5nMWY9zjIjl36CxOW1nJbCnnQKetTI3CqB3UpkZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736450654; c=relaxed/simple;
	bh=AKkKpALtlFLHuYq+a/cEQYvg7emjoCafX3YBGMmSNzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsP+HjnTaWroN2y4KjINKHgqyEWL2wmIWe4sdeSgyZbxF2LZjUkesb8bz7IAt4tF5Ep/N2W/gT/xMYwQpwhujxGBSsJOuMpJXOtqfg47XrrWUgL9TV9TLitZcY7+7bt4tVcEDuvbb3XN/1vMmeiN8EH/5bzd9U4rGwjj53LZkZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auqxbQk+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso1320778f8f.2;
        Thu, 09 Jan 2025 11:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736450651; x=1737055451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKkKpALtlFLHuYq+a/cEQYvg7emjoCafX3YBGMmSNzY=;
        b=auqxbQk+qo65a7bG9dSTrJMQ0DbftiO8IKPTKscGOwlXaAYrsK2Fl2kcqz3VrEDrS1
         gmWnu63x7zlvyR+ZAeLAmoEFMcLgIsOy9hZmRJEeFl+Kgl+ezPhxpJ96siF0eUpe0W6f
         7pPao7GLMGWn8yd9AXF3rfQ3M4D8Ag+LNzVoJzvgStvDbiWBeE8aR/FgKsjfFga+KWcT
         VZxkWnVSIyWKHcVGrB/WMEiPq9Qi3v4bEWaX1oDCF5pd3vwxyM3zllqplXYFKqYHZSUr
         cfA97luFNVEzBzFac6dVjWAWOZ4zERsCbnew3MCT8F/AlDQzDRP4R35z0b8ICzNHqJ+S
         bCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736450651; x=1737055451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKkKpALtlFLHuYq+a/cEQYvg7emjoCafX3YBGMmSNzY=;
        b=DxNKHdExO75afdA/HT0Tv90vNtsqRyyGy9/d97mvCWibDYbKgynQHelPmtyOPDGD5b
         V8ulBwmtTQg2BPXwjtLoX52VLaDUFKn6SCazJCgdQh2BcF1oLPmXu6UvkaeSxTNTtiWT
         eXdoUGcEODbLQcsyyvlTuFVoTkCzlchEqu15eX33M4R/gi3qPOLkL+F7IRPtAi4RAgHB
         wVJBPJ34vRzcdWonyx8NPBRUJMU51223uj9Gk2at4rL1zUTemVWOK1jx67jDwILhEr+v
         ZIFnDQK/AiFGg/Y398aMgGl3dpWShSdMbGLTXwukmMYMMQrT3EW68PxMd5ULdLzRbOFP
         t/nA==
X-Forwarded-Encrypted: i=1; AJvYcCUVI6hqIhiBVquTzpow4fJtP31BmS7aCgfcKn3IfnV+x0i+tscCWft4MHvhjrRhzVWM0bnOC6pNINCpm5JpRA==@vger.kernel.org, AJvYcCUnhGv5hz6EgZNjjlsAzvlSEzL7+iteXTi+y9aSAj//w5xUBhn5rlAg93zBbxVhuNEZBcoCRClxTvrpN5C0@vger.kernel.org, AJvYcCUtuFDPT7sLuU0Ejtj6ED1Wogb1tWKdkBwyx5VAiz+M6ZJZn0q7M01yALrDJlwhUeYkSyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmZNHtt1g1VrnuBNIg4oNgd5J1DRUg52x2WaJx8sZC40ttDKLz
	vdIylMVfZNgjZFh5bP086eFgPTlTSBej7qE20vmJrb+TifItIQwc8zr9fuqRJmrqn1NhMZ5Lw0t
	cuMCtxWIgfZN+wYXS9MlKebuokS4fMImz
X-Gm-Gg: ASbGnctQmxPUodxRu9TiIQP52bZwmuVh4o8ArNCaQoQwji0BOLTf+8bPYqWLeype7jy
	BhON1YJeReFjtbrv3lhvkoAOatd7V0v/gW2VDQS/7MDd3vVmGV8LMPg==
X-Google-Smtp-Source: AGHT+IE6W5rQ22/6vLZrKK2Z3c7ISulxE3JJWCNlRHGYDcMAE7W8/krB1IkKaQavxaG0gvLBQcMUikPWz1a39CC574s=
X-Received: by 2002:a05:6000:188e:b0:388:c61d:43e4 with SMTP id
 ffacd0b85a97d-38a8733e1d1mr8656297f8f.45.1736450650506; Thu, 09 Jan 2025
 11:24:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080E0DFE4F9BAFFDB9D113B99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLU=W7fuEQommfDYrxr9A2ESV7E3uUAm4VUbEugKEZbkQ@mail.gmail.com> <AM6PR03MB50805EAC8B42B0570A2F76B399032@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB50805EAC8B42B0570A2F76B399032@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Jan 2025 11:23:59 -0800
X-Gm-Features: AbW1kvbG5GJZwdRooLFdnF_9APM9Cf4MRaxLyij5yhdp_aUPERAEkwcit6I8EKA
Message-ID: <CAADnVQJYVLEs8zr414j1xRZ_DAAwcxiCC-1YqDOt8oF13Wf6zw@mail.gmail.com>
Subject: per st_ops kfunc allow/deny mask. Was: [PATCH bpf-next v6 4/5] bpf:
 Make fs kfuncs available for SYSCALL program type
To: Juntong Deng <juntong.deng@outlook.com>, Tejun Heo <tj@kernel.org>
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

On Mon, Dec 23, 2024 at 4:51=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> >
> > The main goal is to get rid of run-time mask check in SCX_CALL_OP() and
> > make it static by the verifier. To make that happen scx_kf_mask flags
> > would need to become KF_* flags while each struct-ops callback will
> > specify the expected mask.
> > Then at struct-ops prog attach time the verifier will see the expected =
mask
> > and can check that all kfuncs calls of this particular program
> > satisfy the mask. Then all of the runtime overhead of
> > current->scx.kf_mask and scx_kf_allowed() will go away.
>
> Thanks for pointing this out.
>
> Yes, I am interested in working on it.
>
> I will try to solve this problem in a separate patch series.
>
>
> The following are my thoughts:
>
> Should we really use KF_* to do this? I think KF_* is currently more
> like declaring that a kfunc has some kind of attribute, e.g.
> KF_TRUSTED_ARGS means that the kfunc only accepts trusted arguments,
> rather than being used to categorise kfuncs.
>
> It is not sustainable to restrict the kfuncs that can be used based on
> program types, which are coarse-grained. This problem will get worse
> as kfuncs increase.
>
> In my opinion, managing the kfuncs available to bpf programs should be
> implemented as capabilities. Capabilities are a mature permission model.
> We can treat a set of kfuncs as a capability (like the various current
> kfunc_sets, but the current kfunc_sets did not carefully divide
> permissions).
>
> We should use separate BPF_CAP_XXX flags to manage these capabilities.
> For example, SCX may define BPF_CAP_SCX_DISPATCH.
>
> For program types, we should divide them into two levels, types and
> subtypes. Types are used to register common capabilities and subtypes
> are used to register specific capabilities. The verifier can check if
> the used kfuncs are allowed based on the type and subtype of the bpf
> program.
>
> I understand that we need to maintain backward compatibility to
> userspace, but capabilities are internal changes in the kernel.
> Perhaps we can make the current program types as subtypes and
> add 'types' that are only used internally, and more subtypes
> (program types) can be added in the future.

Sorry for the delay.
imo CAP* approach doesn't fit.
caps are security bits exposed to user space.
Here there is no need to expose anything to user space.

But you're also correct that we cannot extend kfunc KF_* flags
that easily. KF_* flags are limited to 32-bit and we're already
using 12 bits.
enum scx_kf_mask needs 5 bits, so we can squeeze them into
the current 32-bit field _for now_,
but eventually we'd need to refactor kfunc definition into a wider set:
BTF_ID_FLAGS(func, .. KF_*)
so that different struct_ops consumers can define their own bits.

Right now SCX is the only st_ops consumer who needs this feature,
so let's squeeze into the existing KF facility.

First step is to remap scx_kf_mask bits into unused bits in KF_
and annotate corresponding sched-ext kfuncs with it.
For example:
SCX_KF_DISPATCH will become
KF_DISPATCH (1 << 13)

and all kfuncs that are allowed to be called from ->dispatch() callback
will be annotated like:
- BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
- BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
- BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
+ BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
+ BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots, KF_DISPATCH)
+ BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel, KF_DISPATCH)


For sched_ext_ops callback annotations, I think,
the simplest approach is to add special
BTF_SET8_START(st_ops_flags)
BTF_ID_FLAGS(func, sched_ext_ops__dispatch, KF_DISPATCH)
and so on for other ops stubs.

sched_ext_ops__dispatch() is an empty function that
exists in the vmlinux, and though it's not a kfunc
we can use it to annotate
(struct sched_ext_ops *)->dispatch() callback
with a particular KF_ flag
(or a set of flags for SCX_KF_RQ_LOCKED case).

Then the verifier (while analyzing the program that is targeted
to be attach to this ->dispatch() hook)
will check this extra KF flag in st_ops
and will only allow to call kfuncs with matching flags:

if (st_ops->kf_mask & kfunc->kf_mask) // ok to call kfunc from this callbac=
k

The end result current->scx.kf_mask will be removed
and instead of run-time check it will become static verifier check.

