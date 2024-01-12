Return-Path: <linux-fsdevel+bounces-7886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A03882C5CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 20:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBCD1F24BB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 19:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4990215E94;
	Fri, 12 Jan 2024 19:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHKInoTS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531F16410;
	Fri, 12 Jan 2024 19:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9672C433F1;
	Fri, 12 Jan 2024 19:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705087019;
	bh=CUEpNXtIj3y2YghfDHeACDupq7CbR+GCqp5Oj2Kn0Tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KHKInoTSQcHD/QPi8oCP9sqJFNb7MY1iMt8aZaXwcUcKrLOtwHGWP8gCe0B6ZnvI5
	 p6MdbRI9WZ0EU4zg5Fps+KrDi4bWz/M1gLkYOp4e3Ou5332D4FtGstAYgjfggYC3Hn
	 qKud3prvJVCuRV8TMO1O0Xu15U1tv4jPFBAypq6CiqOyaDbLoxQAUjNILDEY+mXrFl
	 MuXzPvQJ4I6W6RsYMs3zVBvutQsNfobH8N2gH3tB/2TsuIaFesy5VWXuUHRGZIe0ia
	 SqVad8c3bOIpOYFW43f/bdYNExJOcGoM3xcVXbd7m3kJq4+xYkR3eNjojJAL6WTxOC
	 mhpS2qzgklhQw==
Date: Fri, 12 Jan 2024 20:16:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
Message-ID: <20240112-hetzt-gepard-5110cf759a34@brauner>
References: <20240108-gasheizung-umstand-a36d89ed36b7@brauner>
 <CAEf4Bzb+7NzYs5ScggtgAJ6A5-oU5GymvdoEbpfNVOG-XmWZig@mail.gmail.com>
 <20240109-tausend-tropenhelm-2a9914326249@brauner>
 <CAEf4BzaAoXYb=qnj6rvDw8VewhvYNrs5oxe=q7VBe0jjWXivhg@mail.gmail.com>
 <20240110-nervt-monopol-6d307e2518f4@brauner>
 <CAEf4BzYOU5ZVqnTDTEmrHL-+tYY76kz4LO_0XauWibnhtzCFXg@mail.gmail.com>
 <20240111-amten-stiefel-043027f9520f@brauner>
 <CAEf4BzYcec97posh6N3LM8tJLsxrSLiFYq9csRWcy8=VnTJ23A@mail.gmail.com>
 <20240112-unpraktisch-kuraufenthalt-4fef655deab2@brauner>
 <CAEf4Bza7UKjv1Hh_kcyBVJw22LDv4ZNA5uV7+WBdnhsM9O7uGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4Bza7UKjv1Hh_kcyBVJw22LDv4ZNA5uV7+WBdnhsM9O7uGQ@mail.gmail.com>

> > My point is that the capable logic will walk upwards the user namespace
> > hierarchy from the token->userns until the user namespace of the caller
> > and terminate when it reached the init_user_ns.
> >
> > A caller is located in some namespace at the point where they call this
> > function. They provided a token. The caller isn't capable in the
> > namespace of the token so the function falls back to init_user_ns. Two
> > interesting cases:
> >
> > (1) The caller wasn't in an ancestor userns of the token. If that's the
> >     case then it follows that the caller also wasn't in the init_user_ns
> >     because the init_user_ns is a descendant of all other user
> >     namespaces. So falling back will fail.
> 
> agreed
> 
> >
> > (2) The caller was in the same or an ancestor user namespace of the
> >     token but didn't have the capability in that user namespace:
> >
> >      (i) They were in a non-init_user_ns. Therefore they can't be
> >          privileged in init_user_ns.
> >     (ii) They were in init_user_ns. Therefore, they lacked privileges in
> >          the init_user_ns.
> >
> > In both cases your fallback will do nothing iiuc.
> 
> agreed as well
> 
> And I agree in general that there isn't a *practically useful* case
> where this would matter much. But there is still (at least one) case
> where there could be a regression: if token is created in
> init_user_ns, caller has CAP_BPF in init_user_ns, caller passes that
> token to BPF_PROG_LOAD, and LSM policy rejects that token in
> security_bpf_token_capable(). Without the above implementation such
> operation will be rejected, even though if there was no token passed
> it would succeed. With my implementation above it will succeed as
> expected.

If that's the case then prevent the creation of tokens in the
init_user_ns and be done with it. If you fallback anyway then this is
the correct solution.

Make this change, please. I'm not willing to support this weird fallback
stuff which is even hard to reason about.

