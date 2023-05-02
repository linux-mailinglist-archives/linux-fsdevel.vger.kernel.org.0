Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D236F461C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 16:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjEBO3a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 10:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjEBO3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 10:29:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48C9186;
        Tue,  2 May 2023 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ELVVbw+54Ch0+43hfmruTFJjfFtCPHuCtqF3FOZLWUg=; b=g6eJOOGyCZpxMJcZ9yJoCd1AkW
        2IkBBSA32Oo0CTWn86cEPm2abQyr6zxmX9+QTElcddtTBR4RaOC61lOPB28TuaREMOa2wYLayK/xV
        FoVhwKpwjOt7jF3g1kfQywXcqG3cIbxnW7/lZu7EAm4agzRj/7wISg6iZqRchmiM8+9iPpWvIWcI2
        2O5CaiAcYoNk/NY7VB63QeNbmTStykUos/zP+fBTZbzowDUWBWJBb4hbKiQnRxNiDaIZukmxjn4z3
        rBmy8mzsnFH4Wjh50AadBku1oeCN2tD/XryfULi2xIFup0LvJAgKiLPfOLsMophIqdjunqZcjC0J9
        4n8EVpyA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ptqzm-008Nj4-ED; Tue, 02 May 2023 14:28:46 +0000
Date:   Tue, 2 May 2023 15:28:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 2/3] mm: drop VMA lock before waiting for migration
Message-ID: <ZFEeHqzBJ6iOsRN+@casper.infradead.org>
References: <20230501175025.36233-1-surenb@google.com>
 <20230501175025.36233-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501175025.36233-2-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 01, 2023 at 10:50:24AM -0700, Suren Baghdasaryan wrote:
> migration_entry_wait does not need VMA lock, therefore it can be dropped
> before waiting. Introduce VM_FAULT_VMA_UNLOCKED to indicate that VMA
> lock was dropped while in handle_mm_fault().
> Note that once VMA lock is dropped, the VMA reference can't be used as
> there are no guarantees it was not freed.

How about we introduce:

void vmf_end_read(struct vm_fault *vmf)
{
	if (!vmf->vma)
		return;
	vma_end_read(vmf->vma);
	vmf->vma = NULL;
}

Now we don't need a new flag, and calling vmf_end_read() is idempotent.

Oh, argh, we create the vmf too late.  We really need to hoist the
creation of vm_fault to the callers of handle_mm_fault().

