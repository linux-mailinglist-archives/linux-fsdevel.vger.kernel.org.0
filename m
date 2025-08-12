Return-Path: <linux-fsdevel+bounces-57505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CA5B225D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 13:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0DA3B0798
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 11:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568CA2F0C51;
	Tue, 12 Aug 2025 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="T3cgJgF/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8A42E338D
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997675; cv=none; b=MBI0BlJcvIv6Koy/OCbULeEYENsfpClPrtZcv88/5OCn6D5lVG5n+48LBAdyYJxxQTVicw7AXNU4a3ByqafqqO2N+ZyH+A3XJgNr4cVHaYdjNZeyoHc5T3LGw/GK7whzQ0kjbsEvgv35XPnvi8NK4gbQ5dY2UviyN9Xv1Qm3oDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997675; c=relaxed/simple;
	bh=ocU53uaCO8tXOsmPANnSTyJOcAGOkLk3aFAeG+DtoLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdCIooAr2D8Mg0klHr5wOwSlaSeYtD67vXCfyL+wkVue3dO8nKqwwZ9WqofMh2gcoRKE9Xd2w71C5g9ous3Vapk/o5vnPkO8tO6NexNYUME193nbpg4ZAib7n5J/EZl0BweTcYlp86rbFqWhQGB1teB4YShqEj264K8F/QUBaOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=T3cgJgF/; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b07cd5019eso63145231cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 04:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1754997672; x=1755602472; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H+xH9acp2H+XKJlPlpxUqmlQHxaf/A0TKenzAtiX5o4=;
        b=T3cgJgF/7jyrkMiXbVlOrYHHwJTfbD5ahFmwX9MAluJKYKSzprHVXfqtddV4RONN39
         vLCU2dkgNoP2AgA4du7LCu4kOLg7NJOS01FHFGAiFRlRGfW0EwkUF+Pk9KGVzIHrDYRH
         5A9YdnA7f1lvXjvMBhD9FfU8jwNmAG4q77T+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754997672; x=1755602472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+xH9acp2H+XKJlPlpxUqmlQHxaf/A0TKenzAtiX5o4=;
        b=UAb5LraCtGzwgi2Ma7eoBma6o34wAb2XgqnAyHWPDPpNfdULIPKsGd4lQ2BnR2VQ3h
         RPSJ/axIhZpBA9VHf6XIHLklchp5r+nZvwDv7KizXTBQAMMf+/KzefANZgm5hTKvhi75
         3190VOVoizW0akbMr+httKU6mLOJ7lii7gHQKZ35n9cfPf3AkpufjOt9E90R5SUvUiYx
         c1Ld6Y6VFiz+GHFXqCmykv9/3L5KIJaRc4H6WpwBJgHq0CHNfbQTxV6Nvm0ogK6tInnv
         WHnPcURBLmV3CW2+NtoC7Nm/ZgDz/lATe6p61AQki24OOY3HV6PJCOha/SabRp8u8Y0/
         iHaw==
X-Gm-Message-State: AOJu0Yx18Y5WJFzHRHVL2Ri0cOWgaX4FAtD8ZiE/0/kKQGgAxVha7dSr
	thb8g215FhP7gcJB9gQl2c2B3MXiPmDGI1R1KNunP6fBj3ks7BGo3IeGmsmcH586dysp9tX3fHa
	5CeBBePpLSRXJs2f6KslsI5qbqtHRrq27aFYocJLB0UdrXSZQuPL7
X-Gm-Gg: ASbGncshJzvoQAvQYYA6XdQp5aUo2sdKkgsaY+Bsk8izuqhEuhBEocogFWbX5dDJzID
	AF+tfRM2rBN2jUAG9K+hsAWiIHd8M5XewH8gzalcHlMSDlNjoLwck5Nq1g/jCNBwXD9dt/GtM+N
	pGsnVTQO1ejXLH2h2goIWXtxAMLFNOlKwDxZZfnZwB7BzVXNjnB6Wa7J5LxJk81u1IUCmW26OD9
	dF9
X-Google-Smtp-Source: AGHT+IEQbWSGjW2crUSLQrBWM+iFqZ+BWsWsKHY+AHmd+Ny2+TAYJQ6MnzGfH/nXQU8PK5dzZtTVZotrkYavU1ehY7g=
X-Received: by 2002:ac8:57c3:0:b0:4ab:37bd:5aa9 with SMTP id
 d75a77b69052e-4b0aec70b07mr229548261cf.17.1754997671812; Tue, 12 Aug 2025
 04:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805183017.4072973-1-mszeredi@redhat.com> <20250805183017.4072973-2-mszeredi@redhat.com>
In-Reply-To: <20250805183017.4072973-2-mszeredi@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Aug 2025 13:21:00 +0200
X-Gm-Features: Ac12FXw5XF9cIo7fJ-X711KoidWus_gMMIei48ksmgGDaPCMyzjIcKtDCgnaXuw
Message-ID: <CAJfpegsiyv52MX_JgkT8jUx194R=vB_BX8VY00muvaVVJGeJoA@mail.gmail.com>
Subject: Re: [PATCH 2/2] copy_file_range: limit size if in compat mode
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 20:30, Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> If the process runs in 32-bit compat mode, copy_file_range results can be
> in the in-band error range.  In this case limit copy length to MAX_RW_COUNT
> to prevent a signed overflow.

This is VFS territory, so if it looks okay, can you please apply this,
Christian?

Thanks,
Miklos

