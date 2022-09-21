Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921055E540A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 21:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiIUTzn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 15:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiIUTzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:55:42 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91B3A2621
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 12:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q5goacXW3jXSX3FDNYMiTc6jFv4jM7pxeUs4MfbTVTs=; b=qcbAE4/clWsO5WpOta9T4OnBOh
        hRVq9GMvBmyPAf7pJt+c/JcRT6LmvQN1F6slwRYQjBCkce/ItvvxydJtnvfSLtefxPKfvjrSHhDys
        clQIUpiINBEGsA3m6s4ksQsd20YJ4jooq0Nxva8UqGUtkCggSf8mLYx8b0k498jJuO8Yuejl0t9KG
        XBluqd8FjTK9zLPN/K4T/T2bPz8hosOrVvd+39cHXfPW+waklzjkbMUsmyDy6PB3VLdSE6esm/qYU
        hSlYOy0aXe+VocJrZto5wlY5DukJvZuYnZb5VkUHe3mOVplBlmaJ0hnIewU5uYDXhPzTmIPnph0PY
        r+1yShjQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ob5op-002Aew-2b;
        Wed, 21 Sep 2022 19:55:39 +0000
Date:   Wed, 21 Sep 2022 20:55:39 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v3 7/9] vfs: move open right after ->tmpfile()
Message-ID: <YytsO4MVpHd+LUE8@ZenIV>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
 <20220920193632.2215598-8-mszeredi@redhat.com>
 <YyopS+KNN49oz2vB@ZenIV>
 <CAJfpegv6-qmLrW-gKx4uZmjSehhttzF1Qd2Nqk=+vGiGoq2Ouw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv6-qmLrW-gKx4uZmjSehhttzF1Qd2Nqk=+vGiGoq2Ouw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

Sorry, missed that bit...
