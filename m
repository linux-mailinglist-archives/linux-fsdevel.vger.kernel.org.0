Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B15D2A0A6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 16:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgJ3PwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 11:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24312 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727060AbgJ3PwI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604073128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4vb/jEomfVr9t/Z7lT0Li6Y+TLCIwj1uDghjq1gCguw=;
        b=B6Ixb5bgPYXlcWMg6nhkZpEo4sr3rEkvOtfcQ4h++YW2tCiBPvhOw2UFggtZbOUmCWFuRD
        SdvubupQtvKaXR6g0NZ714OU2wCkHzztgFds4D94k+8PpD7C1SM96r6xkiTPyVLD/VIaJx
        VIxVINaEPMrpNPeJI/rx1qHCRrV9KWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-I4Azvlc_PJqI_ZZd-SyNPg-1; Fri, 30 Oct 2020 11:52:03 -0400
X-MC-Unique: I4Azvlc_PJqI_ZZd-SyNPg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4271F393B5;
        Fri, 30 Oct 2020 15:52:01 +0000 (UTC)
Received: from ovpn-66-212.rdu2.redhat.com (ovpn-66-212.rdu2.redhat.com [10.10.66.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90D1B18E45;
        Fri, 30 Oct 2020 15:52:00 +0000 (UTC)
Message-ID: <09fa614adb555358d39ab606a8c6a2d89ba4a11d.camel@redhat.com>
Subject: Re: [PATCH -next] fs: Fix memory leaks in do_renameat2() error paths
From:   Qian Cai <cai@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Fri, 30 Oct 2020 11:52:00 -0400
In-Reply-To: <251c80d6-a2d0-4053-404f-bffd5a53313e@kernel.dk>
References: <20201030152407.43598-1-cai@redhat.com>
         <251c80d6-a2d0-4053-404f-bffd5a53313e@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-10-30 at 09:27 -0600, Jens Axboe wrote:
> On 10/30/20 9:24 AM, Qian Cai wrote:
> > We will need to call putname() before do_renameat2() returning -EINVAL
> > to avoid memory leaks.
> 
> Thanks, should mention that this isn't final by any stretch (which is
> why it hasn't been posted yet), just pushed out for some exposure.

I don't know what other people think about this, but I do find a bit
discouraging in testing those half-baked patches in linux-next where it does not
even ready to post for a review.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=3c5499fa56f568005648e6e38201f8ae9ab88015

