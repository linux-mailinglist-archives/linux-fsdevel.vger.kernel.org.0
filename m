Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43EB213929
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 13:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgGCLLl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 07:11:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26606 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726244AbgGCLLg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593774694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F+dxHnBK5IM12q+1kQeLc827ddCTp+YxC832WaCEufM=;
        b=ZFa2cglbQ0bgIqVycVhIBx/7GuO7L36Ds20WA93F1ND5ViLFcXHzAYIRmYOdkC3eOX/pJ1
        vgcKebS7HgnAgVFW68/NCZ6Uf4ymtVhqB1vpBkW9iodV6WlC90TLAjGkOEJR8JbjpNYadv
        onCNhwNIyZbYwSjqMO8cL8MltKGvtCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-GYAT4KpKM3-Nol6cdZloKQ-1; Fri, 03 Jul 2020 07:11:30 -0400
X-MC-Unique: GYAT4KpKM3-Nol6cdZloKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EB76804003;
        Fri,  3 Jul 2020 11:11:26 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-113-12.ams2.redhat.com [10.36.113.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4B7419D7B;
        Fri,  3 Jul 2020 11:11:15 +0000 (UTC)
Date:   Fri, 3 Jul 2020 13:11:13 +0200
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Message-ID: <20200703111113.GB243637@dcbz.redhat.com>
References: <20200701064906.323185-1-areber@redhat.com>
 <20200701064906.323185-2-areber@redhat.com>
 <20200701082708.pgfskg7hrsnfi36k@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701082708.pgfskg7hrsnfi36k@wittgenstein>
X-Operating-System: Linux (5.6.19-300.fc32.x86_64)
X-Load-Average: 1.83 1.37 1.14
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
X-Url:  <http://lisas.de/~adrian/>
Organization: Red Hat
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 01, 2020 at 10:27:08AM +0200, Christian Brauner wrote:
> On Wed, Jul 01, 2020 at 08:49:04AM +0200, Adrian Reber wrote:
> > This patch introduces CAP_CHECKPOINT_RESTORE, a new capability facilitating
> > checkpoint/restore for non-root users.
> > 
> > Over the last years, The CRIU (Checkpoint/Restore In Userspace) team has been
> > asked numerous times if it is possible to checkpoint/restore a process as
> > non-root. The answer usually was: 'almost'.
> > 
> > The main blocker to restore a process as non-root was to control the PID of the
> > restored process. This feature available via the clone3 system call, or via
> > /proc/sys/kernel/ns_last_pid is unfortunately guarded by CAP_SYS_ADMIN.
> > 
> > In the past two years, requests for non-root checkpoint/restore have increased
> > due to the following use cases:
> > * Checkpoint/Restore in an HPC environment in combination with a resource
> >   manager distributing jobs where users are always running as non-root.
> >   There is a desire to provide a way to checkpoint and restore long running
> >   jobs.
> > * Container migration as non-root
> > * We have been in contact with JVM developers who are integrating
> >   CRIU into a Java VM to decrease the startup time. These checkpoint/restore
> >   applications are not meant to be running with CAP_SYS_ADMIN.
> > 
> > We have seen the following workarounds:
> > * Use a setuid wrapper around CRIU:
> >   See https://github.com/FredHutch/slurm-examples/blob/master/checkpointer/lib/checkpointer/checkpointer-suid.c
> > * Use a setuid helper that writes to ns_last_pid.
> >   Unfortunately, this helper delegation technique is impossible to use with
> >   clone3, and is thus prone to races.
> >   See https://github.com/twosigma/set_ns_last_pid
> > * Cycle through PIDs with fork() until the desired PID is reached:
> >   This has been demonstrated to work with cycling rates of 100,000 PIDs/s
> >   See https://github.com/twosigma/set_ns_last_pid
> > * Patch out the CAP_SYS_ADMIN check from the kernel
> > * Run the desired application in a new user and PID namespace to provide
> >   a local CAP_SYS_ADMIN for controlling PIDs. This technique has limited use in
> >   typical container environments (e.g., Kubernetes) as /proc is
> >   typically protected with read-only layers (e.g., /proc/sys) for hardening
> >   purposes. Read-only layers prevent additional /proc mounts (due to proc's
> >   SB_I_USERNS_VISIBLE property), making the use of new PID namespaces limited as
> >   certain applications need access to /proc matching their PID namespace.
> > 
> > The introduced capability allows to:
> > * Control PIDs when the current user is CAP_CHECKPOINT_RESTORE capable
> >   for the corresponding PID namespace via ns_last_pid/clone3.
> > * Open files in /proc/pid/map_files when the current user is
> >   CAP_CHECKPOINT_RESTORE capable in the root namespace, useful for recovering
> >   files that are unreachable via the file system such as deleted files, or memfd
> >   files.
> > 
> > See corresponding selftest for an example with clone3().
> > 
> > Signed-off-by: Adrian Reber <areber@redhat.com>
> > Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
> > ---
> 
> I think that now looks reasonable. A few comments.
> 
> Before we proceed, please split the addition of
> checkpoint_restore_ns_capable() out into a separate patch.
> In fact, I think the cleanest way of doing this would be:
> - 0/n capability: add CAP_CHECKPOINT_RESTORE
> - 1/n pid: use checkpoint_restore_ns_capable() for set_tid
> - 2/n pid_namespace: use checkpoint_restore_ns_capable() for ns_last_pid
> - 3/n: proc: require checkpoint_restore_ns_capable() in init userns for map_files
> 
> (commit subjects up to you of course) and a nice commit message for each
> time we relax a permissions on something so we have a clear separate
> track record for each change in case we need to revert something. Then
> the rest of the patches in this series. Testing patches probably last.

Yes, makes sense. I was thinking about this already, but I was not sure
if it I should do it or not. But I had the same idea already.

		Adrian

