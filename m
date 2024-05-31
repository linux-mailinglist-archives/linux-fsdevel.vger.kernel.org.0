Return-Path: <linux-fsdevel+bounces-20678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4823F8D6C51
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 00:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982DE1F23644
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 22:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A139F7E101;
	Fri, 31 May 2024 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="X7kDV+eQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29EE24B4A
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717193330; cv=none; b=C2nh3kfdWvRRGCC28PdyuDWGIJxRWiQG5N91qjoR3eOBvs3ndQi6PzmQkTaH4RpPkg2W1Ulb8SFtw+bYdX5PJf1JTOctlEULwmjtcUkWTA6FOQ0VHrLaAtzWFou3ELQGStKAxRBcYk9mA6L+28Gyy40Nsrh++Egi3tVjxNpMDCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717193330; c=relaxed/simple;
	bh=LsLLfHV2v5njE9y9hz3Q07GYapcjqZR4vDigNZ4/TQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfNgJwVrQsLz0yvPjUObF2JCfRmn0YCzVJD1JJ5IiiJyHWm2YtKSTE4DH4uL+vgHMrzgKx1kfnodhVY0Nm8lFLmDC+QCA0/HqaiIAm3PVkvzInEac1Jo/gGqo0hUZH8qV444gvPhM+HqGpDvdOqB8DenVHcq7JY9aAvNQbJjATk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=X7kDV+eQ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43fdb797ee2so13887091cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 15:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717193327; x=1717798127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V6OdQltT+y11yGh2NkGgCf7141IzCsmwOQ7dVW3bAjo=;
        b=X7kDV+eQv61c4we6x1I7YJoQwbTcSa1uKlAS0z66FqWzOjv/IMR1jPKHZArm1h3cAM
         j53pQI/RM7bX1KRYA9G7f4JtgSDS34oyjCDej81PICT7V8AOkXjbaBz/JOkuCsHvDi5t
         CQ2SPS6TVsdlhxRwsyE1gnFyt7YicSSF2fJCfxSw+rBXVsVEsz3/OMWWqM9DXbG7ztrh
         dBlJ/vcnHvO3JlFlQQel7QUmYpUVmDk91RjietyLl+MRH+JDMro7Q3MTC5Qisf2726wi
         FxiDMZ2IM4JFvzfD148PgH5STzY5qGCX2sbFLQcpg7hMTF16+U6wtoQziQVlIhXfZF85
         yTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717193327; x=1717798127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6OdQltT+y11yGh2NkGgCf7141IzCsmwOQ7dVW3bAjo=;
        b=qGueG7zVw/40BBNvqrUDp3+zOx5kFaLlY9oOliBLJxhxDQo7fN5TZ+EbbchA2Z3O91
         MhABnsvWes2Fo2AU5oLXO7Fbqse4ba+jr/a3WXDf7Q3B7KX72kJOtipNE7h8aNgN0HjU
         YPVNsAqxfu9uSpKtjwac5HemVe8tAXe6J7oxKRDZoof7LpPS0iPqz3JOur8yL/ys4R6q
         g0KvDCJdHhWA8p+wJSeGz4Wd3LHol1bawOFUB/7BwEC8kRQ/1EAuKEUj1OltuzBRJvwu
         RRtE+NxZnaD2+ftXLrPEuL1pI6lqaPo5n8CPMMJOcnG6zdG1695ByczfMXrGRldUALGi
         TRzw==
X-Forwarded-Encrypted: i=1; AJvYcCWN5Z8THwuOlbsN8PjkOcgt2Yfq6vU+24tFScn8sbrwYOmbifahjFjgXJhf48k4xdLwgociw8ToEJUX0rFPG73pVza8gQZ1S56JZSLSZg==
X-Gm-Message-State: AOJu0YxTat0HaiHWa9lSqlgP4FWauqr8WFqfU/i/UdPH3JqNMmNVBmhC
	JW7urMnjcLSZ3i9JZryaU+NDiepa+0GaiIzMHLVw88cZfIYhu765eWU1z1LTtD8=
X-Google-Smtp-Source: AGHT+IEWCsHThM+KyAHhOv3GrntRsEepezavyJzikluHojXtr53r+IUgSrTFHvcumIEYAmf1wC0OSQ==
X-Received: by 2002:a05:622a:13ca:b0:43d:f989:edad with SMTP id d75a77b69052e-43ff52adf1cmr36306291cf.47.1717193326662;
        Fri, 31 May 2024 15:08:46 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff2582303sm11948491cf.82.2024.05.31.15.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 15:08:46 -0700 (PDT)
Date: Fri, 31 May 2024 18:08:44 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH] fs: don't block i_writecount during exec
Message-ID: <20240531220844.GA2233362@perftesting>
References: <20240531-beheben-panzerglas-5ba2472a3330@brauner>
 <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>

On Fri, May 31, 2024 at 03:01:43PM +0200, Christian Brauner wrote:
> Back in 2021 we already discussed removing deny_write_access() for
> executables. Back then I was hesistant because I thought that this might
> cause issues in userspace. But even back then I had started taking some
> notes on what could potentially depend on this and I didn't come up with
> a lot so I've changed my mind and I would like to try this.
> 
> Here are some of the notes that I took:
> 
> (1) The deny_write_access() mechanism is causing really pointless issues
>     such as [1]. If a thread in a thread-group opens a file writable,
>     then writes some stuff, then closing the file descriptor and then
>     calling execve() they can fail the execve() with ETXTBUSY because
>     another thread in the thread-group could have concurrently called
>     fork(). Multi-threaded libraries such as go suffer from this.
> 
> (2) There are userspace attacks that rely on overwriting the binary of a
>     running process. These attacks are _mitigated_ but _not at all
>     prevented_ from ocurring by the deny_write_access() mechanism.
> 
>     I'll go over some details. The clearest example of such attacks was
>     the attack against runC in CVE-2019-5736 (cf. [3]).
> 
>     An attack could compromise the runC host binary from inside a
>     _privileged_ runC container. The malicious binary could then be used
>     to take over the host.
> 
>     (It is crucial to note that this attack is _not_ possible with
>      unprivileged containers. IOW, the setup here is already insecure.)
> 
>     The attack can be made when attaching to a running container or when
>     starting a container running a specially crafted image. For example,
>     when runC attaches to a container the attacker can trick it into
>     executing itself.
> 
>     This could be done by replacing the target binary inside the
>     container with a custom binary pointing back at the runC binary
>     itself. As an example, if the target binary was /bin/bash, this
>     could be replaced with an executable script specifying the
>     interpreter path #!/proc/self/exe.
> 
>     As such when /bin/bash is executed inside the container, instead the
>     target of /proc/self/exe will be executed. That magic link will
>     point to the runc binary on the host. The attacker can then proceed
>     to write to the target of /proc/self/exe to try and overwrite the
>     runC binary on the host.
> 
>     However, this will not succeed because of deny_write_access(). Now,
>     one might think that this would prevent the attack but it doesn't.
> 
>     To overcome this, the attacker has multiple ways:
>     * Open a file descriptor to /proc/self/exe using the O_PATH flag and
>       then proceed to reopen the binary as O_WRONLY through
>       /proc/self/fd/<nr> and try to write to it in a busy loop from a
>       separate process. Ultimately it will succeed when the runC binary
>       exits. After this the runC binary is compromised and can be used
>       to attack other containers or the host itself.
>     * Use a malicious shared library annotating a function in there with
>       the constructor attribute making the malicious function run as an
>       initializor. The malicious library will then open /proc/self/exe
>       for creating a new entry under /proc/self/fd/<nr>. It'll then call
>       exec to a) force runC to exit and b) hand the file descriptor off
>       to a program that then reopens /proc/self/fd/<nr> for writing
>       (which is now possible because runC has exited) and overwriting
>       that binary.
> 
>     To sum up: the deny_write_access() mechanism doesn't prevent such
>     attacks in insecure setups. It just makes them minimally harder.
>     That's all.
> 
>     The only way back then to prevent this is to create a temporary copy
>     of the calling binary itself when it starts or attaches to
>     containers. So what I did back then for LXC (and Aleksa for runC)
>     was to create an anonymous, in-memory file using the memfd_create()
>     system call and to copy itself into the temporary in-memory file,
>     which is then sealed to prevent further modifications. This sealed,
>     in-memory file copy is then executed instead of the original on-disk
>     binary.
> 
>     Any compromising write operations from a privileged container to the
>     host binary will then write to the temporary in-memory binary and
>     not to the host binary on-disk, preserving the integrity of the host
>     binary. Also as the temporary, in-memory binary is sealed, writes to
>     this will also fail.
> 
>     The point is that deny_write_access() is uselss to prevent these
>     attacks.
> 
> (3) Denying write access to an inode because it's currently used in an
>     exec path could easily be done on an LSM level. It might need an
>     additional hook but that should be about it.
> 
> (4) The MAP_DENYWRITE flag for mmap() has been deprecated a long time
>     ago so while we do protect the main executable the bigger portion of
>     the things you'd think need protecting such as the shared libraries
>     aren't. IOW, we let anyone happily overwrite shared libraries.
> 
> (5) We removed all remaining uses of VM_DENYWRITE in [2]. That means:
>     (5.1) We removed the legacy uselib() protection for preventing
>           overwriting of shared libraries. Nobody cared in 3 years.
>     (5.2) We allow write access to the elf interpreter after exec
>           completed treating it on a par with shared libraries.
> 
> Yes, someone in userspace could potentially be relying on this. It's not
> completely out of the realm of possibility but let's find out if that's
> actually the case and not guess.
> 
> Link: https://github.com/golang/go/issues/22315 [1]
> Link: 49624efa65ac ("Merge tag 'denywrite-for-5.15' of git://github.com/davidhildenbrand/linux") [2]
> Link: https://unit42.paloaltonetworks.com/breaking-docker-via-runc-explaining-cve-2019-5736 [3]
> Link: https://lwn.net/Articles/866493
> Link: https://github.com/golang/go/issues/22220
> Link: https://github.com/golang/go/blob/5bf8c0cf09ee5c7e5a37ab90afcce154ab716a97/src/cmd/go/internal/work/buildid.go#L724
> Link: https://github.com/golang/go/blob/5bf8c0cf09ee5c7e5a37ab90afcce154ab716a97/src/cmd/go/internal/work/exec.go#L1493
> Link: https://github.com/golang/go/blob/5bf8c0cf09ee5c7e5a37ab90afcce154ab716a97/src/cmd/go/internal/script/cmds.go#L457
> Link: https://github.com/golang/go/blob/5bf8c0cf09ee5c7e5a37ab90afcce154ab716a97/src/cmd/go/internal/test/test.go#L1557
> Link: https://github.com/golang/go/blob/5bf8c0cf09ee5c7e5a37ab90afcce154ab716a97/src/os/exec/lp_linux_test.go#L61
> Link: https://github.com/buildkite/agent/pull/2736
> Link: https://github.com/rust-lang/rust/issues/114554
> Link: https://bugs.openjdk.org/browse/JDK-8068370
> Link: https://github.com/dotnet/runtime/issues/58964
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

