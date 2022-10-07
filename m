Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB415F7296
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 03:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiJGBlp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 21:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiJGBlo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 21:41:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F73F2536;
        Thu,  6 Oct 2022 18:41:42 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2971ecnl032685
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Oct 2022 21:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1665106847; bh=qaGXQZPJ+DMM6m33/wU4mECLmQpjFLtDJn6CdcOWtKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KSalaJnH4Pyw9am3lmnE824Wr2kBhNth9uCO4mXO5AzKtequoJLzjonneUAC8ZhxR
         4Hz1eaUw7xthlsGZIvbrKDmeqfMsaZL0mX9jE1bwkYelTLIujVkzCQre3la+eHpRvk
         jehUy8nGH756ojGWF+Lya0ILI+OcQWLFjLYpTrHqGQ5P8VsLDrkkyMAy5y7ZgOktww
         VOQvAZIroJGMqt4qSIuhel3Tn9O/0JEpicFLNkngkAJ7T5kP6qkzL5z4U+3ELVIhC1
         z6ZBz5xcg7Vu7b4LWp9pQf8jyIsi6uPKcXUiiBI32krkxUNWm4c1/xFR2R+71IKcQi
         mHXaABEZ7m0DA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C2CF515C35F2; Thu,  6 Oct 2022 21:40:38 -0400 (EDT)
Date:   Thu, 6 Oct 2022 21:40:38 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jorge Merlino <jorge.merlino@canonical.com>,
        Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Todd Kjos <tkjos@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Prashanth Prahlad <pprahlad@redhat.com>,
        Micah Morton <mortonm@chromium.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Fix race condition when exec'ing setuid files
Message-ID: <Yz+Dln7AAMU+Oj9X@mit.edu>
References: <202209131456.76A13BC5E4@keescook>
 <202210061301.207A20C8E5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210061301.207A20C8E5@keescook>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 06, 2022 at 01:20:35PM -0700, Kees Cook wrote:
> 
> So the question, then, is "why are they trying to exec while actively
> spawning new threads?" That appears to be the core problem here, and as
> far as I can tell, the kernel has behaved this way for a very long time.
> I don't think the kernel should fix this, either, because it leads to a
> very weird state for userspace, where the thread spawner may suddenly
> die due to the exec happening in another thread. This really looks like
> something userspace needs to handle correctly (i.e. don't try to exec
> while actively spawning threads).

One of the classic failure modes is when a threaded program calls a
library, and that library might try to do a fork/exec (or call
system(3) to run some command.  e.g., such as running "lvm create ..."
or to spawn some kind of helper daemon.

There are a number of stack overflow questions about this, and there
are some solutions to _some_ of the problems, such as using
pthread_atfork(), and knowing that you are about to call fork/exec,
and use some out of band mechanism to to make sure no threads get
spawned until the fork/exec is completed --- but if you don't know
that a library is going to do a fork/exec, well, life is tough. 

One technique even advocated by a stack overflow article is "avoid
using threads whenver possible".  :-/

	       	       	  	   - Ted
