Return-Path: <linux-fsdevel+bounces-70331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D975C9716C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 12:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0DBB34160C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 11:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F9F2D0603;
	Mon,  1 Dec 2025 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvCOL6XV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF132C3769
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764589146; cv=none; b=JQpzcMLIt6QxkcgkgYozmVQ94z8/bvppETqaO3GH8rIUv6ZNe5R6LrirbdKSbD4cD4gka2puMmNcsn0q79hSe+zQes9tItg22qzCTbdHOLMxrjooEK8arL5f19OzkfA3/9FxVkMfoYApESX4jhQ/ZIgrG4Yi0+SjxpuAiwkqXkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764589146; c=relaxed/simple;
	bh=vc0BpzEY2wxfDjNgbdfUNdowc1vqv/i2eRZHoA0F/+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qq+jqkR3dN/7xMfc3G7mPQZAaJYrFuQT45Zui6OoU/5EjlSKfhun7eLOlLBuKhZFs7EAl70R8Y3XtKJukFVD/wZYCIwJAYihZEGo4JKmOHZTZCTRR0DGnM0ixZrCKHTRTlaPVODlvL5dDUB/BgqL8vcEerjmvfbAsd0xpQYTDpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvCOL6XV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D83C2BCAF
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 11:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764589145;
	bh=vc0BpzEY2wxfDjNgbdfUNdowc1vqv/i2eRZHoA0F/+A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PvCOL6XVYQa8ZwCQyH9hc1Ha0fiUWE5wKQ6LYSrD1ee2F2qWVWrIBXvJ776k2bn4w
	 AnbLp+EXfJbyt/7TeCD7NeF59bPv6SCMLRcwqhjWls8V3lJdBhyvp8C9Fd1eaSTutX
	 tpuBRbsK4XY+4iJc41uB316MJ3liiLerUC8R3/g1ei3lf98HKU6q2ZlfVBfs7wGodc
	 nvy48oiYYeEpl1Dvn4v5Iy7O7uacBgXy8Na4THqrjU+CvKEyJ0IuL7rjIFSYSnc5j1
	 ojsxtJnaWciEl+ttlAN6CqM6S0HShF/GoWATf6xwinPkEIrPdegktD+gpcaOUuvKHX
	 obOIE6fBntMOw==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so7229200a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 03:39:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJh9QRnzmbVrAzU5UKKxRf9BfRGK3Mu4uU4vFHHN/0FMwl4V8mwtEhtvO5aC9ZKKzRTErN4gkj54c7NvGQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyQr4jCu+HahdyCJlDDkHFMsVi5p6bPpNHBwFtmNmAnAeL3Df61
	uWE3rulMbP+PCT69C6sMdHjHz6BeCwisYCnIQ8lu02oqXyzEGlNVhLjmhyU831Ah3zdHILJnkD/
	ENcL4OFznqt/QqGeUqJs89sr5G0IE4Jw=
X-Google-Smtp-Source: AGHT+IHVQXNLzT+88uNd++aW0+6GTM2fuUhYWtsatpZih4h4sp2cOOV7XPYeCaTbqBmxuUJP5cNRysOJyNSpofCDX+E=
X-Received: by 2002:a05:6402:2745:b0:641:5502:c8e0 with SMTP id
 4fb4d7f45d1cf-64554675483mr35236537a12.20.1764589144269; Mon, 01 Dec 2025
 03:39:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org> <20251127045944.26009-8-linkinjeon@kernel.org>
 <aS1Fdci9qsw_kDay@infradead.org>
In-Reply-To: <aS1Fdci9qsw_kDay@infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 1 Dec 2025 20:38:51 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8Mw0j6CQ3V4=8q_s4roMUoSingGUbcJvo_Twa9Ysv3XQ@mail.gmail.com>
X-Gm-Features: AWmQ_blvyxhnuOHdqrIILMH3k7S5NVz49xRA417b2PidIIeLvCKrsE25UKz_XL0
Message-ID: <CAKYAXd8Mw0j6CQ3V4=8q_s4roMUoSingGUbcJvo_Twa9Ysv3XQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] ntfsplus: add attrib operatrions
To: Christoph Hellwig <hch@infradead.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com, 
	Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 4:36=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> s/operatrions/operations/
Okay, I will fix it in the next version.
Thanks!
>

