Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB31B6385F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 10:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiKYJPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 04:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiKYJOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:14:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAEC1DA79
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 01:14:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A872C21A9F;
        Fri, 25 Nov 2022 09:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669367693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GGpt3ah8HnTK67kqx/nVgAelNcknoRSpTFcKqB3vIcc=;
        b=Jz1CMq+tDof0/AV6MyNJ5b3nvv29nKboiYJ5YuAe7NE+aoAMqYv0+dDePx/tVxKriEGg/2
        grv54h1PS+EKPibaIaaYnCYtQ/IkkCqfw+56pkXrCXXlkvBo9azUrzAA6iRU1hgElGTasX
        FMOoQ0DAIkPVvn++oyIU/JozgiGfHk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669367693;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GGpt3ah8HnTK67kqx/nVgAelNcknoRSpTFcKqB3vIcc=;
        b=LEWdEJF0KuyI9HKE1gjeQ96j9HUN1lOY4jT+V5iksglEtvrYyj/nfWI6lDuztmoOos/ZNv
        HzTrhZr7SOBKIwDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 963CA1361C;
        Fri, 25 Nov 2022 09:14:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fvSgJI2HgGNOQgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 25 Nov 2022 09:14:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0B091A0714; Fri, 25 Nov 2022 10:14:53 +0100 (CET)
Date:   Fri, 25 Nov 2022 10:14:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        Jan Kara <jack@suse.com>, Eric Sandeen <sandeen@redhat.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: Re: [PATCH v2 2/3] shmem: implement user/group quota support for
 tmpfs
Message-ID: <20221125091453.nm2lbxl743ggrqxq@quack3>
References: <20221121142854.91109-1-lczerner@redhat.com>
 <20221121142854.91109-3-lczerner@redhat.com>
 <20221123163745.nnunvbl3s6th6kjx@quack3>
 <20221125085948.wbzzbimqeehcfqnh@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125085948.wbzzbimqeehcfqnh@fedora>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 25-11-22 09:59:48, Lukas Czerner wrote:
> On Wed, Nov 23, 2022 at 05:37:45PM +0100, Jan Kara wrote:
> > On Mon 21-11-22 15:28:53, Lukas Czerner wrote:
> > > Implement user and group quota support for tmpfs using system quota file
> > > in vfsv0 quota format. Because everything in tmpfs is temporary and as a
> > > result is lost on umount, the quota files are initialized on every
> > > mount. This also goes for quota limits, that needs to be set up after
> > > every mount.
> > > 
> > > The quota support in tmpfs is well separated from the rest of the
> > > filesystem and is only enabled using mount option -o quota (and
> > > usrquota and grpquota for compatibility reasons). Only quota accounting
> > > is enabled this way, enforcement needs to be enable by regular quota
> > > tools (using Q_QUOTAON ioctl).
> > > 
> > > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > 
> > ...
> > 
> > > diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
> > > index 0408c245785e..9c4f228ef4f3 100644
> > > --- a/Documentation/filesystems/tmpfs.rst
> > > +++ b/Documentation/filesystems/tmpfs.rst
> > > @@ -86,6 +86,18 @@ use up all the memory on the machine; but enhances the scalability of
> > >  that instance in a system with many CPUs making intensive use of it.
> > >  
> > >  
> > > +tmpfs also supports quota with the following mount options
> > > +
> > > +========  =============================================================
> > > +quota     Quota accounting is enabled on the mount. Tmpfs is using
> > > +          hidden system quota files that are initialized on mount.
> > > +          Quota limits can quota enforcement can be enabled using
> >                           ^^^ and?
> > 
> > > +          standard quota tools.
> > > +usrquota  Same as quota option. Exists for compatibility reasons.
> > > +grpquota  Same as quota option. Exists for compatibility reasons.
> > 
> > As we discussed with V1, I'd prefer if user & group quotas could be enabled
> > / disabled independently. Mostly to not differ from other filesystems
> > unnecessarily.
> 
> Ok, but other file systems (at least xfs and ext) differs. Mounting ext4
> file system with quota feature with default quota option settings will
> always enable accounting for both user and group. Mount options quota,
> usrquota and grpquota enables enforcement; selectively with the last
> two.
> 
> On xfs with no mount options quota is disabled. With quota, usrquota and
> grpquota enforcement is enabled, again selectively with the last two.
> 
> And yes, with this implementation tmpfs is again different. The idea was
> to allow enabling accounting and enforcement (with default limits)
> selectively.
> 
> So how would you like the tmpfs to do it? I think having accounting only
> can be useful and I'd like to keep it. Maybe adding qnoenforce,
> uqnoenforce and qgnoenforce mount options, but that seems cumbersome to
> me and enabling accounting by default seems a bit much. What do you think?

So I wanted things to be as similar to other filesystems as possible. So
quota, usrquota, grpquota would enable quota accounting & enforcement (the
last two selectively). If we want the possibility to enable accounting
without enforcement that can be done by some special mount options (and
possibly we can add them when there's user demand). Also note that there's
always the possibility to disable quota enforcement using quota tools when
needed. But IMHO 99% of users will want accounting & enforcement and thus
that should be the default like with other filesystems.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
