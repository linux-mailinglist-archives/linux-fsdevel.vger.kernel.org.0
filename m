Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73BB38C21A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 10:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhEUIk7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 04:40:59 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:34571 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233249AbhEUIk6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 04:40:58 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-2qxIbDPeMrixVUQP_btX0g-1; Fri, 21 May 2021 04:39:31 -0400
X-MC-Unique: 2qxIbDPeMrixVUQP_btX0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87F65106BB24;
        Fri, 21 May 2021 08:39:30 +0000 (UTC)
Received: from bahia.lan (ovpn-112-49.ams2.redhat.com [10.36.112.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 665FA10013D6;
        Fri, 21 May 2021 08:39:22 +0000 (UTC)
Date:   Fri, 21 May 2021 10:39:21 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 4/5] virtiofs: Skip submounts in sget_fc()
Message-ID: <20210521103921.153a243d@bahia.lan>
In-Reply-To: <CAJfpegugQM-ChaGiLyfPkbFr9c=_BiOBQkJTeEz5yN0ujO_O4A@mail.gmail.com>
References: <20210520154654.1791183-1-groug@kaod.org>
        <20210520154654.1791183-5-groug@kaod.org>
        <CAJfpegugQM-ChaGiLyfPkbFr9c=_BiOBQkJTeEz5yN0ujO_O4A@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 21 May 2021 10:26:27 +0200
Miklos Szeredi <miklos@szeredi.hu> wrote:

> On Thu, 20 May 2021 at 17:47, Greg Kurz <groug@kaod.org> wrote:
> >
> > All submounts share the same virtio-fs device instance as the root
> > mount. If the same virtiofs filesystem is mounted again, sget_fc()
> > is likely to pick up any of these submounts and reuse it instead of
> > the root mount.
> >
> > On the server side:
> >
> > # mkdir ${some_dir}
> > # mkdir ${some_dir}/mnt1
> > # mount -t tmpfs none ${some_dir}/mnt1
> > # touch ${some_dir}/mnt1/THIS_IS_MNT1
> > # mkdir ${some_dir}/mnt2
> > # mount -t tmpfs none ${some_dir}/mnt2
> > # touch ${some_dir}/mnt2/THIS_IS_MNT2
> >
> > On the client side:
> >
> > # mkdir /mnt/virtiofs1
> > # mount -t virtiofs myfs /mnt/virtiofs1
> > # ls /mnt/virtiofs1
> > mnt1 mnt2
> > # grep virtiofs /proc/mounts
> > myfs /mnt/virtiofs1 virtiofs rw,seclabel,relatime 0 0
> > none on /mnt/mnt1 type virtiofs (rw,relatime,seclabel)
> > none on /mnt/mnt2 type virtiofs (rw,relatime,seclabel)
> >
> > And now remount it again:
> >
> > # mount -t virtiofs myfs /mnt/virtiofs2
> > # grep virtiofs /proc/mounts
> > myfs /mnt/virtiofs1 virtiofs rw,seclabel,relatime 0 0
> > none on /mnt/mnt1 type virtiofs (rw,relatime,seclabel)
> > none on /mnt/mnt2 type virtiofs (rw,relatime,seclabel)
> > myfs /mnt/virtiofs2 virtiofs rw,seclabel,relatime 0 0
> > # ls /mnt/virtiofs2
> > THIS_IS_MNT2
> >
> > Submount mnt2 was picked-up instead of the root mount.
> 

> Why is this a problem?
> 

It seems very weird to mount the same filesystem again
and to end up in one of its submounts. We should have:

# ls /mnt/virtiofs2
mnt1 mnt2

> Thanks,
> Miklos

