Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D461F4688
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 20:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbgFISpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 14:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgFISpX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:45:23 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD89C05BD1E;
        Tue,  9 Jun 2020 11:45:22 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h188so13111684lfd.7;
        Tue, 09 Jun 2020 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i3slKnz68qRTQYqlqu1994FSzIGGWBTVPZGv8yJs3pw=;
        b=ML6YQ4jJb/QFpD8tlkzOor4THQ5URMHQc6txTTzmLBappVOFu3Fa+OdWQIb/8j24Rk
         dI13GLibsKN+E0P0rVKG37ENqC7EFwukfVYOAkYobmZtX5BvEUvtigeaVCvGPWTPbylf
         pmppShPfaWtATx966MBrtIwEvz31pPz1XcqRVmQ0QUhpu+o0ihS3hasQHBlh+uK/dAa9
         8EQ7ofGTbOt4AsKvqPnTfRo/5Pu5c+3E81abKRJUYIUV3zdy1E5v7WJMU4P1UUwFxpIW
         YbJcBB+Gr11tkLp9eBIlJU0C/q3SObxrTJHxh+hKT5zwa/svQNplBwfQSsAAewTxgWIZ
         Ktvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i3slKnz68qRTQYqlqu1994FSzIGGWBTVPZGv8yJs3pw=;
        b=GYBQW5Sk1kGeIrIT/rbX1JtuTvDpHDas9qjhPxPO/B55QNBQ87t/EUM1mBCq1MHKP1
         mlM9yU3kgGEs9CMxjnPDcITmapVQAsXj0UquLsSL9e0O2dgyXF/qZumX0xM6/GzICjiJ
         0RQ1NkVAASw2JKA3wtY1ob4+iPr2FovPybHtOfC3893i+6+rokOtxl3MuqZLjRo56/n2
         IrA47jpvHRt5u/HJlBSxpqfSgsb/3U5WKY5H7rfSLnPbQAPPJ1InTMooE3Y2uuCCBdVk
         8KzFfvBiFtq3MVv89OHor3q0R/C4V6uE36WRZrsBB0434NXdCPClyPFeZc8cCroBPV3y
         Fizg==
X-Gm-Message-State: AOAM530s2ee1eQ3jcvOGH9w8PynctwKv2XSrOx+dkYoA6vk2HWVFGHrE
        oALI725PW67YnL8bMDUARXA=
X-Google-Smtp-Source: ABdhPJxwxkFABLiTt2KrTIcLwoOaAGbHv5L38QkoF51ACI0G15m/iNvaVa1oDM+8DJv+0XS/jcaWoQ==
X-Received: by 2002:a19:6c4:: with SMTP id 187mr16117916lfg.1.1591728320923;
        Tue, 09 Jun 2020 11:45:20 -0700 (PDT)
Received: from grain.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id x23sm5189028lfe.32.2020.06.09.11.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 11:45:18 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 10BCB1A1EC1; Tue,  9 Jun 2020 21:45:17 +0300 (MSK)
Date:   Tue, 9 Jun 2020 21:45:17 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Message-ID: <20200609184517.GL134822@grain>
References: <20200603162328.854164-1-areber@redhat.com>
 <20200603162328.854164-2-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603162328.854164-2-areber@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 03, 2020 at 06:23:26PM +0200, Adrian Reber wrote:
> This patch introduces CAP_CHECKPOINT_RESTORE, a new capability facilitating
> checkpoint/restore for non-root users.
> 
> Over the last years, The CRIU (Checkpoint/Restore In Userspace) team has been
> asked numerous times if it is possible to checkpoint/restore a process as
> non-root. The answer usually was: 'almost'.
> 
> The main blocker to restore a process as non-root was to control the PID of the
> restored process. This feature available via the clone3 system call, or via
> /proc/sys/kernel/ns_last_pid is unfortunately guarded by CAP_SYS_ADMIN.
...
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index d86c0afc8a85..ce02f3a4b2d7 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2189,16 +2189,16 @@ struct map_files_info {
>  };
>  
>  /*
> - * Only allow CAP_SYS_ADMIN to follow the links, due to concerns about how the
> - * symlinks may be used to bypass permissions on ancestor directories in the
> - * path to the file in question.
> + * Only allow CAP_SYS_ADMIN and CAP_CHECKPOINT_RESTORE to follow the links, due
> + * to concerns about how the symlinks may be used to bypass permissions on
> + * ancestor directories in the path to the file in question.
>   */
>  static const char *
>  proc_map_files_get_link(struct dentry *dentry,
>  			struct inode *inode,
>  		        struct delayed_call *done)
>  {
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!(capable(CAP_SYS_ADMIN) || capable(CAP_CHECKPOINT_RESTORE)))
>  		return ERR_PTR(-EPERM);

First of all -- sorry for late reply. You know, looking into this code more
I think this CAP_SYS_ADMIN is simply wrong: for example I can't even fetch
links for /proc/self/map_files. Still /proc/$pid/maps (which as well points
to the files opened) test for ptrace-read permission. I think we need
ptrace-may-attach test here instead of these capabilities (if I can attach
to a process I can read any data needed, including the content of the
mapped files, if only I'm not missing something obvious).
