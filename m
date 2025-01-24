Return-Path: <linux-fsdevel+bounces-40086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE22A1BDA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 21:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E6EE7A4BE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 20:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51C21DC19F;
	Fri, 24 Jan 2025 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WreCpMpV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B861DB933
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737751914; cv=none; b=a5AxEZt/G4+2ByPn6SdgQxEj6R0DZ0VOSRM7h0GRRyXIbsSwuP7+iSXeLeIEjYi6C7o/wglSAjBVazb4L9Or0liE7TP4xuzhuXSUpCAvUN6xzIu+lPuhmtkuWdhx3Iigng/A76CL21HNFKsjPSs8wUYDDGVjGSsQwhtoAAcKxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737751914; c=relaxed/simple;
	bh=1Wy0+AMl5lTH+SHOelTuWFzEXL+eHACl5fGCtsxftlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXeRmK/V2RvSOg/Z4d1Rg/IRaIeWU8QaZDwz1LuqjTVut7zfPIYXixxcGNzu8lZFr0J/oJxB3L5OG6C8FviFXLSJN51/tV1OISckkrWGHVVBzCa8ATgg0jqD4OX3oQCaBOOQbE3lx9vveUoWiXE7LvF7wwCdWDkwbA//QG3i1ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WreCpMpV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737751911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnDKRYStVFF2O5PoN6RSjUIWL60O6LRmi/up6YGopUY=;
	b=WreCpMpVOEeAhc/A/OHjvQ0ZO083Tu2KT7vpIjL9rL4/ts9u8kQlXETiXWXEkxKaDw+qh1
	YyLNGTqZCW4oMPjpgUOtV13Ysbn7Ry3Dg4r5vzbBcHbRj4WGBrHSlgdkSxw2C58aWTtoVW
	nBNOr1T08XSLy08H+jTmFF0EDqR1JiM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-Jr0aHEf4MkmWCpXxQyyWGQ-1; Fri, 24 Jan 2025 15:51:50 -0500
X-MC-Unique: Jr0aHEf4MkmWCpXxQyyWGQ-1
X-Mimecast-MFC-AGG-ID: Jr0aHEf4MkmWCpXxQyyWGQ
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b9f0bc7123so407121485a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 12:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737751909; x=1738356709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnDKRYStVFF2O5PoN6RSjUIWL60O6LRmi/up6YGopUY=;
        b=KDgDo5Kf4qvpabu00BLkWsEzf3R6QVIThB1ZAVWmm9QQsrZtJfkWZ9tNPpYC0pJcuK
         npQAHP32/ZnrHozkmHb7wmStq4ey6xpDXWCuOXTD2MqKv2KI8pPo9TQZLI48iS4zk/TF
         MtXuy6DmEO8n4Eo6oVlICqCBSQlaekRJqXLqutcx/SWHDJOcvfU4KY6oiLzGqH8CrMlL
         us4VZ//rd6TgiJfgESF/qPb2WzrsXeBKXXexqcdncEJKs7+nAJ1+Tf80DuIlUkvAhlie
         E0psWUoin2P2RhpPc+6bz/xgue5GoTCZDUTZ3B1iUuQequMnYICE85CTISuYOX5FfUZj
         14uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXram7FM/bHE1K6ESWpAyj7Zq5n3Wg8PZ/A+4QcGykItdRoKqyZ6QaMkwjl/ev4x7jAqQnu2rma9XKi1QbP@vger.kernel.org
X-Gm-Message-State: AOJu0YyFRyTPm3trijkdV3DqM/Fr0aJOI2JWUlL7+gft0VfLngXAazWn
	/nzLYo4iCPGBxhsNByZjTZ6WWzwSntyMZ2Zf9YrpRfp93zUZh2fyupVR5QKlpl+mSWHlGZans2R
	OfQJx8D7qXUW1AQilCbsPgwiReBhr33KZ6ephqe88jNuOu3q0fItXlwW4g/UtnrTP28pgpOPYSm
	2NpFCWTA85BYAbQ4V/mCpU+CV9Cm4/SwdZllTuLw==
X-Gm-Gg: ASbGncuRBZl/AF0eHPQVlnBV1uxO+oK2UoZX+Mo1UZIr3epVQmKyZXaIFhVrbQImPa0
	lhigiqOjUHU3QEWVLf98b0xwZE2BY6iGtt7OlBautqkZsKekdr5I=
X-Received: by 2002:a05:620a:1a07:b0:7b6:d97a:2608 with SMTP id af79cd13be357-7be6321c005mr4741129585a.17.1737751909684;
        Fri, 24 Jan 2025 12:51:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlQYEC/ET/acRO8eOALZe6FdUxkpevtt90ZWb5S2lfnmgT90M1F+3wFQEHr7lQn2mMhYC2pofzS2C7YpkTrUI=
X-Received: by 2002:a05:620a:1a07:b0:7b6:d97a:2608 with SMTP id
 af79cd13be357-7be6321c005mr4741127885a.17.1737751909460; Fri, 24 Jan 2025
 12:51:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124194623.19699-1-slava@dubeyko.com>
In-Reply-To: <20250124194623.19699-1-slava@dubeyko.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Fri, 24 Jan 2025 15:51:23 -0500
X-Gm-Features: AWEUYZmcrCmqkBW_qx0NobEAPNVA_lVJbUALU-0J_3qCaT4SMmzm5ZQxDCUOqDc
Message-ID: <CA+2bHPbkATtMp_BgX=ySuPZkMSqd5EwjoRdsAsoOOxuoN3wzTw@mail.gmail.com>
Subject: Re: [PATCH] ceph: exchange hardcoded value on NAME_MAX
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 2:46=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> Initially, ceph_fs_debugfs_init() had temporary
> name buffer with hardcoded length of 80 symbols.
> Then, it was hardcoded again for 100 symbols.
> Finally, it makes sense to exchange hardcoded
> value on properly defined constant and 255 symbols
> should be enough for any name case.
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> ---
>  fs/ceph/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index fdf9dc15eafa..fdd404fc8112 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -412,7 +412,7 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *f=
sc)
>
>  void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
>  {
> -       char name[100];
> +       char name[NAME_MAX];
>
>         doutc(fsc->client, "begin\n");
>         fsc->debugfs_congestion_kb =3D
> --
> 2.48.0
>
>

Reviewed-by: Patrick Donnelly <pdonnell@ibm.com>

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


