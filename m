Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0B42E1A9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 10:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgLWJtq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Dec 2020 04:49:46 -0500
Received: from mout.gmx.net ([212.227.17.22]:60513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgLWJtp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Dec 2020 04:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608716891;
        bh=65nC/HIa2Iw+m1jZNyib0HWtljb/LeXqdwbAk2EgPYI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bpnWEIf+jRO3wV+4x01rnV/5YyOqpG9k2jAGURrJRWiBdc9vc0f04g/aRIAYSdBk0
         +kNf7L7jl53yyDXqpv2Dg1ag4cOyfodr5OGVH57QcV3/+cB5kgl/nAtWewsOGauJUg
         WudPC6ozCpCBcXd9tYIAtaj/hAiTGq6aQh/4mtYA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.156.206]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UZG-1krSWG3RVi-000Zpk; Wed, 23
 Dec 2020 10:48:10 +0100
Subject: Re: [PATCH] proc/wchan: Use printk format instead of
 lookup_symbol_name()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20201217165413.GA1959@ls3530.fritz.box>
 <20201222181807.360cd9458d50b625608b8b44@linux-foundation.org>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <b54649ea-1bec-25a9-2c22-35bdfabc89a9@gmx.de>
Date:   Wed, 23 Dec 2020 10:48:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201222181807.360cd9458d50b625608b8b44@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gRmuymGPB2LiNQ4rNhvvXmoz1yazFT4wiKbtNc6Z8rEG6IT3DCU
 Hv7Q4ZEx1rSIJuvDO2hX7VM49rGf2C82Ja2Z4klmHQShQwHwZQ9BTPfGclXdgeiyGQ/B8Vo
 hTJhy9/qAVUUQcqzqoFgBv1ywY9F2IvMWGm7HOYYwBHYS2lRKJVOWn5OScwGBrTfQV9Uol+
 5LXHQDblC9HEOZuY6866w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sUNSr/yqII8=:OxBfkv1UwqxWrNFMeT/nhL
 lHTmDd9qfp0OCf4Eh8AGP9u9cM4nmpIIffe4wYvpyVJMAaAFAbvoWEMy52RqU3UNK7im6cM32
 XNbwIrLAyAhTK30TDidOwIZP0st2uKILaDTEzk4+f0R4I/3NMXhkPHFiDiUgwBjbKiJjBGKMM
 2SyRC/KmUYfpCUZ2Mv5xqY1wyP9qGJueY4iLDuk+0R1xdkcULvpS5k2rzZ5dOvl3zbIbHdMhQ
 Ynju3L2DysEbIm2A85wV9WqmRXtfJO0SewhXVRw31BHZI1VAGDGsQk+HgFpJW2HrunKF3i2L2
 mSJ5pSxRUPvP1lF0rQeTJPhpCJyJYFdBQveVWdNoqAJ2C+IDv306WODPeJbBU5cqN19ZktlTC
 VuOOxzfRy6rvvoGgGKiJKNSnbWe3xfNKcDymEhvTrqrRf6koT6qpgjg/ByYSaj+o7y30MuzSV
 xrQRNGeAHOt5qTQOS3elicpewBZwbMsZX7IzM7SFQ0F5jQCfzc8QCL/B+PO2ogZRsBhISC7Qi
 Cv7MCLi460xJAJGvvR2YClDOD3IaKhHP4ePJBqWI3tRGILze5pErK7edBuqZfOR0rbZQBN+SK
 LOr2vDB9XTlpfigftB/1KBDiflhdkoe66YZ8MTmTjNvNdEcqG45iCmCe54AP2UbhvklyTvzS+
 4npuiuBYYGPU1o4nLgI94USX0UJfsHx0VTzbdi9lR9K1OXxlAmF9E7mEuqHyGxPxuTVNO6/I3
 0Bvrx+SQanLLbgXja+4BMEt0U0fI8yWfNVuuzxqse0KQx2AGCBbL9a7pH4cMiQtoKnOybDEjJ
 Fy2pQAoHALrHle6PyBl0osoYTiOkhT+k0kjyBOkdRGmu/MOfCZD8KoRpl2x6irvB5I5ixfhnZ
 HMGFrKwQMvsDVaJombgA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/23/20 3:18 AM, Andrew Morton wrote:
> On Thu, 17 Dec 2020 17:54:13 +0100 Helge Deller <deller@gmx.de> wrote:
>
>> To resolve the symbol fuction name for wchan, use the printk format
>> specifier %ps instead of manually looking up the symbol function name
>> via lookup_symbol_name().
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>
> Please don't forget the "^---$" to separate the changelog from the
> diff.

Ok.

>
>>  #include <linux/module.h>
>> @@ -386,19 +385,17 @@ static int proc_pid_wchan(struct seq_file *m, str=
uct pid_namespace *ns,
>>  			  struct pid *pid, struct task_struct *task)
>>  {
>>  	unsigned long wchan;
>> -	char symname[KSYM_NAME_LEN];
>>
>> -	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
>> -		goto print0;
>> +	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
>> +		wchan =3D get_wchan(task);
>> +	else
>> +		wchan =3D 0;
>>
>> -	wchan =3D get_wchan(task);
>> -	if (wchan && !lookup_symbol_name(wchan, symname)) {
>> -		seq_puts(m, symname);
>> -		return 0;
>> -	}
>> +	if (wchan)
>> +		seq_printf(m, "%ps", (void *) wchan);
>> +	else
>> +		seq_putc(m, '0');
>>
>> -print0:
>> -	seq_putc(m, '0');
>>  	return 0;
>>  }
>
> We can simplify this further?
>
> static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
> 			  struct pid *pid, struct task_struct *task)
> {
> 	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
> 		seq_printf(m, "%ps", (void *)get_wchan(task));
> 	else
> 		seq_putc(m, '0');
>
> 	return 0;
> }
>
>
> --- a/fs/proc/base.c~proc-wchan-use-printk-format-instead-of-lookup_symb=
ol_name-fix
> +++ a/fs/proc/base.c
> @@ -384,15 +384,8 @@ static const struct file_operations proc
>  static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
>  			  struct pid *pid, struct task_struct *task)
>  {
> -	unsigned long wchan;
> -
>  	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
> -		wchan =3D get_wchan(task);
> -	else
> -		wchan =3D 0;
> -
> -	if (wchan)
> -		seq_printf(m, "%ps", (void *) wchan);
> +		seq_printf(m, "%ps", (void *)get_wchan(task));
>  	else
>  		seq_putc(m, '0');

get_wchan() does return NULL sometimes, in which case with
your change now "0x0" instead of "0" gets printed.

If that's acceptable, then your patch is Ok.

Helge
