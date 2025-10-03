Return-Path: <linux-fsdevel+bounces-63415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB33ABB8539
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 00:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A01B9348F19
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 22:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E129627602B;
	Fri,  3 Oct 2025 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PUKIc59B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1145C275B16
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 22:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530706; cv=none; b=eIgY0LSoDCT7TkyzNXG+13wQc0P9nDvuQYW8LHFgTHJXUOG2IP1OuOK8eqHQsZQfpAotfqP+t7K13IhqIB+mVmLQbpkCi4d0hV09PQsKXzXJnURqwBL9qc6JS/37Roajly8GQNmrbSC5+fJFJx6/+2feZx+5dky867a/Y7VP2mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530706; c=relaxed/simple;
	bh=VS33BNFgRTESYybs2GpN/LJYI2/xJwzVvqMvSGy/PBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1/J/6eWRezt1SfoG2hUkz+X72ZKQ5xikHMj7lX/EFcraFvOHUx8HG/nPJ9mIuTAy0gQZL5pyERdIo0cJFmaz66HT0iDZzGI2IyEUtppUN2dWE3YdIBEhK/+JD5AfjYaWAkVDPlfIdxmDYkz4brdvM9cCpILrA9zhMM8QZjz7rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PUKIc59B; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso5623213a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 15:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759530702; x=1760135502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MAKmPQNlXCGxdE2EH2ZWnLv+RHeolnck79An1P1bDWM=;
        b=PUKIc59BLxp0/pDFOzL3SOd+xf9DSSFqnNQ8lo0/8mKn21giOXFTMBnTUocCLVN4h7
         pTyXx1XN6I8rnoaLLCq6lzrr7oYTbHjkINEShUCkfCAqkV2/hRyAj7Lo4m+lZzFH/1Df
         XvTnmjf/YusfYZ//v9yF6d/ES25s77Y7DPnB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759530702; x=1760135502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAKmPQNlXCGxdE2EH2ZWnLv+RHeolnck79An1P1bDWM=;
        b=UqC7pHou6qa4ZHE4pCkCCISCddBjAizAwqkCFvxA6RXX86UCX6EKxupk4/WEP5qdOA
         tPuARDZUBQ6TJNQ349zREvlHiB3GG1zv41A2yB694MhdYXXw7gC+RBuPBofm4ru2S4PR
         Da+MJRm7cMG+x9lVG85Minz/+ORcSkWIUiqwgf+Qif+ItnyxA0/NIRk6zBaIFqP36aWF
         CSIiu5Z4iApePnsoSLi/6WoEBR2QSiadrjZ31vQlvsLJeyiU+U8JyWCcmr2GsnFAnUhE
         BaVHXm7CXEXs5QJ2sxF0pfRzPGe+fFptqm64B+zLuCyi0lfvUNNoGxCYn8MKFJUVjbNx
         AbhQ==
X-Gm-Message-State: AOJu0YxFaERsVN6NBm0zQ/zSWN1otdVufyeH0oODMXsgkdrzcPu4wM4g
	z0tbNAGEDFhEF83B9KFxh+BSIFMS8cs+eHCMm/7BMxWrJSiT2lCfDxm01tvWxVb3ofwqIYbvKNc
	tA+3UT1U=
X-Gm-Gg: ASbGnctu7e+nlqAUlWjv/LZ99t52O+jgToiHYCd1fi9UZrfNrq2kLn9OqWX5kX1S3u3
	ZhvFDbV9mfOWzPYCEqDDnJw2xfvbGzrHStxykaEl4g06l6jRAifJBW901uhfBFtUcjK5xXQbg6H
	rOTm9BG8t6D5VJAdzMTmI7dQdHLKmeGznVhfZK65+Ii9H2iK5UXlSskeGxIRqovGtAoGw5zakiJ
	vPe9RDxoxNFKPoXVyX2W8U5oz9goDUMq3/CuKUfiIFMAyyplcNXAsfPoRe07Ds2TpA2utD/OxxL
	65K7ZE3i+I+lawCFOW6Agz/V4HPt7LvU+V8wAOmCJHnM1dGCkevUxfpCFZGTbTlEU9upvbn5Wd8
	HyZUmb771dapLCXJ9ITL9bfzSJSAJWBpdPBPKgYXq5YBkTH+5YTHFKxRwpL7X9IQ8GkCMorIcz9
	akc7YbS1Jj3tW3lFPGnPGO
X-Google-Smtp-Source: AGHT+IHuy2Iqfe0MwyKCUzJO3kI602wS3AOJeEpnbQuAyedlBzmUJ4dsbUrk9pnwPSFBdp3Uech4XA==
X-Received: by 2002:a05:6402:34c6:b0:638:1599:6c34 with SMTP id 4fb4d7f45d1cf-63939c24f04mr4578892a12.21.1759530702212;
        Fri, 03 Oct 2025 15:31:42 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b78a90bsm4870347a12.19.2025.10.03.15.31.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 15:31:41 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6364eb29e74so5546091a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 15:31:40 -0700 (PDT)
X-Received: by 2002:a17:907:944b:b0:b41:c602:c747 with SMTP id
 a640c23a62f3a-b49c146ca44mr563103466b.7.1759530700049; Fri, 03 Oct 2025
 15:31:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003221558.GA2441659@ZenIV>
In-Reply-To: <20251003221558.GA2441659@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 Oct 2025 15:31:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXC6mo5rFHbqsvJeTjjmw=PeoT9EfSE6KmL21Giej7MA@mail.gmail.com>
X-Gm-Features: AS18NWBciXrwCCJ9MXR64vNDovQv-gQ77u2qIRNRv9Ko8NQC31QgzexDCznuiNo
Message-ID: <CAHk-=wjXC6mo5rFHbqsvJeTjjmw=PeoT9EfSE6KmL21Giej7MA@mail.gmail.com>
Subject: Re: [git pull] pile 6: f_path stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Oct 2025 at 15:16, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git pull-f_path

I see the branch 'work.f_path', but no such tag. Forgot to push out?

           Linus

