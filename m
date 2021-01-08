Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3962EF44F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 16:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbhAHPAS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 10:00:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbhAHPAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610117931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ccuFIC4NVahQ4gA16/nIVWWtycpnNVr85ymKznUYlas=;
        b=EJoDewCxrdxfDn/8X4Z7GgcMxScBB043FyCa5Fyi9hnG/uQYZ5Sq2sC20xDmTf1sgz9k+Z
        wn5fVSpE1sbhU/lmQ3wsa593P01h9nyTcbTmpL/+IxsxlnLltPI9vQ+LxR6vL0NCfpPFMv
        cccWJQdrhiH0MBV60Jz6dmlDxiS6DQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-XDo3koWvM2qBILZwIElmmg-1; Fri, 08 Jan 2021 09:58:49 -0500
X-MC-Unique: XDo3koWvM2qBILZwIElmmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C992107B462;
        Fri,  8 Jan 2021 14:58:48 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 725E5629C0;
        Fri,  8 Jan 2021 14:58:48 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 6655E18095C7;
        Fri,  8 Jan 2021 14:58:48 +0000 (UTC)
Date:   Fri, 8 Jan 2021 09:58:46 -0500 (EST)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Satya Tangirala <satyat@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Message-ID: <1568673558.43563383.1610117926358.JavaMail.zimbra@redhat.com>
In-Reply-To: <879072186.43549344.1610111831181.JavaMail.zimbra@redhat.com>
References: <20201224044954.1349459-1-satyat@google.com> <20210107162000.GA2693@lst.de> <1137375419.42956970.1610036857271.JavaMail.zimbra@redhat.com> <X/eUd4iLxnl2nYRF@google.com> <879072186.43549344.1610111831181.JavaMail.zimbra@redhat.com>
Subject: Re: [PATCH] fs: Fix freeze_bdev()/thaw_bdev() accounting of
 bd_fsfreeze_sb
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.112.201, 10.4.195.26]
Thread-Topic: Fix freeze_bdev()/thaw_bdev() accounting of bd_fsfreeze_sb
Thread-Index: Qh0Y8TOdr+3c+YdH/MUolaQzVBj28yl6kjYT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

> This is the bigger issue, and I'm not very familiar with this code either,
> so I'll defer to the experts. Yes, it's a change in behavior, but I think
> it makes sense to decrement the bd_fsfreeze_count in this case. Here's why:
> 
> If the blockdev is frozen by freeze_bdev while it's being unmounted, the
> bd_fsfreeze_count is incremented, but the freeze is ignored. Subsequent
> attempts to thaw the device will be ignored but return 0 because the sb
> is not found. When the device is mounted again, calls to freeze_bdev
> will bypass the call to freeze_super for the newly mounted sb, because
> bdev->bd_fsfreeze_count was then incremented from 1 to 2 in freeze_bdev.
> 
> 	if (++bdev->bd_fsfreeze_count > 1)
> 		goto done;
> 
> So you're freezing the device without really freezing the superblock.
> Seems like dangerous behavior to me. The new sb will only be frozen if
> a second thaw is done, which gets them back in sync. I suppose we could
> say this is acceptable loss, and your number of thaws should match your
> freezes, and if they don't: user error. Still, it seems like we should do
> something about it, like refuse to mount a frozen device. Perhaps it already
> does that; I'll need to do some research.

After some experiments, I've determined that my fears about the count are unfounded.
Consider my patch withdrawn. Sorry for the noise.

Bob Peterson

