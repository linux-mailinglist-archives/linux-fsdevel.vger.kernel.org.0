Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB5726CD20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 22:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgIPUyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 16:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgIPQxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600275181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7bCQ7MeRu62DOZLtV1EFO2x20MRPYJu/XczjTjBTPpA=;
        b=I5HxHDMVqNejTnduikCn/1Tt//RgKb15ym3o8LS5mBx/BwkdcExq0Ct/pJ8DgCIRi4g4rB
        +1i59qNdfSvviav75vOj7rSz+adWwea6Ar1OJ8Kofjc54t3P16UZMtcUSu31JwZohllKEI
        go3M9HiJEUsJN76BO2FdgPbZbSA2wKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-Sk0eP1QOPDSr7Ms6EvWOUg-1; Wed, 16 Sep 2020 12:17:59 -0400
X-MC-Unique: Sk0eP1QOPDSr7Ms6EvWOUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C26464140;
        Wed, 16 Sep 2020 16:17:58 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-139.rdu2.redhat.com [10.10.116.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D4D95DE86;
        Wed, 16 Sep 2020 16:17:55 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 879732209FD; Wed, 16 Sep 2020 12:17:54 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, virtio-fs@redhat.com
Subject: [PATCH v2 0/6] fuse: Implement FUSE_HANDLE_KILLPRIV_V2 and enable SB_NOSEC
Date:   Wed, 16 Sep 2020 12:17:31 -0400
Message-Id: <20200916161737.38028-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

Please find attached V2 of the patches to enable SB_NOSEC for fuse. I
posted V1 here.

https://lore.kernel.org/linux-fsdevel/20200724183812.19573-1-vgoyal@redhat.com/

I have generated these patches on top of.

https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/log/?h=for-next

Previously I was not keen on implementing FUSE_HANDLE_KILLPRIV_V2 and
implemented another idea to enable SB_NOSEC conditional on server
declaring that filesystem is not shared. But that did not go too
far when it came to requirements for virtiofs.

https://lore.kernel.org/linux-fsdevel/20200901204045.1250822-1-vgoyal@redhat.com/

So I went back to having another look at implementing FUSE_HANDLE_KILLPRIV_V2
and I think it fits nicely and should work nicely with wide variety of
use cases.

I have taken care of feedback from last round. For the case of random
write peformance has jumped from 50MB/s to 250MB/s. So I am really
looking forward to these changes so that fuse/virtiofs performance
can be improved.

Thanks
Vivek 

Vivek Goyal (6):
  fuse: Introduce the notion of FUSE_HANDLE_KILLPRIV_V2
  fuse: Set FUSE_WRITE_KILL_PRIV in cached write path
  fuse: setattr should set FATTR_KILL_PRIV upon size change
  fuse: Kill suid/sgid using ATTR_MODE if it is not truncate
  fuse: Add a flag FUSE_OPEN_KILL_PRIV for open() request
  virtiofs: Support SB_NOSEC flag to improve direct write performance

 fs/fuse/dir.c             | 19 ++++++++++++++++++-
 fs/fuse/file.c            |  7 +++++++
 fs/fuse/fuse_i.h          |  6 ++++++
 fs/fuse/inode.c           | 17 ++++++++++++++++-
 include/uapi/linux/fuse.h | 18 +++++++++++++++++-
 5 files changed, 64 insertions(+), 3 deletions(-)

-- 
2.25.4

