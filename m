Return-Path: <linux-fsdevel+bounces-45436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75427A7796D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 13:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3490516A60E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 11:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751F41F30C0;
	Tue,  1 Apr 2025 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zz5ZUDem"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4C11F236E;
	Tue,  1 Apr 2025 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743506349; cv=none; b=Hgb1GEDYeDUzkigMpWeLb3AJxJFZ0cCRLMf39i8FFtMS/dtcK20cBt+nu3ZXYrIIw5Zgkpf/Wx1nh+VhjKsZlrpRHZQvP9E7GRb52UvW4S9kTv2goB15h3aiv03T7IaRfdbUzHztn6Y70OZaTy0p02DIPTVOZebwHzingHjoMA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743506349; c=relaxed/simple;
	bh=130fS+pjMEoLm9UTm6FGySgpJVShC7ByY0ePlMWPIAs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pNwEfTc0WKNtsxdyqU9DHrqKKacs8Z6SFCkdQOLWLCskT29ssR/6fAQMsgUa37d6h2nNQxKle9jnd+GH8JkhlabGNYWv8f511HG78MezR3xGccW3qvliKHBcw2Ck7d0RXVydSpjPReOPicMYQcH+cWYkO8OCRjyrmoxDjVzZmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zz5ZUDem; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso6633441e87.3;
        Tue, 01 Apr 2025 04:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743506346; x=1744111146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YKD52zm+gVaoIUanOq+CrDkg3TSttqWRUAHG2kVxgsU=;
        b=Zz5ZUDemn5uD2mGvKGi5KzrmmsXA5Z3HYmp20j69hzpQiBLu1C5V8SFozsAlsSJ55C
         /MjjtYBYIlZKciFgQpyNIN/g2EKtMrWfc9Fu2Y421PWIoXXGhh8y24HP7H5TcQlrZ9Qm
         HoVxIBDf8IB9LN4lZXgoOSpeZcg9Kggum2Bi8xpunB8rf/6Yt0aDxaaDu3nUHaZNJYs2
         qZHiCHrN4Z5Q8gH9pU8UyHWTgQAoONp9tNk+15WVr9XMGNyKkrKH9n6SKW1lQ0kfHRpY
         EzxRz0vQyerhT8fR5n9ZS6puoi9fAHjobBvZDmoqrSAExAowwTJVQ7vjJWq6NDlbuY05
         UXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743506346; x=1744111146;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKD52zm+gVaoIUanOq+CrDkg3TSttqWRUAHG2kVxgsU=;
        b=LR3Ejji+ZfKIv/KH/eGoWKh0OQfPEEObwC7qP86JRluNSsbsi3epR11tn14DD1tC9i
         cx+Ej4BrG+Nt26mLziyJsNowwqJv1UIhmWIwVzEFsh/4gVDvkBKGrM2iot5P+QMuCc8A
         SM3S59SV/Wu8PO00j3IualEVFiM+NHX2+BOeo3qXK/zIkkCLXitGAlgt0vR2hh1KV3+O
         XOmq06fwkuZh1emEs3QKSN0cOZWsL+abdh/IY479QLUQnV3iX6cIok91slm3scMTrVnf
         Af5kEJO53FqdG9Mlyujt80BbEPc7AOvF4yBlGeOlrU8Za6htmMv79vzVF/Rh1cDcLiXI
         Gr5w==
X-Forwarded-Encrypted: i=1; AJvYcCUd83DGY312gQq08mqlIeTqhZt57Xrh9Qo+us2/1XKR4PdtLW4pt36UPlVjM26eOPPh5js/ZLpm7DZpFSQo@vger.kernel.org, AJvYcCVbeCHqt+b1hxCZ7+9seuK9BESXC78K1kI31P8Z61/clkwnuux39uzAcSOoUUpyRUgtaLAalXEmqtk5lau+@vger.kernel.org
X-Gm-Message-State: AOJu0YwlXCwpSb61njYf0UoLtpqDsOPTgvgazppq8pVGK5eVDogdFPV7
	5p6JvyCRj9ENT/BAyiiQBufhoB2/mphhq7AXh8tw1DG86k9b0KAg+/NcJGEO00nnIoXvT235Oa7
	QWDh7PSI17k3y1JOFgSWWCdoQ/w==
X-Gm-Gg: ASbGncsHwWcalaqRwEcKNdtshg8mwybNEVteeFYrM/BbV9+u2hLtDfNQ0UpqiEG/+pk
	RJV190swpqVrgnlu7ZGBC6781wrQNE9Ww77SdUmyrfbIH3smQ4IO8SJRCIldmirsdgZttwNLa4S
	HXPNHJkt0C1kJmCG04VlGfc6M=
X-Google-Smtp-Source: AGHT+IHotLV8ha5asbhxquKWjZjYfeN4kY8EE7hc8DSh12SIfaKyzzOFond3b+xwwkIhiCk9vSQ46F31pgZX4W6+wyo=
X-Received: by 2002:a05:6512:39ca:b0:545:2f0d:8836 with SMTP id
 2adb3069b0e04-54b11010797mr3577310e87.40.1743506346144; Tue, 01 Apr 2025
 04:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Tue, 1 Apr 2025 14:18:55 +0300
X-Gm-Features: AQ5f1JoxDz6pgQoqfz8XSlOm5nLyhbCSjz0u2-yrYhLPhovDisMXIQUrHSAfsG0
Message-ID: <CACVxJT_eXRNjp-2sEfuxYmzTMPvu7U1R2bsKYjadVfR-W691og@mail.gmail.com>
Subject: Re: [PATCH 1/2] proc: add a helper for marking files as permanent by
 external consumers
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Linux Kernel <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

>  static int __init proc_filesystems_init(void)
>  {
> - proc_create_single("filesystems", 0, NULL, filesystems_proc_show);
> + struct proc_dir_entry *pde;
> +
> + pde = proc_create_single("filesystems", 0, NULL, filesystems_proc_show);
> + proc_make_permanent(pde);

The only function which should be used is pde_make_permanent()
so that the flag is silently turned off when the code is modular.

Code is fine as-is in this very case but when people start copying it
to real modules
they will start mark PDEs as permanent when it is not true!

