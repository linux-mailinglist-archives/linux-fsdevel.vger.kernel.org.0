Return-Path: <linux-fsdevel+bounces-37749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD419F6D5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 19:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9B21666D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 18:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056EB1FA829;
	Wed, 18 Dec 2024 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTcRhSCF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA98714B06A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546805; cv=none; b=dth3YmOGR/t1BFRrekcwxoK7cyoKlGDczJketkPSHp6OnkQVySm6zwZrdnei6GiPdHdGpAJoF1n3tFO6AdUnal6+IuJdapeX0fp8Qh+L1yUlhPu9pNfZJnElNPqXOYdIQ/3alAm5kXXbyIvIPiw3CyoMH1QTVnEKGVWC5LT8/Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546805; c=relaxed/simple;
	bh=4axhlgsw6zCh2wGq4xp1/mh0QNjDm8SEQunngoU2AOA=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=QlBzW/jrvzFlOQFSkhWl7KHxkCLp248ECVO9Q7P8zExANqaCD2xdv55bBJP8+tD2ZGTBgytf3spBSk4dyB1H47bkVdJZfMeo1qLfX4taLY743MHOzrUjLGFlShZIo9H/cUnmkeJNvJS6P/ma1XEY73TqFyj7GCN2kuNG3uXjfGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTcRhSCF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734546802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LJ+jelgnVcJwmnyad1G7pB5wcEP8fy6YLfv/Lc3ND6M=;
	b=KTcRhSCFMB90prbfWOFX/2bWjgh56STqB3FHktfKBr0XJi3H6JtqvAArHtbgcrlL3WEuzx
	cQDGWTekdad4n4IuBSRxSYBVXs+Hzk3k/tj3waH6323R+VgminDw+8/cJaSm5II9sEfDzy
	fRM0P6Dwg2Vm7ctfu1kJkZOaKRyBg8s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-nHTjWEXANMaqW9Y4JYK4jQ-1; Wed,
 18 Dec 2024 13:33:19 -0500
X-MC-Unique: nHTjWEXANMaqW9Y4JYK4jQ-1
X-Mimecast-MFC-AGG-ID: nHTjWEXANMaqW9Y4JYK4jQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09C7F1964CDA;
	Wed, 18 Dec 2024 18:33:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C531830044C1;
	Wed, 18 Dec 2024 18:33:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>,
    Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: dhowells@redhat.com, Ilya Dryomov <idryomov@gmail.com>,
    Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
    ceph-devel@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org
Subject: Ceph and Netfslib
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3989571.1734546794.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Dec 2024 18:33:14 +0000
Message-ID: <3989572.1734546794@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Alex, Slava,

I don't know whether you know, but I'm working on netfslib-ising ceph with=
 an
eye to moving all the VFS/VM normal I/O interfaces to netfslib (->read_ite=
r,
->write_iter, ->readahead, ->read_folio, ->page_mkwrite, ->writepages), th=
ough
with wrapping/methods by which each network filesystem can add its own
distinctive flavour.

Also, that would include doing things like content encryption, since that =
is
generally useful in filesystems and I have plans to support it in both AFS=
 and
CIFS as well.

This means that fs/ceph/ will have practically nothing to do with page str=
ucts
or folio structs.  All that will be offloaded to netfslib and netfslib wil=
l
just hand iov_iters to the client filesystems, including ceph.

This will also allow me to massively simplify the networking code in
net/ceph/.  My aim is to replace all the page array, page lists, bio,
etc. data types in libceph with a single type that just conveys an iov_ite=
r
and I have a ceph_databuf type that holds a list of pages in the form of a
bio_vec[] and I can extract an iov_iter from that to pass to the networkin=
g.

Then, for the transmission side, the iov_iter will be passed to the TCP so=
cket
with MSG_SPLICE_PAGES rather than iterating over the data type and passing=
 a
page fragment at a time.  We fixed this up for nfsd and Chuck Lever report=
ed a
improvement in throughput (15% if I remember correctly).

The patches I have so far can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dceph-iter

Note that I have rbd working with the changes I've made to that point.


Anyway, ... I need to pick someone's brain about whether the way per-page
tracking of snapshots within fs/ceph/ can be simplified.

Firstly, note that there may be a bug in ceph writeback cleanup as it stan=
ds.
It calls folio_detach_private() without holding the folio lock (it holds t=
he
writeback lock, but that's not sufficient by MM rules).  This means you ha=
ve a
race between { setting ->private, setting PG_private and inc refcount } on=
 one
hand and { clearing ->private, clearing PG_private and dec refcount } on t=
he
other.

Unfortunately, you cannot just take the page lock from writeback cleanup
without running the risk of deadlocking against ->writepages() wanting to =
take
PG_lock and then PG_writeback.  And you cannot drop PG_writeback first as =
the
moment you do that, the page can be deallocated.


Secondly, there's a counter, ci->i_wrbuffer_ref, that might actually be
redundant if we do it right as I_PINNING_NETFS_WB offers an alternative wa=
y we
might do things.  If we set this bit, ->write_inode() will be called with
wbc->unpinned_netfs_wb set when all currently dirty pages have been cleane=
d up
(see netfs_unpin_writeback()).  netfslib currently uses this to pin the
fscache objects but it could perhaps also be used to pin the writeback cap=
 for
ceph.


Thirdly, I was under the impression that, for any given page/folio, only t=
he
head snapshot could be altered - and that any older snapshot must be flush=
ed
before we could allow that.


Fourthly, the ceph_snap_context struct holds a list of snaps.  Does it rea=
lly
need to, or is just the most recent snap for which the folio holds changes
sufficient?

Thanks,
David


