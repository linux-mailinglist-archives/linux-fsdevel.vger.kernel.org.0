Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F47B4EB1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 16:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfFUOuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 10:50:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbfFUOuy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:50:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E8E6C057F2B;
        Fri, 21 Jun 2019 14:50:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F1B75D9E2;
        Fri, 21 Jun 2019 14:50:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190621132839.6ggsppexqfp5htpw@brauner.io>
References: <20190621132839.6ggsppexqfp5htpw@brauner.io> <20190621094757.zijugn6cfulmchnf@brauner.io> <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk> <155905627927.1662.13276277442207649583.stgit@warthog.procyon.org.uk> <21652.1561122763@warthog.procyon.org.uk> <E76F5188-CED8-4472-9136-BDCDFDAF57F0@brauner.io>
To:     Christian Brauner <christian@brauner.io>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Subject: Re: [PATCH 02/25] vfs: Allow fsinfo() to query what's in an fs_context [ver #13]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27767.1561128650.1@warthog.procyon.org.uk>
Date:   Fri, 21 Jun 2019 15:50:50 +0100
Message-ID: <27768.1561128650@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 21 Jun 2019 14:50:54 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian@brauner.io> wrote:

> > >If you tried to go through /proc/pid/fd with open(O_PATH), I think
> > >you'd get
> > >the symlink, not the target.
> > 
> > Then you should use fdget(), no? :)
> 
> That is unless you want fsinfo() to be useable on any fd and just fds
> that are returned from the new mount-api syscalls. Maybe that wasn't
> clear from my first mail.

fsinfo(), as coded, is usable on any fd, as for fstat(), statx() and
fstatfs().

I have made it such that if you do this on the fd returned by fsopen() or
fspick(), the access is diverted to the filesystem that the fs_context refers
to since querying anon_inodes is of little value.

Now, it could be argued that it should require an AT_xxx flag to cause this
diversion to happen.

> Is the information returned for:
> 
> int fd = fsopen()/fspick();
> fsinfo(fd);
> 
> int ofd = open("/", O_PATH);
> fsinfo(ofd, ...);
> 
> the same if they refer to the same mount or would they differ?

At the moment it differs.  In the former case, there may not even be a
superblock attached to the fd to query, though invariants like filesystem
parameter types and names can be queried.

David
