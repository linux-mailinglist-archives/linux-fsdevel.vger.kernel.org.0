Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADADC166F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 17:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfEGPhN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 11:37:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36283 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfEGPhN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 11:37:13 -0400
Received: by mail-ot1-f65.google.com with SMTP id c3so632064otr.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2019 08:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dOaY+uD9DJjErKzQ4lbx3sa2d0JDi7CHezoB5wTbvY=;
        b=1RDaQiep4r+5NZ7RO5zftr0FnsMUZwAyLWkMBkR9iTDOBSIJayhPK4u9DWG7+9yxpt
         9FJnbG3lrhIL0LedEM5ytUIEEGfVVBYdsCV16Q3ZevH87Y7p3IJljktvzFGtbrtOW9jV
         qgMeHUIAfkrXfVgCh+wJIUgLwx8HPs0Hso14g3nE34tG3uE5Kaf93v1albOqeZ8FtzEo
         MRnNU+jjU7Bd7Hg2HKOClTmC45crVs8w8TurxKr/6z1WENdYw/y//CLDQEQmIA9Rf7i+
         OKLRLxxsnQvga0Mn1E5gFobavHOZ9OlvYblRdklzqgaUM3FSIzUzMZWnI38rOf5/Ueyc
         SI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dOaY+uD9DJjErKzQ4lbx3sa2d0JDi7CHezoB5wTbvY=;
        b=EuaO9gflWJMbPMw+alcipNkaOpeJl+k1VkeVm2F2bzWnLfEZNcd2Wkat3OLEY/qY9W
         k+2ZLbTBsGbdqUOgRPvHw2EZYBpbuigAkusS3bSyVQHxQW/DgqyMGaHaMw2gfL4pWwgN
         xLeyeT1Iqz6iRyJLZrS5Q1ApUsAm0vGyMg5zM7taxkQCsrqD7ztYvaKv10PtCTGu3cDK
         kjH9Boel7tCNSbozeu9RTeOnrVKXxpQrTPlDuVAeUvVghtvttMkyTpOAm3zJOtgqSAsS
         NNGpipmcn1+lEjF3LuLoZDxRP1ARCpGf0nTwIQ2QpY1uzRWx1tHH/a1WDoyH17m0W8B9
         PJWA==
X-Gm-Message-State: APjAAAVbUXhrnYa5ZLfOsBAl9gX8fd/qXyPkZTT2PLJbjievgDCNATa4
        CL9cnCfHCNgwx8CCWYOPif/2vE5Phe8RKWTpCb6wBw==
X-Google-Smtp-Source: APXvYqxbxERKNtTaVpMxD9jAh6w8zsl3plIje9NPoM99XF0whcoJ/rqAndFua0o+8QlJA2fPNaeXZRcDVPm+ejCVDvk=
X-Received: by 2002:a9d:222c:: with SMTP id o41mr22019501ota.353.1557243432435;
 Tue, 07 May 2019 08:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190426050039.17460-1-pagupta@redhat.com> <20190426050039.17460-7-pagupta@redhat.com>
In-Reply-To: <20190426050039.17460-7-pagupta@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 May 2019 08:37:01 -0700
Message-ID: <CAPcyv4hCP4E4xPkQx25tqhznon6ADwrYJB1yujkrO-A7LUnsmg@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] xfs: disable map_sync for async flush
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        KVM list <kvm@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christoph Hellwig <hch@infradead.org>,
        Len Brown <lenb@kernel.org>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        lcapitulino@redhat.com, Kevin Wolf <kwolf@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        jmoyer <jmoyer@redhat.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        david <david@fromorbit.com>, cohuck@redhat.com,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kilobyte@angband.pl,
        yuval shaia <yuval.shaia@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:03 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> Dont support 'MAP_SYNC' with non-DAX files and DAX files
> with asynchronous dax_device. Virtio pmem provides
> asynchronous host page cache flush mechanism. We don't
> support 'MAP_SYNC' with virtio pmem and xfs.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  fs/xfs/xfs_file.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Darrick, does this look ok to take through the nvdimm tree?

>
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index a7ceae90110e..f17652cca5ff 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1203,11 +1203,14 @@ xfs_file_mmap(
>         struct file     *filp,
>         struct vm_area_struct *vma)
>  {
> +       struct dax_device       *dax_dev;
> +
> +       dax_dev = xfs_find_daxdev_for_inode(file_inode(filp));
>         /*
> -        * We don't support synchronous mappings for non-DAX files. At least
> -        * until someone comes with a sensible use case.
> +        * We don't support synchronous mappings for non-DAX files and
> +        * for DAX files if underneath dax_device is not synchronous.
>          */
> -       if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
> +       if (!daxdev_mapping_supported(vma, dax_dev))
>                 return -EOPNOTSUPP;
>
>         file_accessed(filp);
> --
> 2.20.1
>
