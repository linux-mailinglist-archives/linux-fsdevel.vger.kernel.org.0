Return-Path: <linux-fsdevel+bounces-76880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIwyAd6Gi2nzVQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:28:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6FD11EA2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBF653038171
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 19:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED288392C4B;
	Tue, 10 Feb 2026 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bah4iDZU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D3138A9B7
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770751694; cv=none; b=V4A9A1IkBFTG/JZ0YrCIKvUQATvp3PvIXyPrebSXwAUxzbknjAv5QUNyZ0oVzgnlX08j4NZSO9VS3q/n7rGIdlxpI4eGkIFslizksMuhasIjJiAjBCAWHIAgx1qU+R2U6D8hO6n+KcD+PAtslcXqc1nAOnrZDfj7zcQz6+XfNqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770751694; c=relaxed/simple;
	bh=nhJZhYBxkbSh8inEMgiGwAe+rPO/lbxfcRT2zbOQwKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxW/jlo5C8FFEoTwOHJzViIRNgZ39qxKO6laNoPkm+nZ1ez9t0r0JEnxCm5SQ6EJwjJYoceoZL+UtnKqj5b5Omz8uMAm+Ky3o8aXcA9eYdMXznvu8KkHXDdjjusZWJfomKKJ5SbmsrWHQh8ZAbgWpkj7zUvDcBGnM6Ahor/v/rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bah4iDZU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-436309f1ad7so3005642f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 11:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770751691; x=1771356491; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFyGR2DyLRU+91jbuLD+/fzhLRHaNo946KYs1mYXfdg=;
        b=bah4iDZUnDoIslL3kST5oTtVXHV5jviujxuA8yyaJH9amx2VCiB5vdNlBAtRaBLrvy
         4LWSw2AVPw8Fk04MmwcRBlTPueXevvbyapZvrKbpRIS+WjirOaDHRAL1VdTHQyAND41h
         FsUpEnfHH+ln+1BSTdqvynAPR0+uJyl59ZR8ccjYFPDezCVWbSKDUCfjVatxKzw/eCkI
         f2+0fDd3C3zHdyDx48pEANgo7lvKZZ7f2UOufefYU4yQ4m9lypstLlwqJk4vULohLGNe
         IgNDF664WLuua8vpQKNDCy/HVa/rI8QcmQ4iTgXJ+cQJXvHUTArfzw1RGY0jYKxpmsRn
         m2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770751691; x=1771356491;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LFyGR2DyLRU+91jbuLD+/fzhLRHaNo946KYs1mYXfdg=;
        b=AeZ3e6tdH/FSF4/3N6bmORuY54GyCMVN4bfMQQ84Q/mRJSb36Y9H79VdJ+v7ff0yhj
         rtjWYzr9D9pTjZscZjA9ibatBspcbgK9G9DEiiBICgE7kJuqcOcqvk35hW+8+ASX3Tz9
         OYd8EjAarkIlXlhYRz+wvCqDjXSReelD+JbNQXI7nke3kErQvhflXpZjpFnt9szS8Cjt
         gLQicqhtnz0jfzsqjT726OyIUw/iTh1pzDOz8zqX+tW+TDfUX8Do6peD14fh/uwMJiAO
         qwbGMxDHqwhJl79EEiDI0kwbQbkwcLzJaM6Yw6cmT3t/Cxa9ZMVGPHUvy9ZDUF/H8NwO
         aZKw==
X-Forwarded-Encrypted: i=1; AJvYcCWkc01FqoAK9+79cHh4f3Yx1mUQLPnWv3yfNyPCxW2MSZMLwSlNr/rUt3pdCrQrjE0pz9k6oTiONFPH8jlb@vger.kernel.org
X-Gm-Message-State: AOJu0YwaSakaOX9MZ8NZoEQJbLkPkL1+tkX8fQgb5izNY2lJ9GMTibRZ
	aLHclbolP0/giyew3rRFjT4uDT79+v1XCvGSdl55YYBHzowp9nhsnYr3
X-Gm-Gg: AZuq6aJbEw4cI4CEMSGXHyz3MtB3Mp8+DGCy9JV0UJ5iouX5ogr7Dlks1d6lHOWIy+k
	2cLR8pF5R+wUiHzcrWe4pP5C2H0ttOOEtVCXFXkMFt6J2/zjSU1dH1z4rey6rPjUJUeOV45rdOB
	aWioE0CiZuSXePYiV/8trCJoP1DGTolSpXGS4o/CrFlu6Owxuqh3IiFfDrMxEB7Y7S7GOrrb6Hu
	aPQvxgr3FqFcyRIWJicEXSnLYUTkgG79qtdz0/Nrk2RoprJ5kHwSIV/7ev0DV2+qhfFnvKksBaL
	a8rKBv+TgbYEcM/+Z2FOI/UitXgI2XRCx7Y3aNIxXBYM5op+YVjJzljJSLdANP7b2kQkCgAHbhN
	6FlxPuN3NcYnSw8FmIBz3CubBXnpH95zTvmbzZZLxaBT5dbd05v+Mx3v9S7RtGTqMfTIdBd/5Be
	xqBX2gnhS9R3UiuryByDfUjiP90JY=
X-Received: by 2002:a05:600c:470b:b0:477:7ae0:cd6e with SMTP id 5b1f17b1804b1-4835b8bbf77mr1193155e9.5.1770751691077;
        Tue, 10 Feb 2026 11:28:11 -0800 (PST)
Received: from grain.localdomain ([212.46.38.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436297462a8sm33795335f8f.30.2026.02.10.11.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 11:28:10 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 8CBD35A004A; Tue, 10 Feb 2026 22:28:06 +0300 (MSK)
Date: Tue, 10 Feb 2026 22:28:06 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Andrei Vagin <avagin@google.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, criu@lists.linux.dev,
	Chen Ridong <chenridong@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Koutny <mkoutny@suse.com>
Subject: Re: [PATCH 0/4 v3] exec: inherit HWCAPs from the parent process
Message-ID: <aYuGxmLOWXhIpoMj@grain>
References: <20260209190605.1564597-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209190605.1564597-1-avagin@google.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76880-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gorcunov@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,linux-foundation.org:email,xmission.com:email]
X-Rspamd-Queue-Id: 5B6FD11EA2A
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 07:06:01PM +0000, Andrei Vagin wrote:
> This patch series introduces a mechanism to inherit hardware capabilities
> (AT_HWCAP, AT_HWCAP2, etc.) from a parent process when they have been
> modified via prctl.
> 
> To support C/R operations (snapshots, live migration) in heterogeneous
> clusters, we must ensure that processes utilize CPU features available
> on all potential target nodes. To solve this, we need to advertise a
> common feature set across the cluster.
> 
> Initially, a cgroup-based approach was considered, but it was decided
> that inheriting HWCAPs from a parent process that has set its own
> auxiliary vector via prctl is a simpler and more flexible solution.
> 
> This implementation adds a new mm flag MMF_USER_HWCAP, which is set when the
> auxiliary vector is modified via prctl(PR_SET_MM_AUXV). When execve() is
> called, if the current process has MMF_USER_HWCAP set, the HWCAP values are
> extracted from the current auxiliary vector and inherited by the new process.
> 
> The first patch fixes AUXV size calculation for ELF_HWCAP3 and ELF_HWCAP4
> in binfmt_elf_fdpic and updates AT_VECTOR_SIZE_BASE.
> 
> The second patch implements the core inheritance logic in execve().
> 
> The third patch adds a selftest to verify that HWCAPs are correctly
> inherited across execve().
> 
> v3: synchronize saved_auxv access with arg_lock
> 
> v1: https://lkml.org/lkml/2025/12/5/65
> v2: https://lkml.org/lkml/2026/1/8/219
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Chen Ridong <chenridong@huawei.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Michal Koutny <mkoutny@suse.com>
> Cc: Cyrill Gorcunov <gorcunov@gmail.com>

Looks ok to me. Thanks, Andrei!

Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>

