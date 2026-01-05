Return-Path: <linux-fsdevel+bounces-72381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5AFCF1B3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 04:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A3E330010DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 03:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F0530C60D;
	Mon,  5 Jan 2026 03:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FALLOl6h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A8531CA7B;
	Mon,  5 Jan 2026 03:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767582481; cv=none; b=SVvqRKLK/qNK5c7ajzJgNSrlJv4fSYPZyJ+WujnQey+TXdSCTMra1dXCPAOuawNuBMMM0FWTZN/kFcv1XiM/xC9NrXbGzkBncu83vxZpIe+Nif3ECHS3a0luJF51yxSNgEHNJjtd+adUTcswCSS4w/limqppYmiIu0sCOqv+NH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767582481; c=relaxed/simple;
	bh=rz0fkIAYb7S/dLqtS5+ID/AhJ742Z5vmbQP+XRKJEo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sil+R61etQ6rrKsg+kvV0B1JaJ0TZ/Nw04I2CDXjosgdKiiVAOuRpm41lCdaGMscVFIigMeYiwWYWrYkvO8Z9s2enEBV1Nym6lerlFnkHHwaIIBJGytIP3ov87pl3zjphNUs/8K3pZhlFGkfArqwtQ0337i40lTkb30uIUHOzJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FALLOl6h; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=SSvrK5qll96czaa0gJeWIBUXz6CWMthA3oxyt3ijLHk=;
	b=FALLOl6hFQyNeYscXW4nyuWQVPuvY/7yJqqK8HIyB8Ilie1R9XTYj/h9ECvIFS
	UrYWtttNiWvfENvwp2JoZo/2b9KPuhC/v2GGr7SrLnlmdNyAzCAUkkSYGmT/aBeD
	XBD1okLFXKSPU2PLGPZTDIl9zSJTpuNLXWWnbT7pzXlZI=
Received: from [10.42.20.201] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBXi7jkKltpf75QEQ--.2535S2;
	Mon, 05 Jan 2026 11:07:16 +0800 (CST)
Message-ID: <53c38e14-13bb-4857-85cf-221408669475@163.com>
Date: Mon, 5 Jan 2026 11:07:15 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] exfat: reuse cache to improve exfat_get_cluster
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "brauner@kernel.org" <brauner@kernel.org>,
 "chizhiling@kylinos.cn" <chizhiling@kylinos.cn>, "jack@suse.cz"
 <jack@suse.cz>, "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "willy@infradead.org" <willy@infradead.org>
References: <PUZPR04MB631637893887AB587E1E3A9381BCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <4c72c670-5ec1-404d-8177-bd80fabf4695@163.com>
 <PUZPR04MB6316842140CBEDFC8E30CDE081B9A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <PUZPR04MB6316842140CBEDFC8E30CDE081B9A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBXi7jkKltpf75QEQ--.2535S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCry5ur47JFyrAF4xZrWkJFb_yoW5tr1xpr
	W5Ka1Ut3y5A3s7ur10vFs3X3WS9FZ7tF4UGan8A3ZIyryDtFs5urnrGr9xuFyrCw4kua1Y
	9F4UK3W7urnxG3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziBbytUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3AT0kmlbKuSNYQAA3u

On 1/4/26 15:56, Yuezhang.Mo@sony.com wrote:
>> On 12/30/25 17:05, Yuezhang.Mo@sony.com wrote:
>>>> -             if (exfat_ent_get(sb, *dclus, &content, NULL))
>>>> -                     return -EIO;
>>>> +             if (exfat_ent_get(sb, *dclus, &content, &bh))
>>>> +                     goto err;
>>>
>>> As you commented,  the buffer_head needs release if no error return.
>>> Here, an error was returned, buffer_head had been released.
>>
>>
>> I mean, it seems like a duplicate release in there, but in fact it's not.
>>
>> When exfat_ent_get return an error, *bh is released and set to NULL. So
>> the second brelse() call in exfat_get_cluster() does nothing.
>>
>> ~~~
>> int exfat_ent_get(struct super_block *sb, unsigned int loc,
>>                   unsigned int *content, struct buffer_head **last)
>> {
>>
>>         ...
>>
>> err:
>>           if (last) {
>>                  brelse(*last);
>>
>>                  /* Avoid double release */
>>                  *last = NULL;
>>           }
>>           return -EIO;
>> }
>> ~~~
>>
>> The reason using "goto err" is that I want to handle all errors in the
>> same way. Although this does seem a bit strange and confusing with the
>> comment in exfat_ent_get.
> 
> I don't think it's necessary to handle all errors in the same way.
> 
> - Only the following error handling requires calling brelse.
>      /* prevent the infinite loop of cluster chain */
>      if (fclus > limit) {
>              exfat_fs_error(sb,
>                      "detected the cluster chain loop (i_pos %u)",
>                      fclus);
>              goto err;
>      }
> - This makes confused with the comment in exfat_ent_get.
> - Unnecessary code modifications are avoided.

Okay, V2 is ready:

diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index 61af3fa05ab7..a5e6858e5a20 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -241,6 +241,7 @@ int exfat_get_cluster(struct inode *inode, unsigned 
int cluster,
         struct exfat_sb_info *sbi = EXFAT_SB(sb);
         unsigned int limit = sbi->num_clusters;
         struct exfat_inode_info *ei = EXFAT_I(inode);
+       struct buffer_head *bh = NULL;
         struct exfat_cache_id cid;
         unsigned int content;

@@ -284,10 +285,10 @@ int exfat_get_cluster(struct inode *inode, 
unsigned int cluster,
                         exfat_fs_error(sb,
                                 "detected the cluster chain loop (i_pos 
%u)",
                                 (*fclus));
-                       return -EIO;
+                       goto err;
                 }

-               if (exfat_ent_get(sb, *dclus, &content, NULL))
+               if (exfat_ent_get(sb, *dclus, &content, &bh))
                         return -EIO;

                 *last_dclus = *dclus;
@@ -299,7 +300,7 @@ int exfat_get_cluster(struct inode *inode, unsigned 
int cluster,
                                 exfat_fs_error(sb,
                                        "invalid cluster chain (i_pos 
%u, last_clus 0x%08x is EOF)",
                                        *fclus, (*last_dclus));
-                               return -EIO;
+                               goto err; // will remove in patch 6/9
                         }

                         break;
@@ -309,6 +310,10 @@ int exfat_get_cluster(struct inode *inode, unsigned 
int cluster,
                         cache_init(&cid, *fclus, *dclus);
         }

+       brelse(bh);
         exfat_cache_add(inode, &cid);
         return 0;
+err:
+       brelse(bh);
+       return -EIO;
  }


Thanks,

> 
>>>
>>>>
>>>>                 *last_dclus = *dclus;
>>>>                 *dclus = content;
>>>> @@ -299,7 +300,7 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
>>>>                                 exfat_fs_error(sb,
>>>>                                        "invalid cluster chain (i_pos %u, last_clus 0x%08x is EOF)",
>>>>                                        *fclus, (*last_dclus));
>>>> -                             return -EIO;
>>>> +                             goto err;
>>>>                         }
>>>>
>>>>                         break;
>>>> @@ -309,6 +310,10 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
>>>>                         cache_init(&cid, *fclus, *dclus);
>>>>         }
>>>>
>>>> +     brelse(bh);
>>>>         exfat_cache_add(inode, &cid);
>>>>         return 0;
>>>> +err:
>>>> +     brelse(bh);
>>>> +     return -EIO;
>>>>    }
>>>
>>>
> 
> 


