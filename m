Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4E474173A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 19:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjF1RdC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 13:33:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34959 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230436AbjF1Rc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687973529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J0S2qMu17h8mlXEB7YzGyxzD+O5lnlad32j3R4zdlCU=;
        b=dR1Tn1bv3hkJfFTjmlgHYyRIsQE2sJbTVqk36WYoxqF+HjofjIe+lfkntJAKXkCyGW/gZe
        efoUIpD4HnxJvR/dfceeQ2JC0b3XpAqNbahJC2O0mAFvCP7CK7MxD+fpYwf2zuMZr/mTSu
        1Q579Vw/raHwlZtC/pL/VOvflp48m5E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-1I3L7EaQMRmX8NuPo1vH5w-1; Wed, 28 Jun 2023 13:32:08 -0400
X-MC-Unique: 1I3L7EaQMRmX8NuPo1vH5w-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4032a3ad8c0so296961cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 10:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687973527; x=1690565527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0S2qMu17h8mlXEB7YzGyxzD+O5lnlad32j3R4zdlCU=;
        b=LPqEZjQIhZ9qbiZJ3pvCUCSeYol368sOjgQNe9OD8WZNvmmP7oIXlPcZxiq8bQTz/L
         MRL/K2/wkLFKcJiLPJ8PCK6/RKvSv5jdGkhTmkhG/BHOa7iXlNj0u1xCNAgWwvSWG3Nw
         +Bs/8KBZqTXLG2l8Hv23y365agoPKVNZnnengDgqxJIpd442Nf9O6+O8uPX3GiVgbHo6
         p2YT0fBB3lzHHX3zALgRdO6n0ooI8z/5zHoxnWRLWk3PFMDusSF9nwHznJruZEcTZ8Ex
         m3PwVECv+ZYcC1jDuCVsaFRKyOiXooy/ubO3um0pM7kt+kXnx4OdGzPglPTg4ovWfsdu
         QdMA==
X-Gm-Message-State: AC+VfDyst0dRUpTr372BRn2UaRE6dZggJi8XE4g6XI68UdTc937frBN/
        8Q7/QOLRASiugDwWalc9NHwKxedrHZtmfzZZ/V04eY8E1vJxOm26tmrCmFNeIYTc4J/uTeiiEg7
        I8JjZEOXUhFl/Gzk5MrmqNGSgtQ==
X-Received: by 2002:a05:622a:1811:b0:3fd:eb2f:8627 with SMTP id t17-20020a05622a181100b003fdeb2f8627mr39939260qtc.6.1687973526687;
        Wed, 28 Jun 2023 10:32:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zIbrpeVS1P//ROrLWn98rbJUqVC2cFPhvP6qO+5ZYOuBmYLSEJ8G5hmetYO7hG2lGw3zRQw==
X-Received: by 2002:a05:622a:1811:b0:3fd:eb2f:8627 with SMTP id t17-20020a05622a181100b003fdeb2f8627mr39939221qtc.6.1687973526431;
        Wed, 28 Jun 2023 10:32:06 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id l25-20020ac848d9000000b003f7369c7302sm6095196qtr.89.2023.06.28.10.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 10:32:06 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:32:04 -0400
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
Message-ID: <ZJxulItq9iHi2Uew@x1n>
References: <20230628172529.744839-1-surenb@google.com>
 <20230628172529.744839-7-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230628172529.744839-7-surenb@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:25:29AM -0700, Suren Baghdasaryan wrote:
> Enable handle_userfault to operate under VMA lock by releasing VMA lock
> instead of mmap_lock and retrying. Note that FAULT_FLAG_RETRY_NOWAIT
> should never be used when handling faults under per-VMA lock protection
> because that would break the assumption that lock is dropped on retry.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Maybe the sanitize_fault_flags() changes suite more in patch 3, but not a
big deal I guess.

Acked-by: Peter Xu <peterx@redhat.com>

Thanks!

-- 
Peter Xu

