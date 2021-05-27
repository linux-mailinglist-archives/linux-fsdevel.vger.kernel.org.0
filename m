Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FC1392F7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 15:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbhE0N0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 09:26:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236427AbhE0N0Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 09:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622121892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tqJQNOn7DWmp0pgLeisvZKd/7HE3qz0sKxqjO7g98TY=;
        b=i2Q5AiOOT6t9kGaRbzd55dFwujGiN1cP2oJFsUHvghqZwfvO3oVdAPaDj7+QlaURbnh3ZO
        0/dOO8ZOOG75TylHHxlf6x0EinxmqRjL00pI+rhf06MtxPA3VokKsqXolE7sWzKeF55sqg
        bHwtVRrSi4Ln6EQayX4eMnPft1E81ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-8xbl90x9Oveo5HJ1nauIug-1; Thu, 27 May 2021 09:24:48 -0400
X-MC-Unique: 8xbl90x9Oveo5HJ1nauIug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54250824F8F;
        Thu, 27 May 2021 13:24:46 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-232.ams2.redhat.com [10.36.114.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC2316061F;
        Thu, 27 May 2021 13:24:41 +0000 (UTC)
Subject: Re: [Virtio-fs] [PATCH 3/4] fuse: Call vfs_get_tree() for submounts
To:     Greg Kurz <groug@kaod.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
References: <20210525150230.157586-1-groug@kaod.org>
 <20210525150230.157586-4-groug@kaod.org>
From:   Max Reitz <mreitz@redhat.com>
Message-ID: <7b4a3379-3004-98f2-841c-386ce62c888a@redhat.com>
Date:   Thu, 27 May 2021 15:24:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210525150230.157586-4-groug@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25.05.21 17:02, Greg Kurz wrote:
> We recently fixed an infinite loop by setting the SB_BORN flag on
> submounts along with the write barrier needed by super_cache_count().
> This is the job of vfs_get_tree() and FUSE shouldn't have to care
> about the barrier at all.
> 
> Split out some code from fuse_dentry_automount() to a new dedicated
> fuse_get_tree_submount() handler for submounts and call vfs_get_tree().
> 
> The fs_private field of the filesystem context isn't used with
> submounts : hijack it to pass the FUSE inode of the mount point
> down to fuse_get_tree_submount().

What exactly do you mean by “isn’t used”?  virtio_fs_init_fs_context() 
still sets it (it is non-NULL in fuse_dentry_automount() after 
fs_context_for_submount()).  It does appear like it is never read, but 
one thing that definitely would need to be done is for it to be freed 
before putting mp_fi there.

So I think it may technically be fine to use this field, but then 
virtio_fs_init_fs_context() shouldn’t set it for submounts (should be 
discernible with fsc->purpose), and perhaps that should be a separate patch.

(Apart from that, this patch looks good to me, though.)

Max

> Finally, adapt virtiofs to use this.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   fs/fuse/dir.c       | 58 +++++++--------------------------------------
>   fs/fuse/fuse_i.h    |  6 +++++
>   fs/fuse/inode.c     | 44 ++++++++++++++++++++++++++++++++++
>   fs/fuse/virtio_fs.c |  3 +++
>   4 files changed, 62 insertions(+), 49 deletions(-)

