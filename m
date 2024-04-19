Return-Path: <linux-fsdevel+bounces-17295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774F98AB0AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 16:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FC9284579
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 14:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7F812F374;
	Fri, 19 Apr 2024 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="S1hEqphq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EBF12DD85
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536617; cv=none; b=Rkx+CY8mlWkpNanv0KjQPGNVe/YfAUr9Fjm+o3byKU5t61kxu+/kHVIvHAFpPHCX4AXrbXgBa3MaSSUmDzXTPOGdHJcJ3RtTpT67iS0CksK0fq7DR4+E/FBBfouc53FXjmCl87fH27hhvKR6q9z5bLeuISG3IEnV/ceNOTbk00Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536617; c=relaxed/simple;
	bh=z7LNFmMI2CnVKzK3GSStJwEhMqLU5/+AJz5kclzlLhg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iZstP0kXJdljBpODGNeknmDFjBGuOVivKwdHCkkgN/4Qo9erf+UOOH8DAAhfmzBqP77jIQRvv61Ib9R9LLMdz4ckktlJEO0WbohEaVqlXivO8DJns9MgwM9VNzgJOcErVHin1iwSDVPhiCTZnsA6RhzLoVc9ODr641j4iAfvuJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=S1hEqphq; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a55602507a9so248562166b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 07:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713536612; x=1714141412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bl4R5HFkhB+8HO5d3f2JEsdVUplHApG7HWomH51zC/Y=;
        b=S1hEqphqWaJtxut0TKl0vk7QoBXXVMs1nCK7rjI9TdOjDNXNA17ovvMM8iwXMlqht9
         0cAU6xTFoT3wOoadSfiFLJMxa1p4zdEb7aQwExRM57veKrbOU0RG6sXPsA5OpkROrYWu
         h9jo7q8SR/KnvF13lzMoZcpJf1Es/h1ZUs3TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713536612; x=1714141412;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bl4R5HFkhB+8HO5d3f2JEsdVUplHApG7HWomH51zC/Y=;
        b=RgC2iPEGYsIM8UTLzxO4GVT2NAx22AV/chFB89JYqqkuqva8jzIPJQmIZcWVy8Fagb
         Pfn9IK/lJBLtw3F2PjpkrYM9Y3jtXKXhG5j8Eq6pD0XfiOoQM5bzIoV7YfiyzLRLT9rn
         JuPKFHfyoJzeB1Z9VGQtFAzKOcL7HjvXvVZdcdA07n6Dypbg/Uo2VILhAIjonBpzR9iY
         5NES7iIeEZq+kNmOLdgZ9itGIoOVfy6QA2Kd7YsDpYGljph+Ml8qWjND9ea6HB7taw55
         ++6GDVMh6MCoHVBdjClLafRx0kLQpWgWtunmk69mMb3s+cYFgObgVwmovl5yTbpNJXu4
         ksUg==
X-Forwarded-Encrypted: i=1; AJvYcCV8gAVxp6G2tvbiIZEBpCJwrVZuSzd+sHLy7ZkAdc6yN/dSro/INTHBCqMHrYLW5pWIBXTo9m2N0jclplPkelAshUZNTpObjFuswxAenQ==
X-Gm-Message-State: AOJu0YxpIwlNb/dF+28/BM8+i0QRNYNB/GJxCP0EDk/qqMyH7+w39OZM
	oGQzrk8c+eiOpXtKL42Fy9lh3J2BDUFsG8pNaIm/pYnXjUOgIaZDDQ40C0KNeXilTI1YvaEjOo7
	j5ngemJ8XJNmGkF7wt9UiIXDJ1QFxYm0cC5+3DHbr5j8LwlXYlUQ=
X-Google-Smtp-Source: AGHT+IF1hURnYhu1wm5S8u0wEHKbjLZvjqJ882LV9gsu2D/vVtXBw6UhFEPfozOEl1JDPiqQWj2Z5qFarA2z1Rfz47M=
X-Received: by 2002:a17:906:fb86:b0:a52:143c:1901 with SMTP id
 lr6-20020a170906fb8600b00a52143c1901mr1649678ejb.22.1713536612086; Fri, 19
 Apr 2024 07:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Apr 2024 16:23:20 +0200
Message-ID: <CAJfpegvMf45cm=VQa35HdjM6=y8SeMojw8snnOjifqYjKbtM_w@mail.gmail.com>
Subject: [GIT PULL] fuse fixes for 6.9-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-fixes-6.9-rc5

- Fix two bugs in the new passthrough mode

- Fix a statx bug introduced in v6.6

- Fix code documentation

Thanks,
Miklos

---
Amir Goldstein (2):
      fuse: fix wrong ff->iomode state changes from parallel dio write
      fuse: fix parallel dio write on file open in passthrough mode

Danny Lin (1):
      fuse: fix leaked ENOSYS error on first statx call

Yang Li (1):
      cuse: add kernel-doc comments to cuse_process_init_reply()

---
 fs/fuse/cuse.c   |  4 ++++
 fs/fuse/dir.c    |  1 +
 fs/fuse/file.c   | 12 +++++++-----
 fs/fuse/fuse_i.h |  7 ++++---
 fs/fuse/inode.c  |  1 +
 fs/fuse/iomode.c | 60 ++++++++++++++++++++++++++++++++++++++------------------
 6 files changed, 58 insertions(+), 27 deletions(-)

