Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1C55BF9DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 10:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiIUIyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 04:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiIUIyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:54:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2DF13CC0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 01:54:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E42FB82EBB
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 08:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12496C433C1;
        Wed, 21 Sep 2022 08:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663750480;
        bh=fVPCeilz9s0KTluTpYankru2zjrjkEllbmzx/KBZfOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9jnXPwLHYAoivrzvXnQ2zLVfLUEx8MMrt1sen7dlQZsuBmArUkVKB2ie0FWBduiX
         XPtbmSAi91yNNHPo1DgViGocepUIL4kWuh1M4FACjo6uxMlgOGOFzA1gfcmKA3SPIw
         oKhjydQt4URhFKmMF/ilFOc5E9CTf8kHn33IW1U0C24VfS7vlm9jeYw9QTUov3MJsG
         o+bETvu9e4nlW1aLg/wU4Mxl7viPmu3Q9h7ld6mnXcTBH80ASIFa7ztNalA2H1+9S6
         P8crNXdolI/vzynb/IdUIIvQ25ifo+mNQGGxnRBaakhU80Zp4OWdJtwa2JPO57rSaF
         zul2WsBRP1Z0w==
Date:   Wed, 21 Sep 2022 10:54:34 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v3 7/9] vfs: move open right after ->tmpfile()
Message-ID: <20220921085434.g3ak6lwqvpe67ksn@wittgenstein>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
 <20220920193632.2215598-8-mszeredi@redhat.com>
 <YyopS+KNN49oz2vB@ZenIV>
 <CAJfpegv6-qmLrW-gKx4uZmjSehhttzF1Qd2Nqk=+vGiGoq2Ouw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegv6-qmLrW-gKx4uZmjSehhttzF1Qd2Nqk=+vGiGoq2Ouw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 05:06:57AM +0200, Miklos Szeredi wrote:
> On Tue, 20 Sept 2022 at 22:57, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Tue, Sep 20, 2022 at 09:36:30PM +0200, Miklos Szeredi wrote:
> >
> > >       inode = child->d_inode;
> >
> > Better
> >         inode = file_inode(file);
> >
> > so that child would be completely ignored after dput().
> >
> > > +     error = vfs_tmpfile(mnt_userns, &path, file, op->mode);
> > > +     if (error)
> > >               goto out2;
> > > -     dput(path.dentry);
> > > -     path.dentry = child;
> > > -     audit_inode(nd->name, child, 0);
> > > +     audit_inode(nd->name, file->f_path.dentry, 0);
> > >       /* Don't check for other permissions, the inode was just created */
> > > -     error = may_open(mnt_userns, &path, 0, op->open_flag);
> >
> > Umm...  I'm not sure that losing it is the right thing - it might
> > be argued that ->permission(..., MAY_OPEN) is to be ignored for
> > tmpfile (and the only thing checking for MAY_OPEN is nfs, which is
> > *not* going to grow tmpfile any time soon - certainly not with these
> > calling conventions), but you are also dropping the call of
> > security_inode_permission(inode, MAY_OPEN) and that's a change
> > compared to what LSM crowd used to get...
> 
> Not losing it, just moving it into vfs_tmpfile().

Afaict, we haven't called may_open() for tmpfile creation in either
cachefiles or overlayfs before. So from that perspective I wonder if
there's a good reason for us to do it now.

The fact that we don't account these kernel internal tmpfiles feels like
another exemption that points to them being internal files that don't
need to be subject to common restrictions.
