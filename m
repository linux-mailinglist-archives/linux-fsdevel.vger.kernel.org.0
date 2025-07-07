Return-Path: <linux-fsdevel+bounces-54177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6CEAFBCAC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 22:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DFD1680C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E64220F5A;
	Mon,  7 Jul 2025 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="eTIxVTc8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A62E220F49
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920782; cv=none; b=hlamFRu5yI3LMFQNLF/YxbKmQjUOTu4rCFcocaYrR2y4boeeDWW0VFp9VFxKh9TZwynYBOA627Mkn+r7mFOy0f5aBctT/VjWGWrg2Upixy7pId2KvEGFKGbRI2LLsOkhJovPfZMu3sHf1iLgM0m47Mj5qczkwSFmmq79fHFf8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920782; c=relaxed/simple;
	bh=DS0Ik4lCY6Q+xvJbyW4/tfkU5AzHV1B2sGMi5QtBO0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1yyLKnxHcLHBlarV02dHUz8sZ/5cTPqFxlKOxo/2ZEYmJd2qOZGUhIZ+amrfN1L3EkpWeuGg+DZp0NHXfMwFROv7NMOHemIqqHLVpjYPREdKolwWkO5q13swIQtrq3tuUBCTKwKHW3eWl/WoXeGZJK6UoZ0umpoJWEfPHs5ztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=eTIxVTc8; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ade5b8aab41so753003766b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 13:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1751920778; x=1752525578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wxneTq/NEhl6VnNWjnUkmFTXqxmN3JS5+IvNj36XqKc=;
        b=eTIxVTc8hYc5y5tFaRCM1TcOUi0i5U5g9sfFpeDy3uEYriUobPWV2jimNU5n5ZIuPO
         d4eUVFNsr0Lfoa1t9Dv+ucXu2BFmIlXWBJroX9cAJ7xAHkolqasLbmKC9TfOmUBysb1/
         CHXtxmnpL1VIKMs3+qtw8zEunLRN1mzhkqcU/7NBDsMfB+IVwlWpWwVVxJUSB1gaDK4y
         10eVy33W5RKQo7H07NGLVDAEDyNNSutVWhuQ9XFZeJE5A3ReLGkhQpZ4XUpZLu3OHOz6
         /CnKLfuLgWpg//MMv4EPDuHxu9p21WNuo50Y8FZzIAcNZDEGNyCR8AcnnuYPw9cGZMwp
         0WrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751920778; x=1752525578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxneTq/NEhl6VnNWjnUkmFTXqxmN3JS5+IvNj36XqKc=;
        b=j89aNr2ba9jDq2zjYRfroK5XXW45eZpVqpyj5L6cXTY6vXKRTho/R/g8eFBIsPxB8m
         x0MWfI+4uj203sKIccgPHoqOyZTsjrF/d2CZ1EfLNAlizchRTGVBztsMW2X33OaA0PLB
         BpLD5SemRhep6R8yguTvXg/ImccCnZ8gp1aG6myuMskHA+oXiX7zzrhrEW+s9RyPR4PC
         NlKmGZSnlQ7tdS/6FgZ+CzjeHO6ZSrFXU3FiPKG/0CMlF9EuT8v5VGYA4J94BIUz8aPJ
         f5pnZc12hf1s1xPUz9sIYolAqPxYp9uyu0w/GcR38fRHY6w35FGR11VA76KmyvV30/ba
         fhrw==
X-Gm-Message-State: AOJu0YxGndwW2FK+DAn/qI6KfpZd6JXfGM45fGuFs6tie/mRPtypignB
	jcyY5HTDB7k1hH9d5m26thc5iMuJqXnJ2e2f+fzn9wOjJJyOLIWP6k61kZqCDQfEOd9N4LEDiH/
	v2jfCxRRX+GgNgPgs1nVkHvU7DVfnpzf/ZyIlMUOjtY7h2QoK1xodzY4=
X-Gm-Gg: ASbGnculEpo40acaOjdXAgWlduSeQze0QHGH1Qd+84OxLV0C5zyDbg2xQmIeZ1XhSVS
	DSFuGCqz/NoJ9airwmWZWeui4xyzBYmI5GaVROV4XZwS0NK5KMZ6GS5fIEDKUiz14/H0nFV8amv
	0E85VlnXwg3wXIhq2FOutdeRE5W2RzSGAPgyPXH7G96VGj8TF1LVr+3leVWG/hw2Seg7U1oQM=
X-Google-Smtp-Source: AGHT+IFD0kxT+rxwBgYryZvBpViuuGbUUU+OvXDXcQVMrFJz/GHF0CiJmFY0JzIyqNJf2bDWYdHKYJMlmYX3uupYorY=
X-Received: by 2002:a17:907:6ea5:b0:ae3:5e2d:a8bf with SMTP id
 a640c23a62f3a-ae3fe5bde90mr1373459766b.14.1751920778431; Mon, 07 Jul 2025
 13:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124060200.GR38156@ZenIV> <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-20-viro@zeniv.linux.org.uk> <CAKPOu+_Ktbp5OMZv77UfLRyRaqmK1kUpNHNd1C=J9ihvjWLDZg@mail.gmail.com>
 <20250707172956.GF1880847@ZenIV> <CAKPOu+87UytVk_7S4L-y9We710j4Gh8HcacffwG99xUA5eGh7A@mail.gmail.com>
 <20250707180026.GG1880847@ZenIV> <CAKPOu+-QzSzUw4q18FsZFR74OJp90rs9X08gDxWnsphfwfwxoQ@mail.gmail.com>
 <20250707193115.GH1880847@ZenIV> <CAKPOu+_q7--Yfoko2F2B1WD=rnq94AduevZD1MeFW+ib94-Pxg@mail.gmail.com>
 <20250707203104.GJ1880847@ZenIV>
In-Reply-To: <20250707203104.GJ1880847@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 7 Jul 2025 22:39:27 +0200
X-Gm-Features: Ac12FXzvinwPocSJyMmR80b6ITnmJc5FsPq_b5MBTNt-hi1_HdEgvQERnOThAoE
Message-ID: <CAKPOu+8kLwwG4aKiArX2pKq-jroTgq0MSWW2AC1SjO-G9O_Aog@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Busy loop here means that everything in the tree is either busy or already
> in process of being torn down *by* *another* *thread*.  And that's already
> in process - not just selected for it (see collect2 in the same loop).

The busy process isn't doing anything. All it does is busy-wait for
another task to complete the evict() call. A pointless waste of CPU
cycles.

> The interesting question is what the other thread is doing...

ceph_evict_inode() is waiting for the Ceph server to acknowledge a
pending I/O operation.

