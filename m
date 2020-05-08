Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808531CA874
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 12:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgEHKii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 06:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725825AbgEHKii (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 06:38:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EDBC05BD43;
        Fri,  8 May 2020 03:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oXjqqQJLus+/+zgHpN+/AuMXduVDDwIK2LOdHmK15tc=; b=hqBpaCsScr1CBw9qTMDCEPKHYk
        Vzdocnr2sYswbK6FaReKGV273kCCaSBnYJ+goewpl5f86l5zKc3ELxwcXXHOcPXNT+1IhWLMOQAan
        3Fyzbz0rOBuZ4FhxMAwZxDJu5NQ0iAOouBLlfBAzuPPZL72A6YsAsbo9jK8anny1OlP3rvUR3U8SO
        JZujHiFU4Q/zpdBS2xlIGP7QT4Jw65SrcKR7+LBeAB65219EQGZSnNx9r4BPyKPhutUkjbHrr8oTR
        EwyIim5iqIrhMYjNXHeGlpqnQ85coMC7RIundnsYavLbxvmRURsitC4WOX+lwFcELfo1VaGEg2A1v
        vJhfma6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX0On-00020w-8t; Fri, 08 May 2020 10:38:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D77F43010C8;
        Fri,  8 May 2020 12:38:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D361201C228D; Fri,  8 May 2020 12:38:30 +0200 (CEST)
Date:   Fri, 8 May 2020 12:38:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: mmotm 2020-05-05-15-28 uploaded (objtool warning)
Message-ID: <20200508103830.GZ5298@hirez.programming.kicks-ass.net>
References: <20200505222922.jajHT3b4j%akpm@linux-foundation.org>
 <36dc367a-f647-4ee8-a327-d1c3457a7940@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36dc367a-f647-4ee8-a327-d1c3457a7940@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 10:40:43PM -0700, Randy Dunlap wrote:
> On 5/5/20 3:29 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-05-05-15-28 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> 
> 
> on x86_64:
> 
> arch/x86/hyperv/hv_apic.o: warning: objtool: hv_apic_write()+0x25: alternative modifies stack

Wheee... this seems to have cured it for me.

---
Subject: objtool: Allow no-op CFI ops in alternatives
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri May 8 12:34:33 CEST 2020

Randy reported a false-positive: "alternative modifies stack".

What happens is that:

	alternative_io("movl %0, %P1", "xchgl %0, %P1", X86_BUG_11AP,
 13d:   89 9d 00 d0 7f ff       mov    %ebx,-0x803000(%rbp)

decodes to an instruction with CFI-ops because it modifies RBP.
However, due to this being a !frame-pointer build, that should not in
fact change the CFI state.

So instead of dis-allowing any CFI-op, verify the op would've actually
changed the CFI state.

Fixes: 7117f16bf460 ("objtool: Fix ORC vs alternatives")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2078,17 +2078,18 @@ static int handle_insn_ops(struct instru
 	struct stack_op *op;
 
 	list_for_each_entry(op, &insn->stack_ops, list) {
+		struct cfi_state old_cfi = state->cfi;
 		int res;
 
-		if (insn->alt_group) {
-			WARN_FUNC("alternative modifies stack", insn->sec, insn->offset);
-			return -1;
-		}
-
 		res = update_cfi_state(insn, &state->cfi, op);
 		if (res)
 			return res;
 
+		if (insn->alt_group && memcmp(&state->cfi, &old_cfi, sizeof(struct cfi_state))) {
+			WARN_FUNC("alternative modifies stack", insn->sec, insn->offset);
+			return -1;
+		}
+
 		if (op->dest.type == OP_DEST_PUSHF) {
 			if (!state->uaccess_stack) {
 				state->uaccess_stack = 1;
