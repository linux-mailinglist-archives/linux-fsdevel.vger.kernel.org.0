Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BFB6E0A28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 11:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjDMJZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 05:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDMJZz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:25:55 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45841106;
        Thu, 13 Apr 2023 02:25:54 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id f14so1996042vsh.10;
        Thu, 13 Apr 2023 02:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681377953; x=1683969953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14XkwBRTK2Qr5c+9iQ6EWXiDKfw6fDHHDEDQaYk9zVI=;
        b=HOXmTzF0Tk9XUqvwGNsz7OZRId/gHvsx7Hsl/a1lrs9gJCA84P3EUO96T42Mz2Oa6S
         w00f0k2IlMoGj33Q0U00wEuY2/SO9J31nyq4XyoO6seHs/FFZBvGg48Avwg0L2q3isSW
         +NeC2A8jQHNQZUhfQ1oo4j9ag8RPZekCf6nlW2xA2kbffbdtg4FEG0Xoh+Xu20YNMzkV
         YZz9D748jvkyiEZRx4VRhJS3hbhiTnQ6xrFX4XTOiyIo+IAnwVUitgzo5ucYzP7/3/B5
         KEGihbN4fQov0koSW1zp4L95MbXSQSNUa3O7GJQGrtZBxtNsgYjfQkJSysZn1vMCfgt0
         v6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681377953; x=1683969953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14XkwBRTK2Qr5c+9iQ6EWXiDKfw6fDHHDEDQaYk9zVI=;
        b=EtqQ0nNhpRiE4c6BQl/bEhW93zwVPJ0KcBqgYoeJ3nuc3Zb8YF1LoTQY+53mH2qHSU
         M6lwFJkLGoQtYPRxHv23HwRSiVGj3Y1JfQL1T2nTNb85jGtLqwxvIHg5S6bP32XiDKVu
         V1N0vyKfTsRb9ovcSkSgjAkEyNCfiAuGr8uoTmyjh8AQfHXcSzthaOzygh0cbi9v4FSP
         Nw9N9Fgn7TfO2hXldeEjHWsMZPMtCeJ9N80cktCIVZXmj8aj/Jkra+m7zsD1xkIcilo0
         d3jZmves+vqb/MK7tgJ4z98ufivclBhRzF7F4X8q9JzkKc1sPUXAIX8jRqIfEuRbaGa7
         cmZQ==
X-Gm-Message-State: AAQBX9fBjbo2/roycsrs1zLKZZJdtlx7ZVq2qDGrxpUie6XlR52nbYbl
        ZgQj+vElbYMl+He2q+3vhud5i9XFjPnmTryTo2U=
X-Google-Smtp-Source: AKy350Y+ryKpsMpYdhnIalah3duLDXrgOaV7QUAT9yOSK7bIi6CFY4f5LHBjtIPXXm1V+JxBps4CKu0S8Pj4M64DUH0=
X-Received: by 2002:a67:d719:0:b0:42c:9397:429 with SMTP id
 p25-20020a67d719000000b0042c93970429mr882385vsj.0.1681377953241; Thu, 13 Apr
 2023 02:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230411124037.1629654-1-amir73il@gmail.com> <20230412184359.grx7qyujnb63h4oy@quack3>
In-Reply-To: <20230412184359.grx7qyujnb63h4oy@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 13 Apr 2023 12:25:41 +0300
Message-ID: <CAOQ4uxj_OQt+yLVnBH-Cg4mKe4_19L42bcsQx2BSOxR7E46SDQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: Enable FAN_REPORT_FID on more filesystem types
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 12, 2023 at 9:44=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>
> On Tue 11-04-23 15:40:37, Amir Goldstein wrote:
> > If kernel supports FAN_REPORT_ANY_FID, use this flag to allow testing
> > also filesystems that do not support fsid or NFS file handles (e.g. fus=
e).
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Jan,
> >
> > I wanted to run an idea by you.
> >
> > My motivation is to close functional gaps between fanotify and inotify.
> >
> > One of the largest gaps right now is that FAN_REPORT_FID is limited
> > to a subset of local filesystems.
> >
> > The idea is to report fid's that are "good enough" and that there
> > is no need to require that fid's can be used by open_by_handle_at()
> > because that is a non-requirement for most use cases, unpriv listener
> > in particular.
>
> OK. I'd note that if you report only inode number, you are prone to the
> problem that some inode gets freed (file deleted) and then reallocated (n=
ew
> file created) and the resulting identifier is the same. It can be
> problematic for a listener to detect these cases and deal with them.
> Inotify does not have this problem at least for some cases because 'wd'
> uniquely identifies the marked inode. For other cases (like watching dirs=
)
> inotify has similar sort of problems. I'm muttering over this because in
> theory filesystems not having i_generation counter on disk could approach
> the problem in a similar way as FAT and then we could just use
> FILEID_INO64_GEN for the file handle.

Yes, of course we could.
The problem with that is that user space needs to be able to query the fid
regardless of fanotify.

The fanotify equivalent of wd is the answer to that query.

If any fs would export i_generation via statx, then FILEID_INO64_GEN
would have been my choice.

But if we are going to change some other API for that, I would not change
statx(), I would change name_to_handle_at(...., AT_HANDLE_FID)

This AT_ flag would relax this check in name_to_handle_at():

        /*
         * We need to make sure whether the file system
         * support decoding of the file handle
         */
        if (!path->dentry->d_sb->s_export_op ||
            !path->dentry->d_sb->s_export_op->fh_to_dentry)
                return -EOPNOTSUPP;

And allow the call to proceed to the default export_encode_fh() implementat=
ion.
Alas, the default implementation encodes FILEID_INO32_GEN.

I think we can get away with a default implementation for FILEID_INO64_GEN
as long as the former (INO32) is used for fs with export ops without ->enco=
de_fh
(e.g. ext*) and the latter (INO64) is used for fs with no export ops.

>
> Also I have noticed your workaround with using st_dev for fsid. As I've
> checked, there are actually very few filesystems that don't set fsid thes=
e
> days. So maybe we could just get away with still refusing to report on
> filesystems without fsid and possibly fixup filesystems which don't set
> fsid yet and are used enough so that users complain?
>

I started going down this path to close the gap with inotify.
inotify is capable of watching all fs including pseudo fs, so I would
like to have this feature parity.

If we can get away with fallback to s_dev as fsid in vfs_statfs()
I have no problem with that, but just to point out - functionally
it is equivalent to do this fallback in userspace library as the
fanotify_get_fid() LTP helper does.

> > I chose a rather generic name for the flag to opt-in for "good enough"
> > fid's.  At first, I was going to make those fid's self describing the
> > fact that they are not NFS file handles, but in the name of simplicity
> > to the API, I decided that this is not needed.
>
> I'd like to discuss a bit about the meaning of the flag. On the first loo=
k
> it is a bit strange to have a flag that says "give me a fh, if you don't
> have it, give me ino". It would seem cleaner to have "give me fh" kind of
> interface (FAN_REPORT_FID) and "give me ino" kind of interface (new
> FAN_REPORT_* flag). I suspect you've chosen the more complex meaning
> because you want to allow a usecase where watches of filesystems which
> don't support filehandles are mixed with watches of filesystems which do
> support filehandles in one notification group and getting filehandles is
> actually prefered over getting just inode numbers? Do you see real benefi=
t
> in getting file handles when userspace has to implement fallback for
> getting just inode numbers anyway?
>

Yes, there is a benefit, because a real fhandle has no-reuse guarantee.

Even if we implement the kernel fallback to FILEID_INO64_GEN, it does
not serve as a statement from the filesystem that i_generation is useful
and in fact, i_generation will often be zero in simple fs and ino will be
reusable.

Also, I wanted to have a design where a given fs/object always returns
the same FID regardless of the init flags.

Your question implies that if
"userspace has to implement fallback for getting just inode numbers",
then it doesn't matter if we report fhandle or inode, but it is not accurat=
e.

The fanotify_get_fid() LTP helper always gets a consistent FID for a
given fs/object. You do not need to feed it the fanotify init flags to
provide a consistent answer.

For all the reasons above, I think that a "give me ino'' flag is not useful=
.
IMO, the flag just needs better marketing.
This is a "I do not need/intend to open_by_handle flag".
Suggestions for a better name are welcome.

For all I care, we do not need to add an opt-in flag at all.
We could simply start to support fs that were not supported before.
This sort of API change is very common and acceptable.

There is no risk if the user tries to call open_by_handle_at() with the
fanotify encoded FID, because in this case the fs is guaranteed to
return ESTALE, because fs does not support file handles.

This is especially true, if we can get away with seamless change
of behavior for vfs_statfs(), because that seamless change would
cause FAN_REPORT_FID to start working on fs like fuse that
support file handles and have zero fsid.

> > The patch below is from the LTP test [1] that verifies reported fid's.
> > I am posting it because I think that the function fanotify_get_fid()
> > demonstrates well, how a would-be fanotify library could be used to get
> > a canonical fid.
> >
> > That would-be routine can easily return the source of the fid values
> > for a given filesystem and that information is constant for all objects
> > on a given filesystem instance.
> >
> > The choise to encode an actual file_handle of type FILEID_INO64 may
> > seem controversial at first, but it simplifies things so much, that I
> > grew very fond of it.
>
> FILEID_INO64 is a bit of a hack in particular because it's difficult to
> pretend FILEID_INO64 can be used for NFS. But I agree it is very convenie=
nt
> :). If we were to do this cleanly we'd have to introduce a new info
> structure with ino instead of handle and three new FAN_EVENT_INFO_TYPE_*

Alas, there are more than three:
/* Special info types for FAN_RENAME */
#define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME       10
/* Reserved for FAN_EVENT_INFO_TYPE_OLD_DFID    11 */
#define FAN_EVENT_INFO_TYPE_NEW_DFID_NAME       12
/* Reserved for FAN_EVENT_INFO_TYPE_NEW_DFID    13 */

and I *really* prefer to avoid duplicating all of them.

> types. As I wrote above, we might be able to actually fill-in
> FILEID_INO64_GEN which would be less controversial then I suppose.
>

Yes, that would definitely be better.

Please let me know what you think about the AT_HANDLE_FID
idea and about the seamless fallback in vfs_statfs().

Thanks,
Amir.
