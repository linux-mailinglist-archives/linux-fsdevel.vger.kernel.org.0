Return-Path: <linux-fsdevel+bounces-40515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 051ABA243A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 21:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB2E188A589
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 20:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9291F2C26;
	Fri, 31 Jan 2025 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh7huvfG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225418E25;
	Fri, 31 Jan 2025 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738353825; cv=none; b=cUZV4M9QM2evcY2FalbXfLaJj2/+JOucDLGTFpcHMJ5uOxIQVjcdRHHngrEPwHKLTtQg8LULodWPqiLE4xuICkjPF0wI2DzCWjpRLa29Xmzqc9fnzyWYeJFX1GqDm46y+HlJjeByNubSC5Elu66mqAcYPnxq7IaUT5IXXS21Jeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738353825; c=relaxed/simple;
	bh=v9bao2gRBuOejMGQejXblTZGEJEolhZDA9IwvqQFiiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gtkmh/vShwL77stOalU0eRd3lSDRkyVwyNQ39XQnkm3neL/HKax06UtEW43vcsEg8lmy7ng+czFnhssW26VAZ0f+qZ2gQ1bGWH+xH1C50Y4YyrfpIb3xXQ/eqBJYcSrTkvPcxmRbYcM9/u22bdwgRk4+ayI1Xsass6AMsgfcq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uh7huvfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A22C4CED1;
	Fri, 31 Jan 2025 20:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738353825;
	bh=v9bao2gRBuOejMGQejXblTZGEJEolhZDA9IwvqQFiiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uh7huvfGJaEnS8Du79Z5fPoFpq1mnLBjHw6voJI3FuY+IRZ0+wFc9Bsn3se8xKcJ8
	 JcWIk/c8q9MmdwGMgBHxjIxuqN8MgcsSFKzpj7x3TM5AiRgBpNGnMdpwbsAG3X8ftG
	 OXRR+1eIXOqHDHTV6sY2Ehrjem6P7Axv5tm4gSXO6RdiDT9E4hDUIU2NlKcKhfChtQ
	 0KPN+aMl3sOWtSyKTVxdrgt1FgBwKazFKxkezDYpOmXrA6ukpjCPwLvEC1U+SvdcIS
	 1KuQewccLOkzCV1YJqEd5dfZ59D6+oaZufIMIToSdmB/DbuQylu+OfVauP4uMi6xCs
	 QVamYAyzBoLyQ==
Date: Fri, 31 Jan 2025 12:03:39 -0800
From: Kees Cook <kees@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Baoquan He <bhe@redhat.com>, Bill O'Donnell <bodonnel@redhat.com>,
	Corey Minyard <cminyard@mvista.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: Re: [GIT PULL] sysctl constification changes for v6.14-rc1
Message-ID: <202501311203.D6FDB314@keescook>
References: <kndlh7lx2gfmz5m3ilwzp7fcsmimsnjgh434hnaro2pmy7evl6@jfui76m22kig>
 <CAHk-=wgNwJ57GtPM_ZUCGeVN5iJt0pxDf96dRwp0KhuVV4Hjpw@mail.gmail.com>
 <iay2bmkotede6c5xkxnfvxwgxg2drmcc6az3eeiijkkz3ftie7@co4cir66ksz2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iay2bmkotede6c5xkxnfvxwgxg2drmcc6az3eeiijkkz3ftie7@co4cir66ksz2>

On Fri, Jan 31, 2025 at 02:57:40PM +0100, Joel Granados wrote:
> From 431abf6c9c11a8b7321842ed0747b3200d43ef34 Mon Sep 17 00:00:00 2001
> From: Joel Granados <joel.granados@kernel.org>
> Date: Fri, 31 Jan 2025 14:10:57 +0100
> Subject: [PATCH] csky: Remove the size from alignment_tbl declaration
> 
> Having to synchronize the number of ctl_table array elements with the
> size in the declaration can lead to discrepancies between the two
> values. Since commit d7a76ec87195 ("sysctl: Remove check for sentinel
> element in ctl_table arrays"), the calculation of the ctl_table array
> size is done solely by the ARRAY_SIZE macro removing the need for the
> size in the declaration.
> 
> Remove the size for the aligment_tbl declaration and const qualify the
> array for good measure.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

FWIW, this looks correct to me.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

