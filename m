Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EB43EECC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 14:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbhHQMuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 08:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229539AbhHQMuI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 08:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629204575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xncVMYj4I8zKo79uuJkhEb9a+TNyKb9f4/f8x3DpaAI=;
        b=LHeafVg7mbkc9jRtlZQTI1p1oFRFaMmDd19R7YZYUSY7O9NocUVrO2Cpcm9i339LbeteIS
        10+vagYf2LesNteNipKujo3LVsDOQoufNiOnaPGb0H9Iu7O0auuVf0AEIdaZC8Vy0gNT12
        oDRCcXnFXfqHdWeMOSD8k2scEVtZHNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-kdxSo6RsMOKNgZGGOCZe3A-1; Tue, 17 Aug 2021 08:49:32 -0400
X-MC-Unique: kdxSo6RsMOKNgZGGOCZe3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD485192CC4F;
        Tue, 17 Aug 2021 12:49:30 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.10.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BB68620DE;
        Tue, 17 Aug 2021 12:49:23 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B210D220637; Tue, 17 Aug 2021 08:39:02 -0400 (EDT)
Date:   Tue, 17 Aug 2021 08:39:02 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
Message-ID: <YRut5sioYfc2M1p7@redhat.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 17, 2021 at 10:06:53AM +0200, Miklos Szeredi wrote:
> On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> >
> > This patchset adds support of per-file DAX for virtiofs, which is
> > inspired by Ira Weiny's work on ext4[1] and xfs[2].
> 
> Can you please explain the background of this change in detail?
> 
> Why would an admin want to enable DAX for a particular virtiofs file
> and not for others?

Initially I thought that they needed it because they are downloading
files on the fly from server. So they don't want to enable dax on the file
till file is completely downloaded. But later I realized that they should
be able to block in FUSE_SETUPMAPPING call and make sure associated
file section has been downloaded before returning and solve the problem.
So that can't be the primary reason.

Other reason mentioned I think was that only certain files benefit
from DAX. But not much details are there after that. It will be nice
to hear a more concrete use case and more details about this usage.

Thanks
Vivek

