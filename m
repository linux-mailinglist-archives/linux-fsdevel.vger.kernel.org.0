Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A114E3B25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 09:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiCVIuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 04:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiCVIuW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:50:22 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC226E542
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 01:48:55 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id v130so32354127ybe.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 01:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QUKbEll3B3MyYDyon4P+rDcqkN3F18MECGrGkqKUuno=;
        b=rm2us6OKRLqK7uRSyjF58yCfkJFOuUQJ9OiT0aRPlGY+hdgxdLxevBebqmkYxi7Kvp
         dYYnA0yznikOIfcp94kmvCoHwd3eBaIBjlxJ5Ao8gBTwrcNcKI6+UrEemVYlvx+6/UVx
         xQVQLCPAuf2wJfSSvaL+r0brkUh5rLAurDIX9UxgFBAzX35pIb/O7NdcUgsovcWiJygc
         +F4Hmk9ymVELB1ruVF0OKDyHW3I9h6mok5rpFm1I/Rmx2oeIeTvKOXwH/USeLye/E6CX
         mVxSVtQpis0R05ccolu21RU+dA8oYht1hQDmNtryYzocmi033mHBJGcf8CtqqD9ukgUX
         BV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QUKbEll3B3MyYDyon4P+rDcqkN3F18MECGrGkqKUuno=;
        b=d62kzNfldldsngNWoyKXQJmF44El4yZUStkcDXs8OVDBKbthCQe6ACXrEdW1jSBbwo
         aTZ0jXgGhyrQIjsXkgeFpkUvuKiNQ1AGiygoiYjj1sIa4I4XbVgU+t/YVn3LzPxMfTiJ
         GERBQLuBQPai8cg+2sFshlDKmzpsWL7IoY6uPinmfTR3kJ6xmu1tiHWczfX0dsEd0MNX
         DS+dfl14ye5a+HmAiLo7z7uFxEnDyphTbxTKGM7IEeZ/r93HDKqL0PNeAT+t6l4BnwwY
         ZOiyQDRvqW9+6DyD+En0H0VbLvtcUEAzWWHTjCN8MRQEoaSA+7fib3sEY8VkwJr0VaQ1
         vDww==
X-Gm-Message-State: AOAM531ydPKpS0PQulitNQ/pdHNpVf2tPhrw/cNiiP1u5Ina6DLRzm2O
        jL7PPiQGL4Hv5PeJsIwwOCBVuxVbEpKxATtacd4QVA==
X-Google-Smtp-Source: ABdhPJwub/NwJPB45j1iuLmm89NuZIw9wFdhV28CEQ33EGCiwtZ2hoVGFhhKU2aj/mWUCkmcesq4ImawnosiJZEkcZo=
X-Received: by 2002:a25:8390:0:b0:629:2839:9269 with SMTP id
 t16-20020a258390000000b0062928399269mr25658972ybk.246.1647938934543; Tue, 22
 Mar 2022 01:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220318074529.5261-1-songmuchun@bytedance.com>
 <20220318074529.5261-6-songmuchun@bytedance.com> <YjmK0aaCu/FI/t7T@infradead.org>
In-Reply-To: <YjmK0aaCu/FI/t7T@infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 22 Mar 2022 16:46:59 +0800
Message-ID: <CAMZfGtVBqVwHpoaotp+HF8+Sh-U3onKBBbQY69UT9SrGGOKVtQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] dax: fix missing writeprotect the pte entry
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 22, 2022 at 4:37 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +static void dax_entry_mkclean(struct address_space *mapping, unsigned long pfn,
> > +                           unsigned long npfn, pgoff_t start)
> >  {
> >       struct vm_area_struct *vma;
> > +     pgoff_t end = start + npfn - 1;
> >
> >       i_mmap_lock_read(mapping);
> > +     vma_interval_tree_foreach(vma, &mapping->i_mmap, start, end) {
> > +             pfn_mkclean_range(pfn, npfn, start, vma);
> >               cond_resched();
> >       }
> >       i_mmap_unlock_read(mapping);
>
>
> Is there any point in even keeping this helper vs just open coding it
> in the only caller below?

Good point. I'll fold dax_entry_mkclean() into the caller.

>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks.
