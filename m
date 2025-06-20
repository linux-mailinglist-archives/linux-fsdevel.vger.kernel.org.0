Return-Path: <linux-fsdevel+bounces-52348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A828AE221A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 20:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE051895F56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 18:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7D72EAD16;
	Fri, 20 Jun 2025 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URxGbqtH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729E2E4241;
	Fri, 20 Jun 2025 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750443520; cv=none; b=smi0eoMqdAUb+EtvNpXNsfLMdr0DmEakmmAO98rWW/jFT2r3B7VP/ZxyIgJzjtrfUDHqSWC+xxdc11Lnw6BUlesrfMRfSsY9hKVF3yOfE5CjvXaGIw/8gmJ6Rhks7WK9qLk8r9B7TnOyoaBhTC8dzTvXZygFJz61Ew2HIprMwYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750443520; c=relaxed/simple;
	bh=/NTEe4LX2305a/082hD0ht8grH/4J99i57GtOdHR6eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0GETpJY3yvLAlUZfcaLcO3gg0F2fhpHPWqQmUhBZSCWi487UBGUTaMxXn5qeGF36Su23VqdvzVHNnfhpYq2xMzgR+A0H4/qxQ5XTMpkCQxIbZ5BfLRRTIduYITJ1mQfGbAPJuloGQ+P0d9bl4mp/ck2RQ5hRwlA/yN9BvDvkhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URxGbqtH; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a54700a463so1246512f8f.1;
        Fri, 20 Jun 2025 11:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750443515; x=1751048315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhMV4vNytMAJBBpa9RjxnYZPyihfBUf6q6MsqT87Yqc=;
        b=URxGbqtHAwvz0KT1uNfUhpH+FAL6mpEfHvCpRqRyyINewHTuyrtsoV8vai0/klBJ9s
         OOQUyZo6G+0wHTCsS60xjoKQD2suXFWKz4Q+hCp2Xk6VcSRwWfw6ILrsMVH8C1/vWQKu
         DI0OlpGO2fQZNR5boKBXPbdLvtoBJlpiq4DEJ+rV+SXWafdNVcTSfsTlRlBAA3xXmvH6
         27mj9Zuqyx36Duca/1b8j72ksEFWOII4wXnGZhMA2tr/RrBYNjMO4HXviUeMphEqI+D4
         MbIgExCdNT1amCYPUq99Uim8bL5T1j6fr//MRR3HS+iNxAH8ky25X+k1rEIKZastTp3C
         s1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750443515; x=1751048315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhMV4vNytMAJBBpa9RjxnYZPyihfBUf6q6MsqT87Yqc=;
        b=cSEcM1q6ulfHo4PLFQpNPBqbE2hLtqGdiKLDc6ihLhHsJ5g0tYioA3LeK40RSsrlHG
         iQ1FhOoeDaLE7e6lEFwjWhUEIOKaXxr3Z+i6tbw58sf6UJ1kc6heP4vw+fOmtW6gxlRJ
         IlcYqYEkK5wmN+XZMlbEYfHb2iL2AY+N7t27DX3O7eYWH2fA75aZwgvDU67X9ok+5SRC
         Lfwt06ce+/xmuDcfwZ+HAGkafDJTSfFIajaGZDAVtLgj26hkNay5z1LaNouYSevkrP2G
         WBSC/mUVrgcyBv6oY41afuflz29OhftAhl5R81XkTyTiGXeliReEByCDTuucm12rIGQC
         MrRw==
X-Forwarded-Encrypted: i=1; AJvYcCV01UXPBWt8OwC/9mptkaBDa74Ab5Lx4CFLFphFvp8/eSTf/uoJHYaEjJrLa94CRNUDG8YVyYHHVAVPJthNaA5rhLCDQm9b@vger.kernel.org, AJvYcCWKtNJM5VJN1q/AUmwjuVZEKOd17p9j2E0trAFhiAYgkdkl1kCMMty4QuZL6KfK9zJGXcDR9Sy8ZBPszgBH@vger.kernel.org, AJvYcCX+puBlZ6ljYFeLcjhMdt44avlrObtyzkUonVUmSvyTVwpytezF9MdcLPra1lJzYqCyWTG9Fi91aMufpIxC@vger.kernel.org
X-Gm-Message-State: AOJu0YzXt7Jc2lJsFOWiODoUCeYUHGy/1GJwcGFfJGVDcxuj+MIEcrtJ
	OBSoZ+UNq1ybGbvsD8402K50RMcsG17qm9uudA2V4B2PgVYwtkbYxnbagkPx8SpSFb2b3GTOinu
	wLtN922t46t0zSygMsjxCoRjAS1ynLB8=
X-Gm-Gg: ASbGncseJttrpocMfGgm+5dqX3yKfVJSYGCE03eGtEpaTFZv2vON4AFBD3KHY0OGvrw
	jR087xjFPIm5HsdNXcAPNSzj27IGqIDZb+FAPT2hE4knXkPGiZNbMZsBcxxL4xMAh41nkIBoKmh
	OiuYyTHRmn7gb6JC0NCTMEjHKewnLOG+tIuxd7jZ+cCLyE9vbJVZLH0/v9V7DD6rRqTY4JP/liy
	yPBOTj2778=
X-Google-Smtp-Source: AGHT+IERIFJDmPI5Mw1ELsO//3RTQwrHGmyoE7/KP5ElN4R3G1PWZpc1vQ2nU+JugdZ2pTBPpOEBKu8rdfjZoKFkLyU=
X-Received: by 2002:a05:6000:26c8:b0:3a5:8977:e0f8 with SMTP id
 ffacd0b85a97d-3a6d27e16f5mr3057936f8f.19.1750443514689; Fri, 20 Jun 2025
 11:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619220114.3956120-1-song@kernel.org> <20250619220114.3956120-6-song@kernel.org>
In-Reply-To: <20250619220114.3956120-6-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Jun 2025 11:18:23 -0700
X-Gm-Features: Ac12FXw3XqXyYvhqyw1ob3gjWc9KnOgD0rHoHKU7ZY9Bk53Kb-1LHiUxKohpROA
Message-ID: <CAADnVQLCyk4O6w4WRxTKcQsEdZ3y6_CNc4mBF2ieT9m51E+2Lw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/5] bpf: Make bpf_cgroup_read_xattr available
 to cgroup and struct_ops progs
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Amir Goldstein <amir73il@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 3:02=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> cgroup BPF programs and struct_ops BPF programs (such as sched_ext), need
> bpf_cgroup_read_xattr. Make bpf_cgroup_read_xattr available to these prog
> types.

...

> +       ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_lsm_fs_=
kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS=
, &bpf_fs_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB=
, &bpf_fs_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOC=
K, &bpf_fs_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_DEV=
ICE, &bpf_fs_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOC=
K_ADDR, &bpf_fs_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SYS=
CTL, &bpf_fs_kfunc_set);
> +       return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK=
OPT, &bpf_fs_kfunc_set);

No need to artificially restrict it like this.
bpf_cgroup_read_xattr() is generic enough and the verifier will enforce
the safety due to KF_RCU.
Just add it to common_btf_ids.

