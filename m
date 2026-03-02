Return-Path: <linux-fsdevel+bounces-78890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAa6DO2JpWmWDQYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:00:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A941D956F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09965308942A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 12:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126553AE6E9;
	Mon,  2 Mar 2026 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="J5bGpV24"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E412C11C6
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455925; cv=pass; b=KXiVRQ/bitAbKihXwAa0NV0WH0pSWHajiINEGjB3RfGhEEK6077F7rC3u8SAALTviL5uH9V8yHbJvzAeRkW7Gxq8WpoklzCiAA1PPCk2elXRi58g7qB0Jm7P3KHnlTogrj4fqTXUGFAL7LbJa8JG0YaiJ5PvwSt9Zwf1VlwCzmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455925; c=relaxed/simple;
	bh=IBb8h3H4mC7JvfxAGxqNwalFIOgvy4nMMnYn8mNtouU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SX3h33HEIjPKUi3sOJrTY7AycNhaBWb1MGmlP8zipuXKgNkj6fAA/7LulnWk5GNPoc+bZeMhFPP6LCuE8SkCqvDdLCTRlPT8CbdXRMbs0ioiovT9J3CkTEoKvJrday/pHoX5WloiVI4W8z/X3exayzNFyrm7I0mbSKs20JNe8JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=J5bGpV24; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899f79df682so10917936d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 04:52:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772455923; cv=none;
        d=google.com; s=arc-20240605;
        b=fLDeSfVQD/PWvm9xMd/tp1EL5Hno66/+yp7qnZ15ZWJGQhJqaoW64hYqccnxFAVHgd
         KAQz1OrynT6qaLE8Lk94CDs/bT2Y7FGDi/jkIw1FZi97pXFmbsipGlzyOoas4AD+lE0w
         loELD3C9YJtgyNvxZGVAbu0MpLfLX2OP9GjYZfXz03aQcDRImNnqiTZKUbTKcbyEqTTq
         mXtZ1f2bjTTf/icHDVeQ71NcSKWN3N7qc+BaKK1igzmAcJ4errEpl9+9UhI7gX5ix7e9
         g6Gwj74Yz+Nc93ORUUpD78nyqV+TTVqo0ALsVcYPCbmXw1fziag9y8fT3R7eSM64I+/z
         5neQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IBb8h3H4mC7JvfxAGxqNwalFIOgvy4nMMnYn8mNtouU=;
        fh=E4IDKGZmfKFczg/ARax7wWwbE7y3Td1r1OZ6LSWqiwc=;
        b=JHwKdl4lT83Px1pEZy2yAJn4uUdy7V/RbVpLXeqtjCiJT3HFrG/L9NFbjqmmW2f1/v
         GiDVu4JHNwhEuuxjqmHxAXu6SEwYUZQOblXZnwYU3NCdmPYtGg7dh0Cadjp1BqggSD/1
         1S+FmHyYhOYYQ9PgAKIkBvxUJdcqVbRuKJTWVEd4UMy7ZjJ1IZCbxyg3rN3NjGmH9a1D
         npFKYNoTgDUhRickbWqdmLrN+V7PcAXATe4P4K8t1kYYptDXe91E2FE/LSH0huTmsECS
         /lbQKGOKRj3rt2EuwcCiuLN9EAVMJ6X+GxUmxfCSkqybP/ajdJ1twIXWk4nV93mUFybo
         CD9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772455923; x=1773060723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IBb8h3H4mC7JvfxAGxqNwalFIOgvy4nMMnYn8mNtouU=;
        b=J5bGpV24U6r+ap+XL+LO6Z+Rygw3KA1y4RUamxMuGtaex70cWRrIkTjwPWgOdduTlX
         5fq9bI7/e/Y0vQ1wBvt69TlTFVo8Do3TEQ9VMtvekHGxLwfJqeJ3DAS67eKmxDPTq+8k
         y6oSPwZLgnUTRB3yURCf1QuV7rGg0J/OuEDNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772455923; x=1773060723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBb8h3H4mC7JvfxAGxqNwalFIOgvy4nMMnYn8mNtouU=;
        b=WiFkppSAIwlyaxVb98w9SmSq3LgYUidrioGwESjCX8DujNnutVAQwwFPce66jedMSP
         Kg6SpeEP8BDLgDzUOCpI3l7UZ5fluz0dyD+KhB996IfLjgYNJ259mM2FB4JBlc6Vi/+g
         I1zPH/p2zWLDfKOT+8D+u3YdIc0pVDlhNDXE1DJ8DLC+l+5pUPxFtwyLEcifHEdn0NsK
         XQiDy/Hif8qo8hy0zXJLm8ND5zWswPyAD4H+NCSo6KfXBYUuhxur4rqZbAPe1EMdDNhm
         pfLeNx3YuTwSyvoCBehF6nYoFbaUl1Qdp9pZBmZgSRqt6sw22Iiz9RiwDVskjfQoUsl7
         m8VA==
X-Gm-Message-State: AOJu0YyzlwygNCuEbCkkyj2xXnSw7nhgT89nrT5495q2FUswvkKAeJJO
	KNTM8T8iXuPrboixdEOFBexnsmOYEphpQ1utPbU92W1RFDSJQgRRY45FH1rIa3Z3BDiLOGKo49T
	PD6+hrG4YXxOKU9PnKBM08xVxY38lJ8KYlN7V7w219Q==
X-Gm-Gg: ATEYQzzrL+1J/0QIQSFOYULAY8FMwfLAEiKLU3N0fK9Np2PQfgpYQuMzBxGXivrgS4d
	1+15vK7tyOVsD96R9CyllyrP42jR3jLnbFPAAkGUnC87HWRjnlcDCny5gAa+MclXMRmzQGTDQEv
	WmAxO5h3gNEJ76fExmQlP6s7mSlp1aKr25wacEUzSACozLaFPwigwZ7E0dAxZatLsXP4R+hSzwk
	GQ+4wS3+atxajXURlsYwQuZTlfj6kYPfSGXdOijQPTfm1qAnJvVne2m27LWCnHVMnA09GWx9OSZ
	r0iuzQIDyQ==
X-Received: by 2002:ac8:5801:0:b0:502:9b85:a609 with SMTP id
 d75a77b69052e-507528d6a97mr146117621cf.30.1772455923205; Mon, 02 Mar 2026
 04:52:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111-fuse_try_move_folio-check-large-folio-v1-1-04921ecf466f@ddn.com>
In-Reply-To: <20260111-fuse_try_move_folio-check-large-folio-v1-1-04921ecf466f@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 2 Mar 2026 13:51:52 +0100
X-Gm-Features: AaiRm53cf4qEObJN3O6WPl1Q0g2YyJCuNaf5Tt_XEdcgghEoaed5e10RMcoumaE
Message-ID: <CAJfpegutV_jsLAMo8Jnr=GYsYg0b_A9Z1MkgeMZYua0r-XnY-A@mail.gmail.com>
Subject: Re: [PATCH] fuse: Check for large folio with SPLICE_F_MOVE
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78890-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szeredi.hu:dkim,ddn.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 79A941D956F
X-Rspamd-Action: no action

On Sun, 11 Jan 2026 at 12:48, Bernd Schubert <bschubert@ddn.com> wrote:
>
> xfstest generic/074 and generic/075 complain result in kernel
> warning messages / page dumps.
> This is easily reproducible (on 6.19) with
> CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_ALWAYS=y
> CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_ALWAYS=y
>
> This just adds a test for large folios fuse_try_move_folio
> with the same page copy fallback, but to avoid the warnings
> from fuse_check_folio().
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>

Applied, thanks.

Miklos

