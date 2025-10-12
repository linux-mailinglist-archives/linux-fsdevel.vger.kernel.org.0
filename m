Return-Path: <linux-fsdevel+bounces-63853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BDEBCFFBE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 08:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77C3C4E19E1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 06:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796CE214807;
	Sun, 12 Oct 2025 06:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN62wl3G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430A01DB375
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Oct 2025 06:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760249687; cv=none; b=STtMJVD6qkRx0UG16AkQgonKw+JtT0GXEg7TTJymlgKMKFeUNVc4Xb8VGJecIM9Pz7K8+Ksjx3UM5Cu0/Q3/kNTNln34UEamTp2IzF8mBYZFlUSTVBeYWn2DM/RQtY/bitm6eYYGxhJU1h/UZUGfLR+e+TWeyUWYmjMXbm5p7TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760249687; c=relaxed/simple;
	bh=m+lgtySiSGGIWnsA66jgFuFum5hqvBvd8+jR6T+AGQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtHcnMYDgLnaXw5XIuY+v6y3nNpK//aK0sxRXc5qtZzJsZrYmkA2wNx4bGpxcWLRelPZ7w9d9gIxnYnY7bbb0hMi2fOVXqgo38NSuIOF56sC/iyh/QT/1I+DTOWU06IifOBpkXjgrU9OmHSk/BZbi9fXDXeqepCQJoF+5iNQrCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bN62wl3G; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so32544365e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Oct 2025 23:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760249684; x=1760854484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAOrmio62U43guzG2eDGA1f1tCPBMTpqSZuJ65iOtN0=;
        b=bN62wl3G9aJ4cFHvjdsCNuclz95UkSZ4tiJSzpbcPlQrY65LK+hJH408KNswZhby+L
         ZVaPiVytDIY/hmS3y/GE2HoN+ECiF5+nnPfFTythRhAnYlCJrmP1+0QzVonYBxyvaXqx
         rkh0rPBV6zkZZ5odUz1g8Wz/BQl/b9l+nUOe7SZd1Xk3eWj7xcmfcEYwQXyoVj4mY/1Y
         MgcZoCa9XF3s3Wup0eBbz6gAEatekzQzzblZKI6jD9PE/Blrh2Cs+xvnpMBdoYJUPVVS
         9IGEviITEmyzZD0Gbt6KlK7YIkE24TKm7DQSDE9DQ+C1FdlugFWaVLYP+TvEjnu4SmtF
         sRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760249684; x=1760854484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAOrmio62U43guzG2eDGA1f1tCPBMTpqSZuJ65iOtN0=;
        b=ZfazwKc8I9hNOBxCWnbKfqb0GtkK4y6MgC62J4N9yCPuPP3EY0fkZbSYsJVRlg/2Y6
         ecVe1qOnnZEFjg5oZHZp72ntYtHFv9XKn2z+WwucchTJntgmATfyFgfsYpTuIRjUXaxs
         uqNRnqurjtbkqBe+8N4I6PA/+IPq+ue2abblZw7PER3uynoaVI1Fewdz4kmM/g1sK3dO
         N0IlsqhpIRI/JzG2C18gS9BI3du5iBdUdkKNL6TByLNRESvG6H/kBtwQodGhdXZ3+iVS
         gA7eVcK//6XiVAIl4dwB+oTCVhfY7BO+3lenSYk3BRYxtnJpz8VRBYCc6Y0FkbbtKgOJ
         Y85Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRy2LP+p0+qsMTcFbzaPvF96KOx2vzHPkV0nq+ivOBYJ9TnIt/m3A1xgi59hQR4ojS98Z+IlQWDv+YFTPh@vger.kernel.org
X-Gm-Message-State: AOJu0YzM0PeKvVmwdfDj5i/AlMQgUbBQ0dDPA6SQYKFI+L7nrhjTOeOu
	EJleITLwvmWXiVGC1Ff6PY5mEtHu6kpvkczvAb+b7Jgnacl9BLCbx7OM
X-Gm-Gg: ASbGncvKN7xmEU1EQb2mFe+jjLYSt07eFJgupx4HPIc4m5CyUJtdLpr0LWCWbKqaiBE
	xJ6TT8kA6OkuGU+6y4wkQLZHxV7H9pdizsykPsWHaqKlhzoiQTJ5OtBY4ODoBvkMMY7Bey6iVpj
	vPNcE/PTm4wZSYs2Poso8ByGjz6SprBFmb9wIWikcEVpZm8mvyNiI5xEjc3YQ60uF7tWUsKX2gj
	4ZucoJbJ1paLPIYHFa/3ocILusHTVWlgSlAKshet6EEdpIzIvcHkrTjwU81Lp+ODfpiY04HyvBw
	1Oi/KFS6rXrvrBatrdClswMtx35+6fM/JxIIKPZwMd1uDJYbSQhdkNxtvLn1N1d+YfYfWNBJqOX
	k3zCVp4eSvxYZZ6PR4LYcvYU9dOSfXUFvy7WTpQ==
X-Google-Smtp-Source: AGHT+IE4rB4xnTmT6He562ThuiVG/pfm4Q/z2xiP28/GWf3Dt1Xuf0+3s0e0VYHIyISay5XLqOIEJg==
X-Received: by 2002:a05:600c:8b5b:b0:46c:d6ed:2311 with SMTP id 5b1f17b1804b1-46fa9af2f4dmr116769955e9.19.1760249684140;
        Sat, 11 Oct 2025 23:14:44 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce583424sm11699282f8f.21.2025.10.11.23.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 23:14:43 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: luca.boccassi@gmail.com
Cc: alx@kernel.org,
	brauner@kernel.org,
	cyphar@cyphar.com,
	linux-fsdevel@vger.kernel.org,
	linux-man@vger.kernel.org
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple instances
Date: Sun, 12 Oct 2025 09:14:38 +0300
Message-ID: <20251012061438.283584-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAMw=ZnQki4YR24CfYJMAEWEAQ63yYer-YzSAeH+xFA-fNth-XQ@mail.gmail.com>
References: <CAMw=ZnQki4YR24CfYJMAEWEAQ63yYer-YzSAeH+xFA-fNth-XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Luca Boccassi <luca.boccassi@gmail.com>:
> Almost - the use case is that I prep an image as a detached mount, and
> then I want to apply it multiple times, without having to reopen it
> again and again. If I just do 'move_mount()' multiple times, the
> second one returns EINVAL. From 6.15, I can do open_tree with
> OPEN_TREE_CLONE before applying with move_mount, and everything works.

This sounds like a bug. Please, give all reproduction steps. Both for
EINVAL and for non-working open_tree before 6.15. I want to reproduce it.

-- 
Askar Safin

