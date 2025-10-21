Return-Path: <linux-fsdevel+bounces-64926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8D0BF6BB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8149D4855D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1102F337B99;
	Tue, 21 Oct 2025 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGck72En"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FF23370EB
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052845; cv=none; b=FrHzmqN7Yf9Kcc3b0NGwLcQPpgqI2FcMYePetI5WzcQD8V98ScLlAX/PS4uYrw9LyS00dLizPjju3rBcB5fEXmEl0XTlTt/se10ZeijhFCR97bmEKGGdTX3Y7ujhkF0SmEVdIOxtUIOI3XEUhHdv5GcEs9NF70OwZJsSVj0P5Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052845; c=relaxed/simple;
	bh=pUM3WkjxlvllZMSA21avgB5tS8ZLspUBiO6Y0NL2uMw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=sqn4B/QRa7yvG6dj0JTAfixTlFyfoMxWZYgCCALEIPfCMKE1R/43SXQwKDGLtQBIpsHB/Pppp85F09f0+YPTT0hn1vaWW6gsYAsOJ+1UW4rOXhrDaWZ/rtncRApOUlYAj/OnNcIiPtAQhXGtq8uYyays4XD24Yk3qKjpzyBiB0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGck72En; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761052842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDMAXz3Joj1Fr7gZbdHzGwjvuqW31ZCsGZDGsi8cR5E=;
	b=XGck72EnRHYCUOqbRWn/kmAjM2fJhYjyXrV5yEgGYMCYinBiIQZxDszu+RXV1snH/n2+3s
	QmJUQAnAESku0u964tJOhFIt+dKmnIz5TScuJUKHYa9gILvbUG4r/oT7dOD49+YxZAHXY0
	GKA0kHeDzFW1H7Q98NEAm8HItkQpNnc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-VgoTW2vuM22D-D82mMOdLA-1; Tue,
 21 Oct 2025 09:20:38 -0400
X-MC-Unique: VgoTW2vuM22D-D82mMOdLA-1
X-Mimecast-MFC-AGG-ID: VgoTW2vuM22D-D82mMOdLA_1761052836
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47727195608A;
	Tue, 21 Oct 2025 13:20:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D872C1956056;
	Tue, 21 Oct 2025 13:20:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20251021-agieren-spruch-65c107748c09@brauner>
References: <20251021-agieren-spruch-65c107748c09@brauner> <20251014133551.82642-1-dhowells@redhat.com> <20251014133551.82642-2-dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <christian@brauner.io>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jeffrey Altman <jaltman@auristor.com>,
    Steve French <sfrench@samba.org>, linux-afs@lists.infradead.org,
    openafs-devel@openafs.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Etienne Champetier <champetier.etienne@gmail.com>,
    Chet Ramey <chet.ramey@case.edu>,
    Cheyenne Wills <cwills@sinenomine.net>,
    Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/2] vfs: Allow filesystems with foreign owner IDs to override UID checks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1523596.1761052821.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Oct 2025 14:20:21 +0100
Message-ID: <1523597.1761052821@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Christian Brauner <brauner@kernel.org> wrote:

> > +	if (unlikely(inode->i_op->have_same_owner)) {
> =

> Same, as above: similar to IOP_FASTPERM this should use a flag to avoid =
pointer derefs.

Can we do these IOP_* flags better?  Surely we can determine at the point =
the
inode has its ->i_op assigned that these things are provided?  This optimi=
ses
the case where they don't exist at the expense of the case where they do (=
we
still have to check the pointer every time).

> > +	if (unlikely(inode->i_op->have_same_owner)) {
> =

> Same, as above: similar to IOP_FASTPERM this should use a flag to avoid =
pointer derefs.
> =

> Really, we should very properly bias this towards the common case where
> the filesystem will not have a custom ownership comparison callback at a=
ll.

Hence the unlikely().

> > +		struct dentry *parent;
> > +		struct inode *dir;
> > +		int ret;
> > +
> > +		if (inode !=3D nd->inode) {
> > +			dir =3D nd->inode;
> > +			ret =3D inode->i_op->have_same_owner(idmap, inode, dir);
> > +		} else if (nd->flags & LOOKUP_RCU) {
> > +			parent =3D READ_ONCE(nd->path.dentry);
> > +			dir =3D READ_ONCE(parent->d_inode);
> > +			if (!dir)
> > +				return -ECHILD;
> > +			ret =3D inode->i_op->have_same_owner(idmap, inode, dir);
> > +		} else {
> > +			parent =3D dget_parent(nd->path.dentry);
> > +			dir =3D parent->d_inode;
> > +			ret =3D inode->i_op->have_same_owner(idmap, inode, dir);
> > +			dput(parent);
> > +		}
> > +		return ret;
> > +	}
> =

> This about as ugly as it can get and costly...

I can break this out into a helper, but it should make no difference to th=
e
actual code generated.

> > +	ret =3D vfs_inode_and_dir_have_same_owner(idmap, inode, nd);
> > +	if (ret <=3D 0)
> > +		return ret;
> =

> Ok, so while that doesn't exactly surface the error it's still weird.
> Please make that consistent. Either have those two new helper functions
> return negative error codes and zero on success or have it be a proper
> boolean instead so there's no possible confusion. This is just begging
> for someone to do if (ret) return ret and bubble up that positive return
> value.

The problem is that you have three available returns: Yes they do, no they
don't and some arbitrary error was encountered.  The first two are not err=
or
cases, and potentially any error you pick to represent, say, "no" could al=
so
be returned by the underlying filesystem.

David


