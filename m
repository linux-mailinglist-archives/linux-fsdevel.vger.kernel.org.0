Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4347623A765
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 15:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHCNWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 09:22:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58933 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726433AbgHCNWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596460952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mx+XnSqPKa3Akxkos0XzQtZs6KN1ZPJwxB+Tb5prv7Q=;
        b=MZ8L9++CVtJxApSh6g7UjAC3XCJHw0rPcKptRTr12pwNcCbpPvVX+zPc17Ha46Z7xxn3Kx
        twwCigqLrx+dzj9PvE7rLE8a6tjG7YreTGJzSL5LoXEv5XobHLd+r6I2U6btTAatvcy+uA
        maiu0vfp/SnaiQZgA6vZ55SrNNV/QcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-QRmJ_ZPqPwqCQfIhnN5q1w-1; Mon, 03 Aug 2020 09:22:28 -0400
X-MC-Unique: QRmJ_ZPqPwqCQfIhnN5q1w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CA84101C8A0;
        Mon,  3 Aug 2020 13:22:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6788F75559;
        Mon,  3 Aug 2020 13:22:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <159645997768.1779777.8286723139418624756.stgit@warthog.procyon.org.uk>
References: <159645997768.1779777.8286723139418624756.stgit@warthog.procyon.org.uk>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-security-module@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jamorris@linux.microsoft.com>,
        nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io,
        jlayton@redhat.com, kzak@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Mount notifications [ver #2]
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 03 Aug 2020 14:22:22 +0100
Message-ID: <1782773.1596460942@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


David Howells <dhowells@redhat.com> wrote:

>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> SIGNIFICANT CHANGES
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  ver #2:
>=20
>  (*) Make the ID fields in the mount notification 64-bits.  They're left
>      referring to the mount ID here, but switched to the mount unique ID =
in
>      the patch in fsinfo that adds that. [Requested by Mikl=C3=B3s Szered=
i]
>=20
>  (*) Dropped the event counters from the mount notification message.
>      [Requested by Mikl=C3=B3s].
>=20
>      This can easily be added back later as the message length can be
>      increased to show it.
>=20
>  (*) Moved the mount event counters over to the fsinfo patchset.

Also:

 (*) Added limitations on the number of concurrent watches that can be held
     by a user.  [Requested by Linus]

 (*) Removed the unused NOTIFY_MOUNT_IS_RECURSIVE flag.  [Requested by
     Mikl=C3=B3s]

David

