Return-Path: <linux-fsdevel+bounces-67914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF9BC4D72A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 12:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2447B342A14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6223570A9;
	Tue, 11 Nov 2025 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pehIauIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A563587DD;
	Tue, 11 Nov 2025 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861091; cv=none; b=Mwwq/flb8tsP3OhebVdx7obxD9Vzb8MFl2QucUPdnm/P65l7hIKTEyO9tjqhuEYqdziAByDQGctP1Ye33vmnY31WZm8dl6WFxneGrlqhhApJ0e1k++wzf6IGb9lR7/hdOM80SP5iO18uC7pGMUdbOwjfb0ENofZlIaGm/KxJRWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861091; c=relaxed/simple;
	bh=S5ADycSWwbo0oJWVKz2x3KxEOZjqckRPgZDiM27t/rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1pQD+hm21pM7vUw7yfrfdaYCi+fu2CEtrzEpWgQvteLBr/LbJcWs5b5UeNS6bhbg18Dd1T9HpUfObjyiaDZ5CvGcaFmq4buzE3HCRSp+qtPpu1dGvCeyJuR1h+QsASyU5h7Lz8Y23AujoH8N0Xqb6Ak2zW7IOmQSgMuU9Y+FKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pehIauIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F297C16AAE;
	Tue, 11 Nov 2025 11:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762861091;
	bh=S5ADycSWwbo0oJWVKz2x3KxEOZjqckRPgZDiM27t/rQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pehIauIKsvbG2Zaq34KTP+At5gcHBNcZbQobMUyuKcOxAdDZQDOP354dlL4pEJ7fp
	 gaCiwaZldy/pbEG/0s4HzQKCYKX32zOmCuPXvsyun5gS9Gm/POQumZkf2tNu4rbfWj
	 KDwHoMeUsKpfTUr2/bStcGQ3mTOrbx6apq2IT/axS/bTLCdTuoNHUMxH8KZVbwyKCy
	 bvLApif2hwTDRRBDOhHt6BTci3bIiuYHkhBCWaMksEE3/Gtd41qx2NIiQQTkXwQtVD
	 F6N1w0xfHL708CF80dEG1rkteHA7tKb+HsilhNtknYFOSPkJBmvsMam0SDsdewC9mC
	 +cmbb9FXIrilQ==
Date: Tue, 11 Nov 2025 12:38:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, bpf@vger.kernel.org, bsegall@google.com, 
	david@redhat.com, dietmar.eggemann@arm.com, jack@suse.cz, jsavitz@redhat.com, 
	juri.lelli@redhat.com, kartikey406@gmail.com, kees@kernel.org, liam.howlett@oracle.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, lorenzo.stoakes@oracle.com, mgorman@suse.de, mhocko@suse.com, 
	mingo@redhat.com, mjguzik@gmail.com, oleg@redhat.com, paul@paul-moore.com, 
	peterz@infradead.org, rostedt@goodmis.org, rppt@kernel.org, sergeh@kernel.org, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com
Subject: Re: [syzbot] [fs?] WARNING in nsproxy_ns_active_put
Message-ID: <20251111-covern-deklamieren-ee89b7b4e502@brauner>
References: <20251111-anbraten-suggerieren-da8ca707af2c@brauner>
 <691317ab.a70a0220.22f260.0135.GAE@google.com>
 <20251111-dozent-losgefahren-0a3a086b293e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111-dozent-losgefahren-0a3a086b293e@brauner>

On Tue, Nov 11, 2025 at 12:23:18PM +0100, Christian Brauner wrote:
> On Tue, Nov 11, 2025 at 03:02:03AM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot tried to test the proposed patch but the build/boot failed:
> 
> I think that's unrelated. Anyway, I managed to point this to the wrong
> branch. I'll send another test request in a bit.

#syz test: https://github.com/brauner/linux.git namespace-6.19

