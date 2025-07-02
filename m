Return-Path: <linux-fsdevel+bounces-53673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836DBAF5D62
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 17:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54EF4E71F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 15:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFBF2459D7;
	Wed,  2 Jul 2025 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="TYeS64cE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA7A3196AF
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470813; cv=none; b=PPfK+9S9LJsXiC18qZRDnjAzHbbj3ibT3r/KFI7Ya3NSrBfT9i0YRwcNn4zOAajV54nfEecpLQ62tIMIHH1INCByZTkvh7h5TXAimGhRAHn4IH1jYu9ZsvTNI1b2VaufPGIQjjyOwm7uNmFp9PKJpl3/+XTrq4pXNiUUepM8cms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470813; c=relaxed/simple;
	bh=3leE4hJGTzOnIvybyYzVeLVcLwlH3jXFpp+iCxZd8d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQ1qDpgpUAyYiJwtK9fiizgP/KYNPRAfizjv3Kndp/5sAYubcZiNbkedCoX75XuCQ+y4+KI1SotfMlIOszP+9bqTXs98FlaUXTu3UHdKS0qKBYPIIIYEpZt8dfY6s+Car+auFc0iKH+30Y2CApUlyJ4KtjyiTKQ32r8MjAYcrGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=TYeS64cE; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a97a67aa97so5344411cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1751470809; x=1752075609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BAXwYrzQQxC3az0StNvnncSbLnK+v9TAGG9M6gj4BwM=;
        b=TYeS64cEbFYo5moSc+SyZtlKUsXjdvl7vAPB4rJbhbX67ODMsT52TsFNg8idhz3Qqq
         o9YXzoWKJd517FOhSBGZnQiw3uNZoKl/gyXZ+5QJ3xF8tCRQJmfZfmPgz0MLImud5TOj
         Srdv3qCsRNavGyMfsRDW8Kev4si+sU4uFfk7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751470809; x=1752075609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAXwYrzQQxC3az0StNvnncSbLnK+v9TAGG9M6gj4BwM=;
        b=aIP5bWZeDpK1wuMPidmfKCfeRQUgL48hIOdkeijff0C7z6j0H0faS/Dsh5F06/HdpP
         HvoMyRKfZQSs3osEX1k90yZh3evmTSUWm8bjsbBOsiPsikbwz8Y05pePjyBggEaywt4q
         L5Hj2rPtwf9slT9j2NHimsiD95w0MP4Uur5NHMiwIPZH7QBu4IyVncEpEimGSUBZJD74
         VMpGG9c1/Bzl0NyDEnY1vo2bTipmWiRDdk333Hr0NhS1KnDJ24/yGRyCr3y7sEC9yQ8A
         BsHmkzTPU6Dt4NlVrFblTyQ3m89ZwdC/KuymXl5CnYAbYXKKg83pwLs7VITSobvmGkhD
         L4MA==
X-Forwarded-Encrypted: i=1; AJvYcCXCLmadDE5oizAYXQW9J4HGARjcrnEODQWwvmsmVpdMcmMDxYb/H6Hc8AWLQtK2qG1NYky/zqHmLFvM9Qd0@vger.kernel.org
X-Gm-Message-State: AOJu0YwR4lzui9l1E1hcG4q42Y/GtfDmQEglya4XBLW6hoKjaR2KQxSI
	r8ar4QknzpaWrWNVqnnNMpmlpxDW6dITu8IAKeL5uzXIgtnjdNgObb6SMxAxaTCSPuGOIQT7vze
	8vh4it0Xen3RFy4WRESkV2tm91AfBkDHnpF6SkHbASw==
X-Gm-Gg: ASbGncufj9G22hMQRw9R0jZPegP9c7fffKY5O4trvpWKVwwQ6TabJhG5LVp9A4vMJq5
	wtrn+Xglvom96QpqaN81k+Q+lEdv2tMR6olE7RXP2vjkfRZNnuqsUek5Px9B8DvrB1ZSudzUZjX
	8fxyQqdlMq7JPSLPM04SeA+O6xSEWOqVr/c8jOtKyHrFbGfUDEswHNtKoQJ8Xqmql0qaO59yhWI
	Rhh
X-Google-Smtp-Source: AGHT+IFNsETd+DqArdws56o/Fjq7V5K7vMfImlLGHwvaIWT00CmQ085htrDrkxaeicglEyem8Wq2gfZsqXYSzAiISlA=
X-Received: by 2002:a05:622a:1889:b0:4a7:6f1e:6fa7 with SMTP id
 d75a77b69052e-4a97690acf4mr60762141cf.19.1751470809458; Wed, 02 Jul 2025
 08:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520154203.31359-1-luis@igalia.com>
In-Reply-To: <20250520154203.31359-1-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 2 Jul 2025 17:39:58 +0200
X-Gm-Features: Ac12FXz1-wpyaTIFNuFKATECNBotnEswf5YkN6Gav-8CiMX78wlEueoCNXNw21A
Message-ID: <CAJfpegue3szRGZs+ogvYjiVt0YUo-=e+hrj-r=8ZDy11Zgrt9w@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: new workqueue to periodically invalidate expired dentries
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Laura Promberger <laura.promberger@cern.ch>, 
	Dave Chinner <david@fromorbit.com>, Matt Harvey <mharvey@jumptrading.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 May 2025 at 17:42, Luis Henriques <luis@igalia.com> wrote:
>
> This patch adds a new module parameter 'inval_wq' which is used to start a
> workqueue to periodically invalidate expired dentries.  The value of this
> new parameter is the period, in seconds, of the workqueue.  When it is set,
> every new dentry will be added to an rbtree, sorted by the dentry's expiry
> time.
>
> When the workqueue is executed, it will check the dentries in this tree and
> invalidate them if:
>
>   - The dentry has timed-out, or if
>   - The connection epoch has been incremented.

I wonder, why not make the whole infrastructure global?  There's no
reason to have separate rb-trees and workqueues for each fuse
instance.  Contention on the lock would be worse, but it's bad as it
is, so need some solution, e.g. hashed lock, which is better done with
a single instance.

>
> The workqueue will run for, at most, 5 seconds each time.  It will
> reschedule itself if the dentries tree isn't empty.

It should check need_resched() instead.

> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 1fb0b15a6088..257ca2b36b94 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -34,33 +34,153 @@ static void fuse_advise_use_readdirplus(struct inode *dir)
>         set_bit(FUSE_I_ADVISE_RDPLUS, &fi->state);
>  }
>
> -#if BITS_PER_LONG >= 64
> -static inline void __fuse_dentry_settime(struct dentry *entry, u64 time)
> +struct fuse_dentry {
> +       u64 time;
> +       struct rcu_head rcu;
> +       struct rb_node node;
> +       struct dentry *dentry;
> +};
> +

You lost the union with rcu_head.   Any other field is okay, none of
them matter in rcu protected code.  E.g.

struct fuse_dentry {
        u64 time;
        union {
                struct rcu_head rcu;
                struct rb_node node;
        };
        struct dentry *dentry;
};

Thanks,
Miklos

