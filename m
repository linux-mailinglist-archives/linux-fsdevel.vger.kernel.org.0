Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B21C175E16
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 16:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCBPXe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 10:23:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46281 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726751AbgCBPXd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583162612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QnN+iIj+lJ/C1dzRk6vOrtrA8A6rdXY2O4R067Olucc=;
        b=AgtOqEswZbCmVUaju5JwkNR1iMGEbYHsLFocFU4QaEdTEckmEPfLcBWoNoPaySJoW53OnI
        5zTuzbcbw+OMDE+bZgT7nd2vGQKXPJ+AOq2accFl8NzyDpdNmgSiCmPz+/SXSEVmmiZtbr
        jjO/8VUFuscnM52lbiXpOoG484yrZVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-HUcrpoOwNeSKqK0Ek5dKSg-1; Mon, 02 Mar 2020 10:23:29 -0500
X-MC-Unique: HUcrpoOwNeSKqK0Ek5dKSg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6464101FC6B;
        Mon,  2 Mar 2020 15:23:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 077B18D553;
        Mon,  2 Mar 2020 15:23:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200302151021.x5mm54jtoukg4tdk@yavin>
References: <20200302151021.x5mm54jtoukg4tdk@yavin> <20200302143546.srzk3rnh4o6s76a7@wittgenstein> <20200302115239.pcxvej3szmricxzu@wittgenstein> <96563.1582901612@warthog.procyon.org.uk> <20200228152427.rv3crd7akwdhta2r@wittgenstein> <87h7z7ngd4.fsf@oldenburg2.str.redhat.com> <848282.1583159228@warthog.procyon.org.uk> <888183.1583160603@warthog.procyon.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     dhowells@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <927227.1583162604.1@warthog.procyon.org.uk>
Date:   Mon, 02 Mar 2020 15:23:24 +0000
Message-ID: <927228.1583162604@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Aleksa Sarai <cyphar@cyphar.com> wrote:

> My counter-argument is that most people actually want
> RESOLVE_NO_SYMLINKS (as evidenced by the countless symlink-related
> security bugs -- many of which used O_NOFOLLOW incorrectly), it just
> wasn't available before Linux 5.6.

I would quibble as to whether they actually want this in all situations.
There are some in which the difference in behaviour will conceivably break
things - though that's more the case for things like stat(), statx(), fsinfo()
and getxattr() where you might want to be able to query a specific symlink
than for openat2() where you almost always want to follow it (save O_PATH |
O_NOFOLLOW).

However, if you're okay with me adding, say, RESOLVE_NO_TERMINAL_SYMLINK and
RESOLVE_NO_TERMINAL_AUTOMOUNT, I can use these flags.

I don't want to have to allow both RESOLVE_* and AT_*.

David

