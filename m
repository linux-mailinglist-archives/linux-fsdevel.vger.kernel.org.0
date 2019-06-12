Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E819342ECA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 20:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfFLShA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 14:37:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfFLShA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:37:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5350E308795D;
        Wed, 12 Jun 2019 18:37:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-109.rdu2.redhat.com [10.10.120.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42FE85F9C3;
        Wed, 12 Jun 2019 18:36:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <0483c310-87c0-17b6-632e-d57b2274a32f@schaufler-ca.com>
References: <0483c310-87c0-17b6-632e-d57b2274a32f@schaufler-ca.com> <9c41cd56-af21-f17d-ab54-66615802f30e@schaufler-ca.com> <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk> <31009.1560262869@warthog.procyon.org.uk> <14576.1560361278@warthog.procyon.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Andy Lutomirski <luto@kernel.org>, viro@zeniv.linux.org.uk,
        linux-usb@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: What do LSMs *actually* need for checks on notifications?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17321.1560364615.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 12 Jun 2019 19:36:55 +0100
Message-ID: <17322.1560364615@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 12 Jun 2019 18:37:00 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> >  (*) Device events (block/usb) don't require any permissions, but currently
> >      only deliver hardware notifications.
> 
> How do you specify what device you want to watch?

It's a general queue.

> Don't you have to access a /dev/something?

Not at the moment.  One problem is that there may not be a /dev/something for
a device (take a bridge for example), and even if it does, the device driver
doesn't necessarily have access to the path.  The messages contain the device
name string as appears in dmesg ("3-7" for a USB device, for example).

I think it would be wise to limit the general queue to hardware events that
either get triggered by someone physically mucking around with the hardware or
device errors, such as bad sectors or links going up and down.

> > You can't find out what watches exist.
> 
> Not even your own?

No.

> > However, it should be noted that (1) is the creds of the buffer owner.
> 
> How are buffers shared? Who besides the buffer creator can use it?

When you open /dev/watch_queue, you get buffers private to that file object; a
second open of the device, even by the same process, will get different
buffers.

The buffers are 'attached' to that file and are accessed by calling mmap() on
the fd; shareability is governed by how shareable the fd and a mapping are
shareable.

> Can you glean information from the watch being deleted?
> I wouldn't think so, and it seems like a one-time event
> from the system, so I don't think an access check would
> be required.

As you say, it's a one-time message per watch.  The object that got deleted
would need to be recreated, rewatched and made available to both parties.

David
