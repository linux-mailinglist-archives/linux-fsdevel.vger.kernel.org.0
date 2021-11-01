Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467CC441DF4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 17:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhKAQV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 12:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232655AbhKAQV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635783562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C05du9bq5580dSm6IfhlDVs1xfqwhE2XhWSAZIf2yew=;
        b=ioV3bcGv85AIWOyDAkvGTS2TjAGuZiacWuWeZda+/ETDMsG5qLftSzKgmpK4q7FS2Umsnf
        OuoVbJYNu0QBQKDOLBcLohvnvmr9NWJFWEYFcXZ9DiQb5Vo6bNW/Ia5YX9AjfY0Qa//PCi
        FpPo81IXuUBBkxwQAldvhalUJRAF/xs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-8uxZ5PCqMG2HTnidc5CgSw-1; Mon, 01 Nov 2021 12:19:21 -0400
X-MC-Unique: 8uxZ5PCqMG2HTnidc5CgSw-1
Received: by mail-qk1-f199.google.com with SMTP id t15-20020a05620a450f00b0046325fa7b93so2573784qkp.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Nov 2021 09:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C05du9bq5580dSm6IfhlDVs1xfqwhE2XhWSAZIf2yew=;
        b=UZez3aE0gBf3s4LnDJpUS5brdOJfM3Dy/X3XblVbPEzMEUvl8BiXlFyfYEslsN/gq2
         8ZmVqvnsgI4rPlIRlO7yRUzZcV4CiW/5/HsEzrJvArHr+JIEbvAYYAS7DNFICMSUqLEV
         7X0Lo2e03eRYU77B3lXYEQpgE0kkpTatM7o3SHne8AAv04jToI47wfQVW48SsOBTDKTm
         gmJDNNcpFUr3lDVBSqyngHfK0NEpfvi99NVG6yXyETfWl9Ojc8L5a3yOPnougN23NCzs
         UhBWnJ60OcoUYpDALALyRO+Fzl2SpnrcMuB9gSkUArphGoZ1Y6iH0LA/FByUiZIWwriW
         DP2Q==
X-Gm-Message-State: AOAM531ESV0zWqO5z4pqtFxaMPqKZwklidKsLRZJBN5h6LuUu9MPdrO5
        vXU9Uxszh8/AZeovar2eyfF1CbR+/RuyOyFZLG2rNJ+iTWQrg7XNqGfhyn3L/GFoWW9mXQ4mj+Z
        JWiOvrHImQrWwmC+2Buu9DpUK
X-Received: by 2002:a0c:b341:: with SMTP id a1mr28270551qvf.21.1635783560973;
        Mon, 01 Nov 2021 09:19:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvmIEea110PcdB5LDCY7U1ej3BdqkCE7DUWVGoDnBFq+m2W3EEPnU5Ptqvnzv3GNnSJbsMew==
X-Received: by 2002:a0c:b341:: with SMTP id a1mr28270537qvf.21.1635783560844;
        Mon, 01 Nov 2021 09:19:20 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id g8sm1775746qko.27.2021.11.01.09.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:19:20 -0700 (PDT)
Date:   Mon, 1 Nov 2021 12:19:19 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 09/11] dm-log-writes: add a log_writes_dax_pgoff helper
Message-ID: <YYATh6yxGehyjpcm@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-10-hch@lst.de>
 <CAPcyv4iaUPEo73+KsBdYhM72WqKqJpshL-YU_iWoujk5jNUhmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iaUPEo73+KsBdYhM72WqKqJpshL-YU_iWoujk5jNUhmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27 2021 at  9:36P -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Add a helper to perform the entire remapping for DAX accesses.  This
> > helper open codes bdev_dax_pgoff given that the alignment checks have
> > already been done by the submitting file system and don't need to be
> > repeated.
> 
> Looks good.
> 
> Mike, ack?
> 

Acked-by: Mike Snitzer <snitzer@redhat.com>

