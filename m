Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECA83F09C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 18:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhHRQ7G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 12:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229623AbhHRQ7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629305910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jIOt3Tax48EHjcS9UTqIzuMFAHA5tBCIflSiAzkMVWM=;
        b=NflkoGIe3F3RXoA/EPjrS4bgAedHqe2rbitzkNot+NS9eambByYPX/tDjja3YpEjGzpJgH
        RX+mP3jkfXoTew9sgr4uz3tyHTCc2Q98yYDH3AZxrd0yZC0mcd8OCau+yhg9JOGkZmKY/y
        CDtKxOq8o/dn8Jt0W68BbS/0IxZvXxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-LcooZPDlPl-FClJC09JXig-1; Wed, 18 Aug 2021 12:58:28 -0400
X-MC-Unique: LcooZPDlPl-FClJC09JXig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9279019611A0;
        Wed, 18 Aug 2021 16:58:27 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C16211036D11;
        Wed, 18 Aug 2021 16:58:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 23438223863; Wed, 18 Aug 2021 12:58:18 -0400 (EDT)
Date:   Wed, 18 Aug 2021 12:58:18 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     JeffleXu <jefflexu@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
Message-ID: <YR08KnP8cO8LjKY7@redhat.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRut5sioYfc2M1p7@redhat.com>
 <6043c0b8-0ff1-2e11-0dd0-e23f9ff6b952@linux.alibaba.com>
 <CAJfpegv01k5hEyJ3LPDWJoqB+vL8hwTan9dLu1pkkD0xoRuFzw@mail.gmail.com>
 <1100b711-012d-d68b-7078-20eea6fa4bab@linux.alibaba.com>
 <CAJfpegsdX1H_=ZMORA-9YiBGdszG0WVmAjFY2QSZPa0iLUEjXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsdX1H_=ZMORA-9YiBGdszG0WVmAjFY2QSZPa0iLUEjXw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 18, 2021 at 07:08:24AM +0200, Miklos Szeredi wrote:
> On Wed, 18 Aug 2021 at 05:40, JeffleXu <jefflexu@linux.alibaba.com> wrote:
> 
> > I'm not sure if I fully understand your idea. Then in this case, host
> > daemon only prepares 4KB while guest thinks that the whole DAX window
> > (e.g., 2MB) has been fully mapped. Then when guest really accesses the
> > remained part (2MB - 4KB), page fault is triggered, and now host daemon
> > is responsible for downloading the remained part?
> 
> Yes.  Mapping an area just means setting up the page tables, it does
> not result in actual data transfer.

But daemon will not get the page fault (its the host kernel which
will handle it). And host kernel does not know that file chunk 
needs to be downloaded.

- Either we somehow figure out user fault handling and somehow
  qemu/virtiofsd get to handle the page fault then they can
  download file.

- Or we download the 2MB chunk at the FUSE_SETUPMAPPING time so
  that later kernel fault can handle it.

Am I missing something.

Vivek

