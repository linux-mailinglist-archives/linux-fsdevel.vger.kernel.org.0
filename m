Return-Path: <linux-fsdevel+bounces-49782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F138AC2644
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 17:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39381C06460
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 15:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9377421B9E5;
	Fri, 23 May 2025 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0tAZ3Sdv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6057184E
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013550; cv=none; b=SO2NX3LCtilMnMgvyv4JvRK6PLHbgtAe+E1QH570g56TstsaI644UAE7z4RtsDcelbcCzsbWyl33JdE2qtLu8PzUk3fWHHAbWcMsieeJS4/3+K+PR8bIUQgdfCSb3zz+bY7NH8m6D7EH9RDpDMjQVCVFHgGSZosiDNVDj52CrKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013550; c=relaxed/simple;
	bh=LyF7JqFiKS+BuUXVk+WN8BIjhcFoTOf396PvgVQ7Pu0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ahRNtK7v7D21hBGKTkp2Cqw+CeWGdZjVSAFZGCZpjNgJnSlQNRl7kJJZSf4ljEISZK+3+GzNpcawGgEv2SLBomLqfDHnK4sqB2oyBNeF/d4UXWic80VK04K+eKZH+jLqVXcS+5NN4wFddPlJ81IpasDKrtfiCVEbSii65B2ZJ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0tAZ3Sdv; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85b3f92c8f8so861568039f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748013547; x=1748618347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1T6SuAVKbFnUVFhOsLRnpVJLJtk7lk8+HsrZWLh36og=;
        b=0tAZ3SdvFBeo76djR139/DagoXg4dJIMWyMgY8t1WMMc0PPWqqHBFXCECp9nIi9FxI
         8q7wiJAmOLZUeFzSdixw/oTgyCgiftaW5QuXQ8pynmexNMYCY7PfinhnGDTSuCbb6G1i
         F7Aq9gnuTI0Xe5VGY6XjLWNyTBNKb0K2OcVTUnruQzAF3kKwGC3ZjkscnvGfd9ZS/sF/
         hoIIgXmrXgls1R487t6LIDlQAHGssrhml6+qZ9e5qB9YnODsfqZ5nTA/+VjPK/SzbSot
         AjAsdj+0hrdLkpRGJFF1P5mPwhlLEkamCnwdr1pGHqGBKXl4ic0C4hBdgZP6azMitNtN
         5yqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748013547; x=1748618347;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1T6SuAVKbFnUVFhOsLRnpVJLJtk7lk8+HsrZWLh36og=;
        b=nzibKWOwS8RpEFi1BUx/NifTv6HAXTCewuvUy20vxGLJXpiCyw/g7K2o6KV/lVnnlF
         JikUoxfXwdX7WNCTlbbkvJNxCNeIoJa+vLjTdYlhjM7TaBskObhShSBTYQ8hYG6lm2MZ
         13FX0pqqeaQev6/0FbCswCFF9LyI7YwVAX4hwwYvF7RTxlda8abh/ygYZ7HGJTElOZ4Z
         DYW1H3AMkaCZq1gZwpdkqEbqVHd7Ec9Jbwl7Sls1IIqD8ysuC3jHxD+z7vqyCPU0h9IC
         Rl2180sp9dlj6QtYl6Glv/kMrWlSVxPCu2wVPgZCGjUFYv5Trah15QuY6UiPwFRuqZ77
         d5Ng==
X-Forwarded-Encrypted: i=1; AJvYcCX38gza9h2pL9BTIjfL0JAfoqK9/U9fMIIy2fG3EXMXpfz/WPQXVyGClFCUFItap9Ldc49iOlakwF3w1rom@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ3rFxsbXJ6xbyiphBPgowEBXaTXAO3YgE4TS94NOlUj9GIAPd
	aGw7TVzcwY/vtoMDs3rdZcwPMcM+LrUk90I4FI8xPvvOBHMzNdeVRckwF0VLBpOrPeahhpMwSV7
	ykD6D
X-Gm-Gg: ASbGncutEHnIZYCcwH72KFhLxLL5qdvZQ386IMFPAst0piGd7cnOtclCDRBKPfjtES/
	6m4+UYkeHyhfes+PycIdaxBRMYLqZUBln0aAlnGTA6D4Axc7xvjteedEL53fMKyGpzn06WrmAA8
	uwg2loh+TtGACKrLcBjBso9/cBeMGjZAIquJgQ29E6X3z8yoZxyow7SPb+D8/qmFoeOMkyMpode
	vD+yL/OC/OugUQGBZwDNMkVHwnkGCZLY2uPp7eC7ChjGBMmn8rM7L2D7WeWZliqghm7NALbXNep
	zg9T/iznMy9OBx3wenDOmlbXQOL/iYLI0WJxK/WWkg==
X-Google-Smtp-Source: AGHT+IGMkJJMLPdEFg6uRpbkU7uGtHnNW+I6GL0eTPNLOTq4jnVPfrefdbYMjGrfNrKUcbXS0ta7rA==
X-Received: by 2002:a05:6602:4802:b0:867:9af:812e with SMTP id ca18e2360f4ac-86a23199d6emr3417519939f.5.1748013546762;
        Fri, 23 May 2025 08:19:06 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc38a5besm3615633173.13.2025.05.23.08.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 08:19:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: John Garry <john.g.garry@oracle.com>, djwong@kernel.org, 
 ojaswin@linux.ibm.com, linux-fsdevel@vger.kernel.org
In-Reply-To: <44317cb2ec4588f6a2c1501a96684e6a1196e8ba.1747921498.git.ritesh.list@gmail.com>
References: <44317cb2ec4588f6a2c1501a96684e6a1196e8ba.1747921498.git.ritesh.list@gmail.com>
Subject: Re: [PATCH v2] traceevent/block: Add REQ_ATOMIC flag to block
 trace events
Message-Id: <174801354522.1277456.4481051172399472027.b4-ty@kernel.dk>
Date: Fri, 23 May 2025 09:19:05 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 22 May 2025 19:21:10 +0530, Ritesh Harjani (IBM) wrote:
> Filesystems like XFS can implement atomic write I/O using either
> REQ_ATOMIC flag set in the bio or via CoW operation. It will be useful
> if we have a flag in trace events to distinguish between the two. This
> patch adds char 'U' (Untorn writes) to rwbs field of the trace events
> if REQ_ATOMIC flag is set in the bio.
> 
> <W/ REQ_ATOMIC>
> =================
> xfs_io-4238    [009] .....  4148.126843: block_rq_issue: 259,0 WFSU 16384 () 768 + 32 none,0,0 [xfs_io]
> <idle>-0       [009] d.h1.  4148.129864: block_rq_complete: 259,0 WFSU () 768 + 32 none,0,0 [0]
> 
> [...]

Applied, thanks!

[1/1] traceevent/block: Add REQ_ATOMIC flag to block trace events
      commit: 927244f6efff6df5f8f2ab58c7d1eec9f90cc3f2

Best regards,
-- 
Jens Axboe




