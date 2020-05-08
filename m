Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458EB1CB5F0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 19:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgEHR22 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 13:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgEHR22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 13:28:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8CBC061A0C;
        Fri,  8 May 2020 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=g4OHAWvJdqq6ZyHT3haATGWFoBehw1iX6Se1BPujZ5g=; b=X3fKeXz0aEWgnYZ/Wm4BaBo1tL
        moKbBLt4taCmsmtYyM2Yx6r+CjDsEWHxqyqVpRKoS5tKH/n/krHkdYmb2H1pnfFS6y4W64zDg/bBK
        rrndiu9vYtN7Vm4wsGustbbx77srZUdf41YupjbgdP3P4GNE8woSDcJzU2TE1KyHnPy8I4sVyHrk9
        aZp2bg4CmY/ibFRkPoTOELO0MD1sp3SR7vq2xUXk7d7l1PfcpyVv6Zt+jy4G4Y7ndD7mwCMp6ohUh
        qdC2jo5Mzvnb84/90rUiS0cD4JnrjJPhKyup2/69WOMWtTRlSlMI40IkOBi7YDEemoeBhDcCLJwEY
        LXL5bvFw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX6nN-0002cH-NI; Fri, 08 May 2020 17:28:21 +0000
Subject: Re: mmotm 2020-05-05-15-28 uploaded (objtool warning)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Josh Poimboeuf <jpoimboe@redhat.com>
References: <20200505222922.jajHT3b4j%akpm@linux-foundation.org>
 <36dc367a-f647-4ee8-a327-d1c3457a7940@infradead.org>
 <20200508103830.GZ5298@hirez.programming.kicks-ass.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <73dd7a8c-87a4-695d-6f3b-ddde337c0747@infradead.org>
Date:   Fri, 8 May 2020 10:28:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508103830.GZ5298@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/8/20 3:38 AM, Peter Zijlstra wrote:
> On Tue, May 05, 2020 at 10:40:43PM -0700, Randy Dunlap wrote:
>> On 5/5/20 3:29 PM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2020-05-05-15-28 has been uploaded to
>>>
>>>    http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> mmotm-readme.txt says
>>>
>>> README for mm-of-the-moment:
>>>
>>> http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>>
>>
>>
>> on x86_64:
>>
>> arch/x86/hyperv/hv_apic.o: warning: objtool: hv_apic_write()+0x25: alternative modifies stack
> 
> Wheee... this seems to have cured it for me.
> 
> ---
> Subject: objtool: Allow no-op CFI ops in alternatives
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri May 8 12:34:33 CEST 2020
> 
> Randy reported a false-positive: "alternative modifies stack".
> 
> What happens is that:
> 
> 	alternative_io("movl %0, %P1", "xchgl %0, %P1", X86_BUG_11AP,
>  13d:   89 9d 00 d0 7f ff       mov    %ebx,-0x803000(%rbp)
> 
> decodes to an instruction with CFI-ops because it modifies RBP.
> However, due to this being a !frame-pointer build, that should not in
> fact change the CFI state.
> 
> So instead of dis-allowing any CFI-op, verify the op would've actually
> changed the CFI state.
> 
> Fixes: 7117f16bf460 ("objtool: Fix ORC vs alternatives")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  tools/objtool/check.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2078,17 +2078,18 @@ static int handle_insn_ops(struct instru
>  	struct stack_op *op;
>  
>  	list_for_each_entry(op, &insn->stack_ops, list) {
> +		struct cfi_state old_cfi = state->cfi;
>  		int res;
>  
> -		if (insn->alt_group) {
> -			WARN_FUNC("alternative modifies stack", insn->sec, insn->offset);
> -			return -1;
> -		}
> -
>  		res = update_cfi_state(insn, &state->cfi, op);
>  		if (res)
>  			return res;
>  
> +		if (insn->alt_group && memcmp(&state->cfi, &old_cfi, sizeof(struct cfi_state))) {
> +			WARN_FUNC("alternative modifies stack", insn->sec, insn->offset);
> +			return -1;
> +		}
> +
>  		if (op->dest.type == OP_DEST_PUSHF) {
>  			if (!state->uaccess_stack) {
>  				state->uaccess_stack = 1;
> 


-- 
~Randy
