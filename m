Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABA3125ABF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 06:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfLSF1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 00:27:55 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33483 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfLSF1z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 00:27:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so5640232otp.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 21:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YiNT2OwN1PC5xiClJXvmIxtU8FKdWcajydHQPOKowMQ=;
        b=dqorifJ4f+v2Gylbu8oAiFDcKa1F8skIpz6V3IgWOqRB33n7U59EJyePbqvuTj6Vy4
         uOPeG7Kob1GhJUtITzia2N5iO6b+FgQt0PfBLv1SShdXtnPTkzPXC4wv8NlfHewxSVCr
         BWaS5xgO+C3htMgxe5c7ubvEmgYEe4TsZt+Zn5XRlxBQhxFahwlW/Mo0S+TgOXqQ/47k
         mtfOMZwImte59GAX6ig1VEn2mK8lUBxmhPPLTpVmIFFbH4EVvah9nw+1Oh0aFp9cBJiW
         sz8ohgGLCmoNne0NYqks6igeYI3pnrq7++p4oBryH4HFQcsawtXKY12nyEVckq37Q8q+
         63BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YiNT2OwN1PC5xiClJXvmIxtU8FKdWcajydHQPOKowMQ=;
        b=WNZYXBT8bOQZ8WWlVb98zQsDm3suly9CBWbpmdbumGnvtLn4XyCIA1kT+M0gFaBMsg
         6HHpdchbFGP4O8Fc4Jj9JLsk+rE0yLU3zSH1AcvLbq4TYnTO1T6fmHmeAYgxSrfDBHm6
         WSK+GmvGj0dHAdBIsyQApKp2jkM9HtbXY/5adRzWiIwnfODeeZvb+JSRaNFq9IIPQuFF
         IacYSM1QJME/nZ2bcPj38LJ9yFvxsLGdG7cJ8Cu9CtXSJdccNOqVIDHpAy1XTJ6ak4QM
         PcGbdZKOXqlrQGwV5aY2qp37wmblNQGXJpdWOo8Hc94dVpQVTNla+UWhFict65EGDfC0
         6hjg==
X-Gm-Message-State: APjAAAW+keORpSj+vCy8O6fB3u+Aw+g44NozqFXgf5IGIhpHm1Q5Skxv
        3ikUiId04bdIfQF9nLj08N3Lwn2J7DEZcODacNrfTQ==
X-Google-Smtp-Source: APXvYqzIho60C4tgIgH4FPSEG3bP2Gra7VUCaG88r8S6eX3efYPsOK7esN+4WGhr8L+TiHfEgJwBcHps0ms7QGyGe6Y=
X-Received: by 2002:a05:6830:1744:: with SMTP id 4mr6583360otz.71.1576733274234;
 Wed, 18 Dec 2019 21:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20191216222537.491123-1-jhubbard@nvidia.com> <20191216222537.491123-5-jhubbard@nvidia.com>
In-Reply-To: <20191216222537.491123-5-jhubbard@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 Dec 2019 21:27:43 -0800
Message-ID: <CAPcyv4hQBMxYMurxG=Vwh0=FKWoT3z-Kf=dqES1-icRV5bLwKg@mail.gmail.com>
Subject: Re: [PATCH v11 04/25] mm: devmap: refactor 1-based refcounting for
 ZONE_DEVICE pages
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, bpf@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, KVM list <kvm@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Netdev <netdev@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 16, 2019 at 2:26 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> An upcoming patch changes and complicates the refcounting and
> especially the "put page" aspects of it. In order to keep
> everything clean, refactor the devmap page release routines:
>
> * Rename put_devmap_managed_page() to page_is_devmap_managed(),
>   and limit the functionality to "read only": return a bool,
>   with no side effects.
>
> * Add a new routine, put_devmap_managed_page(), to handle checking
>   what kind of page it is, and what kind of refcount handling it
>   requires.
>
> * Rename __put_devmap_managed_page() to free_devmap_managed_page(),
>   and limit the functionality to unconditionally freeing a devmap
>   page.
>
> This is originally based on a separate patch by Ira Weiny, which
> applied to an early version of the put_user_page() experiments.
> Since then, J=C3=A9r=C3=B4me Glisse suggested the refactoring described a=
bove.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Suggested-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/mm.h | 17 +++++++++++++----
>  mm/memremap.c      | 16 ++--------------
>  mm/swap.c          | 24 ++++++++++++++++++++++++
>  3 files changed, 39 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c97ea3b694e6..77a4df06c8a7 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -952,9 +952,10 @@ static inline bool is_zone_device_page(const struct =
page *page)
>  #endif
>
>  #ifdef CONFIG_DEV_PAGEMAP_OPS
> -void __put_devmap_managed_page(struct page *page);
> +void free_devmap_managed_page(struct page *page);
>  DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
> -static inline bool put_devmap_managed_page(struct page *page)
> +
> +static inline bool page_is_devmap_managed(struct page *page)
>  {
>         if (!static_branch_unlikely(&devmap_managed_key))
>                 return false;
> @@ -963,7 +964,6 @@ static inline bool put_devmap_managed_page(struct pag=
e *page)
>         switch (page->pgmap->type) {
>         case MEMORY_DEVICE_PRIVATE:
>         case MEMORY_DEVICE_FS_DAX:
> -               __put_devmap_managed_page(page);
>                 return true;
>         default:
>                 break;
> @@ -971,7 +971,14 @@ static inline bool put_devmap_managed_page(struct pa=
ge *page)
>         return false;
>  }
>
> +bool put_devmap_managed_page(struct page *page);
> +
>  #else /* CONFIG_DEV_PAGEMAP_OPS */
> +static inline bool page_is_devmap_managed(struct page *page)
> +{
> +       return false;
> +}
> +
>  static inline bool put_devmap_managed_page(struct page *page)
>  {
>         return false;
> @@ -1028,8 +1035,10 @@ static inline void put_page(struct page *page)
>          * need to inform the device driver through callback. See
>          * include/linux/memremap.h and HMM for details.
>          */
> -       if (put_devmap_managed_page(page))
> +       if (page_is_devmap_managed(page)) {
> +               put_devmap_managed_page(page);
>                 return;
> +       }
>
>         if (put_page_testzero(page))
>                 __put_page(page);
> diff --git a/mm/memremap.c b/mm/memremap.c
> index e899fa876a62..2ba773859031 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -411,20 +411,8 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pf=
n,
>  EXPORT_SYMBOL_GPL(get_dev_pagemap);
>
>  #ifdef CONFIG_DEV_PAGEMAP_OPS
> -void __put_devmap_managed_page(struct page *page)
> +void free_devmap_managed_page(struct page *page)
>  {
> -       int count =3D page_ref_dec_return(page);
> -
> -       /* still busy */
> -       if (count > 1)
> -               return;
> -
> -       /* only triggered by the dev_pagemap shutdown path */
> -       if (count =3D=3D 0) {
> -               __put_page(page);
> -               return;
> -       }
> -
>         /* notify page idle for dax */
>         if (!is_device_private_page(page)) {
>                 wake_up_var(&page->_refcount);
> @@ -461,5 +449,5 @@ void __put_devmap_managed_page(struct page *page)
>         page->mapping =3D NULL;
>         page->pgmap->ops->page_free(page);
>  }
> -EXPORT_SYMBOL(__put_devmap_managed_page);
> +EXPORT_SYMBOL(free_devmap_managed_page);

This patch does not have a module consumer for
free_devmap_managed_page(), so the export should move to the patch
that needs the new export.

Also the only reason that put_devmap_managed_page() is EXPORT_SYMBOL
instead of EXPORT_SYMBOL_GPL is that there was no practical way to
hide the devmap details from evey module in the kernel that did
put_page(). I would expect free_devmap_managed_page() to
EXPORT_SYMBOL_GPL if it is not inlined into an existing exported
static inline api.
