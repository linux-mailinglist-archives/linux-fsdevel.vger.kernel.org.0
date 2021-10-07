Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C30B425776
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 18:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbhJGQQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 12:16:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233308AbhJGQQL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633623257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pRgvQy7zCNT4x1FLGa0VFDNRf/XMV/VudzeiNbniOTk=;
        b=bhdP2rApNJjsDWjBcUEyl7K7PbR26djJVQ4rZJFGcS98tauEWurxbGDn8x0c8CUSaDDs93
        TAPKbHzYuXbivy2y6paiChaKJCs/8sFph1OP0Ne8WkO34mpD6ChaLQ43dawtVu4mhnI453
        Wnu7fIU7YHP4mzUkuPdJuTf0IBSAWHU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-Alup9hV9PoKqjeSQ-Sk0sg-1; Thu, 07 Oct 2021 12:14:16 -0400
X-MC-Unique: Alup9hV9PoKqjeSQ-Sk0sg-1
Received: by mail-qk1-f198.google.com with SMTP id b189-20020a3799c6000000b0045eb0c29072so5591521qke.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 09:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pRgvQy7zCNT4x1FLGa0VFDNRf/XMV/VudzeiNbniOTk=;
        b=pjPa9OcjuQ0T74UC5ht5GvD6NDGb2kpb0Pqx73h6dNhhjItiDivmfQEOHxwuOr37e4
         6q8AZH3l1G3wkEL7qh9vnANJ23qq10EAZiLzgd9JKXAN69BrHAxMzCJXwf6vuPKr1CFy
         jTTj8Bv3RT/k55bxfRIjS8svrqVAfrFuMEPHOt6YhM8Ke3qU9YxXHjxo3/CANBrlJWY8
         GJ+uTPKikaBZtF9T1K54cnmVGlt4yKv8jBShqeiXqUaF2DPc9l1WLS0j0B16n/SmQPRZ
         4i1kPlh9aa9My2u2m5cXy/rU0xAfOYCPGh56rZx2xvzN1j6vaQyIi4vlstH8S53jVCwo
         /SWg==
X-Gm-Message-State: AOAM533+2CO14CnMWVgRysQQhu0gJpBDg4HYWOoLvrjN8FH8BKPyfGzN
        aF70sX5sv+9qy1fk8FcJ6FXiqEwafOa3kjMkSO123+CTpNh7ZJl1qOMAgGDk8E/ktinGvrxA6CO
        DzyPad1lCSUmUc4S18tGtAAnvSg==
X-Received: by 2002:a05:620a:1677:: with SMTP id d23mr4266623qko.327.1633623255961;
        Thu, 07 Oct 2021 09:14:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRhDipkWMKBlUwNt0I0VU8YiJcFyvPa0zwdSqGd/2TPm7Sb3wfxySQ+irOIRCQ5YvPvWvFvQ==
X-Received: by 2002:a05:620a:1677:: with SMTP id d23mr4266603qko.327.1633623255749;
        Thu, 07 Oct 2021 09:14:15 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::bed8])
        by smtp.gmail.com with ESMTPSA id i18sm16970001qtx.60.2021.10.07.09.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 09:14:15 -0700 (PDT)
Date:   Thu, 7 Oct 2021 12:14:13 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
Message-ID: <YV8c1ZoMveUUlG+v@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
 <20211004140637.qejvenbkmrulqdno@box.shutemov.name>
 <CAHbLzkp5d_j97MizSFCgfnHQj_tUQuHJqxWtrvRo_0kZMKCgtA@mail.gmail.com>
 <20211004194130.6hdzanjl2e2np4we@box.shutemov.name>
 <CAHbLzkqcrGCksMXbW5p75ZK2ODv4bLcdQWs7Jz0NG4-=5N20zw@mail.gmail.com>
 <YV3+6K3uupLit3aH@t490s>
 <CAHbLzkpWSM_HvCmgaLd748BLcmZ3cnDRQ577o_U+qDi1iSK3Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkpWSM_HvCmgaLd748BLcmZ3cnDRQ577o_U+qDi1iSK3Og@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 06, 2021 at 04:41:35PM -0700, Yang Shi wrote:
> > Or maybe we just don't touch it until there's need for a functional change?  I
> > feel it a pity to lose the git blame info for reindent-only patches, but no
> > strong opinion, because I know many people don't think the same and I'm fine
> > with either ways.
> 
> TBH I really don't think keeping old "git blame" info should be an
> excuse to avoid any coding style cleanup.

Sure.

> 
> >
> > Another side note: perhaps a comment above pageflags enum on PG_has_hwpoisoned
> > would be nice?  I saw that we've got a bunch of those already.
> 
> I was thinking about that, but it seems PG_double_map doesn't have
> comment there either so I didn't add.

IMHO that means we may just need even more documentations? :)

I won't ask for documenting doublemap bit in this series, but I just don't
think it's a good excuse to not provide documentations if we still can.
Especially to me PageHasHwpoisoned looks really so like PageHwpoisoned, so
it'll be still very nice to have some good document along with the patch it's
introduced.

Thanks,

-- 
Peter Xu

