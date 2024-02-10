Return-Path: <linux-fsdevel+bounces-11036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC90850282
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 05:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 435BDB20E97
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 04:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC5E569F;
	Sat, 10 Feb 2024 04:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmqw9cfh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E695663;
	Sat, 10 Feb 2024 04:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707538435; cv=none; b=YGsTCDeI1qWI1Le5ykk6num7DCEWL9vWAtnBcv/KixpOoR6Qnh8596Ij1s3jmw8aL6J1+iee9ZZ/6dLehpOUH/I5H+/TJJ+eITvJuWRtUgGAc4qPY3vG0k4MGlhGNO0RxXIgXfqATq7Tub16/hyrX8PSt1Mz1V6azHUV2J5ZjoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707538435; c=relaxed/simple;
	bh=oI4igA4qp4EXY2Og+SQxV/VkdWDjclYg15fKupckyik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9ezWPbUFPzcuBbAdt18zj7dFZ5qDQpFbBLX/M0Il5oJHRGRN8p0D3AFc4GXJgPLeqeWRr5s89lS1aVbXlc/Se4+h2kSbvMkdh4eDy8juZmawWqipqwjWIFimFlgWQGs3gt3bRTOu8wT809tAXr2vYHMJo3A/4dvVPKMWpAkDjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pmqw9cfh; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e2b6461aeeso898412a34.0;
        Fri, 09 Feb 2024 20:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707538433; x=1708143233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g9l22/pwJVnGdloAJCNS/sXgALA4qBUOdE7DfdxKQE0=;
        b=Pmqw9cfhS0IJSvX6LQOMDmBnoFWVLsSqEu8JhfBy7BLjAw0CELNHg1d6TMiljFzOX7
         DrUgCLRU53yO3dpL0K1tvY5Jtqf6Kd1iGlYfLE4u5ZLgnFUz2r/ACQigvXVlTV+tyli4
         R5cHklmV2ZCFqpihzXOGdBK28i5bjDrPppGVCspl+xJfX3JlUwlFutYfYRMsZCLwofc4
         dnf04VsRe2YK2dVu+8OkMNLfEgLYL46mLm1cK/l/CjTPZKlWjAbaXdfJO31+awSOCEv+
         Oy6zlp/ZI1crUNroQVL0/tT0N/0TeASdDfcJrmt0TRNuoZia87ndPih5D/vu9fh3UUQv
         vT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707538433; x=1708143233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9l22/pwJVnGdloAJCNS/sXgALA4qBUOdE7DfdxKQE0=;
        b=YHZaUal4Tf3nj7v66oprBIT1ORgfqdtdNsHjI6x2bY7W+tw+gAEtMyCrBbpog2zVbD
         E+OsrT2L7yPSypJfgd5ixl4RzAEjN4vSbDNyzjDddrVmurWB6r+S2lLzsaY4L1//zDKa
         T31c9r6ufZD+r2DgFx0Z61okJM0aKtMypJkaUDHbI1CSj0RSvI1G/kCdH4subYfWDI4Z
         HIQGRYGddqNLTDKTvkA+WdA9YYyqXIi/Z33tZMJQiVKyC0CtwpSXZAQQfePwOyzh06q1
         1g/zm6CENSfvdV/cvTdshmCM40d+zhYruNjKgQhKpqMwUfOcpKXIR9/E+Qq1QbRvs1ty
         LldA==
X-Gm-Message-State: AOJu0YwKIC6s3qSFD+Lz82V/sWbP+kay6x+MuwgklGsItQUZwxnGHtND
	5IR9T2ZgPQRWMZ6No/1w2WA26NejWrCLyScT2BffgkhwGit1hOS3
X-Google-Smtp-Source: AGHT+IHnLJ1F0RxdwY2h9gdOC9vXnofcKuC7RC+W7eD5oOf4kJRXwBY488JvFZ3nky8s/W6NFW9gEg==
X-Received: by 2002:a05:6358:1202:b0:176:4f31:75de with SMTP id h2-20020a056358120200b001764f3175demr2005822rwi.6.1707538432756;
        Fri, 09 Feb 2024 20:13:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNRUdECwuTDzYaCO+YkjpvJi02t/FWClTcm2hrwTlVtMQDAfWUoiQeYut5eDNWcgYcbh8FWgcQOUGM4/GjButZO2IiVad+Nz5bl+iwRguUWXVgzJjNBGW6Aac9Svc6g7DhjqxMwMDKMFDD4wL/qInz2gLMoeFdEUPV
Received: from gmail.com ([192.184.167.79])
        by smtp.gmail.com with ESMTPSA id pb14-20020a17090b3c0e00b002971b574ccdsm127083pjb.38.2024.02.09.20.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 20:13:52 -0800 (PST)
Date: Fri, 9 Feb 2024 20:13:49 -0800
From: Calvin Owens <jcalvinowens@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Infinite loop in cleanup_mnt() task_work on 6.3-rc3
Message-ID: <Zcb3_fdyJWUlZQci@gmail.com>
References: <ZcKOGpTXnlmfplGR@gmail.com>
 <20240206205014.GA608142@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206205014.GA608142@ZenIV>

On Tuesday 02/06 at 20:50 +0000, Al Viro wrote:
> On Tue, Feb 06, 2024 at 11:52:58AM -0800, Calvin Owens wrote:
> > Hello all,
> >
> > A couple times in the past week, my laptop has been wedged by a spinning
> > cleanup_mnt() task_work from an exiting container runtime (bwrap).
>
> Check if git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #fixes
>
> helps.

That absolutely fixes it (the revert of 57851607).

This reproducer hits the bug 100% of the time on my Debian Sid GNOME box:

	$ for i in {1..1000}; do \
		dd if=/dev/urandom bs=65536 count=1 status=none | \
		convert -size 256x256 -depth 8 GRAY:- ${i}.png; done
	$ nautilus .

It turns out Nautilus was the trigger: it spawns and destroys containers
in very quick succession to compute each thumbnail in a directory of
images.

Thanks,
Calvin

