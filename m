Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66303C2736
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jul 2021 18:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhGIQDC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jul 2021 12:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50213 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232426AbhGIQC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jul 2021 12:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625846412;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W8zd5CeolMZZOgiP9R7Wu16S5BIqDudS+X6cBxCBcfY=;
        b=RizSOjPjleoSqQuUY7a/ZEMmPeloeeMwExo87ac4cVRAyE/lVPHsgFKa0Km+IMSVuL8vAP
        cbuufqHPc2oNH3Jy0EMlHum6tOFD/oBVF8P3jQFHvnE+/ZxAUF6Z7YHjcyS+xhzSs7uVb9
        vRWqXsqqzMrPkT+UWwHRJ52zpiVDgmg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-FfBcYcKWPMKcu8X-Lsls2Q-1; Fri, 09 Jul 2021 12:00:11 -0400
X-MC-Unique: FfBcYcKWPMKcu8X-Lsls2Q-1
Received: by mail-qv1-f71.google.com with SMTP id q10-20020a056214018ab029027751ec9742so6652732qvr.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jul 2021 09:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=W8zd5CeolMZZOgiP9R7Wu16S5BIqDudS+X6cBxCBcfY=;
        b=aHCzqDEDGRR/W/ZeQ+gUjpC/D2H+OejQRcCUwH+NTJHZQ9ldc7TBRLFq+wwKDl5qHZ
         veBNRC5rKaQrZbfVns/TImQ/qSWAhwdKcQntWa9ygduv9EyAbqR7Qvlq0rbYONdR2Tny
         +NWPlUoaLpKJXY8m0iFHqNmH30VCMILBe7Soykxn5VGxI5CtrUdAonxXukmKpGq6JqD3
         kA0Y5FYx141mZoshKIa9lXv0Y1u7rkyrX8u00Tq+s6wViK7I2ligm/ezNSTbIapnF32W
         XBdbYA/naNuDpuA3gH38p9BriEnENKvbJy07yKFCM6rEwsDjLkGWveCMnCfteRzBtKLL
         R0Jg==
X-Gm-Message-State: AOAM532DwIGC2naoIYlnQh+UMFCGquZ2I0RNzIU0q3xzDcvpfc6Snz02
        nfLez9+bUBKRsINTqcuK2z05xBIDdCpzfsdoSkHu5z4Ai+XAgv+9CkFGDbxFEOn42i2KCSGemhw
        UR4Y9wjShBnjpblR6L7QPHz79Ow==
X-Received: by 2002:a05:620a:14b5:: with SMTP id x21mr1253982qkj.148.1625846410605;
        Fri, 09 Jul 2021 09:00:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7fgfym/vObH9dS3BXtTYjPpC0DOawx2XrMA8j/rEnnVa/GS7s/gG7r6kSkkmhMgMhzYecxw==
X-Received: by 2002:a05:620a:14b5:: with SMTP id x21mr1253860qkj.148.1625846409623;
        Fri, 09 Jul 2021 09:00:09 -0700 (PDT)
Received: from localhost.localdomain (cpe-74-65-150-180.maine.res.rr.com. [74.65.150.180])
        by smtp.gmail.com with ESMTPSA id d8sm2623910qkk.119.2021.07.09.09.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 09:00:09 -0700 (PDT)
Reply-To: dwalsh@redhat.com
Subject: Re: [RFC PATCH v2 0/1] Relax restrictions on user.* xattr
To:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     virtio-fs@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com, jack@suse.cz
References: <20210708175738.360757-1-vgoyal@redhat.com>
From:   Daniel Walsh <dwalsh@redhat.com>
Organization: Red Hat
Message-ID: <76d4a0ed-7582-cc73-a447-5f2d133c3c24@redhat.com>
Date:   Fri, 9 Jul 2021 12:00:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708175738.360757-1-vgoyal@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/8/21 13:57, Vivek Goyal wrote:
> Hi,
>
> This is V2 of the patch. Posted V1 here.
>
> https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgoyal@redhat.com/
>
> Right now we don't allow setting user.* xattrs on symlinks and special
> files at all. Initially I thought that real reason behind this
> restriction is quota limitations but from last conversation it seemed
> that real reason is that permission bits on symlink and special files
> are special and different from regular files and directories, hence
> this restriction is in place.
>
> Given it probably is not a quota issue (I tested with xfs user quota
> enabled and quota restrictions kicked in on symlink), I dropped the
> idea of allowing user.* xattr if process has CAP_SYS_RESOURCE.
>
> Instead this version of patch allows reading/writing user.* xattr
> on symlink and special files if caller is owner or priviliged (has
> CAP_FOWNER) w.r.t inode.
>
> We need this for virtiofs daemon. I also found one more user. Giuseppe,
> seems to set user.* xattr attrs on unpriviliged fuse-overlay as well
> and he ran into similar issue. So fuse-overlay should benefit from
> this change as well.
>
> Who wants to set user.* xattr on symlink/special files
> -----------------------------------------------------
>
> In virtiofs, actual file server is virtiosd daemon running on host.
> There we have a mode where xattrs can be remapped to something else.
> For example security.selinux can be remapped to
> user.virtiofsd.securit.selinux on the host.
>
> This remapping is useful when SELinux is enabled in guest and virtiofs
> as being used as rootfs. Guest and host SELinux policy might not match
> and host policy might deny security.selinux xattr setting by guest
> onto host. Or host might have SELinux disabled and in that case to
> be able to set security.selinux xattr, virtiofsd will need to have
> CAP_SYS_ADMIN (which we are trying to avoid). Being able to remap
> guest security.selinux (or other xattrs) on host to something else
> is also better from security point of view.
>
> But when we try this, we noticed that SELinux relabeling in guest
> is failing on some symlinks. When I debugged a little more, I
> came to know that "user.*" xattrs are not allowed on symlinks
> or special files.
>
> So if we allow owner (or CAP_FOWNER) to set user.* xattr, it will
> allow virtiofs to arbitrarily remap guests's xattrs to something
> else on host and that solves this SELinux issue nicely and provides
> two SELinux policies (host and guest) to co-exist nicely without
> interfering with each other.
>
> Thanks
> Vivek
>
>
> Vivek Goyal (1):
>    xattr: Allow user.* xattr on symlink and special files
>
>   fs/xattr.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
I just wanted to point out that the work Giuseppe is doing is to support 
nfs homedirs with container runtimes like Rootless Podman.


Basically fuse-overlayfs on top of NFS homedir needs to be able to use 
user xattrs to set file permissions and ownership fields to be 
represented to containers.

Currently NFS Servers do not understand User Namespace and seeing a 
client user attempting to chown to a different user, is blocked on the 
server, even though user namespace on the client allows it.  
fuse-overlay intercepts the chown from the container and writes out the 
user.Xattr the permissions and owner/group as user.Xattrs.  And all the 
server sees is the user modifying the xattrs now chowning the real UID 
of the file.


