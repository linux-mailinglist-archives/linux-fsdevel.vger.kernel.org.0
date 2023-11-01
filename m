Return-Path: <linux-fsdevel+bounces-1765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DD47DE642
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 20:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38364281310
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 19:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9BE18E2A;
	Wed,  1 Nov 2023 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lmKoLm69"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A014000
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 19:10:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E27F7;
	Wed,  1 Nov 2023 12:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4RmhHqVU+OcQi9a5wWVvmwhy6cSHOIi3XcghAi7uKUw=; b=lmKoLm69Vx/JuCLHrKTwyI0Ifl
	d+5mQVFyEXY+rMHBviWPDA1ev0OID67NyVavp1YQFWgo8+CM4cWHDk6nQmWt3AGCQVjY5ZsvtJqda
	kFxk3ho6mya9HS0zse7jZUfVd1MAAbHE0rpTHG39wUcM8o+L7tghsE2O7BybkVcxVDURbysEFQp8C
	l4ptP56313Xfyfsr7X2nz2uGRjTUDCyVHn40O5M4WSAczXTalGiYeJurc18076Axk5xOKOmXLOzXZ
	AtEimsLTPkiAdD91a10O9f6KRlb4EB7OCdeC6tLtNKTIcHZbH2YBKbfDay75+TkLnNHdnw97fZUlv
	I3eN+Yeg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qyGbv-007zqf-1O;
	Wed, 01 Nov 2023 19:10:39 +0000
Date: Wed, 1 Nov 2023 12:10:39 -0700
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
Message-ID: <ZUKir3Qe+7M/aqmv@bombadil.infradead.org>
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

Thanks! Looks good, merged and will push to Linus soon.

  Luis

