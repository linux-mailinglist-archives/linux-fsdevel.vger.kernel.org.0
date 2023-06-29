Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ACD742AB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 18:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjF2QeC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 12:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjF2QeB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:34:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4D430DD
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688056389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T9WhCFKDeQiwQ9P8Z4ZmNdOekWIBt/DtpJr87ziAM18=;
        b=fp8jzEMhzvbV4l+FKW2NZh8kWsKhJ3KsiUUroab52WjR2TzXTia1usPRyr8UlW3jemzOBa
        3oF9ynfM7XE9qNYh6CC+sDI8RYHofN8TmXxwOUeumerc1295wDGLzZWHKGa+xVgegipy0a
        /fENGhzWkn1wUHzlKrEJ/IuNTnY6yVk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657--vIucNaYNZKreSezZNbTyw-1; Thu, 29 Jun 2023 12:33:07 -0400
X-MC-Unique: -vIucNaYNZKreSezZNbTyw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-74faf5008bbso19161385a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 09:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688056387; x=1690648387;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9WhCFKDeQiwQ9P8Z4ZmNdOekWIBt/DtpJr87ziAM18=;
        b=kibXnI4ut9fOXRiyYFcz1dPUoECF77tYYhbP/n3PJiSyjT5nCFqvlC9mxLE48RNgCB
         Nk+14orE2QKA1TMv66LUjupnLoMCvX/8c7NT2nFwIgc8n2pLU/xrVxtT+nncgEQd9v18
         jsbEgaWPPQt9D3RzFiIe74Ev1/NqNRB+NV51d/R6aA/YfAXzL4pBKru05U8/Z89xFefx
         0Qg8kFWy8MHwaoPTr9t4dDfgn5AP3/U0IehuLrP83svjZaiHdCFkChcCXXQWRi/iajIi
         9T06SD0iSSZnYCPzyv1nQk698Rh0Z4DrA7Mg9N8rYR5REEQVRjZa7vQTJ3oiXc+5z5x5
         g7Kg==
X-Gm-Message-State: ABy/qLZZs3D6/a2/OYh4bY7v7otqgExWiZW/QC2PkIoZk0sDlr4FVYF+
        ZxUwHH9ogDlmtio1dusAzts4e/xhkd4RyBRwocLW5OWYuefiDyYVCnliPMSqxGvQsqe2P5LnonI
        ty7d4G8OhLG3Fv3gIfpaln+gvsA==
X-Received: by 2002:a0c:fbcf:0:b0:62b:5410:322d with SMTP id n15-20020a0cfbcf000000b0062b5410322dmr183800qvp.6.1688056387479;
        Thu, 29 Jun 2023 09:33:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEsboSyRALJa4QGaJl+D6XdcWr9w6NJmcI+LBYwqVfR+4ZEGxEM7LvIqdoVBmRJd0KtsVwtMg==
X-Received: by 2002:a0c:fbcf:0:b0:62b:5410:322d with SMTP id n15-20020a0cfbcf000000b0062b5410322dmr183772qvp.6.1688056387069;
        Thu, 29 Jun 2023 09:33:07 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id w2-20020a0cfc42000000b005ef81cc63ccsm7174643qvp.117.2023.06.29.09.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:33:06 -0700 (PDT)
Date:   Thu, 29 Jun 2023 12:32:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v5 6/6] mm: handle userfaults under VMA lock
Message-ID: <ZJ2yOACwp7B2poIw@x1n>
References: <20230628172529.744839-1-surenb@google.com>
 <20230628172529.744839-7-surenb@google.com>
 <ZJxulItq9iHi2Uew@x1n>
 <CAJuCfpEPpdEScAG_UOiNfOTpue9ro0AP6414C4tBaK1rbVK7Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEPpdEScAG_UOiNfOTpue9ro0AP6414C4tBaK1rbVK7Hw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 05:19:31PM -0700, Suren Baghdasaryan wrote:
> On Wed, Jun 28, 2023 at 10:32 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Jun 28, 2023 at 10:25:29AM -0700, Suren Baghdasaryan wrote:
> > > Enable handle_userfault to operate under VMA lock by releasing VMA lock
> > > instead of mmap_lock and retrying. Note that FAULT_FLAG_RETRY_NOWAIT
> > > should never be used when handling faults under per-VMA lock protection
> > > because that would break the assumption that lock is dropped on retry.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Maybe the sanitize_fault_flags() changes suite more in patch 3, but not a
> > big deal I guess.
> 
> IIUC FAULT_FLAG_RETRY_NOWAIT comes into play in this patchset only in
> the context of uffds, therefore that check seems to be needed when we
> enable per-VMA lock uffd support, which is this patch. Does that make
> sense?

I don't see why uffd is special in this regard, as e.g. swap also checks
NOWAIT when folio_lock_or_retry() so I assume it's also used there.

IMHO the "NOWAIT should never apply with VMA_LOCK so far" assumption starts
from patch 3 where it conditionally releases the vma lock when
!(RETRY|COMPLETE); that is the real place where it can start to go wrong if
anyone breaks the assumption.

Thanks,

-- 
Peter Xu

