Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC76454C59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 18:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbhKQRri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 12:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239566AbhKQRrh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:47:37 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3134DC061764
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 09:44:39 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c4so3377969pfj.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 09:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+uFdsysPKBJg8+GUKCjjrR+fu42d0RKVIlJ5p5O3Gqw=;
        b=AhgC+2wjkr5d9yDLbCved4jaDjwAVOHHegPWWTmEA1k+UoMOMYjm4jdejJ0FNzHR6s
         c5CZZTpF5RcDbQWqOsFLQ+5n3WzHTDlujVf/JCPu7XZBET18Z8qLE0BanPT0rnfK5Zu9
         KyIvCY0B/udnAqmbfZZUOtpDWwYOaZvFxMVOaWJLK5nqRMnfBvKrqK4xPQYQJSiLOVa8
         0rlfBALzCZrz1lMqwQv6qq3GRi5Jd7hsx8WgDG14wOcf8TDRiDnZ6oCTTfiQ53aT4YRB
         Vf3FTTZZnWUbXVIHLEPwTQXniddBnZWJsqT6SgaoHFJDwC1BLNE6VpCGlp3JGhptmlcC
         V9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+uFdsysPKBJg8+GUKCjjrR+fu42d0RKVIlJ5p5O3Gqw=;
        b=FZgDb8cQNeXpWbuQLNu8iJBUOLAv7/efRiRR6WpknKjoRi2dxVdIFxDtCfvnno99YY
         nHxR3Q/ERAx9ls9ffPyhykoUICBYlBkyALNjYn5cRstLuxFTfc5QcCuHkwauF1dUDGkD
         UTe2vJtIytOh2O7HGPtDdUvnULQN2dQHievnOYhgB8JifWmiazDdYyVjF2NDPxsxbvok
         kvADgX874i6zaJfg13mB9PY078q/2y8zYEO55mh+Xy5g5GPe0+b/jPEYPBLYe+zFL+N0
         9AlfEUPO2+yVo8NMkjThyWOP9A5RkqLASBX8XODfG3LK5evxly+/otO6Fa6md80U1Vut
         GWkA==
X-Gm-Message-State: AOAM531OIRSAm56w3rG1/1mCHzCopY0+z9w+QujngOT/kxyuFV9S6XPf
        mRW2FqB6IR9K3NjCCilPZGz7QCdsLzohMoSN9SBxYw==
X-Google-Smtp-Source: ABdhPJxiiB8Ak1RjXFinVMdC+8Tb3rrtEkfJ8k6NlxRhm42dcgWCdDR0kkUYUFwrF8G9DBBrfo1Xmvo4+uUGPt+QmE4=
X-Received: by 2002:aa7:8d0a:0:b0:4a2:82d7:1695 with SMTP id
 j10-20020aa78d0a000000b004a282d71695mr37260918pfe.86.1637171078758; Wed, 17
 Nov 2021 09:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-2-hch@lst.de>
In-Reply-To: <20211109083309.584081-2-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Nov 2021 09:44:25 -0800
Message-ID: <CAPcyv4ijKTcABMs2tZEuPWo1WDOux+4XWN=DNF5v8SrQRSbfDg@mail.gmail.com>
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

On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> dax_attribute_group is only used by the pmem driver, and can avoid the
> completely pointless lookup by the disk name if moved there.  This
> leaves just a single caller of dax_get_by_host, so move dax_get_by_host
> into the same ifdef block as that caller.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Link: https://lore.kernel.org/r/20210922173431.2454024-3-hch@lst.de
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

This one already made v5.16-rc1.
