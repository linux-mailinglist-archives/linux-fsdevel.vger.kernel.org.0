Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F02A14025
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2019 16:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfEEOSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 May 2019 10:18:20 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38883 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfEEOSU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 May 2019 10:18:20 -0400
Received: by mail-yw1-f68.google.com with SMTP id b74so8281029ywe.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2019 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0B6QtA+w10DaF7tkUt5KvX/UlAAb1wn8zieXB32QxBQ=;
        b=Bt3eJB9fMNjGkheRjx9WRkV8kVyxPdfc892f/cCGEHZAtK1VkvrFOyIUX7KoHqz2Ha
         XRtQvc6i2PF5UB985DMEGv6T1tnqiQ0HV/0kof3S5ne+fIz9WZmO2sLtNp5JYa+utfSH
         Q48qk1/RJSg/qqzSOfH81r3UPaC/bcU8tQU3sx7WCaLVoAh3oA4xZkd8K7e0B+55Y2pw
         Hp60esHTOAyf1456wIho+1ZUzv+poydKtUWiFDoWpEkDCJqrbTu6oSqu+AAQ/VI4K7Y1
         3PYda2e7rRHshw7JQzmCejAoTeBPto1eIQQ/O1pJiUUt0IbnvVqghT9FsWCMzysMib2b
         jyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0B6QtA+w10DaF7tkUt5KvX/UlAAb1wn8zieXB32QxBQ=;
        b=ZwvLGcjJ6TXw37Pc8oFSUM4hDha5Y3qaKG607E8SLqDvcBZYPvtBPNJhdAt/5V+Ila
         /0YU67t8Nrc0vqXtZlJXY70dqq4iIEMdYhaKnSyQn1FX/+sZ7SyqqZlhLBXzBfx2H7bA
         KxfKMvvQ+FH93PA7Ay5Ih6q0t66o0znZHJcaRvOt8qK6dOh0e8iZlVQ5iDpVdKX6pOUQ
         3etp5VNrM928NmssrKpGHB57lLLWHABRdRwwj/pJtrKCJC+7WtQ74bk30Qkd7Y4Mq6Uf
         oCtusovBD62fF3yfpFIdAx5+PEw033yAA/yNkHku5w716r25sJ8gKchecbDyf6EJXIYa
         hfhA==
X-Gm-Message-State: APjAAAV81OhOOcyX9ohCxJ0sNbvCRUaQK4DEsFPCSp6ajLxrfJ9zlTEp
        8V+SVyjRimcJAwIJsvHGHUf3XATWq5N/vvO0+wzQi1Us
X-Google-Smtp-Source: APXvYqyIs30IeRo9WroR3AvTOYbV9u++5YO+RjAASBmzYsiI+Ucp5b2oFdKyokTecsNpN8yg7fbg0m4FsLe70M3wSKM=
X-Received: by 2002:a81:9903:: with SMTP id q3mr5125377ywg.211.1557065899294;
 Sun, 05 May 2019 07:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190505091549.1934-1-amir73il@gmail.com> <20190505130528.GA23075@ZenIV.linux.org.uk>
 <CAOQ4uxhEWLXQ+cb4UQcworPQoJpXvf59HJYi2dv5pumvbxpA9w@mail.gmail.com> <20190505134706.GB23075@ZenIV.linux.org.uk>
In-Reply-To: <20190505134706.GB23075@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 5 May 2019 17:18:08 +0300
Message-ID: <CAOQ4uxiE63mNsU3dwojzR2ZypdaeVBCstRxtLZCq+LW73WbZFw@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: fix unlink performance regression
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 5, 2019 at 4:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, May 05, 2019 at 04:19:02PM +0300, Amir Goldstein wrote:
>
> > I have made an analysis of callers to d_delete() and found that all callers
> > either hold parent inode lock or name is stable for another reason:
> > https://lore.kernel.org/linux-fsdevel/20190104090357.GD22409@quack2.suse.cz/
> >
> > But Jan preferred to keep take_dentry_name_snapshot() to be safe.
> > I think the right thing to do is assert that parent inode is locked or
> > no rename op in d_delete() and take the lock in ceph/ocfs2 to conform
> > to the standard.
>
> Any messing with the locking in ceph_fill_trace() would have to come
> with very detailed proof of correctness, convincingly stable wrt
> future changes in ceph...

Yeh... Is there any other way to assert that d_name is stable in d_delete()?
My original rule was:
WARN_ON_ONCE(!inode_is_locked(dir) && dir->i_op->rename &&
      !(dir->i_sb->s_type->fs_flags & FS_RENAME_DOES_D_MOVE));

In the hope that declaring FS_RENAME_DOES_D_MOVE means fs knows
what it is doing...

Thanks,
Amir.
