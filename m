Return-Path: <linux-fsdevel+bounces-43677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65684A5B3B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 01:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B5B3AE62E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 00:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B308438384;
	Tue, 11 Mar 2025 00:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SExDGCDh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF05E2CCA5
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741653189; cv=none; b=kO0EaQ2rcH2g53X9jESGQN3w2wbILVgYA5SJPdLEbytXvNk1PU9C0Uhwozhf0BroYjNgtN7ZQWbheVixC8iNrfdZkaYfvyb4FQuFiFCbywAdvMK3Je8C2z0b+JcpVNlU4ONJauZGnIhLo22uE+UvpZou2g2a4pobBeJu/GHJGEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741653189; c=relaxed/simple;
	bh=VzdRAXVoKVmLJqAlDJYWoY9x50Z3i8HiRWx+ZRrGixY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHUvjPISDrsIVztmLA1MxKMSB0yvHagGbdFDewa+2U9qJn4/73071wqhLsX/BpDCmJmAtbFjsjqnMvaomtbIFCizLvDHO85GVBCMZqeWqf12qGMY4TbapBiEW20IvSMC5lGgbRLCwlA0ttF0SR/d6j58QI1fBkY0OdIT4OgPHzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SExDGCDh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so5014672a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 17:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741653184; x=1742257984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M+NqzMzHbZXk+h6w4tXrOYz6KUMPIha1ekpgVhvukzY=;
        b=SExDGCDhDAwDHPxkBCRwHPPew/+etiFeqF+FaMIAQYYxAGHcf85wfuu1GP+TZkXKBy
         oC/8r6z1rY11EoFeXmesDLPgEw067D183mGPu4ilJT1v0Tt2GFHYepjnhcsGW4y4ENn/
         59pgZh0bmSTpKzpJyj9zwFNlOqFajqQvM3A7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741653184; x=1742257984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+NqzMzHbZXk+h6w4tXrOYz6KUMPIha1ekpgVhvukzY=;
        b=Vb3OqtAFmDG+2S2HN+I1bQpQRasaa+ZV9LdX/MJ05kphs0Ne7nCd5fqN932zqY7Rjv
         vRStCW4upvR2e6KxELeqUY/QJOhCJSf+hFy9mTSHB6dQT9uqHgojUuOMyWGXhxPyEO58
         TVKXas5vzHhpQIcTCuLY2njC/AUqfqiPNSZzNCFRrkqhhswiNEydz/97xs5XhToPP6+X
         UjW7r/cb1WxFOQrE5xPGnIqyFBzamrweZnPQQfVWYF/ICbeYzUcyGPZ536f5Pp2jwESg
         qFo6pzb9JOI57mqQaWP1kM3LsHaEBL8WhfomS08KJJptoPCCgZiE6BHSSHY8KAQ4Ve1w
         XZJA==
X-Forwarded-Encrypted: i=1; AJvYcCVa5fifNhxBjtNTMG5rEPjcEoyS5Sm1UfYauwZtN4TtagPoTQ9oBLVeg37fuxHcKQ2RdSo+rhWOLi6idV5F@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg8JhK3LMLv7EYQY29VN1bDnpMVpo838b1POGtN4ThucgSAWuf
	0JkPJoZiKB2CJBTlDTe03ygI9KLXgatXBTM3sSzo45glSXL1XtCJLxZfpX712lkkBP1H7pqPFgp
	EEYiHLQ==
X-Gm-Gg: ASbGncu0v1Zr5GyCeNxDE0DLGpmJK/3OkiV5xgIL0RW+m4pvSC1o3t8Fhq7agwrSI/y
	iXpoGjPwfXd+QEcdIANBP22aEfhvVs17gxvHRXNcZjSWoQMM53jNoRGmbHdrenAtquXWxARbuiM
	LSPnTk4UMjK3PLhZH0i+A6dTdNCcN3pjBct5iPD1lYBNYM7eip74cAWz7YI7mNsf9a7B3BbtKtc
	0/1JIMeCIpuI4rsYSi75DxhNjO/hCKzn3bdN3O3quUzg09DHxCgqbqkrk1AGUmuhp/BXudgDL3m
	EgfwL9QE/5EazWjy25EUOFmYaqoJbvLe8a9z5uMYUu4FHLhDgxkyl2NT1WootQky3TDHFSJU7cU
	X7MKHLGZGF6POq0hU2TShzFVjJVOo1w==
X-Google-Smtp-Source: AGHT+IGi/+UMGeVYnjf7rBY4+aEJx2MeB60GP1zJCdumosDdLeUKBVfmhs2E+nDPbnrHioNVO5m6hg==
X-Received: by 2002:a05:6402:2683:b0:5e5:c847:1a56 with SMTP id 4fb4d7f45d1cf-5e5e22bd1b6mr39867080a12.10.1741653184048;
        Mon, 10 Mar 2025 17:33:04 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988b64asm828714766b.155.2025.03.10.17.33.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 17:33:03 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-391342fc0b5so4119451f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 17:33:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJckLGnP0UIHhk77vrFKjGFoNcgz6Oalp1W+IzkpYgVnUJ1NkIJcWxp4rzlsgaDxMyRgMuY7ov2XKSWsyS@vger.kernel.org
X-Received: by 2002:a05:6402:4617:b0:5e6:17d7:9a32 with SMTP id
 4fb4d7f45d1cf-5e617d7bb68mr34370545a12.18.1741652794918; Mon, 10 Mar 2025
 17:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304102934.2999-1-hdanton@sina.com> <20250304233501.3019-1-hdanton@sina.com>
 <20250305045617.3038-1-hdanton@sina.com> <20250305224648.3058-1-hdanton@sina.com>
 <20250307060827.3083-1-hdanton@sina.com> <20250307104654.3100-1-hdanton@sina.com>
 <20250307112920.GB5963@redhat.com> <20250307235645.3117-1-hdanton@sina.com>
 <20250310104910.3232-1-hdanton@sina.com> <20250310113726.3266-1-hdanton@sina.com>
 <20250310124341.GB26382@redhat.com> <20250310233350.3301-1-hdanton@sina.com>
In-Reply-To: <20250310233350.3301-1-hdanton@sina.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Mar 2025 14:26:17 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj6TE6axJzYURaq=zv2UNjm6ikRqN2HKgLHHRpB9XnEAA@mail.gmail.com>
X-Gm-Features: AQ5f1Jqtj243jyxEZTOcRM5xlgqlawFKyahf8z2U2YCV0F6kMW5dTuQ-rcMhxww
Message-ID: <CAHk-=wj6TE6axJzYURaq=zv2UNjm6ikRqN2HKgLHHRpB9XnEAA@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Hillf Danton <hdanton@sina.com>
Cc: Oleg Nesterov <oleg@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Mar 2025 at 13:34, Hillf Danton <hdanton@sina.com> wrote:
>
> The step-03 in my scenario [1] shows a reader sleeps at line-370 after
> making the pipe empty, so after your change that cuts the chance for
> waking up writer, who will wake up the sleeping reader? Nobody.

But step-03 will wake the writer.

And no, nobody will wake readers, because the pipe is empty. Only the
next writer that adds data to the pipe should wake any readers.

Note that the logic that sets "wake_writer" and "was_empty" is all
protected by the pipe semaphore. So there are no races wrt figuring
out "should we wake readers/writers".

So I really think you need to very explicitly point to what you think
the problem is. Not point to some other email. Write out all out in
full and explain.

               Linus

