Return-Path: <linux-fsdevel+bounces-31736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE8699A863
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 17:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD75DB22C21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC990198E7A;
	Fri, 11 Oct 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ARJeQ+ZG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40453196C7B
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661972; cv=none; b=TV9SsPG/D7z8TtsMBPcrnQBejvSiKOdQQ/Rfw3RWNredWsRqfkGzPDox/rTf9pl2kxTgNGRSjreY+ijehJGztEdIZBLcusJG3r/P5jQlDBJ9Q+YDaxAEZ1Z0dlPzttx0TCR3vTAqC9RZsESmUjSAxiFvrigIU1kz0mzknPTyYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661972; c=relaxed/simple;
	bh=2cnpIpx2npZ2RcJMdl1om2QaNoJNOR0GO7VoLTyd3PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmjXMuYjloBhE6EsGSyOMwbVP0+Biu/x9Dfszoex92vyx9Af3XjHRfrCt6G19NW0JlKTDOGM0CCqwcEd1Ya2F2ObZHsXKXFWitm7w2+Dja0eZehdrNAqZEtSWaym/lQVgJTGk1sHgC9NItw0IQzGsMgcr7JViIPxqig3kG9CQ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ARJeQ+ZG; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fac6b3c220so34474641fa.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728661968; x=1729266768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CKbCfc0GSJHP9tDSJaE2Sqci6+zlP6d2qUVYjC2YJRw=;
        b=ARJeQ+ZG12H0vVt5jsmZC9KjhSroNqKV8oWpZ8cOrbAbEu/T7RmP3dO7cPa3vWQLn/
         gCyASBh4y6JS3+9F/tHXKu0UBUE+akBPsw4gsiE4Fsm1xbK7cS53RayCcgB6HuP7v/Se
         sy35Kzh1DAa8rcc29nsSVQ2mzy5zAVjWs0fwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728661968; x=1729266768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKbCfc0GSJHP9tDSJaE2Sqci6+zlP6d2qUVYjC2YJRw=;
        b=mk68STbKDUsUC/rqVBGGBXWz3lVEGq56RSb9T2VYsvVLkKwM8stLcnn8ZCuBivIt74
         rtC2Q4w/gwrKEqZes2uROmRrNF0cPfK8/xthi9yNztDuwMCp8KD0lImDISQCvbDDyz8a
         MpWQp5PcvdBXZHAMsDEwvlYlO/DO0Z7v3IJpa5zSSY+qXw6/SrfjRAF+ORzQDoVTXVJX
         Pgnz4zqpm+87F5/ikGlculIzOtVrdwRaMVh/HHGMLWJJsGmRfvunCVzOycTR6EXtqFY6
         IZjo9vcvwekMnhMM1CRmt1DSL4lNc5RdctWmdr8wfFvq6cizMGNiaEPAxX4EsJNxI10K
         DTyw==
X-Forwarded-Encrypted: i=1; AJvYcCXu7JxQEPhqjXW/ivF80Q5roCIKaXlaAtjR+BWX9xZSvdf/kVQnxWBtHMLpjQPBailhIYq5fRI68gyZVDjs@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRCJnPslJK5XEccWtqgVdhmqAnT7AH3P2dtpigyZI46PKtKL9
	vzYFTQozAwDnVcHOvwhbYhF51z1PF8lBdSru1itv030dRw+nNbwDjdMQFK8AnCaG5jrsRU//Rra
	+2Hl42itKIWaIIsPACU1sXHTqvaDC9qc4yifQLw==
X-Google-Smtp-Source: AGHT+IE5ypaAeiPlzEi3oHU8Y8cqAc8XraDYoYQ1xE4i6SbfplJ5kRLScOWnTlK7NqRHiXp9tOW+Vu6lYmpKsKKGKe8=
X-Received: by 2002:a2e:4e12:0:b0:2fa:dd6a:9250 with SMTP id
 38308e7fff4ca-2fb3f1b476fmr397641fa.20.1728661967999; Fri, 11 Oct 2024
 08:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-work-overlayfs-v1-0-e34243841279@kernel.org>
In-Reply-To: <20241011-work-overlayfs-v1-0-e34243841279@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 11 Oct 2024 17:52:32 +0200
Message-ID: <CAJfpeguO7PWQ9jRsYkW-ENRk6Y0GDGHJ6qt59+Wu6-sphQ75aw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] ovl: specify layers via file descriptors
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Oct 2024 at 17:43, Christian Brauner <brauner@kernel.org> wrote:

> The mount api doesn't allow overloading of mount option parameters
> (except for strings and flags). Making this work for arbitrary
> parameters would be quite ugly or file descriptors would have to be
> special cased. Neither is very appealing. I do prefer the *_fd mount
> options because they aren't ambiguous.

But the fd's just represent a path (they can be O_PATH, right?)

So upperdir and upperdir_fd are exactly the same options, no?  Just
the representation is different.

Am I missing something?

Thanks,
Miklos

