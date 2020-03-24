Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12B6F1907FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 09:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgCXIs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 04:48:28 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38762 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgCXIs2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 04:48:28 -0400
Received: by mail-pj1-f67.google.com with SMTP id m15so1136077pje.3;
        Tue, 24 Mar 2020 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=bt3cOsdr0C8cVmPItgi4WdtrPk2V3/FsORYh/CBY/lI=;
        b=vA3p3t11FbBNkJKydmTaNNK3N5QW4gtpYzmlrgSF1JIT3wXicBoyZQ6X2qPv4Qvl27
         atW1VCrGbGDlTg1jxwlWdC53pfi5pO12GqKqWwzjPJCi8yZkG6OkVtvJw1OLGhqdMKWJ
         YVITCgHIF79H5pfiZs2gYUgZSyX4kEOcNHQAOMwGVYaxcpUJsAqTXPerqQZwYHyBEzGP
         +AvKs5zDXWGhMNjVuH2KjgkSnFMBn/CbVRXP9QCpCiofOD2/GVjOn735K6I/pb/gBuj3
         IWQbe9lei2ON6VbPeMLYajngQQ1HgV/7UZkMxmMQH9Ng01J1kjTH9anTeMvW0mB2L1lX
         KhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=bt3cOsdr0C8cVmPItgi4WdtrPk2V3/FsORYh/CBY/lI=;
        b=BuT+swMKDciqMfV1Rt6b9L2ej13W46AaJH+nVcnlpLSEvMRgWhqVvEMlbPx0O1YQC9
         Yts21G3x83lNM0WDFqrTtd6Vvoeh8v7hRSlzqdiaNgp+P+Yk1S0Scm9C2QYzvAQBni35
         j1OjkBuMgmaMQ5IMAXvZp5p3rykDi7l3j92hy8ogMbDhRkHUodak1UmkyyaRL9Dz5Zjo
         pwKyyaqClj4WRk7Or93WOs0ytCCwzD8r2QlTmeoKtPnAOvxYiH54ZySEDgCM2R1yt0Ql
         b/aovxDs72u2Cpv+rwsja1I9yHm2IndN+msDJSle5b7pGg/ST/jVuMZsHl5FtOBgfmwY
         0P5w==
X-Gm-Message-State: ANhLgQ1kIirLbHksAVKFZvd36dbcWNzsFfXdJKR2uY1WiK//NFUwKKs4
        DmmHF9mz15q0B5qvRnc6q5w=
X-Google-Smtp-Source: ADFU+vvkxp5PNoeenVejrf8tpB2gV5C4JXUjlzG5rk+czBLRFZq2ATdOuyQvst6hI/VEssCwU4vvrg==
X-Received: by 2002:a17:90a:37c4:: with SMTP id v62mr4006668pjb.151.1585039706935;
        Tue, 24 Mar 2020 01:48:26 -0700 (PDT)
Received: from localhost (14-202-190-183.tpgi.com.au. [14.202.190.183])
        by smtp.gmail.com with ESMTPSA id f22sm10687021pgl.20.2020.03.24.01.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 01:48:26 -0700 (PDT)
Date:   Tue, 24 Mar 2020 18:48:20 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v11 3/8] powerpc/perf: consolidate read_user_stack_32
To:     linuxppc-dev@lists.ozlabs.org, Michal Suchanek <msuchanek@suse.de>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Richter <erichte@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michael Neuling <mikey@neuling.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200225173541.1549955-1-npiggin@gmail.com>
        <cover.1584620202.git.msuchanek@suse.de>
        <184347595442b4ca664613008a09e8cea7188c36.1584620202.git.msuchanek@suse.de>
In-Reply-To: <184347595442b4ca664613008a09e8cea7188c36.1584620202.git.msuchanek@suse.de>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1585039473.da4762n2s0.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michal Suchanek's on March 19, 2020 10:19 pm:
> There are two almost identical copies for 32bit and 64bit.
>=20
> The function is used only in 32bit code which will be split out in next
> patch so consolidate to one function.
>=20
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> v6:  new patch
> v8:  move the consolidated function out of the ifdef block.
> v11: rebase on top of def0bfdbd603
> ---
>  arch/powerpc/perf/callchain.c | 48 +++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
>=20
> diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.=
c
> index cbc251981209..c9a78c6e4361 100644
> --- a/arch/powerpc/perf/callchain.c
> +++ b/arch/powerpc/perf/callchain.c
> @@ -161,18 +161,6 @@ static int read_user_stack_64(unsigned long __user *=
ptr, unsigned long *ret)
>  	return read_user_stack_slow(ptr, ret, 8);
>  }
> =20
> -static int read_user_stack_32(unsigned int __user *ptr, unsigned int *re=
t)
> -{
> -	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
> -	    ((unsigned long)ptr & 3))
> -		return -EFAULT;
> -
> -	if (!probe_user_read(ret, ptr, sizeof(*ret)))
> -		return 0;
> -
> -	return read_user_stack_slow(ptr, ret, 4);
> -}
> -
>  static inline int valid_user_sp(unsigned long sp, int is_64)
>  {
>  	if (!sp || (sp & 7) || sp > (is_64 ? TASK_SIZE : 0x100000000UL) - 32)
> @@ -277,19 +265,9 @@ static void perf_callchain_user_64(struct perf_callc=
hain_entry_ctx *entry,
>  }
> =20
>  #else  /* CONFIG_PPC64 */
> -/*
> - * On 32-bit we just access the address and let hash_page create a
> - * HPTE if necessary, so there is no need to fall back to reading
> - * the page tables.  Since this is called at interrupt level,
> - * do_page_fault() won't treat a DSI as a page fault.
> - */
> -static int read_user_stack_32(unsigned int __user *ptr, unsigned int *re=
t)
> +static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
>  {
> -	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
> -	    ((unsigned long)ptr & 3))
> -		return -EFAULT;
> -
> -	return probe_user_read(ret, ptr, sizeof(*ret));
> +	return 0;
>  }
> =20
>  static inline void perf_callchain_user_64(struct perf_callchain_entry_ct=
x *entry,
> @@ -312,6 +290,28 @@ static inline int valid_user_sp(unsigned long sp, in=
t is_64)
> =20
>  #endif /* CONFIG_PPC64 */
> =20
> +/*
> + * On 32-bit we just access the address and let hash_page create a
> + * HPTE if necessary, so there is no need to fall back to reading
> + * the page tables.  Since this is called at interrupt level,
> + * do_page_fault() won't treat a DSI as a page fault.
> + */

The comment is actually probably better to stay in the 32-bit
read_user_stack_slow implementation. Is that function defined
on 32-bit purely so that you can use IS_ENABLED()? In that case
I would prefer to put a BUG() there which makes it self documenting.

Thanks,
Nick

> +static int read_user_stack_32(unsigned int __user *ptr, unsigned int *re=
t)
> +{
> +	int rc;
> +
> +	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
> +	    ((unsigned long)ptr & 3))
> +		return -EFAULT;
> +
> +	rc =3D probe_user_read(ret, ptr, sizeof(*ret));
> +
> +	if (IS_ENABLED(CONFIG_PPC64) && rc)
> +		return read_user_stack_slow(ptr, ret, 4);
> +
> +	return rc;
> +}
> +
>  /*
>   * Layout for non-RT signal frames
>   */
> --=20
> 2.23.0
>=20
>=20
=
