Return-Path: <linux-fsdevel+bounces-64193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC8EBDC63E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 06:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02AEE4E1B24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 04:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E83B2E7160;
	Wed, 15 Oct 2025 04:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvaO4OEw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AF41B3937
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 04:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760500814; cv=none; b=F0XVtiqzxPHEDHL9Lkf2SiSHd1JZU+btuRneDOSV//BpkysaoA4zMbLDb4k+RkSpM3NaCaxf6h9AEQ0XE1tm9l2rMUGCiQRF3bxV1Qfv9349gGl328PZCm126Qyia4Mi8vhP5kC4DCBm4XcBhMS0TMlAmwFxLyBHO3XvBP4PbA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760500814; c=relaxed/simple;
	bh=90nu5ejHTH2w8klUmkUE2g2YVvl4bXSM55SkccFfof4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P73SuuryUGFh94FnzPjHB71zfF9gsMDz/ZVvlBHY8wPOAX7q4aT7REBk9BGit8lRBnM+CFlyUd9KbRifgDaOBK3Bg1ub+zR8DDQ4yVdzuI9ezBE5LYxeVSAHNYxyh2uMQdKOmYWLYPIBt1TEin7b7DpYCjy3Lo4dU6ZOsYKrvWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvaO4OEw; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6360f28c566so986016d50.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 21:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760500812; x=1761105612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=25O4kccBtnC+yQP8jxbGfZ4sEqGyW1QY7yhZGOqsgSw=;
        b=TvaO4OEwSFY+CtvLrdrToEhycnBkMVJbL6hvx/UDQS6rsc0JIAOSnRDRgdXAkCgIgP
         YtFbmI36LwTJGgtdezf3+dWXT9k41LPQCP+DJob/Kbu/EQUlRfH6kq07GTR+ambBjytk
         tITM2zihHbbacupouRfL4NXfA+p4ERKdv1dhSV5Eq5tjEixLp4fgeOpFe9+7OFN1A0gv
         FOE7PTVSCmAKB1ynn4zhn0asHHhcL0BVTF7n6GKpkNH+efwtx8sXi4bMEYYEMqEltwZc
         AQ04UCB/6AW+aCPIWUFgzAkDaDmjx3pYDNYYF0uiLKB96wkMqKmT4AfWYSEHUQMPTN/z
         Fduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760500812; x=1761105612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25O4kccBtnC+yQP8jxbGfZ4sEqGyW1QY7yhZGOqsgSw=;
        b=jrxJ44DzXJstvyYlKGBlFj1oyIvCsDWOM90e9ZCtjGqOzFtXd3lu6AeNOarePmzlgB
         urZ/WrWZ3R4ihapy6VOCUcmq6HXIRNXejNQfZ/WNnHrNV7kOC0wRBkrCMpMgHe+BrQBq
         njaNSexnkQSuSsT+fNXEX1K3rbw4+REIO8z+Gcm/5soaBwPJHtoQYcsesML5qIoEM3IJ
         KQ4Py0a1g8ICFc6TCVAHFkOuwhbrbhz14UCGT5WcAqdYsm1EOvmKg0AlChMOdK2vdaJR
         rdJh3z6nPQk7IyB0FPewWP7pCf4KmINRPbjbWjA0TRtSJkhRz2l4SgrE4m8BLaMIXfBD
         O/Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXnks7Ww0sxL3qq8ywrDYwdtBF+NADT9ElSdYiO5idI8pnPKWRc2kBFVWhaxdS6KnLN0VEaxbLMx8GRvmch@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+976/Ljsj+gH28DWU3SWTH+3vU5AFHzbYnpyibC1QZwvFKmtk
	GjtheCDrqozpSBPPM4zPhuonBcGrmVxvZERdGAdZLIj68VG1sHkPQ25SXTLinjOilyKp7EGyrF4
	6Yz1+KFtmF6ADE16t4iXh+LYrBYj0QFg=
X-Gm-Gg: ASbGnctgSBc9zue55o5pu6UCEy9zHKSZUVkiDIcm1fU+V985vPQXWlHAenWbnM99uu2
	sCKXqLoL6IvncMh0uxru44NTDLcOtChbqWwIbaUOdrySXatvoTi4DGCaVzOgOm3N79tfITAKNKM
	/aL/jux0JRDs/HyCTNJYERSvLDxCj79D7JEQZ7OdXvD5RVn6yfHJeaRw==
X-Google-Smtp-Source: AGHT+IED0UlnmL4L83CwbEMWuT9hnx95y7m8K9g4G+HJg0uh5+EYc8jM5ktVZ+SDbGi9vIq6uZXpbcsCWtPQllqm9tU=
X-Received: by 2002:a05:690e:14c2:b0:63b:8310:512f with SMTP id
 956f58d0204a3-63d2bbfc1b3mr895279d50.2.1760500811682; Tue, 14 Oct 2025
 21:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <aO06hoYuvDGiCBc7@bfoster> <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster> <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
 <CAJfpegt-OEGLwiBa=dJJowKM5vMFa+xCMZQZ0dKAWZebQ9iRdA@mail.gmail.com>
 <CAJnrk1Z26+c_xqTavib=t4h=Jb3CFwb7NXP=4DdLhWzUwS-QtQ@mail.gmail.com> <aO6N-g-y6VbSItzZ@bfoster>
In-Reply-To: <aO6N-g-y6VbSItzZ@bfoster>
From: lu gu <giveme.gulu@gmail.com>
Date: Wed, 15 Oct 2025 11:59:59 +0800
X-Gm-Features: AS18NWCI-ReyqwcFNhsZ-B_sbfBvh0sSMR8SdI7jeAAmqbyu7RffVJhCQVnxB48
Message-ID: <CAFS-8+Ug-B=vCRYnz5YdEySfJM6fTDS3hRH04Td5+1GyJJGtgA@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>, 
	Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"

>  Attaching a test patch, minimally tested.
Since I only have a test environment for kernel 5.15, I ported this
patch to the FUSE module in 5.15. I ran the previous LTP test cases
more than ten times, and the data inconsistency issue did not reoccur.
However, a deadlock occur. Below is the specific stack trace.
root@ubuntu:~# ps aux | grep ltp
root       15040  0.0  0.0   2972  1124 pts/2    S+   11:26   0:00
/root/ltp-install/testcases/bin/doio -N iogen01 -a -v -n 2 -k
root       15042  0.2  0.0   3036  1320 pts/2    D+   11:26   0:01
/root/ltp-install/testcases/bin/doio -N iogen01 -a -v -n 2 -k
root@ubuntu:~# cat /proc/15042/stack
[<0>] __inode_wait_for_writeback+0xae/0xf0
[<0>] writeback_single_inode+0x72/0x190
[<0>] sync_inode_metadata+0x41/0x60
[<0>] fuse_fsync+0xbf/0x110 [fuse]
[<0>] vfs_fsync_range+0x49/0x90
[<0>] fuse_file_write_iter+0x34b/0x470 [fuse]
[<0>] new_sync_write+0x114/0x1a0
[<0>] vfs_write+0x1d5/0x270
[<0>] ksys_write+0x67/0xf0
[<0>] __x64_sys_write+0x19/0x20
[<0>] do_syscall_64+0x5c/0xc0
[<0>] entry_SYSCALL_64_after_hwframe+0x61/0xcb
root@ubuntu:~# cat /proc/15040/stack
[<0>] do_wait+0x171/0x310
[<0>] kernel_wait4+0xaf/0x150
[<0>] __do_sys_wait4+0x89/0xa0
[<0>] __x64_sys_wait4+0x1c/0x30
[<0>] do_syscall_64+0x5c/0xc0
[<0>] entry_SYSCALL_64_after_hwframe+0x61/0xcb

Thanks,
Guangming

