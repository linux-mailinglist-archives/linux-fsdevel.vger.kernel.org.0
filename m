Return-Path: <linux-fsdevel+bounces-71252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7544DCBB200
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 19:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CDDF3050BB2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 18:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F852EA48F;
	Sat, 13 Dec 2025 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCdLxKGm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D121E1D54FA
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Dec 2025 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765648851; cv=none; b=U2tceJCEo7Xrdl5WlmsgIhi8F1ZRDQ0qCxjBBSpkZpn/j5abp1jBK+/9+smIK4W5P84WL+76j412/EB87pfP27g5oI5PCMyGtF1Dy8uLK1RUQKlCdP3QcERdE7aWpsK2YBlA7a39IUMk9hGaOiWawzQ2caUK83M7Tfb8Y1ea7YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765648851; c=relaxed/simple;
	bh=N/zUMxFBbSB205mUmuRMfy0HVY0fdn4HwQ8lIcvIaGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsTXB95jzXp6Ogq2udq23XGTt0N00ZTuu3hBIXhRrS9S0n96m1pGAbZcYNjJoPaBSQ2VuHWM+QROAnCGboq7WPULwWMReMV3YuzqxIOz1C3m2um62QSHOSmBGQPwCmLdiu7SsYoByKtQkVtFSY8aTJT0zZrqyHbIAHMfwi0+VKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCdLxKGm; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4edb6e678ddso29957121cf.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Dec 2025 10:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765648849; x=1766253649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/zUMxFBbSB205mUmuRMfy0HVY0fdn4HwQ8lIcvIaGI=;
        b=DCdLxKGmcdg3D52xogHY34AnurRxG+Jnsw0x9OCC2IAy8ZWJEAP2Fvv0TY2OzJZjaR
         Akh/1KhmO7wUl2gn89lZ1Y7BFfGLBqcY9u9TWhWW6m4OaLBU07YYF+DCU7v/gxKtpjc5
         fcANly2G4seB5GvODH3jQWqj8Iheiq75+HLCmDp/Zn1l/d7Fk172ajm1YWyYTHieJbRj
         NyJveErVhDUd4Hjuw5j4Pw2JU2emN/mgNm36x1XNkczCF0sVmX13Nx/ULJqOuUbaCa9s
         oFYxQ3K+asvo2VX1HGu8ag1AQVWSUOHsoWAlReHc1kh974byG9uPKG2bxhf/hzDlPxQq
         uE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765648849; x=1766253649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N/zUMxFBbSB205mUmuRMfy0HVY0fdn4HwQ8lIcvIaGI=;
        b=eWfXv4/+lx7UBqXd2EhZxwM5k5Qg2woBkILzY8Ocdm3emMudNBLUgzGXpNJU7bb7G8
         hizkfrWusxGcS2Q18dufV/j5bHvPn35taHuUWdLUxB1jkb+19GHCuwYKVWr8/EIjQzXG
         emKnwfaDpC5ekbRPmw9SGwUqM4Sn+8hJf9vMSDx9ObkRLqZN6QrTkOVzrvDzJZSu3N86
         cy/x0x4e7l9DLtQRhvXP8CYr2X2oupYRSCmzSV1ZzIj8D4WJWK2NAKoVE/7l38YH9NCX
         P4AUmmKa75pog0Q0ayhHWn2pmBq1RipukAw2w4hlEqYBnU7JBerNKFA3WJJDen3+urTl
         5aKA==
X-Forwarded-Encrypted: i=1; AJvYcCUR5cE4N4DX2U4yz9f1kpFi9iHEJAz1d23reSQJVBNw8fvVSzUlxdz8cIuoPoNABpY2Y29c+2djhekoeHBV@vger.kernel.org
X-Gm-Message-State: AOJu0YydazDuqa7wUfSGu6TGUxvS13tZWG3tJj6EN1fbAnKA4JXdt6eb
	s3iQZdu13wortvhOPqq+T2pW86FotB7fpOc/ByHPV8CAyp7Uph5OPLNK
X-Gm-Gg: AY/fxX4wxjNtrH0rHamRMa6/9ixYTolHjq/LPnF+OEKj6//rgNVt90rlwr5ovP3FfVB
	NTpWqLY3uFwvcLE1bekrDoabBC3d+RZfSkOGzaLZbnTZu6Uktkm3J378DKwcJE5kUs9e3ZN2S+L
	fUtk6cs20VlYngkjgTIU00YxsanoBONnfxy0mB+dD+W+xGZK8ugGouNC2weUpI3oo1FF6+IFz7D
	DJpc7fLxTTNwJvzsd2vUGsyXCLG2aIO8toF7GOYwQYKIUrad4+A0yxGPsCoFPX5v/WsARMRPBrT
	GCOLiLjyERs/kIiLSdZSo+Jb9WnwHLHO8AuetC1D9su2RvZ1bm7IiR2egSJWO917HpoACx9CsAD
	tRF6ycx5XJRVDkfk71g2Ks6eQxZ+eQm3YT1ewMY0Dov665HPC6ltX6PZRTn2kmWl/FXTHrbD5hB
	R3vTCD3ZVGudv5GBig4CVlRT+MEEjGyBdk+C8=
X-Google-Smtp-Source: AGHT+IECdC7Qr/SWuLGyQRiaBZF1wiJWW7U0gQvluOjsgkry3CxtA0lHEoNwLgt1a/F4OX9fHnZGPg==
X-Received: by 2002:a05:622a:1f97:b0:4f0:2378:59a1 with SMTP id d75a77b69052e-4f1d06116b0mr79044141cf.72.1765648848640;
        Sat, 13 Dec 2025 10:00:48 -0800 (PST)
Received: from dans-laptop.miyazaki.mit.edu ([18.29.49.101])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab566608asm715702185a.21.2025.12.13.10.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 10:00:47 -0800 (PST)
From: Dan Klishch <danilklishch@gmail.com>
To: legion@kernel.org
Cc: containers@lists.linux-foundation.org,
	ebiederm@xmission.com,
	keescook@chromium.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [RESEND PATCH v6 0/5] proc: subset=pid: Relax check of mount visibility
Date: Sat, 13 Dec 2025 13:00:38 -0500
Message-ID: <20251213180040.750109-1-danilklishch@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <aT1ErArrTmp-sAiO@example.org>
References: <aT1ErArrTmp-sAiO@example.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> It is much easier to implement file access
> restrictions in procfs using an ebpf controller.

But if we already have a masked /proc from podman/docker/user who
decided to run `mount --bind /dev/null /proc/smth`, the sandbox will
not have a choice other than to bail out. Also, correct me if I am
wrong, installing ebpf controller requires CAP_BPF in initial
userns, so rootless podman will not be able to mask /proc "properly"
even if someone sends a patch switching it to ebpf.

Thanks,
Dan Klishch

