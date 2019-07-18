Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04D146D04C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 16:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390541AbfGROtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 10:49:02 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40105 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfGROtC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:49:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so27440143qtn.7;
        Thu, 18 Jul 2019 07:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lmArtbMu3sH1yAvRJHLIrPo6/n/cdKCsdBCmd5C2IQ8=;
        b=mSN6ncgMFo/8r5zIY/lyYALuPXEcATDLCzexMTZDwpsMfCi3W9C2Sb2w1r8zYXyaNQ
         VHxRRn+5RdOhbcejU44W9PO1/vJxujEQjGD3LG0BHyvk1QTIcqCh9wUSJtjb44ObQHT6
         HSoPPdBcxJVqCscuYAVe3PENyxDNXGOus7HgO/UjX/guEb72QL/Y/7qaEJlC554N9ij6
         gBrFm+W20tT4E4CBJysKqRmLEzU8N6QNvB5fh/PvgnZEsaj3erMVtAD4nTKvJ3atGoDJ
         5AbkHZ9wrC+wyaKj9NSc4NUfS+jva6kAmktW8Zy3ZoGS8L1gQD075ZVzUh4YfVrO9SSd
         UGGg==
X-Gm-Message-State: APjAAAVOAFWmxhyCXNGCZAgIKA3RIDDxzij76aLklLerCReKZtnGhekX
        w5Q+qQGPTA7AIbK6wN8d1VQtOwqmUxY5HPQxeV8=
X-Google-Smtp-Source: APXvYqyGTHPe5PQabqcn621tJ6BN0Z+rTWvQOrhBq6i3Ye7JuAJJMajo35a5aTa4MEeNTV7DL/W1Kw/ZK6MtC+9UODk=
X-Received: by 2002:a0c:ba2c:: with SMTP id w44mr32963580qvf.62.1563461340817;
 Thu, 18 Jul 2019 07:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190718125509.775525-1-arnd@arndb.de> <20190718125703.GA28332@lst.de>
 <CAK8P3a2k3ddUD-b+OskpDfAkm6KGAGAOBabkXk3Uek1dShTiUA@mail.gmail.com> <20190718130835.GA28520@lst.de>
In-Reply-To: <20190718130835.GA28520@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Jul 2019 16:48:44 +0200
Message-ID: <CAK8P3a1W03RiWmUmgprAODeUBXZOF-OUyCBJKmufadpKivbQWg@mail.gmail.com>
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

On Thu, Jul 18, 2019 at 3:08 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jul 18, 2019 at 03:03:15PM +0200, Arnd Bergmann wrote:
> > The inclusion comes from the recently added header check in commit
> > c93a0368aaa2 ("kbuild: do not create wrappers for header-test-y").
> >
> > This just tries to include every header by itself to see if there are build
> > failures from missing indirect includes. We probably don't want to
> > add an exception for iomap.h there.
>
> I very much disagree with that check.  We don't need to make every
> header compilable with a setup where it should not be included.

I do like the extra check there, and it did not seem to need too many
fixes to get it working in the first place.

> That being said if you feel this is worth fixing I'd rather define
> SECTOR_SIZE/SECTOR_SHIFT unconditionally.

I'll give that a try and send a replacement patch after build testing
succeeds for a number of randconfig builds.

      Arnd
