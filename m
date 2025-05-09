Return-Path: <linux-fsdevel+bounces-48616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1275FAB16D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DDDBA21D8C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDF929209C;
	Fri,  9 May 2025 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kJmjPEwL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854821D5B6
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799244; cv=none; b=fq4Ruijuf+ChxSuLydcVW4Q2cnXcgahzA+vXxPpfDuc7XuUmwXd6BwIw89l6d+V1dw9oZQ6kAFFGlO+mXj5B52d+5S537jtmPUfmcA57ZFrjzutFE4J0FMh8GiBx6aYSd0gSAyp1Bf/tVND2CQmk/B3rV9sJ0XMBKuoai73KyUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799244; c=relaxed/simple;
	bh=/nEfxeCBEnRy4J1NhW4ZqzTcGc1y/vXaM52vTSkRK7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCmzF3epaxpBxPZejHNvdWKqq3MxA3oGH2JHJcY9VZwAzIUe0/BsQuP3woXChjo3eXPGH2+SbGNMTzJISaKk0BZgzlEKnm0Wvhmsb6zRR/LeqimhjPl+JFOdX1xPBb04ViI5t3aUNxh0H2X+IrG7W8ptEn+T4E6v7j44QfFO4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=kJmjPEwL; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-525b44b7720so673134e0c.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1746799241; x=1747404041; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MLzQadwrXSWBi28Qvo99BU7DHYabFA9gVXIbPnyaBXo=;
        b=kJmjPEwLulPbgtscVmcmyCYbode1jRuculUcYeCNZQ1sst3pUxy+0o08To9fDOqf30
         6iWFCDh7Za4OH4WT3DRBN4s9S72USyRcR/JbLGhr745og9ZaTy3hFof/TLMU19PAkh2h
         Jr4H3CB2HZZ8ZPSg3mluIDY6Ti/uMWLzECu9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746799241; x=1747404041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLzQadwrXSWBi28Qvo99BU7DHYabFA9gVXIbPnyaBXo=;
        b=LTKSeG/Vyqt5PjPaOh/bBi+QvC8Y6od2q5b8v0Nh6s7M6ERDaEJGPvE26GCTo4nZlJ
         OY3qcJGxsjgqYbhmqbveno56pHRbSsnc+Ssr0jdgk5/fNodvznuR1DpXtiMXDbFDZzqz
         laCAGAH5S9ZfJ/SdpyBbuU2qwlHyb3ZBaaqswey175ZOjBzv8A6psoxRkq2o1ROnhraR
         1Erjr+kQYIH1BbsBLAb93G5JGVtdmWlw65/I6+qXj83+JDZg4Y9ddEjOTL+4G3tVRC8m
         /lL1R+Yi7foj2J+xIZApSAdgHRYyuxfogli8Sk8I/C7wbXyHSJ91nQXYihQFJMo8mZc/
         p/UA==
X-Forwarded-Encrypted: i=1; AJvYcCXMd+2wwBaPndJX7mJ0J5zBDk838Pz4nUV/7w9ZLkKHtsmWf6t0WXar+cpqKGWw6btXyedy0ET6InuKrdW3@vger.kernel.org
X-Gm-Message-State: AOJu0YzqOWkVHSLfw5fryVgR8E9B3rXjGuwc4WwitY9wrI6/BLge4NJm
	WF9dkyVxaBiyiYTzsWqKqr/ZhBwo+RTuCYptMgvVgu6uDE+TY9r3ubhsnu5aI2RFAS3B2HcmazZ
	lO3691wAsPHOWC/GDrJGhaSc3KVaVqJviTayviQ==
X-Gm-Gg: ASbGncs0KYI/S9cdr3jt/0Nxt8blYToedX4TwyMSJSe7GIgrxan2lY97QRmom/u2Doj
	yyNYx0wznqKOm3Fp1NC9qmiZgbY78oTav41/YNuILgzD2dC8jnofMIvNJRRAzxpI/JnSJx1SIyM
	8W8p0TerDIgBp8flUgsva+ABhJ
X-Google-Smtp-Source: AGHT+IGyXCmdqeHIcOPC3gHNLGaFw/4ws3BpBLfMJMQe3MgaB4FgAiGLVSqxSN1BdX83jJnLj8SFCFTwHy+JNqvfxq0=
X-Received: by 2002:a05:6122:828d:b0:52a:d093:75ee with SMTP id
 71dfb90a1353d-52c53be5491mr2951764e0c.5.1746799239114; Fri, 09 May 2025
 07:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com> <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
In-Reply-To: <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 May 2025 16:00:27 +0200
X-Gm-Features: ATxdqUHItDoVCeDRwi4i4w5h2rc4ClAFNW1aPU31NxRA4fxq0P_KhXao0V8Zs7w
Message-ID: <CAJfpegvhZ8Pts5EJDU0efcdHRZk39mcHxmVCNGvKXTZBG63k6g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: chenlinxuan@uniontech.com
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 May 2025 at 08:34, Chen Linxuan via B4 Relay
<devnull+chenlinxuan.uniontech.com@kernel.org> wrote:
>
> From: Chen Linxuan <chenlinxuan@uniontech.com>
>
> Add a new FUSE control file "/sys/fs/fuse/connections/*/backing_files"
> that exposes the paths of all backing files currently being used in
> FUSE mount points. This is particularly valuable for tracking and
> debugging files used in FUSE passthrough mode.

This is good work, thanks.

My concern is that this is a very fuse specific interface, even though
the problem is more generic: list hidden open files belonging to a
kernel object, but not installed in any fd:

 - SCM_RIGHTS
 - io_uring
 - fuse

So we could have a new syscall or set of syscalls for this purpose.
But that again goes against my "this is not generic enough" pet peeve.

So we had this idea of reusing getxattr and listxattr (or implementing
a new set of syscalls with the same signature) to allow retrieving a
hierarchical set of attributes belonging to a kernel object.  This one
would also fit that pattern, so...

Thoughts?

Thanks,
Miklos

