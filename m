Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 499B6ED17F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 03:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfKCCFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Nov 2019 22:05:08 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38810 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbfKCCFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Nov 2019 22:05:08 -0400
Received: by mail-il1-f194.google.com with SMTP id y5so11853420ilb.5;
        Sat, 02 Nov 2019 19:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Dt0AtL9r6sJ4IEe12mJVO75o0kUWJjuKUmQz0c8kdE=;
        b=thQSEtfdRoQRWJx/2CEz1ZWrx5tln7Nl0HARQVYHFamL69ufLxfVGBKQOCQdA+C851
         rtmUzCa9XfAKqt7Hbwubss7Fu/QOvVTF5vmg4SLlXY3AkN9JH/XtMKlKyju1HMIUn9UH
         MP4xs88ZebxhC/j4iFZ3mjHJC7yKYJ6w4tNNpqDgKNsgr71BZUzzzUWvcqkQgHJsfQKI
         Mleo+xe/eQhu1gSJs/E0Im+YZYqGhOw2qACfv/f3tqKyhAEj4SU5W/L3ypnzuURCPuJn
         f0BwRlvvLu5DCEKLIwRemU3qEqhYKZRjiIsqQuRbbt8x/5dta7nNIYxUTLL+9ywFZ2dX
         DfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Dt0AtL9r6sJ4IEe12mJVO75o0kUWJjuKUmQz0c8kdE=;
        b=XOAt5xrHMcWBarRaUfFEckhdgsNwZd993t2TkGVdX67mmkhtho8/6x2eZWVI5a3a10
         bzQ1w/mK7cOhapE+ciVT3ihROhxbX812gfnkaHKXcm/MDl2bjzfw9pPsorY1tZWfSkZs
         74+n9iY0rgtJKzqQxi/z7KldG/2NGwp7mIwP35MPNJbLYQ60UByJuaBaPWWH2ri0TlRo
         XSiAhTq5eYBatRcH2a+03yDypntMgRpKnGBfbGPCNBush1+ZCQlZf0DbBXhRjnIK8gqa
         7t5yekMssf1Z4vv7UTJzWkf0uOGDr9z4KvGTyQxpvs4yy6REtJWqPIkm+xlkp2erKugb
         xk0w==
X-Gm-Message-State: APjAAAUmevSf3GnY58XyMO3l0LdOJDnHA8p5/utFS1RRr+btjTDxOyhs
        Uo2v7RjmuXK7CxYwhVcOVb4oRYO3hRWKe80d/eU=
X-Google-Smtp-Source: APXvYqz7ncSDxVWHT6VnSymB/1QNaKCbVXfsrbVt6IoQA6UfJPfpWbyZJGT50MsUpsawS1sqM5s+OvUgdQiXLY8IxY0=
X-Received: by 2002:a92:48d8:: with SMTP id j85mr21159028ilg.272.1572746707214;
 Sat, 02 Nov 2019 19:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191031035514.20871-1-lsahlber@redhat.com>
In-Reply-To: <20191031035514.20871-1-lsahlber@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 2 Nov 2019 21:04:56 -0500
Message-ID: <CAH2r5mv1rGmGha-NDXzix6yjH4FmZ+RGvP61eEG3cF8sWVRG5w@mail.gmail.com>
Subject: Re: [PATCH] cifs: don't use 'pre:' for MODULE_SOFTDEP
To:     Ronnie Sahlberg <lsahlber@redhat.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tentatively merged into cifs-2.6.git for-next but am curious about the
similar problem with ext4 and btrfs

On Wed, Oct 30, 2019 at 10:59 PM Ronnie Sahlberg <lsahlber@redhat.com> wrote:
>
> It can cause
> to fail with
> modprobe: FATAL: Module <module> is builtin.
>
> RHBZ: 1767094
>
> Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> ---
>  fs/cifs/cifsfs.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index f8e201c45ccb..a578699ce63c 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -1677,17 +1677,17 @@ MODULE_DESCRIPTION
>         ("VFS to access SMB3 servers e.g. Samba, Macs, Azure and Windows (and "
>         "also older servers complying with the SNIA CIFS Specification)");
>  MODULE_VERSION(CIFS_VERSION);
> -MODULE_SOFTDEP("pre: ecb");
> -MODULE_SOFTDEP("pre: hmac");
> -MODULE_SOFTDEP("pre: md4");
> -MODULE_SOFTDEP("pre: md5");
> -MODULE_SOFTDEP("pre: nls");
> -MODULE_SOFTDEP("pre: aes");
> -MODULE_SOFTDEP("pre: cmac");
> -MODULE_SOFTDEP("pre: sha256");
> -MODULE_SOFTDEP("pre: sha512");
> -MODULE_SOFTDEP("pre: aead2");
> -MODULE_SOFTDEP("pre: ccm");
> -MODULE_SOFTDEP("pre: gcm");
> +MODULE_SOFTDEP("ecb");
> +MODULE_SOFTDEP("hmac");
> +MODULE_SOFTDEP("md4");
> +MODULE_SOFTDEP("md5");
> +MODULE_SOFTDEP("nls");
> +MODULE_SOFTDEP("aes");
> +MODULE_SOFTDEP("cmac");
> +MODULE_SOFTDEP("sha256");
> +MODULE_SOFTDEP("sha512");
> +MODULE_SOFTDEP("aead2");
> +MODULE_SOFTDEP("ccm");
> +MODULE_SOFTDEP("gcm");
>  module_init(init_cifs)
>  module_exit(exit_cifs)
> --
> 2.13.6
>


-- 
Thanks,

Steve
