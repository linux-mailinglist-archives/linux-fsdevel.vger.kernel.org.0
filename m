Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A8175628A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 14:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjGQMMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 08:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQMMj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:12:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7E7D8;
        Mon, 17 Jul 2023 05:12:34 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4LV44VTRz6823d;
        Mon, 17 Jul 2023 20:09:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 17 Jul
 2023 13:12:30 +0100
Date:   Mon, 17 Jul 2023 13:12:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Oleg Nesterov" <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Kees Cook" <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <kvmarm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 17/35] arm64/traps: Handle GCS exceptions
Message-ID: <20230717131230.00003569@Huawei.com>
In-Reply-To: <20230716-arm64-gcs-v1-17-bf567f93bba6@kernel.org>
References: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
        <20230716-arm64-gcs-v1-17-bf567f93bba6@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 16 Jul 2023 22:51:13 +0100
Mark Brown <broonie@kernel.org> wrote:

> A new exception code is defined for GCS specific faults other than
> standard load/store faults, for example GCS token validation failures,
> add handling for this. These faults are reported to userspace as
> segfaults with code SEGV_CPERR (protection error), mirroring the
> reporting for x86 shadow stack errors.
> 
> GCS faults due to memory load/store operations generate data aborts with
> a flag set, these will be handled separately as part of the data abort
> handling.
> 
> Since we do not currently enable GCS for EL1 we should not get any faults
> there but while we're at it we wire things up there, treating any GCS
> fault as fatal.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

See below.

> ---
>  arch/arm64/include/asm/esr.h       | 26 +++++++++++++++++++++++++-
>  arch/arm64/include/asm/exception.h |  2 ++
>  arch/arm64/kernel/entry-common.c   | 23 +++++++++++++++++++++++
>  arch/arm64/kernel/traps.c          | 11 +++++++++++
>  4 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index ae35939f395b..c5a72172fcf1 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
...

> @@ -382,6 +383,29 @@
>  #define ESR_ELx_MOPS_ISS_SRCREG(esr)	(((esr) & (UL(0x1f) << 5)) >> 5)
>  #define ESR_ELx_MOPS_ISS_SIZEREG(esr)	(((esr) & (UL(0x1f) << 0)) >> 0)
>  
> +/* ISS field definitions for GCS */
> +#define ESR_ELx_ExType_SHIFT	(20)
> +#define ESR_ELx_ExType_MASK	GENMASK(23, 20)
> +#define ESR_ELx_Raddr_SHIFT	(14)

(10) ?

> +#define ESR_ELx_Raddr_MASK	GENMASK(14, 10)
> +#define ESR_ELx_Rn_SHIFT	(5)
> +#define ESR_ELx_Rn_MASK		GENMASK(9, 5)

I think this can also be ESR_ELx_RVALUE_MASK for some ExType
Worth adding that as well?

> +#define ESR_ELx_IT_SHIFT	(0)
> +#define ESR_ELx_IT_MASK		GENMASK(4, 0)
> +
> +#define ESR_ELx_ExType_DATA_CHECK	0
> +#define ESR_ELx_ExType_EXLOCK		1
> +#define ESR_ELx_ExType_STR		2
> +
> +#define ESR_ELx_IT_RET			0
> +#define ESR_ELx_IT_GCSPOPM		1
> +#define ESR_ELx_IT_RET_KEYA		2
> +#define ESR_ELx_IT_RET_KEYB		3
> +#define ESR_ELx_IT_GCSSS1		4
> +#define ESR_ELx_IT_GCSSS2		5
> +#define ESR_ELx_IT_GCSPOPCX		6
> +#define ESR_ELx_IT_GCSPOPX		7
