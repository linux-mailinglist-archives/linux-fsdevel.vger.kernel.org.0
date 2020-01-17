Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8890F140F1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 17:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgAQQjX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 11:39:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27802 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726631AbgAQQjX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:39:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579279162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5m8tHXb1DlBkr0D20ikl66SMlJetA3DFtBUIb+crum8=;
        b=TU1UVM4zqKNJMzDfhABdD93ZE5hpD9QkA/cfq/PqpP18BFh70KG4TfcxpPAatMx5Fcra0N
        xziazrFu1zuCXzwZNGuPWv31sWq0CzA5c0cE+WCiqyOU0c7tper2icVGF1L0xRm6pGoiX8
        U4wQgOclCtJEXhoqxN86R6i6KTxZi5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-mdVlBjycMx6djPNIoMft3g-1; Fri, 17 Jan 2020 11:39:14 -0500
X-MC-Unique: mdVlBjycMx6djPNIoMft3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84C7B800D41;
        Fri, 17 Jan 2020 16:39:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB6E91001902;
        Fri, 17 Jan 2020 16:39:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200117162201.GA282012@vader>
References: <20200117162201.GA282012@vader> <2397bb4a-2ca2-4b44-8c79-64efba9aa04d@www.fastmail.com> <20200114170250.GA8904@ZenIV.linux.org.uk> <3326.1579019665@warthog.procyon.org.uk> <9351.1579025170@warthog.procyon.org.uk> <359591.1579261375@warthog.procyon.org.uk>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     dhowells@redhat.com, Colin Walters <walters@verbum.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, josef@toxicpanda.com,
        dsterba@suse.com, linux-ext4 <linux-ext4@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Making linkat() able to overwrite the target
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <469670.1579279148.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 17 Jan 2020 16:39:08 +0000
Message-ID: <469671.1579279148@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Omar Sandoval <osandov@osandov.com> wrote:

> Yes I still have those patches lying around and I'd be happy to dust
> them off and resend them.

That would be great if you could.  I could use them here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dfscache-iter

I'm performing invalidation by creating a vfs_tmpfile() and then replacing=
 the
on-disk file whilst letting ops resume on the temporary file.  Replacing t=
he
on-disk file currently, however, involves unlinking the old one before I c=
an
link in a new one - which leaves a window in which nothing is there.  I co=
uld
use one or more side dirs in which to create new files and rename them ove=
r,
but that has potential lock bottleneck issues - and is particularly fun if=
 an
entire volume is invalidated (e.g. AFS vos release).

David

