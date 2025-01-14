Return-Path: <linux-fsdevel+bounces-39198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADC5A11446
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 23:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C68167B73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 22:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F0D2139DA;
	Tue, 14 Jan 2025 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+LsTw0J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE9220898D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894541; cv=none; b=lFJ/kQoOlCKrJvIMiCd2F9k2ppMWhhlGS0wT9mgd8vFr/ijZfKaT+h1RYOQQQzJubh0yecEZO1u5P11YIwNIUjnjuDfVOe3laPy35fvkXCUdlBnZnEuMS2k57g7hjmygntTCMieZkXh+3lOnsUzaP1CM1ZKi+ffkflCmo9R77m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894541; c=relaxed/simple;
	bh=Xs1dxq2fGPPYtaqU2IDeyblBvS5L0xhG1gPyp9lfs+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfxfddBlIkb7seJxjHGScZORtxmq1irtRIzOn8cgsHvv/xsZL4SDTaA3OSAO+HPSM8aQbNkQIIBOOb/wrzrZc9r9eKb/9MZ8Eu/cihxRa2SBL/WWL62E6FUOVAOleHxGkXiy68YYuQgDyNUkOFlQaY1PUzElbZwf16WEzFG9c3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q+LsTw0J; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2163affd184so209805ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 14:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736894540; x=1737499340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=swMA7a3HQZ6EnlfLP67EfqYFg1OFOpUwx/BZEKqDMMM=;
        b=Q+LsTw0JnP7LfO47eHwP/JYC6wxNJsi/bb0c1zF9xc3guZzqRj+M23ZdM+nT22T+i9
         h9nFLY3B8AD+paY6wZ+//ObxOZWfEmY+ObBSs7quoUmuD457gBCWsEt7LmUxPSIDnzB8
         DAo6+KM+CzDcy3DkuZLrxAtE58jRI6GXOk33U3TbjvJmyEBijcabXDVNimxrSMIJUds4
         Ocf+7Y8DdlVtiNvXEWePO5xDE7O835QK60gzjt7PtwfNvBxflK9kFmQkMsYYave72+0G
         OcJKEqw3u7gw+fmsoUexq+wnZsO9I/ttvk2BV8dblljgqLzTQkdMD2Rl7ZbOR0ddDeye
         s9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736894540; x=1737499340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swMA7a3HQZ6EnlfLP67EfqYFg1OFOpUwx/BZEKqDMMM=;
        b=WgbjgE4bpk0BNepAtEMQ3kDLJb47kCCmBw2eIsOotf9aFQrixMCrnI2ypowAyr6mXb
         6QXLyUN6EqbQdCoxJY5FBRgHALrbumcBG3qW74FJfvgvALn5Qr4ZqJth3FwN0Akcwq/a
         z1h3W/ZltDezqCh1l+yfam9ycfPnS5irO5LN4fCmHefWhtXxG+MbfYj12B8dTNQeQjMf
         F1wXUqrteKdc9yPLty700ND1ddHUDSUftAF0CE9If14KfmRDI00xWLMVpNBpydXd4yP6
         4kh0JweZwrCRtRTT2kJdO3uP/NPoLXqzx5SLLKfHAlYn5LzDKRwc3T613556RJjqRClD
         Jp+w==
X-Forwarded-Encrypted: i=1; AJvYcCUpmjV9EfI4JM8I+Nk2d/gaKoH0YI6tycMnAz/R0oMHgZ1BcUj4p0CCGRTHKD2lR4pcdeC9iHio6VzEEeJv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6I9B7ZXNbUW9Ek1VFgCn2ADTXXtkl5ei7/Uzl+NA1P5iBm4Eb
	KwVFwGCZz3ZQC4Pi1Z4w43BvurOc/EXWLqTMTGcMgC3tQkK3x/bh5aFXtMKXgg==
X-Gm-Gg: ASbGncuKcI6FNHez4hM+Xj1pwlJbJAejN+AUQyNFKdqjfcJpVXydTZtJm+dM+fO40Ca
	fyUobhPP1Rs9j+BbdtCgiSYBJYeKyr3uL/TYChhhIn/jaBEL/n/eoE+wSyXhc6KJ5ngOuXYO79T
	vVuAiVBekYK91aMSPMFd1QJx8WFNoDnPC4M3MUkd2ghoA1avszP+5J932ZwQPRXZsN5Wa+0yapQ
	jNZFFVJZTXyg8zheMy43+CPyA+IfQj2f+I2QrwfDgR6KQUTFHSh1s2+Mg==
X-Google-Smtp-Source: AGHT+IGoegfwlqw2q5WVfOTyFF4JK79h9BcAugnc0Xv9CPqMRMnAP3WIacvl0pdW6tR1pdom6vRMig==
X-Received: by 2002:a17:903:48f:b0:215:44af:313b with SMTP id d9443c01a7336-21befee6a7cmr867865ad.0.1736894539639;
        Tue, 14 Jan 2025 14:42:19 -0800 (PST)
Received: from google.com ([2620:15c:2d:3:5f58:5aa8:70b1:12b6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a318e055feesm8811734a12.30.2025.01.14.14.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:42:19 -0800 (PST)
Date: Tue, 14 Jan 2025 14:42:14 -0800
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Kees Cook <kees@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
	kernel-team@android.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	John Stultz <jstultz@google.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
Message-ID: <Z4boRqW9Gv57GDzu@google.com>
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com>
 <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
 <CAG48ez1gnURo_DVSfNk0RLWNbpdbMefNcQXu3as9z2AkNgKaqg@mail.gmail.com>
 <CABi2SkUuz=qGvoW1-qrgxiDg1meRdmq3bN5f89XPR39itqtmUg@mail.gmail.com>
 <202501061643.986D9453@keescook>
 <e8d21f15-56c6-43c3-9009-3de74cccdf3a@lucifer.local>
 <CABi2SkV72c+28S3ThwQo+qbK8UXuhfVK4K=Ztv7+FhzeYyF-CA@mail.gmail.com>
 <Z4bC1I1GTlXiJhvS@google.com>
 <202501141326.E81023D@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501141326.E81023D@keescook>

On Tue, Jan 14, 2025 at 01:29:44PM -0800, Kees Cook wrote:
> On Tue, Jan 14, 2025 at 12:02:28PM -0800, Isaac Manjarres wrote:
> > I think the main issue in the threat model that I described is that
> > an attacking process can gain control of a more priveleged process.
> 
> I understood it to be about an attacker gaining execution control through
> a rewritten function pointer, not that they already have arbitrary
> execution control. (i.e. taking a "jump anywhere" primitive and
> upgrading it to "execute anything".) Is the expectation that existing
> ROP/JOP techniques make protecting memfd irrelevant?
>

Is arbitrary execution control necessary? Suppose the attacker
overwrites the function pointer that the victim process is supposed to
return to. The attacker makes it that the victim process ends up
executing code that maps the buffer with PROT_EXEC and then jumps to
the buffer to execute the code that was injected.

I don't think having the ability to seal memfds against execution on a
per-buffer basis entirely addresses that attack. Can't the attacker
craft a different type of attack where they instead copy the code they
wrote to an executable memfd? I think a way to avoid that would be if
the original memfd was write-only to avoid the copy scenario but that
is not reasonable. Alternatively, MFD_NOEXEC_SEAL could be extended
to prevent executable mappings, and MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
could be enabled, but that type of system would prevent memfd buffers
from being used for execution for legitimate usecases (e.g. JIT), which
may not be desirable.

--Isaac

