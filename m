Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6829E436103
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 14:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhJUMF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 08:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhJUMF5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:05:57 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5017CC06161C;
        Thu, 21 Oct 2021 05:03:41 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id bl14so819770qkb.4;
        Thu, 21 Oct 2021 05:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=luh0TIccmegXn8CJKJYKcwVKTjrSX33i0YnsKW7PqRo=;
        b=qGD4VnPE++cf1r2/FKV86F0A1UAugCAyIHl5wNZ1vD6jCIWAMUT6Rwb653yetmU3Ns
         w0ZJCx+yf0nvzehRE0j3tWpUfb2T1Oe1dc1ZcBtlB2Xj05XeWvCCffAID3/dyEVh73m0
         hLUWc1vUsqc5fm5fLmyIU11Ht1P/+cxVUBvrbvwSWLw3TTGjonEQNQCATPY0G5mCYsf/
         NoSDHyefyqDLnv6PiaDrkB4tlzLueZPa9b62UECl9lavceDHw4HQFcm91z9i/wEGdJFY
         4yyd/9f3U21RxJGO88adsptB1gHxmpPqufPNYtAQXwRAql0yw+BZ/CggLOqHZYPHErmP
         /UPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=luh0TIccmegXn8CJKJYKcwVKTjrSX33i0YnsKW7PqRo=;
        b=7xmZ/vbxJKhFSsvyytf0IBW6BnUulEPgQMvn3kvIoCRb8pJCHxR7UwoKCx2nmU0TTl
         Ikvkh+2vqjnKHfto3ElMeot2Rzj/jMUGAs/PO461FLgFXPpdrA4lwMrLQkcQyAY/3n4L
         w3tW/mmppsPIp4ytIxpeNWPWJ0YDu7NObc2YVGzRgue3hEl7EaR7g+YWvW/FcLlyQHWT
         lqEPHBHGErWdTnklzVLKqR6i60dThNk+3FOv0iVZ4CRkTzAt664AwRppj7HX3jBnRqU2
         4VsV7URgtUg6HdbkNqW4V2HGhrknqrz9+TnCosPrNnG/VUqc1DWXerPyN4vNCUiBwYnG
         +kDg==
X-Gm-Message-State: AOAM5327ZRfvdDMun60uGbumat1UnLRbW4T5MOPbtTnMVeicsFvPF9v/
        sqEqHcO9yzQYbFrey8O7PQ==
X-Google-Smtp-Source: ABdhPJwd1ait2YAPoGPfPub3ytuA8mdp1mQxCnWuEJN0VmzllJMSSscBuA4UgH+C3yQkZAYHcnKxAQ==
X-Received: by 2002:a37:b307:: with SMTP id c7mr4157659qkf.134.1634817820520;
        Thu, 21 Oct 2021 05:03:40 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id l3sm2474608qkj.110.2021.10.21.05.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 05:03:39 -0700 (PDT)
Date:   Thu, 21 Oct 2021 08:03:37 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YXFXGeYlGFsuHz/T@moria.home.lan>
References: <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org>
 <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
 <996b3ac4-1536-2152-f947-aad6074b046a@redhat.com>
 <YXBRPSjPUYnoQU+M@casper.infradead.org>
 <436a9f9c-d5af-7d12-b7d2-568e45ffe0a0@redhat.com>
 <YXEOCIWKEcUOvVtv@infradead.org>
 <f31af20e-245d-a8f1-49fa-e368de9fa95c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f31af20e-245d-a8f1-49fa-e368de9fa95c@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 09:21:17AM +0200, David Hildenbrand wrote:
> On 21.10.21 08:51, Christoph Hellwig wrote:
> > FYI, with my block and direct I/O developer hat on I really, really
> > want to have the folio for both file and anon pages.  Because to make
> > the get_user_pages path a _lot_ more efficient it should store folios.
> > And to make that work I need them to work for file and anon pages
> > because for get_user_pages and related code they are treated exactly
> > the same.

++

> Thanks, I can understand that. And IMHO that would be even possible with
> split types; the function prototype will simply have to look a little
> more fancy instead of replacing "struct page" by "struct folio". :)

Possible yes, but might it be a little premature to split them?
