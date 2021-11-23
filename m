Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B5045AEA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 22:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbhKWVvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 16:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239075AbhKWVvo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:51:44 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212E8C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 13:48:34 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so491776pjb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 13:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYkPf9vJ648gXjsCEnGEexU4+Ifkiqg1wwbcGn6CCJ4=;
        b=VQApAlcktwMcpaq5jFhkMxeNGyvexkKC3i6bBW7J48mF8DsF1/7CQAqKNzOE+eTccI
         MukZz7spVxbYqcrXVw8V1NPJ/pO4n52l7m+S0Ph4Ybr+mw2kgqAqtZa3pLex/+BZstf8
         /wFsj02Qj6TChPn0/3voEI1RYYWUipBK72irmVx+QhYrnrndgBztGcQeijJ0cPmWiSB8
         zysPKFzjgdDt9boZOOp48eyCMBg3PV9MBTwiNrvClt0hBzUO02OKjJgpyz/mrusiP8R+
         CYs52zo3lmHwTSmYl1Jahz6zyoWzMdW1LqR6lyuLMEqjEjPScDcZZh/xx6IU/yB7SEwD
         h9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYkPf9vJ648gXjsCEnGEexU4+Ifkiqg1wwbcGn6CCJ4=;
        b=KUJa9i1qkA5BXd8Ph2/KYrZFSmx/Tu6q+ppPUqyJktL6u0TMD/5rS608FuVmOJaOsI
         H4i2/C4MYGaUcaly0E8VLMxa3iJIWvQUZy3/g32zfttsJ8Aynpqc1hkC8tWzbolT3q5z
         Cevj04t4mK4WCWd7JZCVoZlzQBn/09gA1m0847VUjLEGEL1znaMfUYWSizDMTcABJXnt
         lF9SZ7WNrWyDAuovW6/Hn87VYtauk6sL3P8yn7q/wX/lVL9jxAf7WZHEiOw+vo54QDK6
         uU1wSRrl2ZOQnX5M8YsZssRhLdIZ2+a0JR35HwQgSRQKtbTCKUawCiWO2vQy+fuapNTV
         OfkA==
X-Gm-Message-State: AOAM531BMbTHWRgpmjnzvD8UdayNYqbknWNWTb1yZU70yRWYA+1mX66P
        X0iBhySZGcrlmRZutbW5RAr1OuQfLIqCOSZus9yGng==
X-Google-Smtp-Source: ABdhPJyT9foSDeohZagrJ9StTFco2dwZgw3K6Q2oNHo7YSNAudlmobBOmJCjxwVnaF6MiMXxVYrJ5EOKlp8j1MbCkKE=
X-Received: by 2002:a17:90a:e7ca:: with SMTP id kb10mr7435174pjb.8.1637704113737;
 Tue, 23 Nov 2021 13:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-20-hch@lst.de>
In-Reply-To: <20211109083309.584081-20-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 13:48:23 -0800
Message-ID: <CAPcyv4isfhSxr+MJnw2UBCFN_3_dCzwAjJERHzycnR5Ncy2RQQ@mail.gmail.com>
Subject: Re: [PATCH 19/29] ext2: cleanup the dax handling in ext2_fill_super
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

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Only call fs_dax_get_by_bdev once the sbi has been allocated and remove
> the need for the dax_dev local variable.

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
