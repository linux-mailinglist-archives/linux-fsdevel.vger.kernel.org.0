Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BF51F8358
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 15:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFMNFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jun 2020 09:05:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60678 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgFMNFD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jun 2020 09:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592053502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Vkn3rEZeq1POego0MCBFrp41m1L5KDYoTSqj0fJLmA=;
        b=gWI7xlbhDlVweI7PNSB7xyzr2CpBMjdUitYumLvlIOoNd5TsjcMJNU9LRPDSpNzQiD8QI+
        WAQkQyHT2ZyGGogZKWL87y5JJC6qPvU7kJmfVq2pRUU5VpUFL3CcrOBEe4dLJiXlIgWBAV
        G6ADfszgCF/QFANnsWXusnpg/5UwhZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-2oUBF2pBMki-cnGHOZyJkg-1; Sat, 13 Jun 2020 09:04:58 -0400
X-MC-Unique: 2oUBF2pBMki-cnGHOZyJkg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70B02107ACCA;
        Sat, 13 Jun 2020 13:04:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75D905D9C5;
        Sat, 13 Jun 2020 13:04:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=whypJLi6T01HOZ5+UPe_rs+hft8wn6iOmQpZgbZzbAumA@mail.gmail.com>
References: <CAHk-=whypJLi6T01HOZ5+UPe_rs+hft8wn6iOmQpZgbZzbAumA@mail.gmail.com> <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Karel Zak <kzak@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] General notification queue and key notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3984624.1592053492.1@warthog.procyon.org.uk>
Date:   Sat, 13 Jun 2020 14:04:52 +0100
Message-ID: <3984625.1592053492@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I'm not even convinced O_NOTIFICATION_PIPE is necessary, but at worst
> it will be a useful marker. I think the only real reason for it was to
> avoid any clashes with splice(), which has more complex use of the
> pipe buffers.

The main reason is to prevent splice because the iov_iter rewind for splice
gets quite tricky if the kernel can randomly insert packets into the pipe
buffer in between what splice is inserting.

> I'm so far just reading this thread and the arguments for users, and I
> haven't yet looked at all the actual details in the pull request - but
> last time I had objections to things it wasn't the code, it was the
> lack of any use.

Would you be willing at this point to consider pulling the mount notifications
and fsinfo() which helps support that?  I could whip up pull reqs for those
two pieces - or do you want to see more concrete patches that use it?

David

