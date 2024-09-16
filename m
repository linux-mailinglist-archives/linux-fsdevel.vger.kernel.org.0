Return-Path: <linux-fsdevel+bounces-29466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0297097A2A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65AE7B2453D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 12:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B713155725;
	Mon, 16 Sep 2024 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7kfhLBd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E95154456
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726491517; cv=none; b=c0NqcuSpDKi3UMnorp9X1OwkJmpySmbBCzUQbXgnSkjfnPz5zZyroe+fwOwzMLsW22Og/zXJMvheE8HpCqgyUfKyyCX3I7d7XTJEMaVCSl47paY5csnBJe1KwSPHipnVr4IO0AdbxX3MCTk81pjer8FNLD9XMY+V7LuO+avMk7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726491517; c=relaxed/simple;
	bh=h3sLzb8LXY+1Ol7dqUDWPx3SM3yVad4ZVFv6RUD6glc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=k6KWtbQ3tfvgk3yPP7Wyw1dqe6zvhhUhfOHZyj+/zYA/U0c8VvAlpZWpJ4Gg2hchgH73g4U37NhvCfskHqXhOvzq+WQzgBjZ0rZgKizqQnrYfvZDnndmNVZVAXF5t26Lr2arp/Htu8vIo3iHdTJLIOC3J/1RmPDX+WWbseeI77s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7kfhLBd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726491515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIBKqR7iqf54nrpAIRkWMa8rG8OEKUO9fqyOJE5H9js=;
	b=A7kfhLBdDj8/t8uihLeo4gIBoCC3xLk2nFV6GJVbI039puDBbJ9uHrD+2xm3oG+rfI4lLr
	QEcR/NHfB0vgxbmsV0RzApEQEKrZnIK6UtIpbd791he/3gOPMvgosOtdPXc1urOOk5sGwK
	66B6uSkCCg15MLAbNGPlkgD4Km1mLLw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-FTLfvMa7NJKenNwExI0-Pw-1; Mon,
 16 Sep 2024 08:58:32 -0400
X-MC-Unique: FTLfvMa7NJKenNwExI0-Pw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC0391954B16;
	Mon, 16 Sep 2024 12:58:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 244A430001A4;
	Mon, 16 Sep 2024 12:58:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjr8fxk20-wx=63mZruW1LTvBvAKya1GQ1EhyzXb-okMA@mail.gmail.com>
References: <CAHk-=wjr8fxk20-wx=63mZruW1LTvBvAKya1GQ1EhyzXb-okMA@mail.gmail.com> <20240913-vfs-netfs-39ef6f974061@brauner>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    Steve French <stfrench@microsoft.com>
Subject: Re: [GIT PULL] vfs netfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1888009.1726491507.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Sep 2024 13:58:27 +0100
Message-ID: <1888010.1726491507@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > ++      netfs_read_subreq_terminated(&rdata->subreq, rdata->result, fa=
lse);
> =

> So here, I have
> =

> ++      netfs_read_subreq_terminated(&rdata->subreq, rdata->result, true=
);
> =

> with the third argument being 'true' instead of 'false' as in yours.
> =

> The reason? That's what commit a68c74865f51 ("cifs: Fix SMB1
> readv/writev callback in the same way as SMB2/3") did when it moved
> the (originally) netfs_subreq_terminated() into the worker, and it
> changed the 'was_async' argument from "false" to a "true".

As part of these changes, the callback to netfslib from the SMB1 transport
variant is now delegated to a separate worker thread by cifs_readv_callbac=
k()
rather than being done in the cifs network processing thread (e.g. as is d=
one
by the SMB2/3 smb2_readv_worker() in smb2pdu.c), so it's better to pass
"false" here.

All that argument does is tell netfslib whether it can do cleanup processi=
ng
and retrying in the calling thread (if "false") or whether it needs to
offload it to another thread (if "true").  I should probably rename the
argument from "was_async" to something more explanatory.

By putting "true" here, it causes the already offloaded processing to furt=
her
offload unnecessarily.  It shouldn't break things though.

> > +       rdata->subreq.transferred +=3D rdata->got_bytes;
> >  -      netfs_read_subreq_terminated(&rdata->subreq, rdata->result, fa=
lse);
> > ++      trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress)=
;
> =

> where did this trace_netfs_sreq() come from?

It got copied across with other lines when sync'ing the code with
smb2_readv_callback() whilst attempting the merge resolution.  It's someth=
ing
that got missed out when porting the changes I'd made to SMB2/3 to SMB1.  =
It
should have been deferred to a follow up patch.

> > --- a/fs/smb/client/smb2pdu.c
> > +++ b/fs/smb/client/smb2pdu.c
> > @@@ -4614,6 -4613,10 +4613,8 @@@ smb2_readv_callback(struct mid_q_entr=
y
> >                               server->credits, server->in_flight,
> >                               0, cifs_trace_rw_credits_read_response_c=
lear);
> >         rdata->credits.value =3D 0;
> > +       rdata->subreq.transferred +=3D rdata->got_bytes;
> >  -      if (rdata->subreq.start + rdata->subreq.transferred >=3D rdata=
->subreq.rreq->i_size)
> >  -              __set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
> > +       trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress)=
;
> =

> And where did this conflict resolution come from? I'm not seeing why
> it removes that NETFS_SREQ_HIT_EOF bit logic..

A fix that went upstream via SteveF's tree rather than Christian's tree ad=
ded
NETFS_SREQ_HIT_EOF separately:

	1da29f2c39b67b846b74205c81bf0ccd96d34727
	netfs, cifs: Fix handling of short DIO read

The code that added to twiddle NETFS_SREQ_HIT_EOF is in the source, just a=
bove
the lines in the hunk above:

	if (rdata->result =3D=3D -ENODATA) {
		__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
		rdata->result =3D 0;
	} else {
		size_t trans =3D rdata->subreq.transferred + rdata->got_bytes;
		if (trans < rdata->subreq.len &&
		    rdata->subreq.start + trans =3D=3D ictx->remote_i_size) {
			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
			rdata->result =3D 0;
		}
	}

The two lines removed in the example resolution are therefore redundant an=
d
should have been removed, but weren't.

David


