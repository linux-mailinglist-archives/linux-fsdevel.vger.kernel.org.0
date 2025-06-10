Return-Path: <linux-fsdevel+bounces-51080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3167AD2ADA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 02:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863FC16CF7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 00:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C793595B;
	Tue, 10 Jun 2025 00:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QaHON5fU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA73171CD;
	Tue, 10 Jun 2025 00:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749514680; cv=none; b=a8VQgmeqA9aWYTkKWVnQEgq/5L7z1HWSqRvUzyi/KzyVo3zXiIsbbjAoUKD8FnxC8fo3G4K5Sc1ccAl+jwTQHSFRHWYaS7MN6Kim8tJGpcuSgBItcIvyGuN+d11eyaalsa15XFOihmRGf0ndtGeHPf37TbS6zumAKt9GHFV3Te0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749514680; c=relaxed/simple;
	bh=otKscOGsiwswJAP2raTv6afdx7wYswde19W4gMqQ4qw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uBiYCquYVbG1Xt24tHyIxzOLzZerzX8HXRV0G9ZZPZdPi7xeUpZu4gPmNlIDSE/yCVIMBCMXmvm6AMRionhggK1qx5EemevAYcQVHO1s8obK5fc3FXVMIndb7SSHX7IWqOkSA+8MxuDuJr0bPqqbMI8haFmgNLo0TWsRo32fytY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QaHON5fU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDBEC4CEEB;
	Tue, 10 Jun 2025 00:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749514679;
	bh=otKscOGsiwswJAP2raTv6afdx7wYswde19W4gMqQ4qw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QaHON5fU8ZUwLLicgsjDySztS0Qr9fDJet8az4Kqx27A+rUQhPyaEX26oVuy/DOhE
	 BwKCfrYiz5+IpbTqKVW4QoeMr8zmTm+RAr6I68IuFLThnS0Zr745A9tVfzhqm4njGE
	 XF0hOptAcc8kKvM8y8fve8y/73P0Z3cNTKxjRnP4=
Date: Mon, 9 Jun 2025 17:17:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Michal Hocko <mhocko@suse.com>,
 david@redhat.com, shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
 donettom@linux.ibm.com, aboorvad@linux.ibm.com, sj@kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix the inaccurate memory statistics issue for
 users
Message-Id: <20250609171758.afc946b81451e1ad5a8ce027@linux-foundation.org>
In-Reply-To: <06d9981e-4a4a-4b99-9418-9dec0a3420e8@suse.cz>
References: <f4586b17f66f97c174f7fd1f8647374fdb53de1c.1749119050.git.baolin.wang@linux.alibaba.com>
	<87bjqx4h82.fsf@gmail.com>
	<aEaOzpQElnG2I3Tz@tiehlicka>
	<890b825e-b3b1-4d32-83ec-662495e35023@linux.alibaba.com>
	<87a56h48ow.fsf@gmail.com>
	<4c113d58-c858-4ef8-a7f1-bae05c293edf@suse.cz>
	<06d9981e-4a4a-4b99-9418-9dec0a3420e8@suse.cz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Jun 2025 10:56:46 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 6/9/25 10:52 AM, Vlastimil Babka wrote:
> > On 6/9/25 10:31 AM, Ritesh Harjani (IBM) wrote:
> >> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> >>
> >>> On 2025/6/9 15:35, Michal Hocko wrote:
> >>>> On Mon 09-06-25 10:57:41, Ritesh Harjani wrote:
> >>>>>
> >>>>> Any reason why we dropped the Fixes tag? I see there were a series of
> >>>>> discussion on v1 and it got concluded that the fix was correct, then why
> >>>>> drop the fixes tag?
> >>>>
> >>>> This seems more like an improvement than a bug fix.
> >>>
> >>> Yes. I don't have a strong opinion on this, but we (Alibaba) will 
> >>> backport it manually,
> >>>
> >>> because some of user-space monitoring tools depend 
> >>> on these statistics.
> >>
> >> That sounds like a regression then, isn't it?
> > 
> > Hm if counters were accurate before f1a7941243c1 and not afterwards, and
> > this is making them accurate again, and some userspace depends on it,
> > then Fixes: and stable is probably warranted then. If this was just a
> > perf improvement, then not. But AFAIU f1a7941243c1 was the perf
> > improvement...
> 
> Dang, should have re-read the commit log of f1a7941243c1 first. It seems
> like the error margin due to batching existed also before f1a7941243c1.
> 
> " This patch converts the rss_stats into percpu_counter to convert the
> error  margin from (nr_threads * 64) to approximately (nr_cpus ^ 2)."
> 
> so if on some systems this means worse margin than before, the above
> "if" chain of thought might still hold.

f1a7941243c1 seems like a good enough place to tell -stable
maintainers where to insert the patch (why does this sound rude).

The patch is simple enough.  I'll add fixes:f1a7941243c1 and cc:stable
and, as the problem has been there for years, I'll leave the patch in
mm-unstable so it will eventually get into LTS, in a well tested state.

