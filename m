Return-Path: <linux-fsdevel+bounces-20990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DD58FBCE5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 22:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003E62854DB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 20:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D21114B942;
	Tue,  4 Jun 2024 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stuba.sk header.i=@stuba.sk header.b="RoiU1XS6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out.cvt.stuba.sk (smtp-out.cvt.stuba.sk [147.175.1.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFAE13790A;
	Tue,  4 Jun 2024 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.175.1.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531306; cv=none; b=VQhSKZ7YboKnO96FJVU2/deWvxre0ZFVFDgMCWPtsRncqna6lIEqcl3taIiQlsmHGWQs9WVmOiCdDQuwaveBGdB6L6Kmu1StwGn5H8uSNzR/oN7BQvtRdl/Jhk1SWXk+uEQNQrgIFNfloAvyTN4oNtpYL02tV40kDGnRD8XYLqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531306; c=relaxed/simple;
	bh=xe0cw9thbST3IGZR/oHrSk2h8gDB0o+KtYMQ4u2eRgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQu+Rk5vBK2qKO1mz66x/2OrnW18nZW8Lul61lmc6bD3FjtQQTyCzK1QHYQ/L6rv1UmhGJkza6Zgg32CsEL9SDF6/NPT1N33eWjVvdjajQjnqBP3kIXiYY40KSTiEeHv7urWA+UB/RWjUBDSGZyUjVGL1OWz45FlCd/LgLJksos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stuba.sk; spf=pass smtp.mailfrom=stuba.sk; dkim=pass (2048-bit key) header.d=stuba.sk header.i=@stuba.sk header.b=RoiU1XS6; arc=none smtp.client-ip=147.175.1.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stuba.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stuba.sk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=stuba.sk;
	s=20180406; h=Content-Transfer-Encoding:Content-Type:From:To:Subject:
	MIME-Version:Date:Message-ID; bh=OzD8eiGhu04GmQy5cDB6iwlOJ1sKBpFqwfQpiANZgQs=
	; t=1717531302; x=1717963302; b=RoiU1XS6EhzSDf09oyYzywSNGFz8JaMeIms5Ttmc9CrmA
	K46kprcWX743g67XvJYCRjIurWRbwNnDdr4DOyw1rMHgzeb7gEemvX1+8MZ9ROB2mV797paJsF2xH
	0qrNun3ZOEe/rQM6FvNOgUZx0g7z1l1d+MUuKCWRf7lmBamgs2HWibosk3p26gw/hHR16Fd8Vpq0g
	PzWcKzwh2tUA5zeUSkeukEnt4Kspa6w6AdMIkNVxwflYyVa3en3xGBmnFTXUZbUN12jz2gdNu05hf
	ntL71IV33u7PpZMpXdtZF1b03JmOI+1T66dEqCkw1/0ThU9PaLO6S/FMiMu7849yUQ==;
X-STU-Diag: 9f3e1a9c84f4ccb1 (auth)
Received: from ellyah.uim.fei.stuba.sk ([147.175.106.89])
	by mx1.stuba.sk (Exim4) with esmtpsa (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(envelope-from <matus.jokay@stuba.sk>)
	id 1sEaLi-0000iB-Fy; Tue, 04 Jun 2024 22:01:38 +0200
Message-ID: <6cf37b34-c5e4-4d92-8a60-6c083e109439@stuba.sk>
Date: Tue, 4 Jun 2024 22:01:38 +0200
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

Sorry guys for the mistake,

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
there should be fixed only the comment about ->comm initialization during exec.

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c75fd46506df..48aa5c85ed9e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1081,9 +1081,9 @@ struct task_struct {
 	/*
 	 * executable name, excluding path.
 	 *
-	 * - normally initialized setup_new_exec()
+	 * - normally initialized begin_new_exec()
 	 * - access it with [gs]et_task_comm()
-	 * - lock it with task_lock()
+	 * - lock it with task_lock() for writing
 	 */
 	char				comm[TASK_COMM_LEN];
 
Again, sorry for the noise. It's a very minor fix, but maybe even a small fix to the documentation can help increase the readability of the code.

--
Thanks
mY


