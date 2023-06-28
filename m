Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6697416BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 18:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjF1Qsc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 12:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229626AbjF1QsI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687970837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rP7oTLZXnrKdM7Uf6r5o7yLX5pLrMAahCaLybcdGA/I=;
        b=Suw+rs4PYG2/ieTzDI/lRMXK9KwK4bR8f0pRjaQ7lzCFq8aL6USWs4YuUfoctpPNxIHoNT
        mIDCdFn9oPD9E7FpdtByYhE7DLOQzP0nvqDZsVYX7Szy1OB/DIYjGs9ah+AdleoG+N+pon
        nRrDj0EzexwKCoNwPwZw5ME+tmqX+SY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-u7lECdk3PDa-CP_7NcUoGA-1; Wed, 28 Jun 2023 12:47:16 -0400
X-MC-Unique: u7lECdk3PDa-CP_7NcUoGA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4009ad15222so86891cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 09:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687970836; x=1690562836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rP7oTLZXnrKdM7Uf6r5o7yLX5pLrMAahCaLybcdGA/I=;
        b=Kf/IU77gpAUqtLiJV2anB7Wh5Af88LWPq2fRHpAu5Rzex6HgiAPJjCSU+jupX5KfwQ
         FqyBrnHsXivKNdBWT9RP3Du/B0xnedZ2gvlCSt8OQfm4IeaAyEEnTAvVqoLS8t6CJU8W
         Ta0rd+rmeXCfxnoFLGULnRpfowizBDmp01Y4u+d6EKvJ6loijA3vSds0VDiWie0wnsTq
         +6jeg1ooA+qPD6PUxarIIaatcBSGgRh/cxr9/Vn2StU/oz9+KdE6+sqkr/sAnDuOJGL4
         HPt1CPFav5yy5yOVJv/yaQWA09fNqiVUWLNfwHoUOwfSb1VWx6+/ypO8+8PKknGQE6Im
         vjkQ==
X-Gm-Message-State: AC+VfDzLVcm9Rkp8KNH8gBKnq/vlF7B77dXijj3gi0nE1kSv7lDtLjW/
        M7TLRYC0hs85Bunjfiz2XelCWBOQSevKJnkdKkKgsXH3cGMPhwfxPFxND+BhLYhDfSzgOfiaVyw
        MXHsBW6ucQ/rCdv58Z3fIYswZJQ==
X-Received: by 2002:a05:622a:1827:b0:400:a9a4:8517 with SMTP id t39-20020a05622a182700b00400a9a48517mr11519367qtc.4.1687970835964;
        Wed, 28 Jun 2023 09:47:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5LY9IyT/sYyokB/ZS4mBtNEaOWQAWl0KHBcBGkRFXhA9IA4rTLIiYa9kmVOKNwHngvfuwDCg==
X-Received: by 2002:a05:622a:1827:b0:400:a9a4:8517 with SMTP id t39-20020a05622a182700b00400a9a48517mr11519338qtc.4.1687970835728;
        Wed, 28 Jun 2023 09:47:15 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id r15-20020ac85e8f000000b00403214e8862sm1027423qtx.33.2023.06.28.09.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 09:47:15 -0700 (PDT)
Date:   Wed, 28 Jun 2023 12:47:13 -0400
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
Subject: Re: [PATCH v4 6/6] mm: handle userfaults under VMA lock
Message-ID: <ZJxkEVWMAXnz8Y9D@x1n>
References: <20230628071800.544800-1-surenb@google.com>
 <20230628071800.544800-7-surenb@google.com>
 <ZJw8Z3E3d4dHPDuZ@x1n>
 <CAJuCfpGRresZRacCSDU=E+CNDkGfMwO2u-oTB_H30cASzFgNtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpGRresZRacCSDU=E+CNDkGfMwO2u-oTB_H30cASzFgNtA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 09:22:24AM -0700, Suren Baghdasaryan wrote:
> Ack. I was not sure if the ctx->mm would always be the same as vmf->mm.

Feel free to look at the entrance of handle_userfault(), where there's:

	struct vm_area_struct *vma = vmf->vma;
	struct mm_struct *mm = vma->vm_mm;
	struct userfaultfd_ctx *ctx;
        ...
	ctx = vma->vm_userfaultfd_ctx.ctx;
        ...
	BUG_ON(ctx->mm != mm);
        ...

So I think we should be safe.  Thanks,

-- 
Peter Xu

