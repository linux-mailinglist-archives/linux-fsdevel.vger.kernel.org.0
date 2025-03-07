Return-Path: <linux-fsdevel+bounces-43425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BBBA56900
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A2B188BEA0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 13:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB73219A94;
	Fri,  7 Mar 2025 13:32:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A469F23CE
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354327; cv=none; b=tpJ+S8XuZavs1/HFgfSzEi3R88kd3utcTEAb5Ok8fS4vGBBGcE/dT0VNB2HT7krHBCA3/xF6t+mE9skurkCdkEsr3PNNbIIYKyT4JNxHu8aHbfWoP9p34G7P2Iryw5eaXWvkV44dm7tAi8TlQvnswSEQZnKL/wJrfQaLvWqtLsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354327; c=relaxed/simple;
	bh=Rk3HTJSdGsZ/NrV0XqotfCYqlViFG6WGB56pcYsPR1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiYu4b+waNSIPQIsFTY9Cc003hkusjwWJX1xXJh4o2aG+3p5mMSQ5CF2Rv4Vg3Ufr/nXwGIweD7hozWVPF+Fz4sFWtZvg3ddM24c80AV9md4atlN2famTSRCD4686n5dJ2/64bIdOmOA6C2ZpQHBiHeDkdUNWpc1Ok7kbm6Kzeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-49.bstnma.fios.verizon.net [173.48.112.49])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 527DVQBt029743
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Mar 2025 08:31:27 -0500
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 8E4FE2E010B; Fri, 07 Mar 2025 08:31:26 -0500 (EST)
Date: Fri, 7 Mar 2025 08:31:26 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Hector Martin <marcan@marcan.st>,
        syzbot <syzbot+4364ec1693041cad20de@syzkaller.appspotmail.com>,
        broonie@kernel.org, joel.granados@kernel.org, kees@kernel.org,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] general protection fault in proc_sys_compare
Message-ID: <20250307133126.GA8837@mit.edu>
References: <67ca5dd0.050a0220.15b4b9.0076.GAE@google.com>
 <239cbc8a-9886-4ebc-865c-762bb807276c@marcan.st>
 <ph6whomevsnlsndjuewjxaxi6ngezbnlmv2hmutlygrdu37k3w@k57yfx76ptih>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ph6whomevsnlsndjuewjxaxi6ngezbnlmv2hmutlygrdu37k3w@k57yfx76ptih>

On Fri, Mar 07, 2025 at 06:51:23AM -0500, Kent Overstreet wrote:
> 
> Better bisection algorithm? Standand bisect does really badly when fed
> noisy data, but it wouldn't be hard to fix that: after N successive
> passes or fails, which is unlikely because bisect tests are coinflips,
> backtrack and gather more data in the part of the commit history where
> you don't have much.

My general approach when handling some test failure is to try running
the reproducer 5-10 times on the original commit where the failure was
detected, to see if the reproducer is reliable.  Once it's been
established whether the failure reproduces 100% of the time, or some
fraction of the time, say 25% of the time, then we can estalbish how
times we should try running the reproducer before we can conclude the
that a particular commit is "good" --- and the first time we detect a
failure, we can declare the commit is "bad", even if it happens on the
2nd out of the 25 tries that we might need to run a test if it is
particularly flaky.

Maybe this is something Syzbot could implement?

And if someone is familiar with the Go language, patches to implement
this in gce-xfstests's ltm server would be great!  It's something I've
wanted to do, but I haven't gotten around to implementing it yet so it
can be fully automated.  Right now, ltm's git branch watcher reruns
any failing test 5 times, so I get an idea of whether a failure is
flaky or not.  I'll then manually run a potentially flaky test 30
times, and based on how reliable or flaky the test failure happens to
be, I then tell gce-xfstests to do a bisect running each test N times,
without having it stop once the test fails.  It wasts a bit of test
resources, but since it doesn't block my personal time (results land
in my inbox when the bisect completes), it hasn't risen to the top of
my todo list.

Cheers,

					- Ted

