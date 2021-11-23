Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493CD459A9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 04:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhKWDoV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 22:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbhKWDoU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 22:44:20 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43072C061714
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 19:41:13 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso1710581pjb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 19:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuisy9zT1caIpoCJEL+LfomruK38WXIi70xmI7lYDdI=;
        b=Y08/be2uy1a6FHo2yuq5V6dIERIFe+eeTyXLXTKFjFxfAYARUBwDdqRv9XulygxcF5
         4zZfKtYGqV6eckQSPyIqI+Gn3GMQFWIP9FXR6DHHwN+9GDnZm18bVZGFa88rvhT3Zhp8
         eBxG8SJu0LWqmuhUvXdN5Q8E0N7Fv2c7+1ZOSnPpTxrI3q5JIXNMGFvAj0k+TWuhQgQG
         tLoyO8DVm7L0ndxV5dBnp+whJ587dE90ANm0vqzPKJbxSHtsEtd3ERFpgMcAPItk+09G
         dbm69RRAjzWoV6a6vlvEHV0tkZfEJqiOGj5p0uoKbINk6WBGJnIFfCSAm3gIT8TG78mL
         kVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuisy9zT1caIpoCJEL+LfomruK38WXIi70xmI7lYDdI=;
        b=MVkkHUVWKdwaUHC/okX60kchjeYyijxRtVGWSRDyGrqZNijgGAUmAXqd0BOz0kUbQF
         wTG4Btpkmg/ekJHV+cA4h/jOAGil9rLUrQTRBuUZObUWGnna5Y55scUP2kuYhgKBN5C0
         yi9Od9Z3NTK831ysqJo5YwgwHHV3SsFTjxic5xXh4z0jIZHXaB5I8Hl0K2DVGxUECzHy
         GGdWaxXQwJ/bIh0I7VuVuueQ4atFQIUUzSWrumTYRjFMFTx4uJqe6+X1dScZ+7KEncwo
         xAZB++so76U6lYc7hjrXR4zQ+CB6chlCbI8dUmIUH4+vv7GSIB2CEX3CaStE8D/tG8hT
         uflw==
X-Gm-Message-State: AOAM532JitLZWBMC7pbXgUn4VfHqBfPfM64XplUuY9BPTT73qsY/Imxw
        vD5XC/3zxW+vkTqHUJody4Y74n3ATRWaTPRRgHJamQ==
X-Google-Smtp-Source: ABdhPJwgBzEQtBEEt5JgwawqvX/CZbZsaXh/qAQWeeflxeagBI6MsJ+fyqKdfOXHrkiL5G4d5gMRZlq/mNM2Mj9gTds=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr2525502pjb.93.1637638872640;
 Mon, 22 Nov 2021 19:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-7-hch@lst.de>
In-Reply-To: <20211109083309.584081-7-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Nov 2021 19:41:01 -0800
Message-ID: <CAPcyv4imYR=NLizABpZA+gKH+amNQ6jcVNQhtF+1jyevdWzmBw@mail.gmail.com>
Subject: Re: [PATCH 06/29] dax: move the partition alignment check into fs_dax_get_by_bdev
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
> fs_dax_get_by_bdev is the primary interface to find a dax device for a
> block device, so move the partition alignment check there instead of
> wiring it up through ->dax_supported.
>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
