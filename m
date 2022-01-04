Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C47D484AA8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 23:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbiADWYw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 17:24:52 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36446 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234157AbiADWYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:24:51 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 204MNJe9016479
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jan 2022 17:23:20 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7EBF315C00E1; Tue,  4 Jan 2022 17:23:19 -0500 (EST)
Date:   Tue, 4 Jan 2022 17:23:19 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Walt Drummond <walt@drummond.us>, aacraid@microsemi.com,
        viro@zeniv.linux.org.uk, anna.schumaker@netapp.com, arnd@arndb.de,
        bsegall@google.com, bp@alien8.de, chuck.lever@oracle.com,
        bristot@redhat.com, dave.hansen@linux.intel.com,
        dwmw2@infradead.org, dietmar.eggemann@arm.com, dinguyen@kernel.org,
        geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        idryomov@gmail.com, mingo@redhat.com, yzaikin@google.com,
        ink@jurassic.park.msu.ru, jejb@linux.ibm.com, jmorris@namei.org,
        bfields@fieldses.org, jlayton@kernel.org, jirislaby@kernel.org,
        john.johansen@canonical.com, juri.lelli@redhat.com,
        keescook@chromium.org, mcgrof@kernel.org,
        martin.petersen@oracle.com, mattst88@gmail.com, mgorman@suse.de,
        oleg@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        rth@twiddle.net, richard@nod.at, serge@hallyn.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        trond.myklebust@hammerspace.com, vincent.guittot@linaro.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] signals: Support more than 64 signals
Message-ID: <YdTI16ZxFFNco7rH@mit.edu>
References: <20220103181956.983342-1-walt@drummond.us>
 <87iluzidod.fsf@email.froward.int.ebiederm.org>
 <YdSzjPbVDVGKT4km@mit.edu>
 <87pmp79mxl.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmp79mxl.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 04:05:26PM -0600, Eric W. Biederman wrote:
> 
> That is all as expected, and does not demonstrate a regression would
> happen if SIGPWR were to treat SIG_DFL as SIG_IGN, as SIGWINCH, SIGCONT,
> SIGCHLD, SIGURG do.  It does show there is the possibility of problems.
> 
> The practical question is does anything send SIGPWR to anything besides
> init, and expect the process to handle SIGPWR or terminate?

So if I *cared* about SIGINFO, what I'd do is ask the systemd
developers and users list if there are any users of the sigpwr.target
feature that they know of.  And I'd also download all of the open
source UPS monitoring applications (and perhaps documentation of
closed-source UPS applications, such as for example APC's program) and
see if any of them are trying to send the SIGPWR signal.

I don't personally think it's worth the effort to do that research,
but maybe other people care enough to do the work.

> > I claim, though, that we could implement VSTATUS without implenting
> > the SIGINFO part of the feature.
> 
> I agree that is the place to start.  And if we aren't going to use
> SIGINFO perhaps we could have an equally good notification method
> if anyone wants one.  Say call an ioctl and get an fd that can
> be read when a VSTATUS request comes in.
> 
> SIGINFO vs SIGCONT vs a fd vs something else is something we can sort
> out when people get interested in modifying userspace.


Once VSTATUS support lands in the kernel, we can wait and see if there
is anyone who shows up wanting the SIGINFO functionality.  Certainly
we have no shortage of userspace notification interfaces in Linux.  :-)

   	   	       		 	      - Ted
