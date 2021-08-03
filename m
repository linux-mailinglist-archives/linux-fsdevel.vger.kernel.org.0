Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64463DEB64
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 12:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbhHCLAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 07:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235348AbhHCLAA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627988389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lK2SfIHZ2Ac99hQ34j8+KB0YK297k6V7x/Zwpz7e1/A=;
        b=fJUbLrxSP+DQDTKssD30kbeNQoKTxmipTUkXnqBbJollK7dHiNpoi3yz23swIbEvu3H4H5
        Pqhuy6WbqVd5oFIgnZ0TzgZfcyKexiHL67Mi6agmUV+DsIIQBmoA+PqqthFGofaEjkDVlu
        +VwSnVOCHuQQuIsGOdIzj/kzXDchNwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-imAsvqABNjigDaIHhUijNg-1; Tue, 03 Aug 2021 06:59:47 -0400
X-MC-Unique: imAsvqABNjigDaIHhUijNg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF2228799E0;
        Tue,  3 Aug 2021 10:59:45 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B5AA60C05;
        Tue,  3 Aug 2021 10:59:42 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, linux-s390@vger.kernel.org,
        Jia He <hejianet@gmail.com>,
        Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH 0/2] Fix /proc/sys/fs/nfs/nsm_use_hostnames on big endian machines
Date:   Tue,  3 Aug 2021 12:59:35 +0200
Message-Id: <20210803105937.52052-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is an endianess problem with /proc/sys/fs/nfs/nsm_use_hostnames
(which can e.g. be seen on an s390x host) :

 # modprobe lockd nsm_use_hostnames=1
 # cat /proc/sys/fs/nfs/nsm_use_hostnames
 16777216

The nsm_use_hostnames variable is declared as "bool" which is required
for the correct type for the module parameter. However, this does not
work correctly with the entry in the /proc filesystem since this
currently requires "int".

Jia He already provided patches for this problem a couple of years ago,
but apparently they felt through the cracks and never got merged. So
here's a rebased version to finally fix this issue.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1764075

Jia He (2):
  sysctl: introduce new proc handler proc_dobool
  lockd: change the proc_handler for nsm_use_hostnames

 fs/lockd/svc.c         |  2 +-
 include/linux/sysctl.h |  2 ++
 kernel/sysctl.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.27.0

