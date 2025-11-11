Return-Path: <linux-fsdevel+bounces-67913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E088C4D670
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 12:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B763B4B47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662A13559C4;
	Tue, 11 Nov 2025 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQi5GVpX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE72F90DE;
	Tue, 11 Nov 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762860207; cv=none; b=r0c1UI9IDtuYtYWVsfViZTQ9yy3Iuaqm0EHCx03nhSPwewNm9babyOA0xkPZs/Gj5GI0Zj4l4Rj2vsLzHRNZC9PxxWkodw6JQFqJiSmg0JgKHIyO021NOi026CYNbsECRBp05I5Iis3qb35OG90tSKmWhd/Vt8dmhqTkQbLb7Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762860207; c=relaxed/simple;
	bh=Thw9gqzu/5zeb1wIIdMk1FSZcopEkspAzVBeJtniQYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6jZMDxTolXOEmI/EKei47iL+V9TNVBvRzmZhnxoJGKpYMl/gPHyqJ5fDIf1IfwLGsB0wJzqm1GnrAeIMRop7OOO3vkQY/H++I5itdh2XBHdgztQs0hYB/UY3DJQ0M94nUF7HNvdHKDjX4aeCRTxMOCU0wtBvQNPDgMaf0nwE0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQi5GVpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759D4C19425;
	Tue, 11 Nov 2025 11:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762860207;
	bh=Thw9gqzu/5zeb1wIIdMk1FSZcopEkspAzVBeJtniQYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQi5GVpX52PRCMj5gkIAH3YRXiiuANNgtGHcppPScXsYfdyl02sFfNzrO3aH+a/Ax
	 3TuLFVEa0u8rU2MSpSVNrhAuMVX2bSSoXzlUxvgfHAPpK9AN0v4w0qGvpV0F8jgPgn
	 8uWk759FEvUsB9g3yf1epocdoWilRVE9s3+GHQHDjLz3k1htz/iQPi2PI5XdOqtruH
	 4d1Q7M02OXK0Znvb2uxqv2F741E82EdwV82NP4DBWhgim5fkJDVA6Lu3t1buNOvchV
	 CStv+8B1S/nj4DSDhQfNCnELeTWHXq/7wXAT2BsdhKSSUSyRlamKFJ2E84bZRrghdU
	 kjp0x3ofb/xWQ==
Date: Tue, 11 Nov 2025 12:23:18 +0100
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
Message-ID: <20251111-dozent-losgefahren-0a3a086b293e@brauner>
References: <20251111-anbraten-suggerieren-da8ca707af2c@brauner>
 <691317ab.a70a0220.22f260.0135.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <691317ab.a70a0220.22f260.0135.GAE@google.com>

On Tue, Nov 11, 2025 at 03:02:03AM -0800, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:

I think that's unrelated. Anyway, I managed to point this to the wrong
branch. I'll send another test request in a bit.

