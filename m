Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9FB10729E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 14:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfKVNAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 08:00:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44077 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbfKVNAw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:00:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574427650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ETyTIpWW0X6VRUyIQmpufjqzQzz/3LOVGP1+Sl83YY=;
        b=LP5DlBDESlBh69QRl9ZTDmtbMb4VgSZMwADch7N1l4LNKEAgOminVQN9A2ev4mZgCBFgeA
        kcd+eT09IlVyYMAfkRXK6rkRo2IuSCx1hpu+igEy/90Aw8cUMh0exuwpup7RYAi3NwpUsU
        GaV10UWY4vCHRElWxEYHe3h0OggK27Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-TZiyAIdROzSjwdbLH4TeZw-1; Fri, 22 Nov 2019 08:00:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 506291852E21;
        Fri, 22 Nov 2019 13:00:43 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DA5960141;
        Fri, 22 Nov 2019 13:00:43 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 893BF220AFF; Fri, 22 Nov 2019 08:00:42 -0500 (EST)
Date:   Fri, 22 Nov 2019 08:00:42 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dgilbert@redhat.com,
        miklos@szeredi.hu
Subject: Re: [PATCH 4/4] virtiofs: Support blocking posix locks
 (fcntl(F_SETLKW))
Message-ID: <20191122130042.GB8636@redhat.com>
References: <20191115205705.2046-1-vgoyal@redhat.com>
 <20191115205705.2046-5-vgoyal@redhat.com>
 <20191121170020.GE445244@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191121170020.GE445244@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: TZiyAIdROzSjwdbLH4TeZw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 21, 2019 at 05:00:20PM +0000, Stefan Hajnoczi wrote:

[..]
> > +static int virtio_fs_handle_notify(struct virtio_fs *vfs,
> > +=09=09=09=09   struct virtio_fs_notify *notify)
> > +{
> > +=09int ret =3D 0;
> > +=09struct fuse_out_header *oh =3D &notify->out_hdr;
> > +=09struct fuse_notify_lock_out *lo;
> > +
> > +=09/*
> > +=09 * For notifications, oh.unique is 0 and oh->error contains code
> > +=09 * for which notification as arrived.
> > +=09 */
> > +=09switch(oh->error) {
> > +=09case FUSE_NOTIFY_LOCK:
> > +=09=09lo =3D (struct fuse_notify_lock_out *) &notify->outarg;
> > +=09=09notify_complete_waiting_req(vfs, lo);
> > +=09=09break;
> > +=09default:
> > +=09=09printk("virtio-fs: Unexpected notification %d\n", oh->error);
> > +=09}
> > +=09return ret;
> > +}
>=20
> Is this specific to virtio or can be it handled in common code?

This is not specific to virtio_fs. In principle, regular fuse daemon could
implement something similar. Though they might not have to because client
can just block without introducing deadlock possibilities.

Anyway, I will look into moving this code into fuse common.

[..]
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 373cada89815..45f0c4efec8e 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -481,6 +481,7 @@ enum fuse_notify_code {
> >  =09FUSE_NOTIFY_STORE =3D 4,
> >  =09FUSE_NOTIFY_RETRIEVE =3D 5,
> >  =09FUSE_NOTIFY_DELETE =3D 6,
> > +=09FUSE_NOTIFY_LOCK =3D 7,
> >  =09FUSE_NOTIFY_CODE_MAX,
> >  };
> > =20
> > @@ -868,6 +869,12 @@ struct fuse_notify_retrieve_in {
> >  =09uint64_t=09dummy4;
> >  };
> > =20
> > +struct fuse_notify_lock_out {
> > +=09uint64_t=09id;
>=20
> Please call this field "unique" or "lock_unique" so it's clear this
> identifier is the fuse_header_in->unique value of the lock request.

Ok, will do.

Vivek

