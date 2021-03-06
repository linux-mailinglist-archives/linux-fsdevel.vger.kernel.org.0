Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C8A32FD2C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Mar 2021 21:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhCFUhA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Mar 2021 15:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhCFUgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Mar 2021 15:36:46 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781ECC061760
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 Mar 2021 12:36:45 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id r17so11501320ejy.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Mar 2021 12:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bVBJNOetXrqKceA6PQT3AoaWCMo1uBzTwNd40e3p5Mg=;
        b=DUH2TaJDmYKl3P+nqyQnZD/L+UUehgvGZ+JdR6f29HgDHqUZMlDctwBIl8mYEmOyr0
         N4JfiYpVnsK20wsamLI2lVHA89Wfq08BTq5pazwlWEnowiN+pvdoMlOFkXMkezTctVU6
         yLVLH/j9zqqOc1XXIzlPNblcwaWBnvPKoE+8ygaflWqyueqL8GQUxJqDZ0IOPsbLAq4D
         ClAITvBD9MRRxeIdqI+0cvIdl865zgrrN5mPPgRQlFQTjJcqKYMYzsPzMflqD2WkyucY
         yYqxvUtScFD3cWQ3k6qWXggCW2IBUYcSUf7R3K/wcLL0Zz3r5yXY54vMvwFWm819EQIv
         72nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVBJNOetXrqKceA6PQT3AoaWCMo1uBzTwNd40e3p5Mg=;
        b=ZdR0DnNWsjdAhvs4yl+wAb8GCCZ/DquKnBergu6+TfS7lQuRFvRRccl4CuZvt6q8Xs
         Q9huh43Dq9xTIKoL8n5zlnvvASDREgBSn2o3aXpIWZwUVOlfmeBthIdH5H/J32JkknIF
         y90VCBA7V3kDOyB2qy1iavw3rHkWEqgdAMB7/z5z9dq7XffmGp9TxmiVKlo+LYCZ4PHD
         GXAboz4IIPKLB8NUH3B/2xwTPL7qUVY9u5G4ppO8hY3oKs1/K8aDaDOUhwmEK0lCb06x
         nQt3MXRkRhjGH+ivPXR/jBBuRaRpV/lrGxnEq9daxhge8q4tW8OHW/KE0MBDcKoP9kR8
         oK5A==
X-Gm-Message-State: AOAM530kuihHKpp1L13Dm+iJg5A/iKKASPsg3zOYGLp9kRzYsNlQzDiD
        +QNHSC2E48y0+Z/PI24CifEGD4DflfeoAUFeigubyg==
X-Google-Smtp-Source: ABdhPJwWg5JZfa53VPl0WuQEKYMbCdynjlz48fz7pdzLNK+5tXI6itu2L3u8T4IRUn3/J6V3gGOhtuytQtomfVZ9FIo=
X-Received: by 2002:a17:906:2818:: with SMTP id r24mr8202331ejc.472.1615063004125;
 Sat, 06 Mar 2021 12:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com> <20210208105530.3072869-2-ruansy.fnst@cn.fujitsu.com>
In-Reply-To: <20210208105530.3072869-2-ruansy.fnst@cn.fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 6 Mar 2021 12:36:39 -0800
Message-ID: <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>, qi.fuli@fujitsu.com,
        Yasunori Goto <y-goto@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 8, 2021 at 2:55 AM Shiyang Ruan <ruansy.fnst@cn.fujitsu.com> wrote:
>
> When memory-failure occurs, we call this function which is implemented
> by each kind of devices.  For the fsdax case, pmem device driver
> implements it.  Pmem device driver will find out the block device where
> the error page locates in, and try to get the filesystem on this block
> device.  And finally call filesystem handler to deal with the error.
> The filesystem will try to recover the corrupted data if possiable.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>  include/linux/memremap.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 79c49e7f5c30..0bcf2b1e20bd 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -87,6 +87,14 @@ struct dev_pagemap_ops {
>          * the page back to a CPU accessible page.
>          */
>         vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
> +
> +       /*
> +        * Handle the memory failure happens on one page.  Notify the processes
> +        * who are using this page, and try to recover the data on this page
> +        * if necessary.
> +        */
> +       int (*memory_failure)(struct dev_pagemap *pgmap, unsigned long pfn,
> +                             int flags);
>  };

After the conversation with Dave I don't see the point of this. If
there is a memory_failure() on a page, why not just call
memory_failure()? That already knows how to find the inode and the
filesystem can be notified from there.

Although memory_failure() is inefficient for large range failures, I'm
not seeing a better option, so I'm going to test calling
memory_failure() over a large range whenever an in-use dax-device is
hot-removed.
