Return-Path: <linux-fsdevel+bounces-58582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C0AB2F0BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 10:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C19188873D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 08:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32E62EA16C;
	Thu, 21 Aug 2025 08:12:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5620262815;
	Thu, 21 Aug 2025 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763960; cv=none; b=Y34vYUt051/MqiVreYlOSttA3b0mjXASM+ciH9t5qvDdjscukz84Ez64xgQSGjWbF/f9wwtYnjugc0F74NBrlBcobDa56vpQBzgTrO+WWo1NQQpoymXyRMqN8YzXfsuI7E5ptDlBrfeoB2CEgOUHCIJy6I0jN+GZW4n/CMVAU5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763960; c=relaxed/simple;
	bh=sOvu4wPdDmplFytJ6WWywKHC6CavMT261upjBYvAf14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuPZP2C4zA7j4fKU/hFJrV0xoRut3cT+LGOlJ3osJljjLDcoRbYydv7l/xLgPLjg5bjVspioSJdD87BFrkoYWXlwbQrG9SH3QFonpa2n6LbgZ+HDgZqbcnxuOtvfC4fbE35dpPw/htGyr3NvO4CAZqPtMZgwPj2FrwMVLuxrffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4c6wz50zmyzYlxH1;
	Thu, 21 Aug 2025 16:12:17 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 21 Aug
 2025 16:12:29 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 21 Aug
 2025 16:12:29 +0800
From: wangzijie <wangzijie1@honor.com>
To: <brauner@kernel.org>
CC: <adobriyan@gmail.com>, <akpm@linux-foundation.org>, <ast@kernel.org>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <k.shutemov@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <polynomial-c@gmx.de>,
	<regressions@lists.linux.dev>, <rick.p.edgecombe@intel.com>,
	<stable@vger.kernel.org>, <viro@zeniv.linux.org.uk>, <wangzijie1@honor.com>
Subject: Re: [PATCH RESEND v2] proc: fix missing pde_set_flags() for net proc files
Date: Thu, 21 Aug 2025 16:12:29 +0800
Message-ID: <20250821081229.1346962-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250821-wagemut-serpentinen-e5f4b6f505f6@brauner>
References: <20250821-wagemut-serpentinen-e5f4b6f505f6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To a011.hihonor.com
 (10.68.31.243)

>On Mon, Aug 18, 2025 at 08:31:02PM +0800, wangzijie wrote:
>> To avoid potential UAF issues during module removal races, we use pde_set_flags()
>> to save proc_ops flags in PDE itself before proc_register(), and then use
>> pde_has_proc_*() helpers instead of directly dereferencing pde->proc_ops->*.
>> 
>> However, the pde_set_flags() call was missing when creating net related proc files.
>> This omission caused incorrect behavior which FMODE_LSEEK was being cleared
>> inappropriately in proc_reg_open() for net proc files. Lars reported it in this link[1].
>> 
>> Fix this by ensuring pde_set_flags() is called when register proc entry, and add
>> NULL check for proc_ops in pde_set_flags().
>> 
>> [1]: https://lore.kernel.org/all/20250815195616.64497967@chagall.paradoxon.rec/
>> 
>> Fixes: ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al)
>> Cc: stable@vger.kernel.org
>> Reported-by: Lars Wendler <polynomial-c@gmx.de>
>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>> ---
>> v2:
>> - followed by Jiri's suggestion to refractor code and reformat commit message
>> ---
>>  fs/proc/generic.c | 36 +++++++++++++++++++-----------------
>>  1 file changed, 19 insertions(+), 17 deletions(-)
>> 
>> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
>> index 76e800e38..003031839 100644
>> --- a/fs/proc/generic.c
>> +++ b/fs/proc/generic.c
>> @@ -367,6 +367,23 @@ static const struct inode_operations proc_dir_inode_operations = {
>>  	.setattr	= proc_notify_change,
>>  };
>>  
>> +static void pde_set_flags(struct proc_dir_entry *pde)
>> +{
>
>Stash pde->proc_ops in a local const variable instead of chasing the
>pointer multiple times. Aside from that also makes it easier to read.
>Otherwise seems fine.

Thanks for helping review, Christian. I will follow your suggestion.


>> +	if (!pde->proc_ops)
>> +		return;
>> +
>> +	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
>> +		pde->flags |= PROC_ENTRY_PERMANENT;
>> +	if (pde->proc_ops->proc_read_iter)
>> +		pde->flags |= PROC_ENTRY_proc_read_iter;
>> +#ifdef CONFIG_COMPAT
>> +	if (pde->proc_ops->proc_compat_ioctl)
>> +		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
>> +#endif
>> +	if (pde->proc_ops->proc_lseek)
>> +		pde->flags |= PROC_ENTRY_proc_lseek;
>> +}
>> +
>>  /* returns the registered entry, or frees dp and returns NULL on failure */
>>  struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
>>  		struct proc_dir_entry *dp)
>> @@ -374,6 +391,8 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
>>  	if (proc_alloc_inum(&dp->low_ino))
>>  		goto out_free_entry;
>>  
>> +	pde_set_flags(dp);
>> +
>>  	write_lock(&proc_subdir_lock);
>>  	dp->parent = dir;
>>  	if (pde_subdir_insert(dir, dp) == false) {
>> @@ -561,20 +580,6 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
>>  	return p;
>>  }
>>  
>> -static void pde_set_flags(struct proc_dir_entry *pde)
>> -{
>> -	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
>> -		pde->flags |= PROC_ENTRY_PERMANENT;
>> -	if (pde->proc_ops->proc_read_iter)
>> -		pde->flags |= PROC_ENTRY_proc_read_iter;
>> -#ifdef CONFIG_COMPAT
>> -	if (pde->proc_ops->proc_compat_ioctl)
>> -		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
>> -#endif
>> -	if (pde->proc_ops->proc_lseek)
>> -		pde->flags |= PROC_ENTRY_proc_lseek;
>> -}
>> -
>>  struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
>>  		struct proc_dir_entry *parent,
>>  		const struct proc_ops *proc_ops, void *data)
>> @@ -585,7 +590,6 @@ struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
>>  	if (!p)
>>  		return NULL;
>>  	p->proc_ops = proc_ops;
>> -	pde_set_flags(p);
>>  	return proc_register(parent, p);
>>  }
>>  EXPORT_SYMBOL(proc_create_data);
>> @@ -636,7 +640,6 @@ struct proc_dir_entry *proc_create_seq_private(const char *name, umode_t mode,
>>  	p->proc_ops = &proc_seq_ops;
>>  	p->seq_ops = ops;
>>  	p->state_size = state_size;
>> -	pde_set_flags(p);
>>  	return proc_register(parent, p);
>>  }
>>  EXPORT_SYMBOL(proc_create_seq_private);
>> @@ -667,7 +670,6 @@ struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
>>  		return NULL;
>>  	p->proc_ops = &proc_single_ops;
>>  	p->single_show = show;
>> -	pde_set_flags(p);
>>  	return proc_register(parent, p);
>>  }
>>  EXPORT_SYMBOL(proc_create_single_data);
>> -- 
>> 2.25.1
>> 


