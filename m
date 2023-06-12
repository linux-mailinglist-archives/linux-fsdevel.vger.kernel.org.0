Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D234B72C6DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 16:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbjFLOEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 10:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbjFLOEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAB51AC
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 07:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686578596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TqJTjj61+e9IbmTeDPEzKkFs8seOoMOv+pnXorVK6Hc=;
        b=gCDBn98WQ/ZYesBdPpjYF+JFngLTb3F63E8jKO0nPZM37UQhZ4MQuTGuaQPE6EMx4Kn2RK
        UvcAIPiWqbJ9f00tH86Sa+Dh72SeFXX0g+byooBrIeYDIHibpoGc4GpMHZuVHeN6Cl83zb
        WRpvnc1Wc0HH4A/4TjBM6SSEZ+cZJuU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-anMe4V_nMDGoLYaH63Jbww-1; Mon, 12 Jun 2023 09:56:58 -0400
X-MC-Unique: anMe4V_nMDGoLYaH63Jbww-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75ec325d255so52789385a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 06:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686578218; x=1689170218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqJTjj61+e9IbmTeDPEzKkFs8seOoMOv+pnXorVK6Hc=;
        b=MJRFcGGp1sUIYhBvY8YAJm3j6AsRbKo2/RcpTrnpbVO4M+1YTKyt0amsexDPjNyxnW
         1IgFwOrzu3GuK9mOxoYFHRWRDO5oaq5JDCvug6zhJ3Y5Sw3R8nBMOFM1h2K9I2CJeW23
         GzG7Y0UbitoWQf2IcKK8GF9U22bUdlCIWZK923sW2YgKx2w7jZ4VUbKJhKQbMAuomRE0
         v/kC6b74YWdiVUCjb+r9i/Nq2DD9tY76wWRmWfkBZ0456w9AFKa/AN78JveyztyzHc+h
         pcMsVjC/pEQ5dl/HLexf3yyZknKOqtJSSDgki+6RVi0ZKKDK27+xinDe0EJrasaysbIu
         gEKg==
X-Gm-Message-State: AC+VfDyMvUcJLShum+Eh+AapFtwjVTW7GokstcxX1kY/tRysrfp3xZMQ
        86QgdNJyYi+fq67aJr9mjB8AALsU2cIRMGAX0D1jP2nSkA3W9W6JqTl+Cxm7TyIc4aays+PxhmE
        AyqHtfCy2R5B0UtRVCXyLNAhC/A==
X-Received: by 2002:a05:620a:3c8d:b0:75b:23a1:82a4 with SMTP id tp13-20020a05620a3c8d00b0075b23a182a4mr9898803qkn.5.1686578218371;
        Mon, 12 Jun 2023 06:56:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51PNRoKparZ97fJpEl38cjmcmWLq9AZx0KPCWvcIJxJzOQFaz53J6ns5SPtzcprqsL5F1/cQ==
X-Received: by 2002:a05:620a:3c8d:b0:75b:23a1:82a4 with SMTP id tp13-20020a05620a3c8d00b0075b23a182a4mr9898772qkn.5.1686578218103;
        Mon, 12 Jun 2023 06:56:58 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id u14-20020ae9c00e000000b0074636e35405sm2869932qkk.65.2023.06.12.06.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 06:56:57 -0700 (PDT)
Date:   Mon, 12 Jun 2023 09:56:54 -0400
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
Subject: Re: [PATCH v2 5/6] mm: implement folio wait under VMA lock
Message-ID: <ZIckJqkwx3fS6hBV@x1n>
References: <20230609005158.2421285-1-surenb@google.com>
 <20230609005158.2421285-6-surenb@google.com>
 <ZIORdizaMfvo01JO@x1n>
 <CAJuCfpERMyVp4EWTVTfJ5imRTo9h2MBj5QV1Y-AN9Qr1NzxoUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpERMyVp4EWTVTfJ5imRTo9h2MBj5QV1Y-AN9Qr1NzxoUg@mail.gmail.com>
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

On Fri, Jun 09, 2023 at 03:48:04PM -0700, Suren Baghdasaryan wrote:
> That was my intention here, IOW I'm making the following replacement:
> 
> -             mmap_read_unlock(mm);
> +             if (flags & FAULT_FLAG_VMA_LOCK)
> +                     vma_end_read(vma);
> +             else
> +                     mmap_read_unlock(vma->vm_mm);
> 
> Did I miss something which makes the function work differently between
> mmap_lock vs per-vma one?

Nothing wrong I can see.  Thanks.

-- 
Peter Xu

