Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13425334F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 18:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfFCQam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 12:30:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728228AbfFCQam (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:30:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7579081E05;
        Mon,  3 Jun 2019 16:30:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E09DC5D9C6;
        Mon,  3 Jun 2019 16:30:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <c95dd6cd-5530-6b70-68f6-4038edd72352@schaufler-ca.com>
References: <c95dd6cd-5530-6b70-68f6-4038edd72352@schaufler-ca.com> <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk> <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk> <14347.1559127657@warthog.procyon.org.uk> <312a138c-e5b2-4bfb-b50b-40c82c55773f@schaufler-ca.com> <CAG48ez2KMrTBFzO9p8GvduXruz+FNLPyhc2YivHePsgViEoT1g@mail.gmail.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19413.1559579426.1@warthog.procyon.org.uk>
Date:   Mon, 03 Jun 2019 17:30:26 +0100
Message-ID: <19414.1559579426@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 03 Jun 2019 16:30:41 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> >> should be used. Someone or something caused the event. It can
> >> be important who it was.
> > The kernel's normal security model means that you should be able to
> > e.g. accept FDs that random processes send you and perform
> > read()/write() calls on them without acting as a subject in any
> > security checks; let alone close().
> 
> Passed file descriptors are an anomaly in the security model
> that (in this developer's opinion) should have never been
> included. More than one of the "B" level UNIX systems disabled
> them outright. 

Considering further on this, I think the only way to implement what you're
suggesting is to add a field to struct file to record the last fputter's creds
as the procedure of fputting is offloaded to a workqueue.

Note that's last fputter, not the last closer, as we don't track the number of
open fds linked to a file struct.

In the case of AF_UNIX sockets that contain in-the-process-of-being-passed fds
at the time of closure, this is further complicated by the socket fput being
achieved in the work item - thereby adding layers of indirection.

It might be possible to replace f_cred rather than adding a new field, but
that might get used somewhere after that point.

Note also that fsnotify_close() doesn't appear to use the last fputter's path
since it's not available if called from deferred fput.

David
