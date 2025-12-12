Return-Path: <linux-fsdevel+bounces-71187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CA2CB8180
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 08:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAA16300A6D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 07:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9711E2F1FE4;
	Fri, 12 Dec 2025 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DjQO+RCJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D6118DB0D
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765523883; cv=none; b=CBFEq6WQSDWLptNEoCY7ds1VKglsxbPUGdtZ3jfXOYJhsCx9zqXHUhLZI2L0DR8Nx9mbx7DUXtLtIi4QNNYDCAlzpw4RStsYovkTGG9pH57Q0zMBdZhHA+a8wJRxpeIfbpzilrK40FfwOPLk5r5v0LPQvjx8ThiQhdnDuyfSOY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765523883; c=relaxed/simple;
	bh=+4ePIountn2ibvDxRejkul1NwuIToN+sW3r1DqNGfi8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R5XIX5YlGuDBp4cpD5vRe4BH5bGEW21vSLYBZnQj5hCKAzuzJLX4h8mcesHjUkdDLIYSCngZ/jNLNPPXmPzlR/a5Ay9rdlR0mRvQgcX9jN2LE4wxhIfUBSaLxXorwIS+Ii+3O8XGuYI+ZN+k3brjzLrsUPZvEmHLNAnQRcv3yzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DjQO+RCJ; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64306a32ed2so982921d50.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 23:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765523880; x=1766128680; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YDFj3cPL302Wi6J3PzLOOSoxJj5lTq2UhgS864Dd5n0=;
        b=DjQO+RCJ8wRkd9OmfxaBpAKNv1XccvVYOD5F02WYniwloZihvJKG5iTZ2nQ2QrmGQW
         GyOpjBHUk4C5NMMYUaB162OB8NRTKqwdbeDKk4UQntsIGxJj+fOdzI09P1xT9RWzBAO4
         HoBEoqGTl+69dKSplUcDM8Oz8bOjnpgp4sGqgRm5WTgzMt0vjjGY66P89QmV3zBm9e21
         ArXOiFEXDW9Ly57NWRc2YksLrnYR5cJwJUlLhOqyrDCuyiikvCokPKSYPUyFSAHrD7aR
         wIA79O7+75N++3cbm0f3+B7jSiNjgTASAALdaFXkkF3qO6ylqTRyf5qRuMSPaqesQNp3
         TB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765523880; x=1766128680;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDFj3cPL302Wi6J3PzLOOSoxJj5lTq2UhgS864Dd5n0=;
        b=MjdOlWZJWLzSbSKAPRcIziRuxbWaAWVRxI2g69K/Mz0scKJ0Z8YrCdqXPtfr55P/sA
         tOwu44G7S+kXTIoi1RB8vnQwFYMQC8bFkJEippdGf1YmgVF03RTLM+YOVFsdC3/GR1k8
         eABSydnI0VpZN3qEoOGunCuANFw5t13vGf7qQxgm4EYPDrLEdqfJFGSt1pCNENnJBJOB
         pYatwHHHfeRuBojsIxExqBUDcaoNV3+4k+zg6tOSdlhLTwmineYgUmirCaL3lgHhMnQY
         t2PVN/kcmLYDbhGuem4VtQ09uQpeRy3rDR/+qf2NUg13nNU+wF6FnjOCxHG/aivz+zac
         SxMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4n3/lvCrhben5MOPzq7SRXoTX8Hnu5EFI1g0H3p7ZZLoNmev+so9GC86rPkZVRFdiIuaS3M7MqeYbUjWH@vger.kernel.org
X-Gm-Message-State: AOJu0YwNrgvnwavL5TC1w2a/fVjKxbEhqBf5zTNbJEA1fynqdRaplY6a
	pJgv6jOrDwMgCBGbWRasKzfAduL2hzpyWXu1UGvGcMhqc/SiMBNNks4RWpyJ66IhfO5kwizPoXC
	RQ1SthQ==
X-Gm-Gg: AY/fxX6Z/hzEq1ZqkIAA5lf5brh2JekWNrGHDtjwh0bxpCYfJFGgYp0y08XtfAE4GDv
	l1diYR4oEmzB2EEYwYsN1dYb1JXN/yJ6VYfOkiXZpvP7BHn2g3JxSN8kMqgIN0czHNsqneZVzkS
	st/dGm4Tg9YPb16S55OwJEvBpHDcIsjV0jFFmwrSnjKMwoaoHs6cO7WJBhmSltKmDo8Gypri1RV
	A485V+0kxdqUrjQVA/HZjp9lSzQSX6QuLdc7pPVJcXnLombTmBm/nPBDCdobXisT7fcIyJH7vYS
	8zGk9+6WCXoux1wug0hiOOjR3NqwsAE7YngC4FHa/EHHSShp3X5HUafFAOM9LsipimEI+YMGML6
	+cqDButNIhbea5ZtdKdLaVxXI41egXRTRjp3puM/r23em+Swj5nSErMjcC+nr95Y8ex7V6UTedD
	dMJ8ZIlkixK6bS93nrmADksAHiP76DTZXfeFk9W2v/WlRTBf4WueQXcCL2RBqy/pHqSOZ1088=
X-Google-Smtp-Source: AGHT+IGJLiDo6r3v6q+Z+SSY6LmdyLiyTa7Gl/o2vswo9LxewapmGPoaY0Ik84Ee5aPVmK+e9T1+JQ==
X-Received: by 2002:a05:690e:1447:b0:644:7398:6677 with SMTP id 956f58d0204a3-645555cdb89mr688396d50.11.1765523880218;
        Thu, 11 Dec 2025 23:18:00 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64477dab9fbsm2184061d50.14.2025.12.11.23.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 23:17:59 -0800 (PST)
Date: Thu, 11 Dec 2025 23:17:46 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Al Viro <viro@zeniv.linux.org.uk>
cc: Hugh Dickins <hughd@google.com>, Christian Brauner <brauner@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 6.19 tmpfs __d_lookup() lockup
In-Reply-To: <20251212063026.GF1712166@ZenIV>
Message-ID: <2a102c6d-82d9-2751-cd31-c836b5c739b7@google.com>
References: <47e9d03c-7a50-2c7d-247d-36f95a5329ed@google.com> <20251212050225.GD1712166@ZenIV> <20251212053452.GE1712166@ZenIV> <8ab63110-38b2-2188-91c5-909addfc9b23@google.com> <20251212063026.GF1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 12 Dec 2025, Al Viro wrote:
> On Thu, Dec 11, 2025 at 09:57:15PM -0800, Hugh Dickins wrote:
> 
> > No, sad to say, CONFIG_UNICODE is not set.
> > 
> > (I see why you're asking, I did notice from the diff that the
> > case-folding stuff in shmem.c used to do something different but
> > now the same in several places; but the case-folding people will
> > have to look out for themselves, it's beyond me.)
> > 
> > (And yes, I was being stupid in my previous response: once I looked
> > at how simple d_in_lookup() is, I understood your "hitting"; but at
> > least I gave the right answer, no, that warning does not show up.)
> 
> A few more things to check:
> 
> 1) do we, by any chance, ever see dentry_free() called with
> dentry->d_flags & DCACHE_PERSISTENT?

No.

> 
> 2) does d_make_persistent() ever call __d_rehash() when called with
> dentry->d_sb->s_magic == TMPFS_MAGIC?

Yes, both if shmem_whiteout() does its d_rehash() and if it does not.

> 
> 3) is shmem_whiteout() ever called?  If that's the case, could you try
> to remove that d_rehash() call in it and see what happens?  Because
> that's another place where shmem is playing odd games...

Yes, shmem_whiteout() does get called.

And when I remove that d_rehash() call from it, 269 476 650 and 750
complete without locking up.  And when I remove the WARN_ON()s
inserted for 2) and 3), then they pass.

You are very much on the right lines!

Hugh

