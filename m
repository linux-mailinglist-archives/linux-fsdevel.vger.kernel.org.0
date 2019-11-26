Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D859B109C99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 11:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfKZKxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 05:53:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38510 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727918AbfKZKxT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:53:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574765598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RnmbUDDUqVr+GtJqX6llAqX+JxCSlgtk8y8KwLMGH8c=;
        b=BmmWdWOppAGWpn7HaXxBwa52Wou0d4zTdWgNhFCXpN65sgbw/PBpJzmd1F/7FZFUBd8sWY
        t/ZWcrcpcvFOOXcLQa4hlqHvSK/S7SBTsQuk1SGE3PWfPrcnn6TeT/bxdGNdFABpOIocVn
        l9NkSX6euFHIPeDo1Vv+tktypZ1hSyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-ialD43iuM-y2-Dbz_gkc_w-1; Tue, 26 Nov 2019 05:53:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 132A0800D41;
        Tue, 26 Nov 2019 10:53:14 +0000 (UTC)
Received: from 10.255.255.10 (unknown [10.40.205.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 92B4E600C6;
        Tue, 26 Nov 2019 10:53:12 +0000 (UTC)
Date:   Tue, 26 Nov 2019 11:53:09 +0100
From:   Karel Zak <kzak@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [MANPAGE] fsopen.2, fsmount.2
Message-ID: <20191126105309.m4k2zpxgxq7tacy2@10.255.255.10>
References: <10805.1570726908@warthog.procyon.org.uk>
MIME-Version: 1.0
In-Reply-To: <10805.1570726908@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ialD43iuM-y2-Dbz_gkc_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 10, 2019 at 06:01:48PM +0100, David Howells wrote:
> .SH EXAMPLES
> To illustrate the process, here's an example whereby this can be used to =
mount
> an ext4 filesystem on /dev/sdb1 onto /mnt.
> .PP
> .in +4n
> .nf
> sfd =3D fsopen("ext4", FSOPEN_CLOEXEC);
> fsconfig(sfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
> fsconfig(sfd, FSCONFIG_SET_STRING, "source", "/dev/sdb1", 0);
> fsconfig(sfd, FSCONFIG_SET_FLAG, "noatime", NULL, 0);
> fsconfig(sfd, FSCONFIG_SET_FLAG, "acl", NULL, 0);
> fsconfig(sfd, FSCONFIG_SET_FLAG, "user_attr", NULL, 0);
> fsconfig(sfd, FSCONFIG_SET_FLAG, "iversion", NULL, 0);
> fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> mfd =3D fsmount(sfd, FSMOUNT_CLOEXEC, MS_RELATIME);
> move_mount(mfd, "", sfd, AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
                      ^^^^^^^^^^^^
 Seems too many arguments (file descriptors), probably should be:

    move_mount(mfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

...
> move_mount(mfd, "", sfd, AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

 Here too.

    Karel

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

