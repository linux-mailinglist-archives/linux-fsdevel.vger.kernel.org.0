Return-Path: <linux-fsdevel+bounces-59403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8844DB386C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F61220773D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 15:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEA42D2385;
	Wed, 27 Aug 2025 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HP8FNLFN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A126F28F
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309102; cv=none; b=SbD4ZzTJXtLB4UtmoHvcHmLP4VLsbwUtyGp31FmV+iPcqy86XORkkHYgcRCebDQk06qhCThOQTggNVn0VeIXwH3rJRZL34wX/1RAZulypRHrnU130kz2MJY6ZVpzNmTABr7rFCQGGSxJRWGGQkzBTeLC4GC5CIeBb+lPddpHhS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309102; c=relaxed/simple;
	bh=5V5gmHT4ib9khjTGQ2iAE/pbDIJrEyHXN89uDM9KYh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAbkHZcNOQunbomjo3hhBaoe+dlvnyIgzl0WuA0P3BN2eW8lLDTXo4o1+fy/Wk4dE+2922fMHqMy4TlqIY4BHOPbas3M91KFNIU1uratKGiGRA2KdIp0OxPETrWWsm+rftSwGaUo7LY33joKde2rOSTKWkeAbiybGR32PUOuTmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HP8FNLFN; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-324e6daaa39so8079a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 08:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756309100; x=1756913900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCaj9qU1uTlK3Io/0yLAp0BC9tLpIJ8rHughNbkImAs=;
        b=HP8FNLFN/oeTa/q2z0v9DvphaeVF51yppEkoHCzBEfBnnOyRhZAvVaas7TIL/8uSOM
         MOorrs1uRuCA2tTYm2OhjjuTVSR529ohETkWSXSLv7Fpj+ZKy18d/sx9KOsB6FiYiHpb
         i2FrRaXRF89KcsIhTB18q19jmZ+LdcAqAoDZieHG2eWaZrpuMzR61PCXClVBK6VaR5Hr
         AMvtbmT04DmdGBVOW8nZBIKrj0zZyzEFJw0EjwfBfbEFxv82w/RQlplRNVQBNJDwf24N
         aqEmjRgm68lGTG4fWsbdPRrggl7TpuRK7gAgauROmg+eFSiHzgEK+FoFqBxMi08FBgaH
         h7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756309100; x=1756913900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCaj9qU1uTlK3Io/0yLAp0BC9tLpIJ8rHughNbkImAs=;
        b=K7/ap778REGfAipfmYDeWREKVXz4SCgG5Eyd2Hb9WgypWi3QS4ti4lrlxL7KvTWbiJ
         FfEtzE3JDFA8OQySlGt5bdiNiiv4s526M5zDEV9nBFbAak9daXuvhqQU5TvtQ9UDQJAc
         FtqLEPA0DS9cyiU49pSyfKURAbHL2bsXO0bW/VS43o53LxDYLRHrhn1bYWGV9+Al7Y2T
         i30fipF387N3KrNmDqecrhISdHB7XJriNIeq5QKahFsrIVLMKPK7RLYakIqMBzkQB41A
         sxviR+Lmzm9vdbn+B6c7hDKuu93wFrc9uV5nf+jlTryjuRXdpIgzB2JW4mEi6H9kKXgP
         VajQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXGczp9mmMNtcWtw6LAEWC/rckRhY35oHqUy2vYNRkr4CpUpXNAvj31WtGNL+TaKjb8SrHaleE63Fxgmfx@vger.kernel.org
X-Gm-Message-State: AOJu0YySup6rKQF/gpqDvQcmmIkcxQOq/F1M5f9mnGgZqBI37oNzmGdA
	5RFCZFoNSOY20TlzTNx3nZrWCK0VHtF8rPtw5hKDugKiWunTJG0rhFwyn2MOW+d+qv8c9r9mO1S
	JxD7QIIxuz3BvAwMocDO0m/luRRNYYxPYerD5Dxf+
X-Gm-Gg: ASbGncsYIlIU8dMC3RHj21kLX2JO/KY6ZI4WEh0+2Y+TIiCIPub9w75ZM6dxtEqMbY1
	4bUIDpIFTC9zOcrydS66UL7jgYIofw5IA//G+1+BLKkaLT73Ak1K1m/DFGzNaFHGy4vMzaMsO1I
	iKMgZTqJ4ZDrE7eBwwNd6s9ompQu6h7WQQMgw2esVBwY5hLNARiKb+5GdKABBtBvV9fcYvK1zEs
	Q0UPy2+2rj4JbB18g==
X-Google-Smtp-Source: AGHT+IHtW2dnjAZbisWoax5mDslCTJ0tibAgoeGxJEVde+ImUinBOPTyITNYGZAcvnmQsIs+XXzFMCwatNRnWjAZUS0=
X-Received: by 2002:a17:90b:3f90:b0:324:ff5a:38c7 with SMTP id
 98e67ed59e1d1-32515e4f4e3mr28437601a91.16.1756309100066; Wed, 27 Aug 2025
 08:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825044046.GI39973@ZenIV> <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-25-viro@zeniv.linux.org.uk> <20250825-zugute-verkohlen-945073b3851f@brauner>
 <20250825160939.GL39973@ZenIV> <20250826-kronleuchter-vortag-af3c087ae46a@brauner>
 <20250826170044.GT39973@ZenIV> <20250826175501.GU39973@ZenIV> <20250826182124.GV39973@ZenIV>
In-Reply-To: <20250826182124.GV39973@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 27 Aug 2025 11:38:07 -0400
X-Gm-Features: Ac12FXwI_c9yQVliIi4jpN4iAYA38ukwD9hnjwkrY0xsL1nLzMdiDBBGXi7UHag
Message-ID: <CAHC9VhQ9p3W79N5nFJFgoiogNH-zANi+65ydYXhZikMPEvqKkQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] switch do_new_mount_fc() to using fc_mount()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 2:21=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> [
> This is on top of -rc3; if nobody objects, I'll insert that early in seri=
es
> in viro/vfs.git#work.mount.  It has an impact for LSM folks - ->sb_kern_m=
ount()
> would be called without ->s_umount; nothing in-tree cares, but if you hav=
e
> objections, yell now.
> ]

Thanks for the heads-up, I'm not aware of anyone currently
posting/working-on patches that would be dependent on this.

> Prior to the call of do_new_mount_fc() the caller has just done successfu=
l
> vfs_get_tree().  Then do_new_mount_fc() does several checks on resulting
> superblock, and either does fc_drop_locked() and returns an error or
> proceeds to unlock the superblock and call vfs_create_mount().
>
> The thing is, there's no reason to delay that unlock + vfs_create_mount()=
 -
> the tests do not rely upon the state of ->s_umount and
>         fc_drop_locked()
>         put_fs_context()
> is equivalent to
>         unlock ->s_umount
>         put_fs_context()
>
> Doing vfs_create_mount() before the checks allows us to move vfs_get_tree=
()
> from caller to do_new_mount_fc() and collapse it with vfs_create_mount()
> into an fc_mount() call.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

--=20
paul-moore.com

