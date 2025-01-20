Return-Path: <linux-fsdevel+bounces-39678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F25A16EC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 15:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2C1188050A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 14:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005C61E3DED;
	Mon, 20 Jan 2025 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ35l5xq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7C21E0E15;
	Mon, 20 Jan 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737384523; cv=none; b=ODlMdpFIZZvRyMZtrzjx3pfP/I6CauS9zQ0E+aeApmiIgwedLNxY3XqqducaFK12DpgXAHknDbP8WEpZ5KBhSKZhf+r5+siM06yZX6xqLZLMa0VogEZ4H1a8whn0lcrIPU1pA3mRqTlhxZgvwjA6rYyjFY5KUHZz+ukN0TdM9DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737384523; c=relaxed/simple;
	bh=2HBvFH+2G/9d3WwdJ8gi7ozfTW+xMJRiUKu+XfHr74Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+7YAXFg2v5P5juede0CLk7VndqYC4bOi+sFjTtFLshocpDxxmACP00AjlM+VWjJ3qpNV11BGNVygx5ZZS/Cowj3Gk4nPumX+UHwtlWKCZOYWiTsMkmkU2mL18aFpexYR86mq9QbHXbcNfKGX02oGuxFCXgyEG0lrZYkUXNdsyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ35l5xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0093BC4CEDD;
	Mon, 20 Jan 2025 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737384522;
	bh=2HBvFH+2G/9d3WwdJ8gi7ozfTW+xMJRiUKu+XfHr74Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fZ35l5xqhfWRdaqVfQS2MYtj9GlZ+46lCHSUqrE+SauGVCCWizHx6koD+FFve8JX4
	 wf5fAAA07pPWFaOnMIKnAN2vUVGivR3ZiNFgkbgjSO30BhPNFGlIMgJMGppmxXSRSH
	 +tnoCRYq7aplX7x0GpYgzD8s5QKOoKjvhW6yPN1ljran1grPNC8sBj2KT6kewI1RiS
	 XN8JD3KkvA2Yhruo9EBHMHm2wnwdMieQOjCKQ6r+vIpvRBpYO4N2nWiTcUpMAborAR
	 TgfUnIKMy/p8d6JbWZ9uxd+CtedZ9YgtoDVSJgRABybA/gnB9f9zGj4/TbATdEmI4C
	 KOvxhyy6WaOnQ==
Date: Mon, 20 Jan 2025 15:48:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, tavianator@tavianator.com, linux-mm@kvack.org, 
	akpm@linux-foundation.org
Subject: Re: [RESEND PATCH] fs: avoid mmap sem relocks when coredumping with
 many missing pages
Message-ID: <20250120-mutig-umgewandelt-4ced736ffe30@brauner>
References: <20250119103205.2172432-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250119103205.2172432-1-mjguzik@gmail.com>

On Sun, Jan 19, 2025 at 11:32:05AM +0100, Mateusz Guzik wrote:
> Dumping processes with large allocated and mostly not-faulted areas is
> very slow.
> 
> Borrowing a test case from Tavian Barnes:
> 
> int main(void) {
>     char *mem = mmap(NULL, 1ULL << 40, PROT_READ | PROT_WRITE,
>             MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE, -1, 0);
>     printf("%p %m\n", mem);
>     if (mem != MAP_FAILED) {
>             mem[0] = 1;
>     }
>     abort();
> }
> 
> That's 1TB of almost completely not-populated area.
> 
> On my test box it takes 13-14 seconds to dump.
> 
> The profile shows:
> -   99.89%     0.00%  a.out
>      entry_SYSCALL_64_after_hwframe
>      do_syscall_64
>      syscall_exit_to_user_mode
>      arch_do_signal_or_restart
>    - get_signal
>       - 99.89% do_coredump
>          - 99.88% elf_core_dump
>             - dump_user_range
>                - 98.12% get_dump_page
>                   - 64.19% __get_user_pages
>                      - 40.92% gup_vma_lookup
>                         - find_vma
>                            - mt_find
>                                 4.21% __rcu_read_lock
>                                 1.33% __rcu_read_unlock
>                      - 3.14% check_vma_flags
>                           0.68% vma_is_secretmem
>                        0.61% __cond_resched
>                        0.60% vma_pgtable_walk_end
>                        0.59% vma_pgtable_walk_begin
>                        0.58% no_page_table
>                   - 15.13% down_read_killable
>                        0.69% __cond_resched
>                     13.84% up_read
>                  0.58% __cond_resched
> 
> Almost 29% of the time is spent relocking the mmap semaphore between
> calls to get_dump_page() which find nothing.
> 
> Whacking that results in times of 10 seconds (down from 13-14).
> 
> While here make the thing killable.
> 
> The real problem is the page-sized iteration and the real fix would
> patch it up instead. It is left as an exercise for the mm-familiar
> reader.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---

Seems like a good improvement to me.
Let's get it tested.

