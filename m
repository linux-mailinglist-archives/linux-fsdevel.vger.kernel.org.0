Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0282419D0D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 09:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388623AbgDCHNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 03:13:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33648 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbgDCHNe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:13:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id c138so3079724pfc.0;
        Fri, 03 Apr 2020 00:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=PomIT0vOJJubjpTKtqaxIW1z5qgbZ78B+V6vQRPg/ek=;
        b=jGFTK8c3nbtmc18VUKXManK/oeSzFTQrHkvganlOLxTtRzpx9LhO2LBruyVYpPw9kB
         SfjhioMy6EVnX/WHKQyoiykAsSPtiZRSSrXAOb94c0+J0T3H9X3PY7NJltUaEw5VR0u/
         xTG0T+Tf2NHx72Skalb9+xyiOsyohvmCgNfH1nCSZMHVDaq0Xu6ACkYxrKX3zmin1t1N
         4dWeoto0wgpZ5imi64wBqVy0pIABjiOVcNvJgjri+2ew4tqkH2iAzS2C7hPaUeEJrjX5
         /JbitfrbVqWzHZ9uz+JdJchhhcQCkpQ7L5TTVDuse0XFI2IeaZRlef6ij/SnkCuKy5z0
         1r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=PomIT0vOJJubjpTKtqaxIW1z5qgbZ78B+V6vQRPg/ek=;
        b=H1grLKCecsLAgCkDpr9gFKbP3WOBiCNnt/ahoiOqwRwxHtU3ah81kt0b23JQXQeed0
         K4xxVrMEyoystrGxUiRX6UuHCqFz6Hio4+lsrwl+hNQBmJVDRhhzxY3j4ueOG/TheURJ
         XXxJ8OhUi7Y6VMocfWAnO4cysU6Tpvkf87TpEtsPfags1AI23Zzrvss72kqgKfSOgDZ9
         MyNIGiH50HDIRvRzl43Nv27HiUxqlNVUPsFnjBls86hagkSes6P4WNaXUsiWofCRdnL4
         j6j7i9sVdnC+g+ltM15RbwpIxZuE3Wi2kV3WPITmIuABUlsyNeZKTYs/IAFmOC5cbc8a
         9OOQ==
X-Gm-Message-State: AGi0PuYUy5fP37Oxd2WRGBwDOB4P32Nz/NeHPiadYLt0vQu+AxQE58Pn
        kiZAyxnaMlMq0JW0xuPJS+/xOdNe
X-Google-Smtp-Source: APiQypIJqE4VJKubu8R9yMCR6k5nV3HrHF8fEz8TuqPWJDQVNhkIq3UVFUy/DNAWzk5PVXK4EfFEKg==
X-Received: by 2002:aa7:9f42:: with SMTP id h2mr6731404pfr.22.1585898012953;
        Fri, 03 Apr 2020 00:13:32 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
        by smtp.gmail.com with ESMTPSA id t66sm5054577pjb.45.2020.04.03.00.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 00:13:31 -0700 (PDT)
Date:   Fri, 03 Apr 2020 17:13:25 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v11 3/8] powerpc/perf: consolidate read_user_stack_32
To:     Michal =?iso-8859-1?q?Such=E1nek?= <msuchanek@suse.de>
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
        linuxppc-dev@lists.ozlabs.org, Mark Rutland <mark.rutland@arm.com>,
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
        <1585039473.da4762n2s0.astroid@bobo.none>
        <20200324193833.GH25468@kitsune.suse.cz>
In-Reply-To: <20200324193833.GH25468@kitsune.suse.cz>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1585896170.ohti800w9v.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michal Such=C3=A1nek's on March 25, 2020 5:38 am:
> On Tue, Mar 24, 2020 at 06:48:20PM +1000, Nicholas Piggin wrote:
>> Michal Suchanek's on March 19, 2020 10:19 pm:
>> > There are two almost identical copies for 32bit and 64bit.
>> >=20
>> > The function is used only in 32bit code which will be split out in nex=
t
>> > patch so consolidate to one function.
>> >=20
>> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>> > Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> > ---
>> > v6:  new patch
>> > v8:  move the consolidated function out of the ifdef block.
>> > v11: rebase on top of def0bfdbd603
>> > ---
>> >  arch/powerpc/perf/callchain.c | 48 +++++++++++++++++-----------------=
-
>> >  1 file changed, 24 insertions(+), 24 deletions(-)
>> >=20
>> > diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callcha=
in.c
>> > index cbc251981209..c9a78c6e4361 100644
>> > --- a/arch/powerpc/perf/callchain.c
>> > +++ b/arch/powerpc/perf/callchain.c
>> > @@ -161,18 +161,6 @@ static int read_user_stack_64(unsigned long __use=
r *ptr, unsigned long *ret)
>> >  	return read_user_stack_slow(ptr, ret, 8);
>> >  }
>> > =20
>> > -static int read_user_stack_32(unsigned int __user *ptr, unsigned int =
*ret)
>> > -{
>> > -	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
>> > -	    ((unsigned long)ptr & 3))
>> > -		return -EFAULT;
>> > -
>> > -	if (!probe_user_read(ret, ptr, sizeof(*ret)))
>> > -		return 0;
>> > -
>> > -	return read_user_stack_slow(ptr, ret, 4);
>> > -}
>> > -
>> >  static inline int valid_user_sp(unsigned long sp, int is_64)
>> >  {
>> >  	if (!sp || (sp & 7) || sp > (is_64 ? TASK_SIZE : 0x100000000UL) - 32=
)
>> > @@ -277,19 +265,9 @@ static void perf_callchain_user_64(struct perf_ca=
llchain_entry_ctx *entry,
>> >  }
>> > =20
>> >  #else  /* CONFIG_PPC64 */
>> > -/*
>> > - * On 32-bit we just access the address and let hash_page create a
>> > - * HPTE if necessary, so there is no need to fall back to reading
>> > - * the page tables.  Since this is called at interrupt level,
>> > - * do_page_fault() won't treat a DSI as a page fault.
>> > - */
>> > -static int read_user_stack_32(unsigned int __user *ptr, unsigned int =
*ret)
>> > +static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
>> >  {
>> > -	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
>> > -	    ((unsigned long)ptr & 3))
>> > -		return -EFAULT;
>> > -
>> > -	return probe_user_read(ret, ptr, sizeof(*ret));
>> > +	return 0;
>> >  }
>> > =20
>> >  static inline void perf_callchain_user_64(struct perf_callchain_entry=
_ctx *entry,
>> > @@ -312,6 +290,28 @@ static inline int valid_user_sp(unsigned long sp,=
 int is_64)
>> > =20
>> >  #endif /* CONFIG_PPC64 */
>> > =20
>> > +/*
>> > + * On 32-bit we just access the address and let hash_page create a
>> > + * HPTE if necessary, so there is no need to fall back to reading
>> > + * the page tables.  Since this is called at interrupt level,
>> > + * do_page_fault() won't treat a DSI as a page fault.
>> > + */
>>=20
>> The comment is actually probably better to stay in the 32-bit
>> read_user_stack_slow implementation. Is that function defined
>> on 32-bit purely so that you can use IS_ENABLED()? In that case
> It documents the IS_ENABLED() and that's where it is. The 32bit
> definition is only a technical detail.

Sorry for the late reply, busy trying to fix bugs in the C rewrite
series. I don't think it is the right place, it should be in the
ppc32 implementation detail. ppc64 has an equivalent comment at the
top of its read_user_stack functions.

>> I would prefer to put a BUG() there which makes it self documenting.
> Which will cause checkpatch complaints about introducing new BUG() which
> is frowned on.

It's fine in this case, that warning is about not introducing
runtime bugs, but this wouldn't be.

But... I actually don't like adding read_user_stack_slow on 32-bit
and especially not just to make IS_ENABLED work.

IMO this would be better if you really want to consolidate it

---

diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index cbc251981209..ca3a599b3f54 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -108,7 +108,7 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *=
entry, struct pt_regs *re
  * interrupt context, so if the access faults, we read the page tables
  * to find which page (if any) is mapped and access it directly.
  */
-static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
+static int read_user_stack_slow(const void __user *ptr, void *buf, int nb)
 {
 	int ret =3D -EFAULT;
 	pgd_t *pgdir;
@@ -149,28 +149,21 @@ static int read_user_stack_slow(void __user *ptr, voi=
d *buf, int nb)
 	return ret;
 }
=20
-static int read_user_stack_64(unsigned long __user *ptr, unsigned long *re=
t)
+static int __read_user_stack(const void __user *ptr, void *ret, size_t siz=
e)
 {
-	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned long) ||
-	    ((unsigned long)ptr & 7))
+	if ((unsigned long)ptr > TASK_SIZE - size ||
+	    ((unsigned long)ptr & (size - 1)))
 		return -EFAULT;
=20
-	if (!probe_user_read(ret, ptr, sizeof(*ret)))
+	if (!probe_user_read(ret, ptr, size))
 		return 0;
=20
-	return read_user_stack_slow(ptr, ret, 8);
+	return read_user_stack_slow(ptr, ret, size);
 }
=20
-static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
+static int read_user_stack_64(unsigned long __user *ptr, unsigned long *re=
t)
 {
-	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
-	    ((unsigned long)ptr & 3))
-		return -EFAULT;
-
-	if (!probe_user_read(ret, ptr, sizeof(*ret)))
-		return 0;
-
-	return read_user_stack_slow(ptr, ret, 4);
+	return __read_user_stack(ptr, ret, sizeof(*ret));
 }
=20
 static inline int valid_user_sp(unsigned long sp, int is_64)
@@ -283,13 +276,13 @@ static void perf_callchain_user_64(struct perf_callch=
ain_entry_ctx *entry,
  * the page tables.  Since this is called at interrupt level,
  * do_page_fault() won't treat a DSI as a page fault.
  */
-static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
+static int __read_user_stack(const void __user *ptr, void *ret, size_t siz=
e)
 {
-	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
-	    ((unsigned long)ptr & 3))
+	if ((unsigned long)ptr > TASK_SIZE - size ||
+	    ((unsigned long)ptr & (size - 1)))
 		return -EFAULT;
=20
-	return probe_user_read(ret, ptr, sizeof(*ret));
+	return probe_user_read(ret, ptr, size);
 }
=20
 static inline void perf_callchain_user_64(struct perf_callchain_entry_ctx =
*entry,
@@ -312,6 +305,11 @@ static inline int valid_user_sp(unsigned long sp, int =
is_64)
=20
 #endif /* CONFIG_PPC64 */
=20
+static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
+{
+	return __read_user_stack(ptr, ret, sizeof(*ret));
+}
+
 /*
  * Layout for non-RT signal frames
  */
=
