Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E938D6CFB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 16:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfGROaQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 10:30:16 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37522 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfGROaQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:30:16 -0400
Received: by mail-qk1-f195.google.com with SMTP id d15so20588087qkl.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2019 07:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjmJCNJRGOhllI8UevhEezWy1jhS3nYRGQxeSWHjEqQ=;
        b=UTEKW/lQw1+YfnPZ90S0KbWWY8Wf+Rufpf+WlEgKiDHOHtf7HrKB83Bjoy8ag66hfO
         6MEeXVjU8MnY7PYY4RwzoAQ3hb3OZLC5SmYHPlDFCJ9/XcnZV0V5s1UC+pDevIW9Du7u
         WmxuQm1ZgMKRAio5Ii5xne72QhjVM+oE+ZM646Z6YLs2vTQ5P/95rMA/07sWtgyUOw2h
         1rm2g3x7RY3qk7h1uYXaihYrKv2/nw+UG8zP5AHcSOx8zX6gGJ1IkOVYET8QR92ep1B0
         oxQFc2EAkLrtehUI7WEnsZikIYEQNhggfHRYPQjfmT12HvL9xJN/58xty7YWcw3RsBbB
         m7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjmJCNJRGOhllI8UevhEezWy1jhS3nYRGQxeSWHjEqQ=;
        b=I/tkiZ7wRLtlfQskFYnqGKttQKz0j1SghqstHWcYFvi9/K2RP9dXniH+KYaO6qqfm8
         XJw0GymMeRqzCC01ZGiqtmxoPmQwVYDbXo6beRpnKULosz1kjBC0oQUJ7+2xK9T8qU5Q
         5Gh8yejl86wkfeHwizHsvwJgEZlhw7qB9pi6mVPiIRt++wnqpX52W89cWWeWFfipSxEz
         Nlm1GEEvJq0O0GyCyAtTnw+248yYLSC/tbKcgVUgnJabMvRBMOXuXrgj6I3Jefjm+n0K
         B7SmMC5RKaXZ+shEIRGxCRwIwfXgJ7osJPaT/KT8/7xq4FzV4w6vLSlrcGqFJo70Ry1t
         kBGQ==
X-Gm-Message-State: APjAAAWqgoYwMCwfMyJRId2Ts6fZTcVW4+ftxUc86GDB7HPwk9vZW69r
        Mz6pNCL1CUAlgbfq+F1pM+a8iHPE4iuLhZ9nV2SO6g==
X-Google-Smtp-Source: APXvYqyH3Tq2IZ4Y34U+Coq0W2cVWZFn0bZvr00HyTwOSwv4wauHuS/tecT7SIuKu7ysKawZSqDgTIAA4/cnpxUome4=
X-Received: by 2002:a37:a742:: with SMTP id q63mr29771140qke.421.1563460215307;
 Thu, 18 Jul 2019 07:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190515192715.18000-1-vgoyal@redhat.com> <20190515192715.18000-19-vgoyal@redhat.com>
 <20190717192725.25c3d146.pasic@linux.ibm.com> <20190718131532.GA13883@redhat.com>
In-Reply-To: <20190718131532.GA13883@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 18 Jul 2019 07:30:03 -0700
Message-ID: <CAPcyv4i+2nKJYqkbrdm3hWcjaMYkCKUxqLBq96HOZe6xOZzGGg@mail.gmail.com>
Subject: Re: [PATCH v2 18/30] virtio_fs, dax: Set up virtio_fs dax_device
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Collin Walling <walling@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        KVM list <kvm@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Steven Whitehouse <swhiteho@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 18, 2019 at 6:15 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Jul 17, 2019 at 07:27:25PM +0200, Halil Pasic wrote:
> > On Wed, 15 May 2019 15:27:03 -0400
> > Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > >
> > > Setup a dax device.
> > >
> > > Use the shm capability to find the cache entry and map it.
> > >
> > > The DAX window is accessed by the fs/dax.c infrastructure and must have
> > > struct pages (at least on x86).  Use devm_memremap_pages() to map the
> > > DAX window PCI BAR and allocate struct page.
> > >
> >
> > Sorry for being this late. I don't see any more recent version so I will
> > comment here.
> >
> > I'm trying to figure out how is this supposed to work on s390. My concern
> > is, that on s390 PCI memory needs to be accessed by special
> > instructions. This is taken care of by the stuff defined in
> > arch/s390/include/asm/io.h. E.g. we 'override' __raw_writew so it uses
> > the appropriate s390 instruction. However if the code does not use the
> > linux abstractions for accessing PCI memory, but assumes it can be
> > accessed like RAM, we have a problem.
> >
> > Looking at this patch, it seems to me, that we might end up with exactly
> > the case described. For example AFAICT copy_to_iter() (3) resolves to
> > the function in lib/iov_iter.c which does not seem to cater for s390
> > oddities.
> >
> > I didn't have the time to investigate this properly, and since virtio-fs
> > is virtual, we may be able to get around what is otherwise a
> > limitation on s390. My understanding of these areas is admittedly
> > shallow, and since I'm not sure I'll have much more time to
> > invest in the near future I decided to raise concern.
> >
> > Any opinions?
>
> Hi Halil,
>
> I don't understand s390 and how PCI works there as well. Is there any
> other transport we can use there to map IO memory directly and access
> using DAX?
>
> BTW, is DAX supported for s390.
>
> I am also hoping somebody who knows better can chip in. Till that time,
> we could still use virtio-fs on s390 without DAX.

s390 has so-called "limited" dax support, see CONFIG_FS_DAX_LIMITED.
In practice that means that support for PTE_DEVMAP is missing which
means no get_user_pages() support for dax mappings. Effectively it's
only useful for execute-in-place as operations like fork() and ptrace
of dax mappings will fail.
