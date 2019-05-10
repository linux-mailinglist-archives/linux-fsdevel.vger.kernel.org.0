Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD3F1A05B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 17:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfEJPli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 11:41:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36786 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfEJPli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 11:41:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id c3so5976733otr.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2019 08:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ui2zFPB1DYC19lQl11zIEBS4dDuBE0sSmR3AaK+jIn0=;
        b=Xd7Jve/wwg9rBXpWJVmiERkysPDBo4ePhgeoBglu5WVf7aUKOOBKrVzxnk3xLq0xr/
         6Jtqopi12VqLssCwwKL8C5lDjxeFPDs36a3RgBuBHams3EpOBqPUrEFS34ntfNAJ2Wd7
         PjDlZyWysnLd+akFS1hRkooK2NYRDIVlvXrXrZVaXlzGy24TvtXZPf/vZh9POmqJWVpi
         yB5ZbigT4jat3qnXu4F7G57AsCGSUdRbxhf0aftekZipf2BsBT9eKnJiqVNFBsp46rTs
         boLZbqln3lmy1mFwke26mvVHOLmqp7i2dgYckaSysIO5XmtgtBuBckgtGfnjC8l+15nX
         z35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ui2zFPB1DYC19lQl11zIEBS4dDuBE0sSmR3AaK+jIn0=;
        b=Qcy9Ysv7bUhL/VjWf8FipRwy8DT6/bBpc2w/ufMFkrGvfGP9RlDBxSGpb0mzMvE3ji
         MG+YFsTj6dTbvelPUyS1F0XDZuyELMI+0tfgSCjuxTcssjTJ457uOZrgqLDRvFx+bfwK
         YzRpDBp+ihT0PUlyJqLnzcjkzkzyKGkamI4H2F5teEIvRUsfPvWEnAvdI29JRYWfTVP+
         PL7LFn/Q4egASbT1wW6AzdIyMZVaKw5wr4c6lXjZQQxr38Ie/QT+FSLQCAWNopmOgaH+
         tyKtydvfxdRKmXRftqN0V8/e1aEpl7pApiACuuHmXTo1Gb6nAN3pzS8WsTBSrd31rP7K
         Q5kw==
X-Gm-Message-State: APjAAAVFEWfhQlHX5zJh/8i8OpOBqAFjt/fqOarNFNMINmR7CaspCbRY
        AgmukJZRvkjhOsilAfsrt4Pjrg9E+gF5XiY/Xo0tNg==
X-Google-Smtp-Source: APXvYqx9GD2D2N7EYWR97IWH0oQh55yLDCabFZoBxeK8iZN4jPseNZXYcKsp8O4O1+YAgTc16rdx2Cf5rBsgV0xZ5bE=
X-Received: by 2002:a9d:7c84:: with SMTP id q4mr1631137otn.98.1557502897461;
 Fri, 10 May 2019 08:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190429172649.8288-13-rgoldwyn@suse.de> <20190510153222.24665-1-kilobyte@angband.pl>
In-Reply-To: <20190510153222.24665-1-kilobyte@angband.pl>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 May 2019 08:41:25 -0700
Message-ID: <CAPcyv4jPF70QECzpgDCwzasJT38eOqG9tfQRbo37OWg+YzGu_w@mail.gmail.com>
Subject: Re: [PATCH for-goldwyn] btrfs: disallow MAP_SYNC outside of DAX mounts
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, david <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, dsterba@suse.cz,
        nborisov@suse.com, linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pankaj Gupta <pagupta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 10, 2019 at 8:33 AM Adam Borowski <kilobyte@angband.pl> wrote:
>
> Even if allocation is done synchronously, data would be lost except on
> actual pmem.  Explicit msync()s don't need MAP_SYNC, and don't require
> a sync per page.
>
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
> MAP_SYNC can't be allowed unconditionally, as cacheline flushes don't help
> guarantee persistency in page cache.  This fixes an error in my earlier
> patch "btrfs: allow MAP_SYNC mmap" -- you'd probably want to amend that.
>
>
>  fs/btrfs/file.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 362a9cf9dcb2..0bc5428037ba 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2233,6 +2233,13 @@ static int btrfs_file_mmap(struct file   *filp, struct vm_area_struct *vma)
>         if (!IS_DAX(inode) && !mapping->a_ops->readpage)
>                 return -ENOEXEC;
>
> +       /*
> +        * Normal operation of btrfs is pretty much an antithesis of MAP_SYNC;
> +        * supporting it outside DAX is pointless.
> +        */
> +       if (!IS_DAX(inode) && (vma->vm_flags & VM_SYNC))
> +               return -EOPNOTSUPP;
> +

If the virtio-pmem patch set goes upstream prior to btrfs-dax support
this will need to switch over to the new daxdev_mapping_supported()
helper.

https://lore.kernel.org/lkml/20190426050039.17460-5-pagupta@redhat.com/
