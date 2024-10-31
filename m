Return-Path: <linux-fsdevel+bounces-33371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D099B8454
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 21:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221861F23C8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 20:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430301CC15B;
	Thu, 31 Oct 2024 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdJ/Hwsu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380DE1A2562;
	Thu, 31 Oct 2024 20:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730406451; cv=none; b=oTbFRfPdCWm6oI6HIdgMzKhzQPHxLILjYjcWrdrOxSdEgh8Rl20pWaj8nFyL5ciQC/yQEfTFdG4lyQZ3aFw3FyXE2umPwx//jd2Yw1qQlmGpiN8Qo7j++UuYF8T8Wyy0TviX8hRdjKg9oY52mbwcDKf7gAqbnk9psIVe99jmdwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730406451; c=relaxed/simple;
	bh=kv2+7OlHCjC0tPI/3wz8n3SeaSDAj6aV6+PvgugcIss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYcmBb0GQhNE2UiN68ZQgdPzrUywBx+8NLMZpqg9xpxmCbFdVEhtZKTQuFu/xFH8t7cLx9O7Xzj5EwtRaXFhkkeg9eha7Jw6NwRxe92kU6Uh4rpelhuP9YXZ0fD267bQ174rU4EssnCgLa2XQitxiPSkZxAC5QA+gW7j97wADCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdJ/Hwsu; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso21977301fa.3;
        Thu, 31 Oct 2024 13:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730406445; x=1731011245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BEFnsY2CvQcZlMMqwjbmkpFpmklJCE96WVm7txQ8Rak=;
        b=DdJ/HwsuJjrcMpsfIty2G6fUWkkPB5agCW9zJzOhzeyT5cRd7SCjGE0zwVgXHNRzPL
         H5yWfmVvZshuimM/U3qZ3Yb9qinCHrkfhfZOZiOt57Co1Wv33k/zyBu28NJpNVnQlSTW
         Y76URQbBNFn+EqDvQhhoyZ3q8/rTyC7t3W0/UUea35xQn3/uv0lKySoaxhXlH/0NtnfQ
         RU8nZKjqKT/KTmkdkuGZlDNKatsvfPRsZO+buTrl3uBj5704AUYjEmOKM4CEKMu0Nuut
         FXMcYQqOREOg7NyKryq1WJl0bjFFltWfO3oEO7Ce9Gnr/5lJqRJREYXdx8KtKS3eiZQ+
         kSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730406445; x=1731011245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BEFnsY2CvQcZlMMqwjbmkpFpmklJCE96WVm7txQ8Rak=;
        b=fuMtcJZ2XWF8t9A5Z8iOUpyPzSn4+sX/hkL3ywXGflSKGSKuEaMEohFjQAIbnT1gxS
         xzLc0Tu+1SUtSsZhX/Jn7ksRjXlwP8Vh9B5RyOO4/GG8jUNafUbFDFyzR+gkw1/oXSI+
         hJF7Oj5G0w1eHrX60zbp0WByB0GK8MVYlTZ3ASqFytCIe2+BsgQCVDP/r8cVAgxLQArY
         pzMvooajaV+GCHPckMsILjwyCbofWcInIb1tqQl+fFAxVziV4VjCyhq3bWzx+iEpkLQT
         B0hZNv7NzlltbfoqKI+VtJnagZbp9RYfUIfrY2sG+z2bcCPzr/ep+vHWmcgzPfRGeJdV
         nBvA==
X-Forwarded-Encrypted: i=1; AJvYcCUO/bZobi6tF2lm8i9VnLkgs7ZcOCrCh5CjWisH7XZ55alGIQhQNffU22UzGPOwwd0UhTBUajWGqvOFVd2C@vger.kernel.org, AJvYcCV/Ce+MwlOkSASvxstKBaB83jgg9c8lDH6FtsZkrGwuhwnhzbYpVRIGYYEUvljcvIuTxHJcMmskVFHuRlAP@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMjMNtrWnP31/jm7jWCnMIlvw080Nmtra03HddTtw3xy9u0+j
	xbbyii7/lV8drOAYOT3s9KVqyTNHjDlwPSknMYWMn7FhpJ2Zsby9
X-Google-Smtp-Source: AGHT+IGBDmtpJtMNpaRqVNfV9S5wX3xBApWgSas4UQFhVFwI879M3XeJlV47CsMLYesaysiW6eW7dQ==
X-Received: by 2002:a2e:a88b:0:b0:2fa:c0b5:ac8c with SMTP id 38308e7fff4ca-2fedb7c9c2dmr11743571fa.21.1730406444835;
        Thu, 31 Oct 2024 13:27:24 -0700 (PDT)
Received: from [192.168.178.20] (dh207-40-94.xnet.hr. [88.207.40.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565e08fesm100924666b.134.2024.10.31.13.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 13:27:24 -0700 (PDT)
Message-ID: <4c98507d-8c8e-4f8e-ba23-7805908e1477@gmail.com>
Date: Thu, 31 Oct 2024 21:26:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] fs/proc/kcore.c: fix coccinelle reported ERROR
 instances
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jakob Koschel <jakobkoschel@gmail.com>,
 Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
 Oscar Salvador <osalvador@suse.de>,
 Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 Cristiano Giuffrida <c.giuffrida@vu.nl>, "Bos, H.J." <h.j.bos@vu.nl>,
 Alexey Dobriyan <adobriyan@gmail.com>, Yang Li <yang.lee@linux.alibaba.com>,
 Baoquan He <bhe@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
 Yan Zhen <yanzhen@vivo.com>
References: <20241029054651.86356-2-mtodorovac69@gmail.com>
 <20241029182914.9006075cf5844bc8e679f72c@linux-foundation.org>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <20241029182914.9006075cf5844bc8e679f72c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi, Mr. Andrew,

On 10/30/24 02:29, Andrew Morton wrote:
> On Tue, 29 Oct 2024 06:46:52 +0100 Mirsad Todorovac <mtodorovac69@gmail.com> wrote:
> 
>> Coccinelle complains about the nested reuse of the pointer `iter' with different
>> pointer type:
>>
>> ./fs/proc/kcore.c:515:26-30: ERROR: invalid reference to the index variable of the iterator on line 499
>> ./fs/proc/kcore.c:534:23-27: ERROR: invalid reference to the index variable of the iterator on line 499
>> ./fs/proc/kcore.c:550:40-44: ERROR: invalid reference to the index variable of the iterator on line 499
>> ./fs/proc/kcore.c:568:27-31: ERROR: invalid reference to the index variable of the iterator on line 499
>> ./fs/proc/kcore.c:581:28-32: ERROR: invalid reference to the index variable of the iterator on line 499
>> ./fs/proc/kcore.c:599:27-31: ERROR: invalid reference to the index variable of the iterator on line 499
>> ./fs/proc/kcore.c:607:38-42: ERROR: invalid reference to the index variable of the iterator on line 499
>> ./fs/proc/kcore.c:614:26-30: ERROR: invalid reference to the index variable of the iterator on line 499
>>
>> Replacing `struct kcore_list *iter' with `struct kcore_list *tmp' doesn't change the
>> scope and the functionality is the same and coccinelle seems happy.
> 
> Well that's dumb of it.  Still, the code is presently a bit weird and
> we don't mind working around such third-party issues.
> 
>> NOTE: There was an issue with using `struct kcore_list *pos' as the nested iterator.
>>       The build did not work!
> 
> It worked for me.  What's wrong with that?

Now with next-20241031 it works for me too:

marvin@defiant:~/linux/kernel/linux-next$ time nice sudo make TARGETS=proc kselftest |& tee ../kself-proc-01a.log; date
make[3]: Entering directory '.../linux-next/tools/testing/selftests/proc'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory '.../linux-next/tools/testing/selftests/proc'
make[3]: Entering directory '.../linux-next/tools/testing/selftests/proc'
TAP version 13
1..23
# timeout set to 45
# selftests: proc: fd-001-lookup
ok 1 selftests: proc: fd-001-lookup
# timeout set to 45
# selftests: proc: fd-002-posix-eq
ok 2 selftests: proc: fd-002-posix-eq
# timeout set to 45
# selftests: proc: fd-003-kthread
ok 3 selftests: proc: fd-003-kthread
# timeout set to 45
# selftests: proc: proc-2-is-kthread
ok 4 selftests: proc: proc-2-is-kthread
# timeout set to 45
# selftests: proc: proc-loadavg-001
ok 5 selftests: proc: proc-loadavg-001
# timeout set to 45
# selftests: proc: proc-empty-vm
ok 6 selftests: proc: proc-empty-vm
# timeout set to 45
# selftests: proc: proc-pid-vm
ok 7 selftests: proc: proc-pid-vm
# timeout set to 45
# selftests: proc: proc-self-map-files-001
ok 8 selftests: proc: proc-self-map-files-001
# timeout set to 45
# selftests: proc: proc-self-map-files-002
ok 9 selftests: proc: proc-self-map-files-002
# timeout set to 45
# selftests: proc: proc-self-isnt-kthread
ok 10 selftests: proc: proc-self-isnt-kthread
# timeout set to 45
# selftests: proc: proc-self-syscall
ok 11 selftests: proc: proc-self-syscall
# timeout set to 45
# selftests: proc: proc-self-wchan
ok 12 selftests: proc: proc-self-wchan
# timeout set to 45
# selftests: proc: proc-subset-pid
ok 13 selftests: proc: proc-subset-pid
# timeout set to 45
# selftests: proc: proc-tid0
ok 14 selftests: proc: proc-tid0
# timeout set to 45
# selftests: proc: proc-uptime-001
ok 15 selftests: proc: proc-uptime-001
# timeout set to 45
# selftests: proc: proc-uptime-002
ok 16 selftests: proc: proc-uptime-002
# timeout set to 45
# selftests: proc: read
ok 17 selftests: proc: read
# timeout set to 45
# selftests: proc: self
ok 18 selftests: proc: self
# timeout set to 45
# selftests: proc: setns-dcache
ok 19 selftests: proc: setns-dcache
# timeout set to 45
# selftests: proc: setns-sysvipc
ok 20 selftests: proc: setns-sysvipc
# timeout set to 45
# selftests: proc: thread-self
ok 21 selftests: proc: thread-self
# timeout set to 45
# selftests: proc: proc-multiple-procfs
ok 22 selftests: proc: proc-multiple-procfs
# timeout set to 45
# selftests: proc: proc-fsconfig-hidepid
ok 23 selftests: proc: proc-fsconfig-hidepid
make[3]: Leaving directory '.../linux-next/tools/testing/selftests/proc'

Unless I badly missed something, the build is OK.

>> --- a/fs/proc/kcore.c
>> +++ b/fs/proc/kcore.c
>> @@ -493,13 +493,13 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>>  		 * the previous entry, search for a matching entry.
>>  		 */
>>  		if (!m || start < m->addr || start >= m->addr + m->size) {
>> -			struct kcore_list *iter;
>> +			struct kcore_list *tmp;
> 
> `tmp' is a really poor identifier :(
> 
> Let's try `pos':
> 
> --- a/fs/proc/kcore.c~fs-proc-kcorec-fix-coccinelle-reported-error-instances-fix
> +++ a/fs/proc/kcore.c
> @@ -493,13 +493,13 @@ static ssize_t read_kcore_iter(struct ki
>  		 * the previous entry, search for a matching entry.
>  		 */
>  		if (!m || start < m->addr || start >= m->addr + m->size) {
> -			struct kcore_list *tmp;
> +			struct kcore_list *pos;
>  
>  			m = NULL;
> -			list_for_each_entry(tmp, &kclist_head, list) {
> -				if (start >= tmp->addr &&
> -				    start < tmp->addr + tmp->size) {
> -					m = tmp;
> +			list_for_each_entry(pos, &kclist_head, list) {
> +				if (start >= pos->addr &&
> +				    start < pos->addr + pos->size) {
> +					m = pos;
>  					break;
>  				}
>  			}



I see that it is already applied in next-20241031 and it is just running.

$ uname -rms
Linux 6.12.0-rc5-next-20241031nxt x86_64

Please add

Tested-by: Mirsad Todorovac <mtodorovac69@gmail.com>

Thanks.

Best regards,
Mirsad

