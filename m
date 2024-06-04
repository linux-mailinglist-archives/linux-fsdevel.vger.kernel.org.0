Return-Path: <linux-fsdevel+bounces-20951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8788FB3D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 15:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01FA28251D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFE1146D77;
	Tue,  4 Jun 2024 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stuba.sk header.i=@stuba.sk header.b="skpUvvZ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out.cvt.stuba.sk (smtp-out.cvt.stuba.sk [147.175.1.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BCF14387B;
	Tue,  4 Jun 2024 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.175.1.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507889; cv=none; b=mgAOaCsVy4V/adpN64yXy5Xbi13RU5aie73kILUacOrT2g+4+sM4V7dU++NEyuVph+jFQoELx2JXiDpqCxwJCsLR4W1KzYNwKYChR3pBQxqsSQlmsO/ahZ2bYG8Mab+Dp81Ar1RVq9h2G0qe6vhX22sQkQR328Yn1Z/yFp91SM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507889; c=relaxed/simple;
	bh=0icUreYViWYq4/EcpDLJqF968cRqFSabkwCFhlmJ5wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/D+XVdgjqRNdf5ZV11L0WsvF6PnWc2ZONgHVfPqiXUlP99atCk6EH1xIzRtOBosAeM3YqJ9bMLIw0O9neyYvh9AnHXvXkokdP4+MPB457sWZoP0/8FQ/VXPnKwRsjOql+4ESaoW42jpbuk8sifcqOMskHkSxcaFDa3H3tEgXDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stuba.sk; spf=pass smtp.mailfrom=stuba.sk; dkim=pass (2048-bit key) header.d=stuba.sk header.i=@stuba.sk header.b=skpUvvZ/; arc=none smtp.client-ip=147.175.1.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stuba.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stuba.sk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=stuba.sk;
	s=20180406; h=Content-Transfer-Encoding:Content-Type:From:To:Subject:
	MIME-Version:Date:Message-ID; bh=I1tK3w2AP9asXV5BRpDDe4dl5b2p5RS5w5CWAe5+twU=
	; t=1717507886; x=1717939886; b=skpUvvZ/uON14EEamWIwr3fc+aGoyTVYgUVjBD7FoX627
	7V3h5Ui3lnip3CM3U+0OVP1GBfsDlbGgogcN7D1ZgPqj9DwuTGe6y3nkIiHXnzNIUg6QKzadCmloc
	cmEXqs6/MYkfQa6m+Icqfpl+hVpXzlzGRNWxLpQnj6kd67wSOnkiZo2wwfWcRKlHgS/sHSqulIX3u
	J7MEycw6YG8kt7de2tu8453LDGce28fXPdck3UbM/3/waKYJTn+mcd0dy7+RHfGKotkQ1XDqg9ePd
	1iM0v+OqtKw5qVvhsNm0yvN/GBLLGvhluORDyTMSJpryWmCXhOuXE36Xfeaqq2GvFw==;
X-STU-Diag: 732c0afafb52b10d (auth)
Received: from ellyah.uim.fei.stuba.sk ([147.175.106.89])
	by mx1.stuba.sk (Exim4) with esmtpsa (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(envelope-from <matus.jokay@stuba.sk>)
	id 1sETnh-00025l-OF; Tue, 04 Jun 2024 15:02:05 +0200
Message-ID: <1e967ef4-57d0-4090-a42f-6457a04680cf@stuba.sk>
Date: Tue, 4 Jun 2024 15:02:05 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] fs/exec: Drop task_lock() inside __get_task_comm()
To: Yafang Shao <laoar.shao@gmail.com>, torvalds@linux-foundation.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 bpf@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>
References: <20240602023754.25443-1-laoar.shao@gmail.com>
 <20240602023754.25443-2-laoar.shao@gmail.com>
Content-Language: en-US
From: Matus Jokay <matus.jokay@stuba.sk>
In-Reply-To: <20240602023754.25443-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yafang,

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index c75fd46506df..56a927393a38 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1083,7 +1083,7 @@ struct task_struct {
>  	 *
>  	 * - normally initialized setup_new_exec()
>  	 * - access it with [gs]et_task_comm()
> -	 * - lock it with task_lock()
> +	 * - lock it with task_lock() for writing
since you are updating this comment, you might as well fix other comments concerning ->comm, e.g.

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c75fd46506df..95b382d790d9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1081,9 +1081,9 @@ struct task_struct {
 	/*
 	 * executable name, excluding path.
 	 *
-	 * - normally initialized setup_new_exec()
-	 * - access it with [gs]et_task_comm()
-	 * - lock it with task_lock()
+	 * - normally initialized begin_new_exec()
+	 * - access it with __[gs]et_task_comm()
+	 * - lock it with task_lock() for writing
 	 */
 	char				comm[TASK_COMM_LEN];

-- 
Thanks
mY

