Return-Path: <linux-fsdevel+bounces-67898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05274C4D056
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B719188442E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DB034BA31;
	Tue, 11 Nov 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+gQANG+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC08B340275;
	Tue, 11 Nov 2025 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856795; cv=none; b=R+pbQo9smaY5AycsYq43bsXBDcRHtvBHsVv7obCkxzDujhd0LAUhM9JisTT1XEzAbBvxux374YFNKn6t/0TZXtkwpT9+us23+jfxNTkCE20zyvnEPLcN8JOce6UWYPQGDPVD0C8AY2QEmxbGOHsbZmzIb+23ZrQGrytHbiBB6qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856795; c=relaxed/simple;
	bh=ZFmSKSzww2nd88jhXy9fnDkVPC8RGIF3BfU2aAp/Ois=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEhkzBWO6BTfyJSiN7tezztURQwobrsrx0s86bpT0E0Qh7sExUUSytajOvESOtXm6ZUQ1V4tznJZTxjNkehtdU3AHAabsFApADyi6/qs+bRaxUtEd6e2thuGBP9+fN4j+yUspP+9UO7PEqHooDB+TbEqmqp7FPAJlrvWMT/+uUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+gQANG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D584C4CEF7;
	Tue, 11 Nov 2025 10:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762856794;
	bh=ZFmSKSzww2nd88jhXy9fnDkVPC8RGIF3BfU2aAp/Ois=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+gQANG+7egL6t5GUK+eCidFmr3UuP7Wp4UMLin5Nw8rpGOqF9w9FnHfo0bgUlh7z
	 Hrc8YOfMH+fQYgnd9Lbxq+GBlTlSQBCsKjVPX8MQlI4MIoZqhwLLtAn0I3DnQnMTOw
	 KcliZkNR2+mzIwmIV8DL74kbHA/EM8UuEPyNev1QrrjeKFLJx5ffNn/XV+hZInt7Ju
	 UdSlVRE4Dvu3bgj+WGaB+oS+uxXtipXzGfzvea/ZGZcWFZIiTG7Ws3KelpnLs+GVez
	 mmGY+Ytz8gNOUsOT+ASDs4FqyemnLkPwNFlU8W6yf5Z9h4eohw6nYvJTDCefh/p7x6
	 TMwb+7Hfu+UwA==
Date: Tue, 11 Nov 2025 11:26:25 +0100
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
Message-ID: <20251111-anbraten-suggerieren-da8ca707af2c@brauner>
References: <20251111-lausbub-wieweit-76ec521875b2@brauner>
 <691305db.a70a0220.22f260.0130.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <691305db.a70a0220.22f260.0130.GAE@google.com>

On Tue, Nov 11, 2025 at 01:46:03AM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in __ns_ref_active_put

#syz test: https://github.com/brauner/linux.git namespace-6.19.fixes

