Return-Path: <linux-fsdevel+bounces-48483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48DCAAFC36
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 15:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6AF93B162B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565F322DA0D;
	Thu,  8 May 2025 13:58:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDEC22D790;
	Thu,  8 May 2025 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746712725; cv=none; b=WuHtdHXLPJdsnoJLFpNMfFsVAhZaFGhcOIOfAv1rlQaosfsDkw2ItjSyC0Tjjzg6RvWcIaE4MMItL+TgSKZ8qj0ABehYDfyKhXdIXCTV90Msrwi0h4sZsoONN/5niN+kSFV1xd1S3t0WuTZyfiI3X8Llb832xIXqy+wdzMRNEKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746712725; c=relaxed/simple;
	bh=RXu88SI77b0x2ppaQI3PxNj/CQClk7QdVR4i384chtg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pV4d60tiwIp0/l0DFAKIZceanbqUZnWe29CIsnzDrCRgetqDmKSknSE32qs0UbmAYXLTNV/OoN2oCilkNTvvTq2LeE5WgRdrV4OOqCy2DjolrbZBPvNkdEoIUquUbgn/Sytl1oNz3HkwxixgsDXMwo/+sh2XJz4rJGV2yG69ETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3939EC4CEE7;
	Thu,  8 May 2025 13:58:40 +0000 (UTC)
Date: Thu, 8 May 2025 09:58:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bhupesh Sharma <bhsharma@igalia.com>
Cc: Petr Mladek <pmladek@suse.com>, Bhupesh <bhupesh@igalia.com>,
 akpm@linux-foundation.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, mathieu.desnoyers@efficios.com,
 arnaldo.melo@gmail.com, alexei.starovoitov@gmail.com,
 andrii.nakryiko@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org,
 willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk,
 keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org,
 jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v3 3/3] exec: Add support for 64 byte 'tsk->real_comm'
Message-ID: <20250508095852.2d3f7e0b@gandalf.local.home>
In-Reply-To: <751a4217-a506-ecf9-ac9f-1733c7c7c8d9@igalia.com>
References: <20250507110444.963779-1-bhupesh@igalia.com>
	<20250507110444.963779-4-bhupesh@igalia.com>
	<aBtYDGOAVbLHeTHF@pathway.suse.cz>
	<20250507132302.4aed1cf0@gandalf.local.home>
	<751a4217-a506-ecf9-ac9f-1733c7c7c8d9@igalia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 May 2025 13:38:11 +0530
Bhupesh Sharma <bhsharma@igalia.com> wrote:

> >>        something like:
> >>
> >> 	char    comm_ext[TASK_COMM_EXT_LEN];
> >> or
> >> 	char    comm_64[TASK_COMM_64_LEN]  
> > I prefer "comm_ext" as I don't think we want to hard code the actual size.
> > Who knows, in the future we may extend it again!
> >  
> 
> Ok, let me use 'comm_64' instead in v4.

I think you missed what I said. I prefer the comm_ext over comm_64 because
I don't think it's a good idea to hardcode the extended size in the name.
That will make it very difficult in the future if we want to make it even
larger.

-- Steve


