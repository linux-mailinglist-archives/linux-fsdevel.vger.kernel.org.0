Return-Path: <linux-fsdevel+bounces-43889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCC6A5F0C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 11:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892B9179B14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 10:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BC2266591;
	Thu, 13 Mar 2025 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BM2GBNYK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E2266585
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861506; cv=none; b=Vle2XmzTbcUnxh3+iTYECd3x8Fuf3X0znbS/4gav6Tu7bLbKQKNCbk9k1rvn1FrEcujb20cSfTk7hX3uyrT2qN4BNvgxpbuigD60Shrp3TJDYRcoTqgyEfRkjF/FDoAJyvbnycmCVFZcJXOYvH8nh/Wk5O9hxf0NW9J7wyrILDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861506; c=relaxed/simple;
	bh=8E6umR10j1rENZETug8Dvg2uUuaAmIVEZ7lWr0xEUcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxPAKuLjkmXXe1++y+YxB2lAicNXNuTpQ9aSphkwEFQretj/7UOkAJ/0b+ZBZiynf6OmHB4nztx6RcIrhuI591EVvVLT4W6MjZ0qn02JRMmtM9Mnee/dXbhd/MOyCDi/YGL97HUGHgVxxAFGnK9OQO3YVDns4Ek6ixN+/1EXDFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BM2GBNYK; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47686580529so6788451cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 03:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1741861501; x=1742466301; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fJhgDmPv4xBV5PkF1YNcGYxiZv3Gvw3+dAdLt1/aqVg=;
        b=BM2GBNYK01C01waNLwyT7DJ/iUp2nqNVVHfgWggSuRM/YOuCkZ2y/rTlNhUi0ePMaZ
         WChuCapG09NW93nCEdbx01p7w1FGxaakl0vIs1vRXywAFIQ1nnVafY0vCBS0W0uvD10E
         R2Bk1QuNQA7YIfvwujdlB4CdUnhKy9g4Kp6Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741861501; x=1742466301;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJhgDmPv4xBV5PkF1YNcGYxiZv3Gvw3+dAdLt1/aqVg=;
        b=rS/ADFOaS0tjRppL9g8Z/qEhz6c9clY9195GwDLVeCRbFfpS/STAVO7HqpEXonzMcc
         oMX8I7RXdFqK2J5WdAaxTTCuPvmUtxjBaRvLJNo2rTs6Nobh1mWkOgC9pwmNZVppKQp4
         DdaEX06btdQ7jsLhn0iE4coQWjtzSbuyXZOXGvC+AtXIlfQY+w5KL5n7L8JkXa7aI5Km
         jdQWQrp0SeE1lhbkbaoA+B5ATkrhVFSSk12o/kFsv03h6Fs+uwp25wrZLA3+z+Ze/wtW
         5G4ihs3li/BdKiJV/5heYP183v/dOio6+y5kP7Ek1AEFBgAKkrucZtV6j5wEqGx/Pti6
         xRHg==
X-Forwarded-Encrypted: i=1; AJvYcCW058zyxAmB96IlHWcix3mg6hdHVXB6L58nVvBWRP2TkZ5qqp0FgLN9WKEp1RjDHevQaFi+HwGfQWjRJb1o@vger.kernel.org
X-Gm-Message-State: AOJu0YxofcDIkDn8kJQmFhlu5nS0liA6ru7ZRTvmpNHkfwM7QvnvC64M
	5iLO0/0ssIl9DOOEI7Wf5x2m661Ri+p6Y437EX13NUlDTDntFWw3REMLqfj1KIYSYIoiPrsr3UP
	cOJVgf4wJGDShPlkI+Ay9mjRVpXtyE6Ww3zaYXA==
X-Gm-Gg: ASbGnctRbcXC+DTBbkBk1Ncz6hAZb/qQqrMxVpUBQglwyzA908oTPTqRMmmgsqT2PHW
	TK4S3E+84R0Py6+on84DARz43Q9VSJBnGGKb5Ca/7UKksmUXnYfCdJwy1NoSAc7t/0aqGQVbWDm
	hJwEZpJjyx+xFcJO03/KBq+O0DaVh2e3b2WNdC
X-Google-Smtp-Source: AGHT+IHdTEwbvkDm0m+4tqN3e2+RcDe0QvKRnYufGZu9tB9rQzpkkt9gHNhJBwNlIq6VgZJwrE5aV3eVmfIOrbHnPQ4=
X-Received: by 2002:a05:622a:ca:b0:476:b858:1f2d with SMTP id
 d75a77b69052e-476b85825acmr39382321cf.42.1741861501656; Thu, 13 Mar 2025
 03:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226091451.11899-1-luis@igalia.com> <87msdwrh72.fsf@igalia.com>
 <CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com> <0bd342bf-df71-4026-8d26-2c990e99b40d@bsbernd.com>
In-Reply-To: <0bd342bf-df71-4026-8d26-2c990e99b40d@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Mar 2025 11:24:51 +0100
X-Gm-Features: AQ5f1JrpbbkOvwOTG9jY5aBl6NEjKVs91x3eB4o9jjaEB8N7vTieFquCBJjS7Nc
Message-ID: <CAJfpegtG2PS0_moONf_ZmLncv1EH7HtC_8ZYxwkEiGZy4cYZaA@mail.gmail.com>
Subject: Re: [PATCH v8] fuse: add more control over cache invalidation behaviour
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Luis Henriques <luis@igalia.com>, Bernd Schubert <bschubert@ddn.com>, 
	Dave Chinner <david@fromorbit.com>, Matt Harvey <mharvey@jumptrading.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Mar 2025 at 21:11, Bernd Schubert <bernd@bsbernd.com> wrote:

> Can't that be done in fuse-server? Maybe we should improve
> notifications to allow a batch of invalidations?
>
> I'm a bit thinking about
> https://github.com/libfuse/libfuse/issues/1131
>
> I.e. userspace got out of FDs and my guess is it happens
> because of dentry/inode cache in the kernel. Here userspace
> could basically need to create its own LRU and then send
> invalidations. It also could be done in kernel,
> but kernel does not know amount of max open userspace FDs.
> We could add it into init-reply, but wouldn't be better
> to keep what we can in userspace?

Two different things:

1) trimming the cache: this is what you are taking about above.  I
don't think it's possible to move the LRU to userspace since it
doesn't see cache accesses and also does not have information about
some references (e.g. cwd). This can be solved by adding a
notification (FUSE_NOTIFY_TRIM) that tell the kernel to evict  N
*unused* dentries (valid or invalid).

2) cleaning up of invalid dentries.  Dentries can become invalid by
explicit invalidation or by expiring the timeout.  The latter is a bit
of a challenge to clean up, as we don't want to start a timer for each
dentry.   This is what I was suggesting instead of an explicit
shrink_dcache_sb().

Thanks,
Miklos

