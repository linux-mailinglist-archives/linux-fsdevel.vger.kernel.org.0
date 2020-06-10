Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7A11F52E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 13:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgFJLNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 07:13:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28927 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728298AbgFJLNJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591787588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c1vvhL5/pBKghY8N9JMTo024Z+Z84+uHOU1WR4qioPc=;
        b=WEVh9/YgGk8Xj6vdThGqkAAlZyrjmnwRuG64XtFtBtOLypibKXBZbdpjq0M2rfVUTxMce8
        OcaNAb8nDJJdGszri4zKafyyeoTmY14mBj9BNWM33GH8TShOoSchqSjSl5K9Q7rN0gd1e2
        52emB81iihMQkSl2OQiLlUXhgdErUcU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-cphq5XgkPyqtK4p8qDCL6g-1; Wed, 10 Jun 2020 07:13:04 -0400
X-MC-Unique: cphq5XgkPyqtK4p8qDCL6g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B479318A8234;
        Wed, 10 Jun 2020 11:13:02 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77933600F7;
        Wed, 10 Jun 2020 11:12:59 +0000 (UTC)
Date:   Wed, 10 Jun 2020 13:12:56 +0200
From:   Karel Zak <kzak@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        dray@redhat.com, mszeredi@redhat.com, swhiteho@redhat.com,
        jlayton@redhat.com, raven@themaw.net, andres@anarazel.de,
        christian.brauner@ubuntu.com, jarkko.sakkinen@linux.intel.com,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] General notification queue and key notifications
Message-ID: <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
References: <1503686.1591113304@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503686.1591113304@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


 Hi Linus,

On Tue, Jun 02, 2020 at 04:55:04PM +0100, David Howells wrote:
> Can you pull this, please?  It adds a general notification queue concept

I'm trying to use David's notification stuff in userspace, and I guess
feedback is welcome :-)

The notification stuff looks pretty promising, but I do not understand
why we need to use pipe for this purpose, see typical userspace use-case:

        int pipefd[2], fd;

        if (pipe2(pipefd, O_NOTIFICATION_PIPE) == -1)
                err(EXIT_FAILURE, "pipe2 failed");

        fd = pipefd[0];

All the next operations are done with "fd". It's nowhere used as a
pipe, and nothing uses pipefd[1]. The first impression from this code
is "oh, this is strange; why?".

Is it because we need to create a new file descriptor from nothing?
Why O_NOTIFICATION_PIPE is better than introduce a new syscall
notifyfd()?

(We have signalfd(), no O_SIGNAL_PIPE, etc.) 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

