Return-Path: <linux-fsdevel+bounces-40133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E32A1CEFB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 23:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1E73A628A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 22:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632E6139D1B;
	Sun, 26 Jan 2025 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FULQ9gT8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD9FC2D1
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jan 2025 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737929012; cv=none; b=Ier3UEo/nLS2oR49sM8D8wippHKJH76D6vM65dVr/F3e4XXG9YwUQTrc4a1DI8wxjmB7HRySf+uh0RvyywKnEh5+eo2wXnCiLv6rNE+uTdQkO3GcIC6nB1JFyNdbWDIYRIgwmJ97Wrk7s07TnKZar8d8lfKBvZ6Ve2E8izWF0EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737929012; c=relaxed/simple;
	bh=q/ufU6l2hUFdP5eNKcLpkhRfcKNKm7m6TnU5RDxpY/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i01LIqD3GUDhLtstWr2QF8lJEmx2jqV2VctEHZjkXM80fK7VnRvQm7Ey44jbHzr0pZZSbVNn2Rd3grih9fQnLeiv8h4TxVxp66iL6X9lGTuCFgJkTyQyCx9F2uK0t60NHbW6WX/aEXSO1lHgFQo2ZQd1Cu4Ch7R9eJXbecKyrOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FULQ9gT8; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so5673997a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jan 2025 14:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1737929009; x=1738533809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ftAl2E4jhQVnt+zxNTCeWVpoj8xxkdI7zBdq0Uw0aUw=;
        b=FULQ9gT8Jh/2YKK2siEiE5gmcRa4ziDn0gRX1cXiKky27dPXBv6zTokFFw5DbSyWcs
         46MovO1iVLbr6DpED/+UDaVPey0VX2SxBm0d5l5HuzYZgkmsnUMv9DmNap5T3yyFZ9zm
         BBe1EVcdZz1OlUxn1Siev2mcNY3VAuxZy/PFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737929009; x=1738533809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftAl2E4jhQVnt+zxNTCeWVpoj8xxkdI7zBdq0Uw0aUw=;
        b=JojgHCvix5V+oHSZVoSmEU2gsgeC3mQb+Zt6WStjvJ2wt7kFv1BalWrDTp4qQx7B+T
         XPFPxhNOx+aVg3NXtzuj/eUQVIaPac3w1SxTT5l+/326kjR1yHXFkQI6YTiypJ+jTH9Z
         3V8XIjAhCf6zlL3Q6nPrjDZuJMMnQgvAP7pbW2MvmhM/xdLDPGttKSISI+V6CDEXWD/k
         /Bd91WnBykRQuCi1SUoY0ao/b8ElMAfHZrNPnDdtvBfQic6cPYhbYl47LHo6allQigd+
         Onq85yPEtLUqLOg5mKBKY9IK5PKanktT/90z5c1GNhckEecbGXOsE/NBjhwZ37MzMYjF
         O9CA==
X-Forwarded-Encrypted: i=1; AJvYcCVkFLUWjdTAcYlYHEFkQapKMWxfwKjUzQGPpIs5FvkA1mrp9mh+qgif5MTZrGoQ5/7VZixZbbab4ju3pN19@vger.kernel.org
X-Gm-Message-State: AOJu0YwzIoDOtK4Ft6vvLuWXSYh9YMZd4VQqdF5sJ3+UZuPDqBcAFxac
	GokYmTEbw1kbcyJtyH28Vvf1XarXPozYW+gpuHU+hYKIFW//lkOrMxVhZ6eV9VG5rSAjEGghDMg
	XVlI=
X-Gm-Gg: ASbGnct9F/qlkVK1NY9sAEqF++r4Zl4FkLrihYZwQldzoi3EFD6kmemIyZNMIdpwBZ3
	hnt9hjdBEJuZNTiHuilKBrPsiIp9VJMNNPFFIucCoaXVPHl+MZubyw89zRny8cLfB0UvHB47G8I
	dLhxm5GVdKkEQ9YATVKphJf1rpUbRv7Qrw/7UPqJsf8ZL7q9qfKSKDBB2TGIe1ZdRYaRUAwdt8C
	lYzs+0W7BGqz7yd1iEXRqIvxGvklBMED6qqyZpLhLPE7vqgKM0KuRblywerPRErxQPJr7VPek8G
	Tn3XR1HwkvV3KBhsJXukpjwzP9t1II5UFXJoZM+LE/seh4g0+pM4SGg=
X-Google-Smtp-Source: AGHT+IFkILG3r+BtDujFfFovN9QphFoOXTOuTeTJtu9Au19psToZ7hyaOvTehOwJQvBKGS0ppX+XxA==
X-Received: by 2002:a05:6402:270d:b0:5d9:f1f7:5bcc with SMTP id 4fb4d7f45d1cf-5db7db2b295mr79859423a12.29.1737929009087;
        Sun, 26 Jan 2025 14:03:29 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc18619346sm4457324a12.8.2025.01.26.14.03.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 14:03:28 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab69bba49e2so116088566b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jan 2025 14:03:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFOD5B1LDZWMhEAxjB9fTQ1BAEcAV/eIWKzWUqxbtbRIx6aF0mRSp9gTE9wmWN8RtyI0Bt/8kPCVF2sxIQ@vger.kernel.org
X-Received: by 2002:a05:6402:5106:b0:5d0:ced8:d22d with SMTP id
 4fb4d7f45d1cf-5db7db07334mr87191980a12.22.1737929007310; Sun, 26 Jan 2025
 14:03:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20151007154303.GC24678@thunk.org> <1444363269-25956-1-git-send-email-tytso@mit.edu>
 <yxyuijjfd6yknryji2q64j3keq2ygw6ca6fs5jwyolklzvo45s@4u63qqqyosy2>
 <CAHk-=wigdcg+FtWm5Fds5M2P_7GKSfXxpk-m9jkx0C6FMCJ_Jw@mail.gmail.com> <CAGudoHGJah8VNm6V1pZo2-C0P-y6aUbjMedp1SeAGwwDLua2OQ@mail.gmail.com>
In-Reply-To: <CAGudoHGJah8VNm6V1pZo2-C0P-y6aUbjMedp1SeAGwwDLua2OQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 Jan 2025 14:03:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh=UVTC1ayTBTksd+mWiuA+pgLq75Ude2++ybAoSZAX3g@mail.gmail.com>
X-Gm-Features: AWEUYZkT1zJPUOsJDklhxmCnOi9qrGHPGP5lqGBukO5SJTzO9erJAZyCyaIHD94
Message-ID: <CAHk-=wh=UVTC1ayTBTksd+mWiuA+pgLq75Ude2++ybAoSZAX3g@mail.gmail.com>
Subject: Re: [PATCH] ext4: use private version of page_zero_new_buffers() for
 data=journal mode
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Ext4 Developers List <linux-ext4@vger.kernel.org>, 
	Linux Kernel Developers List <linux-kernel@vger.kernel.org>, dave.hansen@intel.com, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Jan 2025 at 11:49, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> This being your revert I was lowkey hoping you would do the honors.

If it had been a plain revert, I would have - but while the general
layout of the code is similar, the code around this area has changed
enough that it really needs to be pretty much entirely "fix up by
hand" and wants some care and testing.

Which I am unlikely to have time for during this merge window.

So if you don't get around to it, and _if_ I remember this when the
merge window is open, I might do it in my local tree, but then it will
end up being too late for this merge window.

             Linus

