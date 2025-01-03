Return-Path: <linux-fsdevel+bounces-38361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA308A00844
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 12:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99263A3330
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 11:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED231F9EDA;
	Fri,  3 Jan 2025 11:11:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E23F13C690;
	Fri,  3 Jan 2025 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735902690; cv=none; b=OIGZgmUezg7sAzO/wxiVQh8LDu/oqu3TvpE74pAHcODdBCfOh5vtmuWwTNzf8HcP80Iy1H3FX3dYsJoM76DTNB47MxXtuRhnGLlqpa9qKjl07lDO8GPk6BHfKZDUOs85Ox+akhydEl6TCHgW/ryaJd3b/G01969g+ZoWWGd4aKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735902690; c=relaxed/simple;
	bh=bCnUqPW+uaZqwgWS/Af5xf2SIMOWjYh+L074grMjMtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zwt6W6WSFk3fexg6AQkhNOe8tgGkGwC4cxkIYNQvLRDBu9ZeX8YRmkZfOF4JSsv95WWa2ewIJ/2l+KtJuK+cN6ju4sJ0+zTj6s+jzvCAQPIqoJMQj/lbmMSOMCUldEl9kb3puYYW3kARHhmhLK9bh81SQIfaeOGk/7tDteiz/nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-85b83479f45so1754690241.0;
        Fri, 03 Jan 2025 03:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735902683; x=1736507483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDFVJ3n3kKrw5RCyDZC9551byJLb/mR9RzkqrgJ1y6U=;
        b=TtiPRiusmPWPKtU0y4yV26Ay1IEZUoE/vuDJu2F5vG8XUT7EZ1CfiRZ6bTMU+Kg7wD
         FpFxyV82leJWclVCsOY4Oabxck1mbyKbiXL8sfF+ErupnNB2/Sq58qTFH3FZ4QcV98HC
         /nv3ozxGmPCW7pG4i8hMDfqccFjrqbq7SjdwzuvdXgTXSA6BU+AT6HOqWBmqyyiGvFv2
         3IlIdBN5j7O/j8/DoLrCgJWbK1b+rFreRHN8P5mKhKq2RX5tGbaT0QCXI9+lQGdaZnNA
         O8R3M5nAwhNA9T7i7CV6q2SygisK4JfWQIq653gLuJpC8JVfa6g2Kb3Zt4CGUMrdNaKR
         jEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0lK1QasnIVgPEsCZiNhR9gMPG6VUHj7+UUdTF5NnsQGdIB4PkpXeFFngOVBAU/ml2s9V2Mbad+v57DcIH@vger.kernel.org, AJvYcCUBEnMEu7rxPUON770KqwJVO3yzap38bTeoKC94VGN3UzFgGiHKFUym5N0ve+89VwADwwaCguzWbnt4bxB5@vger.kernel.org, AJvYcCVaLyDpQcsJCFKKI7R8qSFHHcGSHccFKHROZfExHXQZtqVgx/MIYITLfx6izStEmY6XC4erO0LnFAFcGmirJFvi7Qq1OxmD@vger.kernel.org, AJvYcCVljOt4THpT1n2/qDKSp1u7G2XgVDDD/z2JS6pAqEim9tVfSNYTEFIG5SU2YmHUqo6sgVz3bCh9lis=@vger.kernel.org, AJvYcCX58Rzw7ifXMNEX8I3OzgOep/PkYTnQteIbvda+WYXfObHY9V15QN99yPM5cowsmf6lAqkBruuuKXND@vger.kernel.org, AJvYcCX89VkY1XBhkzupmdplZcdHpxvS3Ivoz9B8UNO4Cb7aJTtlIT0fnNJQK/YR01hud8E2IJFE8M7u@vger.kernel.org
X-Gm-Message-State: AOJu0YyiMb6NfSvpfw9CmQsFMr2iNfR2r/HALwDoy5gZ9rTv0jOz8sB0
	rFBvhXnn9KiNjhJ34LB76GBWZmRqcMF/bXekceSNOpzYY0g7h8xrHjTxinP/GGQ=
X-Gm-Gg: ASbGncugmAnT34zrc9lt8o9Hu3HfmD8/XejaHqULbhybbAqS1HbhBAcngXh0/alN2oS
	VySeVVR03JxxmT7aYcXdwEp9GE7UG/rfj77R4G9MFikf1PZCa2usQRO2PLi2zEY/4fePsUT7c1p
	yMk0znUUDRRloESYtw06Gfl0FgGigRvuHsLmxYF6t1WTwcGksMxhE4i/4mXnvQHhgUfmogeJBm7
	SzdFBQLCAJP4XJQ7hvXOia4NMV6E2apFOS8bYorx8/TQ7YSvhR4ITSc0zoY7lwA95Qyalu9ePz5
	XnaGnQFdahyLp3C3TVs=
X-Google-Smtp-Source: AGHT+IGJElzszDxwg2WWNvqLHzeq3BtZcReGe9oXqn/yhvlxUQOrqYgoDEx91rLiGitn46LiYyO2Zg==
X-Received: by 2002:a05:6102:dca:b0:4b2:af93:4313 with SMTP id ada2fe7eead31-4b2cc462517mr34277364137.17.1735902682656;
        Fri, 03 Jan 2025 03:11:22 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b2bf98d122sm5479527137.7.2025.01.03.03.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 03:11:21 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-85c4b4cf73aso1865916241.2;
        Fri, 03 Jan 2025 03:11:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/QIIfkxYFBMHtPtTYKWe3ANyRfjQKHkHkJybqfXLIoFkBNWN09FtxtO1bmdOhpmOudmoGY1TCN+VsHK4e@vger.kernel.org, AJvYcCUjVSapyoJ8JTrw9je29jjz5NLeolVDuxGtUVdnYnQghJuf8U0xF0PVz++Riptx5epDEMmGYB1c@vger.kernel.org, AJvYcCWMuELEGyVui5bUQnSeBZ95zndIG1v3g9mM3n3bPF5gKJrsfBzRllADphpGk7DOksrk9kTmD6Z56lxSmhaW@vger.kernel.org, AJvYcCXDsQyJUK1Zu57NJhw3OVDF42ijqjhlge158RwgpFtlJ77D5Sn+dT0/9G46KQawJg8c7/F931/CmO4=@vger.kernel.org, AJvYcCXJn3r0JzBfW777cVWWS8KdLX6eRIBPMcD/e5oW+WLt5IhxfnYS3fd9ak2ZWK6Gi6fDw6pUtEYxAjb9mDeBFYMF/JVmTlTx@vger.kernel.org, AJvYcCXOBHGoI+WCymbPSLgrbTY9ik/lsTuOIgTsd0BY3wMQnouHh6zclzvzEODaOcqD8KYs2wWsv9qElT9x@vger.kernel.org
X-Received: by 2002:a05:6102:5684:b0:4b1:130f:9fc0 with SMTP id
 ada2fe7eead31-4b2cc3808a4mr38937534137.16.1735902681279; Fri, 03 Jan 2025
 03:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241228145746.2783627-1-yukaixiong@huawei.com> <20241228145746.2783627-15-yukaixiong@huawei.com>
In-Reply-To: <20241228145746.2783627-15-yukaixiong@huawei.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 3 Jan 2025 12:11:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVHD+AhMpcyxndTno-ocatS1tRP5uRrKNFL6Z=j3KX8og@mail.gmail.com>
Message-ID: <CAMuHMdVHD+AhMpcyxndTno-ocatS1tRP5uRrKNFL6Z=j3KX8og@mail.gmail.com>
Subject: Re: [PATCH v4 -next 14/15] sh: vdso: move the sysctl to arch/sh/kernel/vsyscall/vsyscall.c
To: Kaixiong Yu <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, luto@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kees@kernel.org, j.granados@samsung.com, 
	willy@infradead.org, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, trondmy@kernel.org, anna@kernel.org, 
	chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, paul@paul-moore.com, 
	jmorris@namei.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dhowells@redhat.com, haifeng.xu@shopee.com, baolin.wang@linux.alibaba.com, 
	shikemeng@huaweicloud.com, dchinner@redhat.com, bfoster@redhat.com, 
	souravpanda@google.com, hannes@cmpxchg.org, rientjes@google.com, 
	pasha.tatashin@soleen.com, david@redhat.com, ryan.roberts@arm.com, 
	ying.huang@intel.com, yang@os.amperecomputing.com, zev@bewilderbeest.net, 
	serge@hallyn.com, vegard.nossum@oracle.com, wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kaixiong,

On Sat, Dec 28, 2024 at 4:07=E2=80=AFPM Kaixiong Yu <yukaixiong@huawei.com>=
 wrote:
> When CONFIG_SUPERH and CONFIG_VSYSCALL are defined,
> vdso_enabled belongs to arch/sh/kernel/vsyscall/vsyscall.c.
> So, move it into its own file. After this patch is applied,
> all sysctls of vm_table would be moved. So, delete vm_table.
>
> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> ---
> v4:
>  - const qualify struct ctl_table vdso_table

Thanks for your patch!

I gave this a try on landisk, and /proc/sys/vm/vdso_enabled
disappeared.

> --- a/arch/sh/kernel/vsyscall/vsyscall.c
> +++ b/arch/sh/kernel/vsyscall/vsyscall.c
> @@ -55,6 +67,8 @@ int __init vsyscall_init(void)
>                &vsyscall_trapa_start,
>                &vsyscall_trapa_end - &vsyscall_trapa_start);
>
> +       register_sysctl_init("vm", vdso_table);

    "failed when register_sysctl_sz vdso_table to vm"

Adding some debug prints shows that kzalloc() in
__register_sysctl_table() fails, presumably because it is called too
early in the boot process.

> +
>         return 0;
>  }

Moving the call to register_sysctl_init() into its own fs_initcall(),
like the gmail-whitespace-damaged patch below, fixes that.

--- a/arch/sh/kernel/vsyscall/vsyscall.c
+++ b/arch/sh/kernel/vsyscall/vsyscall.c
@@ -67,11 +67,17 @@ int __init vsyscall_init(void)
               &vsyscall_trapa_start,
               &vsyscall_trapa_end - &vsyscall_trapa_start);

-       register_sysctl_init("vm", vdso_table);
+       return 0;
+}

+static int __init vm_sysctl_init(void)
+{
+       register_sysctl_init("vm", vdso_table);
        return 0;
 }

+fs_initcall(vm_sysctl_init);
+
 /* Setup a VMA at program startup for the vsyscall page */
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp=
)
 {

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

