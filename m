Return-Path: <linux-fsdevel+bounces-61818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8F4B5A0AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 20:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA51585FEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF042F5A3A;
	Tue, 16 Sep 2025 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfMXSqG/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EE72D063E;
	Tue, 16 Sep 2025 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047837; cv=none; b=IWlL2MFCGeE58GZpKlO8ezY6zaCtdEkEs5Z+dCiYmjBENa2haMbNIz1WDHA0IyPbIy+rLZ4efHIQIqMbTL3f6dw3eklSTOIs+e4X7RkurJ0K/SgK9aAYuEpEb3T3cmhB46u+PSKFAniE2BGny1ud93vtnH/Xx2Zpv7DsEePH/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047837; c=relaxed/simple;
	bh=uZNzYbnMobWY+QykZ4WTqTR72hqNvnvoYs9ygOwBweU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKRaoU82xZhYipfpfGfvjZr6y8N4qLy61PF9Fs/e7SYNCPYwHCxIFv+Gci7PDs8Nb93byyXGqWPWEEeiwQqJOJOiQdICZONzpZEVKr2jrZUG/KKU0wL2DiDThFks+ubaK1et3Tg96a/7elawtc21ZlVz1ivOs2inKL+uPC1+8FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfMXSqG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E135C4CEEB;
	Tue, 16 Sep 2025 18:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758047836;
	bh=uZNzYbnMobWY+QykZ4WTqTR72hqNvnvoYs9ygOwBweU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VfMXSqG/J8Ygsl2+/uZU1iHZZa3OW9+E+KPN8SZJpir7n+K8w4aiXm7xBqBfH34un
	 d9Sqql4SQSGK9EwhWgUc0aDkpsYJOYQiz6Pq2GSnVfwdY+SVZBjoutHCLosYp0CiH1
	 gcOeJOcKowSA4SBmMWh5iE01DEnn2aO2TQfhjHy5MUpRg9l393B8HtROeSNOXx7G3C
	 Wlyssw55oFrb5N5s1MixBgRTutUavCoOI9MsJUOGso3HBjHZqkOlXqNIHX15ucg8Go
	 xRj+Tkzqo/D+ogyQwh7VST52JMsEaNzN1f+QfgCZuleVNXwNsWkLeNmh1qFOOcMlb7
	 FTmPb6kUpz7Aw==
Date: Tue, 16 Sep 2025 08:37:15 -1000
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
Subject: Re: [PATCH v3 09/14] cgroup/cpuset: Remove redundant
 rcu_read_lock/unlock() in spin_lock
Message-ID: <aMmuW8VhLbPRWwwx@slm.duckdns.org>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
 <20250916044735.2316171-10-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916044735.2316171-10-dolinux.peng@gmail.com>

On Tue, Sep 16, 2025 at 12:47:30PM +0800, pengdonglin wrote:
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
> Cc: Waiman Long <longman@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Waiman Long <longman@redhat.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: pengdonglin <dolinux.peng@gmail.com>

Applied to cgroup/for-6.18.

Thanks.

-- 
tejun

