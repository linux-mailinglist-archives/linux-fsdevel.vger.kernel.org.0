Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEFF3F8BB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 18:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243068AbhHZQUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 12:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243015AbhHZQUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629994796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7/3gAXjsOYCjvInZsh1tv7Gv6tJXcvyBWH3X0vwJBWc=;
        b=LnfkSJI5iWKHnrQvwUe0FSgO2T23xzPIkpupsN7Qngsl1Rpu1n8fSgHmpTCnRNC17MCIzT
        Ndyjr/cBU4bwY+dA7lb3J1o97zfhSKQLULx6We69blfEtDasTZrVcFy029/XMK+8W6x6Sw
        WETvhT3L1kkIHnzN4HHoYondmi/eQmg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-2a-fxPFJM0q9v4eo5Uf9zA-1; Thu, 26 Aug 2021 12:19:52 -0400
X-MC-Unique: 2a-fxPFJM0q9v4eo5Uf9zA-1
Received: by mail-qk1-f197.google.com with SMTP id 70-20020a370b49000000b003d2f5f0dcc6so432535qkl.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Aug 2021 09:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7/3gAXjsOYCjvInZsh1tv7Gv6tJXcvyBWH3X0vwJBWc=;
        b=IGVOGQ8Z7vylWSkZF6OaoTcvnD6yV17fCWfTuUTukWnkKCiHotHlMp/6rfHCL9JSmF
         cbKa7NqxaCxu/CvRAIkVDE6/QlzeY6HABWrpjUtMeg3KGDkWPTmq/YJvmFAHgYVfE7dC
         LObqpjF22qFgBhqS+VraEnBwGqVmnxT02rM0aitHeD4M2mPVzDHhEybQvbFzL+9sQ8vj
         neKTRpomV17JIRBb/E8REIeWZY/Syi+i9baDGlcQ+DIRCQQbD/FFvR403jy6LwldjjdZ
         xrJ5VsDORoqDVIreS463q3X28HVuZehEos336/f+QjVvMc9rA9GmUD6fAqocMzcLZZjL
         09kw==
X-Gm-Message-State: AOAM532YrXfNRnhu5efqz0jkrgZoYyq7EUGjBPaOLcvS7sxBX/se0C0U
        qiTcrVyutzU4ro9xvKe1JYbE3sc3VDbnvw/CR27fykxSyvNzT+DyQ8qNfa3X90S1ZkzD2TrHd4P
        WN1zzRfyGM6q6LJkeoW92KXSz
X-Received: by 2002:ac8:6697:: with SMTP id d23mr4123804qtp.34.1629994791990;
        Thu, 26 Aug 2021 09:19:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJjb+DXO5M4rPM3LGWmmf30ajsbDc366at2OsGm2R0vZu/YOovqERPcrnuHp7PIFCzTyaymQ==
X-Received: by 2002:ac8:6697:: with SMTP id d23mr4123780qtp.34.1629994791782;
        Thu, 26 Aug 2021 09:19:51 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id m8sm2619535qkk.130.2021.08.26.09.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 09:19:51 -0700 (PDT)
Date:   Thu, 26 Aug 2021 12:19:50 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 3/9] dm: use fs_dax_get_by_bdev instead of dax_get_by_host
Message-ID: <YSe/JtXqoiHsRGqX@redhat.com>
References: <20210826135510.6293-1-hch@lst.de>
 <20210826135510.6293-4-hch@lst.de>
 <CAPcyv4ieXdjgxE+PkcUjuL7vdcnQfXhb_1aG2YeLtX9BZWVQfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ieXdjgxE+PkcUjuL7vdcnQfXhb_1aG2YeLtX9BZWVQfQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 26 2021 at 10:42P -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Thu, Aug 26, 2021 at 6:59 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > There is no point in trying to finding the dax device if the DAX flag is
> > not set on the queue as none of the users of the device mapper exported
> > block devices could make use of the DAX capability.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/md/dm.c | 2 +-
> 
> Mike, any objections to me taking this through a dax branch?

No.

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

Thanks.

