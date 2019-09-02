Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE975A4E0F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 06:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfIBEBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 00:01:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57833 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfIBEBV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 00:01:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46MGbf204Zz9sDQ;
        Mon,  2 Sep 2019 14:01:18 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Breno Leitao <leitao@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Diana Craciun <diana.craciun@nxp.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Hildenbrand <david@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 3/6] powerpc/perf: consolidate read_user_stack_32
In-Reply-To: <87a7bntkum.fsf@mpe.ellerman.id.au>
References: <cover.1567198491.git.msuchanek@suse.de> <ea3783a1640b707ef9ce4740562850ef1152829b.1567198491.git.msuchanek@suse.de> <87a7bntkum.fsf@mpe.ellerman.id.au>
Date:   Mon, 02 Sep 2019 14:01:17 +1000
Message-ID: <877e6rtkhe.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> Michal Suchanek <msuchanek@suse.de> writes:
...
>> @@ -295,6 +279,12 @@ static inline int current_is_64bit(void)
>>  }
>>  
>>  #else  /* CONFIG_PPC64 */
>> +static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
>> +{
>> +	return 0;
>> +}
>> +#endif /* CONFIG_PPC64 */
>
> Ending the PPC64 else case here, and then restarting it below with an
> ifndef means we end up with two parts of the file that define 32-bit
> code, with a common chunk in the middle, which I dislike.
>
> I'd rather you add the empty read_user_stack_slow() in the existing
> #else section and then move read_user_stack_32() below the whole ifdef
> PPC64/else/endif section.
>
> Is there some reason that doesn't work?

Gah, I missed that you split the whole file later in the series. Any
reason you did it in two steps rather than moving patch 6 earlier in the
series?

cheers
