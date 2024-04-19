Return-Path: <linux-fsdevel+bounces-17294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 376198AB056
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 16:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B50F9B26403
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77093131189;
	Fri, 19 Apr 2024 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWKK7rbt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4E12E1C4
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535597; cv=none; b=rSjNCRXB0SYKfikZ+zk77/StP6Wrrt4uliFnsX42z/LcHOBfas4oao0+Oxx5T47r5rbJt1fXuHKflIGrYTEWFj+pZvwbc3iQkVp8/bijy/IqMxVgGY8al6byCWNS5Lne7QW9xkn7ubh/VjS38YplSzmg/E25wzsTrKBj0D7AGXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535597; c=relaxed/simple;
	bh=fZ1XlMMUpy10Gwas/CKc6QVK5m8lEX+IdBFYOy1ekGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IHAImGUWuWoRAzZ6CS+dK4qfB0Ql1zCObNFYUD9D+M3uMUXvzl/2swkdAnRMl9tK3qh4/2OgjDuDvIakDLE2pLv1HPB3/9LVq/Sp1auZORbd1TM9cKRtww4rhK9OsuuP6CF71LTzIoaoZIHjzCICFuRGc7hd+LrNQPbiZKGnB3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWKK7rbt; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-56bf2d59fceso1666978a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 07:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713535595; x=1714140395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDP9lixGtE5tEgwyR0XACy/HYxzizAJIPGzf/ZO8AOI=;
        b=VWKK7rbt7fQe6DNUYBpS9K+X2McHutVfC4Zzy70KXblcvbkxEjDD634mezMj+yesog
         pn6n6oGEGiIURAYJczhxI4m+WjrzXeVspurpCgt1NhpG7WLdlnEIs7AfpGg/FMBID7m2
         3J6h+wuZYqo2Zbhk57q4uRikWkwPv1xB094tK9gO/dQMPQTZoIMHCp0HVWQaRDmAwJNP
         Wqp07QYQTcu2HeUj+gbI1orLVvgOqdAh8WrEzzDzPhufRgnSAuLjSH0S42E+YRH68i94
         6mkg5pRXhBQOyZjhRtOiQW4bFU6YEkeqo42cqrZrwS/sNLafsC98s3uyoE4waw6Xm/rP
         cULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535595; x=1714140395;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DDP9lixGtE5tEgwyR0XACy/HYxzizAJIPGzf/ZO8AOI=;
        b=wM/feUT3K+Eh6Vdup+wzpEjsa9Mjs+1aD4hzWoCPA1KgdLlQRN3IPBfKaI7ZVs4zQk
         7ocCalqCWz3G+gN234ghL6X8pBJQuv7yKHvyn2yXEa6kBE0tB55UpC0CTzb4oRT66kyT
         C4+vIpFF50ow6Ky+Kl1wBPJ3/8j0+kqmBLdSOUVvBer/opgWLpP/hUXWw1J/f/pHYjCP
         ATZCNNdvOE6zbTSrq+NRAir+zn1zdPQ0X6hbDzRFAimoGDDLpmQBGl9uxyTBMLMScljw
         X2XkMHRy3qi2YAkoGlol0dAFk/cEWZulHxy/4rKdidiBvQz36uByvgmhlb8wm6KuB60c
         /3fg==
X-Forwarded-Encrypted: i=1; AJvYcCVvKQHcJwte/IxD5uKrPHro0p4hMtogPZYiApJAol9LZ2tbCthfrAoMInjbE+fK5adZ8TsOj6hdWkCRfqlCV+2QmCvyFftVMmn0zRWUDA==
X-Gm-Message-State: AOJu0Yw8ajOoOIzIoWp5G5TJnP9XEKGk+npT2H7zy/cawhI1UY8J6Vv3
	Ap8NlLhS0eknGDtliu9AW8NOxOt/7PVCiwu0Jkhje02/4luFpReG1UZWAFrC7w/lo2nOljXmu9A
	zPA==
X-Google-Smtp-Source: AGHT+IF3bk2/TSR5machUXRDV7nlSBsyqT6EzRnkyazFWlLiXKdBdw1iKyaKa2d9UlgLQZek2sRUa/XOCtw=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:4581:b0:571:c126:57e3 with SMTP id
 ig1-20020a056402458100b00571c12657e3mr2676edb.5.1713535594615; Fri, 19 Apr
 2024 07:06:34 -0700 (PDT)
Date: Fri, 19 Apr 2024 16:06:32 +0200
In-Reply-To: <20240418.haet6ahfieH2@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com> <20240405214040.101396-4-gnoack@google.com>
 <20240418.haet6ahfieH2@digikod.net>
Message-ID: <ZiJ6aNlF3PTJWKCH@google.com>
Subject: Re: [PATCH v14 03/12] selftests/landlock: Test IOCTL support
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 10:44:00PM -0700, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Apr 05, 2024 at 09:40:31PM +0000, G=C3=BCnther Noack wrote:
> > +/* Invokes the FS_IOC_GETFLAGS IOCTL and returns its errno or 0. */
> > +static int test_fs_ioc_getflags_ioctl(int fd)
> > +{
> > +	uint32_t flags;
> > +
> > +	if (ioctl(fd, FS_IOC_GETFLAGS, &flags) < 0)
> > +		return errno;
> > +	return 0;
> > +}
>=20
> test_fs_ioc_getflags_ioctl() should be moved to the next patch where it
> is used.

Thanks, done.

