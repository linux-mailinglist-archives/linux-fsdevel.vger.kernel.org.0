Return-Path: <linux-fsdevel+bounces-12630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46D7861F4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 22:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB84287649
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 21:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0F514CAA3;
	Fri, 23 Feb 2024 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KPNTnF+O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B10146E81
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708725538; cv=none; b=tfQA7EQ6mivyIP7xsmOHvt1nAXDKoEDBsXldwNxq7obn4wGbUrPUAeka0CZRHqNxykiiTJE3gD16M/Qd4+hXFRoupdwS0TW4MZt872JoYYzWxfEPUz16jtlrItWdq+1A17YAP6xvnWk6NTU8inScUuwv0X9mo1nb3Pvc6jIXdp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708725538; c=relaxed/simple;
	bh=mQuV0yZjIft1JmIQDi8GCAAwiFtPYfz53mkFU3S20es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSG6t7fwkBucGbRb/FWO3up5uw+uvqV+C0B+wUSJBzC9CMvapMI5j5F2HXk+i5xTfRZaqC9QwBhAMknZLNuqDmLa7XjPUQAmglQz4l+qReo08LOGDtaDyOanOMp5p+eQDKhEHQCZpqRmSlX4Q8ewEYd0tl8Br93FlTCgJyFqqWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KPNTnF+O; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512b4388dafso1039273e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 13:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708725534; x=1709330334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cluO4hOihZqbJTGxEk+KwHeb/qJVX5aJw8x5hFc4fQs=;
        b=KPNTnF+OkLX22856pMi2/yDnpABzBLknVrGGvXZr6V5WPNuAUSh4d9n1eSPrfBhiDm
         aS7gicmUqj1SlNO1AQ/GbDs/LbInYfh/y6T099BZ2o9HWhcBl5S/IX19mQHXAusVl4bM
         5wKtfEFEipx2Dqnf+fjoxLbtMntMVG5w2vp6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708725534; x=1709330334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cluO4hOihZqbJTGxEk+KwHeb/qJVX5aJw8x5hFc4fQs=;
        b=RjpmeOtRlKXFKakXPYelpuktmzUM6+kZj4ca/BSvwfp87zt1s5MU+YssP71TcJw31u
         CQ+Ggs3vdZDxyRTin1j4G9PweIUdWY1LnpjV6rhzscYB3WBpL9iW8fSPtlxKzuN3YKoP
         FrOa5I6RHIqSO638tcjTpuCAdZlGpaSJZjnQWB/3LvFP9k33ST1JGyDmHsH0wuN8FXuw
         EhSP+ZGXFO0yCOSUarwRcjsKkcvenqRKjjDcvWVCZ+F3NacRNbNDIAUw5z+gYSWjqj0e
         YVUwgE7lia9eImRh12rDna/YW2T7UG+0lht0fz+7S0lKCMxX1fXQWNLcUTdPc7mkZjTW
         GDyg==
X-Forwarded-Encrypted: i=1; AJvYcCUIufQRqkiGUihuifSGZ0g7FbDg93HsyQq1ROEp0A/x8vA9eX92Bh9v/+ljP4XvJXljj05v7uUdbq8HrQk/G4UMUq4ud0vCg9UmuAuzYg==
X-Gm-Message-State: AOJu0YzfH5Q5QvDU6W92rk/yFGMCPZWXqrwaSLSGTJWXHAAGdj93ZCuW
	WX3i2P5GJUeCrnui6fKfDDEiMLw7FQAxjNDVzhu+7NuAbJC6GsisyqbRTLR+tn+BNVGiGfCV1Eg
	dFUU=
X-Google-Smtp-Source: AGHT+IF0COwHHP+4D2KEPlgE6D7h+R65DT/EruC/uFOk/RowVqLWCPOLSQgt1gOzbV9+IKWolubmVA==
X-Received: by 2002:a05:6512:3143:b0:512:b374:ec67 with SMTP id s3-20020a056512314300b00512b374ec67mr580331lfi.58.1708725534459;
        Fri, 23 Feb 2024 13:58:54 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id se7-20020a170906ce4700b00a3d26a25cbasm7199972ejb.37.2024.02.23.13.58.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 13:58:53 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-564fd9eea75so1195932a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 13:58:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVvHzIA3TrkhOz/Yfs4s8PTh3JLWc8j9pDI7Wyt1fy5ljJxK1KExp8+VhWRs1tWJ9pE9qYWcRIcDhtpc/YWrz/dWv9s8ATfDVaxp3GlTQ==
X-Received: by 2002:a17:906:3397:b0:a3f:d797:e6e2 with SMTP id
 v23-20020a170906339700b00a3fd797e6e2mr596297eja.28.1708725533385; Fri, 23 Feb
 2024 13:58:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org> <20240222190334.GA412503@dev-arch.thelio-3990X>
 <20240223-delfin-achtlos-e03fd4276a34@brauner> <20240223-schusselig-windschatten-a108c9034c5b@brauner>
In-Reply-To: <20240223-schusselig-windschatten-a108c9034c5b@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Feb 2024 13:58:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg0D8g_97_pakX-tC2DnANE-=6ZNY5bz=-hP+uHYyh4=g@mail.gmail.com>
Message-ID: <CAHk-=wg0D8g_97_pakX-tC2DnANE-=6ZNY5bz=-hP+uHYyh4=g@mail.gmail.com>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
To: Christian Brauner <brauner@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, 
	Heiko Carstens <hca@linux.ibm.com>, Al Viro <viro@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 13:26, Christian Brauner <brauner@kernel.org> wrote:
>
> So, the immediate fix separate from the selinux policy update is to fix
> dbus-broker which we've done now:
>
> https://github.com/bus1/dbus-broker/pull/343

Why is that code then continuing the idiocy of doing different things
for different error conditions?

IOW, it causes user space failure when that code doesn't fall back to
"don't do pidfd", but then it continues the crazy habit of treating
*some* error returns as "fallback to not use pidfd" and other errors
as "fail user space".

That was the fundamental bug with special-casing EINVAL in the first
place, and the above "fix" continues the braindamage.

Did nobody learn anything?

Also, honestly, if this breaks existing setups, then we should fix the
kernel anyway. Changing things from the old anonymous inodes to the
new pidfs inodes should *not* have caused any LSM denial issues.

You used the same pointer to dbus-broker for the LSM changes, but I
really don't think this should have required LSM changes in the first
place. Your reaction to "my kernel change caused LSM to barf" should
have made you go "let's fix the kernel so that LSM _doesn't_ barf".

Maybe by making pidfs look exactly like anonfs to LSM. Since I don't
see the LSM change, I'm not actually sure exactly what LSM even
reacted to in that switch-over.

           Linus

