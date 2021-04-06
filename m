Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D2235599D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 18:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244370AbhDFQvU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 12:51:20 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:37474 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbhDFQvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:51:19 -0400
Received: by mail-pg1-f173.google.com with SMTP id k8so10803139pgf.4;
        Tue, 06 Apr 2021 09:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dUOVVdYoSYbWJM3R8BfH3yp511tJPXM9SJGSE2TL6GY=;
        b=XzvTLzBSh6AVFmF1bhUcCakBkjYqyiM5hRmbNdk4aaKMQUrWHtM4iNWpHacQCJ3jut
         nniz2y6tUM3GXo7Qbs/GTppYnltT2AZJz/ZLKKRWGLPLGhRNGiWffXKX0yIWWG622Ak9
         7n5CYuHt1TCDBLXL7TIbyVffkbej+qoDPfGL6cLHOVI2gzcNvz2NMjTUg8etMVtWOWkU
         GKipYQ8nygMkQ62qdAhi/RWoRdXaOY1yjYYZ/9QmAtHNrKZf13ki9oHznkg84thGWA5u
         0njk2u6+kHetQeEP7PnC/3yxVvZuoKzpKib6vHXSoeEw5FZWSEwHhYjcj1HB2l3vSl/G
         L9TA==
X-Gm-Message-State: AOAM533o32v/QbiiS3xuqYLlWGbZG3Z29O9XITGjGHubLRO3i799FWS9
        zea8kKFYzfSC3UrQBCgWE88=
X-Google-Smtp-Source: ABdhPJxJPRbZ8hHR0ZfqHaRIyDYJATSlH01Zbyq90wb+DV+jR9f7adBrfQ3tFv0Oj/c/stWG4JfCFg==
X-Received: by 2002:a63:1303:: with SMTP id i3mr27619155pgl.32.1617727870490;
        Tue, 06 Apr 2021 09:51:10 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p11sm3129812pjo.48.2021.04.06.09.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 09:51:09 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id AB32F40402; Tue,  6 Apr 2021 16:51:08 +0000 (UTC)
Date:   Tue, 6 Apr 2021 16:51:08 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joerg Roedel <jroedel@suse.de>, Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-remoteproc@vger.kernel.org, linux-arch@vger.kernel.org,
        kexec@lists.infradead.org, rcu@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Corey Minyard <minyard@acm.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
Message-ID: <20210406165108.GA4332@42.do-not-panic.com>
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 04:31:58PM +0300, Andy Shevchenko wrote:
> diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
> new file mode 100644
> index 000000000000..41e32483d7a7
> --- /dev/null
> +++ b/include/linux/panic_notifier.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PANIC_NOTIFIERS_H
> +#define _LINUX_PANIC_NOTIFIERS_H
> +
> +#include <linux/notifier.h>
> +#include <linux/types.h>
> +
> +extern struct atomic_notifier_head panic_notifier_list;
> +
> +extern bool crash_kexec_post_notifiers;
> +
> +#endif	/* _LINUX_PANIC_NOTIFIERS_H */

Why is it worth it to add another file just for this? Seems like a very
small file.

  Luis
