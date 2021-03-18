Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F0733FF22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 06:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhCRFzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 01:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhCRFzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:55:25 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DC4C06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Mar 2021 22:55:25 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r17so737014pgi.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Mar 2021 22:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=thuNdy/atXOJvAUmIiVmx8uB0ZvJ8lEzYDmOkR+xX6c=;
        b=MprH25HsBRaGXUd3lCFp5j+Axa+FdUL+lgNyZG0FycK5F1yxkPxN1nQq0/zc6Q0XWy
         7/YTwqm6bZJpwLi2rw76pSmRZojjDYWpLX/7cbSwX7vjvwy29E95ewkiEPBgunT0IJxW
         a3Kw5MJQeWoWflxa489bUZwYAR7aEvsiEaWbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=thuNdy/atXOJvAUmIiVmx8uB0ZvJ8lEzYDmOkR+xX6c=;
        b=MVnFE5rho6AuZr5A3gRF/3/8/z1hdaxLm4+/3GDUmidtvfebSd2g+sq2xWQpCjM4As
         ovqOY1EwIimcpEuDWkfFqbVILkkiTYC8kV9dUftLOdj3LXuxqFJmfsGFW78I5a9dQIWd
         H+tK5Z/PBw6RLghvsenf64Bc1LEZ6FjoELYNIw1cPeu2krmT6UB1P/Oa/LibC+qF1O1F
         XxMrxBhp83txUToT7iawGSmraioPXja9VjMdLD21FdFOYyWhgjjFDDOF1dTkb9ChCNff
         NmMPtcvsGuQf7/kF464Zgk9csi/c8WmFqZKEJDM9ECL2ntqXE2/PaQhmr6RpGC+nUEhv
         Wpkg==
X-Gm-Message-State: AOAM531tTyeAZHjDUCVdKc8I6w1FlgdlCSBA+NxlbQudGXMx4u4dJqqn
        CmGq8gRuPPBVLbNCOK1dc+fEEg==
X-Google-Smtp-Source: ABdhPJzo0CH0324dBXSBMnA6LRAoHtG5Kf0XhoXnPszZLNeJrtGXWDwT27AAVxMw3VT6jqq4EtCtJw==
X-Received: by 2002:aa7:9a89:0:b029:1f6:26b9:bb73 with SMTP id w9-20020aa79a890000b02901f626b9bb73mr2487427pfi.78.1616046924564;
        Wed, 17 Mar 2021 22:55:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s22sm822368pgv.94.2021.03.17.22.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 22:55:23 -0700 (PDT)
Date:   Wed, 17 Mar 2021 22:55:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, surenb@google.com,
        minchan@kernel.org, hridya@google.com, rdunlap@infradead.org,
        christian.koenig@amd.com, willy@infradead.org,
        viro@zeniv.linux.org.uk, kernel-team@android.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>, Helge Deller <deller@gmx.de>,
        James Morris <jamorris@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RESEND PATCH v6 1/2] procfs: Allow reading fdinfo with
 PTRACE_MODE_READ
Message-ID: <202103172255.46B192DA@keescook>
References: <20210308170651.919148-1-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308170651.919148-1-kaleshsingh@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 08, 2021 at 05:06:40PM +0000, Kalesh Singh wrote:
> Android captures per-process system memory state when certain low memory
> events (e.g a foreground app kill) occur, to identify potential memory
> hoggers. In order to measure how much memory a process actually consumes,
> it is necessary to include the DMA buffer sizes for that process in the
> memory accounting. Since the handle to DMA buffers are raw FDs, it is
> important to be able to identify which processes have FD references to
> a DMA buffer.
> 
> Currently, DMA buffer FDs can be accounted using /proc/<pid>/fd/* and
> /proc/<pid>/fdinfo -- both are only readable by the process owner,
> as follows:
>   1. Do a readlink on each FD.
>   2. If the target path begins with "/dmabuf", then the FD is a dmabuf FD.
>   3. stat the file to get the dmabuf inode number.
>   4. Read/ proc/<pid>/fdinfo/<fd>, to get the DMA buffer size.
> 
> Accessing other processes' fdinfo requires root privileges. This limits
> the use of the interface to debugging environments and is not suitable
> for production builds.  Granting root privileges even to a system process
> increases the attack surface and is highly undesirable.
> 
> Since fdinfo doesn't permit reading process memory and manipulating
> process state, allow accessing fdinfo under PTRACE_MODE_READ_FSCRED.
> 
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Who would be best to pick this up? Maybe akpm?

-- 
Kees Cook
