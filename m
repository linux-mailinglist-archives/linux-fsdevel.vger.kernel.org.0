Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC17223764
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 10:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgGQIxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 04:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGQIxU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:53:20 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6135C061755
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 01:53:19 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a21so9938167ejj.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 01:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sepW1MS/244yRuMm//K9S5ChlKO04q+uSw0y80a65rg=;
        b=KSBnq8ckwuIMY+eOle/raGsanI1xcfX9Dr9CLYQjGVzmnmkRKA2AcTO3SsX7ymuFxZ
         n9Tu0GRWZESNQZMvqoqrFfYHkOtw9fBReJAD6p5pTIUDf8DFzM8sJZ+13xqAnR8UWL86
         7w5tPz3/LRnPHJZlGL2jvW6ioBgzbmHZIAInc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sepW1MS/244yRuMm//K9S5ChlKO04q+uSw0y80a65rg=;
        b=Yl42Askw9Am3m5YZgP2qViF1XkfnMbKB/XCIqeS4c8xpWdsjfrf3ZKqHouTukpJqH3
         QHV4nbT82KvBI1i6gCqz5swgyWtqrzDU5aBwnyQryPtohkVEWc/vKdbEzl8nqv0Ip02j
         E+o9htXypnY1WE8OLsA1Hm0/vRUzAYa2kzBrnE7Mkhi9UvbV26bPJ4/yun5oHfR//x3I
         2zGVTamjtkxLKburDunvSvRKRPX1ESoS8kX4AuWRPW3qFILKHLtcAcElfhYRZs0JfxS/
         /0ljCLwqLcq8tvO8hGQFyFxlCa/8BygW/4ixfvoJ4ESBmunacyxBdwoR0ElFKgIdOJco
         eL9g==
X-Gm-Message-State: AOAM533mIwV8+MWQOaL8w3vIYEpPIJWgqRqG7d1TjFQ2S+KjU+cKR78a
        kzyf0Ol3Uo73KPWYj0VX1x2NvXeY2r8s5sgHfbraWQ==
X-Google-Smtp-Source: ABdhPJyAq3TxehmCpgWQARyhP2J75ZT3gpSD3vCIJ6IIcBC4g7DXdnVISeWLTc2Ays8lVrVYYPX2hlYzP7Wt+hYWwz8=
X-Received: by 2002:a17:906:824c:: with SMTP id f12mr5105825ejx.443.1594975998485;
 Fri, 17 Jul 2020 01:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200716144032.GC422759@redhat.com> <20200716181828.GE422759@redhat.com>
In-Reply-To: <20200716181828.GE422759@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 17 Jul 2020 10:53:07 +0200
Message-ID: <CAJfpegt-v6sjm2WyjXMWkObqLdL6TSAi=rjra4KK5sNy6hhhmA@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: Enable SB_NOSEC flag to improve small write performance
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        ganesh.mahalingam@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 8:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Jul 16, 2020 at 10:40:33AM -0400, Vivek Goyal wrote:
> > Ganesh Mahalingam reported that virtiofs is slow with small direct random
> > writes when virtiofsd is run with cache=always.
> >
> > https://github.com/kata-containers/runtime/issues/2815
> >
> > Little debugging showed that that file_remove_privs() is called in cached
> > write path on every write. And everytime it calls
> > security_inode_need_killpriv() which results in call to
> > __vfs_getxattr(XATTR_NAME_CAPS). And this goes to file server to fetch
> > xattr. This extra round trip for every write slows down writes a lot.
> >
> > Normally to avoid paying this penalty on every write, vfs has the
> > notion of caching this information in inode (S_NOSEC). So vfs
> > sets S_NOSEC, if filesystem opted for it using super block flag
> > SB_NOSEC. And S_NOSEC is cleared when setuid/setgid bit is set or
> > when security xattr is set on inode so that next time a write
> > happens, we check inode again for clearing setuid/setgid bits as well
> > clear any security.capability xattr.
> >
> > This seems to work well for local file systems but for remote file
> > systems it is possible that VFS does not have full picture and a
> > different client sets setuid/setgid bit or security.capability xattr
> > on file and that means VFS information about S_NOSEC on another client
> > will be stale. So for remote filesystems SB_NOSEC was disabled by
> > default.
> >
> > commit 9e1f1de02c2275d7172e18dc4e7c2065777611bf
> > Author: Al Viro <viro@zeniv.linux.org.uk>
> > Date:   Fri Jun 3 18:24:58 2011 -0400
> >
> >     more conservative S_NOSEC handling
> >
> > That commit mentioned that these filesystems can still make use of
> > SB_NOSEC as long as they clear S_NOSEC when they are refreshing inode
> > attriutes from server.
> >
> > So this patch tries to enable SB_NOSEC on fuse (regular fuse as well
> > as virtiofs). And clear SB_NOSEC when we are refreshing inode attributes.
> >
> > We need to clear SB_NOSEC either when inode has setuid/setgid bit set
> > or security.capability xattr has been set. We have the first piece of
> > information available in FUSE_GETATTR response. But we don't know if
> > security.capability has been set on file or not. Question is, do we
> > really need to know about security.capability. file_remove_privs()
> > always removes security.capability if a file is being written to. That
> > means when server writes to file, security.capability should be removed
> > without guest having to tell anything to it.
>
>
> I am assuming that file server will clear security.capability on host
> upon WRITE. Is it a fair assumption for all filesystems passthrough
> virtiofsd might be running?

AFAICS this needs to be gated through handle_killpriv, and with that
it can become a generic fuse feature, not just virtiofs:

 * FUSE_HANDLE_KILLPRIV: fs handles killing suid/sgid/cap on write/chown/trunc

Even writeback_cache could be handled by this addition, since we call
fuse_update_attributes() before generic_file_write_iter() :

--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -985,6 +985,7 @@ static int fuse_update_get_attr(struct inode
*inode, struct file *file,

        if (sync) {
                forget_all_cached_acls(inode);
+               inode->i_flags &= ~S_NOSEC;
                err = fuse_do_getattr(inode, stat, file);
        } else if (stat) {
                generic_fillattr(inode, stat);


Thanks,
Miklos
