Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 264AC6CE85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 15:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390486AbfGRNDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 09:03:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45863 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390481AbfGRNDe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 09:03:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id x22so22132278qtp.12;
        Thu, 18 Jul 2019 06:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lb5k3Q5zQv7ZLYwKsi5srpJUcaAhZ2VH3/ijP9EHPxI=;
        b=bJZUe2Q4TPeH0V6Mu45JwPPUVuQzsLbVcT5whNJqDcId54bdTKAvznV94DL75HArIn
         ImDqGrCKqr7DU6uOcEBlKeV++Dl/051kiLMksb5sGpK1d9Jw7rL2Y4z2vRl7hrbqO7ji
         fLwVlvjC/mdjdzc+7FP4FMHX+3/oULVuUOwhO3ZlkX/fdW5iqB0SNA9/LHYNWL8ouhdc
         IraIPpxtjBzEHlQh0Ye4SrdGKTIkWCx3Cd17rhzMC8JOcWyVZ3b0snfZup0XEoXavIUZ
         4/x4Gb0b21xs5p5EU+wN/3bFV2mZp/7ZTKFQME/ziwg+LH0LDnzKInK33zKwptDSPpM0
         eaCQ==
X-Gm-Message-State: APjAAAWDonUdkXTV5MHL2PA2UK1cX7/2wuHsfZ3rrLNbCOIZXe7yBEu4
        NfdiGJtgGCnIsUny82NwsbX7YtK+q9JcKRkkckQ=
X-Google-Smtp-Source: APXvYqz9nIctHx6Rxddq8cesuADplI3Y1SDM5MUlVUyjc8+t0YSaOlsFqe0AC18MyfvhBpwKa4Wro3+CjshsGETrsVs=
X-Received: by 2002:aed:33a4:: with SMTP id v33mr31403781qtd.18.1563455013554;
 Thu, 18 Jul 2019 06:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190718125509.775525-1-arnd@arndb.de> <20190718125703.GA28332@lst.de>
In-Reply-To: <20190718125703.GA28332@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Jul 2019 15:03:15 +0200
Message-ID: <CAK8P3a2k3ddUD-b+OskpDfAkm6KGAGAOBabkXk3Uek1dShTiUA@mail.gmail.com>
Subject: Re: [PATCH] iomap: hide iomap_sector with CONFIG_BLOCK=n
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 18, 2019 at 2:57 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jul 18, 2019 at 02:55:01PM +0200, Arnd Bergmann wrote:
> > When CONFIG_BLOCK is disabled, SECTOR_SHIFT is unknown:
> >
> > In file included from <built-in>:3:
> > include/linux/iomap.h:76:48: error: use of undeclared identifier 'SECTOR_SHIFT'
> >         return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
> >
> > Since there are no callers in this case, just hide the function in
> > the same ifdef.
> >
> > Fixes: db074436f421 ("iomap: move the direct IO code into a separate file")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Can we just not include iomap.c when CONFIG_BLOCK is not set?
> Which file do you see this with?

The inclusion comes from the recently added header check in commit
c93a0368aaa2 ("kbuild: do not create wrappers for header-test-y").

This just tries to include every header by itself to see if there are build
failures from missing indirect includes. We probably don't want to
add an exception for iomap.h there.

      Arnd
