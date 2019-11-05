Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE2F2F021F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 17:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390039AbfKEQDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 11:03:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40951 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389990AbfKEQDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572969788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pLj9LlV805f/L7J5FbyPXxXB07oTibsiCCSGb45ogQg=;
        b=DAxnbXOel7GR/PEe2t6Mrv+03Xuzy/G2FGswsUfLa3WuDKMrcLU58JE3w5zv0Q9mvuNpPY
        I1VMJVfrzlKq4LH4UyFmZKsbkrhlnt52r9X2+0oUwwfFrHC4TmVAq484vO9YuFSB3J2CDA
        meGCgBaj17ZWJu0UuOPTyX1me2I6xBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-9SUU8LceOXeOLaVGd4SGTA-1; Tue, 05 Nov 2019 11:03:06 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B43698017DD;
        Tue,  5 Nov 2019 16:03:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 980C81FA;
        Tue,  5 Nov 2019 16:03:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Details on the UAPI of implementing notifications on pipes
MIME-Version: 1.0
Content-ID: <18579.1572969779.1@warthog.procyon.org.uk>
Date:   Tue, 05 Nov 2019 16:02:59 +0000
Message-ID: <18580.1572969779@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 9SUU8LceOXeOLaVGd4SGTA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So to implement notifications on top of pipes, I've hacked it together a bi=
t
in the following ways:

 (1) I'm passing O_TMPFILE to the pipe2() system call to indicate that you
     want a notifications pipe.  This prohibits splice and co. from being
     called on it as I don't want to have to try to fix iov_iter_revert() t=
o
     handle kernel notifications being intermixed with splices.

     The choice of O_TMPFILE was just for convenience, but it needs to be
     something different.  I could, for instance, add a constant,
     O_NOTIFICATION_PIPE with the same *value* as O_TMPFILE.  I don't think
     it's likely that it will make sense to use O_TMPFILE with a pipe, but =
I
     also don't want to eat up another O_* constant just for this.

     Unfortunately, pipe2() doesn't have any other arguments into from whic=
h I
     can steal a bit.

 (2) I've added a pair of ioctls to configure the notifications bits.  They=
're
     ioctls as I just reused the ioctl code from my devmisc driver.  Should=
 I
     use fcntl() instead, such as is done for F_SETPIPE_SZ?

     The ioctls do two things: set the ring size to a number of slots (so
     similarish to F_SETPIPE_SZ) and set filters.

Any thoughts on how better to represent these bits?

Thanks,
David

