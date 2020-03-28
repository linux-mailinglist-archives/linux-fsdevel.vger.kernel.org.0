Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35FF619694F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Mar 2020 21:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgC1UlG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 16:41:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37522 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgC1UlG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 16:41:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id x1so4979401plm.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2020 13:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3af4XQiObUNSlXzIpOluwclJ5Se37O3IqIxw7xF6Wfg=;
        b=IV5SgG1z6PHJS4slCqg3DwNNnmqSzIJL6lLp1fwgyLEJHHaJ6fFezzh2xoXOGxJwLX
         u1uxgsPMEvfXPUcQsdZOXFVXGdVOzEb6PYiQY7d+mwL+SpkgBSbR2QlSCupn/XvORASl
         wudH09K3inIipQyjqcchSB9CuWVOfYplGOnIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3af4XQiObUNSlXzIpOluwclJ5Se37O3IqIxw7xF6Wfg=;
        b=Ysiw9jnLVXDhj9daFGaV3zJzRB9zsaia8WwZP6GPPJK5cvbXXRDovqFXj4WAuBhG0p
         G8rhHSTaG4Cxoue10CCo0hz3Gl4IhwHuKDKzJijVz1FAod1CMPDbdE6PlzQ/cXgxcoTp
         /fufzSWT28SWBrOgWlly6Wy4sb+rn3uLUrU3BkGG2HL5C0x4hLN0j9oigwOF4MGcOmwP
         2FhVPMlDF5GnYVo1riBlkR3IrOJpNQhGUDxagYSQbpSukMAoh8bVTiuhlOHsuHZlGtLZ
         NNhezgf2hTGMGtt7nEIScomNkuH/e0XA26PuLSqiy/oIJvykSzZo9M2Qlvol599+Hkjz
         k7iQ==
X-Gm-Message-State: ANhLgQ22YxyVT2mflD451uVvOWV5zR43R0Is/C5pbBuZYlAWHJ07zPOD
        eEGek9nDPP8iaIdzcHGpEJHtTQ==
X-Google-Smtp-Source: ADFU+vtOdbkebW3RaZlpqXPeyjJPDfKZqqHvYrxqlogFKpu84+eIxERui1kCOdYg26q2QUxE07C9+Q==
X-Received: by 2002:a17:90a:240a:: with SMTP id h10mr6679023pje.123.1585428064347;
        Sat, 28 Mar 2020 13:41:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l190sm6769009pfl.212.2020.03.28.13.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 13:41:03 -0700 (PDT)
Date:   Sat, 28 Mar 2020 13:41:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v10 7/9] proc: move hidepid values to uapi as they are
 user interface to mount
Message-ID: <202003281340.B73225DCC9@keescook>
References: <20200327172331.418878-1-gladkov.alexey@gmail.com>
 <20200327172331.418878-8-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327172331.418878-8-gladkov.alexey@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 27, 2020 at 06:23:29PM +0100, Alexey Gladkov wrote:
> Suggested-by: Alexey Dobriyan <adobriyan@gmail.com>
> Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> ---
>  include/linux/proc_fs.h      |  9 +--------
>  include/uapi/linux/proc_fs.h | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 8 deletions(-)
>  create mode 100644 include/uapi/linux/proc_fs.h
> 
> diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> index afd38cae2339..d259817ec913 100644
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -7,6 +7,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/fs.h>
> +#include <uapi/linux/proc_fs.h>
>  
>  struct proc_dir_entry;
>  struct seq_file;
> @@ -27,14 +28,6 @@ struct proc_ops {
>  	unsigned long (*proc_get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
>  };
>  
> -/* definitions for hide_pid field */
> -enum {
> -	HIDEPID_OFF	  = 0,
> -	HIDEPID_NO_ACCESS = 1,
> -	HIDEPID_INVISIBLE = 2,
> -	HIDEPID_NOT_PTRACEABLE = 4, /* Limit pids to only ptraceable pids */
> -};
> -
>  /* definitions for proc mount option pidonly */
>  enum {
>  	PROC_PIDONLY_OFF = 0,
> diff --git a/include/uapi/linux/proc_fs.h b/include/uapi/linux/proc_fs.h
> new file mode 100644
> index 000000000000..dc6d717aa6ec
> --- /dev/null
> +++ b/include/uapi/linux/proc_fs.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_PROC_FS_H
> +#define _UAPI_PROC_FS_H
> +
> +/* definitions for hide_pid field */
> +enum {
> +	HIDEPID_OFF            = 0,
> +	HIDEPID_NO_ACCESS      = 1,
> +	HIDEPID_INVISIBLE      = 2,
> +	HIDEPID_NOT_PTRACEABLE = 4,
> +};
> +
> +#endif
> -- 
> 2.25.2
> 

Should the numeric values still be UAPI if there is string parsing now?

-- 
Kees Cook
