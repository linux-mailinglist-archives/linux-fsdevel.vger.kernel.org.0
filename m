Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC3145AE24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 22:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbhKWVTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 16:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhKWVTM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:19:12 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF7CC061714
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 13:16:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v23so534024pjr.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 13:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+zpQrvL4Qxe/qyBBz6nO1x+ZudVJHE22cDmvcF/TOE=;
        b=3UTjzt/B58bzUMuj7IqqMnaCu5WYQAV5rK+fs5kaCfP78gUwTgy5Zlf3Be+wmIjr56
         TnFB+KlAOrzucg0BEhVOP/JXfiAUD2ftEQJXj4AikeXTgWe03Spusb/0TUld0hhFX8v6
         hoRoYhcMIe1fJGrizIl0u8fu7pfvZl0yQ6G/HZ/XblMR0kOZLIsIbaNzfqww2OtwK0QY
         M2kpeuFwFxk8ZGruQVPxMGdqTXvMTUs/jjMoa2NVuNjPrbZJxiRI6LrTQ3lIM/koJIif
         rP8I79qIKGLZ1fswpluH9sZNHRVBAzv8KTrCcmchw/ruDBCNrZVPKtgfRhQ9/KytnoiJ
         mPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+zpQrvL4Qxe/qyBBz6nO1x+ZudVJHE22cDmvcF/TOE=;
        b=T1pDdF6N1qJsYNYWcav2VIF8xCryA4y16yBHpsrfDGdnRARyA0FKLROChnOiE06Y/g
         i9I2jGlsiXZJaLl0q9HJdUC/ADbquPTN+7Z0VvRuZ+26RLyS9UEFQMsBkxRMVyZj4S3V
         n9tjh7y3kLl56BtFpLWj5tcbt8G+BrTJI6bSf2WuqY5G/C2qYg2VXexDjg3khNlWmY1T
         jeF9CVBVenXywwdWjm0M+2pxzCsGf03iRI1bHAIzp7qGppGAv4p77Ti1Vfxl/MBx81Cw
         zzLr05BHbLNE97yGYgsun83aDQtXkewuV/mMTTMdl9kcELVd3GHPMFVpRu47bMinweka
         cAfw==
X-Gm-Message-State: AOAM5311v/dRkmjAgiXgO6dPRItWC2Zor3TJ3itxtC37yc5quSgGbWiK
        WR2OnhvS8hhWqAug1XCGxh3zeSowNpyV3srj0hk2xg==
X-Google-Smtp-Source: ABdhPJxRRlv0NZQorv0M5t2wTRvBAaxVZY2wmbRu89506wlORAkd8KhXvCTyC5EAm4rzXSOWToX/mEdJ14fdPpKfw3k=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr494044pjb.93.1637702163126;
 Tue, 23 Nov 2021 13:16:03 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-16-hch@lst.de>
In-Reply-To: <20211109083309.584081-16-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 13:15:52 -0800
Message-ID: <CAPcyv4jDqfNj4iAYoewj53QEZjXR41UuE0LN49CtC_2qjrbazg@mail.gmail.com>
Subject: Re: [PATCH 15/29] xfs: add xfs_zero_range and xfs_truncate_page helpers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>
> Add helpers to prepare for using different DAX operations.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> [hch: split from a larger patch + slight cleanups]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
