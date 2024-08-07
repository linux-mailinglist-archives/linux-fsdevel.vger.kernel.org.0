Return-Path: <linux-fsdevel+bounces-25311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A3094AA31
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245881C20DF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4321C79B96;
	Wed,  7 Aug 2024 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="japnyPT1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DE854765
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041225; cv=none; b=GhuZkLgsQ6mAqSnY3lzgyZjkvGNTQeWCxETudxh0J/7hYfMrD/Z/zRYFmVSzb//h0wl2ePQLZA7kgBBi8CCLodby2Y/pDKSr86wj9Sk+Q4OuoWvdKMy6vTdhHWjzSzlRxSih8zqMiMaSuummas+/4kijv38aanzJRhXp6DU/2f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041225; c=relaxed/simple;
	bh=FFpfQMiSrq9u1DW5KUXs6cyvFjj3tiZpGKZmfOrRDzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3D7NkRXeudm0G1RY1YD/w29hp0t1NgHvEeXKHYxUKtqzkRx/0eAON9Mz32XhLyDPptA0nakAqOAKistMKBCP0HAMHCErbttusN+ZxHPern+EOLVEgoAkONfHbutpDQKRot1y2/4obj5MErWNa7z52qXSz3zeLu7HX7EmxIVnRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=japnyPT1; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b79fc76d03so10295906d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 07:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723041221; x=1723646021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GOrKHWn4ZTrrASBJyXfVIDWuF9VbpFvqpc2/whJWU2Y=;
        b=japnyPT1t37GCidELzqtsQ/ON+kI5lmdrvJBaimKwS5OnJkzb56SImWH2WqcoA3RIt
         XWoQfKOP0mp1LrCUMqW5Mx0FqdetFFeZgW9iNUppWlqes0ESyBEPlehZrVjQbWuhsN9u
         4ySclP1BxGzTP4LKNy5drOd7/b1Kx6U9YNwJOv5vds3mnj92+u3NY3Oxl564Z4f1v0AA
         O/aJuX5Q2fFQTwI2clIbCQ6LWW8xdKNotSLIGxsVqAtRWAfloCodwD/m0HSAIgkvTo3J
         M774l0ISEbGxorsSTyJ/0n6KrYLsx65CEjjlVYNGSN70LE4FZEpK+vTOTxVC+nRRMh8c
         VhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723041221; x=1723646021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOrKHWn4ZTrrASBJyXfVIDWuF9VbpFvqpc2/whJWU2Y=;
        b=xPCSkeFD1I0VK+a2WHTHMrNIwnf8okYNmhXWXD5Asbbxy+MewTmgio+hlPnioqFjDW
         bjKcKunwXDnb+ZTG89nrCRF88ro3tS3u7MPhASNoC9XEhYBGQI0397CmIVMEz87CTMb2
         7bPhGXGkBILTXhmx/tW4PUSK5rFyheENKT6W/PLG0eoRxdZ9x3KHla0LM1oAyIBZoGqh
         xhDOyIu0brTTbdz1ybc3GJNY4YWO4dw1Mje4wWmonHhD9d/wTEs6tsr9Zz/ihTVpeBg8
         nR9XeIdUsQ1GxtYl4+Yfgiz4i3l2fbJDyTyaxClzqtxuVaPW5QEceE9XoZImgt7xiV0v
         VTRA==
X-Forwarded-Encrypted: i=1; AJvYcCWGqZABsYUKz+S5NdnTYbxywXQSpj4qHFh48bX1CMyOf5yhLa8tVvBOLEnv0rKkjI+LouHx3kELZEy5exKuZRIRs/zrF6W9UVCNdLB9xQ==
X-Gm-Message-State: AOJu0Yzgo7XEsFFk4vEpciTqFVpzkwtNQ/KdLE+Bo6JQAadobTCop9jB
	oIqZn/NUorzrHyem3ZokQQXHjpj57XorzXBXpwCsn1cdaQcxqJ7ReejYAejD5puQfiDJnS/W054
	V
X-Google-Smtp-Source: AGHT+IFFpEcTmztFCCsWagGpfxk5cgO3+2/kmPt8HWU+ZQVpqxn/Fb/WNpbYIthJgy/EMYiR3a5wXg==
X-Received: by 2002:a05:6214:5903:b0:6bc:40ef:6ff8 with SMTP id 6a1803df08f44-6bc40ef7003mr541686d6.14.1723041220907;
        Wed, 07 Aug 2024 07:33:40 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c79c831sm57677066d6.46.2024.08.07.07.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:33:40 -0700 (PDT)
Date: Wed, 7 Aug 2024 10:33:39 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH RFC 0/6] proc: restrict overmounting of ephemeral entities
Message-ID: <20240807143339.GD242945@perftesting>
References: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>

On Tue, Aug 06, 2024 at 06:02:26PM +0200, Christian Brauner wrote:
> (Preface because I've been panick-approached by people at conference
>  when we discussed this before: overmounting any global procfs files
>  such as /proc/status remains unaffected and is an existing and
>  supported use-case.)
> 
> It is currently possible to mount on top of various ephemeral entities
> in procfs. This specifically includes magic links. To recap, magic links
> are links of the form /proc/<pid>/fd/<nr>. They serve as references to
> a target file and during path lookup they cause a jump to the target
> path. Such magic links disappear if the corresponding file descriptor is
> closed.
> 
> Currently it is possible to overmount such magic links:
> 
> int fd = open("/mnt/foo", O_RDONLY);
> sprintf(path, "/proc/%d/fd/%d", getpid(), fd);
> int fd2 = openat(AT_FDCWD, path, O_PATH | O_NOFOLLOW);
> mount("/mnt/bar", path, "", MS_BIND, 0);
> 
> Arguably, this is nonsensical and is mostly interesting for an attacker
> that wants to somehow trick a process into e.g., reopening something
> that they didn't intend to reopen or to hide a malicious file
> descriptor.
> 
> But also it risks leaking mounts for long-running processes. When
> overmounting a magic link like above, the mount will not be detached
> when the file descriptor is closed. Only the target mountpoint will
> disappear. Which has the consequence of making it impossible to unmount
> that mount afterwards. So the mount will stick around until the process
> exits and the /proc/<pid>/ directory is cleaned up during
> proc_flush_pid() when the dentries are pruned and invalidated.
> 
> That in turn means it's possible for a program to accidentally leak
> mounts and it's also possible to make a task leak mounts without it's
> knowledge if the attacker just keeps overmounting things under
> /proc/<pid>/fd/<nr>.
> 
> I think it's wrong to try and fix this by us starting to play games with
> close() or somewhere else to undo these mounts when the file descriptor
> is closed. The fact that we allow overmounting of such magic links is
> simply a bug and one that we need to fix.
> 
> Similar things can be said about entries under fdinfo/ and map_files/ so
> those are restricted as well.
> 
> I have a further more aggressive patch that gets out the big hammer and
> makes everything under /proc/<pid>/*, as well as immediate symlinks such
> as /proc/self, /proc/thread-self, /proc/mounts, /proc/net that point
> into /proc/<pid>/ not overmountable. Imho, all of this should be blocked
> if we can get away with it. It's only useful to hide exploits such as in [1].
> 
> And again, overmounting of any global procfs files remains unaffected
> and is an existing and supported use-case.
> 
> Link: https://righteousit.com/2024/07/24/hiding-linux-processes-with-bind-mounts [1]
> 
> // Note that repro uses the traditional way of just mounting over
> // /proc/<pid>/fd/<nr>. This could also all be achieved just based on
> // file descriptors using move_mount(). So /proc/<pid>/fd/<nr> isn't the
> // only entry vector here. It's also possible to e.g., mount directly
> // onto /proc/<pid>/map_files/* without going over /proc/<pid>/fd/<nr>.
> int main(int argc, char *argv[])
> {
>         char path[PATH_MAX];
> 
>         creat("/mnt/foo", 0777);
>         creat("/mnt/bar", 0777);
> 
>         /*
>          * For illustration use a bunch of file descriptors in the upper
>          * range that are unused.
>          */
>         for (int i = 10000; i >= 256; i--) {
>                 printf("I'm: /proc/%d/\n", getpid());
> 
>                 int fd2 = open("/mnt/foo", O_RDONLY);
>                 if (fd2 < 0) {
>                         printf("%m - Failed to open\n");
>                         _exit(1);
>                 }
> 
>                 int newfd = dup2(fd2, i);
>                 if (newfd < 0) {
>                         printf("%m - Failed to dup\n");
>                         _exit(1);
>                 }
>                 close(fd2);
> 
>                 sprintf(path, "/proc/%d/fd/%d", getpid(), newfd);
>                 int fd = openat(AT_FDCWD, path, O_PATH | O_NOFOLLOW);
>                 if (fd < 0) {
>                         printf("%m - Failed to open\n");
>                         _exit(3);
>                 }
> 
>                 sprintf(path, "/proc/%d/fd/%d", getpid(), fd);
>                 printf("Mounting on top of %s\n", path);
>                 if (mount("/mnt/bar", path, "", MS_BIND, 0)) {
>                         printf("%m - Failed to mount\n");
>                         _exit(4);
>                 }
> 
>                 close(newfd);
>                 close(fd2);
>         }
> 
>         /*
>          * Give some time to look at things. The mounts now linger until
>          * the process exits.
>          */
>         sleep(10000);
>         _exit(0);
> }
> 
> Co-developed-by: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

I'm always down to restrict /proc, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

