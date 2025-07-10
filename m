Return-Path: <linux-fsdevel+bounces-54494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB56B002EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80201C410B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70D328937F;
	Thu, 10 Jul 2025 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BXhLnWQf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295E71DC9A3;
	Thu, 10 Jul 2025 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752152990; cv=none; b=eyO8VxTpK69M5GBgcJ1918en66YJ7hhl7tz/XPmbEuwNbYZb7d48IewWUYjuw35XvlfB2loeX/u3FAwy37E9SqSvjfEGRHpcbGiZg1XEOor5CnH4M83oXtRPWqeo+ZFjSx77lSM7xXleri94hEh+Pq08LfoYkMiZ6KZSjnix09w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752152990; c=relaxed/simple;
	bh=9xASdcSiViiTi1embbBL3U693uCrSF5deAnifIaM4LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEOw4FdvEa6OJ89WE8x8Fghp3/AF3EZMe+H/6TT4zzL1zntQWDGpuF5oDJ4U1hsmb6qznJfwhIInLcjfORAz85a7r4o1HG0oImRsAoyyFgxUN4NbU0QdmQBHacvPV3Uqzt0Qy4LNPu8JltuCUO0lvlivQKSZVzkCDkVBlEQEx8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BXhLnWQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8FEC4CEE3;
	Thu, 10 Jul 2025 13:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752152990;
	bh=9xASdcSiViiTi1embbBL3U693uCrSF5deAnifIaM4LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BXhLnWQfWFYYQDMjwSpwuYoh860pTnWqcLI1w2yiR/zKQEu720SRtkeQO9CpjgBq/
	 ZIiTu4+dPDcwjaiqcdn44TLyMXa/3+/tVtp43vvUV6pLccAhKUl2M9d80Pbuv7vs03
	 rq7iWVi6U5v5VkZZXnWzC/fNut6mbyV23OjvRfzM=
Date: Thu, 10 Jul 2025 15:09:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Oleg Nesterov <oleg@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Sauerwein, David" <dssauerw@amazon.de>,
	Sasha Levin <sashal@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RESEND PATCH 5.15] fs/proc: do_task_stat: use
 __for_each_thread()
Message-ID: <2025071032-june-ecosystem-7767@gregkh>
References: <20250710-yams-adolf-9eb7e4b2@mheyne-amazon>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-yams-adolf-9eb7e4b2@mheyne-amazon>

On Thu, Jul 10, 2025 at 12:43:18PM +0000, Heyne, Maximilian wrote:
> From: Oleg Nesterov <oleg@redhat.com>
> 
> [ Upstream commit 7904e53ed5a20fc678c01d5d1b07ec486425bb6a ]
> 
> do/while_each_thread should be avoided when possible.
> 
> Link: https://lkml.kernel.org/r/20230909164501.GA11581@redhat.com
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Stable-dep-of: 7601df8031fd ("fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats")
> Cc: stable@vger.kernel.org
> [mheyne: adjusted context]
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> ---
> 
> Compile-tested only.
> We're seeing soft lock-ups with 5.10.237 because of the backport of
> commit 4fe85bdaabd6 ("fs/proc: do_task_stat: use sig->stats_lock to
> gather the threads/children stats"). I'm assuming this is broken on 5.15
> too.

Same here, how does this change anything?

greg k-h

