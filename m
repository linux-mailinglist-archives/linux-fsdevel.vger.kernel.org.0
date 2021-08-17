Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFFD3EECBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 14:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhHQMuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 08:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229539AbhHQMuD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 08:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629204570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vcCKqyTQplJmhM6jbmzOZVZZmwW62f89g7PD6tqdQoc=;
        b=DDbQB0PPCqHQDgPzRSQx3tZAKhadpNe9yotWiSh9/h/qgRpZtVJAx2lfmJ5gKnGw0UUXf7
        EE00gE5EtYzU7HwpCre8UuQ7iTXyUmq0xd8Dk+lAe0ycKR+cQK5T9vQLa7CgTgXNAesmUn
        SrRNrG+/33Ge4X+7GEi0956QJTHe7ew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-lnzeZJRfOcihOzliFUjK4w-1; Tue, 17 Aug 2021 08:49:28 -0400
X-MC-Unique: lnzeZJRfOcihOzliFUjK4w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A49B1026200;
        Tue, 17 Aug 2021 12:49:27 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.10.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BB4769280;
        Tue, 17 Aug 2021 12:49:23 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7D68F2281A8; Tue, 17 Aug 2021 08:40:38 -0400 (EDT)
Date:   Tue, 17 Aug 2021 08:40:38 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [Virtio-fs] [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
Message-ID: <YRuuRo8jEs5dkfw9@redhat.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRuCHvhICtTzMK04@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRuCHvhICtTzMK04@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 17, 2021 at 10:32:14AM +0100, Dr. David Alan Gilbert wrote:
> * Miklos Szeredi (miklos@szeredi.hu) wrote:
> > On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> > >
> > > This patchset adds support of per-file DAX for virtiofs, which is
> > > inspired by Ira Weiny's work on ext4[1] and xfs[2].
> > 
> > Can you please explain the background of this change in detail?
> > 
> > Why would an admin want to enable DAX for a particular virtiofs file
> > and not for others?
> 
> Where we're contending on virtiofs dax cache size it makes a lot of
> sense; it's quite expensive for us to map something into the cache
> (especially if we push something else out), so selectively DAXing files
> that are expected to be hot could help reduce cache churn.

In that case probaly we should just make DAX window larger. I assume
that selecting which files to turn DAX on, will itself will not be
a trivial. Not sure what heuristics are being deployed to determine
that. Will like to know more about it.

Vivek

