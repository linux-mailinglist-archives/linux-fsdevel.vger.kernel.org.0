Return-Path: <linux-fsdevel+bounces-62231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A2DB899D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 15:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97711179822
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 13:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9446F30CDA5;
	Fri, 19 Sep 2025 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQIPISGy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A093F2ED845
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287374; cv=none; b=ZWe+jMQ91so511kYVCtbT1LQ1YPvOTJx+epOX6vUA9gXHYysiAW3Q4c+Q1LHR8DIu6fZqNSdSnixCAkGffwqpR2IRDdN98CNe62+QfYARcvmiSkvyH9eIW/iIBCCgRTKzqKPKZuf5nFGgaYf/E/E87sSkGcl6eaHc96szkoLzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287374; c=relaxed/simple;
	bh=H2nghK4bl/H+DNUfQhtZLwYHG07QNLlFwkEd9mrXbhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLwqoPYr59pXKAqqvPSDOqsmDeXLncdx6D4kMH/AGSq5rdo27mAc5SfRJRoWYdvNMMACRY9a5v8iJvMp7G61Ar4rBpmnbvzVHiAJ5XuJISqriYGd1VfllopDUt3vLF3zKFZH8j1HcCCyYu911LNAIt5VLjepj9kRm0l1+YqLhtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQIPISGy; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62fc28843ecso1049331a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758287369; x=1758892169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2nghK4bl/H+DNUfQhtZLwYHG07QNLlFwkEd9mrXbhQ=;
        b=BQIPISGyaL9K2DiFORwYXbLp0t2u4Qq7Wi9F4RNLMuSVpyK66tSAoNsyEIYswqWV26
         iNyNMFsvPDMLcyCx5Brope1KQRqcyBHMz4yssiys1snjyeR3l1GIcRFDsIjglAi9HvWj
         IlBVLk4wEYQGTNNyUT7TeWjslzh1k5HuAp+0Qpsn5AsZ2NW8Y5UyHSzN70Zer329AMnZ
         n996bHOKl75/nauI8STW5nkufGGR6s1xIt3boi1DFvvYhV32fAvcCtgJqEW1NhPtORuX
         wm9IS6roqrijLmO1HE8RXHPiymNGhW+W2wOGR4/VZPeKOGA6ByVNxAJRMbvc1aw+r+Xm
         q8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287369; x=1758892169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2nghK4bl/H+DNUfQhtZLwYHG07QNLlFwkEd9mrXbhQ=;
        b=axQWVc7/PjbwEHngxN1uncxmdIMJHMxG08FA+JGfAPISsiV+Xukkcpog8GLgFBx8CY
         nucKI0Fx2VPQcIiKVAx5v/G0unOkOz6YcrtF6WskVSFXPQtT17sCdypFbkAEs1OObID6
         6iPgERxGzfkn0ST+NxBgmf70pU5Dup4wc+5WMNzuS8pkt/b71iZ8gNAbn+xaEAYXJZUR
         bvrQHNdD8jRPA4V+5WHYbGomzx3KOOP4nQxAX/5TRaVJMgGARGbv0tQT98Fe1jDmIuhD
         tIWDgvPcQDNFYOnFn/W94GToutzD90AmP3h12X3jGqw/ich5JIzf0iB5kalPvw8BdBtF
         GLVg==
X-Forwarded-Encrypted: i=1; AJvYcCVxUV3yxQjTsob9IGB0NShTpC8H6d8zPjrwdgEADmVn1j/3KCHdK6THJwTUQDXgY1Wrc5VM0RGkqyEZAG++@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk49Ih5EcLl67d0m1Z+5HL53ykZfH4PhGLzUoJUL4ZI1QxqUKc
	iQSbo1+27iRiUPF010InjrQA3g8LsWnzNxfmpkzTdxEAVi970I55/9oPSowlrvb83ymruDRYa8N
	gmO/d69fVYEEMr7gpjLJhIVraX8yQns0=
X-Gm-Gg: ASbGncsV6Yq4aqu0ZLpagzHbtoos9BMXKhsLMHqkCVeA+9Z1jl/Ms1Edaf61DueGLlx
	iqg8XnbAAzNZXKwbo5aRZdGaphzaKk4dQpuAlX2oc1iiLyehNWTxVngs/Ip+c9PBDNFiZWAwj/t
	lb6HU6C1xqKMB82mBcj2ELbTr0N+gDqqwBVN1jWyRDrws4Peihd1EvFPv8qz8sKUd/xad/DQNkU
	l1coqngze10lWEOqHQtKKWSW9n1nt0a9DKmgb4=
X-Google-Smtp-Source: AGHT+IFApfhAHEjMUI5U299k57YwKnPsMN/Ik0b5HX6lVlpdtHbeIxsd1Q0r+GQz5I22vbwNy4Ut9U4zuDgZ7sOE0qo=
X-Received: by 2002:a05:6402:5343:10b0:62b:2899:5b31 with SMTP id
 4fb4d7f45d1cf-62fc08d40ecmr2418056a12.5.1758287368510; Fri, 19 Sep 2025
 06:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916135900.2170346-1-mjguzik@gmail.com> <20250919-unmotiviert-dankt-40775a34d7a7@brauner>
In-Reply-To: <20250919-unmotiviert-dankt-40775a34d7a7@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 19 Sep 2025 15:09:16 +0200
X-Gm-Features: AS18NWD5Om8yGekTULVtEvApOLHSTiZijG74rmoXqBK7CgJeOnhoxL1KEl8c09g
Message-ID: <CAGudoHFgf3pCAOfp7cXc4Y6pmrVRjG9R79Ak16kcMUq+uQyUfw@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] hide ->i_state behind accessors
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, 
	amir73il@gmail.com, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:19=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Sep 16, 2025 at 03:58:48PM +0200, Mateusz Guzik wrote:
> > This is generated against:
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=
=3Dvfs-6.18.inode.refcount.preliminaries
>
> Given how late in the cycle it is I'm going to push this into the v6.19
> merge window. You don't need to resend. We might get by with applying
> and rebasing given that it's fairly mechanincal overall. Objections
> Mateusz?

First a nit: if the prelim branch is going in, you may want to adjust
the dump_inode commit to use icount_read instead of
atomic_read(&inode->i_count));

Getting this in *now* is indeed not worth it, so I support the idea.

