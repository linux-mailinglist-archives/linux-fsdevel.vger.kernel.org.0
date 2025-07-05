Return-Path: <linux-fsdevel+bounces-54002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 601EEAF9E50
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 06:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094291C81CB2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 04:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2191E9B3D;
	Sat,  5 Jul 2025 04:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="O1RMzUK2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E295B1D5146
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Jul 2025 04:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751691186; cv=none; b=eNuUtV/iOd7hmCHKdw4txNy83ylXT9e2oqF74w1fZXZZx4NXsc+kAdVr1IFGRjvIa++czov7H0Pm96wIzqKOBUV6mRBIW2EtAQ35kxZWPIW6WoCD5Tx9BhQ8rdSM53F0WlHhJ/SCSQIlPoWMAatXeGFt1uxBv0fq4Cjhu5XKug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751691186; c=relaxed/simple;
	bh=3e5b/mO0RFF+xErZlKYDIePmZimdtmDWBv42TSUuTl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnJhQAEqSrOghnB+8rwWjaJfEfx+y6a03elfx3bfQ81Kq/0pju16j06K5b1yK7rgNK5Byiy3GHoFNb16bpJJe0Q5piGGEwe40+nlgEUa9/89YUV6yk9sFSM2v3ltxR7XY5ruNo1i7Ao+4yQ+cRXXDQT7nSyREp+zJDDMqu/QlBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=O1RMzUK2; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a44e94f0b0so19878941cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 21:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1751691182; x=1752295982; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nc3YrIY3QcMH+4ceWY1WS45kEaxnZqfPpmURLY6Lsb0=;
        b=O1RMzUK2Ig1T32uzIu85G20MNs6XYP8IH8c+UspykHIWXGM86Agds0QFuVnqm4F1aF
         +Zk4fhwHCryrVZbfmfrkq+sk2de43iAzIIYfuxhfFadjxv87X5yelHpvvZUbhxcUUjGF
         o5XTX35hTv6S3tbUfdMNUe/OMr5Xa4mTwDNO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751691182; x=1752295982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nc3YrIY3QcMH+4ceWY1WS45kEaxnZqfPpmURLY6Lsb0=;
        b=n0kJl+pW9wqLGNzpeilPUY34NloPoOoA8IxpgkK2Yp8ZYzMkOde2wes1TOAttMs7FL
         7v9Ub2nX72kgt3pzaolATtZ8lpaaScerx6uP9Q1f73fPRt4oaq3oKccQKqpfJfP+zVjQ
         kR5xBOwbnSAbIqz6XFinZ1FmJ9e9qn4y19rw/GTxdKgRmkMWkzcd4LFdp8MwBT4pD3wu
         ZlZETfiuEKjUNpsTNShU60S6SUZg31vWF/cy14buD9uDBnYsEr054CN8Ztq0yMSxoWrR
         IOKV0P6d9YUSGRT1DEEVEtk7DjLVXIvkyNoYJnC+ieU1vj8eh32OLaJeZwyByzNdvsXi
         RvMA==
X-Forwarded-Encrypted: i=1; AJvYcCVs5xe0aFq/kt94DMf3uf8ZVBif2oCXzuOolSF2QPIZrKoFmWNur6j2rgYpt0VhDCVn8YlCF2ati+uxMWT0@vger.kernel.org
X-Gm-Message-State: AOJu0YyehZe7xeKvzbCmhfQCpnbMmDIgm52lvFcLVFH0dKjN6zxUH/bx
	OEHs/QO2MSadBqvBnTTqms+Md33xAOTjDBl+R5sRTfaKBtmHBIXoetdeLKK4UI+CwkO5BHmwfDZ
	dvA9+o2JqzXJM+RuHo0OG2xpykkJRgkIUeGyhPWxaCQ==
X-Gm-Gg: ASbGncsI6VM1+Tp20VWVA2dJtl7yLXUVnJIbd7czdOqQSXWnGTeIOTxlY8hgrKxDCEq
	WzZ+KDPyTzqI6iDgX4KzOVem81wkZfLHxvbjNrj0EFMqj0eFaPHcC0IxjK76S2jXCdn01up7X3g
	YZ7voaUhoykWYF1pzXlV1j/xrLFsJ7+2RkFf8+vJpCZg6Sy8xLMup4OARbjzpCMgNM5kjZBockU
	HkR
X-Google-Smtp-Source: AGHT+IGo7xWeU/MiO6AhQWLae44XLZkuClUnBuKkQsTpexDkpq0SryBcgywhHCvYw7VTwfxpPxyHFGop/r4Up5xD5Cs=
X-Received: by 2002:ac8:5dcf:0:b0:48c:c121:7e27 with SMTP id
 d75a77b69052e-4a9a6993a19mr16626481cf.50.1751691182456; Fri, 04 Jul 2025
 21:53:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704194414.GR1880847@ZenIV> <CAHk-=wgurLEukSdbUPk28rW=hsVGMxE4zDOCZ3xxY3ee3oGyoQ@mail.gmail.com>
 <20250704202337.GT1880847@ZenIV> <20250705000114.GU1880847@ZenIV>
In-Reply-To: <20250705000114.GU1880847@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 5 Jul 2025 06:52:51 +0200
X-Gm-Features: Ac12FXwRODFHbG0awa8PurHG5mv4JtDr_e0kDXxAcir9Rra-XMFT3zRNnnrlZac
Message-ID: <CAJfpegu8aidxbF7XwfkC02waYpGNHSu1v184UEa2M8CTwtSGjw@mail.gmail.com>
Subject: Re: [RFC] MNT_WRITE_HOLD mess
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Jul 2025 at 02:01, Al Viro <viro@zeniv.linux.org.uk> wrote:
>         * both vfs_create_mount() and clone_mnt() add mount to the tail
> of ->s_mounts.  Is there any reason why that would be better than adding
> to head?  I don't remember if that had been covered back in 2010/2011
> discussion of per-mount r/o patchset; quick search on lore hasn't turned
> up anything...  Miklos?

I don't see why it would matter.  And I tend to choose tail if it
doesn't matter.

Thanks,
Miklos

