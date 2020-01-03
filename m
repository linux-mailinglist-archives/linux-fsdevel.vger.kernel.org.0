Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9B112FC30
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 19:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgACSSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 13:18:34 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33796 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbgACSSe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:18:34 -0500
Received: by mail-oi1-f196.google.com with SMTP id l136so14772133oig.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jan 2020 10:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8jfW1W8ZPOpcKWgvKCt6rdwp9cvHKeFm7M8ZtVMfoqE=;
        b=uUTSYWl8nz82vjdvvs/xw9mCFGyNA1/jWIoEbWuoMKlH3HcUmcrmAqAMT/hIMBHdeM
         Fuby+QAs66gLq4zerv1qQgWzxoVD8/r0SSdFiVPRB1KIlrgk+Ia/w09w2yIVb5UjPUKe
         aPbAUa8sDKqS+Z4oOye+qJxT2xWQdMreVtrK0E0UvXvfqOeelWZW8PJqgrqw9dRkK6uk
         n02sLzh2qbjLYtP6eE1hXlSk3R0Qtd222mErsWQ1QRt3DyYfq3l8wWs0f8OFXi4RxUqR
         Miqm3MNSWzoZ2hZI/iAGOnFy0qTR/HSd977eHvvgAqYPyJXhnZLiJOZszpwfj8/ebisx
         Q1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8jfW1W8ZPOpcKWgvKCt6rdwp9cvHKeFm7M8ZtVMfoqE=;
        b=i8fOhSfia/X9C0x5rD6mhXHJk2hzrHPVN5s5/mqRGQTECBPQrDTexVdjmj036A7C0Q
         LpBtdTUOpRtp6VOMOU+RsasaAvddSsTexKHv+Vjkm9xxOfdffMmf+LcnuoBhH7YUitrv
         WW+yGhFbLu040b6N9f/fo3AFkcsKdQ3tWAv7Q9khksGIU7Q+cXzFWAQJPSzP/EjShmlD
         tAj9FuM3xUHNtg/ufHGf82jGda/78AD/NQfCOpWLNBqhDUcpyo6laxXtmQciLMT9E7Sp
         WaqoJxwkCpCRQttg+JN1DCsMrP5Usl9syx72bXzohYcVbYUpGrAWB7zuv7uWxzuo3yXh
         +UnA==
X-Gm-Message-State: APjAAAWs6ckXp8cuMJc1te7TkNZnoYCxmSR9RtXeRR85bXDLn9ynVzoW
        6hQrFL3tL2M3xikOvdwdCOda7mzB7Ljn0bIrxFe42uuglXE=
X-Google-Smtp-Source: APXvYqy2IVKMiHQ+wQTZ+ASoUXECP3V0RjbOEIgTCxr3TvAGQIi/fJSFNpOGIKISyhHaPla/bwRt9Ai9ZKS192hUFSE=
X-Received: by 2002:a05:6808:b37:: with SMTP id t23mr4590187oij.149.1578075513071;
 Fri, 03 Jan 2020 10:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20190821175720.25901-1-vgoyal@redhat.com> <20190821175720.25901-3-vgoyal@redhat.com>
 <20190826115316.GB21051@infradead.org> <20190826203326.GB13860@redhat.com>
 <20190826205829.GC13860@redhat.com> <20200103141235.GA13350@redhat.com> <CAPcyv4hr-KXUAT_tVy-GuTOq1GvVGHKsHwAPih60wcW3DGmqRg@mail.gmail.com>
In-Reply-To: <CAPcyv4hr-KXUAT_tVy-GuTOq1GvVGHKsHwAPih60wcW3DGmqRg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 3 Jan 2020 10:18:22 -0800
Message-ID: <CAPcyv4jM8s8T5ifv0c2eyqaBu3f2bd_j+fQHmJttZAajZ-we=g@mail.gmail.com>
Subject: Re: [PATCH 02/19] dax: Pass dax_dev to dax_writeback_mapping_range()
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 3, 2020 at 10:12 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jan 3, 2020 at 6:12 AM Vivek Goyal <vgoyal@redhat.com> wrote:
[..]
> > Hi Dan,
> >
> > Ping for this patch. I see christoph and Jan acked it. Can we take it. Not
> > sure how to get ack from ext4 developers.
>
> Jan counts for ext4, I just missed this. Now merged.

Oh, this now collides with:

   30fa529e3b2e xfs: add a xfs_inode_buftarg helper

Care to rebase? I'll also circle back to your question about
partitions on patch1.
