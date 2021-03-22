Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4383435DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 01:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhCVAMp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 20:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhCVAM0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 20:12:26 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2EAC061574;
        Sun, 21 Mar 2021 17:12:26 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id m7so7499346pgj.8;
        Sun, 21 Mar 2021 17:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+HYl4P5peIoOD4DY9nUfCJM5/NVtJNBygH/MHo2LSfY=;
        b=cRAIb0n0q60syCpqe59q36OSXXV/fM1hyADjtLjnWUejeOFMObLEzzBkEy/Me0o5F8
         wFSSv/P+I8pKflAftOLMcXjllo/NMCYhuXYpWZQbGadoK0FR8rZbvSo5hJejgButI5aC
         fnLm3zoogiHKqWeOVGmEmb9mxGAUdAXUsRL8UYkDQ+DvPgErwUpU1qk+9xV87Iep+ekA
         rt6dCEtKFMhnnmZnBJlTiVwuEgs3rMKK7M/X2+66twiT6rerx1BcvQsAe9zbtP2GtXIH
         IVCi4WuRceGz8Tc4GkgIxQM7m2Db8Idv6NyNovxiEmgH2utjdWfP5RZGZydH8EYZmrR6
         jX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+HYl4P5peIoOD4DY9nUfCJM5/NVtJNBygH/MHo2LSfY=;
        b=YwT7ekC2W6Jdy/NLtt8tvscNuXStEzUWJp3rSX5AfKHqKpwoS3F9QwYgl+eRw1RdFI
         InVWyiku0YkSiozykjH7OwMZYZYRAbBS0JE1wyttsj0K2yvrgA5DF9U0SAyzd079qZ00
         jU1UXqksuGkCuf8DTqed3+fSNVfkzXCrRFnIqPMuC7bsKozeHqMgb4Y4jw5gzJytMkAq
         TPGSUI24Ow5pO85Iz79FALnnySFwQwyzRWf9Xjmk0mwk7c87jEPf8Ub4hs25O9uvotXE
         jUULuRSOw2WnMVnaDlJ0CUhQnIa34uL5/WeG9uofyV3V4lUmKC5gl8GORHdT1A0ymEMB
         Zkag==
X-Gm-Message-State: AOAM530c27/uZ3zKTPkIOi+0b1KjDND9evzvXV/Z/EFR8t4sEml4yDdP
        gTVrJRrl+DUyV2ulWcqTZuQtCHieAWZMZA==
X-Google-Smtp-Source: ABdhPJzOUWgMPgK0ModwjBu1ELqkROApeVKQ1soc0eVLW/dj4utu7m0MwvH9gVzTSU1NY4612yvEMA==
X-Received: by 2002:a62:cfc4:0:b029:200:49d8:6f29 with SMTP id b187-20020a62cfc40000b029020049d86f29mr18561164pfg.45.1616371945236;
        Sun, 21 Mar 2021 17:12:25 -0700 (PDT)
Received: from [192.168.0.12] ([125.186.151.199])
        by smtp.googlemail.com with ESMTPSA id d6sm11319468pfq.109.2021.03.21.17.12.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Mar 2021 17:12:24 -0700 (PDT)
Subject: Re: [PATCH v2] exfat: speed up iterate/lookup by fixing start point
 of traversing cluster chain
To:     Sungjong Seo <sj1557.seo@samsung.com>, namjae.jeon@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <CGME20210318064206epcas1p442b4ed65b1c14b1df56d3560612de668@epcas1p4.samsung.com>
 <20210318064132.78752-1-hyeongseok@gmail.com>
 <b88e01d71ca5$a6e424b0$f4ac6e10$@samsung.com>
From:   Hyeongseok Kim <hyeongseok@gmail.com>
Message-ID: <a43fafea-3f35-76c2-4173-9709c1f51bb0@gmail.com>
Date:   Mon, 22 Mar 2021 09:12:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b88e01d71ca5$a6e424b0$f4ac6e10$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ko-KR
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
On 3/19/21 6:53 PM, Sungjong Seo wrote:
>> When directory iterate and lookup is called, there's a buggy rewinding of
>> start point for traversing cluster chain to the parent directory entry's
>> first cluster. This caused repeated cluster chain traversing from the
>> first entry of the parent directory that would show worse performance if
>> huge amounts of files exist under the parent directory.
>> Fix not to rewind, make continue from currently referenced cluster and dir
>> entry.
>>
>> Tested with 50,000 files under single directory / 256GB sdcard, with
>> command "time ls -l > /dev/null",
>> Before :     0m08.69s real     0m00.27s user     0m05.91s system
>> After  :     0m07.01s real     0m00.25s user     0m04.34s system
>>
>> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
>> ---
>>   fs/exfat/dir.c      | 39 ++++++++++++++++++++++++++++++++-------
>>   fs/exfat/exfat_fs.h |  2 +-
>>   fs/exfat/namei.c    |  6 ++++--
>>   3 files changed, 37 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
>> e1d5536de948..63f08987a8fe 100644
>> --- a/fs/exfat/dir.c
>> +++ b/fs/exfat/dir.c
>> @@ -147,7 +147,7 @@ static int exfat_readdir(struct inode *inode, loff_t
>> *cpos, struct exfat_dir_ent
> [snip]
>> + * @de:         If p_uniname is found, filled with optimized dir/entry
>> + *              for traversing cluster chain. Basically,
>> + *              (p_dir.dir+return entry) and (de.dir.dir+de.entry) are
>> + *              pointing the same physical directory entry, but if
>> + *              caller needs to start to traverse cluster chain,
>> + *              it's better option to choose the information in de.
>> + *              Caller could only trust .dir and .entry field.
> exfat-fs has exfat_hint structure for keeping clusters and entries as hints.
> Of course, the caller, exfat_find(), should adjust exfat_chain with
> hint value just before calling exfat_get_dentry_set() as follows.
>
>          /* adjust cdir to the optimized value */
>          cdir.dir = hint_opt.clu;
>          if (cdir.flag & ALLOC_NO_FAT_CHAIN) {
>                  cdir.size -= dentry / sbi->dentries_per_clu;
>          dentry = hint_opt.eidx;
>
> What do you think about using it?
Agreed.
What I want to change here is very clear and any way to achieve the goal 
would be good.
>> + * @return:
>> + *   >= 0:      file directory entry position where the name exists
>> + *   -ENOENT:   entry with the name does not exist
>> + *   -EIO:      I/O error
>>    */
> [snip]
>> @@ -1070,11 +1081,14 @@ int exfat_find_dir_entry(struct super_block *sb,
>> struct exfat_inode_info *ei,
>>   		}
>>
>>   		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
>> -			if (--clu.size > 0)
>> +			if (--clu.size > 0) {
>> +				exfat_chain_dup(&de->dir, &clu);
> If you want to make a backup of the clu, it seems more appropriate to move
> exfat_chain_dup() right above the "if".
Yes, but we would not need this backup any more.
>
>>   				clu.dir++;
>> +			}
>>   			else
>>   				clu.dir = EXFAT_EOF_CLUSTER;
>>   		} else {
>> +			exfat_chain_dup(&de->dir, &clu);
>>   			if (exfat_get_next_cluster(sb, &clu.dir))
>>   				return -EIO;
>>   		}
>> @@ -1101,6 +1115,17 @@ int exfat_find_dir_entry(struct super_block *sb,
>> struct exfat_inode_info *ei,
>>   	return -ENOENT;
>>
>>   found:
>> +	/* set as dentry in cluster */
>> +	de->entry = (dentry - num_ext) & (dentries_per_clu - 1);
>> +	/*
>> +	 * if dentry_set spans to the next_cluster,
>> +	 * e.g. (de->entry + num_ext + 1 > dentries_per_clu)
>> +	 * current de->dir is correct which have previous cluster info,
>> +	 * but if it doesn't span as below, "clu" is correct, so update.
>> +	 */
>> +	if (de->entry + num_ext + 1 <= dentries_per_clu)
>> +		exfat_chain_dup(&de->dir, &clu);
>> +
> Let it be simple.
> 1. Keep an old value in the stack variable, when it found a FILE or DIR
> entry.
> 2. And just copy that here.
>
> There are more assignments, but I think its impact might be negligible.
> Thanks.
>
>
OK. I thought this routine is more straightforward to understand what is 
being done here.
But I don't have any strong opinion about this, so I'll change in that way.
BTW, I think we can do this without local variable.

