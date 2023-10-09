Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051557BE922
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 20:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377469AbjJISVM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 14:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbjJISVL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:21:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D56BA6;
        Mon,  9 Oct 2023 11:21:06 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40651a726acso45016025e9.1;
        Mon, 09 Oct 2023 11:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696875664; x=1697480464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TfP0qTBUd4xX1/BfpaGnOAmCxHeUgPJ3aawAUXPsDFY=;
        b=jtnyoDY8tDoMDCmqQiQFG7oJbTOHc7uKxJ6TQwL4VFb5we4FxgIyzEv1/jPgYwltcq
         g7U4HXdLWoMoSmPvSNZNAy+Z6JYWRV8oli90eQSRnGtR+SPNCGe4XQ/kO546G8TOC3gC
         FELHOlWMk11qq8LgG7tvu+s+qWlL6Nml45m+8/JR/byq9mg6pkGhF1Z89mCk8cmgATox
         MBGS1FOxbtlvEMlUbCFG8sfnegMGmkxVRnjXY1L3GUL6++JAFdS7PS1d/NEbg5P3RD3P
         ykR2yRpBLKnLMWCOn1+8HLIeoueNXS9D9YTqeIZqSHWgrT7Ayy6w7Muy6/v/vPIFerQH
         3B8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696875664; x=1697480464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfP0qTBUd4xX1/BfpaGnOAmCxHeUgPJ3aawAUXPsDFY=;
        b=rfkIch2QZmwyMwUcurrlmqIKzgHJpa0oxa2+B78WscSZz+vkkt/p4QKzOXCBoEqL+8
         zu6Ka8SJk+u/Kil+uI5oA9QddebfB6MHQaW2KMFHKx923Y+g05v2HsYb68j1nkNO7rhB
         zbQHBQvEiZGqwHHGLznKcmgTBQaA4J/sRK8EZSCu9Aw4FhWcVEzTfmR6f7CNHiGxjLuu
         cNaegcGE5NU80iQrjY8ZnEf7UNWVAvmFxHsxkq0STvu1qLPv3XTGWNpDZiSygI5BiV7T
         TDjbnP0WEN/ucC2+URZ4MuVs1eQcyrGKoasRZv2u/ejasCcJNXF567hyOoQkoeAAN5Bp
         n82w==
X-Gm-Message-State: AOJu0YwdxhItlHmndVYKPMZ7/Te6DVOWL2v1QXEAayAP/VqmIGiLwMyu
        hJNPJBnoBaQXFMf6O5OHhmQ=
X-Google-Smtp-Source: AGHT+IH+zjGLzFR7Y7bhfkh7TWduH/jUD5oAtocqjWrnmntfmwCseppIEAA2/7Ynq8jdvcUJYfZmuA==
X-Received: by 2002:a7b:cc07:0:b0:401:73b2:f039 with SMTP id f7-20020a7bcc07000000b0040173b2f039mr14792796wmh.7.1696875664611;
        Mon, 09 Oct 2023 11:21:04 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b00405d9a950a2sm14151670wmh.28.2023.10.09.11.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:21:03 -0700 (PDT)
Date:   Mon, 9 Oct 2023 19:21:03 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: abstract merge for new VMAs into
 vma_merge_new_vma()
Message-ID: <ec520a80-4b4f-4eef-ab17-1ee3ebc2982e@lucifer.local>
References: <cover.1696795837.git.lstoakes@gmail.com>
 <f38b4333badbdabdb141d5ecc59518f50e5d3493.1696795837.git.lstoakes@gmail.com>
 <e0300e5a-394d-0cdf-4044-a9a67a24c9b3@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0300e5a-394d-0cdf-4044-a9a67a24c9b3@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 09, 2023 at 06:04:47PM +0200, Vlastimil Babka wrote:
> On 10/8/23 22:23, Lorenzo Stoakes wrote:
> > Only in mmap_region() and copy_vma() do we add VMAs which occupy entirely
> > new regions of virtual memory.
> >
> > We can share the logic between these invocations and make it absolutely
> > explici to reduce confusion around the rather inscrutible parameters
>
> explicit ... inscrutable
>

Ack will fix up in v2.

> > possessed by vma_merge().
> >
> > This also paves the way for a simplification of the core vma_merge()
> > implementation, as we seek to make the function entirely an implementation
> > detail.
> >
> > Note that on mmap_region(), vma fields are initialised to zero, so we can
> > simply reference these rather than explicitly specifying NULL.
>
> Right, if they were different from NULL, the code would be broken already.
>
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>

Thanks!
