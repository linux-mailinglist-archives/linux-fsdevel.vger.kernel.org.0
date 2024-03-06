Return-Path: <linux-fsdevel+bounces-13731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E06873374
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 11:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9FA928A4B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C825B5FB89;
	Wed,  6 Mar 2024 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dhawFkYi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5FA5F871
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719293; cv=none; b=VK55mANpM0lpv3Qggg/9UB8JFrsd31L5+zyjPOVyDlh4TjIiiFsnKVjcXejrPp7LIUQ41XPxOcCaJuh7gkJNvb7fQpa3h7+q0H0tsDLJb9YOGGwfENnBNch7gIfZri+oj+OQlms+l3I0dQteipRtgAXjlIrf4Xoa1tN8Ht8qRKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719293; c=relaxed/simple;
	bh=xAdDe6dQomEORFaa1bExe/C2eZ99Z8ee6SsE1uK9ROM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWNyNoCRBDFT+Vfm2J0h/6ttAkaGE0NOIKiIBgnpNk57tI44egivQ2vhMP6Skrl64APJpEgpCt9qL8zsteHahQOnRTLSq7saMMMkPodah46N7n/SbltQAsviOidZ7IeWcvNPyR6ugsDz8vE7NMG4NJhOTGGW/7Eeq0Jm/KbYuC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dhawFkYi; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a441d7c6125so176251866b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 02:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709719289; x=1710324089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xAdDe6dQomEORFaa1bExe/C2eZ99Z8ee6SsE1uK9ROM=;
        b=dhawFkYit8n72LVYrSUXI2/0u0gkhrv+444CF8bVcYzsp1SaAS6mwHuFLDff9inxpu
         Gb9uysQGO3a6sjDH7jlZv4O11vvqp9CZpn6gYlbv5Wp5KGixKOhLk1oOjBaf4OLG0L1U
         mesva1RHhiMZ/C3jsU8h9zLCDylQ5V8HYFDNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709719289; x=1710324089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAdDe6dQomEORFaa1bExe/C2eZ99Z8ee6SsE1uK9ROM=;
        b=dEPIhPwJLvVuFdRPJd3ShNUYIq33xDRLIK3KFlcD/fKN77NSB7IaRLm+qqeZD1ic6D
         wJfSF+2V2LRJrUs7RlyCOha8A/mD+N7EGKNtcvnKXylH8povlzjo9CNVT5h6NHdH0AYr
         Tf88z7S3/slmnR1Q+cOGfGalbH48z1SzrmVrIZXBwtkA6UsnRBiyVSaRrHqjhFOmcXDS
         npjGQspqy/0nGDc9TKo+5TUCDrCHT3G3r+TKQ7kDi7Brih7CbN/ycij3YcmUcuNP7V0r
         1CQClmYowRIdnv68ztRBcd3OMHmRhBwMGuWrLixb/tVqw332+n7DBaJPTQe1KvRi5+Zj
         d0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUTvKdXDVBGqw1NBXc8vMTp/Qv3Xv6rdY3P1MMS43gTL8CvNNLNW3UgnnFiW3SGQ+cR7lrmxrb0jlr40dFIfbvwLGn2iyrgoTGoOiIX1Q==
X-Gm-Message-State: AOJu0YwTIuikQAY6XasD4OatQXrZ4fUXYI5V7ci3VwJtjuLb7h1FTm/L
	uvjpHSFpj6TgUhK0rRxhk3ir9BTtyHLNdVJXCbslb2P0s1b/qJBSbAk8d1cemDVgQX26VjFbvpY
	rtjhj6HJ1TDptaSvQalf9ddZcObLGyAyv9iJC0A==
X-Google-Smtp-Source: AGHT+IFDBhqs9g/3UKwHu218l/la87fPexeSsGsdIoalfWgyzMf5RYbc2YJ6ZgJNqyDhvkpz5KIiOUlcU5HvtQwcWn8=
X-Received: by 2002:a17:906:fa87:b0:a44:8ea2:23fa with SMTP id
 lt7-20020a170906fa8700b00a448ea223famr10452807ejb.46.1709719288810; Wed, 06
 Mar 2024 02:01:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1693334193-7733-1-git-send-email-lei.huang@linux.intel.com>
In-Reply-To: <1693334193-7733-1-git-send-email-lei.huang@linux.intel.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 6 Mar 2024 11:01:17 +0100
Message-ID: <CAJfpegtX_XAHhHS4XN1-=cOHy0ZUSxuA_OQO5tdujLVJdE1EdQ@mail.gmail.com>
Subject: Re: [PATCH v1] fs/fuse: Fix missing FOLL_PIN for direct-io
To: Lei Huang <lei.huang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Aug 2023 at 20:37, Lei Huang <lei.huang@linux.intel.com> wrote:
>
> Our user space filesystem relies on fuse to provide POSIX interface.
> In our test, a known string is written into a file and the content
> is read back later to verify correct data returned. We observed wrong
> data returned in read buffer in rare cases although correct data are
> stored in our filesystem.
>
> Fuse kernel module calls iov_iter_get_pages2() to get the physical
> pages of the user-space read buffer passed in read(). The pages are
> not pinned to avoid page migration. When page migration occurs, the
> consequence are two-folds.
>
> 1) Applications do not receive correct data in read buffer.
> 2) fuse kernel writes data into a wrong place.
>
> Using iov_iter_extract_pages() to pin pages fixes the issue in our
> test.
>
> An auxiliary variable "struct page **pt_pages" is used in the patch
> to prepare the 2nd parameter for iov_iter_extract_pages() since
> iov_iter_get_pages2() uses a different type for the 2nd parameter.
>
> Signed-off-by: Lei Huang <lei.huang@linux.intel.com>

Applied, with a modification to only unpin if
iov_iter_extract_will_pin() returns true.

Thanks,
Miklos

