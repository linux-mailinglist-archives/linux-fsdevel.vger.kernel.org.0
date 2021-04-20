Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F4A366192
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 23:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbhDTV1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 17:27:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36863 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbhDTV0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:26:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210420212620euoutp014b03538938661b877e764e4a3b785b00~3rhFwOMKw3001930019euoutp01E
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 21:26:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210420212620euoutp014b03538938661b877e764e4a3b785b00~3rhFwOMKw3001930019euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618953981;
        bh=Qi0gCR3/TMK3uzjKpJBzLkZ7YPXKWP1a7TKwtUHJlLY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nQFS+1Iz3J4BwjcBtPFSUN+xCeA4TO9yvQpAmaSOk5tugEeyoX7bRZqFrkcwybHUa
         q0qhFQYY4MXyBflg+CLsUDy275K3g4/zXXVws6PS87mHVymvoN53OaMGKmWLm5+Zwq
         mEMswOT24zunjZhNJBX+nL/jETUZrA1zPwypudAU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210420212619eucas1p2db02ff7f11d338e5195cc8f929298774~3rhEPp4tw0944609446eucas1p2l;
        Tue, 20 Apr 2021 21:26:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 06.6F.09444.BF64F706; Tue, 20
        Apr 2021 22:26:19 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210420212618eucas1p102b427d1af9c682217dfe093f3eac3e8~3rhDkkl-w0486904869eucas1p1u;
        Tue, 20 Apr 2021 21:26:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210420212618eusmtrp11e98a530ff03bb1715be2a8d4f20957d~3rhDjiL2E2461024610eusmtrp1e;
        Tue, 20 Apr 2021 21:26:18 +0000 (GMT)
X-AuditID: cbfec7f4-dbdff700000024e4-36-607f46fbea01
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7C.2E.08705.AF64F706; Tue, 20
        Apr 2021 22:26:18 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210420212617eusmtip14832ded4148ff65a0ef2786c68aa7cde~3rhCEaNf72499824998eusmtip1C;
        Tue, 20 Apr 2021 21:26:16 +0000 (GMT)
Subject: Re: [PATCH v4 05/10] signal: Introduce TRAP_PERF si_code and
 si_perf to siginfo
To:     Marco Elver <elver@google.com>, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de
Cc:     glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, oleg@redhat.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <1fbf3429-42e5-0959-9a5c-91de80f02b6a@samsung.com>
Date:   Tue, 20 Apr 2021 23:26:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210408103605.1676875-6-elver@google.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH+z7Ps2c/cPSABF8NoTDx8AIdRvfl7MiEs+e/Su/yTuxkwBN4
        wuA2l4VKpoJELGQdMSbCJAkOEWgDZgPil7JbyoRhwXRBIO2QA+ZiXAQuYnu0+O/1/nzfn3u/
        P3dfHu7fSm7mHZOcYKQScUYYKSDa+v82R67s/zxpV1W3Dyocu0miAm05B7mV/Vx0/bdiEv2g
        auKgL+a3oksT+VyUf1fPQfYHnRi66OzEkSbPxUUWUyS6PeDGUJ19HEMFhkUCdXSaCDRsqCBR
        mc1BopqRIQx919PNQZZuDYbOfd9KoNauPICKbSMkMiq6MaTTluLontvIQUvNjzh7g+mGygZA
        rywrAe2+4sRpjVZOd5SYSFpXt4MeHpDT2vovSXrebObSvX0FgK40fUA7fvqFpL9uqQf0gjaE
        1k7NYe+/eFjwViqTcewTRrozLkmQruh6iGUb4z61GPTEWdApKgR8HqTegOP6aa6H/ak6AC83
        rLFgjV0AVjbm4axYALB0ZInzfMNQ2shhH2oBLGnQY6xwArg69DvhcW2kDsM+86B3PYD6FcDH
        tnuER+CUHYf9eoc3kaREsHCukPSwkIqD1marlwlqG9RWF3v5JSoZWi2rOOvxg6byKW8Cn0Lw
        W+Mo8DBOhUL9XAXOchB8MFXlrQSpHwXQ0fHkWfEEuKC8+4w3whljC5flYHjnmyKCXTgP4IT5
        BpcVRQAOn1MB1rUH2szLa5V4axERsMmwkx2/A2ea1ZhnDClfODrnx5bwhcq2MpwdC2FBvj/r
        DodqY+N/sT2DFvwSCFOvO0297hz1unPU/+dqAFEPghi5LDONkUVLmJNRMnGmTC5Ji0rJytSC
        tZ995x+j6yaonXFG9QKMB3oB5OFhAcLxM6eT/IWp4s9yGGnWUak8g5H1gpd5RFiQMLml4ag/
        lSY+wRxnmGxG+vwV4/E3n8Xqc1Mrjuz+eewp/XHwpsTX/iJny065EhPDl5IUnbOnk9sn7dir
        F1X7Hmf8ka5qc3yVVTT7wpnY1OHtfrrFjsl2Ve5sTEe5LXzx2uX2rqox0xFxgsh0lScxuCzF
        TTHTr6t0u1qCRqffy7cKblXFnZzZ8jSBzFaUOIMscC+WU+NMuc0X9tx/RdKUYd+9/d3WDbH8
        ROZD65sXQns2/Dkf7auzaULuX+ghJq98JPQ5GLg8oDy/HN/sPhBxXBByCB4YynUV9pWtvB0b
        iO97cn0sNCbSLqrFdD4Ho5nAwa3g1K1q/Sa3YnV/djw/51pNXk685OGh6j1XRyJuPNpSEeCX
        MrENUWGELF0s2oFLZeJ/AcdqWatIBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsVy+t/xu7q/3OoTDE5dkLLoureDzaJj00xW
        i7+TjrFbrL7bz2axccZ6VovGd8oWEx62sVu0ndnOavHs1l4mi/aPe5ktFrR+Ybe4dFLX4ujZ
        v0wWK57dZ7Lo2PWVxWLP3pMsFpd3zWGzmH7nPZvF0usXmSwWHzzAanHpwAImi6ZlW1kstu5v
        ZbTov3OdzeJ47wEmi82bpjJbnP97nNXix4bHrA4yHmvmrWH0+P1rEqPH37kfmT0WbCr12DPx
        JJvH5hVaHpfPlnpsWtXJ5vHu3Dl2j0OHOxg95p0M9Hi/7yqbR9+WVYwenzfJeWx68pYpgD9K
        z6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL6N3/22m
        guN2FZd2bWdpYNxr2MXIySEhYCKxa+o61i5GLg4hgaWMEquOrmGBSMhInJzWwAphC0v8udbF
        BlH0nlFiw9/LzCAJYYEoiUt/34HZIgLXGCWebxUFKWIWeMYscfnGKaYuRg6gjlSJx8vKQWrY
        BAwlut6CDOLk4BWwk7i54SaYzSKgKrFpUT+YLSqQJHHv8kpmiBpBiZMzn4AdxClgITHt+A1G
        EJtZwExi3uaHzBC2vMT2t3OgbHGJW0/mM01gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz23
        2FCvODG3uDQvXS85P3cTIzA9bTv2c/MOxnmvPuodYmTiYDzEKMHBrCTCe7+2JkGINyWxsiq1
        KD++qDQntfgQoynQPxOZpUST84EJMq8k3tDMwNTQxMzSwNTSzFhJnHfr3DXxQgLpiSWp2amp
        BalFMH1MHJxSDUxzLePDlii+r7l6uFk5fEHtJJafSVkcJ84avdaQa+jVnKlg8YOr6n3Uwo13
        lZhimx7Z3O2vmGsRc7DYdprup0iDN9mqouK9H47Y3FrcuKow0PfjfJc/91qsowvmuX4QbFUw
        Yet3XjCvN2RuytLuG2+d/pporIgzYfAKu+fL/yRs5/91op+5tk41cYwLiiwrvfWi0fXPTlve
        G2LnfHYUJmw7UKhiO6mQf3HsvfCHXtseylQerdmZtqNUq3dW+brr/hz/y99KuyZ+2nNp0srl
        BsxP+N49S3kVyRlm9udBtp/9qp8S3oruU7fc0Pd8IGino7pMWNlWguXGgkOrVkznqFJ43tab
        EeiswcrymoktQImlOCPRUIu5qDgRACWct2fYAwAA
X-CMS-MailID: 20210420212618eucas1p102b427d1af9c682217dfe093f3eac3e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210420212618eucas1p102b427d1af9c682217dfe093f3eac3e8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210420212618eucas1p102b427d1af9c682217dfe093f3eac3e8
References: <20210408103605.1676875-1-elver@google.com>
        <20210408103605.1676875-6-elver@google.com>
        <CGME20210420212618eucas1p102b427d1af9c682217dfe093f3eac3e8@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Marco,

On 08.04.2021 12:36, Marco Elver wrote:
> Introduces the TRAP_PERF si_code, and associated siginfo_t field
> si_perf. These will be used by the perf event subsystem to send signals
> (if requested) to the task where an event occurred.
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
> Acked-by: Arnd Bergmann <arnd@arndb.de> # asm-generic
> Signed-off-by: Marco Elver <elver@google.com>

This patch landed in linux-next as commit fb6cc127e0b6 ("signal: 
Introduce TRAP_PERF si_code and si_perf to siginfo"). It causes 
regression on my test systems (arm 32bit and 64bit). Most systems fails 
to boot in the given time frame. I've observed that there is a timeout 
waiting for udev to populate /dev and then also during the network 
interfaces configuration. Reverting this commit, together with 
97ba62b27867 ("perf: Add support for SIGTRAP on perf events") to let it 
compile, on top of next-20210420 fixes the issue.

> ---
>   arch/m68k/kernel/signal.c          |  3 +++
>   arch/x86/kernel/signal_compat.c    |  5 ++++-
>   fs/signalfd.c                      |  4 ++++
>   include/linux/compat.h             |  2 ++
>   include/linux/signal.h             |  1 +
>   include/uapi/asm-generic/siginfo.h |  6 +++++-
>   include/uapi/linux/signalfd.h      |  4 +++-
>   kernel/signal.c                    | 11 +++++++++++
>   8 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
> index 349570f16a78..a4b7ee1df211 100644
> --- a/arch/m68k/kernel/signal.c
> +++ b/arch/m68k/kernel/signal.c
> @@ -622,6 +622,9 @@ static inline void siginfo_build_tests(void)
>   	/* _sigfault._addr_pkey */
>   	BUILD_BUG_ON(offsetof(siginfo_t, si_pkey) != 0x12);
>   
> +	/* _sigfault._perf */
> +	BUILD_BUG_ON(offsetof(siginfo_t, si_perf) != 0x10);
> +
>   	/* _sigpoll */
>   	BUILD_BUG_ON(offsetof(siginfo_t, si_band)   != 0x0c);
>   	BUILD_BUG_ON(offsetof(siginfo_t, si_fd)     != 0x10);
> diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
> index a5330ff498f0..0e5d0a7e203b 100644
> --- a/arch/x86/kernel/signal_compat.c
> +++ b/arch/x86/kernel/signal_compat.c
> @@ -29,7 +29,7 @@ static inline void signal_compat_build_tests(void)
>   	BUILD_BUG_ON(NSIGFPE  != 15);
>   	BUILD_BUG_ON(NSIGSEGV != 9);
>   	BUILD_BUG_ON(NSIGBUS  != 5);
> -	BUILD_BUG_ON(NSIGTRAP != 5);
> +	BUILD_BUG_ON(NSIGTRAP != 6);
>   	BUILD_BUG_ON(NSIGCHLD != 6);
>   	BUILD_BUG_ON(NSIGSYS  != 2);
>   
> @@ -138,6 +138,9 @@ static inline void signal_compat_build_tests(void)
>   	BUILD_BUG_ON(offsetof(siginfo_t, si_pkey) != 0x20);
>   	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_pkey) != 0x14);
>   
> +	BUILD_BUG_ON(offsetof(siginfo_t, si_perf) != 0x18);
> +	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf) != 0x10);
> +
>   	CHECK_CSI_OFFSET(_sigpoll);
>   	CHECK_CSI_SIZE  (_sigpoll, 2*sizeof(int));
>   	CHECK_SI_SIZE   (_sigpoll, 4*sizeof(int));
> diff --git a/fs/signalfd.c b/fs/signalfd.c
> index 456046e15873..040a1142915f 100644
> --- a/fs/signalfd.c
> +++ b/fs/signalfd.c
> @@ -134,6 +134,10 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
>   #endif
>   		new.ssi_addr_lsb = (short) kinfo->si_addr_lsb;
>   		break;
> +	case SIL_PERF_EVENT:
> +		new.ssi_addr = (long) kinfo->si_addr;
> +		new.ssi_perf = kinfo->si_perf;
> +		break;
>   	case SIL_CHLD:
>   		new.ssi_pid    = kinfo->si_pid;
>   		new.ssi_uid    = kinfo->si_uid;
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 6e65be753603..c8821d966812 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -236,6 +236,8 @@ typedef struct compat_siginfo {
>   					char _dummy_pkey[__COMPAT_ADDR_BND_PKEY_PAD];
>   					u32 _pkey;
>   				} _addr_pkey;
> +				/* used when si_code=TRAP_PERF */
> +				compat_u64 _perf;
>   			};
>   		} _sigfault;
>   
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index 205526c4003a..1e98548d7cf6 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -43,6 +43,7 @@ enum siginfo_layout {
>   	SIL_FAULT_MCEERR,
>   	SIL_FAULT_BNDERR,
>   	SIL_FAULT_PKUERR,
> +	SIL_PERF_EVENT,
>   	SIL_CHLD,
>   	SIL_RT,
>   	SIL_SYS,
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index d2597000407a..d0bb9125c853 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -91,6 +91,8 @@ union __sifields {
>   				char _dummy_pkey[__ADDR_BND_PKEY_PAD];
>   				__u32 _pkey;
>   			} _addr_pkey;
> +			/* used when si_code=TRAP_PERF */
> +			__u64 _perf;
>   		};
>   	} _sigfault;
>   
> @@ -155,6 +157,7 @@ typedef struct siginfo {
>   #define si_lower	_sifields._sigfault._addr_bnd._lower
>   #define si_upper	_sifields._sigfault._addr_bnd._upper
>   #define si_pkey		_sifields._sigfault._addr_pkey._pkey
> +#define si_perf		_sifields._sigfault._perf
>   #define si_band		_sifields._sigpoll._band
>   #define si_fd		_sifields._sigpoll._fd
>   #define si_call_addr	_sifields._sigsys._call_addr
> @@ -253,7 +256,8 @@ typedef struct siginfo {
>   #define TRAP_BRANCH     3	/* process taken branch trap */
>   #define TRAP_HWBKPT     4	/* hardware breakpoint/watchpoint */
>   #define TRAP_UNK	5	/* undiagnosed trap */
> -#define NSIGTRAP	5
> +#define TRAP_PERF	6	/* perf event with sigtrap=1 */
> +#define NSIGTRAP	6
>   
>   /*
>    * There is an additional set of SIGTRAP si_codes used by ptrace
> diff --git a/include/uapi/linux/signalfd.h b/include/uapi/linux/signalfd.h
> index 83429a05b698..7e333042c7e3 100644
> --- a/include/uapi/linux/signalfd.h
> +++ b/include/uapi/linux/signalfd.h
> @@ -39,6 +39,8 @@ struct signalfd_siginfo {
>   	__s32 ssi_syscall;
>   	__u64 ssi_call_addr;
>   	__u32 ssi_arch;
> +	__u32 __pad3;
> +	__u64 ssi_perf;
>   
>   	/*
>   	 * Pad strcture to 128 bytes. Remember to update the
> @@ -49,7 +51,7 @@ struct signalfd_siginfo {
>   	 * comes out of a read(2) and we really don't want to have
>   	 * a compat on read(2).
>   	 */
> -	__u8 __pad[28];
> +	__u8 __pad[16];
>   };
>   
>   
> diff --git a/kernel/signal.c b/kernel/signal.c
> index f2718350bf4b..7061e4957650 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1199,6 +1199,7 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
>   	case SIL_FAULT_MCEERR:
>   	case SIL_FAULT_BNDERR:
>   	case SIL_FAULT_PKUERR:
> +	case SIL_PERF_EVENT:
>   	case SIL_SYS:
>   		ret = false;
>   		break;
> @@ -2531,6 +2532,7 @@ static void hide_si_addr_tag_bits(struct ksignal *ksig)
>   	case SIL_FAULT_MCEERR:
>   	case SIL_FAULT_BNDERR:
>   	case SIL_FAULT_PKUERR:
> +	case SIL_PERF_EVENT:
>   		ksig->info.si_addr = arch_untagged_si_addr(
>   			ksig->info.si_addr, ksig->sig, ksig->info.si_code);
>   		break;
> @@ -3341,6 +3343,10 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
>   #endif
>   		to->si_pkey = from->si_pkey;
>   		break;
> +	case SIL_PERF_EVENT:
> +		to->si_addr = ptr_to_compat(from->si_addr);
> +		to->si_perf = from->si_perf;
> +		break;
>   	case SIL_CHLD:
>   		to->si_pid = from->si_pid;
>   		to->si_uid = from->si_uid;
> @@ -3421,6 +3427,10 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
>   #endif
>   		to->si_pkey = from->si_pkey;
>   		break;
> +	case SIL_PERF_EVENT:
> +		to->si_addr = compat_ptr(from->si_addr);
> +		to->si_perf = from->si_perf;
> +		break;
>   	case SIL_CHLD:
>   		to->si_pid    = from->si_pid;
>   		to->si_uid    = from->si_uid;
> @@ -4601,6 +4611,7 @@ static inline void siginfo_buildtime_checks(void)
>   	CHECK_OFFSET(si_lower);
>   	CHECK_OFFSET(si_upper);
>   	CHECK_OFFSET(si_pkey);
> +	CHECK_OFFSET(si_perf);
>   
>   	/* sigpoll */
>   	CHECK_OFFSET(si_band);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

