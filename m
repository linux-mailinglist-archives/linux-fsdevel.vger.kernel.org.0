Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372107A899C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 18:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjITQgn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 12:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjITQgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:36:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F5983;
        Wed, 20 Sep 2023 09:36:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01C5320159;
        Wed, 20 Sep 2023 16:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695227795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HgcKDsHEjFx/VP7CohCOLnWX8B/Q49HjkEPo77CZqUI=;
        b=yGA9lj7QojFzxupELxt/S1695FU+Bk6Ws6YajnscZNLy5XMXZYx2CglV/VW7X1HyWiKyxZ
        IyJIL6uhv+x5ixEH1Qg4Zm2nXhF6Aul4iqrCTL3B3DqZeoaizDRByGdGbWRZocYFnhELCo
        aDiO01O1ZSK61oM9DMrOWIrIrTufvnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695227795;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HgcKDsHEjFx/VP7CohCOLnWX8B/Q49HjkEPo77CZqUI=;
        b=1I6Th0Jn5RMO7SicQVknnM3tRrdaaIQJaVR7JWTaXPr1DCAz8cL2VxwUktw5Tk5hOk5RzO
        2ccJn3bhRRKpBbBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C50841333E;
        Wed, 20 Sep 2023 16:36:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9OkSMJIfC2VPawAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 20 Sep 2023 16:36:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0DBBEA077D; Wed, 20 Sep 2023 18:36:34 +0200 (CEST)
Date:   Wed, 20 Sep 2023 18:36:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC][PATCH] fanotify: Enable FAN_REPORT_FID on more filesystem
 types
Message-ID: <20230920163634.5agdx523uv7m2qtf@quack3>
References: <20230411124037.1629654-1-amir73il@gmail.com>
 <20230412184359.grx7qyujnb63h4oy@quack3>
 <CAOQ4uxj_OQt+yLVnBH-Cg4mKe4_19L42bcsQx2BSOxR7E46SDQ@mail.gmail.com>
 <20230417162721.ouzs33oh6mb7vtft@quack3>
 <CAOQ4uxjfP+TrDded+Zps6k6GQM+UsEuW0R2PT_fMEH8ouY_aUg@mail.gmail.com>
 <20230920110429.f4wkfuls73pd55pv@quack3>
 <CAOQ4uxisRMZh_g-M06ROno9g-E+u2ME0109FAVJLiV4V=mwKDw@mail.gmail.com>
 <20230920134829.n74smxum27herhl6@quack3>
 <CAOQ4uxj-5n3ja+22Qv4H27wEGn=eAdE1JNRBSxS3TgdEr7b75A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj-5n3ja+22Qv4H27wEGn=eAdE1JNRBSxS3TgdEr7b75A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 20-09-23 18:12:00, Amir Goldstein wrote:
> On Wed, Sep 20, 2023 at 4:48 PM Jan Kara <jack@suse.cz> wrote:
> > > If users had a flag to statfs() to request the "btrfs root volume fsid",
> > > then fanotify could also report the root fsid and everyone will be happy
> > > because the btrfs file handle already contains the subvolume root
> > > object id (FILEID_BTRFS_WITH_PARENT_ROOT), but that is not
> > > what users get for statfs() and that is not what fanotify documentation
> > > says about how to query fsid.
> > >
> > > We could report the subvolume fsid for marked inode/mount
> > > that is not a problem - we just cache the subvol fsid in inode/mount
> > > connector, but that fsid will be inconsistent with the fsid in the sb
> > > connector, so the same object (in subvolume) can get events
> > > with different fsid (e.g. if one event is in mask of sb and another
> > > event is in mask of inode).
> >
> > Yes. I'm sorry I didn't describe all the details. My idea was to report
> > even on a dentry with the fsid statfs(2) would return on it. We don't want
> > to call dentry_statfs() on each event (it's costly and we don't always have
> > the dentry available) but we can have a special callback into the
> > filesystem to get us just the fsid (which is very cheap) and call *that* on
> > the inode on which the event happens to get fsid for the event. So yes, the
> > sb mark would be returning events with different fsids for btrfs. Or we
> > could compare the obtained fsid with the one in the root volume and ignore
> > the event if they mismatch (that would be more like the different subvolume
> > => different filesystem point of view and would require some more work on
> > fanotify side to remember fsid in the sb mark and not in the sb connector).
> >
> 
> It sounds like a big project.

Actually it should be pretty simple as I imagine it. Maybe I can quickly
hack a POC.

> I am not sure it is really needed.
>
> On second thought, maybe getting different events on the
> same subvol with different fsid is not that bad, because for
> btrfs, it is possible to resolve the path of an fid in subvol
> from either the root mount or the subvol mount.
> IOW, subvol_fsid+fid and root_fsid+fid are two ways to
> describe the same unique object.
> 
> Remember that we have two use cases for fsid+fid:
> 1. (unpriv/priv) User queries fsid+fid, sets an inode mark on path,
>     stores fsid+fid<->path in a map to match events to path later
> 2. (priv-only) User queries fsid, sets a sb/mount mark on path,
>     stores fsid<->path to match event to mntfd and
>     resolves path by handle from mntfd+fid

You're right that for open_by_handle_at() the fsid is actually only good
for getting *any* path on the superblock where file handle can be used so
any of the fsids provided by btrfs is OK. What will be a slight catch is
that if you would be using name_to_handle_at() to match what you've got
from fanotify you will never be able to identify some fids. I'm not sure
how serious that would be...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
