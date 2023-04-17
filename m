Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665AA6E4E49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 18:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjDQQ10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 12:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDQQ1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:27:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D90BF;
        Mon, 17 Apr 2023 09:27:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 06E2D1F6E6;
        Mon, 17 Apr 2023 16:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681748842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IkQUH46zKQpzmvFHuHSUPjKutCEQh3rWViqaSZN31aY=;
        b=VlE8fei3trNIAzFX0du11OeCO8wo1IAm6kJ5UaSx/QPr2QchDU5PqCbvAlZ47P2ztfZjFk
        yKIs7X1LpBl2syci9AhZxP+aEoxzLoiyhufSAxJMxVyiNmJ+mK0kiGCV2C4sPYe1T2GA0P
        hBlvqgQFro8KN3Wda+VmyGdf80rEslU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681748842;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IkQUH46zKQpzmvFHuHSUPjKutCEQh3rWViqaSZN31aY=;
        b=WOpBDweHn2za/83kbKDAXB1L6sXWfJLRIjkNYE8spvkY4to9aaOJdxk4u6kyH0sm1Ri8LX
        fag2SNH9PE01HSCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EBD6613319;
        Mon, 17 Apr 2023 16:27:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bEaPOWlzPWQDVQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 17 Apr 2023 16:27:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4B575A0735; Mon, 17 Apr 2023 18:27:21 +0200 (CEST)
Date:   Mon, 17 Apr 2023 18:27:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH] fanotify: Enable FAN_REPORT_FID on more filesystem
 types
Message-ID: <20230417162721.ouzs33oh6mb7vtft@quack3>
References: <20230411124037.1629654-1-amir73il@gmail.com>
 <20230412184359.grx7qyujnb63h4oy@quack3>
 <CAOQ4uxj_OQt+yLVnBH-Cg4mKe4_19L42bcsQx2BSOxR7E46SDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj_OQt+yLVnBH-Cg4mKe4_19L42bcsQx2BSOxR7E46SDQ@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 13-04-23 12:25:41, Amir Goldstein wrote:
> On Wed, Apr 12, 2023 at 9:44 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hi Amir!
> >
> > On Tue 11-04-23 15:40:37, Amir Goldstein wrote:
> > > If kernel supports FAN_REPORT_ANY_FID, use this flag to allow testing
> > > also filesystems that do not support fsid or NFS file handles (e.g. fuse).
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Jan,
> > >
> > > I wanted to run an idea by you.
> > >
> > > My motivation is to close functional gaps between fanotify and inotify.
> > >
> > > One of the largest gaps right now is that FAN_REPORT_FID is limited
> > > to a subset of local filesystems.
> > >
> > > The idea is to report fid's that are "good enough" and that there
> > > is no need to require that fid's can be used by open_by_handle_at()
> > > because that is a non-requirement for most use cases, unpriv listener
> > > in particular.
> >
> > OK. I'd note that if you report only inode number, you are prone to the
> > problem that some inode gets freed (file deleted) and then reallocated (new
> > file created) and the resulting identifier is the same. It can be
> > problematic for a listener to detect these cases and deal with them.
> > Inotify does not have this problem at least for some cases because 'wd'
> > uniquely identifies the marked inode. For other cases (like watching dirs)
> > inotify has similar sort of problems. I'm muttering over this because in
> > theory filesystems not having i_generation counter on disk could approach
> > the problem in a similar way as FAT and then we could just use
> > FILEID_INO64_GEN for the file handle.
> 
> Yes, of course we could.
> The problem with that is that user space needs to be able to query the fid
> regardless of fanotify.
> 
> The fanotify equivalent of wd is the answer to that query.
> 
> If any fs would export i_generation via statx, then FILEID_INO64_GEN
> would have been my choice.

One problem with making up i_generation (like FAT does it) is that when
inode gets reclaimed and then refetched from the disk FILEID_INO64_GEN will
change because it's going to have different i_generation. For NFS this is
annoying but I suppose it mostly does not happen since client's accesses
tend to keep the inode in memory. For fanotify it could be more likely to
happen if watching say the whole filesystem and I suppose the watching
application will get confused by this. So I'm not convinced faking
i_generation is a good thing to do. But still I want to brainstorm a bit
about it :)

> But if we are going to change some other API for that, I would not change
> statx(), I would change name_to_handle_at(...., AT_HANDLE_FID)
> 
> This AT_ flag would relax this check in name_to_handle_at():
> 
>         /*
>          * We need to make sure whether the file system
>          * support decoding of the file handle
>          */
>         if (!path->dentry->d_sb->s_export_op ||
>             !path->dentry->d_sb->s_export_op->fh_to_dentry)
>                 return -EOPNOTSUPP;
> 
> And allow the call to proceed to the default export_encode_fh() implementation.
> Alas, the default implementation encodes FILEID_INO32_GEN.
> 
> I think we can get away with a default implementation for FILEID_INO64_GEN
> as long as the former (INO32) is used for fs with export ops without ->encode_fh
> (e.g. ext*) and the latter (INO64) is used for fs with no export ops.

These default calls seem a bit too subtle to me. I'd rather add explicit
handlers to filesystems that really want FILEID_INO32_GEN encoding and then
have a fallback function for filesystems not having s_export_op at all.

But otherwise the proposal to make name_to_handle_at() work even for
filesystems not exportable through NFS makes sense to me. But I guess we
need some buy-in from VFS maintainers for this.

> > Also I have noticed your workaround with using st_dev for fsid. As I've
> > checked, there are actually very few filesystems that don't set fsid these
> > days. So maybe we could just get away with still refusing to report on
> > filesystems without fsid and possibly fixup filesystems which don't set
> > fsid yet and are used enough so that users complain?
> 
> I started going down this path to close the gap with inotify.
> inotify is capable of watching all fs including pseudo fs, so I would
> like to have this feature parity.

Well, but with pseudo filesystems (similarly as with FUSE) the notification
was always unreliable. As in: some cases worked but others did not. I'm not
sure that is something we should try to replicate :)

So still I'd be interested to know which filesystems we are exactly
interested to support and whether we are not better off to explicitely add
fsid support to them like we did for tmpfs.

> If we can get away with fallback to s_dev as fsid in vfs_statfs()
> I have no problem with that, but just to point out - functionally
> it is equivalent to do this fallback in userspace library as the
> fanotify_get_fid() LTP helper does.

Yes, userspace can workaround this but I was more thinking about avoiding
adding these workarounds into fanotify in kernel *and* to userspace.

> > > I chose a rather generic name for the flag to opt-in for "good enough"
> > > fid's.  At first, I was going to make those fid's self describing the
> > > fact that they are not NFS file handles, but in the name of simplicity
> > > to the API, I decided that this is not needed.
> >
> > I'd like to discuss a bit about the meaning of the flag. On the first look
> > it is a bit strange to have a flag that says "give me a fh, if you don't
> > have it, give me ino". It would seem cleaner to have "give me fh" kind of
> > interface (FAN_REPORT_FID) and "give me ino" kind of interface (new
> > FAN_REPORT_* flag). I suspect you've chosen the more complex meaning
> > because you want to allow a usecase where watches of filesystems which
> > don't support filehandles are mixed with watches of filesystems which do
> > support filehandles in one notification group and getting filehandles is
> > actually prefered over getting just inode numbers? Do you see real benefit
> > in getting file handles when userspace has to implement fallback for
> > getting just inode numbers anyway?
> >
> 
> Yes, there is a benefit, because a real fhandle has no-reuse guarantee.
> 
> Even if we implement the kernel fallback to FILEID_INO64_GEN, it does
> not serve as a statement from the filesystem that i_generation is useful
> and in fact, i_generation will often be zero in simple fs and ino will be
> reusable.
> 
> Also, I wanted to have a design where a given fs/object always returns
> the same FID regardless of the init flags.
> 
> Your question implies that if
> "userspace has to implement fallback for getting just inode numbers",
> then it doesn't matter if we report fhandle or inode, but it is not accurate.
> 
> The fanotify_get_fid() LTP helper always gets a consistent FID for a
> given fs/object. You do not need to feed it the fanotify init flags to
> provide a consistent answer.
> 
> For all the reasons above, I think that a "give me ino'' flag is not useful.
> IMO, the flag just needs better marketing.
> This is a "I do not need/intend to open_by_handle flag".
> Suggestions for a better name are welcome.

I see, yes, these reasons make sense.

> For all I care, we do not need to add an opt-in flag at all.
> We could simply start to support fs that were not supported before.
> This sort of API change is very common and acceptable.
> 
> There is no risk if the user tries to call open_by_handle_at() with the
> fanotify encoded FID, because in this case the fs is guaranteed to
> return ESTALE, because fs does not support file handles.
> 
> This is especially true, if we can get away with seamless change
> of behavior for vfs_statfs(), because that seamless change would
> cause FAN_REPORT_FID to start working on fs like fuse that
> support file handles and have zero fsid.

Yeah. Actually I like the idea of a seamless change to start reporting fsid
and also to start reporting "fake" handles. In the past we've already
enabled tmpfs like this...

> > > The patch below is from the LTP test [1] that verifies reported fid's.
> > > I am posting it because I think that the function fanotify_get_fid()
> > > demonstrates well, how a would-be fanotify library could be used to get
> > > a canonical fid.
> > >
> > > That would-be routine can easily return the source of the fid values
> > > for a given filesystem and that information is constant for all objects
> > > on a given filesystem instance.
> > >
> > > The choise to encode an actual file_handle of type FILEID_INO64 may
> > > seem controversial at first, but it simplifies things so much, that I
> > > grew very fond of it.
> >
> > FILEID_INO64 is a bit of a hack in particular because it's difficult to
> > pretend FILEID_INO64 can be used for NFS. But I agree it is very convenient
> > :). If we were to do this cleanly we'd have to introduce a new info
> > structure with ino instead of handle and three new FAN_EVENT_INFO_TYPE_*
> 
> Alas, there are more than three:
> /* Special info types for FAN_RENAME */
> #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME       10
> /* Reserved for FAN_EVENT_INFO_TYPE_OLD_DFID    11 */
> #define FAN_EVENT_INFO_TYPE_NEW_DFID_NAME       12
> /* Reserved for FAN_EVENT_INFO_TYPE_NEW_DFID    13 */
> 
> and I *really* prefer to avoid duplicating all of them.

Yeah, I was just thinking loud :).

> > types. As I wrote above, we might be able to actually fill-in
> > FILEID_INO64_GEN which would be less controversial then I suppose.
> 
> Yes, that would definitely be better.


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
