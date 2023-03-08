Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548A46B156B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 23:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCHWoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 17:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCHWog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:44:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323CE62FEB
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 14:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678315426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jUpec8k3TuIoHkhdWuDgw2GYbAPkkhYheZa+lxQbkK0=;
        b=dPs8c3b3RtJDbhKCuoxJlxNN+hgWHpW4Wp38outWfYuKxQ2I32E9emD6kZFsHTQPHRi4Q1
        RNxI+oWNyo2RHc0yBmEyk5KNUfL9DoBcJe8Ny7YqFqico25bzjVs57hHxng80hXJ4PrN3u
        dBOnNuxo426Epz9iwO4EYdiEc5GAz+w=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-wvo7d4O9PMipzP-A_E6gnA-1; Wed, 08 Mar 2023 17:43:42 -0500
X-MC-Unique: wvo7d4O9PMipzP-A_E6gnA-1
Received: by mail-qt1-f200.google.com with SMTP id r4-20020ac867c4000000b003bfefb6dd58so60419qtp.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Mar 2023 14:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678315422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUpec8k3TuIoHkhdWuDgw2GYbAPkkhYheZa+lxQbkK0=;
        b=SYWHoyXP+nBRFfT+4bq8kEQjvuBzZoa2Wn24XP4gkftjW6iALsp7kWEP6bNOY1K/GW
         E6KmLVvJ7gh183sjPWqBRSLWnvN8oVczRGBDpi8aL00BBSZxPsSY8xjIjlcfF0N2z0+l
         tizOOsSEpQdd7izKJk5iGaSfwgNJU+WUDeetekiW+SaW+F0Ix8kGPcLgG4LTHQfiBeP9
         I3wFzOOKLVGuGWCLZe0oKdyt5CvdJoY3T++xqeikr2AurujB7RlTt/U1cET0oCMBrvD9
         baIHTc3SvyXDrVkWv2ShX+Kw/uFgZxZ99oPB98z3a5goaFIxcCy4eKc9dxemhPFCFc1l
         DE5w==
X-Gm-Message-State: AO0yUKWgBZx6SukkHNM7qEZc0SpvM7k5voZwJMNNjGrUK7rB5g4Wfrqr
        KhxEVYU7zezGIsE5sUQDlBkqGwxr+cDL/FG4JHJDUKLseNvJWEJeCkyHNGnnFR+n9pOYybRlq4m
        2EwYXY5qZ/ou3k1QR3PUXCCSnTQ==
X-Received: by 2002:a05:622a:4c7:b0:3bf:be4b:8094 with SMTP id q7-20020a05622a04c700b003bfbe4b8094mr39961486qtx.0.1678315422282;
        Wed, 08 Mar 2023 14:43:42 -0800 (PST)
X-Google-Smtp-Source: AK7set/svpcFN7oyLd26+MN7LVXbPhQYslhKV53Vi4XzGLt4t3d/JLaXvYRZ51X7BFbuHcnLETSjqQ==
X-Received: by 2002:a05:622a:4c7:b0:3bf:be4b:8094 with SMTP id q7-20020a05622a04c700b003bfbe4b8094mr39961450qtx.0.1678315422037;
        Wed, 08 Mar 2023 14:43:42 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id r25-20020ac87959000000b003bfc1f49ad1sm12255401qtt.87.2023.03.08.14.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:43:41 -0800 (PST)
Date:   Wed, 8 Mar 2023 17:43:39 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Shuah Khan <shuah@kernel.org>,
        James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 3/4] mm: userfaultfd: combine 'mode' and 'wp_copy'
 arguments
Message-ID: <ZAkPmy0EqcW6Mfvn@x1n>
References: <20230308221932.1548827-1-axelrasmussen@google.com>
 <20230308221932.1548827-4-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230308221932.1548827-4-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All nitpicks below.

On Wed, Mar 08, 2023 at 02:19:31PM -0800, Axel Rasmussen wrote:
> +static inline bool uffd_flags_has_mode(uffd_flags_t flags, enum mfill_atomic_mode expected)
> +{
> +	return (flags & MFILL_ATOMIC_MODE_MASK) == ((__force uffd_flags_t) expected);
> +}

I would still call it uffd_flags_get_mode() or uffd_flags_mode(), "has"
sounds a bit like there can be >1 modes set but it's not.

> +
> +static inline uffd_flags_t uffd_flags_set_mode(uffd_flags_t flags, enum mfill_atomic_mode mode)
> +{
> +	return flags | ((__force uffd_flags_t) mode);
> +}

IIUC this __force mostly won't work in any way because it protects
e.g. illegal math ops upon it (to only allow bitops, iiuc) but here it's an
OR so it's always legal..

So I'd just drop it and also clear the mode mask to be very clear it sets
the mode right, rather than any chance of messing up when set twice:

    flags &= ~MFILL_ATOMIC_MODE_MASK;
    return flags | mode;

But feel free to ignore this if there's no other reason to repost, I don't
think it matters a huge deal.

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

