Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD8B1969A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Mar 2020 22:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgC1Vxx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 17:53:53 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37629 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgC1Vxw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 17:53:52 -0400
Received: by mail-pj1-f67.google.com with SMTP id o12so5488925pjs.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2020 14:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ovk2bmmHiHq0822krEgDFQkSPYt5Bktnb17JLm/lkJA=;
        b=alfNoYU8g+4LyDehhJH9iGwAtea55N/Xy8WHF5I5hMwcVa8EuZTEWAbZ7eeEAtCAjD
         1YoFtSlC3h2vBfbE0MPFBAhCW1HFfaZquUMB005WQh05V1HgCf9MnCioH/P0sUd516+4
         DI0bMW4XCbsmAoMIv05h5N0yfwlGhX5+NtqUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ovk2bmmHiHq0822krEgDFQkSPYt5Bktnb17JLm/lkJA=;
        b=tuqDp150s1ZS8JMFSXgD6+DRWyNqmXWXEd4+ZK52myZZtKB+1DgV/c9GHAxZtUf/rx
         0aoO2rC7RzLj0evyRdQmtYazOIB5uqP307C6SztlNhzSB1ht8C8Y81ftakpGuSoooxb+
         0ZAPqT4UwhEBU/EKa5eGzmnTTiKtE3Sk7411JrXcPMC0uCH6f9HOMcds4p1npXdEnST8
         VLxSsNOfQA8Zc6CeM4iAzGxoxBi30/EGdAxY6OVc6hp9pRdxcndPS/3nRqmMKYlPMxVT
         +yoUv0Mo1omkChv9HZXi+KYM56XKhTyRZLd0oItsNMAt8JTZOzCu18D9RvAHbOOofUfB
         IcYg==
X-Gm-Message-State: ANhLgQ0sq/UwM3FmiXxH2YgjO6nZUot+F/7so16p2c+tZAtrGuoedkp7
        i6xe0jsAMdXJYrH8YTvXMBAlKQ==
X-Google-Smtp-Source: ADFU+vsfxLWSgTsJUgK14r0bXgUXWbEfwzw64SCYCXUXpSNDoac/nQTFCQ7zeikniIjgJ9mfpfaHkA==
X-Received: by 2002:a17:90a:fd90:: with SMTP id cx16mr7121093pjb.41.1585432431548;
        Sat, 28 Mar 2020 14:53:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id hg20sm6550839pjb.3.2020.03.28.14.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 14:53:50 -0700 (PDT)
Date:   Sat, 28 Mar 2020 14:53:49 -0700
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
Message-ID: <202003281453.CED94974@keescook>
References: <20200327172331.418878-1-gladkov.alexey@gmail.com>
 <20200327172331.418878-8-gladkov.alexey@gmail.com>
 <202003281340.B73225DCC9@keescook>
 <20200328212547.xxiqxqhxzwp6w5n5@comp-core-i7-2640m-0182e6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328212547.xxiqxqhxzwp6w5n5@comp-core-i7-2640m-0182e6>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 28, 2020 at 10:25:47PM +0100, Alexey Gladkov wrote:
> On Sat, Mar 28, 2020 at 01:41:02PM -0700, Kees Cook wrote:
>  > diff --git a/include/uapi/linux/proc_fs.h b/include/uapi/linux/proc_fs.h
> > > new file mode 100644
> > > index 000000000000..dc6d717aa6ec
> > > --- /dev/null
> > > +++ b/include/uapi/linux/proc_fs.h
> > > @@ -0,0 +1,13 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > +#ifndef _UAPI_PROC_FS_H
> > > +#define _UAPI_PROC_FS_H
> > > +
> > > +/* definitions for hide_pid field */
> > > +enum {
> > > +	HIDEPID_OFF            = 0,
> > > +	HIDEPID_NO_ACCESS      = 1,
> > > +	HIDEPID_INVISIBLE      = 2,
> > > +	HIDEPID_NOT_PTRACEABLE = 4,
> > > +};
> > > +
> > > +#endif
> > > -- 
> > > 2.25.2
> > > 
> > 
> > Should the numeric values still be UAPI if there is string parsing now?
> 
> I think yes, because these are still valid hidepid= values.

But if we don't expose the values, we can do whatever we like with
future numbers (e.g. the "is this a value or a bit field?" question).

-- 
Kees Cook
