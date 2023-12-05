Return-Path: <linux-fsdevel+bounces-4891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC662805D71
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 19:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D461C20400
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 18:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8184A6A012
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8bjdApn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B667188;
	Tue,  5 Dec 2023 09:51:30 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5d95a3562faso18787597b3.2;
        Tue, 05 Dec 2023 09:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701798690; x=1702403490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LXGGLKq7Z8pmpqdiDr0S+r8xceEAR8zgb0x49rS3sI=;
        b=R8bjdApnww8WC3o+WSiy8NhKdZDvh2RQ6IIXltqPCit4tt5edUruWnTnKbKw8JMgoW
         AaslWx1XjedWqsGL8+ol6gyZCIGB4IfTo6BVdsFf0xr1CffM1f+JowJuLBEu7RiYLs5r
         eSEt1tQHR4FGE0hIKkPbW+ZmlLqgDjZHbnA0jQUSd1g9rUyaxJO/WDeUclxAnxyOsIyh
         efyXUea0Aml+iBi1cY2mdavZb2Sq5s21nhAmvC/uTKR0r9GubJZFZvU5Rpm2N197r7IJ
         hZuBqi6yElLl/P4Km6wzcUz4VfBhPTqLUyFGrxFfFeAe6RWbcvzNpEtdLRi2MW5jeyGK
         0KiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701798690; x=1702403490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LXGGLKq7Z8pmpqdiDr0S+r8xceEAR8zgb0x49rS3sI=;
        b=FK1zrswlE/RWF1BhhEvKb3r6PSSP1HYdSDkjqJaUOSEjaC/yOgL+kO2n42JDXyUHfd
         8IJqSZutN9w5Qe4mCA5PaaBJoSuHuep8+LGDxZZZmpKeT8PdgncpvyY7UYbO5fnJtj/g
         OIHmGIK1YFdLkL+SxyXc6U8t8yUh45m/46Kk/SkYRRhA16jWxnjztVpkaYog4l08Arwb
         dfJ3XWkUD4JHOSZqe8aAqpxgSDWdmi1vv7YM4KVNaXuTfhAgituj002T78/HQsKC1P9l
         mCIQACXpqXTY2OLm8VyJu/FlMtYb56/QVJPpksyS/RlrWHiIzjR1zSJWdL/jCk1jp3j6
         xoKg==
X-Gm-Message-State: AOJu0YzQgXEYeE+943yRIWxieijHu92bEs8DZd3CHPbh+QNUYpvqmeSJ
	Pxk323pgzB6TDg8aNu4F+wE=
X-Google-Smtp-Source: AGHT+IFdOwamQNuxLTN6hj36+e1/fLL+aOtl+lmhjkUdffr8tXVDulQ2jRf06EAqBbOEAEkQbeQRbQ==
X-Received: by 2002:a81:48cf:0:b0:5a8:204c:5c9b with SMTP id v198-20020a8148cf000000b005a8204c5c9bmr5089876ywa.18.1701798689227;
        Tue, 05 Dec 2023 09:51:29 -0800 (PST)
Received: from firmament.. ([89.187.171.244])
        by smtp.gmail.com with ESMTPSA id o5-20020a0de505000000b0059a34cfa2a5sm4327132ywe.67.2023.12.05.09.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 09:51:29 -0800 (PST)
From: Matthew House <mattlloydhouse@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: libc-alpha@sourceware.org,
	linux-man <linux-man@vger.kernel.org>,
	Alejandro Colomar <alx@kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	Florian Weimer <fweimer@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Karel Zak <kzak@redhat.com>,
	Ian Kent <raven@themaw.net>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Amir Goldstein <amir73il@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] proposed libc interface and man page for listmount
Date: Tue,  5 Dec 2023 12:51:10 -0500
Message-ID: <20231205175117.686780-1-mattlloydhouse@gmail.com>
In-Reply-To: <CAJfpeguMViqawKfJtM7_M9=m+6WsTcPfa_18t_rM9iuMG096RA@mail.gmail.com>
References: <CAJfpeguMViqawKfJtM7_M9=m+6WsTcPfa_18t_rM9iuMG096RA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 11:28 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> Attaching the proposed man page for listing mounts (based on the new
> listmount() syscall).
>
> The raw interface is:
>
>        syscall(__NR_listmount, const struct mnt_id_req __user *, req,
>                   u64 __user *, buf, size_t, bufsize, unsigned int, flags=
);
>
> The proposed libc API is.
>
>        struct listmount *listmount_start(uint64_t mnt_id, unsigned int fl=
ags);
>        uint64_t listmount_next(struct listmount *lm);
>        void listmount_end(struct listmount *lm);
>
> I'm on the opinion that no wrapper is needed for the raw syscall, just
> like there isn't one for getdents(2).
>
> Comments?

One use case I've been thinking of involves inspecting the mount list
between syscall(__NR_clone3) and _exit(), so it has to be async-signal-
safe. It would be nice if there were a libc wrapper that accepted a user-
provided buffer and was async-signal-safe, so that I wouldn't have to add
yet another syscall wrapper and redefine the kernel types just for this
use case. (I can't trust the libc not to make its own funny versions of the
types' layouts for its own ends.)

Thank you,
Matthew House

