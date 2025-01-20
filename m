Return-Path: <linux-fsdevel+bounces-39692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 085B2A16FB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A9D7A19F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 15:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1DC1E9B16;
	Mon, 20 Jan 2025 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hp67LqiD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5B71E9B0F
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737388247; cv=none; b=SkzKDdCkev7lXfL6/+XUdmZd9+T2JrHdzAIGzPx6+0gnD7b8VMCbXHt6MLeZ19U6jgSUEsL/SE4R/dglNVdO2q/eEl96N9kYRvOpzOe2VVps6uLJGnDOAImh1+X1OtpAmqyV0Ip7ToGMdmhxDz+KOkBnztX8gTsLPFaGSVaXrTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737388247; c=relaxed/simple;
	bh=t1WUxRy4eGnpes0GZimQAD8XyfAQn+Z3KwMgxXq72QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0NeY/Ac+AiUB8yMahM/YnnPhZ0pJHgMmQLkRjXBq4UyTl+i1B+CKySNI5/C+cQLH8pLf0lrwFq2+aWavRDwwK88bNYV7KidvchmibtPX1m4J+T8MmaL1SvAJnRgBpGP8s1jUMHBr5qAekv1PVjxX4vhx2sCVo8QTttqNabSu+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hp67LqiD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737388243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMAkoPEbp1X/1fbqmcjUBuRkyr/p8lqtKYU91SycHTM=;
	b=hp67LqiDtfMtLN8SjHC3qIXTq5IdNWW4boj6LHH/NoR0CIvHDJsSGtUNm80S00QZ1GeRzQ
	m+qImPDeO4m6BsPXjBX7GFuVG8FtzTjcjNWzYUkPJoxmQ3aVOi3NJuOch0t0A78AVxi8Cw
	jW3sS1aqJCftzSXFkxsw+i1cYRaRjQM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-4zMjq5AaN9eRpyYE_hzzbQ-1; Mon,
 20 Jan 2025 10:50:41 -0500
X-MC-Unique: 4zMjq5AaN9eRpyYE_hzzbQ-1
X-Mimecast-MFC-AGG-ID: 4zMjq5AaN9eRpyYE_hzzbQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB80E1956062;
	Mon, 20 Jan 2025 15:50:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.104])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 48A181956094;
	Mon, 20 Jan 2025 15:50:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 20 Jan 2025 16:50:14 +0100 (CET)
Date: Mon, 20 Jan 2025 16:50:10 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Christian Brauner <brauner@kernel.org>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [linux-next:master] [pipe_read]  aaec5a95d5:
 stress-ng.poll.ops_per_sec 11.1% regression
Message-ID: <20250120155009.GD7432@redhat.com>
References: <202501201311.6d25a0b9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202501201311.6d25a0b9-lkp@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Again, I'll try to take another look tomorrow. Not sure I will find the
explanation though...

But can you help? I know nothing about stress-ng.

Google finds a lot of stress-ng repositories, I've clone the 1st one
https://github.com/ColinIanKing/stress-ng/blob/master/stress-poll.c
hopefully this is what you used.

On 01/20, kernel test robot wrote:
>
>       9.45            -6.3        3.13 ±  9%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
> ...
>      10.00            -6.5        3.53 ±  9%  perf-profile.children.cycles-pp.pipe_read
>       2.34            -1.3        1.07 ±  9%  perf-profile.children.cycles-pp.pipe_poll

Could you explain what do these numbers mean and how there are calculated?

"git-grep cycles-pp" find nothing in stress-ng/ and tools/perf/

> kernel test robot noticed a 11.1% regression of stress-ng.poll.ops_per_sec on:

same for ops_per_sec

>       6150           -47.8%       3208        stress-ng.time.percent_of_cpu_this_job_got

same for percent_of_cpu_this_job_got

>       2993           -50.6%       1477        stress-ng.time.system_time
>     711.20           -36.0%     454.85        stress-ng.time.user_time

Is that what I think it is?? Does it run faster?

Or it exits after some timeout and the decrease in system/user_time can be
explained by the change in the mysterious 'percent_of_cpu_this_job_got' above?

Oleg.


