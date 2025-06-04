Return-Path: <linux-fsdevel+bounces-50595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38112ACD8C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 09:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0799E164FF7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 07:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D1422F765;
	Wed,  4 Jun 2025 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho0rxPkI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2D71D435F;
	Wed,  4 Jun 2025 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749023128; cv=none; b=aY9uRFP86pVNSO3b6X6pyCCSgNQ8ENg4PvX64dPUgsG1G608ms5LIvLvTbHnxlOLLAEuDy+NYyy2yhxI53WRuegJ7xxws4/n9GQXAoLUvch6BhsZM8KoUYb42y6VqsL0AhMMX0BQHc2ocBkMyOG9IszAtap+vH/AjDVLkDo2hcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749023128; c=relaxed/simple;
	bh=jmZaSvIHE6oNYDUB7dI4l1oC0WsSrtvbVjeVWoBGMlw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G+0vDDJB17nz8C236kSaLOwOe08yjOCjiCyi4+ncGNwtCJ8zskTneugsWYHD1TT57oNn8t/2bZf5KguMZKWVQhOuSnLnS4tVeFzTsYKqCtDmZL8NdTajgCB86cC+6zxYddLachdys9iETvXDfSLFQ9eUu/8DPjWxISEahbdRMJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho0rxPkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E01EC4CEE7;
	Wed,  4 Jun 2025 07:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749023127;
	bh=jmZaSvIHE6oNYDUB7dI4l1oC0WsSrtvbVjeVWoBGMlw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ho0rxPkIEY1BB6Ps7bUo3NCmatG4/6qWFPtUuObLY4KLaOhYsxx9GneA78q+OHNRx
	 QcnK71NvNtEPgU/DmDyM4hJbV3+dmsJ4nMBhXzKxGadDOXbOGorLqDHO2dt6oj48Hm
	 49wz5eIlznt/jCm2/ZhYPBLhvK9tKD+On91ZxhJatZliKCZouojybvkeRwfDFyXjZo
	 Xfnqq9bAUGlQg+GocwhNuFaOyEshpI01XQ0LU60rIQOMklUL3DkbxbR8PnGmutsdsz
	 Bdn/duR7+TCFiew6IgeWifgMxRHign+wOqlIywscJ+9Oj8bu/5323cIaaV5YF/uzYU
	 L6ZwZE9hgZr7g==
Date: Wed, 4 Jun 2025 09:45:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Luka <luka.2016.cs@gmail.com>
Subject: Re: [Bug] possible deadlock in vfs_rmdir in Linux kernel v6.12
Message-ID: <20250604-quark-gastprofessor-9ac119a48aa1@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALm_T+2FtCDm4R5y-7mGyrY71Ex9G_9guaHCkELyggVfUbs1=w@mail.gmail.com>
 <CALm_T+0j2FUr-tY5nvBqB6nvt=Dc8GBVfwzwchtrqOCoKw3rkQ@mail.gmail.com>
 <CALm_T+3H5axrkgFdpAt23mkUyEbOaPyehAbdXbhgwutpyfMB7w@mail.gmail.com>

Konstantin, this looks actively malicious.
Can we do something about this list-wise?

On Wed, Jun 04, 2025 at 12:38:36PM +0800, Luka wrote:
> Dear Kernel Maintainers,
> 
> I am writing to report a potential vulnerability identified in the
> upstream Linux Kernel version v6.12, corresponding to the following
> commit in the mainline repository:
> 
> Git Commit:  adc218676eef25575469234709c2d87185ca223a (tag: v6.12)
> 
> This issue was discovered during the testing of the Android 16 AOSP
> kernel, which is based on Linux kernel version 6.12, specifically from
> the AOSP kernel branch:
> 
> AOSP kernel branch: android16-6.12
> Manifest path: kernel/common.git
> Source URL:  https://android.googlesource.com/kernel/common/+/refs/heads/android16-6.12
> 
> Although this kernel branch is used in Android 16 development, its
> base is aligned with the upstream Linux v6.12 release. I observed this
> issue while conducting stability and fuzzing tests on the Android 16
> platform and identified that the root cause lies in the upstream
> codebase.
> 
> 
> Bug Location: vfs_rmdir+0x118/0x488 fs/namei.c:4329
> 
> Bug Report: https://hastebin.com/share/vobatolola.bash
> 
> Entire Log: https://hastebin.com/share/efajodumuh.perl
> 
> 
> Thank you very much for your time and attention. I sincerely apologize
> that I am currently unable to provide a reproducer for this issue.
> However, I am actively working on reproducing the problem, and I will
> make sure to share any findings or reproducing steps with you as soon
> as they are available.
> 
> I greatly appreciate your efforts in maintaining the Linux kernel and
> your attention to this matter.
> 
> Best regards,
> Luka

On Wed, Jun 04, 2025 at 12:21:40PM +0800, Luka wrote:
> Dear Kernel Maintainers,
> 
> I am writing to report a potential vulnerability identified in the
> upstream Linux Kernel version v6.12, corresponding to the following
> commit in the mainline repository:
> 
> Git Commit:  adc218676eef25575469234709c2d87185ca223a (tag: v6.12)
> 
> This issue was discovered during the testing of the Android 16 AOSP
> kernel, which is based on Linux kernel version 6.12, specifically from
> the AOSP kernel branch:
> 
> AOSP kernel branch: android16-6.12
> Manifest path: kernel/common.git
> Source URL:  https://android.googlesource.com/kernel/common/+/refs/heads/android16-6.12
> 
> Although this kernel branch is used in Android 16 development, its
> base is aligned with the upstream Linux v6.12 release. I observed this
> issue while conducting stability and fuzzing tests on the Android 16
> platform and identified that the root cause lies in the upstream
> codebase.
> 
> 
> Bug Location: may_delete+0x72c/0x730 fs/namei.c:3066
> 
> Bug Report: https://hastebin.com/share/amuhawituy.scss
> 
> Entire Log: https://hastebin.com/share/oponarusih.perl
> 
> 
> Thank you very much for your time and attention. I sincerely apologize
> that I am currently unable to provide a reproducer for this issue.
> However, I am actively working on reproducing the problem, and I will
> make sure to share any findings or reproducing steps with you as soon
> as they are available.
> 
> I greatly appreciate your efforts in maintaining the Linux kernel and
> your attention to this matter.
> 
> Best regards,
> Luka

On Wed, Jun 04, 2025 at 12:12:26PM +0800, Luka wrote:
> Dear Kernel Maintainers,
> 
> I am writing to report a potential vulnerability identified in the
> upstream Linux Kernel version v6.12, corresponding to the following
> commit in the mainline repository:
> 
> Git Commit:  adc218676eef25575469234709c2d87185ca223a (tag: v6.12)
> 
> This issue was discovered during the testing of the Android 16 AOSP
> kernel, which is based on Linux kernel version 6.12, specifically from
> the AOSP kernel branch:
> 
> AOSP kernel branch: android16-6.12
> Manifest path: kernel/common.git
> Source URL:  https://android.googlesource.com/kernel/common/+/refs/heads/android16-6.12
> 
> Although this kernel branch is used in Android 16 development, its
> base is aligned with the upstream Linux v6.12 release. I observed this
> issue while conducting stability and fuzzing tests on the Android 16
> platform and identified that the root cause lies in the upstream
> codebase.
> 
> 
> Bug Location: fs_bdev_sync+0x2c/0x68 fs/super.c:1434
> 
> Bug Report: https://hastebin.com/share/pihohaniwi.bash
> 
> Entire Log: https://hastebin.com/share/orufevoquj.perl
> 
> 
> Thank you very much for your time and attention. I sincerely apologize
> that I am currently unable to provide a reproducer for this issue.
> However, I am actively working on reproducing the problem, and I will
> make sure to share any findings or reproducing steps with you as soon
> as they are available.
> 
> I greatly appreciate your efforts in maintaining the Linux kernel and
> your attention to this matter.
> 
> Best regards,
> Luka

