Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 565FF101206
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 04:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfKSDOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 22:14:52 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44003 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfKSDOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 22:14:52 -0500
Received: by mail-yb1-f193.google.com with SMTP id r201so8188506ybc.10;
        Mon, 18 Nov 2019 19:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQHqCNVwbalLp3JAlJVgYKUSDqFESUx7sTL9hUFN0AI=;
        b=U009EfjYcF6r60Y4bSa2bfjs4f/u2b1uQzYUzCvTIUNlRzONu7xw8D08oEJLBetjiD
         dlN2GfUQDvlt0o9PtpCxqFCcYbpYaUcw4P28+um+F+2pUyDXC9kZhRcXtDzHsKtvhDOZ
         6XVF2dTGZ8fpdzwh/rhwaOIvVZCqjxb2uRy7jQokns1dPWDfelIWO6ciRBHBhkq1wxNm
         Em2Isddsiha4YeASDUrJqge8NRwYYre1kZSVx4DcEaPKNSA1VjLGsWah5+NstkPNv/kq
         V1oiyihDs+A2jeqPCcZXm/6BMYTKS7/Ani6neQEXLm2wkG5Ivs4s6nb+jvUnLM3oMUk7
         s7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQHqCNVwbalLp3JAlJVgYKUSDqFESUx7sTL9hUFN0AI=;
        b=bynBiclphZWyxE/LW9yeXlXdv35JpVhfgN4gPv1ioFdIXKlyxfFzdAD5JanKTMvz1R
         fnFp1vIkWCN3HVYAIbinj7UYDqnas4/Fwv+U+JAnkCs58KJtd6CbNEYBPc2wcAWM5jGU
         uPufyzU5hKDjVMiz/hu1p3rQYKPDxSudd8lRnVqF0u1GFYPSO0OJrRcvPxWXUBbQLyoA
         +2BxbwL8adECMDbGCXHmAcFHtYI+P97Rf2u8YdBTQIwv/3m7VeiiMmycreqkiT5UPnyI
         a7dtGx7Oh5YzBgNrt8jEvVQMDLaE62baf+2eMm17jpG3v4yf80bIyKssCCGcqkkPyjDz
         ZXWA==
X-Gm-Message-State: APjAAAXSx/Wk+nLXItjMUjItFhZNBXchPTrLdk5T9F5LLaBKzcrs8NLw
        O3PzDQMhfI4s9Gzl6f9WaF3T7NE+ouep5V+NfXCWTg==
X-Google-Smtp-Source: APXvYqynsZxQlnPySCXrSJ0aXDxO+pDjCesAPPJAEC4QrHX7JFE2JhARojkWM3g7520ot9SB2Sg+1yiz+tn4EEZ9o3c=
X-Received: by 2002:a25:6649:: with SMTP id z9mr24259666ybm.132.1574133291117;
 Mon, 18 Nov 2019 19:14:51 -0800 (PST)
MIME-Version: 1.0
References: <1574129643-14664-1-git-send-email-jiufei.xue@linux.alibaba.com> <1574129643-14664-2-git-send-email-jiufei.xue@linux.alibaba.com>
In-Reply-To: <1574129643-14664-2-git-send-email-jiufei.xue@linux.alibaba.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Nov 2019 05:14:40 +0200
Message-ID: <CAOQ4uxgZZ=noynAZWmiuJupdqsfPw1AkG3TJc+JBk6fAv7ofOA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfs: add vfs_iocb_iter_[read|write] helper functions
To:     Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 19, 2019 at 4:14 AM Jiufei Xue <jiufei.xue@linux.alibaba.com> wrote:
>
> This isn't cause any behavior changes and will be used by overlay
> async IO implementation.
>
> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
> ---
>  fs/read_write.c    | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h | 16 +++++++++++++++
>  2 files changed, 74 insertions(+)
>
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 5bbf587..3dfbcec 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -984,6 +984,64 @@ ssize_t vfs_iter_write(struct file *file, struct iov_iter *iter, loff_t *ppos,
>  }
>  EXPORT_SYMBOL(vfs_iter_write);
>
> +ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
> +                          struct iov_iter *iter)
> +{
> +       ssize_t ret = 0;
> +       ssize_t tot_len;
> +
> +       if (!file->f_op->read_iter)
> +               return -EINVAL;
> +       if (!(file->f_mode & FMODE_READ))
> +               return -EBADF;
> +       if (!(file->f_mode & FMODE_CAN_READ))
> +               return -EINVAL;
> +
> +       tot_len = iov_iter_count(iter);
> +       if (!tot_len)
> +               return 0;
> +
> +       ret = rw_verify_area(READ, file, &iocb->ki_pos, tot_len);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = call_read_iter(file, iocb, iter);
> +       if (ret >= 0)
> +               fsnotify_access(file);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(vfs_iocb_iter_read);
> +
> +ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
> +                           struct iov_iter *iter)
> +{
> +       ssize_t ret = 0;
> +       ssize_t tot_len;
> +
> +       if (!file->f_op->write_iter)
> +               return -EINVAL;
> +       if (!(file->f_mode & FMODE_WRITE))
> +               return -EBADF;
> +       if (!(file->f_mode & FMODE_CAN_WRITE))
> +               return -EINVAL;
> +
> +       tot_len = iov_iter_count(iter);
> +       if (!tot_len)
> +               return 0;
> +
> +       ret = rw_verify_area(WRITE, file, &iocb->ki_pos, tot_len);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = call_write_iter(file, iocb, iter);
> +       if (ret >= 0)
> +               fsnotify_modify(file);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(vfs_iocb_iter_write);
> +

If it was up to me, I would pass down an optional iocb pointer
to the do_iter_XXX static helpers, instead of duplicating the code.
Others may find your approach cleaner, so let's see what other
people think.

Thanks,
Amir.
