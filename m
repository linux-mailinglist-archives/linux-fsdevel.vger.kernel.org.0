Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6643F1D002D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 23:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbgELVJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 17:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731156AbgELVJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 17:09:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2563C05BD0A
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 14:09:43 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id a4so6762648pgc.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 14:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4SiIjIE0HqgktULUkxH4huGvPI4IR97vaLn7SaMgRvw=;
        b=kvOR1LBvbXHsTdtL2TP6eGDZfFC1ooMf5iQTDsBYgNoJtSbpgX4ulckTUbNODBqoP7
         riZzlWq93xqkYi3zXErNHAHy+/gZ9NrBfN7Gye2AF282HV8iGeljGnl6WQLR0VRh/DEO
         vErb11z8cHI5SW+sUPYZCGttNjJuR7vSpITj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4SiIjIE0HqgktULUkxH4huGvPI4IR97vaLn7SaMgRvw=;
        b=fZYZkHYAXcoGhg+P2e+1x75HmtyC5jsb3CwsrWEWy7HZiBrskIIMamTHVB/xnzDRSh
         rSIti/x1NIeq4ijW8iORD5ZktQemT1Nz/52Ob7jmH575snb9c+UdiyQX0VrSKv6K5noS
         8bAjTxreM9ZDWuekzqpnVM68+tqTi0728/B2XWgBlNSKi4BGK5tCUaDPAIA6wWXkzJdb
         eokgljF3OEbI091HW7dGrJRS1EXysXE2bGSU6ZIzOKJdXVZj3myYx+seQPXNNSxPjtwJ
         4CQzOZIcZvIQn27H5cUQVmn4gnVxet5O1NPIoCqlj3ATfs3pBIxTWlq5hsvk0o0bZD83
         P4Tg==
X-Gm-Message-State: AOAM531mQC4shwhqKYKFrh9pcL358NSAvZICs1+7icyAk57WsMkvNuAB
        MJHOjyD97Api/rvFzEhc+G31iw==
X-Google-Smtp-Source: ABdhPJxt840LEl+4pcP5gOb8tskJnRcbgXJ1+UHrDACNk2Ju97S34FmnGoVr6OI4La30DBmSgA2nPQ==
X-Received: by 2002:a63:c04a:: with SMTP id z10mr8594229pgi.430.1589317783313;
        Tue, 12 May 2020 14:09:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g17sm2433251pgg.43.2020.05.12.14.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 14:09:42 -0700 (PDT)
Date:   Tue, 12 May 2020 14:09:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] fs: Add a MAY_EXECMOUNT flag to infer the noexec
 mount property
Message-ID: <202005121407.A339D31A@keescook>
References: <20200505153156.925111-1-mic@digikod.net>
 <20200505153156.925111-3-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505153156.925111-3-mic@digikod.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 05:31:52PM +0200, Mickaël Salaün wrote:
> This new MAY_EXECMOUNT flag enables to check if the underlying mount
> point of an inode is marked as executable.  This is useful to implement
> a security policy taking advantage of the noexec mount option.
> 
> This flag is set according to path_noexec(), which checks if a mount
> point is mounted with MNT_NOEXEC or if the underlying superblock is
> SB_I_NOEXEC.
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Reviewed-by: Philippe Trébuchet <philippe.trebuchet@ssi.gouv.fr>
> Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  fs/namei.c         | 2 ++
>  include/linux/fs.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index a320371899cf..33b6d372e74a 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2849,6 +2849,8 @@ static int may_open(const struct path *path, int acc_mode, int flag)
>  		break;
>  	}
>  
> +	/* Pass the mount point executability. */
> +	acc_mode |= path_noexec(path) ? 0 : MAY_EXECMOUNT;
>  	error = inode_permission(inode, MAY_OPEN | acc_mode);
>  	if (error)
>  		return error;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 313c934de9ee..79435fca6c3e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -103,6 +103,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  #define MAY_NOT_BLOCK		0x00000080
>  /* the inode is opened with O_MAYEXEC */
>  #define MAY_OPENEXEC		0x00000100
> +/* the mount point is marked as executable */
> +#define MAY_EXECMOUNT		0x00000200
>  
>  /*
>   * flags in file.f_mode.  Note that FMODE_READ and FMODE_WRITE must correspond

I find this name unintuitive, but I cannot think of anything better,
since I think my problem is that "MAY" doesn't map to the language I
want to use to describe what this flag is indicating.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
