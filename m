Return-Path: <linux-fsdevel+bounces-47873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A79CAA64BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 22:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B0C9879D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 20:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ABC253F1A;
	Thu,  1 May 2025 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fNWyluZo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B576253B5F;
	Thu,  1 May 2025 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746131227; cv=none; b=EiQleEEdzpNHTMBnF0xmSNa7GuocTtgajW1HRDsUlvMd+wJGJeIXDPYnFAeN/Bp83aMxJ3bUMj3k1QBXv1llaRm7A5kgb74jV0zx73Jn5TPT7shsj4N6iKaoI0X4QP8ST4FjDVtclGuRDOJN36pUZVExqfJTZyCLXVew2McPmeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746131227; c=relaxed/simple;
	bh=6kUzEANofjpMe3wHUoEUOCv7hGxATGQjEwALgV5sis4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WWGsWHEkz+8Vz3R9pOBXwJOqjUNDMUmIqg6bZgIOd3PVOOqZYPoWiC4wpvbriMjPTROlyS0cl5u/980mZtq4+OUo5cnVhNYMjvvXNmU+iJJUglHWeP+TFJ9xQp9SCiv9jfZ9pveDC6KRCceOKuQCchYNzWe92ZoY53fkdU9fk1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fNWyluZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F03EC4CEE3;
	Thu,  1 May 2025 20:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746131225;
	bh=6kUzEANofjpMe3wHUoEUOCv7hGxATGQjEwALgV5sis4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fNWyluZoGy41jJ210SzaJj+wqQdiPIuokJiSXrmjnFWknctK65dLsJFZHBwZsIF1v
	 6SrLpAJwo37KL5qLi+VF12MPPDp8t3+d9UFZxK6tpTI5Ezq5shoOTLNvo+jBVb/zwg
	 mUtrLAiBS4+dHyWCTN7tDYVw6oMCZuPW7EzxFNh0=
Date: Thu, 1 May 2025 13:27:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: <xu.xin16@zte.com.cn>
Cc: <david@redhat.com>, <linux-kernel@vger.kernel.org>,
 <wang.yaxin@zte.com.cn>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>, <yang.yang29@zte.com.cn>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun
 Song <muchun.song@linux.dev>
Subject: Re: [PATCH v2 0/9] support ksm_stat showing at cgroup level
Message-Id: <20250501132704.416b6000fb5eeaf4e9c3634b@linux-foundation.org>
In-Reply-To: <20250501120854885LyBCW0syCGojqnJ8crLVl@zte.com.cn>
References: <20250501120854885LyBCW0syCGojqnJ8crLVl@zte.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 May 2025 12:08:54 +0800 (CST) <xu.xin16@zte.com.cn> wrote:

> With the enablement of container-level KSM (e.g., via prctl [1]), there is
> a growing demand for container-level observability of KSM behavior. However,
> current cgroup implementations lack support for exposing KSM-related
> metrics.
> 
> This patch introduces a new interface named ksm_stat
> at the cgroup hierarchy level, enabling users to monitor KSM merging
> statistics specifically for containers where this feature has been
> activated, eliminating the need to manually inspect KSM information for
> each individual process within the cgroup.

Well, you didn't cc any of the memcg maintainers!

The feature seems desirable and the implementation straightforward. 
I'll add the patchset into mm.git for some testing, pending review
outcomes, thanks.



