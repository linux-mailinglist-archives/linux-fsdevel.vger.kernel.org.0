Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0B64175D89
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 15:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgCBOuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 09:50:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30596 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727112AbgCBOuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583160610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rHjGdoM/kz+qPoO2ABvyQ7EE/HX9YQYgQRurjxXqWRI=;
        b=EWN/RYMiQp6lFddu0qr5dLsRVBkcfGZFxhqJVywgv/jlZIk+mN5koN+tvLzWYayVpP3grn
        LWOY/3u6e99WKAZEWMF6vb2jDlojRJDgWf6lsu3+04JkElDn3foi6t9A/B5DGO3aECfe5o
        +zR7VF47XHO0Q6XwkhHDHOQUsVAYRs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-BIe46xGPNi2Gkh1qTttGxQ-1; Mon, 02 Mar 2020 09:50:09 -0500
X-MC-Unique: BIe46xGPNi2Gkh1qTttGxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50DC41084420;
        Mon,  2 Mar 2020 14:50:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64C677386B;
        Mon,  2 Mar 2020 14:50:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200302143546.srzk3rnh4o6s76a7@wittgenstein>
References: <20200302143546.srzk3rnh4o6s76a7@wittgenstein> <20200302115239.pcxvej3szmricxzu@wittgenstein> <96563.1582901612@warthog.procyon.org.uk> <20200228152427.rv3crd7akwdhta2r@wittgenstein> <87h7z7ngd4.fsf@oldenburg2.str.redhat.com> <848282.1583159228@warthog.procyon.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     dhowells@redhat.com, Florian Weimer <fweimer@redhat.com>,
        linux-api@vger.kernel.org, viro@zeniv.linux.org.uk,
        metze@samba.org, torvalds@linux-foundation.org, cyphar@cyphar.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <888182.1583160603.1@warthog.procyon.org.uk>
Date:   Mon, 02 Mar 2020 14:50:03 +0000
Message-ID: <888183.1583160603@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> wrote:

> I think we settled this and can agree on RESOLVE_NO_SYMLINKS being the
> right thing to do, i.e. not resolving symlinks will stay opt-in.
> Or is your worry even with the current semantics of openat2()? I don't
> see the issue since O_NOFOLLOW still works with openat2().

Say, for example, my home dir is on a network volume somewhere and /home has a
symlink pointing to it.  RESOLVE_NO_SYMLINKS cannot be used to access a file
inside my homedir if the pathwalk would go through /home/dhowells - this would
affect fsinfo() - so RESOLVE_NO_SYMLINKS is not a substitute for
AT_SYMLINK_NOFOLLOW (O_NOFOLLOW would not come into it).

David

