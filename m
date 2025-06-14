Return-Path: <linux-fsdevel+bounces-51667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3694CAD9D80
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 16:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE8D189C213
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 14:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EACA2DA741;
	Sat, 14 Jun 2025 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3twA8iu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4564127452;
	Sat, 14 Jun 2025 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749911011; cv=none; b=BgPlkB/0uD4/trV9aKWj0IR81MtkhucxSn3LNAOwzAp7BybHGLL0lywVX5C+8qGRvKce73/sKBweJSIokrjDoC3b1yxh3xf60CFn25csRFQVKMQty9n83M6fbq7yZgTaj1Mw3E+ekkmmQfKWxA8zokbX6Tv3Wb4vw+28tb6ps9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749911011; c=relaxed/simple;
	bh=ha9MJg6gV95/TNrJ0UcWvkWlG9JcFL2WRQ8Woz3cy2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9rKEsSLFrgE7hesg25tyuyM+FDxYQ3zE487KqU19k23+ha22WjcGLxCRYlOctCx2gnpCJ9qDbxjeBuZXApZtz8lHu2wHBZKbNB1UzCk+iAMue8YOtTwCGP0CfXmkRhuunJH/S46To089rjD2218qzedIYEi6+wPXQtjjw57970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3twA8iu; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ade76b8356cso601702466b.2;
        Sat, 14 Jun 2025 07:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749911008; x=1750515808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ha9MJg6gV95/TNrJ0UcWvkWlG9JcFL2WRQ8Woz3cy2g=;
        b=f3twA8iu1CfQj80VyLf8Mpujw4bSYnC7F+sMmbLkF8b72+S+mM2B+FUD/7g2evpkHD
         MFdqIbvOKxSnisHkF04Qe78duAiJcQ6nloP6doltj9hqVpL3dup5UCg8s5Z7rJTyM+MZ
         SyEp5iBmcw5xVjyIySxtwmbiIdty6zg/ulJgYGa1Ulf3rxEjEXhebll6SyEZgbFUlwyw
         N/dQSVUyVBjD7r5YZmU1Bu43Od/YxtzCAy5UmgQPvFMveCkO4bmnHs0vjjy03ZoDg12N
         h0XGDfQgibUmpCBwK5d0ua6S3fyNQASRS8P2VZK81aQZ96S3nmULvYTjeOKs7LNRohos
         yUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749911008; x=1750515808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ha9MJg6gV95/TNrJ0UcWvkWlG9JcFL2WRQ8Woz3cy2g=;
        b=GYfWRcGEUzqMFzzv5xJLKn3SyRlW2coXgOjyJIKkOI7qdiYq0ztm04f/VekKQDhDVu
         CCtjh2N/5qdJo3bPcbJD522n/bESejLvW9n4BCnrXB5Flr+sgZE310WbuxTNjmOTqn9X
         FCtbVykqQ4Mk9fIKNnWfp8yi3yt+vNEEfjooCwuiL6YroVArn+e7mEqpf0tCAb7Syl7u
         XUWmqk0x78wPcOcvWRk4Ian9vMm+HfyvmSKvEJzUIz9MI95xRJ0zsWjK2FiXypVFc6c7
         RdOJ7l1Z6Uwxlxkf9hNU6rIaGkeoXIsaLfqCcfMk9yw2P5OHAAP9ErxSFOL2ig90F2/T
         JC5g==
X-Forwarded-Encrypted: i=1; AJvYcCVCzVDPMqRjQzUd8C8gIBkgvykz9lFD0YUBLYPZZVS7IYF6aSV9i6IfV9LtHpeWsyzw3kEyDPfKO44o@vger.kernel.org, AJvYcCXXckKCBtVwr7ikn/EDUFTsAbCkG4WtG/6FB3ZSLI9DyJf8h3uCRHaW5jrja0EgywfwtufLV5T4zMwIvw9j@vger.kernel.org
X-Gm-Message-State: AOJu0YxqvSVESkyqcUzUR+511TZp/QCQh2nlEQjkX/Lnhx9puDkZS/1W
	coSYdGxHBl4+X+62dYOSBtGCntNyJm9/s/uEsLVPmApwNt4B/W2VTOs1igggJka7aW/BoFc3sJ4
	dec5CtZ3Xu8oe6xRoYM886UL5qWXxRQ==
X-Gm-Gg: ASbGncuRKtp2ebiUcDrhVtg+lUbxjp4cbH7kjKcpx1DFI1FqN7A+tMXWvGtvSaUt72Z
	2m4zdqpoWpPnoaRtGyXGGKWC8b5NVYJgu/zga3jM6+gKuKzoQiSyoXYfr5CletLoJHHJ+tTBlwE
	cWe9OKulXvDn3v7v5RbYlQUTj+mmXaurnKziUgwyjHQgsvzggvi/rXZv/m5JYIv8m4mWOX/UTjg
	6AtDS6xhgs2
X-Google-Smtp-Source: AGHT+IGlkvF0el7GJrsVNvhkoXyHa+Zb3yC6yDptupgDNLE8hG0Cpzwh6n4TtHS4Q9hC/VKrsB3e63wzuOO/x+hlhs8=
X-Received: by 2002:a17:907:72d6:b0:ad8:9257:5728 with SMTP id
 a640c23a62f3a-adfad49907emr287412166b.27.1749911008300; Sat, 14 Jun 2025
 07:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <CACzX3As_tiO3c0ko9WJKTOt10dj0q9gNqPym3zFdUbLxib=YNw@mail.gmail.com> <CAJnrk1Z2QSVbALJpt2-nXjg+gFDH2mdnXUDTMEkyhxcvwh8B5A@mail.gmail.com>
In-Reply-To: <CAJnrk1Z2QSVbALJpt2-nXjg+gFDH2mdnXUDTMEkyhxcvwh8B5A@mail.gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Sat, 14 Jun 2025 19:52:51 +0530
X-Gm-Features: AX0GCFvffEky9wHTKtyAXvCu3jZJ-yvXoCDANWUc2oQYrv5e5OGr_oONS6PVK9U
Message-ID: <CACzX3AsCsgL6Z1nshJ-b8P8QxsT0hipR=wVzKqPqfZQHpKWEUQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] fuse: use iomap for buffered writes + writeback
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com, 
	Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> My main concern was whether iomap overhead ends up slowing down writes
> that don't need granular dirty tracking. I didn't see any noticeable
> difference in performance though when I tested it out by writing out
> all entire chunks.
>
Hi Joanne,

Sorry I couldn't get to this any earlier. But FWIW, I tried this
scenario as well (writes that don=E2=80=99t require fine-grained dirty
tracking). Like you mentioned, I also didn=E2=80=99t observe any performanc=
e
drop with the patchset applied.

