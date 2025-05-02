Return-Path: <linux-fsdevel+bounces-47901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4E8AA6C63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 10:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A321BA4FFE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 08:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8051F426C;
	Fri,  2 May 2025 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUyud9VP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E228828
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746173870; cv=none; b=b5hJ8rOYC6FnbLKOF11BtQgJwpTCKNkyRUZ7i3XNGeEyDuLYItYi46rgQCYXbL3CBDRhSdjuLJzcspmDQFnVboBRS634u4TLFzNRarFVqC3Wa7gs6XhbNSf3Z2kZJD3ZuWsrDNEHN0WV4AOXOe8MmzwvzZVcQZDyigNlWsx1eqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746173870; c=relaxed/simple;
	bh=uUtde6FLSqIRIUjkxrKfbCbR7EcIoza7yfWbHlcAm0o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UeMdkf9HkaUYUGk8KeSPJTQgm5oQ0SuEXSyOImT4ER8yBQZ/FZVEqGpCk332BtB4XHtMgPbQVcQhaKcIQyCBRxGl5ZgbFVyP9r1Nq3YJcpJeA+OzNyEecxeIYDUmKXdTBkA8Abrr0+Uq97QpGdUlJMT+Hoqzr7faUa6B6f9cpoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUyud9VP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746173866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=nVQlT567fRkdg68ZomwjxZQGPU8NbKasYEQg8bOfVjE=;
	b=QUyud9VPhnkYoeqzCKfdxW8vmnXJUrI4n8o2pE54fbMOyF8rsrL8QqcnNuKibdOUdse/2y
	nQPczeNse5Z1ti4Ukpg8DaiwQ9sNJQEiSz5accaBBdJQIUuRcDZOLzffdjZAD+o/tgQ4yO
	smZZbDZwV2RJjFafDJiY6XCoSyvo9UM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-fyDgDekOO-OKMEy2Qd9jPA-1; Fri, 02 May 2025 04:16:24 -0400
X-MC-Unique: fyDgDekOO-OKMEy2Qd9jPA-1
X-Mimecast-MFC-AGG-ID: fyDgDekOO-OKMEy2Qd9jPA_1746173784
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3fe246005c6so598934b6e.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 May 2025 01:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746173783; x=1746778583;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVQlT567fRkdg68ZomwjxZQGPU8NbKasYEQg8bOfVjE=;
        b=ogV4bCWL6OX4ERDg/F3EhhRZFFodkmAyH7TS6zSKr4eLtI4SaZb+j8abOliuDM6fSd
         CoCxzh4E7NxWtOJYHM7RliAcLgDKsk7HwjP8w/m8JTnAs1XErjCrygdQ6WQc8/zXEFXl
         Xw/GIkk6LUS2GuJ4yzs5/AfK+lxCz2Kegp2pqgULdbRZTSeikPYzKo1Sox8cU36Y1BOC
         2MLBLaDIWI8FB19V3vQ+zbbi+YbfSYWgGcqKABcQvlV9AMBOpWsQptVyT0Wc7Gq5pKjC
         yyl56HaLW1Ms2CT2euFiQ4v8rASTGVY2D9h+6XkhrR4lEl42t4dT0QfMotdZQ2t0/4Rf
         xHQQ==
X-Gm-Message-State: AOJu0Yz/nD4bvOiX7JvebZbHZKIctinx+VEQ/e/hVtPT4JFteLHYn78r
	VE7KNdSFOH2WQJyIQW35ccWuILkaYZstE+EgijqLEfo8PP4Gi3AHngXpSRJEEwDeMPnfUg04jV/
	CHbja12hl4VjkFA5xdMmey9h3lrtgr55sAApsb4JncM30GcnGvbpFzyS3hUbXh02TZyCxuzs+Hw
	8/t9slUZDL5cFEa+pcF387VnvFYe6zp1Xjcy2WLHxH26pfdwnr+iA=
X-Gm-Gg: ASbGnct7nK04hiTIPMWuXsUrR5FJyh+GFg6SuvLpz0h8PEv+1SQJyBCA5Vxv83T2ywf
	kYVojbBMM9J4a4e5deihByipcdN/Rp+8g9nHDv3g46EpU4PLgzBF+/RB3Bji449wnZeeIMnjzSo
	D8J9ustul3fZorvV0Qngzi3to=
X-Received: by 2002:a05:6870:8983:b0:2d4:e96a:580d with SMTP id 586e51a60fabf-2dab2fe2bc4mr856917fac.16.1746173783714;
        Fri, 02 May 2025 01:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXtKRXkJxW7DZbCb/1AwwLKDWp4IBf9QqVK1RkstrGTSL1AfAlAm50tM21B5YK5zU/V1qubqdvD1PPoMYAUMk=
X-Received: by 2002:a05:6870:8983:b0:2d4:e96a:580d with SMTP id
 586e51a60fabf-2dab2fe2bc4mr856910fac.16.1746173783387; Fri, 02 May 2025
 01:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Allison Karlitskaya <lis@redhat.com>
Date: Fri, 2 May 2025 10:16:12 +0200
X-Gm-Features: ATxdqUHt3A8gyOfuYcnBrdn_xykN8UHYxESrWI3EYlpe-5GNKHLYHnl8S4oMQ7s
Message-ID: <CAOYeF9V_FM+0iZcsvi22XvHJuXLXP6wUYPwRYfwVFThajww9YA@mail.gmail.com>
Subject: CAP_SYS_ADMIN restriction for passthrough fds
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

hi,

Please excuse me if these are dumb questions.  I'm not great at this stuff. :)

In fuse_backing_open() there's a check with an interesting comment:

    /* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
    res = -EPERM;
    if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
        goto out;

I've done some research into this but I wasn't able to find any
original discussion about what led to this, or about current plans to
"relax" this restriction -- only speculation about it being a
potential mechanism to "hide" open files.

It would be nice to have an official story about this, on the record.
What's the concrete problem here, and what would it take to solve it?
Are there plans?  Is help required?  Would it be possible to relax the
check to having CAP_SYS_ADMIN in the userns which owns the mount (ie:
ns_capable(...))?  What would it take to do that?  It would be
wonderful to be able to use this inside of containers.

The most obvious guess about direction (based on the comment) is that
we need to do something to make sure that fds that are registered with
backing IDs remain visible in the output of `lsof` even after the
original fd is closed?

Thanks in advance for any information you can give.  Even if the
answer is "no, it's impossible" it would be great to have that on
record.

Cheers

lis


