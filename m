Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 732C519D5C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 13:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403794AbgDCL0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 07:26:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34407 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403790AbgDCL0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:26:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id v23so446269pfm.1;
        Fri, 03 Apr 2020 04:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=8EqiMbUsXYeG9yH6GqFnb0WQImnRkyrpeOIRXy5bX+0=;
        b=n/ujB5GbtIIpbt3JflYJx+9+oBcaF5c6KIp2t3My3cerGsvea2wlvqx4T4GBWLZn/x
         6c4lG13Ay3ceCx/YTEaoXxuHxXNcK3MkLBtPiNn9JAx78bp7rqI0tzqzT6Zc5nVkHC2M
         QFPDCR6rLgWcaDD4LN9c47ZwPY9mNb59XBqU0e1thgST/aP8zvsIGehqq4yfOWwOX25a
         WVyQjpuSgxtxnwWmR0sfV3n9aKR89qu3utHcN/lZhR7zD4ttXeh2safDhzIulTBaYrwH
         kDsfUCYO33j0J2Ldrai+o1EWiBca4nyZ6Jw4E2VczAEwIopatLexrwJnUuqK590fw7Hz
         /D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=8EqiMbUsXYeG9yH6GqFnb0WQImnRkyrpeOIRXy5bX+0=;
        b=hTYPwhirFzp+3MoRbgMA4E6nQoHZ1DRYZsUvozfLIJanteZIKemYZlqMVv2Rh55heG
         3vTKFqLNEaPMHS6rE3Qayd/288NO/FjYaUMs6w6vpcnBKtmKOMIZ2uh0D3vvzaaeY7+b
         KvAWOyD2ZuCwLAnFj5w3dy4JrPbqf45k9Rm0OiiS8XdhYl5nFQ6oSYAKEyo/tTxDpnPz
         Gh59HpcO8c/axFoQDVrUzDA/phbO5MDp98PxgFPZfj7Mv/ulMUdvls16NZplx9cZBZPm
         bdR5ba042BpJ9fwTmOQm9D1a1qo3Y5GOLP9gHz1GISrUkndSavqqb/cqp0kgW6mCe2B1
         ELmQ==
X-Gm-Message-State: AGi0PuadLjlE7sVIgiFSy7va/uEhyklfOCzOjXTF1g6Z95ponpE9EyLE
        EKjzGn8hpJpe68UhRSxE4Y4=
X-Google-Smtp-Source: APiQypJryYVP2bJFCWAGJyeYt8G4pH3FAscyrWs2nsOaa4xu2QlJUUTufWC94u9Pc9SLLWFpwhphyg==
X-Received: by 2002:a63:5fd8:: with SMTP id t207mr7477349pgb.186.1585913199745;
        Fri, 03 Apr 2020 04:26:39 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
        by smtp.gmail.com with ESMTPSA id l5sm5173615pgt.10.2020.04.03.04.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 04:26:39 -0700 (PDT)
Date:   Fri, 03 Apr 2020 21:26:27 +1000
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
        <1585896170.ohti800w9v.astroid@bobo.none>
        <20200403105234.GX25468@kitsune.suse.cz>
In-Reply-To: <20200403105234.GX25468@kitsune.suse.cz>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1585913065.zoacp2kzsv.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michal Such=C3=A1nek's on April 3, 2020 8:52 pm:
> Hello,
>=20
> there are 3 variants of the function
>=20
> read_user_stack_64
>=20
> 32bit read_user_stack_32
> 64bit read_user_Stack_32

Right.

> On Fri, Apr 03, 2020 at 05:13:25PM +1000, Nicholas Piggin wrote:
[...]
>>  #endif /* CONFIG_PPC64 */
>> =20
>> +static int read_user_stack_32(unsigned int __user *ptr, unsigned int *r=
et)
>> +{
>> +	return __read_user_stack(ptr, ret, sizeof(*ret));
> Does not work for 64bit read_user_stack_32 ^ this should be 4.
>=20
> Other than that it should preserve the existing logic just fine.

sizeof(int) =3D=3D 4 on 64bit so it should work.

Thanks,
Nick
=
