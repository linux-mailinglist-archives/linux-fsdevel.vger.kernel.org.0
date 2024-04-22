Return-Path: <linux-fsdevel+bounces-17402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0DB8AD000
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 16:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5AB1C20BE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0192315250B;
	Mon, 22 Apr 2024 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="erWA+QCB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB2152190;
	Mon, 22 Apr 2024 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797845; cv=none; b=aIjhA3PpHViGc0RNfAWE+1XdLii0xbpXSu/51PWYG/Py0tXTMW+3o0vv7jkzrHQMQz8l5q/cM9ZUwgJEjORB79Yr/ntxlbtyu5kuho4J3NMF7Z+o+7PLLE3QmfiS5rlHWUY0WRaI5VwtPpx1nmWehsJSvoiKNxnl3KbLVN0sTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797845; c=relaxed/simple;
	bh=/ys6Pzra7IEywMh4hBfA5xJtu9C9b7qcLANvkfE5cJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riGM8UWfDPLCZnJ2v7QQNU3mO5f/vIKZ5eJNOf4cIXNdGPkSv5BUv3yIHPs9xZ3Sx1IOw1Mgoa1f0HQnBljnNHsxj8gsl+cIlgf19ql8LEsOS7G4pSJVIba/B15mI7TWtmmBhEVCZd6geNsx8sELihVJBuaoBa1zuJRpIEtUjmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=erWA+QCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B11C113CC;
	Mon, 22 Apr 2024 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713797844;
	bh=/ys6Pzra7IEywMh4hBfA5xJtu9C9b7qcLANvkfE5cJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=erWA+QCBdHASSENTMbmbCLszQVLSQvPHDCWgfW4TwFE/GVWL7ruM5SR//WtQ1W6QM
	 d12zJ3HocPCG90okjpoCMBPNiZ4C2wMBghXJf7jiZrH+0zwnbBY2X6rvcNM+wESAuT
	 kBqxDZqGDGm1bi25Y/5iM9IhfADZv/lx70kLTU88=
Date: Mon, 22 Apr 2024 10:57:23 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Joel Granados <j.granados@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>, josh@joshtriplett.org, 
	Kees Cook <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>, 
	Iurii Zaikin <yzaikin@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Balbir Singh <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	tools@kernel.org
Subject: Re: [PATCH v3 00/10] sysctl: Remove sentinel elements from kernel dir
Message-ID: <20240422-sensible-sambar-of-plenty-ae8afc@lemur>
References: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
 <36a1ea2f-92c2-4183-a892-00c5b48c419b@linaro.org>
 <311c8b64-be13-4740-a659-3a14cf68774a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <311c8b64-be13-4740-a659-3a14cf68774a@kernel.org>

On Mon, Apr 22, 2024 at 04:49:27PM +0200, Krzysztof Kozlowski wrote:
> >> These commits remove the sentinel element (last empty element) from 
> >> the
> >> sysctl arrays of all the files under the "kernel/" directory that use a
> >> sysctl array for registration. The merging of the preparation patches
> >> [1] to mainline allows us to remove sentinel elements without changing
> >> behavior. This is safe because the sysctl registration code
> >> (register_sysctl() and friends) use the array size in addition to
> >> checking for a sentinel [2].
> > 
> > Hi,
> > 
> > looks like *this* "patch" made it to the sysctl tree [1], breaking b4
> > for everyone else (as there's a "--- b4-submit-tracking ---" magic in
> > the tree history now) on next-20240422
> > 
> > Please drop it (again, I'm only talking about this empty cover letter).
> 
> Just to clarify, in case it is not obvious:
> Please *do not merge your own trees* into kernel.org repos. Instead use
> b4 shazam to pick up entire patchset, even if it is yours. b4 allows to
> merge/apply also the cover letter, if this is your intention.
> 
> With b4 shazam you would get proper Link tags and not break everyone's
> b4 workflow on next. :/

I was expecting this to happen at some point. :/

Note, that you can still use b4 and merge your own trees, but you need 
to switch to using a different cover letter strategy:

  [b4]
  prep-cover-strategy = branch-description

-K

