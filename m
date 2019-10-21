Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27DA0DECF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 15:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfJUNBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 09:01:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33458 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727962AbfJUNBy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571662913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0XtuYVi16cRua7MI95pvO9rKONEjZD3Ff+zCiPew+iM=;
        b=HyPCRkHorxetOazsVRqT1PrE8QPlh5tOUtY3UK8PpgPEj1yA2QdZ10PFdjgkxb6++MqxBu
        WrxyTMQzosiWi5K43XjTcEuu6D9CF5pkDVl61nE6uEejRN/Nk0adcJ+WABjPI89vrgAHdB
        MoGaDE9Ct0GHqUjA/vipwwJONZlCGY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-LdV4YUg_NRuCt4nf2SOzDQ-1; Mon, 21 Oct 2019 09:01:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E91B1100551E;
        Mon, 21 Oct 2019 13:01:48 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2DAD5DA8C;
        Mon, 21 Oct 2019 13:01:43 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8625D2202E5; Mon, 21 Oct 2019 09:01:43 -0400 (EDT)
Date:   Mon, 21 Oct 2019 09:01:43 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        chirantan@chromium.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 5/5] virtiofs: Retry request submission from worker
 context
Message-ID: <20191021130143.GB13573@redhat.com>
References: <20191015174626.11593-1-vgoyal@redhat.com>
 <20191015174626.11593-6-vgoyal@redhat.com>
 <CAJfpegvg1ePA7=Fm3499bKsZBv_98j817KCDxOU18j=BdVfHyA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJfpegvg1ePA7=Fm3499bKsZBv_98j817KCDxOU18j=BdVfHyA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: LdV4YUg_NRuCt4nf2SOzDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 10:15:18AM +0200, Miklos Szeredi wrote:
[..]
> > @@ -268,13 +272,43 @@ static void virtio_fs_request_dispatch_work(struc=
t work_struct *work)
> >                                                list);
> >                 if (!req) {
> >                         spin_unlock(&fsvq->lock);
> > -                       return;
> > +                       break;
> >                 }
> >
> >                 list_del_init(&req->list);
> >                 spin_unlock(&fsvq->lock);
> >                 fuse_request_end(fc, req);
> >         }
> > +
> > +       /* Dispatch pending requests */
> > +       while (1) {
> > +               spin_lock(&fsvq->lock);
> > +               req =3D list_first_entry_or_null(&fsvq->queued_reqs,
> > +                                              struct fuse_req, list);
> > +               if (!req) {
> > +                       spin_unlock(&fsvq->lock);
> > +                       return;
> > +               }
> > +               list_del_init(&req->list);
> > +               spin_unlock(&fsvq->lock);
> > +
> > +               ret =3D virtio_fs_enqueue_req(fsvq, req, true);
> > +               if (ret < 0) {
> > +                       if (ret =3D=3D -ENOMEM || ret =3D=3D -ENOSPC) {
> > +                               spin_lock(&fsvq->lock);
> > +                               list_add_tail(&req->list, &fsvq->queued=
_reqs);
> > +                               schedule_delayed_work(&fsvq->dispatch_w=
ork,
> > +                                                     msecs_to_jiffies(=
1));
> > +                               spin_unlock(&fsvq->lock);
> > +                               return;
> > +                       }
> > +                       req->out.h.error =3D ret;
> > +                       dec_in_flight_req(fsvq);
>=20
> Missing locking.  Fixed.

Good catch. Thanks.

Vivek

