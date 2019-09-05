Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32DC1AADD6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 23:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390677AbfIEVcu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 17:32:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731418AbfIEVct (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:32:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37A8C18C4266;
        Thu,  5 Sep 2019 21:32:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7BBA60BE1;
        Thu,  5 Sep 2019 21:32:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com>
References: <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com> <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk> <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com> <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com> <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Ray Strode <rstrode@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Ray, Debarshi" <debarshi.ray@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>
Subject: Re: Why add the general notification queue and its sources
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5395.1567719164.1@warthog.procyon.org.uk>
Date:   Thu, 05 Sep 2019 22:32:44 +0100
Message-ID: <5396.1567719164@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Thu, 05 Sep 2019 21:32:49 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Also, what is the security model here? Open a special character
> device, and you get access to random notifications from random
> sources?
>
> That makes no sense. Do they have the same security permissions?

Sigh.  It doesn't work like that.  I tried to describe this in the manpages I
referred to in the cover note.  Obviously I didn't do a good enough job.  Let
me try and explain the general workings and the security model here.

 (1) /dev/watch_queue just implements locked-in-memory buffers.  It gets you
     no events by simply opening it.

     Each time you open it you get your own private buffer.  Buffers are not
     shares.  Creation of buffers is limited by ENFILE, EMFILE and
     RLIMIT_MEMLOCK.

 (2) A buffer is implemented as a pollable ring buffer, with the head pointer
     belonging to the kernel and the tail pointer belonging to userspace.
     Userspace mmaps the buffer.

     The kernel *only ever* reads the head and tail pointer from a buffer; it
     never reads anything else.

     When it wants to post a message to a buffer, the kernel reads the
     pointers and then does one of three things:

	(a) If the pointers were incoherent it drops the message.

	(b) If the buffer was full the kernel writes a flag to indicate this
	    and drops the message.

	(c) Otherwise, the kernel writes a message and maybe padding at the
     	    place(s) it expects and writes the head pointer.  If userspace was
     	    busy trashing the place, that should not cause a problem for the
     	    kernel.

     The buffer pointers are expected to run to the end and wrap naturally;
     they're only masked off at the point of actually accessing the buffer.

 (3) You connect event sources to your buffer, e.g.:

	fd = open("/dev/watch_queue", ...);
	keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fd, ...);

     or:

	watch_mount(AT_FDCWD, "/net", 0, fd, ...);

     Security is checked at the point of connection to make sure you have
     permission to access that source.  You have to have View permission on a
     key/keyring for key events, for example, and you have to have execute
     permission on a directory for mount events.

     The LSM gets a look-in too: Smack checks you have read permission on a
     key for example.

 (4) You can connect multiple sources of different types to your buffer and a
     source can be connected to multiple buffers at a time.

 (5) Security is checked when an event is delivered to make sure the triggerer
     of the event has permission to give you that event.  Smack requires that
     the triggerer has write permission on the opener of the buffer for
     example.

 (6) poll() signals POLLIN|POLLRDNORM if there is stuff in the buffer and
     POLLERR if the pointers are incoherent.

David
