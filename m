Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FB836CC75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 22:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbhD0Unj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 16:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236058AbhD0Unj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 16:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619556175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/RvrYyTMEiHtCZW0MwDUjdnqhLrqE4kTWBWaQVaWhX4=;
        b=awOqtIteh6TqjlK+T8wXD3Yc0T+VqvkVh0mPyvzpG/0l71Tvo16rfFhpU0tug2sbesA6Ub
        CFsAYAFIrr4eqFTkCUoAKlRF9ucclrFhXzMLpc2bBP18F7yM3whcAV4WvJPBbfOmBgXk4C
        4byWS8pd2Rs/CbQJX02CucKpeKvC0qw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-zLrm4deJN5G5t9v-k_spqg-1; Tue, 27 Apr 2021 16:42:53 -0400
X-MC-Unique: zLrm4deJN5G5t9v-k_spqg-1
Received: by mail-qk1-f197.google.com with SMTP id l19-20020a37f5130000b02902e3dc23dc92so19961532qkk.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 13:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/RvrYyTMEiHtCZW0MwDUjdnqhLrqE4kTWBWaQVaWhX4=;
        b=QpY4xd1GxqhqCSKe5FtKHxREZ7sczVKNUo6AKythUVW5402ccQYJ9Bz2IJUswDdq8a
         I5LCRJSkdftsZw+LgladA8SC3Th23+KMyryR844CYEB2ycfNRuy1GNUYhNCPQEelyQJg
         HHAoyxcuRFHRQoxGRDmxcCwCrVi9fGurlcljv/+AvT2GJYwVnaCMSM24Q2AjpyJaii+w
         meW5FwCjzphOBlS5fekoLDoLTdrDqawClO09N79jJfl3KapnMFgFsBDfR/uJYdxpeft8
         N/U0I7HdQ4YFJ+FDCKeegOCh6aSIsL5dRVInnd8ems8GYxZIdAf6nKMVxT4jR4SJ/rs7
         lkgw==
X-Gm-Message-State: AOAM5307NauKkzUL9YwuvrxBHdmYYqdsQLRgKdS3fRmnYtTWQgVKX+Zy
        6UTwTWwWzKt2NcpFDHHzgMrmhKnlepjw/ZfYCF6yTxdXdHbF387+v779oEf0EzuZUSDjEu0R5v0
        DaUs7iHzPIDhe7iQpFvYbq7Oywg==
X-Received: by 2002:a05:622a:11d1:: with SMTP id n17mr10557607qtk.360.1619556172936;
        Tue, 27 Apr 2021 13:42:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXdbR54zw+S/1LpL+C8ZvobC9U+08rm/wphtfr+XZ5o9lHGt3slPtEst+FHJjmjSso+DRu0w==
X-Received: by 2002:a05:622a:11d1:: with SMTP id n17mr10557577qtk.360.1619556172652;
        Tue, 27 Apr 2021 13:42:52 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id u126sm3664993qkd.80.2021.04.27.13.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 13:42:51 -0700 (PDT)
Date:   Tue, 27 Apr 2021 16:42:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20210427204250.GG6820@xz-x1>
References: <20210420220804.486803-1-axelrasmussen@google.com>
 <20210420220804.486803-4-axelrasmussen@google.com>
 <alpine.LSU.2.11.2104261906390.2998@eggly.anvils>
 <20210427155414.GB6820@xz-x1>
 <CAJHvVciNrE_F0B0nu=Mib6LhcFhL8+qgO-yiKNsJuBjOMkn5+g@mail.gmail.com>
 <20210427180314.GD6820@xz-x1>
 <CAJHvVciMU=TDGxArtEQSq3n5DCLfYNWh7bVX_8dQL_dht4Q73w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVciMU=TDGxArtEQSq3n5DCLfYNWh7bVX_8dQL_dht4Q73w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 01:29:14PM -0700, Axel Rasmussen wrote:
> On Tue, Apr 27, 2021 at 11:03 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Apr 27, 2021 at 09:57:16AM -0700, Axel Rasmussen wrote:
> > > I'd prefer to keep them separate, as they are not tiny patches (they
> > > are roughly +200/-150 each). And, they really are quite independent -
> > > at least in the sense that I can reorder them via rebase with no
> > > conflicts, and the code builds at each commit in either orientation. I
> > > think this implies they're easier to review separately, rather than
> > > squashed.
> > >
> > > I don't have a strong feeling about the order. I slightly prefer
> > > swapping them compared to this v4 series: first introduce minor
> > > faults, then introduce CONTINUE.
> > >
> > > Since Peter also has no strong opinion, and Hugh it sounds like you
> > > prefer it the other way around, I'll swap them as we had in some
> > > previous version of this series: first introduce minor faults, then
> > > introduce CONTINUE.
> >
> > Yes I have no strong opinion, but that's probably the least I prefer. :-)
> >
> > Because you'll declare UFFD_FEATURE_MINOR_SHMEM and enable this feature without
> > the feature being completely implemented (without UFFDIO_CONTINUE, it's not
> > complete since no one will be able to resolve that minor fault).
> >
> > Not a big deal anyway, but since we're at it... Basically I think three things
> > to do for minor shmem support:
> >
> >   (1) UFFDIO_CONTINUE (resolving path)
> >   (2) Handle fault path for shmem minor fault (faulting path)
> >   (3) Enablement of UFFD_FEATURE_MINOR_SHMEM (from which point, user can detect
> >       and enable it)
> >
> > I have no preference on how you'd like to merge these steps (right now you did
> > 1 first, then 2+3 later; or as Hugh suggested do 1+2+3 together), but I'd still
> > hope item 3 should always be the last, if possible...
> 
> In that case, I'll split the patch which adds the faulting path in
> two: add the faulting path hook and registration mode, and then in a
> separate commit advertise the feature flag as available.
> 
> Then I'll order them like so, which I think is the order Hugh finds
> more natural:
> 1. MInor fault registration / faulting path
> 2. CONTINUE ioctl to resolve the faults
> 3. Advertise the feature as supported
> 
> Sound okay?

Good to me, thanks Axel.

-- 
Peter Xu

