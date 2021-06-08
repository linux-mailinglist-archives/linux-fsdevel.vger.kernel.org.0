Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA8A3A0457
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 21:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbhFHTcF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 15:32:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237555AbhFHT2T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623180384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LPDqsEBP/MDK1aKd0nqXwm2OMJM183ITXNbTcctz3N8=;
        b=L4dGllb5cWYWby6qsKnCXbkFMxJFYQQ+pctsoRjdNoeOEVnoYb2Nf88t9k5G/E9X7o6eHL
        pjNiMn0fHlXee4Py5txzwGEBwAbKGWphMeASpECYxRqU0coP39gurd+gb79tMMljT3VyD0
        JQ8vr72NXeXfQq8bC0EPND8UZrusJ20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-5-T2Gw-wOvKmizB1GzmYSg-1; Tue, 08 Jun 2021 15:26:23 -0400
X-MC-Unique: 5-T2Gw-wOvKmizB1GzmYSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8872107ACCD;
        Tue,  8 Jun 2021 19:26:21 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-35.rdu2.redhat.com [10.10.114.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C5315D9E3;
        Tue,  8 Jun 2021 19:26:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E422222054F; Tue,  8 Jun 2021 15:26:17 -0400 (EDT)
Date:   Tue, 8 Jun 2021 15:26:17 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     "Harry G. Coin" <hgcoin@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [Virtio-fs] [PATCH] init/do_mounts.c: Add root="fstag:<tag>"
 syntax for root device
Message-ID: <20210608192617.GC504497@redhat.com>
References: <20210608153524.GB504497@redhat.com>
 <8929c252-3d99-8cdb-1c56-5fdb1fd29fc2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8929c252-3d99-8cdb-1c56-5fdb1fd29fc2@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 08, 2021 at 01:38:56PM -0500, Harry G. Coin wrote:
> On 6/8/21 10:35 AM, Vivek Goyal wrote:
> > We want to be able to mount virtiofs as rootfs and pass appropriate
> > kernel command line. Right now there does not seem to be a good way
> > to do that. If I specify "root=myfs rootfstype=virtiofs", system
> > panics.
> >
> > virtio-fs: tag </dev/root> not found
> > ..
> > ..
> > [ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0) ]
> 
> Whatever the best direction forward might be for kernel patches
> regarding 'not block device as root', it would ease learning curves if
> 'the patterns that set config issue X' were the same across root 'not
> block device options' whether cephfs, nfs, 9p, virtiofs.

I think achieveing same pattern for all non-block options is pretty
hard. There are too many varieits, mtd, ubifs, nfs, cifs, and you
just mentioned cephfs.

It would be nice if somebody can achieve it. But that should not be
a blocker for this patch. Goal of this patch is to take care of virtiofs
and 9p. And any other filesystem which can work with this pattern.

I think ubi and mtd should be able to work with "root=fstag:<tag>"
as well. Something like "root=fstag:ubi:foo". And then ubi:foo
will should be passed to ubifs. I think only thing missing is
that current code assumes there is one filesystem passed in
rootfstype. If we want to try mounting device with multiple
filesystems then one can modify the code to call do_mount_root()
in a loop from a filesystem list.

Right now I did not need it, so I did not add it.

> All of them
> will have to handle the selinux xattr/issue, posix and flock issues,
> caching etc.

Filesystem specific flags will be passed by rootflags=.

> While by definition virtiofs has to exist only in a vm
> guest, the others could be baremetal or vm guest roots.  (How much 9p's
> other-than-guest transports are used I don't know).
> 
> FYI (though patching the kernel may be the best option)  there is a case
> that does not have those kernel panics for virtiofs-root and 9p root
> using stock fc34.  As 9p, the virtiofs method uses the initrd creation
> mechanisms provided by 'dracut' or 'initramfs' to provide the 'sysroot
> pivot glue'.
> 
> On the fc34 guest a successful 'direct kernel boot' today looks like:
> 
> kernel path: /vmsystems/fedora_generic/boot/vmlinuz
> 
> initrd path: /vmsystems/fedora_generic/boot/initrd.img
> 
> Kernel args: root=virtiofs:myfs rd.shell rd.fstab

Does it work with upstream dracut or you have modified dracut to
parse "root=virtiofs:myfs" option.

I think it probably is better that both kernel and dracut parse
and understand same "root=" format string and I will try to
avoid creating a "root=" option which dracut understands but
not kernel. Or try creating two different wasy to mount 
virtiofs using "root=" for kernel and dracut.

That's why I am first trying to get this new syntax in the kernel
and once it works, I want to follow up with dracut folks to
parse "root=fstag:<tag>" and be able to mount virtiofs/9p/foo
filesystem.

Thanks
Vivek

> 
> 
> The xml to pass through virtio-fs is:
> 
> <filesystem type="mount" accessmode="passthrough">
>   <driver type="virtiofs" queue="1024"/>
>   <binary xattr="on">
>     <lock posix="on" flock="on"/>
>   </binary>
>   <source dir="/vmsystems/fedora_generic"/>
>   <target dir="myfs"/>
> </filesystem>
> 
> The guest fstab is:
> 
> myfs / virtiofs defaults 0 0
> 
> HTH
> 
> Harry Coin
> 
> 
> 

