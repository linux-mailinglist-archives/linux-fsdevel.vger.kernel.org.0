Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 993592DB15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 12:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfE2KzQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 06:55:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfE2KzQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 06:55:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92A5430B2443;
        Wed, 29 May 2019 10:55:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B4BC2F2A0;
        Wed, 29 May 2019 10:55:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com>
References: <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk> <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        raven@themaw.net, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13969.1559127310.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 29 May 2019 11:55:10 +0100
Message-ID: <13970.1559127310@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 29 May 2019 10:55:15 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> > +                       /* Global root? */
> > +                       if (mnt != parent) {
> > +                               cursor.dentry = READ_ONCE(mnt->mnt_mountpoint);
> > +                               mnt = parent;
> > +                               cursor.mnt = &mnt->mnt;
> > +                               continue;
> > +                       }
> > +                       break;
> 
> (nit: this would look clearer if you inverted the condition and wrote
> it as "if (mnt == parent) break;", then you also wouldn't need that
> "continue" or the braces)

It does look better with the logic inverted, but you *do* still need the
continue.  After the if-statement, there is:

	cursor.dentry = cursor.dentry->d_parent;

which we need to skip.  It might make sense to move that into an
else-statement from an aesthetic point of view.

David
