Return-Path: <linux-fsdevel+bounces-54310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1CEAFD9E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 23:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C49178A5F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 21:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D9E2459F8;
	Tue,  8 Jul 2025 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YERsk/o0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A5023C8B3;
	Tue,  8 Jul 2025 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010089; cv=none; b=fsVxnyn1axkw+L8jTCb8t3i7th6aFMHXvHEbWgpllIM1GRmuluHkS/onv4gn9+EoXkV1jbS83bEJA9+iGd+5ZAdFHrKXcg67Ck+g9WFxxwrcNJFybH8Npvo1TabA3TvG6cs1KyQVUcO76xiShzxI0b7/j4oMYc+f+dB4npVV4S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010089; c=relaxed/simple;
	bh=KH80pBGvK95duvfP05FBqteazR1TV1r1R/kYwzUSEMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2JQMGsfgM8XkaLKKkYho0lsZf8dmcCoN4+rjQ5eZ9XuWhabTkR4HJ22uHOYkRdWuU+Q4cpWXWBDbl3E54/hujL8byMjefdFsCqrjfiYPFkrkb3pEmp3Q+VE1Q/u2czWf0xJ2YpeOvREXwtbv+rDbV/0ZK/sabG2Gm3QPe8pap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YERsk/o0; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a97a67aa97so31422401cf.2;
        Tue, 08 Jul 2025 14:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752010086; x=1752614886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/n4FQqDZgscE96T/Q1Cm/w2ztQMgw6w5bX/UKWRgK4=;
        b=YERsk/o0PYgcQx2B9n8tSJiYKli4OhIJz3ZE17UFLi0R01p+QSc3AJJYc0k8o+mirv
         7i+f3HGO3WDOoohl1I5d35oPJ96do7K214CYPnuoen4edfCpR3KyDS9Gy/IFTSxgr9BY
         ZPReDtiDMP/e2qRtNTR2fJrvQIfjp3wuy7OEvcSwxEQNU0YZzNAk4qBoSsSpIW02DpCO
         sKvC2r7HyLt+gBPa3s9/kea+REsE8xZJjBT+B1triPzEFtfJAyKkeSNRUZDkokH0SVel
         gH82pCc6w8/jGuW3/hKwHbKKWqg1zr18oHUslHMysz3KCvrSRjl4wJCDGxhI+hbUapio
         CP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752010086; x=1752614886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/n4FQqDZgscE96T/Q1Cm/w2ztQMgw6w5bX/UKWRgK4=;
        b=fvswFtLvAeort+rLL9OfdqNqzLI9SmZPY/Ll5OV7h48LHg6kREIljXYePIWF4RYQ/f
         Z2dpUo8pfDvMAdhA+IGUoILlbtrsHZKB3vcM/sj3S6NqlV/U5ItR+ZaoivrW6GkkoNuW
         fCsrpJZTOajqk93TI8nFCIiWAj1fEg9q+NaO6SYr8qQUQZJ4i1FhrIB/VUahclTnKLLA
         EGbK3HWtKAijAJm9LbuwYAXeb/XbWQpiAiSI6oyyyzVkgoG0mgdh4bWKD0Or4cTONUof
         WK2fVJrdYoHmiBZF2DrQOIfV95ns4fVffH6aFnh2rQ7T5r1eR19KUZztYSBIfihEslYk
         Mm9A==
X-Forwarded-Encrypted: i=1; AJvYcCVMwoKNX7lL7eJ6uLCa4trLGFSW2dVGIfvSTkH4JRj4IKP21cbU3H4F4PyU2mJaxXfyPQoGWSZHD/wAjw==@vger.kernel.org, AJvYcCVbQuATGI99Ewujfxv2sXoAvzfCXoWSMgIy4pVusit21RjlfJvtOS3PjV3SXKQcTHqrnVX+f/liK4Yw@vger.kernel.org, AJvYcCWKniv0VxjBqNnqHt08ob0pu9gVMvGuW/UfleGXTtQzfLSEgjuWVS0vxrByTorSC+I8qTufrtobNUSOO/PGHQ==@vger.kernel.org, AJvYcCWqyry8dNtNYKIK9RgB8vV68oFossU9o+cVQ+VCAfFJnZds9E/TB+UKLmgVHQZB6YHYOT+k4LrQOtF3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9IKmX3s8x9zBe/A/tZey3UnMhGOXT6llGfTeJ4jf5cGYFO1A8
	Lftkg2JVR61BMReM7FxrEq+E6HvetTkimZwQQUXrb982L75CchPYCvs3l3rZBEfAQBBfe+k564y
	ftGwTp+sQUnn89q/CA+sPv44anOfcK1o=
X-Gm-Gg: ASbGncsq4WSfuWzHj/B/bR1APjWB/9caVa2IdDUj9GM38fSLOvfRBGOS5gb7GadfZtF
	ijEzs6RwnyITp38P9AFScAR6JcCpcdQjc1WspWu9sJri6T111ijYU6griMMgQG/o7mHbAT/ws73
	3xlVzg5S3bpjFZiG4ZNxImThm4zHS2BxWUpBsU/HSH9lU=
X-Google-Smtp-Source: AGHT+IG6ppwNXJOKmfyqWRjL2gzJNhHTbHsi1CugYOTLDE1djdPPUcm+bXlr2zgXs2duHd/3iqXiYYXnEEW980chRDc=
X-Received: by 2002:a05:622a:400e:b0:4a5:912a:7c64 with SMTP id
 d75a77b69052e-4a9987bee22mr356017581cf.30.1752010086409; Tue, 08 Jul 2025
 14:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708135132.3347932-1-hch@lst.de> <20250708135132.3347932-15-hch@lst.de>
In-Reply-To: <20250708135132.3347932-15-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 8 Jul 2025 14:27:55 -0700
X-Gm-Features: Ac12FXzq0wErtxHImDMLoetaoL0NgHH4F4Hld2zkUOUcA0tdUmgfprT2nRYpH2M
Message-ID: <CAJnrk1YjEtFd-jR=E-QPPy5DkkbScimBNAvoWa1xjo8NQOxuwA@mail.gmail.com>
Subject: Re: [PATCH 14/14] iomap: build the writeback code without CONFIG_BLOCK
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 6:52=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Allow fuse to use the iomap writeback code even when CONFIG_BLOCK is
> not enabled.  Do this with an ifdef instead of a separate file to keep
> the iomap_folio_state local to buffered-io.c.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/iomap/Makefile      |   6 +--
>  fs/iomap/buffered-io.c | 113 ++++++++++++++++++++++-------------------
>  2 files changed, 64 insertions(+), 55 deletions(-)

