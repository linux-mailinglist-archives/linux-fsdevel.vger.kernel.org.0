Return-Path: <linux-fsdevel+bounces-62434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E593EB93694
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 23:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39B319036AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 21:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B309230ACED;
	Mon, 22 Sep 2025 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yXqaRefF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0015B2F5461;
	Mon, 22 Sep 2025 21:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578277; cv=none; b=ZP+trFEhOQeIK/os87luYnTgBs+4nf/xxYIq0RLnnONcEQM2V/1K77OfIUcnFMfJ1WD+kHXuGBXuKLHiMlj8EgOxf6BZsCv2HpPGD0vhgrx8u/WT73qmZI3zdWlrIbVQkHyMSUmJialGMFPKyTyw9fFYoMkfXkGlwa0zrWiC/4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578277; c=relaxed/simple;
	bh=5ng5om+YUbc2f9wAZBiotwO4O22XuJjCRsZsmZl5Gs4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ACN6ZnKM4qTzG4ODnMR5PHmKl0MMAe9V4zpzcCIMSRr2asIhuqtQyGYLAsaQrHf0D965VVk23aTeic0kkdXAoP9BxsU+2hU/xUxyjgA9gTJQBwL4sCY6uCtkcfa1Jp6kWfGtIeA0iazIs+62AuDlW6p5IrQOHcBkazW+npjeXdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yXqaRefF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668DCC4CEF0;
	Mon, 22 Sep 2025 21:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758578276;
	bh=5ng5om+YUbc2f9wAZBiotwO4O22XuJjCRsZsmZl5Gs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yXqaRefFD0nvm4MspjjswD9cyQdN6nWcxP21ytNPA5noSZqVUMH+T69ARH/960uHO
	 K4MsEtod9SU5B7poouxhjo8Cj9QYKwdC0WjKMduSNYpqJLGppeTukbAbPt4dNUoNfu
	 z3Z9tiNbFRPArANqm+efaP0WN721RjIs/hPmcjpk=
Date: Mon, 22 Sep 2025 14:57:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: Julian Sun <sunjunchao@bytedance.com>, mhiramat@kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 agruenba@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] Suppress undesirable hung task warnings.
Message-Id: <20250922145754.31890092257495f70db3909d@linux-foundation.org>
In-Reply-To: <b31a538a-c361-4e3e-a5b6-6a3d2083ef3b@linux.dev>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
	<b31a538a-c361-4e3e-a5b6-6a3d2083ef3b@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 19:38:21 +0800 Lance Yang <lance.yang@linux.dev> wrote:

> On 2025/9/22 17:41, Julian Sun wrote:
> > As suggested by Andrew Morton in [1], we need a general mechanism
> > that allows the hung task detector to ignore unnecessary hung
> 
> Yep, I understand the goal is to suppress what can be a benign hung task
> warning during memcg teardown.
> 
> > tasks. This patch set implements this functionality.
> > 
> > Patch 1 introduces a PF_DONT_HUNG flag. The hung task detector will
> > ignores all tasks that have the PF_DONT_HUNG flag set.
> 
> However, I'm concerned that the PF_DONT_HUNG flag is a bit too powerful
> and might mask real, underlying hangs.

I think that's OK if the calling task is discriminating about it.  Just
set PF_DONT_HUNG (unpleasing name!) around those bits of code where
it's needed, clear it otherwise.

Julian, did you take a look at what a touch_hung_task_detector() would
involve?  It's a bit of an interface inconsistency - our various other
timeout detectors (softlockup, NMI, rcu) each have a touch_ function.


