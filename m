Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6948F67EA20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 16:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjA0P66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 10:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjA0P64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:58:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B716A24491
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 07:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674835085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LGMjaKXOqe+JLwIJovTd/9nYCPNTj82aDGnhgP3mX/4=;
        b=YcItZ/HjTMqdzwjDLlrx8EbLN/WXOffEhq4bwiXq0tPA0NE/0Wn/5NAiMaqfIHpdiaPunx
        eQWznQyBHItw1XNVL0WXfykLIrnslHiEMRJ7oyf1XVgaSbqm1nSRVSzgyT1cZhG4s3dPPY
        p+HeJG85NL2EnpjxGKF2XCV+ardrTUE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-Gs8p_XAMOpuFQqWlvU8ztQ-1; Fri, 27 Jan 2023 10:58:02 -0500
X-MC-Unique: Gs8p_XAMOpuFQqWlvU8ztQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1B78857F82;
        Fri, 27 Jan 2023 15:58:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9382C14171BE;
        Fri, 27 Jan 2023 15:58:01 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
        id E09ACF10F2; Fri, 27 Jan 2023 10:57:58 -0500 (EST)
Date:   Fri, 27 Jan 2023 10:57:58 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
Message-ID: <Y9P0hhHSFq/OBZjt@redhat.com>
References: <20230125041835.GD937597@dread.disaster.area>
 <CAOQ4uxhqdjRbNFs_LohwXdTpE=MaFv-e8J3D2R57FyJxp_f3nA@mail.gmail.com>
 <87wn5ac2z6.fsf@redhat.com>
 <CAOQ4uxiPLHHnr2=XH4gN4bAjizH-=4mbZMe_sx99FKuPo-fDMQ@mail.gmail.com>
 <87o7qmbxv4.fsf@redhat.com>
 <CAOQ4uximBLqXDtq9vDhqR__1ctiiOMhMd03HCFUR_Bh_JFE-UQ@mail.gmail.com>
 <87fsbybvzq.fsf@redhat.com>
 <CAOQ4uxgos8m72icX+u2_6Gh7eMmctTTt6XZ=BRt3VzeOZH+UuQ@mail.gmail.com>
 <87wn5a9z4m.fsf@redhat.com>
 <CAOQ4uxi7GHVkaqxsQV6ninD9fhvMAPk1xFRM2aMRFXQZUV-s3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi7GHVkaqxsQV6ninD9fhvMAPk1xFRM2aMRFXQZUV-s3Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 10:23:08PM +0200, Amir Goldstein wrote:
> On Wed, Jan 25, 2023 at 9:45 PM Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> >
> > Amir Goldstein <amir73il@gmail.com> writes:
> >
> > >> >> I previously mentioned my wish of using it from a user namespace, the
> > >> >> goal seems more challenging with EROFS or any other block devices.  I
> > >> >> don't know about the difficulty of getting overlay metacopy working in a
> > >> >> user namespace, even though it would be helpful for other use cases as
> > >> >> well.
> > >> >>
> > >> >
> > >> > There is no restriction of metacopy in user namespace.
> > >> > overlayfs needs to be mounted with -o userxattr and the overlay
> > >> > xattrs needs to use user.overlay. prefix.
> > >>
> > >> if I specify both userxattr and metacopy=on then the mount ends up in
> > >> the following check:
> > >>
> > >> if (config->userxattr) {
> > >>         [...]
> > >>         if (config->metacopy && metacopy_opt) {
> > >>                 pr_err("conflicting options: userxattr,metacopy=on\n");
> > >>                 return -EINVAL;
> > >>         }
> > >> }
> > >>
> > >
> > > Right, my bad.
> > >
> > >> to me it looks like it was done on purpose to prevent metacopy from a
> > >> user namespace, but I don't know the reason for sure.
> > >>
> > >
> > > With hand crafted metacopy, an unpriv user can chmod
> > > any files to anything by layering another file with different
> > > mode on top of it....
> >
> > I might be missing something obvious about metacopy, so please correct
> > me if I am wrong, but I don't see how it is any different than just
> > copying the file and chowning it.  Of course, as long as overlay uses
> > the same security model so that a file that wasn't originally possible
> > to access must be still blocked, even if referenced through metacopy.
> >
> 
> You're right.
> The reason for mutual exclusion maybe related to the
> comment in ovl_check_metacopy_xattr() about EACCES.
> Need to check with Vivek or Miklos.
> 
> But get this - you do not need metacopy=on to follow lower inode.
> It should work without metacopy=on.
> metacopy=on only instructs overlayfs whether to copy up data
> or only metadata when changing metadata of lower object, so it is
> not relevant for readonly mount.

I think you might need metacopy=on even to just follow lower inode. I
see following in ovl_lookup().

                if ((uppermetacopy || d.metacopy) && !ofs->config.metacopy) {
                        dput(this);
                        err = -EPERM;
                        pr_warn_ratelimited("refusing to follow metacopy origin for (%pd2)\n", dentry); 
                        goto out_put;
                }

W.r.t allowing metacopy=on from inside userns, I never paid much attention
to this as I never needed it. But this might be interesting to look into
it now if it is needed.

Thanks
Vivek

