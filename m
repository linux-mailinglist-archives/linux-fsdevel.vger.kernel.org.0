Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B2738C193
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 10:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhEUIVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 04:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhEUIVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 04:21:16 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642CCC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 01:19:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n2so29197486ejy.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 01:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9BT3Hx3P3B8a0YB8xDWcQzYi30cUttNenzj/Q+a2BuE=;
        b=ZHFefVH2NnwfN6qqSETR6RWg6qE1d8/n84IVK9M8F1u0akSKx5Q7ErkV1KbVW9x27l
         7HFRXFibKZd8ahV6ZQDpItgA6t0mQgPNTf8kbuXC+4bTQW8iIJKVPqXdy3KpKqnIO12q
         xIxpuQl4VdPbLn0x6bDDouPcKq/civ6NhsluI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9BT3Hx3P3B8a0YB8xDWcQzYi30cUttNenzj/Q+a2BuE=;
        b=cPUf/Z+n7C1eifOh/RJIb8kGCMzprOfmuBVINxRnUOSSM/mgxQVOH7Lt8niyWH763K
         VBQz2X9ZVRmb7U+t1jp3ZA75wRh6leWuJw8emQrD8DDEYDAEVVukf+BvN0/Ui32qbLYj
         kzXDPKR0ncfDDOmqDzMnRHIgEaIuhRwUI991saRdok+w+1Z9IX+aCgUT6DEvyJBZYD/X
         SAsiGfz63g5pH/pI4a6Vmjebyc4BP/kxPnmS/UuxGpn2SwMMG6+fYpoUsp2vGcoqaBLj
         8kV3p99JkW8dVS5lXbWzpCNCWG7X0ydXwHM5Zl3hnBVt/23xpDtbb7VqE5So4BQDZw/x
         MmUg==
X-Gm-Message-State: AOAM531BsaVlV/AZw905aZ/Enf/q1ub71k46sgmd7lm6swSpqUDQQKl8
        kUumVwaLkA1zE1abFKDlwI2+uQ==
X-Google-Smtp-Source: ABdhPJweDLurcYoAxJbcGquDPxDbAsqw+ElGRnNzi50Pf4B9Y5CiAUMwpvG4vz0XFzlw19EIQ7O+nA==
X-Received: by 2002:a17:906:368e:: with SMTP id a14mr9079440ejc.366.1621585191245;
        Fri, 21 May 2021 01:19:51 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id l19sm3373181edv.17.2021.05.21.01.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 01:19:50 -0700 (PDT)
Date:   Fri, 21 May 2021 10:19:48 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Greg Kurz <groug@kaod.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 2/5] fuse: Call vfs_get_tree() for submounts
Message-ID: <YKdtJCo/06q594pM@miu.piliscsaba.redhat.com>
References: <20210520154654.1791183-1-groug@kaod.org>
 <20210520154654.1791183-3-groug@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520154654.1791183-3-groug@kaod.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 20, 2021 at 05:46:51PM +0200, Greg Kurz wrote:
> We don't set the SB_BORN flag on submounts superblocks. This is wrong
> as these superblocks are then considered as partially constructed or
> dying in the rest of the code and can break some assumptions.
> 
> One such case is when you have a virtiofs filesystem and you try to
> mount it again : virtio_fs_get_tree() tries to obtain a superblock
> with sget_fc(). The matching criteria in virtio_fs_test_super() is
> the pointer of the underlying virtiofs device, which is shared by
> the root mount and its submounts. This means that any submount can
> be picked up instead of the root mount. This is itself a bug :
> submounts should be ignored in this case. But, most importantly, it
> then triggers an infinite loop in sget_fc() because it fails to grab
> the superblock (very easy to reproduce).
> 
> The only viable solution is to set SB_BORN at some point. This
> must be done with vfs_get_tree() because setting SB_BORN requires
> special care, i.e. a memory barrier for super_cache_count() which
> can check SB_BORN without taking any lock.

Looks correct, but...

as an easily backportable and verifiable bugfix I'd still go with the
simple two liner:

--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -351,6 +351,9 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
 	list_add_tail(&fm->fc_entry, &fc->mounts);
 	up_write(&fc->killsb);
 
+	smp_wmb();
+	sb->s_flags |= SB_BORN;
+
 	/* Create the submount */
 	mnt = vfs_create_mount(fsc);
 	if (IS_ERR(mnt)) {

And have this patch be the cleanup.

Also we need Fixes: and a Cc: stable@... tags on that one.

Thanks,
Miklos
