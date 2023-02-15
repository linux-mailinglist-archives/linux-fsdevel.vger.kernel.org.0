Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235866972AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 01:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjBOAd0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 19:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBOAdZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 19:33:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1E2234F6
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 16:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676421157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0etdia8N+ECGaC0gAhXaKuBpC7aTnF6lYawwxL7alZU=;
        b=cfGW390hFBPKIv50Qskfx916BPSKhAV0OmSqzpIee+F7bxyzPZPeipEPisj5uSL5PJNE3V
        B9dQZKKTSbdSf/zYIbZx66U7K55CBHzpqoNxM7HRQHm3kcxLzN5q7SEFCXwycygwLp6n6a
        v1qyR8WP8OtqTyRLm/Dgw8fHPXtST0Q=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-vc8FRiivN_e1pLvyHXTi5g-1; Tue, 14 Feb 2023 19:32:36 -0500
X-MC-Unique: vc8FRiivN_e1pLvyHXTi5g-1
Received: by mail-qt1-f198.google.com with SMTP id i5-20020ac813c5000000b003b86b748aadso10380456qtj.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 16:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676421156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0etdia8N+ECGaC0gAhXaKuBpC7aTnF6lYawwxL7alZU=;
        b=UggqzyMVD0fkFlpekp+9DGsKRGvQx0HlODeVJ4YF1yYeXlgkXxj+y7GtqkrTIUhzWH
         WQzwwytE6lsQOWxJ/Me+SuZ3RTUrHckOE3RXXViwOtun2XDSLOPy4SKKgt7xF848yha4
         /O/9DS/QJ4nKmlp7wzYBag8GnK0Ii0zogNEBgfOnyPUIL6qX7azViaw3NDMeN75mIQcf
         gTLaUU2oUhJXE/3oLxfNruAr04aWWYs/vu62UMfok14eAFTXXE6TjvqpFMHnZXVBiTOV
         AIxPxjFBIa/4Fkudz7lltNUs7Angr4tt+VKGdFMi5MH3AOIc5jo1fUC8A/CqjeQmHSK1
         442Q==
X-Gm-Message-State: AO0yUKVe+IEh0N4OyZ2Mfi8asBTzvtYTigyCBFAFtbeLmGAAJdLGVD33
        R80FB6z2UxhCJcSKORnNcmyY+oiv1p9nzWfvgG13VaieLTVrE9hUh+0oAUDpcKAK/My6qmgWdIf
        sxDSgrug4hQ4Tmiqh8E7BkbvN2g==
X-Received: by 2002:a05:622a:5c7:b0:3b8:36f8:830e with SMTP id d7-20020a05622a05c700b003b836f8830emr338501qtb.6.1676421156143;
        Tue, 14 Feb 2023 16:32:36 -0800 (PST)
X-Google-Smtp-Source: AK7set9yOl2ngRxqcgHLXOhO5w1e7vPn8HhnvU3R6YCTj2Nylo/ep0JaoSfrJ2cQznmURLh3CZz7pw==
X-Received: by 2002:a05:622a:5c7:b0:3b8:36f8:830e with SMTP id d7-20020a05622a05c700b003b836f8830emr338467qtb.6.1676421155789;
        Tue, 14 Feb 2023 16:32:35 -0800 (PST)
Received: from x1n ([70.30.145.63])
        by smtp.gmail.com with ESMTPSA id s6-20020a372c06000000b00727538eb831sm12902269qkh.86.2023.02.14.16.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 16:32:35 -0800 (PST)
Date:   Tue, 14 Feb 2023 19:32:29 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Subject: Re: [PATCH] mm: userfaultfd: add UFFDIO_CONTINUE_MODE_WP to install
 WP PTEs
Message-ID: <Y+woHZ3AHe3quadT@x1n>
References: <20230214215046.1187635-1-axelrasmussen@google.com>
 <Y+wIdeu3Lw/3kmXg@casper.infradead.org>
 <CAJHvVciR=inDaKnmCfCQsxgBsJB6eQVDXQw67o0Foc9ofgbuow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVciR=inDaKnmCfCQsxgBsJB6eQVDXQw67o0Foc9ofgbuow@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 02:37:51PM -0800, Axel Rasmussen wrote:
> Agreed, it would likely be a nice cleanup. Peter, any objections? I
> wouldn't mind writing a commit to do this sort of refactor, and rebase
> my change on top of that.

No objection here.  Personally I actually prefer keeping the parameters
around if possible because it's straightforward and no thinking of any
possible indirect accesses all over the place. But maybe growing as long as
8 is still a moot point..  It's just that I don't really know whether it'll
look that good if we put everything into a struct*.

Things like src_start/dst_start/.. do not look good to be there: each layer
could loop over its own range of start/end/... so even if not in the
function parameter we'll need a variable to hold them anyway.

But I do see a few low hanging fruits:

  - I don't see why we need to pass over mmap_changing over all of the
    __mcopy_atomic() callers.  One chance is we simply pass in the ctx* to
    replace "dst_mm + mmap_changing".

  - Merge mcopy_atomic_mode and mode, having last 2 bits for the existing
    three modes, then bit 3 for WP, good enough to set it for the new case.

  - Optionally, we can avoid passing over dst_mm/src_mm all around, when
    dst_vma/src_vma is there?

How about we start from simple?

-- 
Peter Xu

