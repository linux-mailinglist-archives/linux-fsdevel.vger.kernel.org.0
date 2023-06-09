Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A6A72A4D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 22:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjFIUm5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 16:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFIUmz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0D62134
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686343325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3+p+efMF1py6pEpvkihdBi8OztSv7Pz8tdWi2Iw9yIU=;
        b=Ql1Q2gTLMWewSfgVXHb+IRl5Q5qpGrj9j/T3OX18cV8NnOwgXYD1LABz/ObqDPxqyIiJhp
        gvQa1DOZGEgeB1klQE4Q/A/o9qVFqsigyHoyPb16La5XoDl8mMXX0r67Wxmvb5QfF2EF7E
        EsLVRLLjwR8/PGUzLoTCQPezTCuo+j4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-1zzAk6dQNfW3G6zvC6QPyA-1; Fri, 09 Jun 2023 16:42:04 -0400
X-MC-Unique: 1zzAk6dQNfW3G6zvC6QPyA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75e681229c5so47432585a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 13:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686343323; x=1688935323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+p+efMF1py6pEpvkihdBi8OztSv7Pz8tdWi2Iw9yIU=;
        b=cWcb2QLGQGC5YLA8c/iMwtT64i/aNqMRrYYlop18SOGpyQGikbP7UuSddgRGc7KcH1
         9gAJ+j3hYQSTgzfZG2nioPvA3xIMU/NlWsFhzWH0355uxiP345SBrebUxmBTKtWRmNVv
         bauGDW80UM9ZeqjEeCSo+hWHdurCSeDgkFmrpzpp/H8M+ggrkzasf4Y39JmLzNAcx7aa
         o+p1rsOczs+Y9SheB2t5niTkSCoeUukgvL7nmjf86yV5mcHyob+cWeP6Y9kSgFGqtvfA
         XDggwGD523kVQA4rdK+DISHdzsYQURawomoDO2lZDrvUBuHLY6rq14Y9HZma6lGeupAq
         taSg==
X-Gm-Message-State: AC+VfDyHT+/WINqYcY58zA5TgZcOhGHW5V10/2V/IeCAvERikQ3Npehz
        8gNvXGuqZrFEOwoV86RfDylCBJk1lS8W//YmUUvkdNwrDsRR52463u/MzVytXCJsf/ROz58epaW
        djAeVsNVZc9JBPeK4pu+r4mNymw==
X-Received: by 2002:a05:620a:46a8:b0:75b:23a1:69f0 with SMTP id bq40-20020a05620a46a800b0075b23a169f0mr2844968qkb.7.1686343323576;
        Fri, 09 Jun 2023 13:42:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5MhYTYYAIL9lllr8F5q12r8SC+qD0eDeSyZp3uUsLxhZSNfrjXGqhTrE3LVMEEYGVFirie1g==
X-Received: by 2002:a05:620a:46a8:b0:75b:23a1:69f0 with SMTP id bq40-20020a05620a46a800b0075b23a169f0mr2844938qkb.7.1686343323262;
        Fri, 09 Jun 2023 13:42:03 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id x14-20020a05620a14ae00b007595614c17bsm1259288qkj.57.2023.06.09.13.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:42:02 -0700 (PDT)
Date:   Fri, 9 Jun 2023 16:42:00 -0400
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
Subject: Re: [PATCH v2 4/6] mm: drop VMA lock before waiting for migration
Message-ID: <ZIOOmC26qh4EXUEX@x1n>
References: <20230609005158.2421285-1-surenb@google.com>
 <20230609005158.2421285-5-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230609005158.2421285-5-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 08, 2023 at 05:51:56PM -0700, Suren Baghdasaryan wrote:
> migration_entry_wait does not need VMA lock, therefore it can be dropped
> before waiting. Introduce VM_FAULT_VMA_UNLOCKED to indicate that VMA
> lock was dropped while in handle_mm_fault().
> Note that once VMA lock is dropped, the VMA reference can't be used as
> there are no guarantees it was not freed.

Then vma lock behaves differently from mmap read lock, am I right?  Can we
still make them match on behaviors, or there's reason not to do so?

One reason is if they match they can reuse existing flags and there'll be
less confusing, e.g. this:

  (fault->flags & FAULT_FLAG_VMA_LOCK) &&
    (vm_fault_ret && (VM_FAULT_RETRY || VM_FAULT_COMPLETE))

can replace the new flag, iiuc.

Thanks,

-- 
Peter Xu

