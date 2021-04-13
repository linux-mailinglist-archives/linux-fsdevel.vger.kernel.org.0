Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F8435E7A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 22:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348236AbhDMUlg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 16:41:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241931AbhDMUlf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618346475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bJQMkeUjT9KF4eEXY9TfAwJ1xFGxyGdcFU5piXvMFcs=;
        b=NKKXmNzuzxcRnYQ8AHYtguZ/AfXHuvMfwADo0Qv49UHGBzTfpuipLg7j/D07oxJYVOXr/V
        Al9b3zfkF3dMnrtXAlaX6JsUZ+ekuqVIHbulfWa4IgFCUeFmLJY/yxxKt8GriGBXWikSMA
        BltryZ6E2MwpUNMGDc7fAC2JRh14B9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-FZE2aXeANyGTS-bQn-87Mw-1; Tue, 13 Apr 2021 16:41:10 -0400
X-MC-Unique: FZE2aXeANyGTS-bQn-87Mw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7555D195D587;
        Tue, 13 Apr 2021 20:41:09 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-152.rdu2.redhat.com [10.10.116.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E65EC67C7B;
        Tue, 13 Apr 2021 20:41:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 72E1022054F; Tue, 13 Apr 2021 16:41:02 -0400 (EDT)
Date:   Tue, 13 Apr 2021 16:41:02 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     seth.forshee@canonical.com
Subject: Re: [Virtio-fs] [PATCH v2 0/2] fuse: Fix clearing SGID when access
 ACL is set
Message-ID: <20210413204102.GK1235549@redhat.com>
References: <20210325151823.572089-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325151823.572089-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

Ping for this patch series.

Vivek

On Thu, Mar 25, 2021 at 11:18:21AM -0400, Vivek Goyal wrote:
> 
> Hi,
> 
> This is V2 of the patchset. Posted V1 here.
> 
> https://lore.kernel.org/linux-fsdevel/20210319195547.427371-1-vgoyal@redhat.com/
> 
> Changes since V1:
> 
> - Dropped the helper to determine if SGID should be cleared and open
>   coded it instead. I will follow up on helper separately in a different
>   patch series. There are few places already which open code this, so
>   for now fuse can do the same. Atleast I can make progress on this
>   and virtiofs can enable ACL support.
> 
> Luis reported that xfstests generic/375 fails with virtiofs. Little
> debugging showed that when posix access acl is set that in some
> cases SGID needs to be cleared and that does not happen with virtiofs.
> 
> Setting posix access acl can lead to mode change and it can also lead
> to clear of SGID. fuse relies on file server taking care of all
> the mode changes. But file server does not have enough information to
> determine whether SGID should be cleared or not.
> 
> Hence this patch series add support to send a flag in SETXATTR message
> to tell server to clear SGID.
> 
> I have staged corresponding virtiofsd patches here.
> 
> https://github.com/rhvgoyal/qemu/commits/acl-sgid-setxattr-flag
> 
> With these patches applied "./check -g acl" passes now on virtiofs.
> 
> Thanks
> Vivek
> 
> Vivek Goyal (2):
>   fuse: Add support for FUSE_SETXATTR_V2
>   fuse: Add a flag FUSE_SETXATTR_ACL_KILL_SGID to kill SGID
> 
>  fs/fuse/acl.c             |  8 +++++++-
>  fs/fuse/fuse_i.h          |  5 ++++-
>  fs/fuse/inode.c           |  4 +++-
>  fs/fuse/xattr.c           | 21 +++++++++++++++------
>  include/uapi/linux/fuse.h | 17 +++++++++++++++++
>  5 files changed, 46 insertions(+), 9 deletions(-)
> 
> -- 
> 2.25.4
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://listman.redhat.com/mailman/listinfo/virtio-fs

