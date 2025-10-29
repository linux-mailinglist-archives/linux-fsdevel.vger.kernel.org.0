Return-Path: <linux-fsdevel+bounces-65972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D2BC177A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7980B1C231FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4A527472;
	Wed, 29 Oct 2025 00:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Rm/tQAfY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89692EAF9
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 00:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696500; cv=none; b=c1C8IoVHs43/txOXAu+TxUbYx+SxPWj4sWwm1ojrXBnA9l3A8pC/90h0WclM2EZ9uwQgIsz0zkQ4lrETx3SOkqB9DYHnMOSF3KCS9fzPsYRKr5KG1v4JwdzadAhGeNseoyzt95Ad2VC/3AvXB7f2T7kM7Uvj5YZTtVCZOMEGECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696500; c=relaxed/simple;
	bh=4+0VmKS7izmdzBSkGnuSr1zXLYq/caM1BpBnvQPHwUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bn8n/IDiTQly6Gla6QvaC0QGZPGdbX223GkX2w8mxRwaXRhwWB7fmVegbZUJ0j6HFM+qUHc9sPMGaOZc98L5xunB1JYsqMrnLkumzOh+0aFLlClT3JMY+EP8dK5NBbjoJFfkNo/KZFH5sZKjVqmq4OCJhcDteDAEqpV90ntInIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Rm/tQAfY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33e0008d3b3so6682224a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 17:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761696499; x=1762301299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZjzJP5BDJixdHcjsD4MEtXcdIeCfYM/75TifkWeDww=;
        b=Rm/tQAfYDRv9P5gu7ha5CsCLxdHAVSufx4wPrLRv39Ao5X4Zd0nLl4WMq66DKWF21j
         pzblNcL+S7EmmehpeXxiCucHVp/gIxF+345p35vVv7k3j4S9XiyILrrjYNpDck8Nwjvf
         u0v4idUFcDSYLq+/hsZKpXYxYmCl3he69VZ7RAvIotMFQhDCV2Kqsptie1SrDLZP1AA0
         kxbVDhUun37cH9zNf8QuTePAzGTU4YKjhVH0cU+/jVfx/MbmEfEddQxZN+GQ58Zt0VjO
         DdJYJ6gKRYAwQ0SnbRvOZxH3etqOX762S1vBeYEBv174TLf5QcBHlHYWHsPxQFrzkq1d
         oq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761696499; x=1762301299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZjzJP5BDJixdHcjsD4MEtXcdIeCfYM/75TifkWeDww=;
        b=W6cx1my8mbSVLqTB10lPbwelrGavxO7cmv6+LHKnE8X7asY8l1PJqBqYDg0/GOg+Hf
         hQJn7SQF9hi0S5YzZdf5Y1Kf8cpbYQ4InEP1Jrq2pFiTBX+SsE+qxP2rgvbbw+V/fbq8
         ULmUx3oCBuo0lqkPS0z19ctRGn1C7j0j5AIFVYIrQ1KcuQl6yDKWKLjO+f4GQmHxLPQA
         x9D5mRDBIyFofgd1SVvN8AHlxhMYJjILiZjYno+o5s1+nMq4Eefh3umenIOuqaQorWEA
         D3QmyZ3xilLkjWFZMr8FlDQCNmV0NYUWPMhvvQWpxvfyAxtHFZBEsTjTymuI0gM7wDlr
         ONEw==
X-Gm-Message-State: AOJu0Yxqf+cYmovhEui1JPcwY7zOAVS+9gRLzQhbY74ZF4haBdsqaMmD
	YgBQz6E/s8F8XD+C+2cMopN+RQW2xJtWJr/ZNP6TIBcApprmqE7pjup77QXRN3ZKcz/smmsCycs
	KlnMqjBJJX7Dc7CWfRgQLVzkLkzN2ajq6DJgvmgwI
X-Gm-Gg: ASbGncsYS5OnAEV11P/UkJRF7sgRyPxwJWPueH6P3i/uO1irL1qUeJ1phbW39Or3pEe
	QNGJYTXi6Omp8CDyCh89YO9hUAaKhiGsfWSYKAR95pD6PDVb44mjTxvaoalkxpxx3CQwIKNhrf0
	5+On3yfW69acf3cGil2S205VY1JteRp6hOC/SRX6rjR4IQ9T4Q2NTJ5rMeIiaI1U0Roa4pYNfB5
	zDe0i6u0p2c6RmX59KZQn6sPeQuzY74oTb7cRmK/JjIUwI0ssufv6sRdPpf
X-Google-Smtp-Source: AGHT+IGEKRPFq5L2rd6w/ubcuTn//BXhetf/wOj9xAOGHPjYYno+UXGan0WlvoJBaoZ1JF4tIK0SCxZjeiDlUqLjb6g=
X-Received: by 2002:a17:90b:4a05:b0:339:ef05:3575 with SMTP id
 98e67ed59e1d1-3403a294f2fmr971614a91.26.1761696498871; Tue, 28 Oct 2025
 17:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-34-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-34-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 20:08:07 -0400
X-Gm-Features: AWmQ_blBn2fdqYcxKi_H91_QLngZD09fAUzDyH5oMtRPekpRq9pqWMOuQKzGUHw
Message-ID: <CAHC9VhSeiK=qqLMUDAKRTgS5EEHdVvLD7-afuDqJWYFindvfUA@mail.gmail.com>
Subject: Re: [PATCH v2 33/50] selinuxfs: don't stash the dentry of /policy_capabilities
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 8:46=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> Don't bother to store the dentry of /policy_capabilities - it belongs
> to invariant part of tree and we only use it to populate that directory,
> so there's no reason to keep it around afterwards.
>
> Same situation as with /avc, /ss, etc.  There are two directories that
> get replaced on policy load - /class and /booleans.  These we need to
> stash (and update the pointers on policy reload); /policy_capabilities
> is not in the same boat.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  security/selinux/selinuxfs.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

