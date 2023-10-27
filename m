Return-Path: <linux-fsdevel+bounces-1454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1EA7DA311
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 00:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCD3281286
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 22:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4C5405CC;
	Fri, 27 Oct 2023 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ftQp63Qn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FEC3FB02
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 22:05:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8378B1A6;
	Fri, 27 Oct 2023 15:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EYCAyHviKNKDeA9zecSwLrqFG76gAM2TWOZ+GOqwprM=; b=ftQp63QnPUjq81aj92WyGldhDG
	+uZzJoJx8Y+FfGFKEnMpjYdKdF471lvIGABRVDIMB9dotIAxQq6cTyOkg1VhKN91dr4KOIJir5NB3
	ACKnKI6wxCpOmi54sFBBaOj2u+1ANRXFqgs2Qp+tXJiTKZocKOxsFZLdbSYLwrTwo548kzARdw9fB
	pkywDDPt2dINpKJODre8NYRHD/agz0gFfAJcGGVyIgnbZPrB1cNn1FK2noDSmB1E/yHDlof8/nY0f
	F0yL32qof++hnmTAtaJtnPmDO3Q9lQN+4c6x1Fv5LWANlMTLzb9P4uxfhtytmNlppiZHy9IpSFVTS
	5UHYYYZg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qwUwq-00HGYH-0E;
	Fri, 27 Oct 2023 22:04:56 +0000
Date: Fri, 27 Oct 2023 15:04:56 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: Kees Cook <keescook@chromium.org>, Iurii Zaikin <yzaikin@google.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Vlastimil Babka <vbabka@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
	Lecopzer Chen <lecopzer.chen@mediatek.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Hildenbrand <david@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Pingfan Liu <kernelfans@gmail.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Guilherme G. Piccoli" <kernel@gpiccoli.net>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/2] Triggering a softlockup panic during SMP boot
Message-ID: <ZTw0CACF3jtT3/dX@bombadil.infradead.org>
References: <cover.1698441495.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698441495.git.kjlx@templeofstupid.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Oct 27, 2023 at 02:46:26PM -0700, Krister Johansen wrote:
> Hi,
> This pair of patches was the result of an unsuccessful attempt to set
> softlockup_panic before SMP boot.  The rationale for wanting to set this
> parameter is that some of the VMs that my team runs will occasionally
> get stuck while onlining the non-boot processors as part of SMP boot.
> 
> In the cases where this happens, we find out about it after the instance
> successfully boots; however, the machines can get stuck for tens of
> minutes at a time before finally completing onlining processors.  Since
> we pay per minute for many of these VMs there were two goals for setting
> this value on boot: first, fail fast and hope that a subsequent boot
> attempt will be successful.  Second, a panic is a little easier to keep
> track of, especially if we're scraping serial logs after the fact.  In
> essence, the goal is to trigger the failure earlier and hopefully get
> more useful information for further debugging the problem as well.
> 
> While testing to make sure that this value was getting correctly set on
> boot, I ran into a pair of surprises.  First, when the softlockup_panic
> parameter was migrated to a sysctl alias, it had the side effect of
> setting the parameter value after SMP boot has occurred, when it used to
> be set before this.  Second, testing revealed that even though the
> aliases were being correctly processed, the kernel was reporting the
> commandline arguments as unrecognized. This generated a message in the
> logs about an unrecognized parameter (even though it was) and the
> parameter was passed as an environment variable to init.
> 
> The first patch ensures that aliased sysctl arguments are not reported
> as unrecognized boot arguments.
> 
> The second patch moves the setting of softlockup_panic earlier in boot,
> where it can take effect before SMP boot beings.

Sounds all great but I only got the cover letter, so may be resend?

  Luis

