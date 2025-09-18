Return-Path: <linux-fsdevel+bounces-62171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59227B86FC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 23:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729631C209D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 21:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ED92FBE0F;
	Thu, 18 Sep 2025 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0IiWOYqd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF6E2F3C03;
	Thu, 18 Sep 2025 20:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229190; cv=none; b=PdpE1nTfQxdC+u0CQ7th8suu+j+5a6F5qLSozZXteJ1S/cM7bXKERrcO6WyJ0YdgAxKLmg+3r2TClAo23R2+nQtP3Ll87FahGvpCD9UHTgJBqviE/NXC+WuEHKwZTYqKk1zyLcTAEcivf5QopIVkxOJ5nq77HS/2tkARD9fICQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229190; c=relaxed/simple;
	bh=elOhek8sIU44GYAtre1DnN6ZeNY6fSeRLQXHd5WnQrQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CLXDEG6aDBJRDyqkqnnEjZO/PyKDQwGPozRR7DuizMy5RJlJZii6Yk8DmFdivIYIfJLxkaYIcH98/ZZGAbuBOqP5wKHP89/24tBJaYpqg/JJ0lbqIKBBF2V/C2PTu5XT4pvtu1npuYwXWK9VnyFfJGiHYAaDS0dCl1TEE96CiOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0IiWOYqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F17CC4CEE7;
	Thu, 18 Sep 2025 20:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758229189;
	bh=elOhek8sIU44GYAtre1DnN6ZeNY6fSeRLQXHd5WnQrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0IiWOYqdGBx5hvY1ckMxBqlziJs5ywHDrD8bc3p4KEQ+/unJWdMR6cAFZ5LztZtz4
	 tGUeXgnad3ckGnURulgoAObqqeDPibMEE8JFGibkowfhv9rknk7PftaPGmLbr4Rb1s
	 R6Snd9ceQES6mfnhzrNLgQ5AnRfzcDTu6ExYwZZE=
Date: Thu, 18 Sep 2025 13:59:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Kalesh Singh
 <kaleshsingh@google.com>, minchan@kernel.org, Liam.Howlett@oracle.com,
 rppt@kernel.org, pfalcato@suse.de, kernel-team@android.com,
 android-mm@google.com, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook
 <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn
 <jannh@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/7] vma count: fixes, test and improvements
Message-Id: <20250918135946.4f4432e0c69a465c89af14aa@linux-foundation.org>
In-Reply-To: <7e3de8d3-c064-4ef4-85f8-48294a238336@lucifer.local>
References: <20250915163838.631445-1-kaleshsingh@google.com>
	<20250915153401.61cbd5120871ee7a4e5b9cae@linux-foundation.org>
	<aa95777a-8012-4d08-abcf-7175f9e2691c@lucifer.local>
	<20250916191645.15aae276992acafe7f7e723e@linux-foundation.org>
	<e85d0b14-28dd-418f-872e-57c0127ad572@lucifer.local>
	<20250917163231.b5f7b8012367f033a91e6f9b@linux-foundation.org>
	<cfabded7-442e-40d9-963a-597a42da581e@lucifer.local>
	<0c068e35-0954-43fd-b3b3-20786a6a12fe@redhat.com>
	<7e3de8d3-c064-4ef4-85f8-48294a238336@lucifer.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 13:49:33 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> > > I'm confused, why is the merge window a good time to consider new material?
> > >
> > > People have the entirety of the cycle to submit new material, and they do
> > > so.
> >
> > My view is that if you are sending a cleanup/feature during the merge window
> > you cannot expect a fast reply, and you should not keep sending new versions
> > in that timeframe expecting that all people you CCed that should have a look
> > actually did have a look.
> 
> Yes exactly.
> 
> The problem is all the conversations and respins and etc. _do_ carry on as
> normal, and often land in mm-new, queued up for mm-unstable etc. unless we
> happen to notice them.
> 
> So it makes it impossible for us to just ignore until the next cycle (or need to
> go through every thread that happened afterwards).
> 
> And people know that, so just keep on submitting as normal. That was _really_
> palpable last merge window.
> 

Well, what else do we have to do during the merge window?  The previous
cycle's batch is merged up and there may be some fallout from that, but
it isn't very time-consuming.

If you're proposing that we start to use that period as a break for
sanity purposes then OK, didn't see that one coming, don't know how
widespread this desire is.

But perhaps a better time for this quiet period is during -rc6 and -rc7
when the rate of merging is throttled right back.  Or perhaps from -rc7
to mid-merge-window.


