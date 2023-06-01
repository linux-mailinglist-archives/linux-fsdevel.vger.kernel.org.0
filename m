Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5322719DC9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 15:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjFAN0Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 1 Jun 2023 09:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjFAN0J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:26:09 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEFFE49;
        Thu,  1 Jun 2023 06:25:55 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b0218c979cso4180975ad.3;
        Thu, 01 Jun 2023 06:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685625955; x=1688217955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpSK1tyvrOnn/69ucnamSU0HHWpIBr6ylCzTzygVnpg=;
        b=XIKeUSRvIULWX8DCC4azLgdDGgOt9diyAW8sBN30/NrP8GxbmbrN+EYQH4pd02ZD5r
         tm5sUUWkZGJUBNtocHfV7ccqtyQ9zv7aBXoB77HSr6S/qyijxmEb8kCewZWsmjtb7k86
         FxEalYmWKyZWamo9nZ6RIgi/98PpmARWZsBaBSBxQnSOd4WKIT8C5JW9yTUyxpWk9Fbj
         nsPMO4Q3v7D3uVUJyG6vmKZGFkdMXQV8uAgBiPQn070T0WAvFLOdpSDDS8tVDPLpZ0LR
         vlrsx5bzMC7/uWmjXXxNSv1PCNzv3t3xiIE3TnEdQdTNKayxbBITm4pn4hHrUIcde8tn
         T+xQ==
X-Gm-Message-State: AC+VfDzkWiUeCN9wRjM/XkyR2s7ewXihdNhfUn7y9xVfZgffBZRm1Xnn
        0Gxlw9LHRQIKRYzD2+77kmHi4jjl4jw=
X-Google-Smtp-Source: ACHHUZ4XuPQTPBqS7WhsUKDqT1g+13+LHk+tFX665SKbN++JuvAmSHadPuVku9ua8lda9h21Fumk4w==
X-Received: by 2002:a17:902:b08e:b0:1b0:3576:c2b5 with SMTP id p14-20020a170902b08e00b001b03576c2b5mr5686027plr.7.1685625954550;
        Thu, 01 Jun 2023 06:25:54 -0700 (PDT)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com. [209.85.210.171])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902748700b001afccb29d69sm3409811pll.303.2023.06.01.06.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 06:25:54 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-64d1e96c082so548064b3a.1;
        Thu, 01 Jun 2023 06:25:54 -0700 (PDT)
X-Received: by 2002:a05:6a20:ad90:b0:110:b0ab:8798 with SMTP id
 dd16-20020a056a20ad9000b00110b0ab8798mr6531759pzb.36.1685625953866; Thu, 01
 Jun 2023 06:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <808140.1685573412@warthog.procyon.org.uk>
In-Reply-To: <808140.1685573412@warthog.procyon.org.uk>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Thu, 1 Jun 2023 10:25:42 -0300
X-Gmail-Original-Message-ID: <CAB9dFduJtzreY9dY0oa0oNtXBOWzRyCDZ45zPQR4neJBBuj94Q@mail.gmail.com>
Message-ID: <CAB9dFduJtzreY9dY0oa0oNtXBOWzRyCDZ45zPQR4neJBBuj94Q@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix setting of mtime when creating a file/dir/symlink
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 31, 2023 at 7:50 PM David Howells <dhowells@redhat.com> wrote:
>
>
> kafs incorrectly passes a zero mtime (ie. 1st Jan 1970) to the server when
> creating a file, dir or symlink because commit 52af7105eceb caused the
> mtime recorded in the afs_operation struct to be passed to the server, but
> didn't modify the afs_mkdir(), afs_create() and afs_symlink() functions to
> set it first.
>
> Those functions were written with the assumption that the mtime would be
> obtained from the server - but that fell foul of malsynchronised clocks, so
> it was decided that the mtime should be set from the client instead.
>
> Fix this by filling in op->mtime before calling the create op.
>
> Fixes: 52af7105eceb ("afs: Set mtime from the client for yfs create operations")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/afs/dir.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 4dd97afa536c..5219182e52e1 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -1358,6 +1358,7 @@ static int afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>         op->dentry      = dentry;
>         op->create.mode = S_IFDIR | mode;
>         op->create.reason = afs_edit_dir_for_mkdir;
> +       op->mtime       = current_time(dir);
>         op->ops         = &afs_mkdir_operation;
>         return afs_do_sync_operation(op);
>  }
> @@ -1661,6 +1662,7 @@ static int afs_create(struct mnt_idmap *idmap, struct inode *dir,
>         op->dentry      = dentry;
>         op->create.mode = S_IFREG | mode;
>         op->create.reason = afs_edit_dir_for_create;
> +       op->mtime       = current_time(dir);
>         op->ops         = &afs_create_operation;
>         return afs_do_sync_operation(op);
>
> @@ -1796,6 +1798,7 @@ static int afs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>         op->ops                 = &afs_symlink_operation;
>         op->create.reason       = afs_edit_dir_for_symlink;
>         op->create.symlink      = content;
> +       op->mtime               = current_time(dir);
>         return afs_do_sync_operation(op);
>
>  error:

The fix looks good, but as we discussed privately, the issue that this
fixes predates commit 52af7105eceb.  That commit only touched the yfs
client code and made it rely on the op mtime rather than letting the
server set the time. This made it inherit the issue that was already
present for the non yfs client code.

Marc
