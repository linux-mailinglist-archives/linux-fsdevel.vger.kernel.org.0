Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817AE2E18FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 07:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgLWGdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Dec 2020 01:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgLWGdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Dec 2020 01:33:00 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFF0C061793
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 22:32:19 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id lt17so21398847ejb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 22:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gLShtXRFUgewbIKfHtzkzQ5g7IaXVf3xlFIgWLLVqz8=;
        b=YpZMAt7xFq/77g6dwxVdwTalDKzaGm9/4PzOMbWOsWfDSVV9yzvU5yFAhxJVu7TgWM
         06ta5T89UkCXgxA6Y3lY1nMBr9KNGsXBMVvTSyEM41CLdF4F9iDdv11RQDTp0U5cTenE
         QkHVsn+pXE3uBzQan4UEOxCVtUwC/LuLU/cAO/m44GzvDxnq/aeb99qr5AV35qmzE8jN
         46YAhWhWp0XSzpfvt3rO1iB2xWB4B8csLwcLdSjdFOxySbFlwHL2G+I560sKxsGG1jfb
         6WwdcVMj+dRLWvIJafAo/elklLL67cvrfdxsq4FrX/Mti9wKuhlbyWHcMnQV343nnSVF
         UvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gLShtXRFUgewbIKfHtzkzQ5g7IaXVf3xlFIgWLLVqz8=;
        b=YJH1vG5ukee1hi60wPN986xlqjqqu6srpkFmWAwqUrJoA88Qc1N8EUT0g8GD85d0pS
         TnAOaanjCmt5O6Iu4kdk4jVZq0O/2T9aZQnsiJ6+6OWnT4Z8iiHCLTMMYPS2tWt9Hz8r
         uHYYlnIESlHKm7B8UL3m/g4iW6bRWLoPtjcPVOTgvga2sumFl0RDS7RhdwzZHXlcKF+N
         46aFphLdqduFLaFu4WQ1v9BlQI/S4aPA9JtOheOZpCB//PshmN8q/BQIW4Mx9iuZTy1q
         8Y9EWZjs+57T1sYf9UKdF07t6fnUSK5qqmr24MX6kvDfhv6h9g/WXs0JF0RC8u1LWhm1
         NJ2w==
X-Gm-Message-State: AOAM532KqfXA6j8BryPSa0Vy4/PcGgGLX5AANwZ5bXQljCa7mJRa+8X7
        kk1QpbhsxXHdPBagqukBaW9n7Qlj7EpEYSZeUJw2
X-Google-Smtp-Source: ABdhPJxs6lIntTC3Viz+5acTB3IEA1HMKnEybJJ/XyF/jDwD0HipwjDi0OgXmfi0YFe4Ee6AtCr/GLgvQ3xVMVqdmkM=
X-Received: by 2002:a17:906:d0c2:: with SMTP id bq2mr22682863ejb.1.1608705138457;
 Tue, 22 Dec 2020 22:32:18 -0800 (PST)
MIME-Version: 1.0
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 23 Dec 2020 14:32:07 +0800
Message-ID: <CACycT3vevQQ8cGK_ac-1oyCb9+YPSAhLMue=4J3=2HzXVK7XHw@mail.gmail.com>
Subject: Re: [RFC v2 01/13] mm: export zap_page_range() for driver use
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, sgarzare@redhat.com,
        Parav Pandit <parav@nvidia.com>, akpm@linux-foundation.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, bcrl@kvack.org, corbet@lwn.net,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 22, 2020 at 11:44 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Dec 22, 2020 at 10:52:09PM +0800, Xie Yongji wrote:
> > Export zap_page_range() for use in VDUSE.
>
> Err, no.  This has absolutely no business being used by drivers.

Now I want to map/unmap some pages in an userland vma dynamically. The
vm_insert_page() is being used for mapping. In the unmapping case, it
looks like the zap_page_range() does what I want. So I export it.
Otherwise, we need some ways to notify userspace to trigger it with
madvise(MADV_DONTNEED), which might not be able to meet all our needs.
For example, unmapping some pages in a memory shrinker function.

So I'd like to know what's the limitation to use zap_page_range() in a
module. And if we can't use it in a module, is there any acceptable
way to achieve that?

Thanks.
Yongji
