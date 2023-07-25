Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153EE761BCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 16:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjGYOcJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 10:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjGYOcI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:32:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E926212A
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 07:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=V4bk2VLThmhiGf/np0YjK8qbCseKe119AZNKpP8acYg=; b=VTI0OhylsQTxXMA/RSk9xXGTtJ
        HQhelkeNA2AgiHFa2Qq6TzffrLJJxOa0YWQmoJTEl63npJJvULOH5ed3k/yewLseqnQ89yz4JTOvX
        CIp3Arkoji/Q0K6zCngLgIjwUbnhUrnYYsWTGwInvLH9KvpBGIiNR4yD/Ar42BibptGrY7NZyLg0f
        ODF3A8Ep5esjcoMn/xr5imfQTBfCvZhPoVOwUbQ0PC+PN+OQ22ytOzTzkwlcaQY2SjbH0gisuuHiB
        Ra+pT9oIdmvFBrKJvOBrlqwnj1qvKpUGjE/vO+ewXnAOxHs6eLlbE6vwAj5pHo0VpudxLXFCUpUA2
        x5IPw1Gg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOJ4H-005YH3-6X; Tue, 25 Jul 2023 14:31:17 +0000
Date:   Tue, 25 Jul 2023 15:31:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v3 02/10] mm: Allow per-VMA locks on file-backed VMAs
Message-ID: <ZL/ctWq9Td8i7Qba@casper.infradead.org>
References: <20230724185410.1124082-1-willy@infradead.org>
 <20230724185410.1124082-3-willy@infradead.org>
 <20230725-anaconda-that-ac3f79880af1@wendy>
 <CAJuCfpEUn=pycn-69-zUGbF-Exb2M1kDrsMPmA-BtAUkH2dKjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEUn=pycn-69-zUGbF-Exb2M1kDrsMPmA-BtAUkH2dKjQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 07:15:08AM -0700, Suren Baghdasaryan wrote:
> On Tue, Jul 25, 2023 at 5:58 AM Conor Dooley <conor.dooley@microchip.com> wrote:
> >
> > Hey,
> >
> > On Mon, Jul 24, 2023 at 07:54:02PM +0100, Matthew Wilcox (Oracle) wrote:
> > > Remove the TCP layering violation by allowing per-VMA locks on all VMAs.
> > > The fault path will immediately fail in handle_mm_fault().  There may be
> > > a small performance reduction from this patch as a little unnecessary work
> > > will be done on each page fault.  See later patches for the improvement.
> > >
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Arjun Roy <arjunroy@google.com>
> > > Cc: Eric Dumazet <edumazet@google.com>
> >
> > Unless my bisection has gone awry, this is causing boot failures for me
> > in today's linux-next w/ a splat like so.
> 
> This patch requires [1] to work correctly. It follows the rule
> introduced in [1] that anyone returning VM_FAULT_RETRY should also do
> vma_end_read(). [1] is merged into mm-unstable but has not reached
> linux-next yet, it seems.

No, it's in linux-next, but you didn't fix riscv ...

Andrew, can you add this fix to Suren's patch?
"mm: drop per-VMA lock when returning VM_FAULT_RETRY or VM_FAULT_COMPLETED"

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 046732fcb48c..6115d7514972 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -296,7 +296,8 @@ void handle_page_fault(struct pt_regs *regs)
 	}
 
 	fault = handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK, regs);
-	vma_end_read(vma);
+	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+		vma_end_read(vma);
 
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
