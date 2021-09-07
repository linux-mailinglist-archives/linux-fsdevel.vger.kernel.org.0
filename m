Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB472402E2F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 20:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345733AbhIGSMG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 14:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345652AbhIGSMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631038259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ZQ77LfQrAYIlW/IP+7FgGcr5kmtkI9421/WQcrZKBc=;
        b=h340AZlXCxfgaV0G5Icz6OLoBijszXccxd+rB3kaW5VZLC0OT/acnK9VqDXfa0Uj7cptwG
        0Ld9kqrghpTpffGcoesMwVDa3vhli33C0pbnQPuKstFXDlfVkqna4PF/6CfUslqR6sJ9gZ
        0aFombEHfxfVaVlwusZkKbBYwFvF1qw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-TxqX7602Pjijwm8cjH2BZA-1; Tue, 07 Sep 2021 14:10:55 -0400
X-MC-Unique: TxqX7602Pjijwm8cjH2BZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 223B8425D9;
        Tue,  7 Sep 2021 18:10:54 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AA475D9CA;
        Tue,  7 Sep 2021 18:10:48 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9E36E220257; Tue,  7 Sep 2021 14:10:47 -0400 (EDT)
Date:   Tue, 7 Sep 2021 14:10:47 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: [PATCH 2/2] virtiofs: reduce lock contention on fpq->lock
Message-ID: <YTerJ1bvGSfOYjBY@redhat.com>
References: <20210812054618.26057-1-jefflexu@linux.alibaba.com>
 <20210812054618.26057-3-jefflexu@linux.alibaba.com>
 <CAJfpegt48RM_y7mOj5EBcohF0zEmE4D6D7sHNgYgKNgGqDgTsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegt48RM_y7mOj5EBcohF0zEmE4D6D7sHNgYgKNgGqDgTsA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 07, 2021 at 10:57:07AM +0200, Miklos Szeredi wrote:
> On Thu, 12 Aug 2021 at 07:46, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> >
> > From: Liu Bo <bo.liu@linux.alibaba.com>
> >
> > Since %req has been removed from fpq->processing_list, no one except
> > request_wait_answer() is looking at this %req and request_wait_answer()
> > waits only on FINISH flag, it's OK to remove fpq->lock after %req is
> > dropped from the list.
> 
> I'll accept a patch to remove FR_SENT completely from virtiofs.
> 

Recently I was also looking at FR_SENT flag and was wondering if it
is atomic bit flag, then why do we need to take spin lock around it.
Probably we need just some barrier if code needs it but not necessarily
any lock.

But I agree that FR_SENT seems not usable from virtiofs point of view
as we don't have support for interrupt request.

> This flag is used for queuing interrupts but interrupts are not yet
> implemented in virtiofs.    When blocking lock support is added the
> interrupt handling needs to be properly designed.

Hmm.., I did not think about this. I was getting ready to post patches
for blocking posix locks but it does not have any support for interrupting
the locking request (either blocked or queued).

Is implementing interrupt support a requirement for getting blocking
posix lock patches in?

Thanks
Vivek

