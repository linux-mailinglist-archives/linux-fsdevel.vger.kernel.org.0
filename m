Return-Path: <linux-fsdevel+bounces-69922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF57C8BE4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 21:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DA984E490B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 20:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1E1335555;
	Wed, 26 Nov 2025 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="o3Wo/gJc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655E9342CB8;
	Wed, 26 Nov 2025 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764189729; cv=none; b=GDGl/q5SosQKJkewFP1bYfVU3ux54QTYgRpI1NCsYcQ4+Me8AwN/ZCE6m4LkHuse3qWsUSI/j/SiOh8bt0rUt1O46eIkLKUC+eIJvf07mKc4G3wW7CIsao2rujCKfo7SQX1gfEJSPM6cl1qf8RGJK22zPOr2Gh5G/aBoeg71V3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764189729; c=relaxed/simple;
	bh=dOmnbnOwXcK6MREsRcXBo9JW1kZoA60KYNWUaq6Jm4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxWzMqqD4JAhwCe0uN3CQ+BVZmvbCE+qJBbCfMye2dMbLn/1ybjhuwAMRaev1W8xOg/GC97gcmsaqlbxn6UWESno1taS8Z9VRQJTmsndxWU7TN7ht5ClWkhW5lnrlrZAnSM0eAtiN4JyinJqcKzi1IyzIlGHv4Lk6OP2VEo1TiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=o3Wo/gJc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F3LhDg+yUIEO9+/SIuMeJHAc2uhx3ggEtkG8ys37ptk=; b=o3Wo/gJcdx6jF9yp+Moy+3zJBK
	4/xo3hGwpRQOjUuSnpVFd4+9RcmyDDSe6UMmetucmLae8BVJHjzLIu50qRgqYbk/odASxIUgSaAfn
	OZll8+aYjj1NWsWeY+RlkEcZ7SZ/UylVJW9S6ufdik3v9+fqhi1LOYdieImh4RVPP/pxDkPD633KB
	QFmjjdoW0GrmEG9tEjsTOgB0CoqhLB114KiR2psKlxll9g3YD462/AiRggY3TIECco1FGKJJaTLU8
	3V99sW3+lW6A28AxFj7hwSILErX3NPG2gXJopcYvlOTjOLtKShmxzpjPZ2/n6NgWW5TbZUWcR+T5p
	JvbpCgZw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vOMKw-00000002Jft-096S;
	Wed, 26 Nov 2025 20:42:02 +0000
Date: Wed, 26 Nov 2025 20:42:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: brauner@kernel.org, jack@suse.cz, linux@armlinux.org.uk,
	will@kernel.org, nico@fluxnic.net, akpm@linux-foundation.org,
	hch@lst.de, jack@suse.com, wozizhi@huaweicloud.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	lilinjie8@huawei.com, liaohua4@huawei.com,
	wangkefeng.wang@huawei.com, pangliyuan1@huawei.com
Subject: Re: [RFC PATCH] vfs: Fix might sleep in load_unaligned_zeropad()
 with rcu read lock held
Message-ID: <20251126204201.GF3538@ZenIV>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <20251126101952.174467-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126101952.174467-1-xieyuanbin1@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 26, 2025 at 06:19:52PM +0800, Xie Yuanbin wrote:

> On latest linux-next source, using arm32's multi_v7_defconfig, and
> setting CONFIG_PREEMPT=y, CONFIG_DEBUG_ATOMIC_SLEEP=y, CONFIG_KFENCE=y,
> CONFIG_ARM_PAN=n, then run the following testcase:
> ```c
> static void *thread(void *arg)
> {
> 	while (1) {
> 		void *p = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
> 
> 		assert(p != (void *)-1);
> 		__asm__ volatile ("":"+r"(p)::"memory");
> 
> 		munmap(p, 4096);
> 	}
> }
> 
> int main()
> {
> 	pthread_t th;
> 	int ret;
> 	char path[4096] = "/tmp";
> 
> 	for (size_t i = 0; i < 2044; ++i) {
> 		strcat(path, "/x");
> 		ret = mkdir(path, 0755);
> 		assert(ret == 0 || errno == EEXIST);
> 	}
> 	strcat(path, "/xx");
> 
> 	assert(strlen(path) == 4095);
> 
> 	assert(pthread_create(&th, NULL, thread, NULL) == 0);
> 
> 	while (1) {
> 		FILE *fp = fopen(path, "wb+");
> 
> 		assert(fp);
> 		fclose(fp);
> 	}
> 	return 0;
> }
> ```
> The might sleep warning will be triggered immediately.

"Immediately" part is interesting - presumably KFENCE is playing silly
buggers with PTEs in there.

Anyway, the underlying bug is that fault in this scenario should not
even look at VMAs - it should get to fixup_exception() and be done
with that, with minimal overhead for all other cause of faults.

We have an unaligned 32bit fetch from kernel address, spanning the
page boundary, with the second page unmapped or unreadable.  Access
comes from kernel mode.  All we want is to fail the fault without
an oops, blocking, etc.

AFAICS, on arm32 looks for VMA at address > TASK_SIZE won't find
a damn thing anyway, so skipping these attempts and going to
bad_area looks safe enough, if we do that after all early cases...

