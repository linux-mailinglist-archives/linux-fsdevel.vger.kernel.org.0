Return-Path: <linux-fsdevel+bounces-22172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BB391313E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 03:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6509228385B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 01:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F34E4A06;
	Sat, 22 Jun 2024 01:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M8OE1Els"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95257184D;
	Sat, 22 Jun 2024 01:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719018212; cv=none; b=aqrVEWaqV2Qp5qZtRmUZSdzyUMz1wqzTf1P29M3RolL42fFfnNYlYtZViJurLUK3UptwTqWwQYXYlW/FehTTWTCSYpBn+yAikh5JRXdgSxRcMXxObiwcR/aUIoTQCE1Ar/3Fk4KEqizsXw2FP1x1lIO3788mBsTxU71UEE6vI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719018212; c=relaxed/simple;
	bh=IjmlIDAKLr1kULDNb5pBcVLdCn5WnM7PbdZUawOctb8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YlM5rb2Q/q2p2WG249+iM975l3JE129e98+NU5Fl7x9jqYkC5WgG76ms6ZHeAdLZ5f/wnUjUw4zV4L69pgvC5lwUefPowKGvbsuaV6mcxFtdSx5zffzM8ZbzQSffqOcqX1aoHU8yCDtuLnSyZRxYQQ2M4L4ScVmwJeAyiDV1wa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M8OE1Els; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91147C2BBFC;
	Sat, 22 Jun 2024 01:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719018211;
	bh=IjmlIDAKLr1kULDNb5pBcVLdCn5WnM7PbdZUawOctb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M8OE1ElswZEkOBU41/0RdmQYSUqjS/7mY7/rALc+Od9D5UsRpHOtGGf/1AuRp196W
	 t5AMc826YoL9GCZYHudkUgYw3O4sRH3d01XHZHGVZhNaFIgGxzQn4m/Z3RIg92pBf3
	 +UdIu6cbPSTZwhQEzNTYohz+YOMhGaVbSnHcuuKE=
Date: Fri, 21 Jun 2024 18:03:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Audra Mitchell <audra@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 aarcange@redhat.com, rppt@linux.vnet.ibm.com, shli@fb.com,
 peterx@redhat.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, raquini@redhat.com
Subject: Re: [PATCH v2 1/3] Fix userfaultfd_api to return EINVAL as expected
Message-Id: <20240621180330.6993d5fd0bda4da230e45f0d@linux-foundation.org>
In-Reply-To: <20240621181224.3881179-1-audra@redhat.com>
References: <20240621181224.3881179-1-audra@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 14:12:22 -0400 Audra Mitchell <audra@redhat.com> wrote:

> Currently if we request a feature that is not set in the Kernel
> config we fail silently and return all the available features. However,
> the man page indicates we should return an EINVAL.
> 
> We need to fix this issue since we can end up with a Kernel warning
> should a program request the feature UFFD_FEATURE_WP_UNPOPULATED on
> a kernel with the config not set with this feature.
> 
>  [  200.812896] WARNING: CPU: 91 PID: 13634 at mm/memory.c:1660 zap_pte_range+0x43d/0x660
>  [  200.820738] Modules linked in:
>  [  200.869387] CPU: 91 PID: 13634 Comm: userfaultfd Kdump: loaded Not tainted 6.9.0-rc5+ #8
>  [  200.877477] Hardware name: Dell Inc. PowerEdge R6525/0N7YGH, BIOS 2.7.3 03/30/2022
>  [  200.885052] RIP: 0010:zap_pte_range+0x43d/0x660
> 
> Fixes: e06f1e1dd499 ("userfaultfd: wp: enabled write protection in userfaultfd API")

A userspace-triggerable WARN is bad.  I added cc:stable to this.

