Return-Path: <linux-fsdevel+bounces-11320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2362D852A35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 08:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A542FB22806
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 07:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F90179A1;
	Tue, 13 Feb 2024 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjN0yzWp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B86417980;
	Tue, 13 Feb 2024 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707810338; cv=none; b=BcsXMCVDSKcSGlUV0I+82PgdhwnN+7FiwxaPIDTx6jpn1pKhuEifgDbhhZ2AVqs0YnHo6FBGTZPash/+pyyqPf1QGtAPxkTzFr5R3S+oJ7q8tziVP/ZqkoYy8GrjKOZt0KckzMqmRsFPJxTpTtXpQZ1MYWT9ps5UtGHYDhsqXfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707810338; c=relaxed/simple;
	bh=s/VnGkah36o5e86AM1uOTnVb660SGkn6WdUDvWapgLM=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=RRPRIxy3rktw6kSUIN0Q5pZrgjSdJnYGgOt0Sfpk7x0xtTrG07aEqxAGlseRcFyxMy82EBsHRHiko3Xpboi7AdhksMvkjp/DT11/biPthg0sW4cnrQDr/bghANbsj9PW5rw6gMv9sbAehVVXrJerNuFATi0EGMO+cFGBRa5P+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjN0yzWp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d8da50bffaso16641615ad.2;
        Mon, 12 Feb 2024 23:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707810336; x=1708415136; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lf6TU7R23fdwJeKphz6y3AoUlEwOvpYPP6zi5/0Y1Nw=;
        b=hjN0yzWpqs/SxzJFV3e/D94oUFEjib269EiJfwKtXgN2M8YUhmYoRpco8JxWG0ojNb
         J7SSdHot4kIggYJcLSztBp2xiUeIzGO6gJo+SYvDEzUKoMfKtmTcLcjTSB6vlPjA8tSw
         OSAH2+ebq6z61FaLb+0sB/e7CivFlxWCA/BtAxfGgXoOM3FBVmwPJvdTKrZJ3ln8FKog
         4EFUsmxYAa9T1c52cc0mxw8cbaXxB3MkmuZOp5N+g6OOQg4K9P8Alz9zRnyptUMkeBE4
         Dy3JzPoIU2w1HSuIlCQsFTt92OB94O2ReeDeTQOwe3aeZasfYzzVDKR/7CuRzYuLnYu7
         hvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707810336; x=1708415136;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lf6TU7R23fdwJeKphz6y3AoUlEwOvpYPP6zi5/0Y1Nw=;
        b=RMz2LwjxHKyL6dWHWg3iJ3xZu5s5hSuqe7NouqVJC/Ouiqj0DtoEJWr8EZ55FmUoLC
         lGmXzlpNI2KAXnPw16tRI0z/TKZ1ym5rTWx3ND2vYNa2zkCE/YtIHzjJS4XFnA8Slnpt
         dZJFlQeaa9RDKc7I1m9m9T4aoyQpZXRkoMM3BYlvd6yNCrr/il2wk6hywhp/XDJjxZR/
         D3QeAVIAYiUy2/IIBomWpquEPbQMKwDtHKM/paCTvUTpS695ynRovQyC+/qjBOrRzyuK
         sjMYEZibBGvydzJngNVNp3k+PxUQLNkr1TxMe/tX+R7kQuMKtLwPTj46hGZ02R6RYzgQ
         l9+g==
X-Forwarded-Encrypted: i=1; AJvYcCVPDgh0IsjLkVPg38jxXtgxlv8a/Duh9i0DVTqm3AYp3gyXqSPIE3QTs4sBoUHSmadK8DDift+s4B+Vm7FR33K60kdS4bz/lx8nuTuFv2guYMWzE/0Kke57ZlBJZ84BYeK+iupMAn3f079x2LLd2Axmt05N4boWrNMONtioN3ZTUD2sD4lx8w==
X-Gm-Message-State: AOJu0Yykvx9J4RpJCxmrhlN5ec6Kn6JYWi3DtiRpAe8/TGjkmFsLbK73
	N6kI9SC348RjIPLPtByEIZCxnLENnQ3FF2xCYPcNKSRAwfh8ba2i
X-Google-Smtp-Source: AGHT+IFB32NDcQmAPenodD0C/m/q3IvvehbB5VLqV5e/hF7bajsOzyb4m5wuvYgLsq7sKPW9KLr0pA==
X-Received: by 2002:a17:902:7594:b0:1d9:f495:cfa0 with SMTP id j20-20020a170902759400b001d9f495cfa0mr7908830pll.17.1707810336465;
        Mon, 12 Feb 2024 23:45:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWfCKAy0R554PZgy+jTF7bvQinwiK40SDfAd3dbexA1oYjayA5IhibOFUs1K03rNnFvwPrTQhFUbehdd538hbKeNbbBTEVGAqAEKCFnl4tp8DnSiIjke213xXJnioacFNU8ePiXU7ifNheBw3hjJxlCQiQtJDLL2SWXJ0lfrsMcLfN2p00QXwcfc2C9O2eaeqZa43W2m7mvH+13vSGTJSjoU43+VgIzSqLchJK3zKp9qLBkQa9sdz0JQf6+Mu6zq7ZHKbhu9m4jRkpOi2NZoMYBsBwiSviIEOkzjTaec6i2jYsl51bdKJtj4IY0h87vzu0UjBxui3X56FPTD7KOfZYU13CaXx8ACIzgqmAyu05pOTkQD1P0sLdHsdT87nPGcTjTJXDXlejFn7bmv+oC7cbDQ0OI0koXWn/ZziVB2AqnrNiOL/p8HvJ
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902ce8e00b001d7252fef6bsm1463926plg.299.2024.02.12.23.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 23:45:35 -0800 (PST)
Date: Tue, 13 Feb 2024 13:15:29 +0530
Message-Id: <87cyt0vmcm.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH 0/6] block atomic writes for XFS
In-Reply-To: <20240124142645.9334-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> This series expands atomic write support to filesystems, specifically
> XFS. Since XFS rtvol supports extent alignment already, support will
> initially be added there. When XFS forcealign feature is merged, then we
> can similarly support atomic writes for a non-rtvol filesystem.
>
> Flag FS_XFLAG_ATOMICWRITES is added as an enabling flag for atomic writes.
>
> For XFS rtvol, support can be enabled through xfs_io command:
> $xfs_io -c "chattr +W" filename
> $xfs_io -c "lsattr -v" filename
> [realtime, atomic-writes] filename

Hi John,

I first took your block atomic write patch series [1] and then applied this
series on top. I also compiled xfsprogs with chattr atomic write support from [2]. 

[1]: https://lore.kernel.org/linux-nvme/20240124113841.31824-1-john.g.garry@oracle.com/T/#m4ad28b480a8e12eb51467e17208d98ca50041ff2
[2]: https://github.com/johnpgarry/xfsprogs-dev/commits/atomicwrites/


But while setting +W attr, I see an Invalid argument error. Is there
anything I need to do first?

root@ubuntu:~# /root/xt/xfsprogs-dev/io/xfs_io -c "chattr +W" /mnt1/test/f1
xfs_io: cannot set flags on /mnt1/test/f1: Invalid argument

root@ubuntu:~# /root/xt/xfsprogs-dev/io/xfs_io -c "lsattr -v" /mnt1/test/f1
[realtime] /mnt1/test/f1

>
> The FS needs to be formatted with a specific extent alignment size, like:
> mkf.xfs -r rtdev=/dev/sdb,extsize=16K -d rtinherit=1 /dev/sda
>
> This enables 16K atomic write support. There are no checks whether the
> underlying HW actually supports that for enabling atomic writes with
> xfs_io, though, so statx needs to be issued for a file to know atomic
> write limits.
>

Here you say that xfs_io does not check whether underlying HW actually
supports atomic writes or not. So I am assuming xfs_io -c "chattr +W"
should have just worked?

Sorry, I am still in the process of going over the patches, but I thought let
me anyways ask this first.


-ritesh

