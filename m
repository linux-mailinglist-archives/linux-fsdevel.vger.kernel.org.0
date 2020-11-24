Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092332C1B4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 03:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgKXCIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 21:08:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728002AbgKXCIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 21:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606183722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WP+31OsU+5g/aMu0W36G+ShW7+TjC+8Wfm0ANAD2BDg=;
        b=SJijZ7EzXcr1BWrAHhxtUQ6N0w7uorsqNwlhJd6WG9m9i9Fl0uWvBemFHwG9aZIWwzf4ea
        wfUmZlhmeJtZxtJuRx3oRO/rtg3OzzqAQJkmSiTCqcClZKPQ3T74oV/VAwQ8OmPlldFJLw
        8bdZK1daCfE6cljhREd/OVn2TzQSKSw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-0B_mKUt8PB2UTr3UDpkfNg-1; Mon, 23 Nov 2020 21:08:40 -0500
X-MC-Unique: 0B_mKUt8PB2UTr3UDpkfNg-1
Received: by mail-pg1-f198.google.com with SMTP id f19so13924738pgm.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 18:08:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WP+31OsU+5g/aMu0W36G+ShW7+TjC+8Wfm0ANAD2BDg=;
        b=SWLvDeI28kIl+4jb7x+cGP+Br9R9dTWPcl+dBeeIvMHh+SiiHTVl4ETdpiRLb1+cuD
         jdaC4ffehLtQ2SOUYfH5mez9XGLskJrA3/qFfv3q6s4odiRlkNkOwoVg+zhSXAaj8Y3n
         pOBhbL1tfLEAyJ9jbNnBtCZl8REgcwLRhb0pC6XcgSetcyM05HsxexS6ysvpbTSmbBMq
         pX1dMnMOGRmKDhj1QDdvuRhINDuxLm/4Mq2RYyLMY5ledA+qFRa+FGiWZUBFtS2a1EHk
         VpPjBAm+os5xAn/vBtY8+Tovjlp1Tikmg3QyX/0KgOJraD5xesq6mVcZrmcXpMSQw6Cz
         QzPA==
X-Gm-Message-State: AOAM532OiSpWw2TwUAiP1L6dGp5Umb4g7tgCHAEJ1mS+rVikpuLLH/V7
        hkArEoHg7n0Dh09cIoue9ILiGCnz24kLxDAFoD5CdI1owE8eJLoVL4spWbErOiLWLRKwRGSVZLt
        mapO63whjUCs0gmnjGWbiZLfQ9w==
X-Received: by 2002:a17:902:6b08:b029:d6:c471:8b5b with SMTP id o8-20020a1709026b08b02900d6c4718b5bmr1986833plk.78.1606183718984;
        Mon, 23 Nov 2020 18:08:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5+igtPET/Dt98T/kKfa/91YJzxneE9zETKp3qe+D1ZXJ/z5cODpK8Yh/f0wMZsyQSBVZxXw==
X-Received: by 2002:a17:902:6b08:b029:d6:c471:8b5b with SMTP id o8-20020a1709026b08b02900d6c4718b5bmr1986811plk.78.1606183718720;
        Mon, 23 Nov 2020 18:08:38 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y3sm723148pjb.18.2020.11.23.18.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 18:08:38 -0800 (PST)
Date:   Tue, 24 Nov 2020 10:08:24 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
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
Message-ID: <20201124020824.GA3156301@xiangao.remote.csb>
References: <20201119060904.463807-1-drosen@google.com>
 <20201119060904.463807-3-drosen@google.com>
 <20201122051218.GA2717478@xiangao.remote.csb>
 <X7w9AO0x8vG85JQU@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X7w9AO0x8vG85JQU@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 02:51:44PM -0800, Eric Biggers wrote:
> On Sun, Nov 22, 2020 at 01:12:18PM +0800, Gao Xiang wrote:
> > Hi all,
> > 
> > On Thu, Nov 19, 2020 at 06:09:03AM +0000, Daniel Rosenberg wrote:
> > > This shifts the responsibility of setting up dentry operations from
> > > fscrypt to the individual filesystems, allowing them to have their own
> > > operations while still setting fscrypt's d_revalidate as appropriate.
> > > 
> > > Most filesystems can just use generic_set_encrypted_ci_d_ops, unless
> > > they have their own specific dentry operations as well. That operation
> > > will set the minimal d_ops required under the circumstances.
> > > 
> > > Since the fscrypt d_ops are set later on, we must set all d_ops there,
> > > since we cannot adjust those later on. This should not result in any
> > > change in behavior.
> > > 
> > > Signed-off-by: Daniel Rosenberg <drosen@google.com>
> > > Acked-by: Eric Biggers <ebiggers@google.com>
> > > ---
> > 
> > ...
> > 
> > >  extern const struct file_operations ext4_dir_operations;
> > >  
> > > -#ifdef CONFIG_UNICODE
> > > -extern const struct dentry_operations ext4_dentry_ops;
> > > -#endif
> > > -
> > >  /* file.c */
> > >  extern const struct inode_operations ext4_file_inode_operations;
> > >  extern const struct file_operations ext4_file_operations;
> > > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > > index 33509266f5a0..12a417ff5648 100644
> > > --- a/fs/ext4/namei.c
> > > +++ b/fs/ext4/namei.c
> > > @@ -1614,6 +1614,7 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
> > >  	struct buffer_head *bh;
> > >  
> > >  	err = ext4_fname_prepare_lookup(dir, dentry, &fname);
> > > +	generic_set_encrypted_ci_d_ops(dentry);
> > 
> > One thing might be worth noticing is that currently overlayfs might
> > not work properly when dentry->d_sb->s_encoding is set even only some
> > subdirs are CI-enabled but the others not, see generic_set_encrypted_ci_d_ops(),
> > ovl_mount_dir_noesc => ovl_dentry_weird()
> > 
> > For more details, see:
> > https://android-review.googlesource.com/c/device/linaro/hikey/+/1483316/2#message-2e1f6ab0010a3e35e7d8effea73f60341f84ee4d
> > 
> > Just found it by chance (and not sure if it's vital for now), and
> > a kind reminder about this.
> > 
> 
> Yes, overlayfs doesn't work on ext4 or f2fs filesystems that have the casefold
> feature enabled, regardless of which directories are actually using casefolding.
> This is an existing limitation which was previously discussed, e.g. at
> https://lkml.kernel.org/linux-ext4/CAOQ4uxgPXBazE-g2v=T_vOvnr_f0ZHyKYZ4wvn7A3ePatZrhnQ@mail.gmail.com/T/#u
> and
> https://lkml.kernel.org/linux-ext4/20191203051049.44573-1-drosen@google.com/T/#u.
> 
> Gabriel and Daniel, is one of you still looking into fixing this?  IIUC, the
> current thinking is that when the casefolding flag is set on a directory, it's
> too late to assign dentry_operations at that point.  But what if all child
> dentries (which must be negative) are invalidated first, and also the filesystem
> forbids setting the casefold flag on encrypted directories that are accessed via
> a no-key name (so that fscrypt_d_revalidate isn't needed -- i.e. the directory
> would only go from "no d_ops" to "generic_ci_dentry_ops", not from
> "generic_encrypted_dentry_ops" to "generic_encrypted_ci_dentry_ops")?

From my limited knowledge about VFS, I think that is practical as well, since
we don't have sub-sub-dirs since all sub-dirs are negative dentries for empty dirs.
And if casefold ioctl is "dir inode locked", I think that would be fine (?)
I don't check the code though.

Thanks,
Gao Xiang

> 
> - Eric
> 

