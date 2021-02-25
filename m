Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34283255C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 19:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhBYSps (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 13:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbhBYSpc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:45:32 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04EBC061574;
        Thu, 25 Feb 2021 10:44:51 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id r25so6696472ljk.11;
        Thu, 25 Feb 2021 10:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbx8LPOFbmXf8Szf9y254PvyCx/aSExb5Tf2CHubYaM=;
        b=k3PoCZTLRY18NdHrgvvVJN1BpIe7QYovvg6t3tBHtSvNsm/NED+s7C5NmrSuvWDLXM
         ini3+YvqF6AbfNOqtM4PICyTIIvpr2A3rkAJexntLVgPQGSPTCYeDGb54m2mRiLhdZvq
         Lde2fI7GnlFB0aF0v3Z+G6lJzjVAg22U51iG1Ny9B8Q8cdbtqDZyWjfbUNW8UDQVf4L9
         IkM+AoETAmEoEHoCURYq77YcJqc+MKA8e1fPZowlyA20UteVBj3jZEfpHp1EQTP/UnBS
         +zi9N1EXW4uYR3tGSGyLEnAbxRjizVgCbXOSmAByInmElzJJUJPlJQ1SBg74Z3X8D6bz
         7wNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbx8LPOFbmXf8Szf9y254PvyCx/aSExb5Tf2CHubYaM=;
        b=AsApA3gJmGAiQcS50EHL9QlQAo1/4Mv5QfRgln3O6cgad9aLmrbe8IFduWs8ut/w5r
         1sgUytuXhZ4HHZvEwMOX3asFeWumcmEGPJcQUmN7LJhFAQaHhYPmeUaiQ5saQRPdFXA3
         Vv68/GEx1eYAnb9cMYDbYAb8xg/2aFDogtVe8rhNECxA5SSyi+c+UDuBFnI/8GRCe+02
         hOCRNIEYd7vDB5FEAnfYbv/Kx5xEVUQD+FPxwKmBszecPyjthn71CpC6Td/e+9oy7wmo
         +KcaPXZkK4/VpLYS6rOG6zy+a4ZOb1cfQRg7UsaayCmVzUx0V+vKRH3gkYkaq4GMqCZl
         W/cw==
X-Gm-Message-State: AOAM532dGUuBRHTQc3NwXswEOvm8gZ/XNdhXrx9ocfrAv2bnrDAkHTqP
        ZYgn3pvzkDQfliTnMbhUtgWpG15D/depqP2TpNZM+6iyEdg=
X-Google-Smtp-Source: ABdhPJxJieTySEIj+LiFJ8FAagEm0v5OXzojxA5GtSJCuK3eIhed0GC/PfoSDqU5XxRqn+IUhD/kPokkB3yTHASSTMg=
X-Received: by 2002:a05:651c:3cb:: with SMTP id f11mr2325034ljp.272.1614278689962;
 Thu, 25 Feb 2021 10:44:49 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mt+69AZFh_2OOd2JHLtqG9jo7=O7HF4bTGbSjhgi=M53g@mail.gmail.com>
In-Reply-To: <CAH2r5mt+69AZFh_2OOd2JHLtqG9jo7=O7HF4bTGbSjhgi=M53g@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 25 Feb 2021 12:44:38 -0600
Message-ID: <CAH2r5muBiaOZooFd0XgBuNUkifH1qA1RkdJy963=UHFLQXMwGA@mail.gmail.com>
Subject: Re: [PATCH] cifs: convert readpages_fill_pages to use iter
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tentatively merged into cifs-2.6.git for-next, pending testing

On Thu, Feb 4, 2021 at 12:49 AM Steve French <smfrench@gmail.com> wrote:
>
> (Another patch to make conversion to new netfs interfaces easier)
>
> Optimize read_page_from_socket by using an iov_iter
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> ---
>  fs/cifs/cifsglob.h  |  1 +
>  fs/cifs/cifsproto.h |  3 +++
>  fs/cifs/connect.c   | 16 ++++++++++++++++
>  fs/cifs/file.c      |  3 +--
>  4 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> index 50fcb65920e8..73f80cc38316 100644
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -1301,6 +1301,7 @@ struct cifs_readdata {
>   int (*copy_into_pages)(struct TCP_Server_Info *server,
>   struct cifs_readdata *rdata,
>   struct iov_iter *iter);
> + struct iov_iter iter;
>   struct kvec iov[2];
>   struct TCP_Server_Info *server;
>  #ifdef CONFIG_CIFS_SMB_DIRECT
> diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
> index 75ce6f742b8d..64eb5c817712 100644
> --- a/fs/cifs/cifsproto.h
> +++ b/fs/cifs/cifsproto.h
> @@ -239,6 +239,9 @@ extern int cifs_read_page_from_socket(struct
> TCP_Server_Info *server,
>   unsigned int page_offset,
>   unsigned int to_read);
>  extern int cifs_setup_cifs_sb(struct cifs_sb_info *cifs_sb);
> +extern int cifs_read_iter_from_socket(struct TCP_Server_Info *server,
> +       struct iov_iter *iter,
> +       unsigned int to_read);
>  extern int cifs_match_super(struct super_block *, void *);
>  extern int cifs_mount(struct cifs_sb_info *cifs_sb, struct
> smb3_fs_context *ctx);
>  extern void cifs_umount(struct cifs_sb_info *);
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index 943f4eba027d..7c8db233fba4 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -585,6 +585,22 @@ cifs_read_page_from_socket(struct TCP_Server_Info
> *server, struct page *page,
>   return cifs_readv_from_socket(server, &smb_msg);
>  }
>
> +int
> +cifs_read_iter_from_socket(struct TCP_Server_Info *server, struct
> iov_iter *iter,
> +    unsigned int to_read)
> +{
> + struct msghdr smb_msg;
> + int ret;
> +
> + smb_msg.msg_iter = *iter;
> + if (smb_msg.msg_iter.count > to_read)
> + smb_msg.msg_iter.count = to_read;
> + ret = cifs_readv_from_socket(server, &smb_msg);
> + if (ret > 0)
> + iov_iter_advance(iter, ret);
> + return ret;
> +}
> +
>  static bool
>  is_smb_response(struct TCP_Server_Info *server, unsigned char type)
>  {
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 6d001905c8e5..4b8c1ac58f00 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -4261,8 +4261,7 @@ readpages_fill_pages(struct TCP_Server_Info *server,
>   result = n;
>  #endif
>   else
> - result = cifs_read_page_from_socket(
> - server, page, page_offset, n);
> + result = cifs_read_iter_from_socket(server, &rdata->iter, n);
>   if (result < 0)
>   break;
>
>
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve
