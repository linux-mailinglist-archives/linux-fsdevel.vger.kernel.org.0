Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426A82C1CEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 05:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgKXEhv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 23:37:51 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42594 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbgKXEhv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 23:37:51 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D57A11F4481C
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Gao Xiang <hsiangkao@redhat.com>,
        Daniel Rosenberg <drosen@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org, kernel-team@android.com
Subject: Re: [PATCH v4 2/3] fscrypt: Have filesystems handle their d_ops
Organization: Collabora
References: <20201119060904.463807-1-drosen@google.com>
        <20201119060904.463807-3-drosen@google.com>
        <20201122051218.GA2717478@xiangao.remote.csb>
        <X7w9AO0x8vG85JQU@sol.localdomain>
Date:   Mon, 23 Nov 2020 23:37:45 -0500
In-Reply-To: <X7w9AO0x8vG85JQU@sol.localdomain> (Eric Biggers's message of
        "Mon, 23 Nov 2020 14:51:44 -0800")
Message-ID: <877dqbpdye.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Sun, Nov 22, 2020 at 01:12:18PM +0800, Gao Xiang wrote:
>> Hi all,
>> 
>> On Thu, Nov 19, 2020 at 06:09:03AM +0000, Daniel Rosenberg wrote:
>> > This shifts the responsibility of setting up dentry operations from
>> > fscrypt to the individual filesystems, allowing them to have their own
>> > operations while still setting fscrypt's d_revalidate as appropriate.
>> > 
>> > Most filesystems can just use generic_set_encrypted_ci_d_ops, unless
>> > they have their own specific dentry operations as well. That operation
>> > will set the minimal d_ops required under the circumstances.
>> > 
>> > Since the fscrypt d_ops are set later on, we must set all d_ops there,
>> > since we cannot adjust those later on. This should not result in any
>> > change in behavior.
>> > 
>> > Signed-off-by: Daniel Rosenberg <drosen@google.com>
>> > Acked-by: Eric Biggers <ebiggers@google.com>
>> > ---
>> 
>> ...
>> 
>> >  extern const struct file_operations ext4_dir_operations;
>> >  
>> > -#ifdef CONFIG_UNICODE
>> > -extern const struct dentry_operations ext4_dentry_ops;
>> > -#endif
>> > -
>> >  /* file.c */
>> >  extern const struct inode_operations ext4_file_inode_operations;
>> >  extern const struct file_operations ext4_file_operations;
>> > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
>> > index 33509266f5a0..12a417ff5648 100644
>> > --- a/fs/ext4/namei.c
>> > +++ b/fs/ext4/namei.c
>> > @@ -1614,6 +1614,7 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
>> >  	struct buffer_head *bh;
>> >  
>> >  	err = ext4_fname_prepare_lookup(dir, dentry, &fname);
>> > +	generic_set_encrypted_ci_d_ops(dentry);
>> 
>> One thing might be worth noticing is that currently overlayfs might
>> not work properly when dentry->d_sb->s_encoding is set even only some
>> subdirs are CI-enabled but the others not, see generic_set_encrypted_ci_d_ops(),
>> ovl_mount_dir_noesc => ovl_dentry_weird()
>> 
>> For more details, see:
>> https://android-review.googlesource.com/c/device/linaro/hikey/+/1483316/2#message-2e1f6ab0010a3e35e7d8effea73f60341f84ee4d
>> 
>> Just found it by chance (and not sure if it's vital for now), and
>> a kind reminder about this.
>> 
>
> Yes, overlayfs doesn't work on ext4 or f2fs filesystems that have the casefold
> feature enabled, regardless of which directories are actually using casefolding.
> This is an existing limitation which was previously discussed, e.g. at
> https://lkml.kernel.org/linux-ext4/CAOQ4uxgPXBazE-g2v=T_vOvnr_f0ZHyKYZ4wvn7A3ePatZrhnQ@mail.gmail.com/T/#u
> and
> https://lkml.kernel.org/linux-ext4/20191203051049.44573-1-drosen@google.com/T/#u.
>
> Gabriel and Daniel, is one of you still looking into fixing this?

Eric,

overlayfs+CI has been on my todo list for over a year now, as I have a
customer who wants to mix them, but I haven't been able to get to it.
I'm sure I won't be able to get to it until mid next year, so if anyone
wants to tackle it, feel free to do it.


> IIUC, the current thinking is that when the casefolding flag is set on
> a directory, it's too late to assign dentry_operations at that point.

yes

> But what if all child dentries (which must be negative) are
> invalidated first,

I recall I tried this approach when I quickly looked over this last
year, but my limited vfs knowledge prevented me from getting something
working.  But it makes sense.

> and also the filesystem forbids setting the casefold flag on encrypted
> directories that are accessed via a no-key name (so that
> fscrypt_d_revalidate isn't needed -- i.e. the directory would only go
> from "no d_ops" to "generic_ci_dentry_ops", not from
> "generic_encrypted_dentry_ops" to "generic_encrypted_ci_dentry_ops")?




-- 
Gabriel Krisman Bertazi
