Return-Path: <linux-fsdevel+bounces-30848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B621998EC7D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 11:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37311C21DD1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010C0147C91;
	Thu,  3 Oct 2024 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="K5EGoVjt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A081474B2
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949061; cv=none; b=aS/htdDhOaU5e4OYUyoeJpV0xdqWYkXHxU3IkMez4hAJ/t1f2YfjlhmQ4MYPh+Pq/E/Q3rh6Jgkgr7j2++qXXtDF3tWjPDDGvto8QMjPaxdIBBUkm78UBem3QWNJ9HNcG1stPHX6mj3iii5i2HmSW6iOzn943+cvq2lcSCsEbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949061; c=relaxed/simple;
	bh=9E6f/uCDaDGHrcTPXLc5evKBv9bcT7mSdk4eDvg18ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLcKpVoegOhVmzQ5Nkoh0s+mBKRp7NeoQYuPUoeuHSnzGP6Kxv09c0RMjTJBMlFrBbZAErhPs+mlDBkKKGXq8z4fXHfUdzJvAAQnfaPUK71K/MyT1B0r8IUEUXLAOvJtg8ng81sW4JNLjiKq2h4ACqWovJS5K/QZ5Bc+aGo0pDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=K5EGoVjt; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c89668464cso883891a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2024 02:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1727949056; x=1728553856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kvtstig7vTzXAllV/rphN85fT9kacfaghzm/BxzXMbE=;
        b=K5EGoVjtkXIz3i6yo3hcLS6q2zWKTK3cujc7WHq2NePytRXtcOKVffjbAA1YRcyvbR
         flybQj4783AyCvlcPtWEYNt9E6OF4ldG9az3mulKpSsXJ5pzGoMYlNgVImtWcoqRn025
         WuO6/iRSgafJCHQFaE4r+PiBp6GC2ZQc1L9D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727949056; x=1728553856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kvtstig7vTzXAllV/rphN85fT9kacfaghzm/BxzXMbE=;
        b=LssaZeVXCN96iwqjG20Unjvdox+QJmTUEBJXxfAloFiU8mhy6XQllvXZ0aojQHcJ/c
         7KBeYWMVn515KvcVHe+DqPbrD0BjLDHcg6vx8pGH/VJD8zBoijpMuwEd7PR5e93J/GEa
         ySCLQAWzQWaxhBfTBWpZNbdN4Jx5lhV8/YPjemSqiJZjTlruINDmKo61B7wFrV9QLtwA
         co3lsusvi85kD0s6q6YTearLO1bLlS0+J7gJ+Q8+L69KzlcnNvSasPtalpTtdEyEKSvJ
         SxxnZjStnXlTExakeLW9qU2TOljw+IUjdEbH8tv1gwdp0Us5CmA9J7acsWNKdWmyNgDi
         Hspw==
X-Gm-Message-State: AOJu0YwKCFiLqn7R3JCNYlGGmNq0oFU2ca2RV36OiPOb3qZzWvEdOfy7
	QcRscSUNnq3nRgEQqXTLCZ3AUwxzL/gWVvaJSpegqda4fqKFupeSgX0PKNpqAkXkNAPkxzaoDNA
	m6Gs8n21NxLHarcJvRWKBeN/km96XdzF97+rXJR3RYA85/hcpxvk=
X-Google-Smtp-Source: AGHT+IF0rRHGX9VuxphY62DcQJ+nNNFpmW3Itz/RYpxgG1l1gW39u8hdXaht5Qcz+RWhzGLEz5QadUXFXGPMkKmCP64=
X-Received: by 2002:a17:906:c143:b0:a86:8d83:542d with SMTP id
 a640c23a62f3a-a98f8372af8mr562814566b.45.1727949056527; Thu, 03 Oct 2024
 02:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e3a4e7a8-a40f-495f-9c7c-1f296c306a35@fastmail.fm>
In-Reply-To: <e3a4e7a8-a40f-495f-9c7c-1f296c306a35@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 3 Oct 2024 11:50:44 +0200
Message-ID: <CAJfpegsCXix+vVRp0O6bxXgwKeq11tU655pk9kjHN85WzWTpWA@mail.gmail.com>
Subject: Re: fuse-io-uring: We need to keep the tag/index
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 23:54, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
> Hi Miklos,
>
> in the discussion we had you asked to avoid an entry tag/index,
> in the mean time I don't think we can.
> In fuse_uring_cmd(), i.e. the function that gets
> 'struct io_uring_cmd *cmd' we need identify the corresponding fuse
> data structure ('struct fuse_ring_ent'). Basically same as in
> as in do_write(), which calls request_find() and does a list search.
> With a large queue size that would be an issue (and even for smaller
> queue sizes not beautiful, imho).

I don't really understand the problem.

Is efficiency the issue?  I agree, that that would need to be
addressed.  But that's not a interface question, it's an
implementation question, and there are plenty of potential solutions
for that (hash table, rbtree, etc.)

> I'm now rewriting code to create an index in
> FUSE_URING_REQ_FETCH and return that later on with the request
> to userspace. That needs to do realloc the array as we do know the
> exact queue size anymore.

It should not be an array because dynamic arrays are complex and
inefficient.   Rbtree sounds right, but I haven't thought much about
it.

Thanks,
Miklos

