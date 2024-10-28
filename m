Return-Path: <linux-fsdevel+bounces-33060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21CD9B300E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 13:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 302BCB238D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 12:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB991D90AD;
	Mon, 28 Oct 2024 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTaOO1gR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3C17C61;
	Mon, 28 Oct 2024 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118176; cv=none; b=im+mdkyEAradSK4uuRSEUOE9POt1nFIb4MLcQPDvAgvIaF182SbgxmMqwC1W8lAjdNzCRlfV0oT0dq4EFGEtxB1UgwMJDUeBylKwUsibmzB3vqun/QOWEPRhHIbNT3bNUqbE58OL13ABhZmYg+3Cou+u7Ta4d6IIgNWgL4a6BzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118176; c=relaxed/simple;
	bh=t5BCCg8GDUrIBMJaCItyLNKRX4VPscnWnSFuwr6sirk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzH7d03XEQfgTRDRPIGkO11Ewu++H2tLdC8jPMsXcpMo/X8ibWUFG5KCUpF6jqF4rNxNzotiNQfe2p2uZ0ktfMVvYnlIQkK2gzFL13s6Vf4uVYXMhm0F8qf3VB1zxCpshLZkYFUv/zwuiULGGKsobmHxlly3b3xJ8RFFaqJFjZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTaOO1gR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E17C4CEC3;
	Mon, 28 Oct 2024 12:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730118176;
	bh=t5BCCg8GDUrIBMJaCItyLNKRX4VPscnWnSFuwr6sirk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTaOO1gR/V+WU/aOBUnnqFyLPfthadzlj5URkbWqlPNM2cviJ4uIxRCgtePEma/GP
	 ma3WT5QOaKi3Mz7TQbamzHW7c4WtuEYi59TiMSRV6P7ONhI0Yce/9uHRiWTcsdwhLN
	 OOe/DV7wlvlK4aUQrewl8EHPMHo9CZWo26IuEgvn+H2wDoOIky7fmWPJiXIn57kNrk
	 6Vttx4Ipj2MDrtlPOkxlo3AgvETn5HmM/7Y6BWXvASticZ5XRVNznzq1v8FidLw9XQ
	 /sO4H3jeKDt6g5dQF8LhJribGmBQOH7vvbI7rk3gXhU9eDjYx0M6faQ8pHlGQ9byyt
	 kmnshtfaJ/oFw==
Date: Mon, 28 Oct 2024 13:22:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: lots of fstests cases fail on overlay with util-linux 2.40.2
 (new mount APIs)
Message-ID: <20241028-eigelb-quintessenz-2adca4670ee8@brauner>
References: <20241026180741.cfqm6oqp3frvasfm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241026180741.cfqm6oqp3frvasfm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sun, Oct 27, 2024 at 02:07:41AM +0800, Zorro Lang wrote:
> Hi,
> 
> Recently, I hit lots of fstests cases fail on overlayfs (xfs underlying, no
> specific mount options), e.g.
> 
> FSTYP         -- overlay
> PLATFORM      -- Linux/s390x s390x-xxxx 6.12.0-rc4+ #1 SMP Fri Oct 25 14:29:18 EDT 2024
> MKFS_OPTIONS  -- -m crc=1,finobt=1,rmapbt=0,reflink=1,inobtcount=1,bigtime=1 /mnt/fstests/SCRATCH_DIR
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /mnt/fstests/SCRATCH_DIR /mnt/fstests/SCRATCH_DIR/ovl-mnt
> 
> generic/294       [failed, exit status 1]- output mismatch (see /var/lib/xfstests/results//generic/294.out.bad)
>     --- tests/generic/294.out	2024-10-25 14:38:32.098692473 -0400
>     +++ /var/lib/xfstests/results//generic/294.out.bad	2024-10-25 15:02:34.698605062 -0400
>     @@ -1,5 +1,5 @@
>      QA output created by 294
>     -mknod: SCRATCH_MNT/294.test/testnode: File exists
>     -mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': File exists
>     -touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file system
>     -ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists
>     +mount: /mnt/fstests/SCRATCH_DIR/ovl-mnt: fsconfig system call failed: overlay: No changes allowed in reconfigure.
>     +       dmesg(1) may have more information after failed mount system call.

In the new mount api overlayfs has been changed to reject invalid mount
option on remount whereas in the old mount api we just igorned them.
If this a big problem then we need to change overlayfs to continue
ignoring garbage mount options passed to it during remount.

