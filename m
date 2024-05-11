Return-Path: <linux-fsdevel+bounces-19330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB128C3338
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 20:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE171C20D4A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 18:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9221BC4F;
	Sat, 11 May 2024 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IfX9AF+u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474A2366
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715452976; cv=none; b=INdo3dk4RCh1pzpikDQlrudgvGoLiICfe0/PsPTpNRoVtkH7DG2FSE8JLI4GPKyiXLIFy8BTwVERtNf8kT8h2XNaEmCOBoBoHGY/WaENa1/9y3OwEEQxy03gvlFlrYv/Cra27tex7jPNJL2iUlsmLSVTVdUjdPR+2gnyNnZXZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715452976; c=relaxed/simple;
	bh=ApCJCyRs/j1pv1e73Mk2nr2GCEsuTwCexsS/z9hBi/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apH35OOOGZlaIevw9A3x/p4PJIx54MB0dIothmHxym+8PH7D97KKoOPgVvgiKr7Q9H6ZFYLj/3Pvxa4HHP2jBROuMI+lgDU9J4k/ZnskP7OisG2EgZuR6jW6Fi3s4e6esa/9D/VRSsYU0gAAp3vU5k3TGKzsShPtGwDKrMRc8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IfX9AF+u; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4702457ccbso765548366b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 11:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715452972; x=1716057772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PnMdJnE8yoeGQU4ENYIBNUz2hwuFIS5awXtMxfvXts0=;
        b=IfX9AF+uXcmRXX/b9U4I5O7U8/HtkNG4w5CctphpmGSWgRRNY7qIf8/DQEbpeLb9F2
         e/RpUdT6DUFn1U6FF0cFKRgfEUe/Ph6E/yTvU8lPYZ/pb+aqfVnmLWtnkt0MjCx6CQoy
         PZYJiHWor3GjOKNSmOmyx3DBP07dmxXwBiRI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715452972; x=1716057772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnMdJnE8yoeGQU4ENYIBNUz2hwuFIS5awXtMxfvXts0=;
        b=N/u9c6Uy62KyAqptpgSPr/7y3vBijNXwMptrFdeiQmTwDGtkZcp4JkYlhRM5nYi+Po
         GVNGgL6DpSXbFCCeJp26QJI2pJeIws9/FlZ+dybUCETXlqWHjyAyQjozxOnhMz5lVYbD
         MJYT2ZRfGAZFnrc8cZ06x8STuzs1D3rwzME20aVAHNShN2Tve/oPlzZAffD3Lut4Jls0
         KAx3znxyMaSfLP+CUC+E/pGMb+wWxEVFCaUJatUvx96miojX095qc9Thby+zSwq8/4VO
         rjvLva4i/R0/e9eqZ0xID898l4MTWD5neqVwPXdMjaxt4pk0J5opY83g0Rj3mJCGjvsm
         2DcA==
X-Forwarded-Encrypted: i=1; AJvYcCU0wHfqXNpIifVT9Uej/7HzVWmPB8QEaYPi6QHlD627dxdWoTGf/p7jAPyWNusSVvKslglufHFnIhBJhCc/F7maCEK5yiy6LFP+Q7p/5g==
X-Gm-Message-State: AOJu0YyWpW2eoARfOFk+9IijyQOrUsSwjUhS+C3C9/iWjW8lLfrIghd/
	OqUOmhVRAn0aL6hMj8t5jdS9pt9UVbfEjXjt7DZPAJLR0uv1euWJwFWjl12DIYNYJHAJ7pS4whb
	m9rLJjg==
X-Google-Smtp-Source: AGHT+IEbHWHqXVZ3Yj2/WU++BcEiAGcTP6ygVjf0CxpNEMGwgOPtr0kopC4ysdVASvMZozdMmjfdFA==
X-Received: by 2002:a17:906:d9c2:b0:a59:c2c3:bb45 with SMTP id a640c23a62f3a-a5a2d66aa37mr356702966b.56.1715452972601;
        Sat, 11 May 2024 11:42:52 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7f32sm361493866b.106.2024.05.11.11.42.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 May 2024 11:42:51 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4702457ccbso765545866b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 11:42:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGStHK9JvvUQ0AwSpPHDYz3UARspeUdwR1Or0pTZS/ANfa97mecZ7j5XQxi4VTy4GGdMgyPSlwMH/VYYT+A7+SKh0s1UMHJeIhAihtXA==
X-Received: by 2002:a17:906:f296:b0:a58:f13d:d378 with SMTP id
 a640c23a62f3a-a5a2d54c5d6mr413536766b.13.1715452971426; Sat, 11 May 2024
 11:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
 <20240511182625.6717-2-torvalds@linux-foundation.org>
In-Reply-To: <20240511182625.6717-2-torvalds@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 11 May 2024 11:42:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
Message-ID: <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
Subject: Re: [PATCH] vfs: move dentry shrinking outside the inode lock in 'rmdir()'
To: torvalds@linux-foundation.org
Cc: brauner@kernel.org, jack@suse.cz, laoar.shao@gmail.com, 
	linux-fsdevel@vger.kernel.org, longman@redhat.com, viro@zeniv.linux.org.uk, 
	walters@verbum.org, wangkai86@huawei.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 May 2024 at 11:29, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Reorganize the code trivially to just have a separate success path,
> which simplifies the code (since 'd_delete_notify()' is only called in
> the success path anyway) and makes it trivial to just move the dentry
> shrinking outside the inode lock.

Bah.

I think this might need more work.

The *caller* of vfs_rmdir() also holds a lock, ie we have do_rmdir() doing

        inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
        dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
        ...
        error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
        dput(dentry);
        inode_unlock(path.dentry->d_inode);

so we have another level of locking going on, and my patch only moved
the dcache pruning outside the lock of the directory we're removing
(not outside the lock of the directory that contains the removed
directory).

And that outside lock is the much more important one, I bet.

So I still think this approach may be the right one, but that patch of
mine didn't go far enough.

Sadly, while do_rmdir() itself is trivial to fix up to do this, we
have several other users of vfs_rmdir() (ecryptfs, devtmpfs, overlayfs
in addition to nfsd and ksmbd), so the more complete patch would be
noticeably bigger.

My bad.

                  Linus

