Return-Path: <linux-fsdevel+bounces-60709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFCFB5038D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 19:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75AAE1C67339
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01CB36CC6F;
	Tue,  9 Sep 2025 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n27gCPnh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0656035CECD
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437021; cv=none; b=GMxF82GAZbpzsPULdCvkE75cPVsWexJKIHRYng8tIqjiYez+POqxR/bk01QVdvgpu95sRSqX5MHq+tzB9VogOHoeiHS2XdqW9Jys51mWaUR7t6S6cy/unv7hqyoL2rYQ6MEecKfE/qQyBuid92rgLN1HoDBy5WpZrSXmDahmr7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437021; c=relaxed/simple;
	bh=uqpDAGosien1SeQ7c+4lEgfxREFgztyI5rUxEsj2F3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsPRnMiQ/prZmQirOBJlJCyz6yONLFMCSfFlUTWxf/FiHT2r9bHeBN5Ck13VuHMJpqL/Rem+EW2ql+L7Fe0UfTl+tT1f3Q14jIs+fLYmujpEBbmSBJDa0uNrH3HrJ8044WPvXcPrOQd6hbCk/rftUHzTP8LqlgbN+jtm85zPs1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n27gCPnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727DBC4CEF8;
	Tue,  9 Sep 2025 16:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757437020;
	bh=uqpDAGosien1SeQ7c+4lEgfxREFgztyI5rUxEsj2F3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n27gCPnhB0pzmrD36IQyk8v8jtGtD5nfINvwKogbcYDDsAhNdJhKAbdsN/YZSPiP0
	 g4z6PBzTTL7d1AUhv30XWJ5kPSNTbWl9kx8SrACA+mX5uLELQ/D/XguZcybCnyX3ea
	 O0bixqSpFK1nQ/16/OF6ZcILlwPsrFkV9Yz9foZRmpqH7LMJ+DoZr9aH47VGpXUMUS
	 Q7jOIsuHL4z334yA6BOcrGfxZjF3QSC2Cv6Wp6gYlz5lvopbXFA4th8bnMVqEgsidq
	 KyuZ4bGaXfICtCxVBRRKB99eCXBl8HosY6Qx39BOu1wHh/Au955v3XDbBZCJ0bKRYX
	 ModkZ6rv7weGA==
Date: Tue, 9 Sep 2025 06:56:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] writeback: Avoid excessively long inode switching
 times
Message-ID: <aMBcW0yZJcuXpjW0@slm.duckdns.org>
References: <20250909143734.30801-1-jack@suse.cz>
 <20250909144400.2901-7-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909144400.2901-7-jack@suse.cz>

On Tue, Sep 09, 2025 at 04:44:04PM +0200, Jan Kara wrote:
> With lazytime mount option enabled we can be switching many dirty inodes
> on cgroup exit to the parent cgroup. The numbers observed in practice
> when systemd slice of a large cron job exits can easily reach hundreds
> of thousands or millions. The logic in inode_do_switch_wbs() which sorts
> the inode into appropriate place in b_dirty list of the target wb
> however has linear complexity in the number of dirty inodes thus overall
> time complexity of switching all the inodes is quadratic leading to
> workers being pegged for hours consuming 100% of the CPU and switching
> inodes to the parent wb.
> 
> Simple reproducer of the issue:
>   FILES=10000
>   # Filesystem mounted with lazytime mount option
>   MNT=/mnt/
>   echo "Creating files and switching timestamps"
>   for (( j = 0; j < 50; j ++ )); do
>       mkdir $MNT/dir$j
>       for (( i = 0; i < $FILES; i++ )); do
>           echo "foo" >$MNT/dir$j/file$i
>       done
>       touch -a -t 202501010000 $MNT/dir$j/file*
>   done
>   wait
>   echo "Syncing and flushing"
>   sync
>   echo 3 >/proc/sys/vm/drop_caches
> 
>   echo "Reading all files from a cgroup"
>   mkdir /sys/fs/cgroup/unified/mycg1 || exit
>   echo $$ >/sys/fs/cgroup/unified/mycg1/cgroup.procs || exit
>   for (( j = 0; j < 50; j ++ )); do
>       cat /mnt/dir$j/file* >/dev/null &
>   done
>   wait
>   echo "Switching wbs"
>   # Now rmdir the cgroup after the script exits
> 
> We need to maintain b_dirty list ordering to keep writeback happy so
> instead of sorting inode into appropriate place just append it at the
> end of the list and clobber dirtied_time_when. This may result in inode
> writeback starting later after cgroup switch however cgroup switches are
> rare so it shouldn't matter much. Since the cgroup had write access to
> the inode, there are no practical concerns of the possible DoS issues.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

