Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DA3457559
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 18:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbhKSRYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 12:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbhKSRYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:24:22 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A859C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 09:21:20 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id x7so8470909pjn.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 09:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2U/4HYKnAZR7qNMIeDCg5S//595luEluzFk14uv4gBU=;
        b=FQ6M7eMMvPf80QsdTpoBZi0VrX8bn7QeX7OvbRABdgkNvCMNjXzl7/FKjSfSUjRkzX
         F1usfPnFQYNtajLRg0QRwSSgzt8mzXj0XCG2cnk0+F0m/6Zhw3KmrGwYuAHqWjDxU8h7
         LoqDBYl4kQUeXb8kAZzT8ViJ+hkv5vLV1Goy6Yaluym7CVIoftX3Jldatma/nAYXl27p
         pclrbJHG5C0Blu/232w4rLGJUG53x/PsyFdu4/UMHnSQZ8XMlr5FFqwE0la2E0Wy9pBi
         QLaClBcQjJDmbuAEv+kCOvcY8AEg2J0pE5d377NWsFamWj8v0zJjbYMN2j8PjhK8WH2h
         Pe+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2U/4HYKnAZR7qNMIeDCg5S//595luEluzFk14uv4gBU=;
        b=efJCevmjn/YXl4wWSZFthu55LblPHWg9sDPDB7HGbUNuBa7VEYkf0KPmj9isoNJhW6
         UMfdBK8bU47FuqxonTnpAvaGWJ1VNIZggKQ+IIa3PGb1e3Ap/gKuk+YxWsh30mHmsADO
         lqnbfvKrKdQrme/8EyNNer4tkOkSTFoNn7WZZvP2KT0Ptw+YZ6bvbSKeYwxjvwiOFUYw
         iQIb62wWrRD/JSyV94F+JgBozP5tguV8FJVNfOV7zL09ImO5G5/Awn4SKaB4hxDav8F+
         kn2PwqSBnCclWlh3KARzTnfDXguk8JrBqq2OhhCMEEU97xELX4lHgBhPJdRpVE1d5nFK
         f1OA==
X-Gm-Message-State: AOAM533PtlTaZ1EV3KhY5BocCMy4kNPbnBXncBYX5wuwqk7Si2+DdsCV
        +YBcpCv7b0EigzlR6JvN+itz1YbuoJ0ivvevx+HkLg==
X-Google-Smtp-Source: ABdhPJxOTsb7kpZ1mbQBZyHvrw/GjkoPNdlC1Mnmi7QTa5v33P77eZ447VYbGdz8Hsj3aBiYzZhGTejFWOktm98P3BA=
X-Received: by 2002:a17:90b:1e49:: with SMTP id pi9mr1505670pjb.220.1637342480174;
 Fri, 19 Nov 2021 09:21:20 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-2-hch@lst.de>
 <CAPcyv4ijKTcABMs2tZEuPWo1WDOux+4XWN=DNF5v8SrQRSbfDg@mail.gmail.com> <20211119065645.GB15524@lst.de>
In-Reply-To: <20211119065645.GB15524@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 19 Nov 2021 09:21:09 -0800
Message-ID: <CAPcyv4iFG0n-vdaEi4h5ken6mPrgW6Kz6UXCTRfaHi-c99GBnw@mail.gmail.com>
Subject: Re: [PATCH 01/29] nvdimm/pmem: move dax_attribute_group from dax to pmem
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 18, 2021 at 10:56 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Nov 17, 2021 at 09:44:25AM -0800, Dan Williams wrote:
> > On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > dax_attribute_group is only used by the pmem driver, and can avoid the
> > > completely pointless lookup by the disk name if moved there.  This
> > > leaves just a single caller of dax_get_by_host, so move dax_get_by_host
> > > into the same ifdef block as that caller.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > Link: https://lore.kernel.org/r/20210922173431.2454024-3-hch@lst.de
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
> > This one already made v5.16-rc1.
>
> Yes, but 5.16-rc1 did not exist yet when I pointed the series.
>
> Note that the series also has a conflict against 5.16-rc1 in pmem.c,
> and buildbot pointed out the file systems need explicit dax.h
> includes in a few files for some configurations.
>
> The current branch is here, I just did not bother to repost without
> any comments:
>
>    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dax-block-cleanup
>
> no functional changes.

Do you just want to send me a pull request after you add all the acks?
