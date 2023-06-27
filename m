Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DBC73FF9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 17:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjF0P0A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 11:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjF0PZ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5992976
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687879465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mpxx00XoyC132Mr6RO3yKQstSVhf2gcfuBHHVEFTNh0=;
        b=S3mJhOcr1CrzAtdiwu3IsCPSOe6p2ZxBh6dyfEdtguZKDcBMhYm3+oe0r4pAD3TyykSfMi
        +lHouJRurXUeWT5j7JQNsKVyRJxY0vA36WGXd574juVKG1LdPflkclgo2CM4mBHVPc2lCg
        cvPknEslcsARJGOfwN3zzYC7miDpaJc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-HonrI-iNNhKijrkNniaFXg-1; Tue, 27 Jun 2023 11:23:08 -0400
X-MC-Unique: HonrI-iNNhKijrkNniaFXg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635eb5b04e1so2541606d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 08:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687879361; x=1690471361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpxx00XoyC132Mr6RO3yKQstSVhf2gcfuBHHVEFTNh0=;
        b=bJd1wfK1ykilKNsiQGR5hb732zN2oL8zftqcFc/ZVl0baLnbJOpDEQj1cbX6jVxYMt
         KHPSjWGu10vthYnGqsA0XckS4hRJ0JIODLAoXJYqloBqaxFRBvQe+/vhUKY5ZBcwnH9d
         pNukt4O5vUTSs3o41k3qKVQb1fL271DDYyf4C+nYGxPemn9slch7lViZnGO+04LFPad/
         AXJCTLWHLqdkOyi30yp0u/uceRw0SXH5/u10/EP8uy+7MzeQvgqht0RfEXRCtWgxcH++
         GIn8NQ+nh0N2bt4kJdWnexdFHhq0Jd2+oSlwF8nCtcpbyOwg97R6pRllwgmUGKgiSJWo
         yUgQ==
X-Gm-Message-State: AC+VfDxfUKq1+fY7ZwYcl3DXuLzE5zUpA6G4pdnUQUam/gM0k92XVCG+
        nWw5HiLcWmcqzPz1uJkRh6WgXGayKCM9UFKae8FcTI3IwfhB0v73W5YWoM+7x6IEgUPjqmAFkfF
        w1N97HevZbMHG3CtcSyWwAbY3LA==
X-Received: by 2002:a05:6214:c22:b0:625:77a1:2a5f with SMTP id a2-20020a0562140c2200b0062577a12a5fmr40561820qvd.5.1687879361512;
        Tue, 27 Jun 2023 08:22:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7k+Rvj2HAGIGv/kROiZog/CMhixAGLi2szEMwd9ZGPIqaz7MS5XLwAM8b1ix+sT9QAUyZ4HA==
X-Received: by 2002:a05:6214:c22:b0:625:77a1:2a5f with SMTP id a2-20020a0562140c2200b0062577a12a5fmr40561789qvd.5.1687879361249;
        Tue, 27 Jun 2023 08:22:41 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id ej8-20020ad45a48000000b0063003786840sm4661038qvb.99.2023.06.27.08.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 08:22:40 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:22:38 -0400
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
Subject: Re: [PATCH v3 4/8] mm: replace folio_lock_or_retry with
 folio_lock_fault
Message-ID: <ZJr+vlkIpaHWj1xg@x1n>
References: <20230627042321.1763765-1-surenb@google.com>
 <20230627042321.1763765-5-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230627042321.1763765-5-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 09:23:17PM -0700, Suren Baghdasaryan wrote:
> Change folio_lock_or_retry to accept vm_fault struct and return the
> vm_fault_t directly. This will be used later to return additional
> information about the state of the mmap_lock upon return from this
> function.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

The patch looks all fine to me except on the renaming..

*_fault() makes me think of a fault handler, while *_lock_or_retry() was
there for years and it still sounds better than the new one to me.

Can we still come up with a better renaming, or just keep the name?

Thanks,

-- 
Peter Xu

