Return-Path: <linux-fsdevel+bounces-10881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C4D84F0FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 08:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1FC284285
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 07:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E093365BA4;
	Fri,  9 Feb 2024 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ecHrfIec"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23BB65BA9
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707464777; cv=none; b=DCJYyUMR32xM9nRPVeE+JhycdNssWXZCDu5O2BEMfyAHLF1UKZAvlL1WolZgHTBiD/hVjmWSN1492pIqPYul8v/4r8oY4mEwapeGYOmx9E/PxKHNN4cpZqGnDKwqTtyHw6GSa7RxBF0Irmz+LzIr+LIQKbADBqpgEYqTcX8Dflo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707464777; c=relaxed/simple;
	bh=Evf1zJuCE3Ehj9Lls6uIna1JA2KKcI3DDcSgPNeIa0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtTuawEe/eVsz2S/Xc3APk4d0c7gUVPPfUReJjee7XWnaqZS9ZU9cU3LJPPNpX9KGX6uzch+4afBQm4maAjiNMCl988cgz6A3u1mstdbpMOi11IaX0Agsuaclf4V+yhIeCZqDJYLF7V8KDU46aTLHxZ7xheOwB36FhLWyUz2GW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ecHrfIec; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a38392b9917so80119566b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 23:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707464773; x=1708069573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvZjKUGyCLNY0dYo05tIYWBLBHKAMov6XdCR0mleVm8=;
        b=ecHrfIec09zehqTW6313m+TqWYX+f9qvOZnYzSDhorUPp4LBdtjBXSCxPLyp8dAoGO
         gvtrACCPV37y06DiLfT1f7NaruawEw3YWmKh1lUHPN8jDD9coP6ilSexsd3GyxOYqqh6
         KorCEWIZtP0OAi6M2n1Npj8Kn4Iacx7up3dSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707464773; x=1708069573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvZjKUGyCLNY0dYo05tIYWBLBHKAMov6XdCR0mleVm8=;
        b=Ob4aTiB8cbX9eq4ZCFsrgCxlNNieyt6uzyjvcM3qlq7lnUMydTb1d5x2XH5pKnmQNq
         C4LRnbkJeFopG9SkDQTvmsfIkWxfz4mQnzN85J6YvDzbNLCBAVto2HP7u+ThJvwcttOE
         lH1JC9ch3PoV3e6OgUb6d0dKzRWKlGaqv8e0tPO8Hwq0hOXY8MP4hPvO1pyUIgSmzLH0
         wyA4pY3+UkTcDtuADbLmKo+Hnfx6QrJQsuj23zXaTOIle6asG0Kdx53Nwe5DrEbWteTn
         bFEZqYFDCztEYQAXrHcpnCQm3En52TBDHAG5D2aYgnHd47YdX7fx578EouwVAjfRM8GY
         VCig==
X-Gm-Message-State: AOJu0YzF1qd0IQgmTcl8mKtUoqrKKsd+8pexLHO1pGqaol5lff6aDRSc
	GM+NxSSZz2bt48zKVYRZDExf8KxcC7w/80kNjDYXW+8FA2mhSDGWHhrsxlZ1ZKBjIuhyTB5/UdG
	xHmHr5/bBbH0JKUYWktdn2SnmiCKDeyXIv9aMDDuKQg4Zp+3z
X-Google-Smtp-Source: AGHT+IHfrL4z/ehyS18WQITbKuy+x7ogMCEt1cFczqaUdkuG67XSpomTfXW6xmmtgVQEcATOOnkmnQJbLsIntBbfNnY=
X-Received: by 2002:a17:906:6608:b0:a38:4cdf:adf6 with SMTP id
 b8-20020a170906660800b00a384cdfadf6mr516804ejp.23.1707464773150; Thu, 08 Feb
 2024 23:46:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023183035.11035-3-bschubert@ddn.com> <20240123084030.873139-1-yuanyaogoog@chromium.org>
 <20240123084030.873139-2-yuanyaogoog@chromium.org> <337d7dea-d65a-4076-9bac-23d6b3613e53@fastmail.fm>
In-Reply-To: <337d7dea-d65a-4076-9bac-23d6b3613e53@fastmail.fm>
From: Yuan Yao <yuanyaogoog@chromium.org>
Date: Fri, 9 Feb 2024 16:46:01 +0900
Message-ID: <CAOJyEHYK7Agbyz3xM3_hXptyYVmcPWCaD5TdaszcyJDhJcGzKQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] fuse: Make atomic_open use negative d_entry
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: bschubert@ddn.com, brauner@kernel.org, dsingh@ddn.com, hbirthelmer@ddn.com, 
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bernd,

Thank you for taking a look at this patch! I appreciate it a lot for
adding this patch to the next version. However, I just found that
there=E2=80=99s a bug with my patch. The *BUG_ON(!d_unhashed(dentry));* in
d_splice_alias() function will be triggered when doing the parallel
lookup on a non-exist file.

> struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
> {
>    if (IS_ERR(inode))
>        return ERR_CAST(inode);
>
>    BUG_ON(!d_unhashed(dentry));

This bug can be easily reproduced by adding 3 seconds sleep in fuse
server=E2=80=99s atomic_open handler, and execute the following commands in
fuse filesystem:
cat non-exist-file &
cat non-exist-file &

I think this bug can be addressed by following two approaches:

1. adding check for d_in_lookup(entry)
-----------------------------------------------------------------------
       if (outentry.entry_valid) {
+            if (d_in_lookup(entry)) {
                inode =3D NULL;
                d_splice_alias(inode, entry);
               fuse_change_entry_timeout(entry, &outentry);
+          }
            goto free_and_no_open;
        }

2. adding d_drop(entry)
-----------------------------------------------------------------------
        if (outentry.entry_valid) {
             inode =3D NULL;
+           d_drop(entry)
             d_splice_alias(inode, entry);
             fuse_change_entry_timeout(entry, &outentry);
            goto free_and_no_open;
        }

But I'm not so sure which one is preferable, or maybe the handling
should be elsewhere?

Best,
Yuan

