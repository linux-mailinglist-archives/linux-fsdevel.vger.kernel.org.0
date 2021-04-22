Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C206736887A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 23:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbhDVVTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 17:19:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237018AbhDVVTa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 17:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619126335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WL2DjbQuTq/EcUdymB75wSg7jJRF6qAH0Wk/CKq5EIY=;
        b=OouV6LUy1hdHGfG30icZrU6EBM8+adpAmwkAcEpzGLyPA399y6YjzbumycjK8zizp9zNLP
        39+u2W4TnZa2uaTHPUZuEnCEcC2GTKo486SEg3xBILuAm33Sv1mhOfUSSGUg0oXPnoc/Ne
        Yl+E8CovX6mOzcU0ajMQL8qm5IiX/hY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-8rUu5sQBP9GXlrCQ-jG6kA-1; Thu, 22 Apr 2021 17:18:51 -0400
X-MC-Unique: 8rUu5sQBP9GXlrCQ-jG6kA-1
Received: by mail-qv1-f72.google.com with SMTP id b20-20020a0cf0540000b02901a471b6ccbaso12287074qvl.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 14:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WL2DjbQuTq/EcUdymB75wSg7jJRF6qAH0Wk/CKq5EIY=;
        b=W0rJ9lFHm4pxXSleE1j+jaf0ts71qScvh6k9O/EyMHLNfvM2BoRvbCPxO+Enc+diE+
         y3q2g5xjqudT9350Zq4Znny0F47mWFjmWZ4KrMgJu3yAYlYZfO68/Qv9klDvpFike+Pz
         tjQ7sI+JQ02o363nEqwsdCENhVB4CxgMYpnzcuyWWSmz/5SsEZy5w4LXPDCk4//610vX
         LuTXBDifh18wSPLGiH9s+NGhh5cs/qJ1F35x/oCxnL9Oiu/IxP2WhZEdw3vXY9w7V3u6
         Ov0gyyVkcyKZkrceJ/G0fOkNtkj+I889im2Rowvt6+bdIEUiYKBQpwEz8K6hKRpXhSZ6
         9+Cw==
X-Gm-Message-State: AOAM533UCHtbh+EkC4dmO+67W7teJJoFXpa4NCktxRAQHKiWcZaQc9mY
        xthOs3DwM//e7TAi98EvHgxrz/mAy6wBfb1fUrl/UuvSBlEEnuVEX/V7kOaxFpoIQzDHBOKF0qC
        woJKwVd4cO+vaBDXxTaCMpxE48A==
X-Received: by 2002:ac8:4793:: with SMTP id k19mr453041qtq.373.1619126330843;
        Thu, 22 Apr 2021 14:18:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPK39d5FeudQjLH1XVuvAUd8EB5opbfb/Nov9VNsvcjW/X3rbs5nsCsgqxO6li0RTX/w4dHA==
X-Received: by 2002:ac8:4793:: with SMTP id k19mr453015qtq.373.1619126330602;
        Thu, 22 Apr 2021 14:18:50 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id g135sm3084697qke.8.2021.04.22.14.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 14:18:49 -0700 (PDT)
Date:   Thu, 22 Apr 2021 17:18:47 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 03/10] userfaultfd/shmem: support UFFDIO_CONTINUE for
 shmem
Message-ID: <20210422211847.GF6404@xz-x1>
References: <20210420220804.486803-1-axelrasmussen@google.com>
 <20210420220804.486803-4-axelrasmussen@google.com>
 <CAJHvVchQk1zrgah08n_P3sHUVzQLZUXHSMbkpd9rG-w5jUGNdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVchQk1zrgah08n_P3sHUVzQLZUXHSMbkpd9rG-w5jUGNdw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Axel,

On Thu, Apr 22, 2021 at 01:22:02PM -0700, Axel Rasmussen wrote:
> > +       if (page_in_cache)
> > +               page_add_file_rmap(page, false);
> > +       else
> > +               page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
> > +
> > +       /*
> > +        * Must happen after rmap, as mm_counter() checks mapping (via
> > +        * PageAnon()), which is set by __page_set_anon_rmap().
> > +        */
> > +       inc_mm_counter(dst_mm, mm_counter(page));
> 
> Actually, I've noticed that this is still slightly incorrect.
> 
> As Hugh pointed out, this works for the anon case, because
> page_add_new_anon_rmap() sets page->mapping.
> 
> But for the page_in_cache case, it doesn't work: unlike its anon
> counterpart, page_add_file_rmap() *does not* set page->mapping.

If it's already in the page cache, shouldn't it be set already in e.g. one
previous call to shmem_add_to_page_cache()?  Thanks,

-- 
Peter Xu

