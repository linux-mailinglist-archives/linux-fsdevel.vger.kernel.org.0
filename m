Return-Path: <linux-fsdevel+bounces-71192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB6ACB8974
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 11:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E2D5302083B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 10:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CD22EBB96;
	Fri, 12 Dec 2025 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ddzcjvSN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67F9315D28
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765534359; cv=none; b=ZcqNre0AqGBMm7nPGbasZrRsyriy3cOOFLObspNo8kGsQ+0E2MzxM/YrRgabiAoAef0cq5LPio+SisRnBz7nEEfzA4VVk3yX6rVt9XY9nLcuKPCbG7a73nQg0hS9/fLjh7mfp14ePsbzDyIY3sRCug3bqJDxUK7Moj23+byer2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765534359; c=relaxed/simple;
	bh=gzQjeuzK8OvsG95sV2x0e18zLLQ1/JQTFC2nyRSpltE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OjXYQeVZNG1FF8qI9l9YpaZIsI8mC+q02jAtVgX7laD3Dx6hXMBAfwUpkyokFPBNyZI9pDtV6Se8aDc+TPH2/pnCW+Z/1jDWSyrDGJJgHWUdiVHYD/E2cxvc13Cm73FTJ0+Xa/uZprCL2LBATDr9a7RQ24JflARaT2gjtxEgUjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ddzcjvSN; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-787df0d729dso8849747b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 02:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765534356; x=1766139156; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tyiWj+teLSvOcemqfQ8kWGe8XZlNZ+qzMwX7g7wGHpA=;
        b=ddzcjvSNzCDvK3aJt9L2zOcCD6TCcs5Gk7aEzAcVX2Asvo6Bk7vG4EKRLCr1AVLrlT
         uGbaO87d6bWQtq2a//UzHdN1B+Ct7YeFAuICF73hlOF7yP+cQbutYtbCUScu8LmX44ra
         NkgfKuLgQWTlA1ciG34Tph9Yua1OapgDG3iI6I5I2wsuuwzcU+R/yf5sGAKCP6k6VnC1
         qepH0m6MqgpscwM316GEqSe/n75rrGF4RT9t2Wlf+ISGDJ1pHYlsRmi85wc4CkS0ATTX
         tdYoP97095UtTpn36MxCw3RVlFcq3IfLUqPRhd6rMiIoDQlKxqSyM0RKJsRd61Q/MQWg
         +4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765534356; x=1766139156;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tyiWj+teLSvOcemqfQ8kWGe8XZlNZ+qzMwX7g7wGHpA=;
        b=iroJd6+MTRofAZ2HaqFz9t10uWtyUAy+6oHvc9mr7R+RFV98exblLTbKA8yEB5XJm9
         te97GmnZ/WqjHI6WK4Ev4ldYweOtWbv50r0/FV5jMKYJtjFlu183Ovldv7H8XWpj1R07
         0ORfTTUFAqOldDy6A0PNrYTmGHUr8BMSA6eB4h8BDQI1qxacpDlZ4Di2GvhlIt9t47ix
         fjyTMLQJpIq129ePfIUx0Zj6MvNp22dRdQiT54pMdIOqLopxC/BUQeIxLqQMy7+ddrC2
         7+HrDDXZHSp9bf95T3jOxvV/KuLQNeSe9kdrEIpE8Jc95IUedkC8CGtBilbq59rEolOD
         PMLA==
X-Forwarded-Encrypted: i=1; AJvYcCV5hJ9iXxqZCgh9CJBn9qqu84LYcKpgM77Vx8GicSTx/QttMJ1Akt1vF8BzxiLF/tq/ApupZEg0Jlm3Nt7s@vger.kernel.org
X-Gm-Message-State: AOJu0YzZMkGFzM0bwkKd0Wi0CUia/rXjDgzAjvw6OdI+Cv/rJTEdYSyt
	qW4/QuqQQU8gYcj47UaK4hF+3bxbdumhnxrnBxz2KsPXIOhJO0RVLT3XDke5h1zYKw==
X-Gm-Gg: AY/fxX6AV3uuGvQQxa6yh6S/dOe3XsU+zDO+AqaxuyZXEHlJLMj+QalTMdMzVd4mQiT
	YbSN2phjxQMPvaXpljZmEQpzmU/SWIHDFToJCr4jr0tyWlqGwJZjWlh9tb7dFQbypCK6ebTx5vM
	8b6kUC69bIo5ErQrX8hM5KKa4Riz3agx3I672g8S8B4n/gBy3W7FUTd2KGb/wvExkW20cEmvlvn
	u98+AcAEYeZltMRYcR0TBBCpQ1E8olr5tlmqjBJYPTtB0TpRgvO2gqIUSVtFQJHiEEOXCaSSDE4
	CUarJSGTCYWvpdY+SVVqX7ob4HRWwXK3Y5P3VnWZXzTW46F/kaIgxnhjDq6JTjZ41MEx/ueyxmy
	Zo2SjAg7fFPntfVrj+8v7RvfuZxmrt/+pEmzdJmR13f4Z0Yvtu3u3QLI8Va6z/K+6fkcclFJqEI
	tLI0/otpE13MhcbZFL3OFo6q8hxqNF76jc48e4QtnJrhhQbOxLHMtHQrMfn+oIerFM1DyIypm43
	HAE6zDT4A==
X-Google-Smtp-Source: AGHT+IGKtXEzcTRKcustuNEfSG9GQgq2I5s1vamHi1Jm95rHy6d13FrXiicoayqFzE3hF90bPUJ+gA==
X-Received: by 2002:a05:690e:4105:b0:645:591a:cb5e with SMTP id 956f58d0204a3-645591accdfmr267163d50.5.1765534356223;
        Fri, 12 Dec 2025 02:12:36 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e6a46397csm3097617b3.53.2025.12.12.02.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 02:12:34 -0800 (PST)
Date: Fri, 12 Dec 2025 02:12:17 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Al Viro <viro@zeniv.linux.org.uk>
cc: Hugh Dickins <hughd@google.com>, Miklos Szeredi <miklos@szeredi.hu>, 
    Christian Brauner <brauner@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 6.19 tmpfs __d_lookup() lockup
In-Reply-To: <2a102c6d-82d9-2751-cd31-c836b5c739b7@google.com>
Message-ID: <bed18e79-ab2b-2a8f-0c32-77e6d27e2a05@google.com>
References: <47e9d03c-7a50-2c7d-247d-36f95a5329ed@google.com> <20251212050225.GD1712166@ZenIV> <20251212053452.GE1712166@ZenIV> <8ab63110-38b2-2188-91c5-909addfc9b23@google.com> <20251212063026.GF1712166@ZenIV>
 <2a102c6d-82d9-2751-cd31-c836b5c739b7@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 11 Dec 2025, Hugh Dickins wrote:
> On Fri, 12 Dec 2025, Al Viro wrote:
> > 
> > A few more things to check:
> > 
> > 1) do we, by any chance, ever see dentry_free() called with
> > dentry->d_flags & DCACHE_PERSISTENT?
> 
> No.
> 
> > 
> > 2) does d_make_persistent() ever call __d_rehash() when called with
> > dentry->d_sb->s_magic == TMPFS_MAGIC?
> 
> Yes, both if shmem_whiteout() does its d_rehash() and if it does not.
> 
> > 
> > 3) is shmem_whiteout() ever called?  If that's the case, could you try
> > to remove that d_rehash() call in it and see what happens?  Because
> > that's another place where shmem is playing odd games...
> 
> Yes, shmem_whiteout() does get called.
> 
> And when I remove that d_rehash() call from it, 269 476 650 and 750
> complete without locking up.  And when I remove the WARN_ON()s
> inserted for 2) and 3), then they pass.
> 
> You are very much on the right lines!

Well, more than that: it's exactly the right thing to do, isn't it?
shmem_mknod() already called d_make_peristent() which called __d_rehash(),
calling it a second time naturally leads to the __d_lookup() lockup seen.
And I can't see a place now for shmem_whiteout()'s "Cheat and hash" comment.

Al, may I please leave you to send in the fix to Christian and/or Linus?
You may have noticed other things on the way, that you might want to add.

But if your patch resembles the below (which has now passed xfstests
auto runs on tmpfs), please feel free to add or omit any or all of

Reported-by: Hugh Dickins <hughd@google.com>
Acked-by: Hugh Dickins <hughd@google.com>
Tested-by: Hugh Dickins <hughd@google.com>

Thanks a lot for your very quick resolution!
Hugh

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4023,18 +4023,7 @@ static int shmem_whiteout(struct mnt_idmap *idmap,
 	error = shmem_mknod(idmap, old_dir, whiteout,
 			    S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
 	dput(whiteout);
-	if (error)
-		return error;
-
-	/*
-	 * Cheat and hash the whiteout while the old dentry is still in
-	 * place, instead of playing games with FS_RENAME_DOES_D_MOVE.
-	 *
-	 * d_lookup() will consistently find one of them at this point,
-	 * not sure which one, but that isn't even important.
-	 */
-	d_rehash(whiteout);
-	return 0;
+	return error;
 }
 
 /*

