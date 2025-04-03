Return-Path: <linux-fsdevel+bounces-45628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE50A7A106
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 12:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3198B1898407
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 10:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1638A1F542B;
	Thu,  3 Apr 2025 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/DsT6Zk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADA81E04AC;
	Thu,  3 Apr 2025 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743676254; cv=none; b=IxhVyrzqPtxByX7FTM93EPphMHUMvQcXLyUlt+qxo0KxmFSZsgzP/34wHKuF19nJY7DYPwY83Qfy5p1r/wy2kRtRioBhunYiRu9m/UlwrB0AWDXsqLlynoVb0Hvd9PQEjghFl0L4BL6SMK2Okj5wLSexCoTwEFqfpIBDShaasGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743676254; c=relaxed/simple;
	bh=n1zuPqLp3BAZjlMBGxoVRWw7DfZfeQ1wmjCwvago3yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1iIEIBG31a1I1CtxYl8qrXhKx3VSHWNAo3VLByEcdId+516I4O5ClHo5iV0h9HBybJgVFLANd7CsNHr7DdrI4PLzO3kc0LEfBRdHKI9xeS+YB/xLIaLZuI/Ibne3jULd5MY6q+jSzN0IdbT+BZIPbA3WWV1AocUcqtknOHX1Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/DsT6Zk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB23CC4CEE3;
	Thu,  3 Apr 2025 10:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743676253;
	bh=n1zuPqLp3BAZjlMBGxoVRWw7DfZfeQ1wmjCwvago3yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/DsT6Zk2sA7zZ4f4FpjTI1XHNHdFsMGY+ggqD6xm8P8PWfVPWDlU4Q77Qoc1Y67C
	 XseEpV7d2z3UmTvs3o4G+uNctgD7yrwge92Sr6wsDY5i11uj9ugvipjIrV7mlP3ux3
	 D41C13pGBeV3zrQui3eJ8RUON0tl0P2Nr5Y1LQ6mc2HNdS2GtUInD7emP1CBynyFuX
	 QN/bgAdLp0HBFumBkj+/fOmIfQWbUX83DcN35LY/3Tw5kwaPAqyGOPDwxTtrBAhBt5
	 8E8Hvxp5O+6uaTBppQFckFF0uUTY3GVNxOmtVkiStcjbBPweAjQimsJSWdelTrV+v2
	 aCXrTaRQrwBBQ==
Date: Thu, 3 Apr 2025 12:30:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?B?55m954OB5YaJ?= <baishuoran@hrbeu.edu.cn>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Kun Hu <huk23@m.fudan.edu.cn>, 
	Jiaji Qin <jjtan24@m.fudan.edu.cn>, linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: INFO: task hung in chmod_common
Message-ID: <20250403-teppich-geist-a877dd4158f2@brauner>
References: <79192769.9da0.195faff9e75.Coremail.baishuoran@hrbeu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79192769.9da0.195faff9e75.Coremail.baishuoran@hrbeu.edu.cn>

On Thu, Apr 03, 2025 at 05:33:31PM +0800, 白烁冉 wrote:
> Dear Maintainers,
> 
> When using our customized Syzkaller to fuzz the latest Linux kernel, the following crash (95th)was triggered.
> 
> 
> HEAD commit: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
> git tree: upstream
> Output:https://github.com/pghk13/Kernel-Bug/tree/main/0305_6.14rc5/95-INFO_%20rcu%20detected%20stall%20in%20sys_chdir
> Kernel config:https://github.com/pghk13/Kernel-Bug/blob/main/0305_6.14rc5/config.txt
> C reproducer:https://github.com/pghk13/Kernel-Bug/blob/main/0305_6.14rc5/95-INFO_%20rcu%20detected%20stall%20in%20sys_chdir/95repro.c
> Syzlang reproducer: https://github.com/pghk13/Kernel-Bug/blob/main/0305_6.14rc5/95-INFO_%20rcu%20detected%20stall%20in%20sys_chdir/95call_trace.txt

We generally ignore any reports from non-official syzbot instances.

> 
> 
> 
> Our reproducer uses mounts a constructed filesystem image.
> This could be a file system deadlock issue that occurs on lines
> 547-548 of the chmod_common function. When this function is called,
> the code already holds the inode lock (via the inode_lock (inode)),
> but the notify_change may need to perform RCU-protected operations
> internally. The core of the problem is that the chmod_common function
> calls the notify_change while holding the inode lock, and the
> notify_change internally relies on the RCU protection mechanism. At a
> specific path to the SYSV file system, this combination results in a
> deadlock.

I'm not following at all but also sysv is removed in v6.15.

