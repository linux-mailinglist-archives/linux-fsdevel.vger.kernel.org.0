Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6472441DE7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 17:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhKAQV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 12:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232641AbhKAQV0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635783533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+PlMFyDlSdyotYZmkf9Kx/3zxEQEZ+hPS+mrYwQmhsg=;
        b=EW0fz8Qe+ut9KmyCoRnOsO+APBwR60Zxa92KxIOw0e3QnKU/DslfH1ELoHiVCkefhnbYEu
        QOheCjtisgQ1WDDVDdsZ6TkXRMXrhS8S5d86zD8pYK3L36Z6H1AbIQBLv7Ig/obIp6gM7b
        CYbnS/lTZusUX2RMuk9U17L7r0fDKrA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-TL2djzW7ObC36CdKvTU_5w-1; Mon, 01 Nov 2021 12:18:52 -0400
X-MC-Unique: TL2djzW7ObC36CdKvTU_5w-1
Received: by mail-qt1-f199.google.com with SMTP id 100-20020aed30ed000000b002a6b3dc6465so12394901qtf.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Nov 2021 09:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+PlMFyDlSdyotYZmkf9Kx/3zxEQEZ+hPS+mrYwQmhsg=;
        b=uyY7BgqzYVkq984j39vSQ77JDwSns9l2WNfTddnwTYexMLZu2FfSL2ESQuyIp+JWBw
         hJSVXj4MO/gcCNH0HQ2BvHsYc8YYsa81b5b1TGVW8o+u6YIz2BfemPf6PlivuWmpw3Zw
         mvx4K4cBgY0fhWXykzzwI+T7HugLgLX7d69p3zOv2Wb6t6ZJZnd7DNez2ENxk2DQtRxU
         zEuhSHuRjWW9cBrwpgEVZkvjIKNJQgf/Eb4Hps3x8zpDONQliZtLUk3Lo7yVv+E6fgrs
         kXWjbg4x2zO3NwulpIpYXBCibx0CeZzHRaVO3eNWQlKipsZrJujpgrl+q2Wdp0YWmlHJ
         cW4Q==
X-Gm-Message-State: AOAM533svxoLaantXDizh858O3G/XcwKf6cdYDi423hR2Vy5lkVJ3+TE
        5pwpIKZkyFSawP3vfEXpX5++CLLn/RaK0Ar3feBRCHA/QIbOTl60CIEMf7DHcpG0S0ZmYKLpXW4
        9HrOd2M0/ekjZC4dCKJ/EFzRC
X-Received: by 2002:ac8:183:: with SMTP id x3mr31456931qtf.270.1635783531653;
        Mon, 01 Nov 2021 09:18:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx06c4hivJwjfQA8DeAKPNXipJ/hNPI/8Dli7abowyJqKsKBWURc5Mk5ISYlLWlJ3N1kL0ucw==
X-Received: by 2002:ac8:183:: with SMTP id x3mr31456902qtf.270.1635783531462;
        Mon, 01 Nov 2021 09:18:51 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id q20sm10701041qkl.53.2021.11.01.09.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:18:51 -0700 (PDT)
Date:   Mon, 1 Nov 2021 12:18:50 -0400
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
Subject: Re: [PATCH 08/11] dm-linear: add a linear_dax_pgoff helper
Message-ID: <YYATamEnd6imRSxt@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-9-hch@lst.de>
 <CAPcyv4iK-Op9Nxoq91YLv0aRj6PkGF64UY0Z_kfovF0cpuJ_JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iK-Op9Nxoq91YLv0aRj6PkGF64UY0Z_kfovF0cpuJ_JQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27 2021 at  9:32P -0400,
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

Acked-by: Mike Snitzer <snitzer@redhat.com>

