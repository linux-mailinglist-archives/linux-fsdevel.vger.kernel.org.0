Return-Path: <linux-fsdevel+bounces-35060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F369D0927
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 07:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45CF4B21A04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 06:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7BA143759;
	Mon, 18 Nov 2024 06:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3HINUEj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A58DDC5;
	Mon, 18 Nov 2024 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909654; cv=none; b=XlxBLAaZGpCAojq16nDO73YkE4Md4zdDZCEb3cmypzHoio9wnLCAU3yXZKZTuRW/PWKsRFXJ1yoUPacAL6qfe/MglxaxE+rvbmpelscUcajrJyjGuAXmhqacYhWwmOA/puhwvbmgLQtk2w2qKnH1UY+XJb1A9qCzYN/9+bgTO2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909654; c=relaxed/simple;
	bh=sgFGmAJSWz62h5J0gaOs0tTJ0+JIkMwQW8wgYGPyNjw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=ZBdUuTe2RObH9vQHS2/z+HeghRBCm9zoQMAIy9dCrg028ByqZVd/YM6gbfmJPZIKYW0QxFzRhrQ9XkRdL3MD4BHfv/4qsx9Zd91K1pStygoQHkxqA9J1Hc2fNR0hUC0SRuE1AE+n0lPVb5wQN/xutxdUCup0pB6VU/YjZLB6Zbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3HINUEj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21210fe8775so5314035ad.1;
        Sun, 17 Nov 2024 22:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731909652; x=1732514452; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kO+QtFpKfgzNuqO1kZp/2nPap7iCfAUCSQud9ZT+/+Q=;
        b=k3HINUEjcyuCyACMEeizV1B5Dj86tZQqBhZ2PXX4ZrTbGKvNAqse7ZbZJD0PfY4eRS
         wLG1DBYo2FzFZ6FeA8bgJ5dXP0PoUufKkkJQU8jGCVbik29gEJFGk0o21ffD8wPXyfEW
         yjSGsQiU59+1ZJ/QHLT4p+kQQsWnHk6WV9zU2cL1yQZkYdlqmNTm21Fjx3pIrxOg0LAe
         D8wxIYepF4YMusf6ByyRH4uXRyqTiPN9HfXExchu8gD+mVUHler8ppmvwlBlkbHmUFwb
         9SyUiB0l0RPoCkdgnYHS4E2uDnDAGH9xdqPJBFXrYJG8ZA0H9b6Top4vHwnzPNmO9PXk
         kWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731909652; x=1732514452;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kO+QtFpKfgzNuqO1kZp/2nPap7iCfAUCSQud9ZT+/+Q=;
        b=xJACQ1pPD7+1fk8eCCKGnQScFV3iFvtFR3uMXIPochwCBkgeitM3hd5VteF4t4qAPA
         4lu1l8EJl90R6CWTkqX50+oX5y0pipliYAdV3U6/WhRHAEf6e8DR+e9LI2U2/8ZobMOM
         TI9P6FQxyrw2CaYDIG7BskFJoGbSsA8um6RGOP1T8aQVhFOB9SYyb2QVj4Wn2fUIzJrD
         DKr8vHFiN4qDCvGnNQu0UAzqVyPPwu7jQU2nEcvxwZ4CCZt09PksOTV2ItdLk1t7TNk8
         JOz41Bkv/gPrKxOhZ+Mjd/fDe4Ib91K+rg5Wzdsjw2FkCevtHAFch4imNtg0eFT+Yzgz
         wV1g==
X-Forwarded-Encrypted: i=1; AJvYcCWSW6rGdsntcVO1udcOBEbSTxk94hpgfQu9pkx7NTYglaQh5jtz3VbHPVSvCcVX2h3S3GjYqDyp@vger.kernel.org, AJvYcCXnKkgXJPvdk6opIn1c/rTZNqwIzXy47OKQUCHkre3oC1hlL/K9yfYMbQcL5PrYyH2my5Tp0H/BJV3X3ixd@vger.kernel.org, AJvYcCXyPH8nBow3B8ZHDTlQr/JLPZMuJ3NsAYQ4hnE9FYbCsheNireN1B3wAjiZBdeYUG9o9bKBljgn9eo0ymgO@vger.kernel.org
X-Gm-Message-State: AOJu0YyVUoih+UjHMKS7WC4HV+QDd2uR7+T9wKKlWUFLhTohZqCxyEG0
	bGUEHOW90zgBENqqrngeH4V0ZaaiOp2XqDupykQrtKMEPWZ9Hh4Y21vVMwwK
X-Google-Smtp-Source: AGHT+IFdxyTPCM6q1QU17AqfiduUvqhQ1jdXop17N8bmnqw3ZxHsAmLAuld0aAwN/RD4QYOI9Rf7Tg==
X-Received: by 2002:a17:902:ce0e:b0:20b:a73b:3f5 with SMTP id d9443c01a7336-211d06f619cmr172400875ad.14.1731909651862;
        Sun, 17 Nov 2024 22:00:51 -0800 (PST)
Received: from smtpclient.apple ([2001:e60:a40b:abbe:19cc:3a68:771c:24a1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ec7b9csm49435665ad.73.2024.11.17.22.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 22:00:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Jeongjun Park <aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] fs: prevent data-race due to missing inode_lock when calling vfs_getattr
Date: Mon, 18 Nov 2024 15:00:39 +0900
Message-Id: <E79FF080-A233-42F6-80EB-543384A0C3AC@gmail.com>
References: <20241117165540.GF3387508@ZenIV>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20241117165540.GF3387508@ZenIV>
To: Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: iPhone Mail (21G93)


Hello,

> Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> =EF=BB=BFOn Mon, Nov 18, 2024 at 01:37:19AM +0900, Jeongjun Park wrote:
>> Many filesystems lock inodes before calling vfs_getattr, so there is no
>> data-race for inodes. However, some functions in fs/stat.c that call
>> vfs_getattr do not lock inodes, so the data-race occurs.
>>=20
>> Therefore, we need to apply a patch to remove the long-standing data-race=

>> for inodes in some functions that do not lock inodes.
>=20
> Why do we care?  Slapping even a shared lock on a _very_ hot path, with
> possible considerable latency, would need more than "theoretically it's
> a data race".

All the functions that added lock in this patch are called only via syscall,=

so in most cases there will be no noticeable performance issue. And
this data-race is not a problem that only occurs in theory. It is
a bug that syzbot has been reporting for years. Many file systems that
exist in the kernel lock inode_lock before calling vfs_getattr, so
data-race does not occur, but only fs/stat.c has had a data-race
for years. This alone shows that adding inode_lock to some
functions is a good way to solve the problem without much=20
performance degradation.

Regards,

Jeongjun Park=

