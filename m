Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1B92C4347
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 16:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgKYPg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 10:36:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730762AbgKYPgy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606318612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cJkC53GyD9FAHLxibh9+A1BamdzF6S8jhyvfUGPJHh4=;
        b=DbXJloroS+V/xlSUgutc6xJVleGBPumitfoYlBqLq/2o3sfSgLc7g8FNhyz6mhjag1o8Qo
        V3P5BOHE8g1OBkIVpFKPOmrp/IPxgodxx96uPiOaCcwALO2Ld3BSfO+G7WOa1UdFUtmwai
        c+FwPbRr7WZQR73D+5EV4cIR9aWWBi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-cLpycQfOMFmtfcz3nrt9Qg-1; Wed, 25 Nov 2020 10:36:50 -0500
X-MC-Unique: cLpycQfOMFmtfcz3nrt9Qg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A026586ABD6;
        Wed, 25 Nov 2020 15:36:47 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-154.rdu2.redhat.com [10.10.114.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A9FD5C1A3;
        Wed, 25 Nov 2020 15:36:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 040C322054F; Wed, 25 Nov 2020 10:36:47 -0500 (EST)
Date:   Wed, 25 Nov 2020 10:36:46 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v1 3/3] overlay: Add rudimentary checking of writeback
 errseq on volatile remount
Message-ID: <20201125153646.GC3095@redhat.com>
References: <20201125104621.18838-1-sargun@sargun.me>
 <20201125104621.18838-4-sargun@sargun.me>
 <CAOQ4uxhr1iLkvt+LK868pK=AaZ5O6vniPf2t8=u1=Pb+0ELPAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhr1iLkvt+LK868pK=AaZ5O6vniPf2t8=u1=Pb+0ELPAw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 04:03:06PM +0200, Amir Goldstein wrote:
> On Wed, Nov 25, 2020 at 12:46 PM Sargun Dhillon <sargun@sargun.me> wrote:
> >
> > Volatile remounts validate the following at the moment:
> >  * Has the module been reloaded / the system rebooted
> >  * Has the workdir been remounted
> >
> > This adds a new check for errors detected via the superblock's
> > errseq_t. At mount time, the errseq_t is snapshotted to disk,
> > and upon remount it's re-verified. This allows for kernel-level
> > detection of errors without forcing userspace to perform a
> > sync and allows for the hidden detection of writeback errors.
> >
> 
> Looks fine as long as you verify that the reuse is also volatile.
> 
> Care to also add the alleged issues that Vivek pointed out with existing
> volatile mount to the documentation? (unless Vivek intends to do fix those)

I thought current writeback error issue with volatile mounts needs to
be fixed with shutting down filesystem. (And mere documentation is not
enough).

Amir, are you planning to improve your ovl-shutdown patches to detect
writeback errors for volatile mounts. Or you want somebody else to
look at it.

W.r.t this patch set, I still think that first we should have patches
to shutdown filesystem on writeback errors (for volatile mount), and
then detecting writeback errors on remount makes more sense.

Vivek

> 
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > ---
> >  fs/overlayfs/overlayfs.h | 1 +
> >  fs/overlayfs/readdir.c   | 6 ++++++
> >  fs/overlayfs/super.c     | 1 +
> >  3 files changed, 8 insertions(+)
> >
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index de694ee99d7c..e8a711953b64 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -85,6 +85,7 @@ struct ovl_volatile_info {
> >          */
> >         uuid_t          ovl_boot_id;    /* Must stay first member */
> >         u64             s_instance_id;
> > +       errseq_t        errseq; /* Implemented as a u32 */
> >  } __packed;
> >
> >  /*
> > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > index 4e3e2bc3ea43..2bb0641ecbbd 100644
> > --- a/fs/overlayfs/readdir.c
> > +++ b/fs/overlayfs/readdir.c
> > @@ -1109,6 +1109,12 @@ static int ovl_verify_volatile_info(struct ovl_fs *ofs,
> >                 return -EINVAL;
> >         }
> >
> > +       err = errseq_check(&volatiledir->d_sb->s_wb_err, info.errseq);
> > +       if (err) {
> > +               pr_debug("Workdir filesystem reports errors: %d\n", err);
> > +               return -EINVAL;
> > +       }
> > +
> >         return 1;
> >  }
> >
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index 9a1b07907662..49dee41ec125 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -1248,6 +1248,7 @@ static int ovl_set_volatile_info(struct ovl_fs *ofs, struct dentry *volatiledir)
> >         int err;
> >         struct ovl_volatile_info info = {
> >                 .s_instance_id = volatiledir->d_sb->s_instance_id,
> > +               .errseq = errseq_sample(&volatiledir->d_sb->s_wb_err),
> >         };
> >
> >         uuid_copy(&info.ovl_boot_id, &ovl_boot_id);
> > --
> > 2.25.1
> >
> 

