Return-Path: <linux-fsdevel+bounces-57886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC2AB26627
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA19564DED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 13:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582DB2D738D;
	Thu, 14 Aug 2025 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DN5WKlk4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE64149C7B;
	Thu, 14 Aug 2025 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176555; cv=none; b=Cgp3LIkol/39ENk9kwQhiaE9je2s4p3PTMnenl1AuEzjG9OisKif4PQF0KCKP39RE3X2inwyAtHwooq+zRyoRizdG5hmcedKCiNjPSgPAYaLo+g/9Oc5/sMysu8tMlEaQiHNoFqdyindetmROxGph6msyKi+hJ+hDY0dW2ZUv7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176555; c=relaxed/simple;
	bh=wa8geRxqrSU0ClRxE5m1G0fYsxAKnYlzT7v5YAtCSBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqOEDa00EYU2K1ov+qW6Hb1xEkk+xapd1rzQYaV3EZYA1bbKfum0hHW3cGAMQ0vdA/ogBncZa0ewb4r/RQF6yZIYdF+3OV8AGOEkz0d0kzij4Ow4d+13OpgjyLWDWlQ4O56blC3Z51xTG7a0jUnDsbTrfI2KLXDVgbIxx4AlkOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DN5WKlk4; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Dgy0S83Cr9KrvoU/zU+CWqulo9fmNO5crSndIMyT4kU=; b=DN5WKlk44aV97zBO4CrcBLRtYM
	wLyCsRBTIFTV2eXL3LTgkMwZ3ZkGbBcDELu3AYUh9j/0GEkav/26LpDg9oTVTotSP5jSuhEQ3NMeJ
	pLthCDAWWIjiNjn0iCWNOc4q+0gyx4ylRQ4Ibs6YTb/TjirWSseCQvI229a7Yh8YKQhTpEsfSLFMj
	yNqreFChfKxTQg3dHRd3tHf8CtuE/LRPMpM979CSL0hdOZS4supNz9Ixg2jWuj+qUfTsRQZeA4Ri1
	cWBBXByUx8s0Je/TFICdJHDWO6HRfQ9v1CvzLPEAUBv54PjaBK4ZJX4241c61gfmypGvBnFoxH7dr
	ntM+Japg==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1umXb4-00E7LX-CW; Thu, 14 Aug 2025 15:02:22 +0200
Message-ID: <22a794e8-39c1-4f30-80c4-989a81c6b968@igalia.com>
Date: Thu, 14 Aug 2025 10:02:17 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] ovl: Create ovl_casefold() to support casefolded
 strncmp()
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>,
 Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 kernel-dev@igalia.com
References: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com>
 <20250813-tonyk-overlayfs-v4-3-357ccf2e12ad@igalia.com>
 <CAOQ4uxgDw5SVaoSJNzt2ma4P+XkVcvaJZoKmd1AmrTuqDxHc6A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxgDw5SVaoSJNzt2ma4P+XkVcvaJZoKmd1AmrTuqDxHc6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Amir,

Em 14/08/2025 09:53, Amir Goldstein escreveu:
> On Thu, Aug 14, 2025 at 12:37 AM André Almeida <andrealmeid@igalia.com> wrote:
>>
>> To add overlayfs support casefold filesystems, create a new function
>> ovl_casefold(), to be able to do case-insensitive strncmp().
>>
>> ovl_casefold() allocates a new buffer and stores the casefolded version
>> of the string on it. If the allocation or the casefold operation fails,
>> fallback to use the original string.
>>
>> The case-insentive name is then used in the rb-tree search/insertion
>> operation. If the name is found in the rb-tree, the name can be
>> discarded and the buffer is freed. If the name isn't found, it's then
>> stored at struct ovl_cache_entry to be used later.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---

[...]

>> +       }
>>
>>          INIT_LIST_HEAD(list);
>>   }
>> @@ -260,12 +311,28 @@ static bool ovl_fill_merge(struct dir_context *ctx, const char *name,
>>   {
>>          struct ovl_readdir_data *rdd =
>>                  container_of(ctx, struct ovl_readdir_data, ctx);
>> +       struct ovl_fs *ofs = OVL_FS(rdd->dentry->d_sb);
>> +       const char *aux = NULL;
> 
> It looks strange to me that you need aux
> and it looks strange to pair <aux, cf_len>
> neither here or there...
> 

The reason behind this `aux` var is because I need a `const char` 
pointer to point to the `name` argument, and `cf_name` can't be const 
because it goes through ovl_casefold(). I tried a couple approaches here 
to get rid of the compiler warning regarding const, and the only way I 
managed to was using a third variable like that.

>> +       char *cf_name = NULL;
>> +       int cf_len = 0;
>> +
>> +       if (ofs->casefold)
>> +               cf_len = ovl_casefold(rdd->map, name, namelen, &cf_name);
>> +
>> +       if (cf_len <= 0) {
>> +               aux = name;
> 
> why not:
> cf_name = name;
> 
>> +               cf_len = namelen;
>> +       } else {
>> +               aux = cf_name;
>> +       }
> 
> and no aux and no else needed at all?
> 
> If you don't like a var named cf_name to point at a non-casefolded
> name buffer, then use other var names which are consistent such as
> <c_name, c_len> (c for "canonical" or "compare" name).
> 
>>
>>          rdd->count++;
>>          if (!rdd->is_lowest)
>> -               return ovl_cache_entry_add_rb(rdd, name, namelen, ino, d_type);
>> +               return ovl_cache_entry_add_rb(rdd, name, namelen, aux, cf_len,
>> +                                             ino, d_type);
>>          else
>> -               return ovl_fill_lowest(rdd, name, namelen, offset, ino, d_type);
>> +               return ovl_fill_lowest(rdd, name, namelen, aux, cf_len,
>> +                                      offset, ino, d_type);
>>   }
>>
> 
> What do you think about moving all the consume/free buffer logic out to caller:
> 

That looks way cleaner to me, thanks! I will apply this approach for v5.

> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index b65cdfce31ce..e77530c63207 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -174,7 +174,8 @@ static struct ovl_cache_entry
> *ovl_cache_entry_new(struct ovl_readdir_data *rdd,
>          return p;
>   }
> 
> -static bool ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
> +/* Return 0 for found, >0 for added, <0 for error */
> +static int ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
>                                    const char *name, int len, u64 ino,
>                                    unsigned int d_type)
>   {
> @@ -183,22 +184,23 @@ static bool ovl_cache_entry_add_rb(struct
> ovl_readdir_data *rdd,
>          struct ovl_cache_entry *p;
> 
>          if (ovl_cache_entry_find_link(name, len, &newp, &parent))
> -               return true;
> +               return 0;
> 
>          p = ovl_cache_entry_new(rdd, name, len, ino, d_type);
>          if (p == NULL) {
>                  rdd->err = -ENOMEM;
> -               return false;
> +               return -ENOMEM;
>          }
> 
>          list_add_tail(&p->l_node, rdd->list);
>          rb_link_node(&p->node, parent, newp);
>          rb_insert_color(&p->node, rdd->root);
> 
> -       return true;
> +       return 1;
>   }
> 
> -static bool ovl_fill_lowest(struct ovl_readdir_data *rdd,
> +/* Return 0 for found, >0 for added, <0 for error */
> +static int ovl_fill_lowest(struct ovl_readdir_data *rdd,
>                             const char *name, int namelen,
>                             loff_t offset, u64 ino, unsigned int d_type)
>   {
> @@ -207,6 +209,7 @@ static bool ovl_fill_lowest(struct ovl_readdir_data *rdd,
>          p = ovl_cache_entry_find(rdd->root, name, namelen);
>          if (p) {
>                  list_move_tail(&p->l_node, &rdd->middle);
> +               return 0;
>          } else {
>                  p = ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
>                  if (p == NULL)
> @@ -215,7 +218,7 @@ static bool ovl_fill_lowest(struct ovl_readdir_data *rdd,
>                          list_add_tail(&p->l_node, &rdd->middle);
>          }
> 
> -       return rdd->err == 0;
> +       return rdd->err ?: 1;
>   }
> 
> @@ -260,12 +263,31 @@ static bool ovl_fill_merge(struct dir_context
> *ctx, const char *name,
>   {
>          struct ovl_readdir_data *rdd =
>                  container_of(ctx, struct ovl_readdir_data, ctx);
> +       struct ovl_fs *ofs = OVL_FS(rdd->dentry->d_sb);
> +       char *c_name = NULL;
> +       int c_len = 0;
> +       int ret;
> +
> +       if (ofs->casefold)
> +               c_len = ovl_casefold(rdd->map, name, namelen, &c_name);
> +
> +       if (c_len <= 0) {
> +               c_name = name;
> +               c_len = namelen;
> +       }
> 
>          rdd->count++;
> -       if (!rdd->is_lowest)
> -               return ovl_cache_entry_add_rb(rdd, name, namelen, ino, d_type);
> -       else
> -               return ovl_fill_lowest(rdd, name, namelen, offset, ino, d_type);
> +       if (!rdd->is_lowest) {
> +               ret = ovl_cache_entry_add_rb(rdd, name, namelen, c_name, c_len,
> +                                            ino, d_type);
> +       } else {
> +               ret = ovl_fill_lowest(rdd, name, namelen, c_name, c_len, offset,
> +                                     ino, d_type);
> +       }
> +       // ret > 1 means c_name is consumed
> +       if (ret <= 0 && c_len > 0)
> +               kfree(c_name);
> +       return ret >= 0;
>   }
> 
> Thanks,
> Amir.


