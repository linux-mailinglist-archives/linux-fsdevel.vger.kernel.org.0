Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9884C72C6C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 16:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjFLOAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 10:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjFLOAl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:00:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37BF1AC
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686578376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GKBfBKTeVMZb+dt8ekYcaXAyT4nwQrKdK59Oup6XbjM=;
        b=PMrMOMhygQanLa8wpyi1Lvvv6BIPHNtZ1UAMCK79CtxD/4dcvHhU2Sz3drO2LkmTz72pab
        kJ3X3Q3brCVxkRcSYXWep3GukPSC3ERPkXJJK8sgYNn2QzcMyh8yLFqdXCauE1md3g0Mxh
        vF8sr6KYIkFXjP8SjijLbgJ5H4RXF2Q=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-bakhY-MpOw6wrJzd-Z6-qw-1; Mon, 12 Jun 2023 09:59:28 -0400
X-MC-Unique: bakhY-MpOw6wrJzd-Z6-qw-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-463982ca6f2so105091e0c.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 06:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686578363; x=1689170363;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKBfBKTeVMZb+dt8ekYcaXAyT4nwQrKdK59Oup6XbjM=;
        b=VEgi7shwNclNsyPo7Q9TlwzhV+2gjzXNZI3NnwJmHow22DJ3aTK4Sz9dPCZ/kxRwTV
         6TexuvmM07LM4JW0Md5kNzl+T5aDKNiTpF1ocYdomwX27r0R3o1rU+4r0glhH411pDun
         gHiAckn9AP2Xj1Ou/FJk0q0cWaByGt0ykn/cR3YuMXZ/79rSqqCwPHf3vjmIYA1fq7lG
         J0FoEiwCtKqbrSKFIQzBr89SXZd3zQio7kbF4M3SZIXMXvJN2hMpuCjmPZ2qbSOpaYAQ
         nHAEelAOHw2UNkBCkEjUAGFW73RYO/uCaKITHsdYSMhjrK9gnBgtic+9evr1NhOd5M39
         8X/Q==
X-Gm-Message-State: AC+VfDwJ2hqwlNNZdt2XsNqMoKamgfuHEdkGemN1CIEmJdc7f8m9RiDt
        PsbWBNOZDy2jFZflfVQudMXlHzRlkGqgUJOgcZsa3c7DEeKwBtZ0Nz8pGkpQzB2J2C+H5ueyAgW
        iVRX0pK2BXQYHftJYEn0qn+kUTw==
X-Received: by 2002:ac5:c858:0:b0:457:3a45:38d2 with SMTP id g24-20020ac5c858000000b004573a4538d2mr3539488vkm.1.1686578363651;
        Mon, 12 Jun 2023 06:59:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5TlkHrlSDfBgWo12KHaFjakxWZQ6CGtAWvz+eNVHFMNBM4VurWIdxp0q7dBJcjBu3sxsTD9w==
X-Received: by 2002:ac5:c858:0:b0:457:3a45:38d2 with SMTP id g24-20020ac5c858000000b004573a4538d2mr3539453vkm.1.1686578363405;
        Mon, 12 Jun 2023 06:59:23 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id t18-20020a0cea32000000b005ef54657ea0sm3221971qvp.126.2023.06.12.06.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 06:59:22 -0700 (PDT)
Date:   Mon, 12 Jun 2023 09:59:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 2/6] mm: handle swap page faults under VMA lock if
 page is uncontended
Message-ID: <ZIcktx8DPYxtV2Sd@x1n>
References: <20230609005158.2421285-1-surenb@google.com>
 <20230609005158.2421285-3-surenb@google.com>
 <ZIOKxoTlRzWQtQQR@x1n>
 <ZIONJQGuhYiDnFdg@casper.infradead.org>
 <ZIOPeNAy7viKNU5Z@x1n>
 <CAJuCfpFAh2KOhpCQ-4b+pzY+1GxOGk=eqj6pBj04gc_8eqB6QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFAh2KOhpCQ-4b+pzY+1GxOGk=eqj6pBj04gc_8eqB6QQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 03:34:34PM -0700, Suren Baghdasaryan wrote:
> On Fri, Jun 9, 2023 at 1:45 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Jun 09, 2023 at 09:35:49PM +0100, Matthew Wilcox wrote:
> > > On Fri, Jun 09, 2023 at 04:25:42PM -0400, Peter Xu wrote:
> > > > >  bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
> > > > >                    unsigned int flags)
> > > > >  {
> > > > > + /* Can't do this if not holding mmap_lock */
> > > > > + if (flags & FAULT_FLAG_VMA_LOCK)
> > > > > +         return false;
> > > >
> > > > If here what we need is the page lock, can we just conditionally release
> > > > either mmap lock or vma lock depending on FAULT_FLAG_VMA_LOCK?
> > >
> > > See patch 5 ...
> >
> > Just reaching.. :)
> >
> > Why not in one shot, then?
> 
> I like small incremental changes, but I can squash them if that helps
> in having a complete picture.

Yes that'll be appreciated.  IMHO keeping changing semantics of
FAULT_FLAG_VMA_LOCK for the folio lock function in the same small series is
confusing.

-- 
Peter Xu

