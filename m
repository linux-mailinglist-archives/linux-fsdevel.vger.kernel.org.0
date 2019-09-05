Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F053AAD91
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 23:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391732AbfIEVFo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 17:05:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44884 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391724AbfIEVFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:05:44 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so7955665iog.11;
        Thu, 05 Sep 2019 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8iIlyAotvW4/18LwXApdfEoPXtA2KQQGEH61jRfRVAo=;
        b=sHXnG50SGTAEMamnJiePV25Po8ZEH8WUcAJsqNeVSvbJi4KV0S3Cr5cd8EF4KTFY2V
         t6edZIJhwHxVz8F9u3N4HlECsMSqqGzPFAjMmx4svi8TBzmUhYKBBVi6v9kmaH/o/x80
         Ek3Qzq3OZ+VuIlklEMCtJOa3egi90xym2pFOQrccb0O7QZEvUmRE9opcTD6D247AGajW
         zwqsWZTFHR5M6R8udErfw+cCFHIWFO0cyPY/3c7UociWcrIkXM/nNVhTLNJePRleXzIx
         1OBBvIaWb77euYq/lOP+whcpS7og8UwJa/Pt+MoCYijj+uKwjAfikwk0n1k6lhsyK3nq
         CPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8iIlyAotvW4/18LwXApdfEoPXtA2KQQGEH61jRfRVAo=;
        b=aJem6F5rGPAaa7et8STNxa0B/C0W9ozfucFEWjID7/tEVnOW8uIYhTeB88IERMLI8L
         jfhef2Oh97B7h8X1t9wWZD8Jtj4nrJcFnbxnHe1dRVbSNbB+/zdDGbxuDRMcvcP6K425
         plw5ANd2OEyTDFRl1xtdqk2pFbJsGC9L2B1lD3iLVLueskrgizo2psvKw7CmgDO2MW7I
         D5IPtldzw4v42+G1HHh8nj4Z8Yx+d5ISQwzySsMyLqfr1Fhk3V/dcUXBwdc8d1AjInAE
         HXG4XJlcKn8jz4JGnboa0CmhLmy1FR7qRwaOemzqjG8dSA3nhYoKEz0ilfWZbhVTD8V+
         z7ng==
X-Gm-Message-State: APjAAAWxL+79jahz2W5BanuvtEmeJCvaACxTRfSkSD4Uzh7kgOJ3rRNQ
        J2T5BVZFbKR0IEjnNkQ8mc0O1IGt+XKWU7xSpHQ=
X-Google-Smtp-Source: APXvYqwCvwJOw20p4s9Eazhb+LVC8v7V4AWVLbMPedSP/EC2a4khEk6OwDQ8iZprMwwnnjQxgLX8S/Mf51kbguSXTzY=
X-Received: by 2002:a5d:8444:: with SMTP id w4mr6449112ior.51.1567717543746;
 Thu, 05 Sep 2019 14:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190905190558.25717-1-jlayton@kernel.org>
In-Reply-To: <20190905190558.25717-1-jlayton@kernel.org>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Thu, 5 Sep 2019 23:05:33 +0200
Message-ID: <CAOi1vP_OYDevF9Kn-FU6bEbCY2MG811Hvvshu=Feb3r9MGDMgg@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: Convert ceph to use the new mount API
To:     Jeff Layton <jlayton@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Yan, Zheng" <zyan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 5, 2019 at 9:06 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> From: David Howells <dhowells@redhat.com>
>
> Convert the ceph filesystem to the new internal mount API as the old
> one will be obsoleted and removed.  This allows greater flexibility in
> communication of mount parameters between userspace, the VFS and the
> filesystem.
>
> See Documentation/filesystems/mount_api.txt for more information.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Sage Weil <sage@redhat.com>
> cc: ceph-devel@vger.kernel.org
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  drivers/block/rbd.c          | 341 ++++++++---------
>  fs/ceph/cache.c              |  10 +-
>  fs/ceph/cache.h              |   5 +-
>  fs/ceph/super.c              | 687 +++++++++++++++++------------------
>  fs/ceph/super.h              |   1 -
>  include/linux/ceph/libceph.h |  17 +-
>  net/ceph/ceph_common.c       | 410 +++++++++------------
>  7 files changed, 715 insertions(+), 756 deletions(-)
>
> v2: fix several string parsing bugs in rbd_add_parse_args and rbd_parse_monolithic
>     prefix rbd log message with "rbd:"
>     drop unneeded #undef from ceph_debug.h
>     drop unrelated comment fixes in fs/fs_*.c
>     rebase onto current ceph/testing branch

This is still broken.

A simple "rbd map" works, but option parsing is busted:

  $ sudo rbd map -o ro testimg
  rbd: sysfs write failed
  In some cases useful info is found in syslog - try "dmesg | tail".
  rbd: map failed: (519) Unknown error 519

meaning errno = 519 from write()...

On one of the attempts it crashed in kfree(), probably called from
rbd_parse_monolithic().

Thanks,

                Ilya
