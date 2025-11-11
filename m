Return-Path: <linux-fsdevel+bounces-67961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8588C4EB71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 16:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656E6189792C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BFA35BDA4;
	Tue, 11 Nov 2025 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekN5/IS1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4253587C3;
	Tue, 11 Nov 2025 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873632; cv=none; b=qNzC/J/utZJDUZw6kxK5O42C0jVNpF0ohbc3uNhnzrT7VTQU3KX8u2C5Gk4zCrTzpy8750Nh633Jyv4ipe9RckbkMYw/DinnEEQg+l3iYSFeo7bzNWGwAYKFsxpqrlCIPtjIgGlry2+Q48Tgvn7QH19DwHikBwA43BKiAuY/EmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873632; c=relaxed/simple;
	bh=rlHZcBpWe3kzEeAH+SDvCuLpDVeld7J3UBzo44DCVEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEvn7qjOrcceraEpZXaKuSkeDqQ3VrrwyZJjt+Jov/ZcylB8mKQmcxtvAvGQMPQFMXY0Wrfzt5dZ7tSp050L/Ya9mOZ9HUd6gaylKdS3+gX3vMHFC1bh8IrWSOQTy4r+fH7N6fI0AtlEuxy9ysAA3+houV3XZZ/jroTZnDHFjmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekN5/IS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EE2C16AAE;
	Tue, 11 Nov 2025 15:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762873631;
	bh=rlHZcBpWe3kzEeAH+SDvCuLpDVeld7J3UBzo44DCVEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekN5/IS1XAQbOzF2fQaQfGveWiZCAkhBeJC2SZvd/KKW4qzfDu8ocWpq1Xi44C8cy
	 h1qRz3zGTxdOoQu2fnDBWjCcaI3/VayjGrPKrrX7yFC40tzISd1iRjI0i/VoYY0x/B
	 f0KOG/wd98OA+6ZNo/tAhCVTFEC2/Yrm5LztmEW1sC3ZdT7YF/LnQ64ArE/1xOSIcj
	 a7OJyas5ld/LqP4WYoNpMFJYoELz5PYlEG1I5AFwzk+wOQryFMdBBwJLPkGSlAMn9H
	 sUPzn202D71ve+4Y3hYe4FHlAW/K0zW7VsbKv+U23LlqYOWruYR5sdjRGJFVlLRUhC
	 5bOAaWmfyIVvA==
Date: Tue, 11 Nov 2025 16:07:02 +0100
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
Message-ID: <20251111-gaspipeline-getippt-9b19b62f89d2@brauner>
References: <20251111-covern-deklamieren-ee89b7b4e502@brauner>
 <69133407.a70a0220.22f260.0138.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69133407.a70a0220.22f260.0138.GAE@google.com>

On Tue, Nov 11, 2025 at 05:03:03AM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in __ns_ref_active_put

#syz test: https://github.com/brauner/linux.git namespace-6.19

Groan, forgot the actual important bit after the cleanup:

  * Called from unshare. Unshare all the namespaces part of nsproxy.
  * On success, returns the new nsproxy.
@@ -338,7 +313,7 @@ static void put_nsset(struct nsset *nsset)
        if (nsset->fs && (flags & CLONE_NEWNS) && (flags & ~CLONE_NEWNS))
                free_fs_struct(nsset->fs);
        if (nsset->nsproxy)
-               free_nsproxy(nsset->nsproxy);
+               nsproxy_free(nsset->nsproxy);
 }


