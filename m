Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE3F1EA3EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 14:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgFAMbh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 08:31:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55570 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726125AbgFAMbh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591014696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0VOACdA2Kaw77MK1p6SFJPm5uM6Jc6RhnwZNlhKvqlk=;
        b=jOPYIEX05hWV1k3Y9Y7A44tjSxT4KBkIglDgfJN3gN895t4OPCgY49pXIuxIDfKbSwlXbh
        xrzSbsMmKxcNir/QCVFTnSL7n1scD5fPMssZfNyn75WNZac8pr6hHCxVpxfuEqqgfL8Mck
        VkgL5rc9iLMOPSzztbSNJzh8zoLma0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-VxsYkypcM6-zac2MMITW0A-1; Mon, 01 Jun 2020 08:31:32 -0400
X-MC-Unique: VxsYkypcM6-zac2MMITW0A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45F4F107ACF2;
        Mon,  1 Jun 2020 12:31:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DBBF7E7E1;
        Mon,  1 Jun 2020 12:31:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200601092150.3798343-1-chengzhihao1@huawei.com>
References: <20200601092150.3798343-1-chengzhihao1@huawei.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] afs: Fix memory leak in afs_put_sysnames()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1306173.1591014689.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 01 Jun 2020 13:31:29 +0100
Message-ID: <1306174.1591014689@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Zhihao Cheng <chengzhihao1@huawei.com> wrote:

> sysnames should be freed after refcnt being decreased to zero in
> afs_put_sysnames().

Good catch.

> Besides, it would be better set net->sysnames to 'NULL' after net->sysna=
mes
> being released if afs_put_sysnames() aims on an afs_sysnames object.

Why?  We don't normally clear pointers when cleaning up a struct - and of =
the
two places this is relevant, in one we fail to set up a namespace and in t=
he
other we're tearing down a namespace.  In neither case should the pointer =
be
accessed again.

> @@ -894,7 +894,7 @@ static struct dentry *afs_lookup_atsys(struct inode =
*dir, struct dentry *dentry,
>  	 */
>  	ret =3D NULL;
>  out_s:
> -	afs_put_sysnames(subs);
> +	afs_put_sysnames_and_null(net);

This is definitely wrong.  We obtained a ref 23 lines above and dropped th=
e
lock:

	read_lock(&net->sysnames_lock);
	subs =3D net->sysnames;
	refcount_inc(&subs->usage);
	read_unlock(&net->sysnames_lock);

We are dropping *that* ref, not the one in the struct.

Just adding the missing kfree() call into afs_put_sysnames() should suffic=
e,
thanks.

David


