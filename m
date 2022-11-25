Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9377D6386C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 10:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiKYJwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 04:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiKYJwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:52:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126354843A
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 01:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669369766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xKbQmNMIGnlDgYvEteAlL0wXb/z4xDLJRKQD4d/vVoI=;
        b=SHPgwaET1CHgJykz1BXqFD3WaQihUq+AJlVpGU8s1IdAbSP6eTHuRsN7zoZc02NzItLuwX
        vABElJR6Rf1eeyquo4ydkJ3hIk039MYhuELiUuVPCkzcOSnzHPHyau55t7gKBV/q1zD4eo
        IyGFcrSFUSrX/T8CYrYnSEO68VJ7Oek=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-kQqoNabyND-Q-bGWIDEupw-1; Fri, 25 Nov 2022 04:49:20 -0500
X-MC-Unique: kQqoNabyND-Q-bGWIDEupw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C6003815D2C;
        Fri, 25 Nov 2022 09:49:20 +0000 (UTC)
Received: from fedora (ovpn-193-67.brq.redhat.com [10.40.193.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0136FD48;
        Fri, 25 Nov 2022 09:49:18 +0000 (UTC)
Date:   Fri, 25 Nov 2022 10:49:16 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.com>,
        Eric Sandeen <sandeen@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v2 2/3] shmem: implement user/group quota support for
 tmpfs
Message-ID: <20221125094916.4vutvnxt4wiulygw@fedora>
References: <20221121142854.91109-1-lczerner@redhat.com>
 <20221121142854.91109-3-lczerner@redhat.com>
 <20221123163745.nnunvbl3s6th6kjx@quack3>
 <20221125085948.wbzzbimqeehcfqnh@fedora>
 <20221125091453.nm2lbxl743ggrqxq@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125091453.nm2lbxl743ggrqxq@quack3>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 25, 2022 at 10:14:53AM +0100, Jan Kara wrote:
> On Fri 25-11-22 09:59:48, Lukas Czerner wrote:
> > On Wed, Nov 23, 2022 at 05:37:45PM +0100, Jan Kara wrote:
> > > On Mon 21-11-22 15:28:53, Lukas Czerner wrote:
> > > > Implement user and group quota support for tmpfs using system quota file
> > > > in vfsv0 quota format. Because everything in tmpfs is temporary and as a
> > > > result is lost on umount, the quota files are initialized on every
> > > > mount. This also goes for quota limits, that needs to be set up after
> > > > every mount.
> > > > 
> > > > The quota support in tmpfs is well separated from the rest of the
> > > > filesystem and is only enabled using mount option -o quota (and
> > > > usrquota and grpquota for compatibility reasons). Only quota accounting
> > > > is enabled this way, enforcement needs to be enable by regular quota
> > > > tools (using Q_QUOTAON ioctl).
> > > > 
> > > > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > > 
> > > ...
> > > 
> > > > diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
> > > > index 0408c245785e..9c4f228ef4f3 100644
> > > > --- a/Documentation/filesystems/tmpfs.rst
> > > > +++ b/Documentation/filesystems/tmpfs.rst
> > > > @@ -86,6 +86,18 @@ use up all the memory on the machine; but enhances the scalability of
> > > >  that instance in a system with many CPUs making intensive use of it.
> > > >  
> > > >  
> > > > +tmpfs also supports quota with the following mount options
> > > > +
> > > > +========  =============================================================
> > > > +quota     Quota accounting is enabled on the mount. Tmpfs is using
> > > > +          hidden system quota files that are initialized on mount.
> > > > +          Quota limits can quota enforcement can be enabled using
> > >                           ^^^ and?
> > > 
> > > > +          standard quota tools.
> > > > +usrquota  Same as quota option. Exists for compatibility reasons.
> > > > +grpquota  Same as quota option. Exists for compatibility reasons.
> > > 
> > > As we discussed with V1, I'd prefer if user & group quotas could be enabled
> > > / disabled independently. Mostly to not differ from other filesystems
> > > unnecessarily.
> > 
> > Ok, but other file systems (at least xfs and ext) differs. Mounting ext4
> > file system with quota feature with default quota option settings will
> > always enable accounting for both user and group. Mount options quota,
> > usrquota and grpquota enables enforcement; selectively with the last
> > two.
> > 
> > On xfs with no mount options quota is disabled. With quota, usrquota and
> > grpquota enforcement is enabled, again selectively with the last two.
> > 
> > And yes, with this implementation tmpfs is again different. The idea was
> > to allow enabling accounting and enforcement (with default limits)
> > selectively.
> > 
> > So how would you like the tmpfs to do it? I think having accounting only
> > can be useful and I'd like to keep it. Maybe adding qnoenforce,
> > uqnoenforce and qgnoenforce mount options, but that seems cumbersome to
> > me and enabling accounting by default seems a bit much. What do you think?
> 
> So I wanted things to be as similar to other filesystems as possible. So
> quota, usrquota, grpquota would enable quota accounting & enforcement (the
> last two selectively). If we want the possibility to enable accounting
> without enforcement that can be done by some special mount options (and
> possibly we can add them when there's user demand). Also note that there's
> always the possibility to disable quota enforcement using quota tools when
> needed. But IMHO 99% of users will want accounting & enforcement and thus
> that should be the default like with other filesystems.
> 
> 								Honza

Alright I'll do that.

Thanks!
-Lukas

> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

