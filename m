Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D61C2D88C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 18:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407456AbgLLRs3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 12:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgLLRs3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 12:48:29 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AEDC0613CF
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 09:47:48 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id v3so6374933plz.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 09:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZSVmkxSxlO3p2RgjrPeWvLUTpfbjgmdh8OMYu3RitqE=;
        b=fj+u++8hoZkE2GZf2xH5hz00mdwRzgcH8Vu5kzZEIxEX+CM/Qj6+2w8DKxPc3ilVVe
         /eYT8w+5+qfUaltrPRoCNTqRn9fh/FqFRbKRZm6GFVPvBEB8VHp2Rt+3DIIa/6/iallR
         nalqr6LjZFp/p0Q58WX57wuXOLdsy5ipha9y1o6tXw/z9wrdedLE9aTP1D8dZ62uLP44
         znExWUrhosTVfeY43nZIa0x1pe0Yjra9K4aZ618YEATgKSUaFZXc8SbHyi6EHm5EYhrf
         puT8jytyLRWGCT0WLdqg3IdUEj6zCtz0j5wTjUytn5RjDRjz7j+IQtCLQ1O0APFVqsKn
         UCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZSVmkxSxlO3p2RgjrPeWvLUTpfbjgmdh8OMYu3RitqE=;
        b=uHjTWPtVrFJE7mMx8zMrKfS8npfMZ34XSma7Wevl6lLekWTAqBYK9PI0RhH65qb4bJ
         TakD+TqID/1GUvJnvDGIy5CS6EHUPRQMJN28s1D+VYrtFtjDicNEKqKe9yals4Yk0rBt
         esy+UtMlvXUwP/18gBgueJg+wcMzxag2iF9wMDDWtnIRJygbw9HBYCg0TBxdOjj5rLhX
         7kJGVe0r+FvI6wwpGED9vFI8uDwm4MOUtAUgy0q3loPLWPK38v1veUgQZBZCKZ1ISL++
         6Q6eGVJDVrr9PUu0GjkHUE0IWmJwL7wexJj+gkDiqhEAIOz1JSo8WZ0h78AInTr9qdXt
         WRwg==
X-Gm-Message-State: AOAM530HrU8qwGjDuc8ymoM/5LRFDc81n3hq9D/8g6yJ5Op6x2s+TJqu
        uZ0GEXaeRCkAY13teg44ET9l11RJE7Qo4A==
X-Google-Smtp-Source: ABdhPJw7t0gzUMcpBNX1B258IvEIiBlEgvaG/j9peT8ovH3crS1kOKxhtCYR0Je6rdTK7r8hOBsU7A==
X-Received: by 2002:a17:902:5997:b029:da:a1cd:3cc2 with SMTP id p23-20020a1709025997b02900daa1cd3cc2mr15961060pli.80.1607795268158;
        Sat, 12 Dec 2020 09:47:48 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 3sm14775953pfv.92.2020.12.12.09.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Dec 2020 09:47:47 -0800 (PST)
Subject: Re: [PATCH 4/5] fs: honor LOOKUP_NONBLOCK for the last part of file
 open
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
References: <20201212165105.902688-1-axboe@kernel.dk>
 <20201212165105.902688-5-axboe@kernel.dk>
 <20201212172528.GB3579531@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c48b976a-a074-4e61-b61b-4eb62e61e87a@kernel.dk>
Date:   Sat, 12 Dec 2020 10:47:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201212172528.GB3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/20 10:25 AM, Al Viro wrote:
> On Sat, Dec 12, 2020 at 09:51:04AM -0700, Jens Axboe wrote:
> 
>>  	struct dentry *dentry;
>> @@ -3164,17 +3165,38 @@ static const char *open_last_lookups(struct nameidata *nd,
>>  	}
>>  
>>  	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
>> -		got_write = !mnt_want_write(nd->path.mnt);
>> +		if (nonblock) {
>> +			got_write = !mnt_want_write_trylock(nd->path.mnt);
>> +			if (!got_write)
>> +				return ERR_PTR(-EAGAIN);
>> +		} else {
>> +			got_write = !mnt_want_write(nd->path.mnt);
>> +		}
>>  		/*
>>  		 * do _not_ fail yet - we might not need that or fail with
>>  		 * a different error; let lookup_open() decide; we'll be
>>  		 * dropping this one anyway.
>>  		 */
> 
> Read the comment immediately after the place you are modifying.  Really.
> To elaborate: consider e.g. the case when /mnt/foo is a symlink to /tmp/bar,
> /mnt is mounted r/o and you are asking to open /mnt/foo for write.  We get
> to /mnt, call open_last_lookups() to resolve the last component ("foo") in
> it.  And find that the sucker happens to be an absolute symlink, so we need
> to jump into root and resolve "tmp/bar" staring from there.  Which is what
> the loop in the caller is about.  Eventually we'll get to /tmp and call
> open_last_lookups() to resolve "bar" there.  /tmp needs to be mounted
> writable; /mnt does not.
> 
> Sure, you bail out only in nonblock case, so normally the next time around
> it'll go sanely.  But you are making the damn thing (and it's still too
> convoluted, even after a lot of massage towards sanity) harder to reason
> about.

Thanks - I did read that comment, but reading your full explanation it's
starting to make sense. I'll have it follow the same paradigm for the
nonblocking side.

>> +	if (open_flag & O_CREAT) {
>> +		if (nonblock) {
>> +			if (!inode_trylock(dir->d_inode)) {
>> +				dentry = ERR_PTR(-EAGAIN);
>> +				goto drop_write;
>> +			}
>> +		} else {
>> +			inode_lock(dir->d_inode);
>> +		}
>> +	} else {
>> +		if (nonblock) {
>> +			if (!inode_trylock_shared(dir->d_inode)) {
>> +				dentry = ERR_PTR(-EAGAIN);
>> +				goto drop_write;
>> +			}
>> +		} else {
>> +			inode_lock_shared(dir->d_inode);
>> +		}
>> +	}
>>  	dentry = lookup_open(nd, file, op, got_write);
> 
> ... as well as more bloated, with no obvious benefits (take a look
> at lookup_open()).

Can you elaborate? It's hard not to make

if (nonblock) {
	trylock;
} else
	lock;
}

not look/feel bloated, as it tends to explode it like the above. Can
hide it in helpers, but really, the logic needs to look like that...

-- 
Jens Axboe

