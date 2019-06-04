Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43D103512E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 22:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfFDUjt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 4 Jun 2019 16:39:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfFDUjt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:39:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 946E83001461;
        Tue,  4 Jun 2019 20:39:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D0C619C69;
        Tue,  4 Jun 2019 20:39:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com>
References: <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com> <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications [ver #2]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1206.1559680778.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 04 Jun 2019 21:39:38 +0100
Message-ID: <1207.1559680778@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 04 Jun 2019 20:39:48 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> wrote:

> > Here's a set of patches to add a general variable-length notification queue
> > concept and to add sources of events for:
> 
> I asked before and didn't see a response, so I'll ask again.  Why are you
> paying any attention at all to the creds that generate an event?

Casey responded to you.  It's one of his requirements.

I'm not sure of the need, and I particularly don't like trying to make
indirect destruction events (mount destruction keyed on fput, for instance)
carry the creds of the triggerer.  Indeed, the trigger can come from all sorts
of places - including af_unix queue destruction, someone poking around in
procfs, a variety of processes fputting simultaneously.  Only one of them can
win, and the LSM needs to handle *all* the possibilities.

However, the LSMs (or at least SELinux) ignore f_cred and use current_cred()
when checking permissions.  See selinux_revalidate_file_permission() for
example - it uses current_cred() not file->f_cred to re-evaluate the perms,
and the fd might be shared between a number of processes with different creds.

> This seems like the wrong approach.  If an LSM wants to prevent covert
> communication from, say, mount actions, then it shouldn't allow the
> watch to be set up in the first place.

Yeah, I can agree to that.  Casey?

David
