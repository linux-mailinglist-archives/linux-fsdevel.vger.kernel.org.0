Return-Path: <linux-fsdevel+bounces-25425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA4694C061
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 16:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9121C25528
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A026018EFD3;
	Thu,  8 Aug 2024 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uceui2MV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089EB18C346;
	Thu,  8 Aug 2024 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129097; cv=none; b=f1PLL/5X+F2CjIcRO8EQhGyL5eRtiAtPgpA4rb4EiBj/jjLhnfHj7LMcednE5ljfOUHbv0yTdk3ZU6PvERSWeIM+asp2tgxj/ETmHWyYmApWuaaZ9/kzoq32lLx23v6Ye0iePiuSDN9pdJlN5zF4AwIjAcf9EVpyabIqrpx2RpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129097; c=relaxed/simple;
	bh=NsNKDWui3rAIcAyqOlICEDrazl+1Yxm/DlMsdmERQ0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAtmFQCJxe1HXgoKDAqxvlBKp412h475LznEmeGd1x4SFZGjE0Oxv9Uj9MhHwrxP2OjHpjH/pSHY4ISGyjE6LjqSTAKHjA93EWvQ++J+MMAN/+/7YcS+PovVwBDfYRMejJZ7u6oQqUMAu9Ifzv9XDm/H6NfdeYQ9sSaTn6WO4ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uceui2MV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FA3C32782;
	Thu,  8 Aug 2024 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723129096;
	bh=NsNKDWui3rAIcAyqOlICEDrazl+1Yxm/DlMsdmERQ0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uceui2MVGRgMVhWl/LMgqBHCLjWGIHkE1TSRnSt+VeAySe4tKyPTA0EcbNvVNvm9F
	 FrV3U/MjcSdw9GkIbHZxQFPPKfYs8LpzAxuG0hpdzgO0Jo43KVDYZAEGcmqfYujWGt
	 50bYf/8MYjkii4l4zYpJR0z1NHaKULE82/U+iOo6SVRMXAivsoumf7objyjQmmiPL6
	 ztrnFoaYK7yOaW1KsFG52S76dyy4uf1hDhT9bSwxPRz/GVWcFG4QEfuwoml1x/i8oE
	 cqVJ8NcNidaRb0d0GscVMgGKkywlASeV58CROLrj53Isfj9aAjeGVx3jBwYYDoDE8T
	 fzoLQuwYUivaw==
Date: Thu, 8 Aug 2024 16:58:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Morten Hein Tiljeset <morten@tiljeset.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Debugging stuck mount
Message-ID: <20240808-kontinental-knauf-d119d211067e@brauner>
References: <22578d44-b822-40ff-87fb-e50b961fab15@app.fastmail.com>
 <20240808-hangar-jobverlust-2235f6ef0ccb@brauner>
 <e244e74d-9e26-4d4e-a575-ea4908a8a893@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e244e74d-9e26-4d4e-a575-ea4908a8a893@app.fastmail.com>

On Thu, Aug 08, 2024 at 04:20:43PM GMT, Morten Hein Tiljeset wrote:
> > It's likely held alive by some random file descriptor someone has open.
> > IOW, try and walk all /proc/<pid>/fd/<nr> in that case and see whether
> > anything keeps it alive.
> 
> Thanks for the suggestion, but I've already tried the equivalent of that by
> using a debugger to find the superblock in question and then walking all open
> fds and comparing the superblock pointer. I've validated that this approach
> works in a synthetic example where I create a new namespace, mount the
> filesystem under /mnt, run a program to open /mnt/foo and lazy unmount /mnt.
> 
> Walking procfs seems less precise. I've tried iterating through /proc/*/fd/*
> and comparing the Device entry of stat -L, also without luck.

The file descriptor could already be closed but the task could be stuck
exiting and so queued task work including destroying files wouldn't be
done yet. You could also try and see if you can figure out what tasks
require your workload to do a lazy umount in the first place. That might
bring you closer to the root cause.

What kernel version are you running anyway?

