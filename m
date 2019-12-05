Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDF6114646
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 18:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfLERvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 12:51:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39471 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbfLERvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:51:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so4628372wmh.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 09:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oCM4XV1Q03JY+XBq9T6ZfcKWAdi4Qy0y0BTDkhuSdK8=;
        b=rUUZO+tlZzLRden5dfFouYXg0QIWLwv/o1dpU4E0jB2dbxHG5mjyFTXL2bQqj2kFWP
         XJXVjII9dl3AYnHEFsIXWs0vdFia0VA2nUjpXuvtMA3I251xQS1dLJ6GAV49tIiReCgP
         dxgBD6gnC/4CpalBbHQ2l6dpt9UIv6EUbyQsIoxi1+Xvsh+ytXP1a8N7Cxc23wqKv3O+
         +qkNziS4kURfQFcfde43OIjvMkIUdkQLxLhYiRD0qiKg6y5lalJ0cEPGCVWmlLJVlXq6
         mn4xvP3e122eBXBFMSKCmlGLvxArTJoJdRRfj/mzMDwJUkL8k8LWzNcUs2pGG5nE4MVT
         39Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oCM4XV1Q03JY+XBq9T6ZfcKWAdi4Qy0y0BTDkhuSdK8=;
        b=ZTuJWdhFnWcjnD2uygfowApxvroXRhLXh0BMxu9WIJvXhXdXs0RXWSkOifd6LL4Id8
         Ua3+BoF0jqwVfonUOxPJJ8rQtJUql2N3Sze/pZuZgTVuP6gLCC3E4aSTPWDdou+i+yku
         +6/AQnzlsQU8C+1MUfIe0O1nHBmn2hU16nDZeUwidJqOT4eORSg2bZcH9XwKcTMbzxSH
         rnziRqrKLraxI6tD2qGCTAw7L13joskOzh6d8dXW1o9hjuHy/HQokzM4XcLMy9NS++g+
         3iB6rPWgxTzgoZLbsr5FUqI62dgm2QHFTb/oWm7lSqr2ZZ6uzl3JX1Wku5lZBA2EVZ55
         O68w==
X-Gm-Message-State: APjAAAWs75XaMpf1yCAzeB6gOD0zFSsRrHEOYKXGsfzYs+kqYUCZbMIh
        Cb/ot8w93RL8ktwT/TwUeSsMxlc2WsBeereUckvwXA==
X-Google-Smtp-Source: APXvYqzM+6BtOmXiHeieEzyKgkgjghFIiNlwlmqqI+bMdHx555C+saCk7bgi/8U0cUpJ14tc1MoLDJlILEKaQj/N6Ww=
X-Received: by 2002:a1c:5419:: with SMTP id i25mr6584531wmb.150.1575568271878;
 Thu, 05 Dec 2019 09:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20191204234522.42855-1-brendanhiggins@google.com>
In-Reply-To: <20191204234522.42855-1-brendanhiggins@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 5 Dec 2019 09:50:59 -0800
Message-ID: <CABVgOSn7tTYuMZ8ArA3fRWp4aeKAcKJ3qNL+SgtFt5fkBLnc-A@mail.gmail.com>
Subject: Re: [PATCH v1] staging: exfat: fix multiple definition error of `rename_file'
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     valdis.kletnieks@vt.edu, linux-fsdevel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 4, 2019 at 3:46 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> `rename_file' was exported but not properly namespaced causing a
> multiple definition error because `rename_file' is already defined in
> fs/hostfs/hostfs_user.c:
>
> ld: drivers/staging/exfat/exfat_core.o: in function `rename_file':
> drivers/staging/exfat/exfat_core.c:2327: multiple definition of
> `rename_file'; fs/hostfs/hostfs_user.o:fs/hostfs/hostfs_user.c:350:
> first defined here
> make: *** [Makefile:1077: vmlinux] Error 1
>
> This error can be reproduced on ARCH=um by selecting:
>
> CONFIG_EXFAT_FS=y
> CONFIG_HOSTFS=y
>
> Add a namespace prefix exfat_* to fix this error.
>
> Reported-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Tested-by: David Gow <davidgow@google.com>
Reviewed-by: David Gow <davidgow@google.com>

This works for me: I was able to reproduce the compile error without
this patch, and successfully compile a UML kernel and mount an exfat
fs after applying it.

> ---
>  drivers/staging/exfat/exfat.h       | 4 ++--
>  drivers/staging/exfat/exfat_core.c  | 4 ++--
>  drivers/staging/exfat/exfat_super.c | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
> index 2aac1e000977e..51c665a924b76 100644
> --- a/drivers/staging/exfat/exfat.h
> +++ b/drivers/staging/exfat/exfat.h
> @@ -805,8 +805,8 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
>  s32 create_file(struct inode *inode, struct chain_t *p_dir,
>                 struct uni_name_t *p_uniname, u8 mode, struct file_id_t *fid);
>  void remove_file(struct inode *inode, struct chain_t *p_dir, s32 entry);
> -s32 rename_file(struct inode *inode, struct chain_t *p_dir, s32 old_entry,
> -               struct uni_name_t *p_uniname, struct file_id_t *fid);
> +s32 exfat_rename_file(struct inode *inode, struct chain_t *p_dir, s32 old_entry,
> +                     struct uni_name_t *p_uniname, struct file_id_t *fid);
>  s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
>               struct chain_t *p_newdir, struct uni_name_t *p_uniname,
>               struct file_id_t *fid);

It seems a bit ugly to add the exfat_ prefix to just rename_file,
rather than all of the above functions (e.g., create_dir, remove_file,
etc). It doesn't look like any of the others are causing any issues
though (while, for example, there is another remove_file in
drivers/infiniband/hw/qib/qib_fs.c, it's static, so shouldn't be a
problem).


-- David
