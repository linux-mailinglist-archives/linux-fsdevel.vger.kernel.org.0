Return-Path: <linux-fsdevel+bounces-53955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E3AAF90CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1FDA168659
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 10:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A2B2BF012;
	Fri,  4 Jul 2025 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0m7k8a5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89DC286418;
	Fri,  4 Jul 2025 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751625668; cv=none; b=uO934N2N7SdlLiV5hoUuOyJRmTlL12OSwDfIa9MSUSQxmnMbNr6z0Y/yseBMA5vaMyOYO2Ep2WPlBLN0vf/b04uqZqhX9fOw/+6uYYzkVA0hY07rysMzvpJ8flJtB87L3h8bK3Iwmv7+2ALlwarwSulxr0aSiMBLd6rfJwYzvn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751625668; c=relaxed/simple;
	bh=X4yEOmShYkyGdDG8jUDfJmpuAowTz2C1ktaJJvFjvK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OOYYW5T3W7AW1+YlgwuFxuCXkejviLoyaev2osz597rT7x5jo6tE/RuBmVsG/aamqG/8ras2iF7PlRZcL2Q9MMsIZlhhFg3C5xkNXOa0+gmilzOgsOC+ciFwayt2TURqRs7dM3g61xiu2rh/pnCvQqpzCloOjE64ItUkZCzWLsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0m7k8a5; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so1216949a12.3;
        Fri, 04 Jul 2025 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751625665; x=1752230465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Otye1kCoP0BhCgEfxZf771/Q3ahhGvTB6tzyRbYtKT4=;
        b=a0m7k8a5cvQa5vhzmT7ZoGUGIW7vTxEO/HYf2Hza+uySZNTXkm2mQ1591WPGCZXGRi
         9ww5FIkjAQaXTqxDX6FBb30/59jo26zo8F+h022s4tOlnk+F3Rq6kYaicpXEF4fc/U0j
         KE46Q1W4eVLjQRb5sYO2zv6+EGOIY8gR6UT9gtDdCE/NIsbh3Cxq9jDV5eTdokPsO04I
         /qe7qDSjpdi+KF9lzdtxCi0HpLfm+cBKdWYLwXXh3Jyd9LxuX480ccxGL4HKvsG0rLDA
         4B32ygcKyg4+nISOCDsyY2lWNRGpz/HAdFp9DIhg3ZlCwERVJvuNi3kpcLPuoxuQanvS
         nL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751625665; x=1752230465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Otye1kCoP0BhCgEfxZf771/Q3ahhGvTB6tzyRbYtKT4=;
        b=AsqsmokgCpv0SFgDuCnoqpI8lmDk98S48nKwofIon3Z7s3NcNQNL/jp6TqCPqMZ/1Y
         zy7y+oUbdrRaG/S1uBWTP/KzxuD7/8UBbF3KmRFbmSdtuCIBwwp/4ycLe3LnSWlj7joy
         pKhRbAn1ktfDae3NXOPKwDJuGH357V0/Oyj6SVNjBfZPnt6BPQs5w7+sHLHjLa47AD6l
         FLwCLqxUYw5sROF/xZf0iWuuVaxw1cr0R/Md/lae2s8CX5BaABoFzMzh8MDwW2l45GOZ
         30IoEW/iACD4Tej7vT4KhQ11/4XAOY5qMItKuWCqOrUe1jfDOKwDucr70e+a9/Mmv4jf
         K8FA==
X-Forwarded-Encrypted: i=1; AJvYcCVby0TLR8Ok6hZCJuXpVorJHjxEN18ASAYdV19AwiXL05e7O10k++BCtRRsZ9wP7MUJKVaMbTWZxF+LSWKw@vger.kernel.org, AJvYcCWlVpJfLcR6iHQlPy699aILzVM89P6ZLVaPxthQ7ttxucSVhd3Fu7qNxZwKtMEWdkWlRGiQvhujOZCwOgzL@vger.kernel.org
X-Gm-Message-State: AOJu0YycPXUc04pv/yoZp5cdu8V2IMX0mpWQDhsyd1MkI5Q3W0Hd560s
	VS3OVZV9ZYHShTF52eT62AqrtZDXW9N5eywDyuksDha0wIcWRzdUDgPA
X-Gm-Gg: ASbGncveBS6iXpVadmw8bSRXHla9R9H4g65cdYHmC0bK0gBYhr9xHhnY/DdgGTBXfBR
	2wzQzOA7fH+QzcWMri3F3kId/E/d+LhfXJFyWGJD2hVLH6k3MrJsC3jeziLF6qKjopvSQYQxbs8
	Jd+N6VS+AvYpBaTdak9C1AXMNyym7vSGvX5QWkak2Ajvohmwd7FXsQSuL68jIWnyOpsQJCQDDU+
	C4kWsuK2bdJQ0D+36LWlnHiJC99WisCIs2CuosDQWHaJCsSsf99/RoEliEK3L4JoSh0YTXiqkOJ
	ILNqpHX+H1TyJfKpWfnUFRoyTyrz+82fSiX7NN3SF7YQep2A1B9tJ1kKtJwWTf/LcIyzp6ji0LI
	NivxKB7xsEiqweVwRCQ==
X-Google-Smtp-Source: AGHT+IE1gEqPGZad76uyTc44DenoyGmNq3Xc7sqhmB/KF2p1ubdw09jNycjUCWZvEgDEn+wPUctvFA==
X-Received: by 2002:a17:906:d554:b0:ae0:bbd2:68d5 with SMTP id a640c23a62f3a-ae3fe457654mr139080766b.2.1751625664979;
        Fri, 04 Jul 2025 03:41:04 -0700 (PDT)
Received: from Mac.lan (p5088513f.dip0.t-ipconnect.de. [80.136.81.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66e6f30sm152102866b.33.2025.07.04.03.41.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Jul 2025 03:41:04 -0700 (PDT)
From: Laura Brehm <laurajfbrehm@gmail.com>
X-Google-Original-From: Laura Brehm <laurabrehm@hey.com>
To: brauner@kernel.org
Cc: laurabrehm@hey.com,
	laurajfbrehm@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] coredump: fix race condition between connect and
Date: Fri,  4 Jul 2025 12:40:42 +0200
Message-Id: <20250704104042.86223-1-laurabrehm@hey.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250704-ernten-fehlschlag-05a175183e12@brauner>
References: <20250704-ernten-fehlschlag-05a175183e12@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> kernel_connect()
> -> sock->ops->connect::unix_stream_connect()
>   -> prepare_peercred()
>      -> pidfs_register_pid()

Ah, thank you! I initially ran into this while working from an older
tree that had had the coredump-socket series cherry-picked into it,
but it was missing Commit fd0a109a0f6b7524543d17520da92a44a9f5343c
("net, pidfs: prepare for handing out pidfds for reaped 
sk->sk_peer_pid").

My tree instead had:
    static void init_peercred(struct sock *sk)
    {
	    sk->sk_peer_pid = get_pid(task_tgid(current));
	    sk->sk_peer_cred = get_current_cred();
    }

I switched over to the main tree when preparing patches, but missed
that the issue was not present there. 

> Honestly curious: is that something you actually observed or that you
> think may happen or that an some coding assistant thinks might happen?

No coding assistants (not a fan), but I understand the question. I
maintain some other large projects and we get a few inane patches
too. I usually try my best to avoid making patches such as these
without some amount of double checking if I'm addressing a real issue,
but I did run into the issue I described (about half the time,
depending on how fast the coredump server ran) in my tree, and I
forgot to repro after switching trees.

Apologies for the inconvenience, and for the understanding/quick
replies!


