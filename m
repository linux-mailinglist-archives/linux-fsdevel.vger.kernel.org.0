Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D8C3F2288
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 23:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbhHSV4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 17:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbhHSV4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 17:56:38 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEBBC061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 14:56:01 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x16so6790432pfh.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 14:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHbvW6UqiCTsRu5vWaf3qnfqFYd/iOMYaaPDkT+6n4k=;
        b=ZLTPQExqKJd8DCa2TyoJWa3XCbsUacLbIOl9KO7oHTE83PBtwK+t7km4R6MNyOTtZi
         SGiazJQsLWTBM7iseMRbLEv2+SegAraOApUKlAGLUjfvHejA0A5vc+V43eVlFy+zTsB9
         uAqCX7733MC+5i3lIosErzuEMthhPZvXXXIps3cRSMnuY8yZIAognhi1QZyoospV8DJm
         t/NY95OUxhJS1NokUENvcK0ev6TDCli4oVp0HinstyrA6hMUnGw1zDIth8EtIHjUh9RH
         nocO/p/V7QFexAOb9XnyfxfhZntIFJ6OEIea2ekTSxFWpQuI9o54TR+ak8fpwuBHCRpl
         Q4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHbvW6UqiCTsRu5vWaf3qnfqFYd/iOMYaaPDkT+6n4k=;
        b=sXiw2171OP3hVTdaCAets+TksLp/1cvJqnLg5B7h1NtBzcvvU1NWe04EltB7FOEXTf
         HLPwUjC1PfWgduimnS/DRzGY8rMn66VxpNLYJE5CKLOi7UWcUcPMla5eU7W85IFovQ0Q
         mc3MgYIwAIo7MQID/9gXtirBxMf+3oDh0OHBQxM4s3jwZG6VyTxmYPlOQUeEsbl4pvda
         aScSo8r6o0PIyrMsSItW8Yq8acUK+0TBqc0bFcCjxvusEoAHsikripydic42kMOJCG6j
         +/GRQ969j+xwVvuNilBEPoBotuSViRvkJp1RYKdAsACdHyh/B1X7iTu9WoerZmO1/gAP
         7GJA==
X-Gm-Message-State: AOAM5339mphemAupRl6UtD/x0fyKrCaw9fVUVl/EN7IY+EXbKTZOB3/z
        r6zv+nKvbm7Yq+6IxUslr/0ccXnIK7F3RMEkeHK86g==
X-Google-Smtp-Source: ABdhPJy/B2hm2/hWvC7e67tV3MfHtjJtBBELucqps5FMrdqxqVA8mCj+nC4eNLvFYInr3AywzqexVgaoo2GPMcxThDI=
X-Received: by 2002:a63:311:: with SMTP id 17mr15684252pgd.450.1629410161397;
 Thu, 19 Aug 2021 14:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210809061244.1196573-1-hch@lst.de> <20210809061244.1196573-24-hch@lst.de>
In-Reply-To: <20210809061244.1196573-24-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 19 Aug 2021 14:55:50 -0700
Message-ID: <CAPcyv4jOh8qaTBVM5tRn1S1+Bp2QCW4eoj5Qi0xRw_EwJ0q0ww@mail.gmail.com>
Subject: Re: [PATCH 23/30] fsdax: switch dax_iomap_rw to use iomap_iter
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>, cluster-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 8, 2021 at 11:33 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Switch the dax_iomap_rw implementation to use iomap_iter.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c | 49 ++++++++++++++++++++++++-------------------------
>  1 file changed, 24 insertions(+), 25 deletions(-)

Looks straightforward,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
