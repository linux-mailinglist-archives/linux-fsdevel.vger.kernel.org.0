Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6489CBC8F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 15:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505062AbfIXNaa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 09:30:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46100 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505058AbfIXNaa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 09:30:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id u22so2081501qtq.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2019 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5MMdmEI5E3YGr18eOY+CzA36GDQKBSr573ORf++OIig=;
        b=ux/4VDyHuy/J1rXbaFWi7pE86io9QNhjmComOk8cMBBOnRq+ypAy5jXyK6J4quq4m3
         bxWvfnfgVEkiES1wLPmv0DY8yS0YqWEGzh18RgfRTLCtvF/pUN25LfZmlJn+1NHQQdGT
         0EQ7Y1tvTprvs+E+Mj0oemTj5V9Yizq5/SmUrDdkHuQ1U+fh/UeTErWEQssMZljcX9l6
         Dc/ej2E4wVuCvihnRc9jv8Y2QCm7emT0L8d9uVBw1Ren0DWNKHj4KdIAU4cV9jPSeBie
         sx/8GbD/8Sgp4xpevPnX1Xwn/3a111uB5vj0xkXE9oyzdCU8u/SH4Be5UsbrKo9O3iOJ
         Mfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5MMdmEI5E3YGr18eOY+CzA36GDQKBSr573ORf++OIig=;
        b=TFbTOLi+mykd9O7uKDe9aQtTcrdsip0nwJ/SI4m97xnaleezMrZ4T7EQ2Sq0DS+5uy
         dyjg1N4OPomGiw+CDEYib7E80IQlk1vTV4xktCIq666jHvprTa1nWoOpmeME9hWYBQnZ
         y+ew2+PhGPLB+Z73JJZPnSnOID5/JzkHDjfKcmcYo4iZzFvQ1xA/GBY0QdykwUR0OhC9
         hO+1qG+fGYVDDz/MdY/3N4S3EqtgOzg395gss5emsL21Pjg/04eyGM2BWIxczUaS6p/z
         b8/pXX+pbOFjrOLtsceChFhz0/tioQ0DBNjbAiJnPU/dJGZJREl3OUvNGKS8jzRTLIYQ
         s1mg==
X-Gm-Message-State: APjAAAXzMALYqbE3y2zUPPoVWmsyiXoVfgunNW1eHpvKR/G+XJKzseWl
        CSHBD4mjzKAkmSTROPqY6MmJWA==
X-Google-Smtp-Source: APXvYqzjyxB9ym582W5hkail5QrvOGDSjAstiMeIulH4RPqRz7KSnnBtvmkpRJW3vuDrKCbF7rRPHg==
X-Received: by 2002:ad4:458d:: with SMTP id x13mr2442272qvu.85.1569331828635;
        Tue, 24 Sep 2019 06:30:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::b7c9])
        by smtp.gmail.com with ESMTPSA id p22sm856947qkk.92.2019.09.24.06.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 06:30:27 -0700 (PDT)
Date:   Tue, 24 Sep 2019 09:30:26 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>, linux-btrfs@vger.kernel.org,
        "Yan, Zheng" <zyan@redhat.com>, linux-cifs@vger.kernel.org,
        Steve French <sfrench@us.ibm.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190924133025.jeh7ond2svm3lsub@macbook-pro-91.dhcp.thefacebook.com>
References: <20190914170146.GT1131@ZenIV.linux.org.uk>
 <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
 <20190914200412.GU1131@ZenIV.linux.org.uk>
 <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
 <20190915005046.GV1131@ZenIV.linux.org.uk>
 <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
 <20190915160236.GW1131@ZenIV.linux.org.uk>
 <CAHk-=whjNE+_oSBP_o_9mquUKsJn4gomL2f0MM79gxk_SkYLRw@mail.gmail.com>
 <20190921140731.GQ1131@ZenIV.linux.org.uk>
 <20190924025215.GA9941@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924025215.GA9941@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 03:52:15AM +0100, Al Viro wrote:
> [btrfs and cifs folks Cc'd]
> 
> On Sat, Sep 21, 2019 at 03:07:31PM +0100, Al Viro wrote:
> 
> > No "take cursors out of the list" parts yet.
> 
> Argh...  The things turned interesting.  The tricky part is
> where do we handle switching cursors away from something
> that gets moved.
> 
> What I hoped for was "just do it in simple_rename()".  Which is
> almost OK; there are 3 problematic cases.  One is shmem -
> there we have a special ->rename(), which handles things
> like RENAME_EXCHANGE et.al.  Fair enough - some of that
> might've been moved into simple_rename(), but some (whiteouts)
> won't be that easy.  Fair enough - we can make kicking the
> cursors outs a helper called by simple_rename() and by that.
> Exchange case is going to cause a bit of headache (the
> pathological case is when the entries being exchanged are
> next to each other in the same directory), but it's not
> that bad.
> 
> Two other cases, though, might be serious trouble.  Those are
> btrfs new_simple_dir() and this in cifs_root_iget():
>         if (rc && tcon->pipe) {
>                 cifs_dbg(FYI, "ipc connection - fake read inode\n");
>                 spin_lock(&inode->i_lock);
>                 inode->i_mode |= S_IFDIR;
>                 set_nlink(inode, 2);
>                 inode->i_op = &cifs_ipc_inode_ops;
>                 inode->i_fop = &simple_dir_operations;
>                 inode->i_uid = cifs_sb->mnt_uid;
>                 inode->i_gid = cifs_sb->mnt_gid;
>                 spin_unlock(&inode->i_lock);
> 	}
> The trouble is, it looks like d_splice_alias() from a lookup elsewhere
> might find an alias of some subdirectory in those.  And in that case
> we'll end up with a child of those (dcache_readdir-using) directories
> being ripped out and moved elsewhere.  With no calls of ->rename() in
> sight, of course, *AND* with only shared lock on the parent.  The
> last part is really nasty.  And not just for hanging cursors off the
> dentries they point to - it's a problem for dcache_readdir() itself
> even in the mainline and with all the lockless crap reverted.
> 
> We pass next->d_name.name to dir_emit() (i.e. potentially to
> copy_to_user()).  And we have no warranty that it's not a long
> (== separately allocated) name, that will be freed while
> copy_to_user() is in progress.  Sure, it'll get an RCU delay
> before freeing, but that doesn't help us at all.
> 
> I'm not familiar with those areas in btrfs or cifs; could somebody
> explain what's going on there and can we indeed end up finding aliases
> to those suckers?

We can't for the btrfs case.  This is used for the case where we have a link to
a subvolume but the root has disappeared already, so we add in that dummy inode.
We completely drop the dcache from that root downards when we drop the
subvolume, so we're not going to find aliases underneath those things.  Is that
what you're asking?  Thanks,

Josef
