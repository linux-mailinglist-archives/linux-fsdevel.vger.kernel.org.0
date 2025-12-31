Return-Path: <linux-fsdevel+bounces-72259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AEFCEB009
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 02:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D28B53019E20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 01:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615062D77FA;
	Wed, 31 Dec 2025 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EkPxcjS0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14B72D5436;
	Wed, 31 Dec 2025 01:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767145123; cv=none; b=qrS3xe/94EF7N5rwZayzvHYjyApY9G3+CAnR0owASnq9hX/9sc3fXQ00GNcR/kmeAQzZiWCodAZHZbVA4v/gKMSlUXzqSmfgcXayr025KVESrKEPCfIHMvKIwuYFEjK/tq9EBxxPXMugvmpdVL4iPdgVhABpgYL9f6QcuFI8qJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767145123; c=relaxed/simple;
	bh=vbgoXjtbThmQ+GYV7wLAam2cLtkEKW/pmXJMhloaCrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N19CmvpcfOZVLXqpYuRQjGkoDieO9Wr+bf/nz28v506N9LV4x8vnplzREQNyX/m44TZQa+hSeOyvOwdYKT1bkefsOCyk/yOd3DHfT1gPIg+vp7e709PaZ6+iEsmaSPbSvyEDU96yF+FNa/njHm7/5AXuvTY/7iTJ++CVfXGxuTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EkPxcjS0; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=lcgJ5aqhgWg4BJSMNaqfZ1vO1qpj6eG5+s5Ly5QT7Xk=;
	b=EkPxcjS0qFmRkROEpQDf58AgWEiDEncDfE8fE45ALyxwnhhjs41n1L4AEin8bo
	GO1D4PQM9KVSEx7k5wclKNGLprSCJEv1h3/gemp/5y+Z48bVbUkP+TQ9nROlmKJO
	j6pzZ3syU46LgCwHxnF93cNP7SJTS8tYDDCjYCfpim9pQ=
Received: from [10.42.20.201] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3ht1pflRpv+7tKg--.11419S2;
	Wed, 31 Dec 2025 09:37:45 +0800 (CST)
Message-ID: <4c72c670-5ec1-404d-8177-bd80fabf4695@163.com>
Date: Wed, 31 Dec 2025 09:37:45 +0800
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
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <PUZPR04MB631637893887AB587E1E3A9381BCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgD3ht1pflRpv+7tKg--.11419S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy5ArykWw1kKFW8Zr1fJFb_yoW8Xry7pr
	Z8Ka4DAw4UJrn2vw10vFs3X3WS9Fs3tFs8GF45JanxAr98tr4kWrnrKryayFW8Cw4v9rWY
	vayUK3W8urnrGFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziQ6pdUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9wkpxmlUfmmuigAA3f

On 12/30/25 17:05, Yuezhang.Mo@sony.com wrote:
>> -             if (exfat_ent_get(sb, *dclus, &content, NULL))
>> -                     return -EIO;
>> +             if (exfat_ent_get(sb, *dclus, &content, &bh))
>> +                     goto err;
> 
> As you commented,  the buffer_head needs release if no error return.
> Here, an error was returned, buffer_head had been released.


I mean, it seems like a duplicate release in there, but in fact it's not.

When exfat_ent_get return an error, *bh is released and set to NULL. So 
the second brelse() call in exfat_get_cluster() does nothing.

~~~
int exfat_ent_get(struct super_block *sb, unsigned int loc,
                 unsigned int *content, struct buffer_head **last)
{

	...

err:
         if (last) {
                 brelse(*last);

                 /* Avoid double release */
                 *last = NULL;
         }
         return -EIO;
}
~~~

The reason using "goto err" is that I want to handle all errors in the 
same way. Although this does seem a bit strange and confusing with the 
comment in exfat_ent_get.


Thank,

> 
>>   
>>                *last_dclus = *dclus;
>>                *dclus = content;
>> @@ -299,7 +300,7 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
>>                                exfat_fs_error(sb,
>>                                       "invalid cluster chain (i_pos %u, last_clus 0x%08x is EOF)",
>>                                       *fclus, (*last_dclus));
>> -                             return -EIO;
>> +                             goto err;
>>                        }
>>
>>                        break;
>> @@ -309,6 +310,10 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
>>                        cache_init(&cid, *fclus, *dclus);
>>        }
>>
>> +     brelse(bh);
>>        exfat_cache_add(inode, &cid);
>>        return 0;
>> +err:
>> +     brelse(bh);
>> +     return -EIO;
>>   }
> 
> 


