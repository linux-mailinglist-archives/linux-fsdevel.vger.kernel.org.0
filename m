Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72F0462EF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 09:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbhK3I45 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 03:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhK3I44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:56:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71886C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Nov 2021 00:53:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3828EB817E9
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Nov 2021 08:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8E2C53FCB;
        Tue, 30 Nov 2021 08:53:32 +0000 (UTC)
Date:   Tue, 30 Nov 2021 09:53:29 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 02/10] fs: move mapping helpers
Message-ID: <20211130085329.ix677sd3v2l5yu6e@wittgenstein>
References: <20211123114227.3124056-1-brauner@kernel.org>
 <20211123114227.3124056-3-brauner@kernel.org>
 <CAOQ4uxi+3-OaZNrO2X3KawExE8PTvCkncDAsMQ8KL-UEhNwHLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi+3-OaZNrO2X3KawExE8PTvCkncDAsMQ8KL-UEhNwHLA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 08:35:56AM +0200, Amir Goldstein wrote:
> On Tue, Nov 23, 2021 at 3:29 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> >
> > The low-level mapping helpers were so far crammed into fs.h. They are
> > out of place there. The fs.h header should just contain the higher-level
> > mapping helpers that interact directly with vfs objects such as struct
> > super_block or struct inode and not the bare mapping helpers. Similarly,
> > only vfs and specific fs code shall interact with low-level mapping
> > helpers. And so they won't be made accessible automatically through
> > regular {g,u}id helpers.
> >
> > Cc: Seth Forshee <sforshee@digitalocean.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > CC: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >  include/linux/fs.h          |  91 +-------------------------------
> >  include/linux/mnt_mapping.h | 101 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 102 insertions(+), 90 deletions(-)
> >  create mode 100644 include/linux/mnt_mapping.h
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 192242476b2b..eb69e8b035fa 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -41,6 +41,7 @@
> >  #include <linux/stddef.h>
> >  #include <linux/mount.h>
> >  #include <linux/cred.h>
> > +#include <linux/mnt_mapping.h>
> 
> If I grepped correctly, there are ~20 files that use these helpers.
> Please put the include in those files, so changes to this header
> will not compile the world.

Ok, happy to.

> 
> And how about mnt_idmapping.h or idmapped_mnt.h?

I think then I'll opt for mnt_idmapping.h.

> Not sure if this naming issue was discussed already.

Nope!

Thanks!
Christian
