Return-Path: <linux-fsdevel+bounces-25026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22EF947E38
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 17:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B952812C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41EB158DCD;
	Mon,  5 Aug 2024 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpdLnMIv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C83A1547DC;
	Mon,  5 Aug 2024 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872141; cv=none; b=sw8ygbZ6ErX6CBFAb0A4tNWWXCNCh1xyRLo8Zit7tcNsxticZzAH7T8grtNno0fn5ioIjOPDEQe13gWO2Vbzzf0uszSpvmUGgM4f7i1J+5L4zvKFjqUgzOWnEdFrm3sQ92oR/YU3ButABLDZdGqHj3JXvD1GbO/vTHhR6EgqROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872141; c=relaxed/simple;
	bh=fW0hqKtwItjdTsBb9Y5QYMsGWy4TX25zlp03368880A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2snuzInG5BxHCJFiVPuUMhdxuvj2eo30DcBa+I/okB4JL+06VFZYBLnVnLeQsC7JuucneWpRLpkxUFcRtBu32pggs+I0hrPtSTyVdZYb1thDKx76DG4T86iPa++R3qFy+euVZJvO/5v3ppymZSOr3zGq6gvXcVDMZXvrYM2JRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpdLnMIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC12C32782;
	Mon,  5 Aug 2024 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722872140;
	bh=fW0hqKtwItjdTsBb9Y5QYMsGWy4TX25zlp03368880A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KpdLnMIvrnE2kazr1tCu9bKLFuGYeeRMrtD73Xdc6nQW75Jvm4MF7uzZWjHHKmCnX
	 4+NabMXLV+wUtNH2C1kCkjOqQ0OuDBTP6pWT4E1wEfHFNlmzExwevc0kwtOLXIMVMY
	 LbZqLyjFDQ1w5DAbmh877L3DewSs44SsqmeMxSV3zMr0Y0UMyAEhTHkT0OWkQH0a80
	 i7FD0Y2nudS1iB1l+CMwt8mWzzow82Vsw1b9Ng0yhNlH938Ep6yIfuKm86Dz2qpEYd
	 FRATcEn2EEIFgvIcC/0EDzTnTWVBrHBBMhY8/1mbASLDAGsNIbNAEl99/xf8oKHtJe
	 zW0u32xD8Oz/Q==
Date: Mon, 5 Aug 2024 17:35:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, wojciech.gladysz@infogain.com, 
	ebiederm@xmission.com, kees@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] exec: drop a racy path_noexec check
Message-ID: <20240805-denkspiel-unruhen-c0ec00f5d370@brauner>
References: <20240805-fehlbesetzung-nilpferd-1ed58783ad4d@brauner>
 <20240805131721.765484-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240805131721.765484-1-mjguzik@gmail.com>

> To my reading that path_noexec is still there only for debug, not
> because of any security need.

I don't think it's there for debug. I think that WARN_ON_ONCE() is based
on the assumption that the mount properties can't change. IOW, someone
must've thought that somehow stable mount properties are guaranteed
after may_open() irrespective of how the file was opened. And in that
sense they thought they might actually catch a bug.

But originally it did serve a purpose...

> 
> To that end just I propose just whacking it.

... the full history (afaict) is that once upon a time noexec and
whether it was a regular file were checked in (precurors to)
inode_permission().

It then got moved into the callers. The callers also called may_open()
directly afterwards. So the noexec and i_mode check preceeded the call
to may_open() and thus to inode_permission().

Then may_open() got moved into the open helpers but the noexec and
i_mode checks stayed behind. So the order was now reversed. That in turn
meant it was possible to see non-regular file exec requests in
security_inode_permission().

So the order was restored by moving that check into may_open(). At that
time it would've made sense to also wipe the path_noexec() from there.
But having it in there isn't wrong. In procfs permission/eligibility
checks often are checked as close to the open as possible. Worst case
it's something similar here. But it's certainly wrong to splat about it.

