Return-Path: <linux-fsdevel+bounces-77436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKSkGjn3lGkUJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:18:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E48151C3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F219A3024C9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475852BD030;
	Tue, 17 Feb 2026 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VQfYo7/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C102221FCF
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370291; cv=none; b=GMVc/fg0z+QypSHHey+Aijk3iv8Kr6VyMwDVyEMBB9UR5M7XSkZNr1krkHkDEa5KBHB73DswaavZyuS9t+Cq62DC1Zz7pS1ecXIobxWxPiiIQqRZz3EGnDAdhBEnn9/Ov/6tSjxF6ZjIjYQYvNB8JUP9RcBPVx6W1xJPpBouXxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370291; c=relaxed/simple;
	bh=IUiqjvFU1sk4CRCoaXLNqUeOK1Xpy7tX6UysD8+oBPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/P5wRKiKVN3JOm7hfqG/nIx9qx35BSirTgiCG+CZJ5KDJ/dJ68v6lZS7GL52TfJCJmq0ce+//BbxHkjI2qfLWNE7uWrK6noXntKkeSCx2y4An2U8faw9jxO8M+T3AHn0NZnWUzFeu+ghaaKsdQzgq6R2NtyMXITNN/GM0YrdGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VQfYo7/s; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8845cb580bso852028466b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 15:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771370288; x=1771975088; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cI2W1u/lZj2/rECvdEYlQ+UmBvId4Eq45MPeqIsmI9w=;
        b=VQfYo7/sB8uEgxYBRJW23mSd6avFsYH5BZ2Uf6yFi07Tl7KwV/S4N5YAXLokhIqN69
         BcXdlLULP1+p6W5cYEdT8b6+5oVcurg3WM3DdueXxfoBA/UEeimOSZd2VyY1zBNgyanR
         k3lUO4FTkTr6QFo1N76IOMjmHs/W537uKiVfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771370288; x=1771975088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cI2W1u/lZj2/rECvdEYlQ+UmBvId4Eq45MPeqIsmI9w=;
        b=vIv8yu1wCecvXeaCVOLwZA7gAtnn8Y04nQMhsbsuw5UlRpoYv+ijxEw/mSPxCR2Zxc
         zDh5oPYT+3IaOzy1fVAq5TrlyYSLKtPKdZi2SWlDizmmtWWhf4WlGaUWf+IXaHsKXby3
         kh447XWRCAK5HCA0eqZx/hfIxFrXd72DwR8gPz/atXLcgJNhlk+9XUGhkWsXUHtmh/UJ
         LNXn9gxMdO2rKwQK/+z26u4BYxcJhLR37X27KT6Tl2N4v+fySDtbH5WtFCog0dKM3N16
         2rUTRBMbIpoWTto00u696D0PBiIuzpuSD4OkWjCryhLDsMZ7dWH15W3I83JxClvcfpxj
         7zdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+LfPBq+900aQYYtfww+nA3Mx7US8Pu0abAfXNlo9Ck1QVGNGdZHNR66rYcekvu0/8f/TCSLeuE0JWAnx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1x439Caa2UoA65Xpi5Cz8lTt4bIJjK3EUPTMGPytpgRky0VeX
	vy45j51cc3YRpD5EFviOdieIcTVW1YHBsOijy4bxmcg6txPci7WUmvksoWOtvDv6za1UcqAQ5q5
	YJ94ZcXoa/w==
X-Gm-Gg: AZuq6aIK2kLvsFvs39VMtn3rY3ENb8i1rN3YgAdugBt+Vi+7KZ9ZEz5/e0wAi20zL+Y
	/Pht7tfzXxf51e1SvX3xmowAjlGErkx/7SC1BjSUQvh9g69X/1c/Xg9YSPSHgnEj+Q5GpPtt+6+
	3SR8dN2kt26NKnKxEF6gK3Z2gJHoBdu0gEkywwIusvh7xAP8tFAeDycuuS9BbUGdWRAY4W+DeMi
	CeB5B9RV/3qeb5kB1Su8QQnEHZSo8oEEnYlLFkAHDj6DFxVEPmHFYhSw4aKIpM2kwV5O5nDsfbK
	EJHm7iXF+L4qoK8qlx6+L3Ib3SGoZ3U8wBOL2cyvpWy2WcIDfeMJ/HkyIe+jlbBmO3dPLOWRcGe
	Q1Ds4u68isAKnix+5HtBmCKjCW80vmkM/r674kAU8g23SuIywISl7ixY0+WCdieYNqmyR57o8E+
	/gfGHPM5FVtm4MQeL/suKMPnXIYbGN5JwBpmbhe/Jgi8xD9uEH3700MKSWeDdWcWP3o3XYTXWS
X-Received: by 2002:a17:907:9492:b0:b88:227e:3876 with SMTP id a640c23a62f3a-b8fc3b5ac06mr797262166b.24.1771370288468;
        Tue, 17 Feb 2026 15:18:08 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fcb0ab637sm368363066b.39.2026.02.17.15.18.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 15:18:08 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8876d1a39bso530814766b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 15:18:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW36R/5NBfc9bomrKY3N+bzZSQ06kWf6XPQYc2fH+hu4uPSvFpv7Xq3u2AjY/nyqcUgndpyRsqrb5vKchWF@vger.kernel.org
X-Received: by 2002:a17:907:7fa4:b0:b88:241e:693c with SMTP id
 a640c23a62f3a-b8fc3c7fa23mr844554466b.31.1771370287820; Tue, 17 Feb 2026
 15:18:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org> <20260217-work-pidfs-autoreap-v3-2-33a403c20111@kernel.org>
In-Reply-To: <20260217-work-pidfs-autoreap-v3-2-33a403c20111@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Feb 2026 15:17:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj80zwxy=5jp5SAi64cqCZgRjY1cRokVuDPd9_t3XMvUw@mail.gmail.com>
X-Gm-Features: AaiRm52dznNQbLA6KtgNYG-mDHW0wPftuiLvoCz4fZKrM8M1aXh9Yri2jK5MB0c
Message-ID: <CAHk-=wj80zwxy=5jp5SAi64cqCZgRjY1cRokVuDPd9_t3XMvUw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/4] pidfd: add CLONE_PIDFD_AUTOKILL
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77436-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5E48151C3F
X-Rspamd-Action: no action

On Tue, 17 Feb 2026 at 14:36, Christian Brauner <brauner@kernel.org> wrote:
>
> Add a new clone3() flag CLONE_PIDFD_AUTOKILL that ties a child's
> lifetime to the pidfd returned from clone3(). When the last reference to
> the struct file created by clone3() is closed the kernel sends SIGKILL
> to the child.

Did I read this right? You can now basically kill suid binaries that
you started but don't have rights to kill any other way.

If I'm right, this is completely broken. Please explain.

              Linus

