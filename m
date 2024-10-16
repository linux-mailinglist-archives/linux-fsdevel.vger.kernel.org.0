Return-Path: <linux-fsdevel+bounces-32082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 920B19A061E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 11:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26C89B2524A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 09:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23488206060;
	Wed, 16 Oct 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="A9Y+L3LK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4716E206054
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072315; cv=none; b=ByWCqZ+Jpk1QLlsUVmWwDpdMKIUjFocTfvNxSZuLub8ThOunv12ReHdHNQOE/FPqLECFnB32Reg6gG56VC+QHyZ+vtJ5XXBF3PDUMSapV8GiLn/Qx2uFcR9d9in4dCXy2gCJczvWGZSMhElPlVFRekDuTSwmghlOWscVk+iKqzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072315; c=relaxed/simple;
	bh=dPqY+sjIQvnEOuf74ppt6P7PRxHixJJvbBJNbvoN2w4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoMe6qFFelKeYTUlWnGHC04+YJoYEmjr3SRg4NO4TNqjTSN+ZA/l3nkEOHtjJfKQLcql0f5DKtMczUdbOPxUgbOBZGzmhZu1S4AeUhAJRZBiO2gLgfBBTrxOkekg9Rl8KWFIhwZZlIZ5h4By1Dvzzui/7uORSmEZ3+q8jM467dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=A9Y+L3LK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d495d217bso5693998f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 02:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729072310; x=1729677110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jTE7u8o5tI0FIkTxmDK+qnKrh3RskOoSkXunWZSYvDA=;
        b=A9Y+L3LKoU0YceugbCZNesXYxx6ugsK+vMccbHkWteXh/urlMa6AAXCACQrEHmhnid
         ivGDuVTK6GyHm5SbYpx1CnnVmQ7zsFg+tr8AINhHwFWFZAZskSLBHFJPE2aUkRRsu3cV
         UrgoVV7ZNh/T0l2fUe45cc3JdDQ96pnwC/YZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729072310; x=1729677110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTE7u8o5tI0FIkTxmDK+qnKrh3RskOoSkXunWZSYvDA=;
        b=tM/CPXJjX8M7FXpcBb4HV2zsmQOY99T+lsSXZgd7pV1KuE0SVzUc3KJXm7G839VnkR
         XskkBVCxrmxNCnhjWklNNsw9ofUK8h62V4XdhSVoIR0eQ4I+LPqUMcQBRJOZq57ByCW+
         kiPCS1wowCP0zaj5Nv1sia2jtvnpSYeig/lA9/Zduw2a5Q3UDCcwnuIfTNvg4jrXnxhS
         CK3aY3rMTFrOiBJAJ7mOQ30QMJZYUIVSAtePd2AIzhOlnIU9aS3TArTYvGfvsJHvwPg4
         wPbstVh0xfoqGa9QMi1G9N+WUoVChYpWbP2HUN1kvK6O6dV38esr5RKdac9MgnfvGmlV
         8QmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvdhYMPmq5DpZg039ESrz1X3CPbH2z7YMBXbT+w+eQi1XkZHKHlZ3VcMUz6yjGBm6Y+ybvtYcePRWwKhXQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyXcOn+t6RkhEIN0QqBIH+Kyn/d7AXnHabDj9GhwSB0HabhJrkz
	gfTifCB8FmYB+EYNAaDmmULQYis17gkx7+6TNVuga8zL3DHjAKQW6YxXMgoLBk0maCTSzq6JV4D
	eAFHbPQl/9Y7q9QxA+nqRnKScgJG9tM+/w2LOlw==
X-Google-Smtp-Source: AGHT+IHJimRU7kA9YKF3JTgoDD4uf700fxLLUhA7uSlebDcZu8rjEvIaflwjR+RPRB/FnozQr6QSjw50ZEua6MqYHRA=
X-Received: by 2002:a05:6000:e4b:b0:37c:c832:cf95 with SMTP id
 ffacd0b85a97d-37d601db8b9mr13236270f8f.50.1729072310441; Wed, 16 Oct 2024
 02:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com> <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com> <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
In-Reply-To: <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 16 Oct 2024 11:51:39 +0200
Message-ID: <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 21:17, Shakeel Butt <shakeel.butt@linux.dev> wrote:

> So, any operation that the fuse server can do which can cause wait on
> writeback on the folios backed by the fuse is problematic. We know about
> one scenario i.e. memory allocation causing reclaim which may do the
> wait on unrelated folios which may be backed by the fuse server.
>
> Now there are ways fuse server can shoot itself on the foot. Like sync()
> syscall or accessing the folios backed by itself. The quesion is should
> we really need to protect fuse from such cases?

That's not the issue with sync(2).  The issue is that a fuse server
can deny service to an unrelated and possibly higher privilege task by
blocking writeback.  We really don't want that to happen.

Thanks,
Miklos

