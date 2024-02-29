Return-Path: <linux-fsdevel+bounces-13167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4038986C279
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 08:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE348281A04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 07:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23AD4596C;
	Thu, 29 Feb 2024 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NJORgpR2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4654594B
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 07:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191647; cv=none; b=rAMuHxxceAxjZxUZd/e6YtAi9izHKnEokBlzSpSPGcMB3jAj5srZ5vkawY9oB2eYPRdp+w20JXdrj93C26bRD+tedoehRBGEhoEy2AhbveWZSOrnAe4+Cd7uvrokAN6ouifw9j8Lwi419SuKq/FbblzTMMRucsQ6eQlHzievQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191647; c=relaxed/simple;
	bh=gj0srNm4dhyxwVwQnx30g58qYENerrA3OScXTEwvqjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2r2afkYH0I1W5m6DUc+3GaMdQUOJEOG0IK8JY/wLH445Hysbo/uhbx/TUeKfsLSXd6NS6mewUhKaXkHFUZmGND0YNuxnEclGL7aYb7UAYwUzdwl3um9ltHXqO06q+POB12tsQWhijfgr8iSR4vx9isf4v4W8StEAQM8AfOBtQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NJORgpR2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a43f922b2c5so71989066b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 23:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709191643; x=1709796443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hmnTRedH8O3pT6nT1reFMuPDuDJUr60IhrC8tjvNdqw=;
        b=NJORgpR2z9aWJmO7EFX4CUzuFS7zB6gUVA5TBnrFKod3Jb59Nopi0Ub/Qw33tpkArB
         XBRuoqI3nfdBuxBQ6r0Wc/CFTqOV/HXAJmzXzo6TeDYDWh8P0cs1jeqggTsiuJ5AImcY
         2F3ajeVCutUz1/V8QQ7LEXzBFESSPP1J76IgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709191643; x=1709796443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmnTRedH8O3pT6nT1reFMuPDuDJUr60IhrC8tjvNdqw=;
        b=gQ7VserlWhZ6XS9aUWrdhaWCG3k8P4i+buqsE3G7gWUfHZjimQRNfRnTCTTh9ralMl
         NsAWz0IPJpz+Zk8CtTJMgDTXvc3S+LezwjYZgV59epKd1kb6g+j0ZU70U5Y1WIJiEfR3
         lbReYpfhpAkshRUDpVo5E8Bnfe2AIx3ZKczp4qw9vD52CNEPiQ48uXeHs4juyBOqTQJz
         koTek6WNX5cNmFGwiaF3rsPN/8p+RJ7d+kgf+3oT/Di6EOY/jexXlVLo2f/fiaLEF05P
         mgGqPEDUSuOboVwj9jh1VItWiJNI9R3OxtLaZP5vpTZV3vL5/hPp+rHvJX5o9eCGACpa
         KJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNSvzMNXm2aKWR4SCE0cSImZdRatZKsKCcjf7XxBx9EL6fSf6Q8JrZHPQFH03cDdWBk/kU8FHVwr+fyqfOhjeDxM7hTDDAcun0xsAt9A==
X-Gm-Message-State: AOJu0YxDR5SMf4L47noFx4vALbfuXyXZpm4xs9dbIQMlrZawSWr9EVQV
	LgrQKTfvvJ2cy3TRw8lX843hkvM/KHq25PdSWHI5RnZWG+aXBORHX0lCNAecrDhmj9aUhkBrWEX
	OfQtCCQ==
X-Google-Smtp-Source: AGHT+IFTywdl7bFmIn9DsLoteuRwex7Gv3N4qBFhPopWmi/Bgd31DX2W610I/t6GQooQYAlR1vBfqw==
X-Received: by 2002:a17:906:55d2:b0:a43:ffe3:70a with SMTP id z18-20020a17090655d200b00a43ffe3070amr819857ejp.9.1709191643564;
        Wed, 28 Feb 2024 23:27:23 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090699cc00b00a43e573146asm377368ejn.100.2024.02.28.23.27.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 23:27:22 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a445587b796so7064266b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 23:27:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfPxJ0n23qRCmq3BXDK9XHeyDTlu9f95wopIZgJuzoVSw0n9/XLtqrV8m77Te8wf0eRKgJea6dnY1lR3OysSVtNbZaZFiOzbqAg+n+uA==
X-Received: by 2002:a17:906:ae49:b0:a44:4610:6aad with SMTP id
 lf9-20020a170906ae4900b00a4446106aadmr466351ejb.11.1709191641702; Wed, 28 Feb
 2024 23:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229063010.68754-1-kent.overstreet@linux.dev>
 <20240229063010.68754-3-kent.overstreet@linux.dev> <CAHk-=whf9HsM6BP3L4EYONCjGawAV=X0aBDoUHXkND4fpqB2Ww@mail.gmail.com>
In-Reply-To: <CAHk-=whf9HsM6BP3L4EYONCjGawAV=X0aBDoUHXkND4fpqB2Ww@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Feb 2024 23:27:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg96Rt-SuUeRb-xev1KdwqX0GLFjf2=qnRsyLimx6-xzw@mail.gmail.com>
Message-ID: <CAHk-=wg96Rt-SuUeRb-xev1KdwqX0GLFjf2=qnRsyLimx6-xzw@mail.gmail.com>
Subject: Re: [PATCH 2/2] bcachefs: Buffered write path now can avoid the inode lock
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	david@fromorbit.com, mcgrof@kernel.org, hch@lst.de, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 23:20, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
>  - take the lock exclusively if O_APPEND or if it *looks* like you
> might extend the file size.
>
>  - otherwise, take the shared lock, and THEN RE-CHECK. The file size
> might have changed, so now you need to double-check that you're really
> not going to extend the size of the file, and if you are, you need to
> go back and take the inode lock exclusively after all.

Same goes for the suid/sgid checks. You need to take the inode lock
shared to even have the i_mode be stable, and at that point you might
decide "oh, I need to clear suid/sgid after all" and have to go drop
the lock and retake it for exclusive access after all.

(And yes, we *really* should have a rwsem_try_upgrade() operation and
at least avoid the "read_unlock -> write_lock" dance), but we don't.
See a comment in mmap_upgrade_trylock() about it. It should be
reasonably easy to add, but we've never really had enough reason to.
Maybe somebody decides it's worth the effort)

               Linus

