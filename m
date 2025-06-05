Return-Path: <linux-fsdevel+bounces-50757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E63ECACF506
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 19:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4EF1886BAE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 17:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED11276045;
	Thu,  5 Jun 2025 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRPf5dKz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD513D521
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143354; cv=none; b=lMXk1fQgh/nAgLrcSU+dZdtAqDHiQYbNZ78CCduZ3GW1hXvo5xWIEhJthP7UJgedrjtAwApjVXdeatVeZMpgGalka6yasStpD+lDju9i1UfIWesbMTy90cVJoNm4vsVqUbYOqc11lggnfeStN2dQ19L1gG+u7QIfBdhQ8eu+E8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143354; c=relaxed/simple;
	bh=J7AxQAZ0C6ZiWD2LwYZW0QFFdbFf8ZkmooxoSFzysO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nGWOZLydW/9V+mqvFOTpThm6IFTR2NGb+l/94jN4GOptt5256sJD76nttndbp6p0d4+T8qF8RZoE1woXfieUzsg3OgJQyKvMJuZ1fBVkkrfQHRRDMYngIJIrSZVSBYJNBn5dL2SMsBVq9CNn6OutbLFlc9U/MJYxwddzVKISESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRPf5dKz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235f9e87f78so7367535ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 10:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749143352; x=1749748152; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXK+NIAKEQji4wcxO54nm5AT5lDPq0nwVxeAkWuOYog=;
        b=MRPf5dKzDX4/59uCRE01UFToVIVLa5Jmz/kgqec9TQ/Soddxy39tEJ+dofpsPPipvD
         shZRY0zC/CMvbESXDGczK0JDfhNcKd+P+9dsCmVdFhIo+MVBegKjaS+HoQ7tnbf53cLi
         3vMPG/s0inDSPXfgmrHZTc3MGn7SVxqYT84Dc5e3sVq6ycuOEx+fUy+qS+7GnyjGptgk
         5JfS/afef8cv4dVqj0WBfhESBiBbvB2bu78X8MUmc7PM5KXH2vaG4umHSCa1GGzRH2nq
         /HIv/td746HOxieqJViPsGNZhbNfkldy3sgFVCMXVfrkRwbzee3VCIEnONLZ7pkti9DT
         HuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749143352; x=1749748152;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXK+NIAKEQji4wcxO54nm5AT5lDPq0nwVxeAkWuOYog=;
        b=CkNJpZtcK3Q7ccgNymlPaJ52WII4y1uRA+0JkHYs/jmXhQdl+n0yjkHtoGByd+NhBk
         xzpCYOVCsgKbZ5Uj5xMMldqwJp+M6VnK20tn/FT6pCkQkJdKk4gr23zIPwb7auZKX8jc
         nP8ZY3j1q3hyU7xoVG+g8pjXm85d4oHz44u9iMrnoKp9KsRW2RKlEPU/YV6UbRrgMCyc
         axxootMBbuACQ1rEmCacgH1DP3S5LZjDQVDeEQq/LfqAozloibLv5xKwWRBLKn35i/B7
         Dg0CMvsqI+gNjEZRnDBuWyAkjw6Z1hn0WduuqvOZvOHilQVS9fdZECVLyhb6ifqrRxDO
         tvAw==
X-Gm-Message-State: AOJu0YwwB/roImJkIl8HLGiXWLolBKkpI8vgJXvlyxfACjqqU4wSVATo
	5wAdDc2hAfKwdXgkv50ytxo8LzDBNX/F9FISuYNDCVtMUAffwcSRXxEJQ1vwsg==
X-Gm-Gg: ASbGncs6ZZZtQCQvc8vGQXWOB0EYfmanxp/+oeNwQfd/KRbEtUB5dnYjMlmZvINU3GJ
	3Wmf0gEH2U6FcBRvBupH5OYln1+qW6/1E1WTjSiZ1toKpFVy9QF/U6PCEVIhiuYSI1wxUDkSJOS
	nPx1Z80QBcbK0Oo18ckaB0Evvlq98kVUhU3ANjGn5usFtp6cuKRHAoPu4R+Ty4n688vpz3X7Ffn
	eCcxGWcVOHt8Rb3LAj6A+nOD6FilVce8p/NJHT/zrZvoJ5dPgR/YnqbUWOn+CzaTGZBx1q+aCz+
	DU9h1opzDzZHuPmKs2hgW5+ixX3CD0uFvyij/iLOhy6Lkcgq6HypUXYwEv2kRRGFCwrl6rtzfq3
	983O+VlpwdX6Y00EKfX81Hjm5NMYL
X-Google-Smtp-Source: AGHT+IFiezxp4QGD/Fg2gWKD+LF68+byB/rbwh0AWOLL5A4IQ0SGT3v++fi5OXV9Scz2Uyp1OUMWgw==
X-Received: by 2002:a17:902:e890:b0:235:e942:cb9c with SMTP id d9443c01a7336-23601ced1e1mr2318975ad.5.1749143352381;
        Thu, 05 Jun 2025 10:09:12 -0700 (PDT)
Received: from XTHCYRY1WD-Collin-Funk (redis-162.tisch.gvad.net. [207.135.66.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bcd56fsm122165515ad.48.2025.06.05.10.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:09:12 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,  Paul Eggert <eggert@cs.ucla.edu>
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list()
In-Reply-To: <20250605165116.2063-1-stephen.smalley.work@gmail.com> (Stephen
	Smalley's message of "Thu, 5 Jun 2025 12:51:16 -0400")
References: <20250605165116.2063-1-stephen.smalley.work@gmail.com>
Date: Thu, 05 Jun 2025 10:09:11 -0700
Message-ID: <m1wm9qund4.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> commit 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always
> include security.* xattrs") failed to reset err after the call to
> security_inode_listsecurity(), which returns the length of the
> returned xattr name. This results in simple_xattr_list() incorrectly
> returning this length even if a POSIX acl is also set on the inode.
>
> Reported-by: Collin Funk <collin.funk1@gmail.com>
> Closes: https://lore.kernel.org/selinux/8734ceal7q.fsf@gmail.com/
> Reported-by: Paul Eggert <eggert@cs.ucla.edu>
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2369561
> Fixes: 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always include security.* xattrs")
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  fs/xattr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 8ec5b0204bfd..600ae97969cf 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -1479,6 +1479,7 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  		buffer += err;
>  	}
>  	remaining_size -= err;
> +	err = 0;
>  
>  	read_lock(&xattrs->lock);
>  	for (rbp = rb_first(&xattrs->rb_root); rbp; rbp = rb_next(rbp)) {

Thanks for looking into it and the quick patch.

I'll see if I can test it later today.

Collin

