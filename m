Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63E4E11D378
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 18:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfLLROF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 12:14:05 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41108 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbfLLROF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:14:05 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so3576283ioo.8;
        Thu, 12 Dec 2019 09:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7zp5AU7+v+4wQYF7EXic/VeL+BZYCULV2dZfkWHkOtQ=;
        b=IWnOmzlzbqC+ElOmkaN5htx1fAk8YpLKlvnmc+M1O6wz2YsIBWgv2ucjoupkTrJYSf
         RQk/aIwRObx5MCyGEYWUg9cNnMVOvKAmp0b3OVYQwnvsbIu9iZrdVNXce0DEYFqwz6Bj
         dp52oMlXjMhD/RhIqQz1t5BgrTplU5tp7psonCF9WQFIVgScm3KnKORFGvYnGmS8wJOF
         w/nXmWTw3mS8g92glen5t3UVFCRYnyECGDdmJUv3xN7/iotC7xLCO3lWrD0arFws/ruM
         bXq+uQHhFzjU+Xl9XLn3et81zVuUHOrkOGdcCvv9RWaaWlv6Zmne++aZyYXc7r0ps6KX
         xUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7zp5AU7+v+4wQYF7EXic/VeL+BZYCULV2dZfkWHkOtQ=;
        b=PMwpGcj8334J6edRpfYgZpDOtysKOw45TesF/XYqNj7RL2sPaFwx8wFAr5sz+oFYFm
         Z9X6IkGDeRZdN0B4rsTaIC8dKgSfdU9/XGk64BHYoOprkFBrCAyQX1rhWojSkmMJlsqy
         uSna0BmdX+QdapCpp4SbmJc/W7bGUrz6AqXyMgc6Xwr9JsDyibu2jzQQ9fQzLGT50fDT
         Q513ecYm0a8Wuu3ZQcUceJVaSDpprCE2y3xxN3TmxSUZb68hAeJ2KknVXyIonrsUDlsP
         b3Q9C2B5M+ZhVZgOm/lYecuyR2/DH4clWnurZJ3qKL+7GkpCxAqzleZGEaFlKBhazOHM
         +WNA==
X-Gm-Message-State: APjAAAV7RrV9/1holZBA1HcJm2+iTaJ3V0vTnl3gsqyV8Di8GnW6wRTX
        G2SeDbU7gHekQZl8QDd4fhedjAW2V0S0hqsgFvo=
X-Google-Smtp-Source: APXvYqyheuBwq6E51exwPH7vXTifWk+lPJ/5eDtfvNP9thnpVpy+PwoW2ByOJIUEgBRBRUe5K08yfKCNXgvhowhI1Mk=
X-Received: by 2002:a6b:8d43:: with SMTP id p64mr3614752iod.215.1576170844459;
 Thu, 12 Dec 2019 09:14:04 -0800 (PST)
MIME-Version: 1.0
References: <20191212145042.12694-1-labbott@redhat.com>
In-Reply-To: <20191212145042.12694-1-labbott@redhat.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Thu, 12 Dec 2019 18:13:55 +0100
Message-ID: <CAOi1vP9E2yLeFptg7o99usEi=x3kf=NnHYdURXPhX4vTXKCTCQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: Don't reject unknown parameters
To:     Laura Abbott <labbott@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 3:51 PM Laura Abbott <labbott@redhat.com> wrote:
>
> The new mount API currently rejects unknown parameters if the
> filesystem doesn't have doesn't take any arguments. This is
> unfortunately a regression from the old API which silently
> ignores extra arguments. This is easly seen with the squashfs
> conversion (5a2be1288b51 ("vfs: Convert squashfs to use the new
> mount API")) which now fails to mount with extra options. Just
> get rid of the error.
>
> Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock
> creation/configuration context")
> Link: https://lore.kernel.org/lkml/20191130181548.GA28459@gentoo-tp.home/
> Reported-by: Jeremi Piotrowski <jeremi.piotrowski@gmail.com>
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1781863
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  fs/fs_context.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 138b5b4d621d..7ec20b1f8a53 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -160,8 +160,7 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
>                 return 0;
>         }
>
> -       return invalf(fc, "%s: Unknown parameter '%s'",
> -                     fc->fs_type->name, param->key);
> +       return 0;
>  }
>  EXPORT_SYMBOL(vfs_parse_fs_param);

Hi Laura,

I'm pretty sure this is a regression for all other filesystems
that used to check for unknown tokens and return an error from their
->mount/fill_super/etc methods before the conversion.

All filesystems that provide ->parse_param expect that ENOPARAM is
turned into an error with an error message.  I think we are going to
need something a bit more involved in vfs_parse_fs_param(), or just
a dummy ->parse_param for squashfs that would always return 0.

Thanks,

                Ilya
