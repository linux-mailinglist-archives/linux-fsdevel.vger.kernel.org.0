Return-Path: <linux-fsdevel+bounces-61817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C85AB5A0A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 20:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893AD585D5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701DD2DE70C;
	Tue, 16 Sep 2025 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2ep6gSM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95710246783;
	Tue, 16 Sep 2025 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047824; cv=none; b=QIBcOqFdSiSE4lL4gg/grwqz0VsGkse9YGTVuc83QdMZGcRFkTTTrAeSAQ9qGuOfEsHiAM82/SS45L5ob2GAnwFilqltcBK90hbBUtPxyDJ1Pmm4Y+Yt/uKBBTCXpSLJz76GzYl3hAkB89APTcVMf2hitTkL/1WMPSPDWNIg5Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047824; c=relaxed/simple;
	bh=jnE3T/TrSxsfQhYKHHZkySdj6XnCpKLKkcg0Jk32Y6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhqA7IKeND8GINKHhpZh2sZeohxYNzsEW8xSQd+OUwhTMoXALhNpb5OLAUrCukl94C7+UiE47Mi8pTomM+BC8VU2uZ9ef9xAPObn+yzTcsqOGq17FDs9h+PBhcv5cJzVFvO0/0aVdg9Xz2oODyG1OsFOjHJzjRGMB1GKTagpVNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2ep6gSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F45C4CEEB;
	Tue, 16 Sep 2025 18:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758047822;
	bh=jnE3T/TrSxsfQhYKHHZkySdj6XnCpKLKkcg0Jk32Y6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2ep6gSMpdFnttghY+ZQDHb/uKNh+aQyvx1yPRjPflTZYBy+I0m9GICWEC3pl6D5l
	 A7KYUBEoyGG0LaIlpwgEtS1y438lnBM2Keo7Dh4eMrcmYp3BsuQ55zp1qTmqtOXJRs
	 wjEnNkw1308B6wqeofWDMH2XkhB2krw0z5woQZWEZzIBQY0jFyHHIaKUdX8iHgnNWk
	 VXmXEZmnvyR4DtzMz9hDRUUKrg7q8pVqM7UcnRJSeI62VFtb4NdnL8KB3JqN+YTLaT
	 VfcNwEURuquG6ungOU6gMBnq84GmJgN8vp1SUb2pcs/GDlCL1EOMR4XvIkPhFmbjC7
	 mQsnS8YiqJHNg==
Date: Tue, 16 Sep 2025 08:37:01 -1000
From: Tejun Heo <tj@kernel.org>
To: pengdonglin <dolinux.peng@gmail.com>
Cc: tony.luck@intel.com, jani.nikula@linux.intel.com, ap420073@gmail.com,
	jv@jvosburgh.net, freude@linux.ibm.com, bcrl@kvack.org,
	trondmy@kernel.org, longman@redhat.com, kees@kernel.org,
	bigeasy@linutronix.de, hdanton@sina.com, paulmck@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v3 08/14] cgroup: Remove redundant rcu_read_lock/unlock()
 in spin_lock
Message-ID: <aMmuTXNPY_9Fp_WQ@slm.duckdns.org>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
 <20250916044735.2316171-9-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916044735.2316171-9-dolinux.peng@gmail.com>

On Tue, Sep 16, 2025 at 12:47:29PM +0800, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
> 
> Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
> there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
> rcu_read_lock_sched() in terms of RCU read section and the relevant grace
> period. That means that spin_lock(), which implies rcu_read_lock_sched(),
> also implies rcu_read_lock().
> 
> There is no need no explicitly start a RCU read section if one has already
> been started implicitly by spin_lock().
> 
> Simplify the code and remove the inner rcu_read_lock() invocation.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Waiman Long <longman@redhat.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: pengdonglin <dolinux.peng@gmail.com>

Applied to cgroup/for-6.18.

Thanks.

-- 
tejun

