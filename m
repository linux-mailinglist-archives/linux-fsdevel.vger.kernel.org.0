Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF2334243E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 13:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfFLLnQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 07:43:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbfFLLnQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:43:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C388D7573D;
        Wed, 12 Jun 2019 11:43:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-109.rdu2.redhat.com [10.10.120.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2927614C4;
        Wed, 12 Jun 2019 11:43:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <05ddc1e6-78ba-b60e-73b1-ffe86de2f2f8@tycho.nsa.gov>
References: <05ddc1e6-78ba-b60e-73b1-ffe86de2f2f8@tycho.nsa.gov> <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk> <31009.1560262869@warthog.procyon.org.uk>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@kernel.org>, viro@zeniv.linux.org.uk,
        linux-usb@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: What do LSMs *actually* need for checks on notifications?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25044.1560339786.1@warthog.procyon.org.uk>
Date:   Wed, 12 Jun 2019 12:43:06 +0100
Message-ID: <25045.1560339786@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 12 Jun 2019 11:43:15 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> >   (6) The security attributes of all the objects between the object in (5)
> >       and the object in (4), assuming we work from (5) towards (4) if the
> >       two aren't coincident (WATCH_INFO_RECURSIVE).
> 
> Does this apply to anything other than mount notifications?

Not at the moment.  I'm considering making it such that you can make a watch
on a keyring get automatically propagated to keys that get added to the
keyring (and removed upon unlink) - the idea being that there is no 'single
parent path' concept for a keyring as there is for a directory.

I'm also pondering the idea of making it possible to have superblock watches
automatically propagated to superblocks created by automount points on the
watched superblock.

> And for mount notifications, isn't the notification actually for a change to
> the mount namespace, not a change to any file?

Yes.

> Hence, the real "object" for events that trigger mount notifications is the
> mount namespace, right?

Um... arguably.  Would that mean that that would need a label from somewhere?

> The watched path is just a way of identifying a subtree of the mount
> namespace for notifications - it isn't the real object being watched.

I like that argument.

Thanks,
David
