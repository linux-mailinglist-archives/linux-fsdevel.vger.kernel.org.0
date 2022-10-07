Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BC75F77C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 13:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJGL6S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 7 Oct 2022 07:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJGL6Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 07:58:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8098D0195
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Oct 2022 04:58:12 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-25-ABR5MNZQOUi4UB5yYMDNEA-1; Fri, 07 Oct 2022 12:58:08 +0100
X-MC-Unique: ABR5MNZQOUi4UB5yYMDNEA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 7 Oct
 2022 12:58:06 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Fri, 7 Oct 2022 12:58:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Theodore Ts'o' <tytso@mit.edu>, Kees Cook <keescook@chromium.org>
CC:     Jorge Merlino <jorge.merlino@canonical.com>,
        Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
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
        Andrei Vagin <avagin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "apparmor@lists.ubuntu.com" <apparmor@lists.ubuntu.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] Fix race condition when exec'ing setuid files
Thread-Topic: [PATCH] Fix race condition when exec'ing setuid files
Thread-Index: AQHY2e33//tmcksZekaHt2mlO/Dtmq4C0tkw
Date:   Fri, 7 Oct 2022 11:58:06 +0000
Message-ID: <f01aae2a5936450f889fa5a7d350d363@AcuMS.aculab.com>
References: <202209131456.76A13BC5E4@keescook>
 <202210061301.207A20C8E5@keescook> <Yz+Dln7AAMU+Oj9X@mit.edu>
In-Reply-To: <Yz+Dln7AAMU+Oj9X@mit.edu>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Theodore Ts'o
> Sent: 07 October 2022 02:41
> 
> On Thu, Oct 06, 2022 at 01:20:35PM -0700, Kees Cook wrote:
> >
> > So the question, then, is "why are they trying to exec while actively
> > spawning new threads?" That appears to be the core problem here, and as
> > far as I can tell, the kernel has behaved this way for a very long time.
> > I don't think the kernel should fix this, either, because it leads to a
> > very weird state for userspace, where the thread spawner may suddenly
> > die due to the exec happening in another thread. This really looks like
> > something userspace needs to handle correctly (i.e. don't try to exec
> > while actively spawning threads).
> 
> One of the classic failure modes is when a threaded program calls a
> library, and that library might try to do a fork/exec (or call
> system(3) to run some command.  e.g., such as running "lvm create ..."
> or to spawn some kind of helper daemon.
> 
> There are a number of stack overflow questions about this, and there
> are some solutions to _some_ of the problems, such as using
> pthread_atfork(), and knowing that you are about to call fork/exec,
> and use some out of band mechanism to to make sure no threads get
> spawned until the fork/exec is completed --- but if you don't know
> that a library is going to do a fork/exec, well, life is tough.

Or that a library thread is about to create a new thread.

> One technique even advocated by a stack overflow article is "avoid
> using threads whenver possible".  :-/

Doesn't fork() only create the current thread in the new process?
So by the time exec() runs there is a nice single threaded process
with an fd table that isn't shared.

For helpers there is always (a properly implemented) posix_spawn() :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

