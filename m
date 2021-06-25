Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B533B4896
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 20:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFYSCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 14:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFYSCl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 14:02:41 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EE4C061574;
        Fri, 25 Jun 2021 11:00:20 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwq69-00CB0n-0a; Fri, 25 Jun 2021 17:58:37 +0000
Date:   Fri, 25 Jun 2021 17:58:36 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Justin He <Justin.He@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 13/14] d_path: prepend_path() is unlikely to return
 non-zero
Message-ID: <YNYZTIP+anazsz/U@zeniv-ca.linux.org.uk>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-13-viro@zeniv.linux.org.uk>
 <AM6PR08MB43762B63D11A43FE84849748F7069@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR08MB43762B63D11A43FE84849748F7069@AM6PR08MB4376.eurprd08.prod.outlook.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 25, 2021 at 08:00:49AM +0000, Justin He wrote:
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -210,6 +210,7 @@ static int prepend_path(const struct path *path,
>         b = *p;
>         read_seqbegin_or_lock(&rename_lock, &seq);
>         error = __prepend_path(path->dentry, real_mount(path->mnt), root, &b);
> +       printk("prepend=%d",error);
>         if (!(seq & 1))
>                 rcu_read_unlock();
>         if (need_seqretry(&rename_lock, seq)) {
> 
> Then the result seems a little different:
> root@entos-ampere-02:~# dmesg |grep prepend=1 |wc -l
> 7417
> root@entos-ampere-02:~# dmesg |grep prepend=0 |wc -l
> 772
> 
> The kernel is 5.13.0-rc2+ + this series + my '%pD' series
> 
> Any thoughts?

On which loads?  1 here is "mount/dentry pair is in somebody
else's namespace or outside of the subtree we are chrooted
into".  IOW, what's calling d_path() on your setup?
