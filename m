Return-Path: <linux-fsdevel+bounces-66672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB48C2814C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 16:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B29340003D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 15:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA62F246774;
	Sat,  1 Nov 2025 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b="GqgHbGlj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8413F7E792
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Nov 2025 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762010494; cv=none; b=q/0alqdBr6sAEdiiKfl8yhF4055ouLL+ZCSn5OgzIo/cmKOJaKexyr9XJTdKq0bR9K9TD6UytDYgTe9XKOjHlGPsTyeFb4r1p5GRymp/d5p0caER0yP2eeWcnVVJToG4vij1Xswp7KvOdgB2h0lx8nUhpKkzFuFTsI5PpCFOdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762010494; c=relaxed/simple;
	bh=uUk76hdd0hwty+NpXdCQyoQvaOQi20A07N6O2nFjwxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBvrUOY25A4LzdN7CgdgtQ19LZJEqjSBDuzHt15iKXq9XkTJzIxDqQpY075KTF+QbvesEquKrRqz5bcN+9ln5qWjCR/6ENGiseNG59V7mGjGQ5ysVwobf7/EruVwc0j73RDM6/P99nPxmT2aLtC8DsjYkVpHUr6AV26ANdZOsn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe; spf=pass smtp.mailfrom=snai.pe; dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b=GqgHbGlj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snai.pe
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475dc0ed8aeso20962935e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Nov 2025 08:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snai.pe; s=snai.pe; t=1762010490; x=1762615290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJI0WCogeIwOOokvtkg3D7Kleng7z0nsAQZ89JplC0s=;
        b=GqgHbGljB6sL7qZYyOb7Ty0GyHiB/0820n79w4mBHkRQJPdLLs3QiR2fevsHLQHcf2
         eukym84COns2LJnHMqOf3QPF/Pdgl5tBNH1ZmYCYjl3IWiacXVP0KJZIQ4whK7nhpfIS
         7TGmzjfkZ+5hPqhHqaampWH1EelkqYHRiTjuXnAF5rqF9C1m/ookS8EW8Urheq+T/Ud+
         z5QxdkwuIit5/ialKXbatNv5hoq1lKsAJMdf4bU+apUCuIK+l74qr750m98Wk6U5BAVf
         woeRYL2KTRx8BCnCkql0Ui98U5J2/YcHcFEIYG+aYNojzKrTq66t9b31dsJUPD7Uffg4
         V8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762010490; x=1762615290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJI0WCogeIwOOokvtkg3D7Kleng7z0nsAQZ89JplC0s=;
        b=JQVbFDzgsYtC0GsytObB3uKLemiXYn5rr0Ed2Lgi6B11cA2vGvtQ4bF0QUmsK8R2/t
         PlrFQJbK81KFpJPPn4ACsPRBkHTMzK43O7JsQgwa7mBaPXgDnlIMCfc4soyFGH1m8TIo
         4boynKDcK3kE99IMjQiCeL2il2SxrAuyGvFMDJ8cXNuGl5HtvJllaW88/WZY1X01NPQk
         jzBKSycpo3pH+/IAOD0Npv8qXSTeF1pr2waITzaGyXNlcR4DCFYprYo9xSBAyD6GOLeL
         HnUchclx3rMSw7IIMeoVmlGpm6GDxo4/EJU4k36YJSJwmvIJkJDXMnpaJx5gYBwvIBgy
         P/Fg==
X-Gm-Message-State: AOJu0Yz2BIFZzyyHm/HYhRCcGaKh4Vg/JVp5y/QpQUpEj1j4mJw+WQZD
	PPRQ+m9/QOQ8MMRbH0uKi22kcaGrh8tYeKPGdZFhst/si9i02/6iij1CC28+JCSlX29MZLdXU2q
	ePVUb
X-Gm-Gg: ASbGncugw4pvMkYIyo2LMYtbRU8SiGa0NykhszzG+9TiWJzOsPyTiDPFNd0PpQyDAAM
	3ch9qegKlNqhw4uqGG81JlVD677ws7mH26TWJU0LlvlJAzi1zndWwsTiNYYymyWKMggFp3rAXfV
	/JfU3ZcSt768moMmcOs9nSzRdtkHif2K32s23YwWgO3FRf3kGYawbszIP3tg/eaGivQWnHT+hHT
	VBK8g6CEGYz9JReep5/OU8nh65f4s6T9oQctJsmyPlyeR4b+hOid+j2L8iD0USsU7EZIRHFtL1H
	otNfcnwSiH9Mxz2mVnbvI1lFteawWX4RJkhR8bA7eZYcMqZzzazHcwi7vgQWerv8ebfkWI4lmq1
	RUunksXV45db92L8olmm6YY3W2EjqN7JL+iXOMS2Gbo0morQXUKXGrP+xonOdgPXvv4r8OL9hUV
	dOJ22YYfATBrgfCMc=
X-Google-Smtp-Source: AGHT+IHW4Mjepa2E97irYso1hSJydfLi4WWuTcvVPuoBDeO/qcDBoX/3JBe0gTWrRQbyoty2WeZoCA==
X-Received: by 2002:a05:600c:1c1d:b0:46d:cfc9:1d0f with SMTP id 5b1f17b1804b1-4773086e04fmr79057815e9.19.1762010490088;
        Sat, 01 Nov 2025 08:21:30 -0700 (PDT)
Received: from snaipe-arista.aristanetworks.com ([81.255.216.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2e674csm53699555e9.4.2025.11.01.08.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 08:21:29 -0700 (PDT)
From: Franklin Snaipe Mathieu <me@snai.pe>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	"Franklin \"Snaipe\" Mathieu" <me@snai.pe>
Subject: Re: open_tree, and bind-mounting directories across mount namespaces
Date: Sat,  1 Nov 2025 16:21:09 +0100
Message-ID: <20251101152110.2709624-1-me@snai.pe>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <CACyTCKhcoetvvokawDc4EsKwJcEDaLgmtXyb1gvqD59NNgh=_A@mail.gmail.com>
References: <CACyTCKhcoetvvokawDc4EsKwJcEDaLgmtXyb1gvqD59NNgh=_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Franklin \"Snaipe\" Mathieu" <me@snai.pe>

I actually ended up trying my initial idea of adding a new open_tree
flag. With this, I was able to make open_tree work on a file descriptor
that was opened in a different mount namespace.

I'm sure there's some sharp edges I haven't thought about that would
make this patch horribly incorrect, but I wanted at the very least try
to see if it would work. At the very least, a cursory glance over the
description of may_copy_tree indicates that allowing this is, in
principle, not completely out of left field.

Franklin "Snaipe" Mathieu (1):
  fs: let open_tree open mounts from another namespace

 fs/namespace.c                                | 26 +++++++++++--------
 include/uapi/linux/mount.h                    |  1 +
 tools/include/uapi/linux/mount.h              |  1 +
 .../trace/beauty/include/uapi/linux/mount.h   |  1 +
 4 files changed, 18 insertions(+), 11 deletions(-)

-- 
2.51.2


