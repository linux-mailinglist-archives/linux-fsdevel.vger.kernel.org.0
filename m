Return-Path: <linux-fsdevel+bounces-34543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF449C6252
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E8F1F23584
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E998219E4D;
	Tue, 12 Nov 2024 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aNMf5lBY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEDA219CB2
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442363; cv=none; b=O95N0SSC+Tio/rJTM5f0q0DfMk6qTcZDM6TPcvRuZ6KG3MieEJH4dihyIjJsQGvmiROcfCItWB+IEpNTm3IjKPVqmEENTHADyZhBMIicYcDVF6J0ftjcyF8R2gGSY64oLIQVqUdOVRaPEDhTaa7VtAbKezDYLsQL/waIF4JWHx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442363; c=relaxed/simple;
	bh=APg3rcEySs1o4uLtYJBcvRsc9Qe6Q1ZTOQRJgr9MbAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvnWoyo1OSpelhTXzpmLdDUMm/fzmDOJD+Dzrcuwm9fKE9DNeeSpP0ar+xyLxpZRi5lbalr4CUehLZg4cDMcsWrYOIzI+rvLqgxSO2lgZiMqJ09t+sarxuYuoVKWbmIvAqFV0iDePARaDVx3s2403HeZRDhAUvpfHOPWYrO5ybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aNMf5lBY; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f2b95775so7744656e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 12:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731442360; x=1732047160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0qYB3r0e+M+AIIS7skjeHUYQNaIJb6UwbAHof7SMGqw=;
        b=aNMf5lBY/H4thziDEo4SsJPhXp+oCUg72p0lGzU4PnUMx6DvkdVuA5kq3h6/sjvWhb
         OmDJQ/yEXQLHNdUgbTwu/PPru+45p88cZrfqJFEYtBREG17bhygfzAu7zBqhAfPR6E3P
         FQRS3oP+wtYl9MNE4wj5V06UEFYoJ042XnzsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731442360; x=1732047160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qYB3r0e+M+AIIS7skjeHUYQNaIJb6UwbAHof7SMGqw=;
        b=k9T1TETqjEARfubKCf3chJkRzHpmpqYOi0Rn/MBV10Xsvviy1t00Dya4lLT8FV1Era
         HYWyFd5kLYCbAg5BIuSHbK77ooDLobIEUAh8hFUbH3uYE9uror+cy7tDQYnblX8QKBpU
         am5rkYow1JUgvl2PL9IG0BoKyWywewExf52/Npyk17+6JVqVIXp3k1ZNov6Qw7/ivC4m
         zeLPGrJ/Vqb3M4kNGmd2tWpLuuw4VfdLuiU6poMVQ989UdOC1tDOg837hTunPt17D/tx
         3QQvcEae5sqY6Z3bPXjKd+fNZJRJHEENZYd/L511esgxKmMOOtDu3EP9lW243+rZlxiX
         Xkig==
X-Forwarded-Encrypted: i=1; AJvYcCUPiIpMKda5XlKN9GsXn/6HPC3mOICjy0KehvQ+UXUvIGa8lxZ2q0ZptfXqR/SjBun38CVGPAHI/2kUpjBb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7P0PecykIvoMGpCwjKQVF5LM8IN1vLcUv9X5aYBL8i8GRWbtl
	hpGrECa/YjKbl9yhjQX4azxjQM4z1c9+lNkLOSkddzGFc82XP6zon+7QzbQ6V7I7VFmnTel/hdM
	2QjFb+A==
X-Google-Smtp-Source: AGHT+IFa6i0czP/hsm+0SoEsWRHsKTnsWsodhzii++V2nayqCdVgCI3NZ8deVyXpy2ay2WjNAuK3sw==
X-Received: by 2002:a05:6512:3da2:b0:539:8f3c:4586 with SMTP id 2adb3069b0e04-53d862f8159mr11559030e87.55.1731442359545;
        Tue, 12 Nov 2024 12:12:39 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2e8a3sm758333166b.190.2024.11.12.12.12.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 12:12:37 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cb615671acso4557605a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 12:12:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUv2SkUxtuz1myqXlOknYcXUP26CRe43shrrXpCrIiWsNUp7daRuvrBeR/RxwBCIpGaEVfNTVdTd1Hrx2kx@vger.kernel.org
X-Received: by 2002:a50:cd1d:0:b0:5cf:22ab:c3b5 with SMTP id
 4fb4d7f45d1cf-5cf22abcab5mr13468088a12.1.1731442356992; Tue, 12 Nov 2024
 12:12:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
In-Reply-To: <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 12:12:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
Message-ID: <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 09:56, Josef Bacik <josef@toxicpanda.com> wrote:
>
>  #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
> +static inline int fsnotify_pre_content(struct file *file)
> +{
> +       struct inode *inode = file_inode(file);
> +
> +       /*
> +        * Pre-content events are only reported for regular files and dirs
> +        * if there are any pre-content event watchers on this sb.
> +        */
> +       if ((!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode)) ||
> +           !(inode->i_sb->s_iflags & SB_I_ALLOW_HSM) ||
> +           !fsnotify_sb_has_priority_watchers(inode->i_sb,
> +                                              FSNOTIFY_PRIO_PRE_CONTENT))
> +               return 0;
> +
> +       return fsnotify_file(file, FS_PRE_ACCESS);
> +}

Yeah, no.

None of this should check inode->i_sb->s_iflags at any point.

The "is there a pre-content" thing should check one thing, and one
thing only: that "is this file watched" flag.

The whole indecipherable mess of inline functions that do random
things in <linux/fsnotify.h> needs to be cleaned up, not made even
more indecipherable.

I'm NAKing this whole series until this is all sane and cleaned up,
and I don't want to see a new hacky version being sent out tomorrow
with just another layer of new hacks, with random new inline functions
that call other inline functions and have complex odd conditionals
that make no sense.

Really. If the new hooks don't have that *SINGLE* bit test, they will
not get merged.

And that *SINGLE* bit test had better not be hidden under multiple
layers of odd inline functions.

You DO NOT get to use the same old broken complex function for the new
hooks that then mix these odd helpers.

This whole "add another crazy inline function using another crazy
helper needs to STOP. Later on in the patch series you do

+/*
+ * fsnotify_truncate_perm - permission hook before file truncate
+ */
+static inline int fsnotify_truncate_perm(const struct path *path,
loff_t length)
+{
+       return fsnotify_pre_content(path, &length, 0);
+}

or things like this:

+static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+       if (!(file->f_mode & FMODE_NOTIFY_PERM))
+               return false;
+
+       if (!(file_inode(file)->i_sb->s_iflags & SB_I_ALLOW_HSM))
+               return false;
+
+       return fsnotify_file_object_watched(file, FSNOTIFY_PRE_CONTENT_EVENTS);
+}

and no, NONE of that should be tested at runtime.

I repeat: you should have *ONE* inline function that basically does

 static inline bool fsnotify_file_watched(struct file *file)
 {
        return file && unlikely(file->f_mode & FMODE_NOTIFY_PERM);
 }

and absolutely nothing else. If that file is set, the file has
notification events, and you go to an out-of-line slow case. You don't
inline the unlikely cases after that.

And you make sure that you only set that special bit on files and
filesystems that support it. You most definitely don't check for
SB_I_ALLOW_HSM kind of flags at runtime in critical code.

               Linus

