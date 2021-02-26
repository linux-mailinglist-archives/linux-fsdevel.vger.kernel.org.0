Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E97325BA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 03:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhBZCZi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 21:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhBZCZh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 21:25:37 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9DDC061788;
        Thu, 25 Feb 2021 18:24:50 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id v5so11612717lft.13;
        Thu, 25 Feb 2021 18:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ljsGvMwIzgHHd0f4Vzgd0s3wnQN5Zmki9Mycw1KyE20=;
        b=M8Za0ABFDT0XGYATp0lJiKFBajA8W9X01tlfgzeutS/xet6dWy9ZED3yNAXjpddj48
         nwsQVGIQKkz2CKB5eHrSySUbQr7Tq0hgAqWZt8v5THS46wN4MMjPC4EUSDS8cNk/7pZb
         lCz3NQLmuQnc7iOVNBgt75Je9qw3qv/xGvmb1nLA745sHe590AngYuKbm7k93blFld/a
         3/GidVSB+S2OiESceEcmyjNoHKvapH+MluaI/jV2Z0/n9+Pf5lzy8Ng+8yyu94FBqvWZ
         5JFQSk9+HUhbrob7RdwwfejFVD6+y/vmHaby96ej+5EEmkh4icT14zyBSkDR6z+2faFN
         eqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ljsGvMwIzgHHd0f4Vzgd0s3wnQN5Zmki9Mycw1KyE20=;
        b=adnN5Ulla1YmNOaE+sszY8D83Sezxazuqzf3sAlV6ywvVxVN4rJht2h+iwWhbOLY8J
         +y0EYikwcFIDqVUzZUhfM+Etl9XAKkStL5BiISEk5fKrNw4jFSZSEaYfSs0TmYYgf++M
         8UaxBm3/eFrtAH6Vp6XmpprE+/rTcifso286Z/juFJA6T5ygSf3nGG5ogtrTiFfN5oM/
         WrGWaHs+oNSaWOIU86inexmxt8ucMkWQvvIFyHiRl49ppjNXBu60F+kRcNrORnqnCSFi
         qJLWxlAiDgO7O7w02FgXtm2+C+WByHZd1lu+wZ4owWotu/qSWAdSmMQOIZRJsLa2Q1BA
         aDog==
X-Gm-Message-State: AOAM532lBrXjog5neM4rdbSRZglOD9XS5rEn0fF8quoTd/AcG+nCe447
        5r9QdwyKngiR435QjBjb20UjMMoJhXtsx40xxmdVtrebXeQ=
X-Google-Smtp-Source: ABdhPJxPPfndalw1ojAYxxhgYD3sz9pNioMNLvRbzXokrKZA2qcfQB8IcPTdLsMsb/MmxgBIA4ZcG+YQkqO2liDr1Jk=
X-Received: by 2002:a19:404f:: with SMTP id n76mr481236lfa.184.1614306288903;
 Thu, 25 Feb 2021 18:24:48 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mt+69AZFh_2OOd2JHLtqG9jo7=O7HF4bTGbSjhgi=M53g@mail.gmail.com>
 <CAH2r5muBiaOZooFd0XgBuNUkifH1qA1RkdJy963=UHFLQXMwGA@mail.gmail.com>
In-Reply-To: <CAH2r5muBiaOZooFd0XgBuNUkifH1qA1RkdJy963=UHFLQXMwGA@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 25 Feb 2021 20:24:37 -0600
Message-ID: <CAH2r5mu6yo=fFpWwE3JZ0PbcdvWPA+Y9t4bHnQgAk+LS20-AUg@mail.gmail.com>
Subject: Re: [PATCH] cifs: convert readpages_fill_pages to use iter
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It regressed when buildbot tests run on it (hundreds of signing error
messages logged as well) - so backed this patch out of for-next

On Thu, Feb 25, 2021 at 12:44 PM Steve French <smfrench@gmail.com> wrote:
>
> Tentatively merged into cifs-2.6.git for-next, pending testing
>
> On Thu, Feb 4, 2021 at 12:49 AM Steve French <smfrench@gmail.com> wrote:
> >
> > (Another patch to make conversion to new netfs interfaces easier)
> >
> > Optimize read_page_from_socket by using an iov_iter
> >
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Signed-off-by: Steve French <stfrench@microsoft.com>
> > ---
> >  fs/cifs/cifsglob.h  |  1 +
> >  fs/cifs/cifsproto.h |  3 +++
> >  fs/cifs/connect.c   | 16 ++++++++++++++++
> >  fs/cifs/file.c      |  3 +--
> >  4 files changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> > index 50fcb65920e8..73f80cc38316 100644
> > --- a/fs/cifs/cifsglob.h
> > +++ b/fs/cifs/cifsglob.h
> > @@ -1301,6 +1301,7 @@ struct cifs_readdata {
> >   int (*copy_into_pages)(struct TCP_Server_Info *server,
> >   struct cifs_readdata *rdata,
> >   struct iov_iter *iter);
> > + struct iov_iter iter;
> >   struct kvec iov[2];
> >   struct TCP_Server_Info *server;
> >  #ifdef CONFIG_CIFS_SMB_DIRECT
> > diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
> > index 75ce6f742b8d..64eb5c817712 100644
> > --- a/fs/cifs/cifsproto.h
> > +++ b/fs/cifs/cifsproto.h
> > @@ -239,6 +239,9 @@ extern int cifs_read_page_from_socket(struct
> > TCP_Server_Info *server,
> >   unsigned int page_offset,
> >   unsigned int to_read);
> >  extern int cifs_setup_cifs_sb(struct cifs_sb_info *cifs_sb);
> > +extern int cifs_read_iter_from_socket(struct TCP_Server_Info *server,
> > +       struct iov_iter *iter,
> > +       unsigned int to_read);
> >  extern int cifs_match_super(struct super_block *, void *);
> >  extern int cifs_mount(struct cifs_sb_info *cifs_sb, struct
> > smb3_fs_context *ctx);
> >  extern void cifs_umount(struct cifs_sb_info *);
> > diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> > index 943f4eba027d..7c8db233fba4 100644
> > --- a/fs/cifs/connect.c
> > +++ b/fs/cifs/connect.c
> > @@ -585,6 +585,22 @@ cifs_read_page_from_socket(struct TCP_Server_Info
> > *server, struct page *page,
> >   return cifs_readv_from_socket(server, &smb_msg);
> >  }
> >
> > +int
> > +cifs_read_iter_from_socket(struct TCP_Server_Info *server, struct
> > iov_iter *iter,
> > +    unsigned int to_read)
> > +{
> > + struct msghdr smb_msg;
> > + int ret;
> > +
> > + smb_msg.msg_iter = *iter;
> > + if (smb_msg.msg_iter.count > to_read)
> > + smb_msg.msg_iter.count = to_read;
> > + ret = cifs_readv_from_socket(server, &smb_msg);
> > + if (ret > 0)
> > + iov_iter_advance(iter, ret);
> > + return ret;
> > +}
> > +
> >  static bool
> >  is_smb_response(struct TCP_Server_Info *server, unsigned char type)
> >  {
> > diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> > index 6d001905c8e5..4b8c1ac58f00 100644
> > --- a/fs/cifs/file.c
> > +++ b/fs/cifs/file.c
> > @@ -4261,8 +4261,7 @@ readpages_fill_pages(struct TCP_Server_Info *server,
> >   result = n;
> >  #endif
> >   else
> > - result = cifs_read_page_from_socket(
> > - server, page, page_offset, n);
> > + result = cifs_read_iter_from_socket(server, &rdata->iter, n);
> >   if (result < 0)
> >   break;
> >
> >
> > --
> > Thanks,
> >
> > Steve
>
>
>
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve
