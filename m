Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8145F7A4EA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjIRQUi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjIRQU2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:20:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66115FC5;
        Mon, 18 Sep 2023 09:17:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AEDC433B7;
        Mon, 18 Sep 2023 13:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045108;
        bh=jiGrt6majxDR+XMOL+qVbyDBwKKU2Pb4JTzAJ6GQJEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPrbpHUafnMPvp4lSfOS5DEN4hjXnwPwKAXM3Z0zwmTzIP5zeJkn8U9NzB38B5Tex
         k+2tyA6hrOslXumLkwMjHPpZ+WQGvkjfeS20C0Cb/KbV4p6/Nx3KaY2BBxdDjRA2Oq
         M/QPer3Z0Zmp1vFxzR5roQfGsteyheBghYUFbMTrWg2o5WdqAXXMmIsWFjhIjiknoz
         Zs6at91WlL6saoO8M1axs/BCMJYjR9XA+8Vkk7NV2ROdgImshQLMo4QYe5rOkYWkXf
         uc1BPYi5/reup0U7DOzjaPaXJkuWVmscixL/VAo9Mh+/vbb5SfoahdBXnAiqqYxuQZ
         b8kgNMNS0Ke2g==
Date:   Mon, 18 Sep 2023 15:51:42 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Message-ID: <20230918-grafik-zutreffen-995b321017ae@brauner>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
 <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner>
 <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Atomicity of getting a snapshot of the current mount tree with all of
> its attributes was never guaranteed, although reading
> /proc/self/mountinfo into a sufficiently large buffer would work that
> way.   However, I don't see why mount trees would require stronger
> guarantees than dentry trees (for which we have basically none).

So atomicity was never put forward as a requirement. In that
session/recording I explicitly state that we won't guarantee atomicity.
And systemd agreed with this. So I think we're all on the same page.

> Even more type clean interface:
> 
> struct statmnt *statmnt(u64 mnt_id, u64 mask, void *buf, size_t
> bufsize, unsigned int flags);
> 
> Kernel would return a fully initialized struct with the numeric as
> well as string fields filled.  That part is trivial for userspace to
> deal with.

I really would prefer a properly typed struct and that's what everyone
was happy with in the session as well. So I would not like to change the
main parameters.

> > Plus, the format for how to return arbitrary filesystem mount options
> > warrants a separate discussion imho as that's not really vfs level
> > information.
> 
> Okay.   Let's take fs options out of this.

Thanks.

> 
> That leaves:
> 
>  - fs type and optionally subtype

So since subtype is FUSE specific it might be better to move this to
filesystem specific options imho.

>  - root of mount within fs
>  - mountpoint path
> 
> The type and subtype are naturally limited to sane sizes, those are
> not an issue.

What's the limit for fstype actually? I don't think there is one.
There's one by chance but not by design afaict?

Maybe crazy idea:
That magic number thing that we do in include/uapi/linux/magic.h
is there a good reason for this or why don't we just add a proper,
simple enum:

enum {
        FS_TYPE_ADFS        1
        FS_TYPE_AFFS        2
        FS_TYPE_AFS         3
        FS_TYPE_AUTOFS      4
	FS_TYPE_EXT2	    5
	FS_TYPE_EXT3	    6
	FS_TYPE_EXT4	    7
	.
	.
	.
	FS_TYPE_MAX
}

that we start returning from statmount(). We can still return both the
old and the new fstype? It always felt a bit odd that fs developers to
just select a magic number.

> 
> For paths the evolution of the relevant system/library calls was:
> 
>   char *getwd(char buf[PATH_MAX]);
>   char *getcwd(char *buf, size_t size);
>   char *get_current_dir_name(void);
> 
> It started out using a fixed size buffer, then a variable sized
> buffer, then an automatically allocated buffer by the library, hiding
> the need to resize on overflow.
> 
> The latest style is suitable for the statmnt() call as well, if we
> worry about pleasantness of the API.

So, can we then do the following struct:

struct statmnt {
        __u64 mask;             /* What results were written [uncond] */
        __u32 sb_dev_major;     /* Device ID */
        __u32 sb_dev_minor;
        __u64 sb_magic;         /* ..._SUPER_MAGIC */
        __u32 sb_flags;         /* MS_{RDONLY,SYNCHRONOUS,DIRSYNC,LAZYTIME} */
        __u32 __spare1;
        __u64 mnt_id;           /* Unique ID of mount */
        __u64 mnt_parent_id;    /* Unique ID of parent (for root == mnt_id) */
        __u32 mnt_id_old;       /* Reused IDs used in proc/.../mountinfo */
        __u32 mnt_parent_id_old;
        __u64 mnt_attr;         /* MOUNT_ATTR_... */
        __u64 mnt_propagation;  /* MS_{SHARED,SLAVE,PRIVATE,UNBINDABLE} */
        __u64 mnt_peer_group;   /* ID of shared peer group */
        __u64 mnt_master;       /* Mount receives propagation from this ID */
        __u64 propagate_from;   /* Propagation from in current namespace */
	__aligned_u64 mountpoint;
	__u32 mountpoint_len;
	__aligned_u64 mountroot;
	__u32 mountroot_len;
        __u64 __spare[20];
};

Userspace knows already how to deal with that because of bpf and other
structs (e.g., both systemd and LXC have ptr_to_u64() helpers and so
on). Libmount and glibc can hide this away internally as well.
