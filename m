Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B483D19E1AF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Apr 2020 01:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgDCX71 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 19:59:27 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39674 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgDCX70 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 19:59:26 -0400
Received: by mail-pj1-f65.google.com with SMTP id z3so3740037pjr.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2020 16:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YCa/Qs0yPmh3XTwnN4PsbMB277OSr9D+GN0maXxjMHA=;
        b=Bbhh3fmXAiGdRNFedcwh3XwyQ26GhP6Z9oRxi/DD0ElrQbHJt8FP23Due9BPsALnlu
         cdsBGZMeu1Kd8/vgELs72HvtyNixfzg4EaDAo5O2ENQpAqF+HriRbxrU9MqmUByE9IP0
         IyiltCvmyvjnf3QdBrKiVqJ2X8ZPSJrLSlitI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YCa/Qs0yPmh3XTwnN4PsbMB277OSr9D+GN0maXxjMHA=;
        b=eSiIKaTR6iceHuEeQ/RPlWkrM+FJ/QAlKcbAT/5k+b8FOw7IbTv3ugj3tkWh28twoi
         cC7jPToQLtkAd74qBwpsfRO8V1b8HeIE+Bg05TUFKGnHa3DVNWa/psx832jlQEVhM37n
         L81B8CsuxR3eFp55dYYXfnzWe/CpEjm3c5OQJ1oHBBLc+WjK87qZgGuepC0zCmdfjyx/
         fnQenPugQbZYQfdCF0flmw4gOcf/6juFrxNxuf6tE4RpygIpX3ERQnrHX6LTyLubSD5f
         bp1zEmZNBEXgwMpCJaOf8hv+6JBtWceX1C0Ggh/wn/M6RK9kGIdg63QHZR3LvaVXK9vO
         dtSg==
X-Gm-Message-State: AGi0PuYy+TyI/l3n3R2XGUJT2CVuoDw69CVGnDNt1j4fUNvlikqtGCKz
        /Y6kgt6ePlA9O5bdKyBmPoVGEA==
X-Google-Smtp-Source: APiQypKaLpvqre5tI8MwDWqt73Tqg7m9h+IsHfp66R3KYbvS+0hTX2lg8k4AHfoG5/7A9eafgxz9Gw==
X-Received: by 2002:a17:90a:21ac:: with SMTP id q41mr12995017pjc.41.1585958365843;
        Fri, 03 Apr 2020 16:59:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m3sm6071311pgt.27.2020.04.03.16.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 16:59:24 -0700 (PDT)
Date:   Fri, 3 Apr 2020 16:59:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v10 7/9] proc: move hidepid values to uapi as they are
 user interface to mount
Message-ID: <202004031658.8D0C048E3@keescook>
References: <20200327172331.418878-1-gladkov.alexey@gmail.com>
 <20200327172331.418878-8-gladkov.alexey@gmail.com>
 <875zehkeob.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zehkeob.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 02, 2020 at 11:58:28AM -0500, Eric W. Biederman wrote:
> 
> I will just say that I do not understand exporting this to the uapi
> headers.  Why do we want to export the enumeration names?
> 
> I understand that the values are uapi.  This looks like it will make it
> difficult to make changes that rename enumeration values to make
> the code more readable.
> 
> Given that this patchset goes immediately to using string enumerated
> values, I also don't understand the point of exporting
> HIDEPID_NOT_PTRACEABLE.  I don't think we need to ever let
> people use the numeric value.
> 
> My sense is that if we are switching to string values we should
> just leave the existing numeric values as backwards compatiblity
> and not do anything to make them easier to use.

Yeah, that's what I had suggested too. Let's not export this to UAPI.

-Kees

> 
> Eric
> 
> 
> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
> 
> > Suggested-by: Alexey Dobriyan <adobriyan@gmail.com>
> > Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
> > Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> > ---
> >  include/linux/proc_fs.h      |  9 +--------
> >  include/uapi/linux/proc_fs.h | 13 +++++++++++++
> >  2 files changed, 14 insertions(+), 8 deletions(-)
> >  create mode 100644 include/uapi/linux/proc_fs.h
> >
> > diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> > index afd38cae2339..d259817ec913 100644
> > --- a/include/linux/proc_fs.h
> > +++ b/include/linux/proc_fs.h
> > @@ -7,6 +7,7 @@
> >  
> >  #include <linux/types.h>
> >  #include <linux/fs.h>
> > +#include <uapi/linux/proc_fs.h>
> >  
> >  struct proc_dir_entry;
> >  struct seq_file;
> > @@ -27,14 +28,6 @@ struct proc_ops {
> >  	unsigned long (*proc_get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
> >  };
> >  
> > -/* definitions for hide_pid field */
> > -enum {
> > -	HIDEPID_OFF	  = 0,
> > -	HIDEPID_NO_ACCESS = 1,
> > -	HIDEPID_INVISIBLE = 2,
> > -	HIDEPID_NOT_PTRACEABLE = 4, /* Limit pids to only ptraceable pids */
> > -};
> > -
> >  /* definitions for proc mount option pidonly */
> >  enum {
> >  	PROC_PIDONLY_OFF = 0,
> > diff --git a/include/uapi/linux/proc_fs.h b/include/uapi/linux/proc_fs.h
> > new file mode 100644
> > index 000000000000..dc6d717aa6ec
> > --- /dev/null
> > +++ b/include/uapi/linux/proc_fs.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef _UAPI_PROC_FS_H
> > +#define _UAPI_PROC_FS_H
> > +
> > +/* definitions for hide_pid field */
> > +enum {
> > +	HIDEPID_OFF            = 0,
> > +	HIDEPID_NO_ACCESS      = 1,
> > +	HIDEPID_INVISIBLE      = 2,
> > +	HIDEPID_NOT_PTRACEABLE = 4,
> > +};
> > +
> > +#endif

-- 
Kees Cook
