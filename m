Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E0C44E73E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 14:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbhKLN0y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 08:26:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234440AbhKLN0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 08:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636723441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V0x70aOSjj4juyUQjyZjwm3PmchvbNbWWsusOMomWSY=;
        b=Nj7buJAoAj74NVBm3cieF3pmF3zA2AA/oDuNVCGf2DJo3/VlLn2WlUgRUIhAPrPXgyzamQ
        /42miFyAqVihWqsHYnCQl8R751ig25lKQl1S94vDWQDl6GySMoUDhkoOGofVMzHgTtHbn/
        Xvoi5BC8C49SAnkgmiw3NevsPnY1z1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-yDqGPiWaOQqk18Zf6QR59A-1; Fri, 12 Nov 2021 08:23:58 -0500
X-MC-Unique: yDqGPiWaOQqk18Zf6QR59A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0BCA9F92F;
        Fri, 12 Nov 2021 13:23:56 +0000 (UTC)
Received: from localhost (ovpn-12-197.pek2.redhat.com [10.72.12.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC7A267840;
        Fri, 12 Nov 2021 13:23:28 +0000 (UTC)
Date:   Fri, 12 Nov 2021 21:23:26 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v1] proc/vmcore: fix clearing user buffer by properly
 using clear_user()
Message-ID: <20211112132326.GA16071@MiWiFi-R3L-srv>
References: <20211111191800.21281-1-david@redhat.com>
 <20211112070113.GA19016@MiWiFi-R3L-srv>
 <21bdcecd-127c-f70e-0c7d-cb1b97caecb0@redhat.com>
 <20211112090116.GC19016@MiWiFi-R3L-srv>
 <CADFyXm7uS3GN1AnF-iLpUZMFK=MwF3=NGwSZFqXPA+kK182-cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADFyXm7uS3GN1AnF-iLpUZMFK=MwF3=NGwSZFqXPA+kK182-cQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/12/21 at 10:08am, David Hildenbrand wrote:
> > > "that allows supervisor mode programs to optionally set user-space
> > > memory mappings so that access to those mappings from supervisor mode
> > > will cause a trap. This makes it harder for malicious programs to
> > > "trick" the kernel into using instructions or data from a user-space
> > > program"
> >
> > OK, probably. I thought it's triggered in access_ok(), and tried to
> > figure out why. But seems we should do something to check this in
> > access_ok(), otherwise the logic of clear_user/_clear_user is not so
> > reasonable. Anyway, I have learned it, thanks a lot for digging it out.
> >
> > By the way, I can't open above wiki article, found below commit from
> > hpa. Maybe we can add some into log to tell this, not strong opinin,
> > leave it to you.
> 
> Yes, now that we know the root cause I'll add some more details to the
> patch description and resend -- thanks Baoquan!

Thanks for sending v2.

