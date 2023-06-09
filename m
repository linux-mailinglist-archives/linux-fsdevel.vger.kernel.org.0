Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B95372A4C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 22:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjFIUfo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 16:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFIUfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:35:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0ADD8
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686342896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WPbQmwUDw1rrCoBIsKEBQ6SaspaPtKCgJlbYD45n1n4=;
        b=Nv/ZOHK5pSPAtIiFIqISwr2Mdee1rgK6n250bfEAghh+q+2cjXr4vWBDhBqmwoqvbdkdIa
        rh4PeCkY2Wf4U/v+sU6fmZNVz9FUDrHDpYUrVZXajF6R4P7OCKNzGdfIc4K36SK6UMMEAz
        bU5y1Oarvb4wYFp4LN9Tfe/6wHTEjwQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-I7ANyf-MPOmXpcc_iX5LXA-1; Fri, 09 Jun 2023 16:34:49 -0400
X-MC-Unique: I7ANyf-MPOmXpcc_iX5LXA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75ec325d255so34468085a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 13:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686342888; x=1688934888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPbQmwUDw1rrCoBIsKEBQ6SaspaPtKCgJlbYD45n1n4=;
        b=Gs7NTxTG/19lVHlecea3cdY/B0gVWcRTvm8HblkqImKt9KxwAbhqS0kDq6weC6d75q
         Nh7uvfb/KVFdtquTzvEFevI6qt7M3Glas5iLofIFwJ7poPLUjDEtGCRaYI+JCx0aoXdK
         mPWz/A7TGlzRStFRmTDN34LewdHTFeXGBinF1n2boUfnPd34cp6ZyKH18V7puqRLAHna
         Cw6tMb/RuBUuVk0zUcpYw/Tdc28H528RXlJ0kc60y5mBnnQsKHPEi8aE7+hQM5xwIebG
         fDz78X/O5efBoajGbw7mD74NMyOiZQTxY2FJSWuFccvRh9Qtoqblkoqthe4i9CYySaL4
         oysw==
X-Gm-Message-State: AC+VfDwiVjGL1bHQnmQG/OmCXmJKKO6d6CaalI4R5xQQA/x5q2w0pTb3
        PK4Bx3sP8O+NlM7CW46kk3an0p2nr1z1ol5Xrxd2sZkOPKNmAw+aPrZrowf/ByErRHoSqBpU/la
        II5UBILrdqV1f8Z6DyfKE8XdJmg==
X-Received: by 2002:a05:620a:3711:b0:75e:b9ee:79ff with SMTP id de17-20020a05620a371100b0075eb9ee79ffmr2740564qkb.6.1686342888794;
        Fri, 09 Jun 2023 13:34:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4dU66sFL5e0sKBdTSuUBDYP+uMeSF/Slrlj3huXsRNDM2MpZKmMDCZm0x+DMxh9aiYqjIwXw==
X-Received: by 2002:a05:620a:3711:b0:75e:b9ee:79ff with SMTP id de17-20020a05620a371100b0075eb9ee79ffmr2740526qkb.6.1686342888499;
        Fri, 09 Jun 2023 13:34:48 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id o15-20020ae9f50f000000b007590aa4b115sm1269161qkg.87.2023.06.09.13.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:34:47 -0700 (PDT)
Date:   Fri, 9 Jun 2023 16:34:45 -0400
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
Subject: Re: [PATCH v2 3/6] mm: add missing VM_FAULT_RESULT_TRACE name for
 VM_FAULT_COMPLETED
Message-ID: <ZIOM5RJhshoqqZFF@x1n>
References: <20230609005158.2421285-1-surenb@google.com>
 <20230609005158.2421285-4-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230609005158.2421285-4-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 08, 2023 at 05:51:55PM -0700, Suren Baghdasaryan wrote:
> VM_FAULT_RESULT_TRACE should contain an element for every vm_fault_reason
> to be used as flag_array inside trace_print_flags_seq(). The element
> for VM_FAULT_COMPLETED is missing, add it.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

