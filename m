Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA472DE949
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 19:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgLRSvM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 13:51:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726137AbgLRSvM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 13:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608317385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mu9mY5uhyKSd1nOZhoF3bMk566AK2t1HfVACnYE+V/s=;
        b=aH6DCUooZRFyqNZ4MTs21U79DGDTaF1ZhlixZmS8fEloFOySgLHe5AtcxfQyv+oJeVTywB
        PGQEBPiojBY0oB0QTa3rwEf7iaeS/N5d2sJTNyXH4DxIxkV84eD6ydGGTk0zdf7yEm/Q+n
        GXtTnGuNbXbJKIAK5FZ8fkVB6yZIx3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-ZAmeYbrQMPSBAE1h56acAA-1; Fri, 18 Dec 2020 13:49:41 -0500
X-MC-Unique: ZAmeYbrQMPSBAE1h56acAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43B04801817;
        Fri, 18 Dec 2020 18:49:40 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA8995C1C5;
        Fri, 18 Dec 2020 18:49:39 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: how to track down cause for EBUSY on /dev/vda4?
References: <CAJCQCtQUvyopGxBcXzenTy8MuEvm+W1PQNqzFf1Qp=p1M9pBGQ@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 18 Dec 2020 13:49:53 -0500
In-Reply-To: <CAJCQCtQUvyopGxBcXzenTy8MuEvm+W1PQNqzFf1Qp=p1M9pBGQ@mail.gmail.com>
        (Chris Murphy's message of "Thu, 17 Dec 2020 13:13:54 -0700")
Message-ID: <x49sg83t0dq.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chris Murphy <lists@colorremedies.com> writes:

> Hi,
>
> Short version:
> # mkfs.any /dev/vda4
> unable to open /dev/vda4: Device or resource busy
>
> Curiously /dev/vda4 is just a blank partition, not in use by anything
> that I'm aware of. And gdisk is allowed to modify the GPT on /dev/vda
> without complaint. This is a snippet from strace of the above command
> at the failure point:
>
> openat(AT_FDCWD, "/dev/vda4", O_RDWR|O_EXCL) = -1 EBUSY (Device or
> resource busy)

[snip]

> format, and /proc/mounts shows
>
> /dev/vda /run/initramfs/live iso9660
> ro,relatime,nojoliet,check=s,map=n,blocksize=2048 0 0

That mount claims the device, and you can't then also open a partition
on that device exclusively.

> So it sees the whole vda device as iso9660 and ro? But permits gdisk
> to modify some select sectors on vda? I admit it's an ambiguous image.
> Is it a duck or is it a rabbit? And therefore best to just look at it,
> not make modifications to it. Yet /dev/vda is modifiable, where the
> partitions aren't. Hmm.

The file system is mounted read-only.  It may be that the /device/ is not
read-only.

HTH,
Jeff

