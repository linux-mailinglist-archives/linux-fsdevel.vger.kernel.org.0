Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4EAA9F9A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 12:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732797AbfIEK0C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 06:26:02 -0400
Received: from outbound4mad.lav.puc.rediris.es ([130.206.19.146]:47950 "EHLO
        mx01.puc.rediris.es" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730864AbfIEK0C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:26:02 -0400
X-Greylist: delayed 654 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Sep 2019 06:25:58 EDT
Received: from mta-out02.sim.rediris.es (mta-out02.sim.rediris.es [130.206.24.44])
        by mx01.puc.rediris.es  with ESMTP id x85ADag1012008-x85ADag3012008
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 5 Sep 2019 12:13:36 +0200
Received: from mta-out02.sim.rediris.es (localhost.localdomain [127.0.0.1])
        by mta-out02.sim.rediris.es (Postfix) with ESMTPS id 655BCC7BE2B;
        Thu,  5 Sep 2019 12:13:30 +0200 (CEST)
Received: from mta-out02.sim.rediris.es (localhost.localdomain [127.0.0.1])
        by mta-out02.sim.rediris.es (Postfix) with ESMTPS id 40229C7BE2C;
        Thu,  5 Sep 2019 12:13:27 +0200 (CEST)
Received: from lt-gp.iram.es (mrt-fw.iram.es [150.214.224.223])
        by mta-out02.sim.rediris.es (Postfix) with ESMTPA id 95D21C7BE2B;
        Thu,  5 Sep 2019 12:13:19 +0200 (CEST)
Date:   Thu, 5 Sep 2019 12:13:15 +0200
From:   Gabriel Paubert <paubert@iram.es>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Aleksa Sarai <asarai@suse.de>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Drysdale <drysdale@google.com>,
        Christian Brauner <christian@brauner.io>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-parisc@vger.kernel.org, linux-api@vger.kernel.org,
        Chanho Min <chanho.min@lge.com>,
        Jeff Layton <jlayton@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-alpha@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH v12 01/12] lib: introduce copy_struct_{to, from}_user
 helpers
Message-ID: <20190905101315.GA25637@lt-gp.iram.es>
References: <20190904201933.10736-1-cyphar@cyphar.com>
 <20190904201933.10736-2-cyphar@cyphar.com>
 <mvma7bj85yo.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvma7bj85yo.fsf@linux-m68k.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-FEAS-CONTENT-MODIFICATION:      
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 11:09:35AM +0200, Andreas Schwab wrote:
> On Sep 05 2019, Aleksa Sarai <cyphar@cyphar.com> wrote:
> 
> > diff --git a/lib/struct_user.c b/lib/struct_user.c
> > new file mode 100644
> > index 000000000000..7301ab1bbe98
> > --- /dev/null
> > +++ b/lib/struct_user.c
> > @@ -0,0 +1,182 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2019 SUSE LLC
> > + * Copyright (C) 2019 Aleksa Sarai <cyphar@cyphar.com>
> > + */
> > +
> > +#include <linux/types.h>
> > +#include <linux/export.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/kernel.h>
> > +#include <linux/string.h>
> > +
> > +#define BUFFER_SIZE 64
> > +
> > +/*
> > + * "memset(p, 0, size)" but for user space buffers. Caller must have already
> > + * checked access_ok(p, size).
> > + */
> > +static int __memzero_user(void __user *p, size_t s)
> > +{
> > +	const char zeros[BUFFER_SIZE] = {};
> 
> Perhaps make that static?

On SMP? It should at least be per cpu, and I'm not even sure
with preemption.

	Gabriel

> 
> Andreas.
> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
