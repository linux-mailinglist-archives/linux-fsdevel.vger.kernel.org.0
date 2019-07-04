Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9798F5FB6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2019 18:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfGDQEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jul 2019 12:04:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58875 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfGDQEv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:04:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4784C058CA8;
        Thu,  4 Jul 2019 16:04:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-9.rdu2.redhat.com [10.10.120.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE1C37D958;
        Thu,  4 Jul 2019 16:04:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190703190846.GA15663@kroah.com>
References: <20190703190846.GA15663@kroah.com> <156173690158.15137.3985163001079120218.stgit@warthog.procyon.org.uk> <156173697086.15137.9549379251509621554.stgit@warthog.procyon.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] Add a general, global device notification watch list [ver #5]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10294.1562256260.1@warthog.procyon.org.uk>
Date:   Thu, 04 Jul 2019 17:04:20 +0100
Message-ID: <10295.1562256260@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 04 Jul 2019 16:04:50 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> Don't we need a manpage and a kselftest for it?

I've got part of a manpage, but it needs more work.

How do you do a kselftest for this when it does nothing unless hardware events
happen?

> > +	u64 id = 0; /* Might want to allow dev# here. */
> 
> I don't understand the comment here, what does "dev#" refer to?

This is really for mount subtree watches, so I'm removing it for now.

The reason it's there is because a mount object may have multiple watches, but
each watch is set on a dentry within that mount, and it doesn't have to be the
same dentry each time.  The queue is shared between all the dentries, and the
ID is used (a) to label them so that they can be manually removed, (b) to
match them to each dentry when the notification is being propagated rootwards
along the tree and (c) to avoid adding another field to struct dentry.

David
