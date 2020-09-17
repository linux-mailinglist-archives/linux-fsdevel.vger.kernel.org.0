Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE35226E459
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 20:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgIQSpz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 14:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24460 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbgIQSpq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600368345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L8gcGmqClvD9NFWKHbVnJbSGJrEsu3J52I1o2pikmbo=;
        b=UoG5pve0Ppe19i4lN7lLQ2Rjyrv3IoPz3xukTZOinlFRepuFvSyxJIScmBalTwuDqW3eLg
        E1ZGsNfV/QK9cWtlE9W/3uQSXCINvgrwDKmTOI3+zdxAgsevCkVrkS4v/jjju4iAyxKcDi
        ZxcdQuUAlnBkTKaPAMaeZ4+xgktNExo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-zMNHokvrMHa2Lpz-8Z2UDg-1; Thu, 17 Sep 2020 14:45:43 -0400
X-MC-Unique: zMNHokvrMHa2Lpz-8Z2UDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C56BE802B56;
        Thu, 17 Sep 2020 18:45:41 +0000 (UTC)
Received: from ovpn-66-148.rdu2.redhat.com (ovpn-66-148.rdu2.redhat.com [10.10.66.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FA215DA30;
        Thu, 17 Sep 2020 18:45:41 +0000 (UTC)
Message-ID: <afcea1c4d35a99b271622b34364a479dfda9dab2.camel@redhat.com>
Subject: Re: slab-out-of-bounds in iov_iter_revert()
From:   Qian Cai <cai@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     torvalds@linux-foundation.org, vgoyal@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Sep 2020 14:45:40 -0400
In-Reply-To: <20200917164432.GU3421308@ZenIV.linux.org.uk>
References: <20200911215903.GA16973@lca.pw>
         <20200911235511.GB3421308@ZenIV.linux.org.uk>
         <87ded87d232d9cf87c9c64495bf9190be0e0b6e8.camel@redhat.com>
         <20200917020440.GQ3421308@ZenIV.linux.org.uk>
         <20200917021439.GA31009@ZenIV.linux.org.uk>
         <e815399a4a123aa7cc096a55055f103874db1e75.camel@redhat.com>
         <20200917164432.GU3421308@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-09-17 at 17:44 +0100, Al Viro wrote:
> On Thu, Sep 17, 2020 at 10:10:27AM -0400, Qian Cai wrote:
> 
> > [   81.942909]  generic_file_read_iter+0x23b/0x4b0
> > [   81.942918]  fuse_file_read_iter+0x280/0x4e0 [fuse]
> > [   81.942931]  ? fuse_direct_IO+0xd30/0xd30 [fuse]
> > [   81.942949]  ? _raw_spin_lock_irqsave+0x80/0xe0
> > [   81.942957]  ? timerqueue_add+0x15e/0x280
> > [   81.942960]  ? _raw_spin_lock_irqsave+0x80/0xe0
> > [   81.942966]  new_sync_read+0x3b7/0x620
> > [   81.942968]  ? __ia32_sys_llseek+0x2e0/0x2e0
> 
> Interesting...  Basic logics in there:
> 	->direct_IO() might consume more (on iov_iter_get_pages()
> and friends) than it actually reads.  We want to revert the
> excess.  Suppose by the time we call ->direct_IO() we had
> N bytes already consumed and C bytes left.  We expect that
> after ->direct_IO() returns K, we have C' bytes left, N + (C - C')
> consumed and N + K out of those actually read.  So we revert by
> C - K - C'.  You end up trying to revert beyond the beginning.
> 
> 	Use of iov_iter_truncate() is problematic here, since it
> changes the amount of data left without having consumed anything.
> Basically, it changes the position of end, and the logics in the
> caller expects that to remain unchanged.  iov_iter_reexpand() use
> should restore the position of end.
> 
> 	How much IO does it take to trigger that on your reproducer?

I can even reproduce this with a single child of the trinity:

https://people.redhat.com/qcai/iov_iter_revert/single/

[   77.841021] BUG: KASAN: stack-out-of-bounds in iov_iter_revert+0x693/0x8c0
[   77.842055] Read of size 8 at addr ffff8886efe47d98 by task trinity-c0/1449

