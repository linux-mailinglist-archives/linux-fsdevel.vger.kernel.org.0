Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3784E3F52BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 23:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhHWVVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 17:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhHWVVE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 17:21:04 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640CEC061757
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 14:20:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j4-20020a17090a734400b0018f6dd1ec97so872403pjs.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Tta22g6TzCbS8+A5F3hRnTInZTNETaE2nytspmuyiI=;
        b=WmkNeRi7tFECQpCdiAmGDL4hHYzV9+5I3fYvoUDlepLk2e1dCoJMI6zB/qrgiW/KA8
         tjlG4bLQMDL/lTTTfR20oVNEgEEZ9SZi71LCMKYLmB9l7o0IKWQV3x99rHH9jrOdt/aQ
         KvCTbbVrru40KnJ4Ss45A2n6Y2tle0h2j1Fyp9R/qhfGrgpEmPMaySRW6/mu3K7iVXr5
         PxzRBeLG0yaFZc9b/9i/1w066LgdKUZn7jriSCoN6lLiH0EHg9NWUBuRKhMrDkvqUavH
         1ra/FqSzDumL4aMl8uZzZVoN/2mdgv0SPsnRwIrftWCnmVtCvSYcmYp/HvEhrMhW4u3g
         nk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Tta22g6TzCbS8+A5F3hRnTInZTNETaE2nytspmuyiI=;
        b=sNsK8A5xZc01D5SLH2RhAmzLRS8+gRbcRoozqPRDsHAmC605zDVm3fIlwoKRHCejbS
         2mtiY7O7a4mVBDh2AmYugceSp3UJt4VNL1X43N9BBC0fv8cXS/1sObDaWxEN3EbWnjOB
         MliXEAj2Wrjbb+/0yqa41I9ydiCtTmJGCVHKgAA3fJ65lTzxCIPGPvmZxdXQOGP/RPHU
         nY2hycungenPXj/ndF/MbAf2TrZp/X4QfmGFRXxn3fAhbK6TroTodcOXLGaD5WBNAJ+O
         +ckRtSTwnCr4tSCZoE+aQg3ntrq6HWfW9z8Fahu2b4H+HK9y/lG1e23IJPnSstxQ6aEE
         vOiQ==
X-Gm-Message-State: AOAM530jMwcPFuoErWj14/L7jJtSKpmQPwDMlJbD1byFKve6uufGtIcd
        gF7Ftu8fG8Gx4pMHeQf9QlE7JCrz48nlBO/ULAbD7A==
X-Google-Smtp-Source: ABdhPJzdZDOlIEIUdEe/koFlzTPnIhrvJ+LvlXLPoKCXM8QxzZFIYVnDFkM1MxM7I34jVCC/VnQMg8JkpWiv08lsQpo=
X-Received: by 2002:a17:90b:23d6:: with SMTP id md22mr532829pjb.149.1629753620957;
 Mon, 23 Aug 2021 14:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210823123516.969486-1-hch@lst.de> <20210823123516.969486-9-hch@lst.de>
In-Reply-To: <20210823123516.969486-9-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Aug 2021 14:20:10 -0700
Message-ID: <CAPcyv4jR7U2N0-fFE8FUL+fNdY+6f=FNs7ex56F5tsLztA_GJA@mail.gmail.com>
Subject: Re: [PATCH 8/9] xfs: factor out a xfs_buftarg_is_dax helper
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 23, 2021 at 5:44 AM Christoph Hellwig <hch@lst.de> wrote:
>

I wouldn't mind adding:

"In support of a future change to kill bdev_dax_supported() first move
its usage to a helper."

...but either way:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
