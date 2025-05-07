Return-Path: <linux-fsdevel+bounces-48391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A5DAAE370
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 16:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C891C0145A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8A0289E04;
	Wed,  7 May 2025 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QzRZkrch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC58289E0A
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629118; cv=none; b=p+sSYVE59DDhVPjs99mLeHIU5XFhaD2IX7xdzva1d7INpS5NmLfZddYuKR+TbpLhCAVCkuYkM8gLlZWmlycapLF98Alg3VOMZkXUhFJJz7SE8vsyiNgpPj2lY2m+g7SEBb0vfve1w9wPlJLTal3sGmnJXNXV3LZMl/1YgozggQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629118; c=relaxed/simple;
	bh=6qCFWk2WnSXJdlX1KORj3L4lFoOX6zlY/sfoE7Pzi+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmqIJxzxYwrNNDFvh43tsy4SVBA8jfJYlBBaqqcm2w0pUjHxbTQmsa94O8Zv+MG10Qk+vhki13a6wDzVMtFc7aPISXH7C2x25IAF34UEWAhS0TkOG4lqoL6bowCueoWeHJr4BvdjIfogMSaGM4JjHmJfDFxYfs1vXhXOVxuCK9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QzRZkrch; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47691d82bfbso36643831cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 May 2025 07:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1746629115; x=1747233915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6qCFWk2WnSXJdlX1KORj3L4lFoOX6zlY/sfoE7Pzi+A=;
        b=QzRZkrch4RlZF/xPpM3mqEjGCsHZBGbMeh6g5YOncb1UaSA1Pf0oYcnmUV5skU7dtW
         bGcbdSkFHGqNNQYCGWyspS+adz3aRKBqmChScB8fXgNOdAMD5rBxtXfoC2H6pSdJvgqH
         TVhRNgWvYG88m0xdS090WNxhjCHeokrzpZT5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746629115; x=1747233915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qCFWk2WnSXJdlX1KORj3L4lFoOX6zlY/sfoE7Pzi+A=;
        b=duzEtJ1fBeYzOvz5I3ZHCL9j7SFVkiv5rrDjZtWRYiqiubtH/TA0F5sBbMECtKusFZ
         lAsmteMOZgL4L0jKXrWr/+8zIAV2SV+gkuk+XfjahYptDGVSYlWmgPjDtInUQKxT/R3l
         dGochYZZ8KFryfxHmX2xVA+bje7gH1tMgb7XINEg6w3O0lUme63Xf6/nVF9Hb7QurdIq
         GXKFmrOX/syCt+J00HB7lMpCpITww402chSRcIbd/hOSlbZAS8biF0hQfl9FBcupz0Xv
         Z15GgJNbWYDX0OrhGtzqaemklfdBNzgu4RvMOd4NVWbh5CVrnzdxS+LEIKdfyF7KXU1c
         75dA==
X-Gm-Message-State: AOJu0YyCdr+SEEKAsRsIJToOQA2sfedos7Z4WZ5YK+TDyMFlS3U7qhzb
	pKGKeIg5fFLI/rujobhHqA1NrMBpMVl7qK74YtETvco6h1U2UyFMIr0srgyX6ChcTOzUFv/3mw3
	leHCSUpxfGEwLqQqKsTias2+a45mViDy1FGqf0g==
X-Gm-Gg: ASbGncvhWa9T9RK45DWbV49vH40IGUEx7tD1G4hYqlRfdYHQiZ8w/cSh3rbEqU0gelb
	JqNzRTkOabGanOtIzM3u6M3d/TK87SOC1s8/GhpvK3zqfMp+j7ix9naaQ4p/Bc+3EXUWiCc3+kA
	KQLtwVQ00GglcxKwZYUhIxxA==
X-Google-Smtp-Source: AGHT+IHyMBm4pxch2Y0m7eKTAeMAo/YJWTbqoXKkrSVXyVEob+fPFy/VXgEuUpxGO7yAgDTbGltyJC2/jo3vZ1m8K50=
X-Received: by 2002:a05:622a:109:b0:477:1edc:baaa with SMTP id
 d75a77b69052e-49225560457mr40054541cf.6.1746629114957; Wed, 07 May 2025
 07:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422235607.3652064-1-joannelkoong@gmail.com>
In-Reply-To: <20250422235607.3652064-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 7 May 2025 16:45:04 +0200
X-Gm-Features: ATxdqUFlKmB9CyCg8JL77-GuEOplY-nHfmFBWar14QGXclzaghG4f9OjtWQ2LCk
Message-ID: <CAJfpegsc8OHkv8wQrHSxXE-5Tq8DMhNnGWVpSnpu5+z5PBghFA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: use splice for reading user pages on servers
 that enable it
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	jlayton@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Apr 2025 at 01:56, Joanne Koong <joannelkoong@gmail.com> wrote:

> For servers that do not need to access pages after answering the
> request, splice gives a non-trivial improvement in performance.
> Benchmarks show roughly a 40% speedup.

Hmm, have you looked at where this speedup comes from?

Is this a real zero-copy scenario where the server just forwards the
pages to a driver which does DMA, so that the CPU never actually
touches the page contents?

Thanks,
Miklos

