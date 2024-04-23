Return-Path: <linux-fsdevel+bounces-17485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75BD8AE10B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 11:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489E71F20FC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 09:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8833E58AC4;
	Tue, 23 Apr 2024 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="d2ek9O8K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9958AA1
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864726; cv=none; b=bTve56X/FGz9Ei1cVsLLHepj+22q27dMcqNM+7h7g/vTaLgJZnvM/yuPMuXF432n7CIu6UOPlMOLTGhEaZ2XXwI6lzm0I+27MoJXovijXezp/ceXWpToxZUH+Fj4kFarTz37pt1tFXKn6AsXakcgqqPdzW6M7mqE06WAOezZ5GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864726; c=relaxed/simple;
	bh=aWGB3swA+Jg3uLhcV6Osy7Xudy4Uf5japuCRCXXNvJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o535aa5GsNKVmCzQNWXi33/zTsSHOce70I2IZHGMr7TPSzOVHdi8xvcH5GGp0ZfwTeOYx08hffC5RbiBGUYHR96jeDAWXfRx4Gp1awZsDLrOQlQgDYIws2Kcdjnxdqwicv43ZkG5IMfDoFIGrbBHcbUi2B9OfDqo2ctLBe9HD/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=d2ek9O8K; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51addddbd4so542635266b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 02:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713864722; x=1714469522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45lBnYkiVFlhp4xqLP07lTCWuATovrc0olIkkBfyt9I=;
        b=d2ek9O8KvvmElABvVqzDK1Tb5abuNuZ5n9ZtPaGxrVg6feuWRnfDMBYTx23UXI3sxE
         51v/2F5pY3pW7EO7sfqLpEEVvt3IXPNUjkJ6wVqa8bn/3fVXJ9A8VA3h7K6jqTWcyGeA
         EWX+H9tOpjfP8iNHDA3gkjZtLUNpJYZ73UU6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713864722; x=1714469522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45lBnYkiVFlhp4xqLP07lTCWuATovrc0olIkkBfyt9I=;
        b=IyhcHkHRfFs7Yk6oMpqq2U8JWh5gu1ISAh4AyWJLajeBmKXnCF9CzPYe8nKWG0YS2w
         gGSOw4VBBQo2R8Gacjg7R+ZGrtMXCgpYlwmfYx3PqVsckg8vLdEzL7MnhjAtSLUtojl+
         pe7MKvvCGh87B/++edGbNKNaWXP+vcBpIdlkxuh0yV9Mt2ZQc9uGftY40Iq1oDONXNvw
         /G/5/5T2Do7vEsRBjz/HJSjDWIPDouKIM4I586uXN/Zv8t1VjPCY5qg9BQV1U2fm/h+7
         hOFInApcBhDQbIuf+l/MOZmE2dVwW+Q0qRJcC4ZJ9VX9rSpwqTAFTK5cOMPMW3K1ChNT
         miZw==
X-Forwarded-Encrypted: i=1; AJvYcCXkqUkkC5fLVv6TXQEplA05D1JDy3seG8ckTPvjHvbHhVO54KvjEZqnUTeEkNP5EwStV+rgAQ/yQefBi2ufxl7M/I2fYzFK7Mw8qd6r1A==
X-Gm-Message-State: AOJu0YwlFtIq2YCcrouGz1pd/PkbiDxBUIYbGT/uhSjqvPhKZT0a+4ay
	lEG6Pe3vjwR8Jl42P+iK9qtoObGDnEkjWldkKuzh4LTFvz0P2tHA4Rjbs9DbDIz9j67YZwHyDqi
	/0m4eddi4GHgktZoNtt4g6Oa8jYH+WKF0G5DpcxMRHjGP3Kmtmdw=
X-Google-Smtp-Source: AGHT+IFPPPbj6Qq5tYBTh7saCUA+yKXKCPNUl2woFYzNbUaAx5TT96V3GVhi3xN1cJu6INSeLRog0Vj3jc2KEP5oJgc=
X-Received: by 2002:a17:906:dac9:b0:a55:be99:60d5 with SMTP id
 xi9-20020a170906dac900b00a55be9960d5mr3559679ejb.23.1713864722153; Tue, 23
 Apr 2024 02:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328205822.1007338-1-richardfung@google.com>
 <20240416001639.359059-1-richardfung@google.com> <20240419170511.GB1131@sol.localdomain>
 <CAGndiTNW=AAy8p6520Q2dDoGJbstN5LAvvbO9ELHHtqGbQZAzQ@mail.gmail.com>
In-Reply-To: <CAGndiTNW=AAy8p6520Q2dDoGJbstN5LAvvbO9ELHHtqGbQZAzQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Apr 2024 11:31:50 +0200
Message-ID: <CAJfpegs=J5x_0DfiiXcEtsRxkoVq+ZGv_FhxFo9Vk8B++e_P3A@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Add initial support for fs-verity
To: Richard Fung <richardfung@google.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, ynaffit@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Apr 2024 at 18:31, Richard Fung <richardfung@google.com> wrote:
>
> On Fri, Apr 19, 2024 at 10:05=E2=80=AFAM Eric Biggers <ebiggers@kernel.or=
g> wrote:
> > It's a bit awkward that the ioctl number is checked twice, though.  May=
be rename
> > the new function to fuse_setup_special_ioctl() and call it unconditiona=
lly?
> >
> > - Eric
>
> I'm happy to change it but the benefit of the current iteration is
> that it's much more obvious to someone unfamiliar with the code that
> code path is only used for fs-verity. Admittedly, I may be
> overindexing on the importance of that as someone who's trying to
> learn the codebase myself.
>
> Let me know if you still prefer I change it

Or move the switch out to the caller and split
fuse_setup_verity_ioctl() into two separate functions, since there's
no commonality between them (except that both are verity related).

I did that transformation and pushed it to

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next

Please verify that I didn't mess anything up.

Thanks,
Miklos

