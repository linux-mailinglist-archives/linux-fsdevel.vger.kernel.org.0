Return-Path: <linux-fsdevel+bounces-31781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D41399AE28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 23:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAFC1C22A6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 21:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1581D173D;
	Fri, 11 Oct 2024 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LASzk+CF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C611D151F
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728682950; cv=none; b=kAcnNxOrIUoV+cHnYAeh0JZOJ70dMGFQP7aysRU/7vLmjWqN2v/VJMLGCX3Cmn+YJVLPNryIheYZCQZSylXoNDOnTNRn9VGYmTXBVJTCVgzdBKx66zH7Ah7D6uydOE/Z6VXxsANNhtZC4pZtv0p6OYzJy9YayqpfM3rxmOfjTKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728682950; c=relaxed/simple;
	bh=m+LlSFZiZ4EdyTP0z768l0cUfXeAV9CGldpFQxcl9us=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=tQswMu907wPt0U2miiTQbvIczIiQwuWqO0940i/dZ6BUdeREmZCZttvTzWfFdkyk75WX1lC+LzOP3rYgkKY8fDgNokb46ofvnwYljznfrcUwM19LnvUbTsMmNbt1BPBXCa4VcTeKIOQX1eWz+bpzglQ0nPsMDEOZbUt59yEZ/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LASzk+CF; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbf2fc28feso6928426d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 14:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728682948; x=1729287748; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YdNIDV6aOrHYYOm3W6bJ2hofeoY/nb2/SNegHSUAfN0=;
        b=LASzk+CFLdjtSwr2lyGOS/narpVheYp7YqZnSDP7cvQHTTNoGdtGibK/xjlsW3yUEd
         7oXJbj4kZEBXdu7KxAjFSr5c8zZM9sS0uulQra1cgyUWop95KqV8WlpYwJIZPo489ZLH
         N5EcSzyK5lsvw2hPt7hJrO2XK5OEuYz4NIftwmW0ve/+qCh4m6tfYt6FoeVWcyvARdXo
         40hLSAPVKtQHQNNirdmx5bDbprlnbuRe8JMe6bgYKZD2buKIBDQwsFgxUpvdXfl9jiOq
         bLYuBGduqku1qybOj1Tam7+Ei4MU9CoSRculqrCdVKW9oh5/Bp94LfVOJlEsKop4iVMs
         DKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728682948; x=1729287748;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YdNIDV6aOrHYYOm3W6bJ2hofeoY/nb2/SNegHSUAfN0=;
        b=N4Opz2PVCe5VmG7yoTwSwUkT1CCX1oUeuo4N15NInwcaCRRALpcEue5vjd30A7s3KJ
         yHsJQcKks7xztK2TlkMwQVg0WEX8ZbK2g4KKJq4Oh0keBxOFRKZpXrnIZwiRN2zl+wVY
         GTdv+FleMX67vM4F1jrIOxgoJsZiKz253PNJb/d/MbZBhIQBNMwJYt/T8LdXG8eFI2rG
         KioAi93skbzdLG6tdHJPo0GiG/H+JophCEDh7BlWyZxeTivbZ6SvDI3QrPaFm4eEAf2L
         08om64Ph3h1jX8CdzokVIC2bhxiTrA+Zwpvcb2FrXp9F3hJEs99RmeYNtwpo24RfT5f/
         c+PA==
X-Forwarded-Encrypted: i=1; AJvYcCWnsAiPvBvQ4f1JgQq19gc6qsvi3cZKo2nukKjpp6sjLWe1J3YlNLUjJeuWZVnfXbr7+4l78BoGbIsY2ntB@vger.kernel.org
X-Gm-Message-State: AOJu0YxD7BKkpE/HdYNsTCiMtaoYohgt+SJgbNKZVCUMHfQeGVa3tZ0W
	G/Pi4NguGqTg8G14RjESZduNDW3JgMxZAzjl/vj8V7ItlQe41VcZWV44p9hc/Q==
X-Google-Smtp-Source: AGHT+IEh+B2X5EjxY/cs15tAetwL781t8oGupqCkY1RdKOysHJaJeW1Ecay1sZmGrh//AIBwq1Gwhg==
X-Received: by 2002:a05:6214:4883:b0:6cb:f907:ae4b with SMTP id 6a1803df08f44-6cbf907ae78mr16792076d6.20.1728682947732;
        Fri, 11 Oct 2024 14:42:27 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8679de8sm19680746d6.136.2024.10.11.14.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 14:42:27 -0700 (PDT)
Date: Fri, 11 Oct 2024 17:42:26 -0400
Message-ID: <a083e273353d7bc5742ab0030e5ff1f5@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork/sendmail
From: Paul Moore <paul@paul-moore.com>
To: Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, jmorris@namei.org, serge@hallyn.com, kernel-team@fb.com, song@kernel.org
Subject: Re: [PATCH] fsnotify, lsm: Separate fsnotify_open_perm() and  security_file_open()
References: <20241011203722.3749850-1-song@kernel.org>
In-Reply-To: <20241011203722.3749850-1-song@kernel.org>

On Oct 11, 2024 Song Liu <song@kernel.org> wrote:
> 
> Currently, fsnotify_open_perm() is called from security_file_open(). This
> is not right for CONFIG_SECURITY=n and CONFIG_FSNOTIFY=y case, as
> security_file_open() in this combination will be a no-op and not call
> fsnotify_open_perm(). Fix this by calling fsnotify_open_perm() directly.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
> PS: I didn't included a Fixes tag. This issue was probably introduced 15
> years ago in [1]. If we want to back port this to stable, we will need
> another version for older kernel because of [2].
> 
> [1] c4ec54b40d33 ("fsnotify: new fsnotify hooks and events types for access decisions")
> [2] 36e28c42187c ("fsnotify: split fsnotify_perm() into two hooks")
> ---
>  fs/open.c           | 4 ++++
>  security/security.c | 9 +--------
>  2 files changed, 5 insertions(+), 8 deletions(-)

This looks fine to me, if we can get an ACK from the VFS folks I can
merge this into the lsm/stable-6.12 tree and send it to Linus, or the
VFS folks can do it if they prefer (my ACK is below just in case).

As far as stable prior to v6.8 is concerned, once this hits Linus'
tree you can submit an adjusted backport for the older kernels to the
stable team.

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

