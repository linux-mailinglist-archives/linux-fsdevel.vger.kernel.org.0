Return-Path: <linux-fsdevel+bounces-6755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C38D581BACA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 16:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6EF01C23194
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 15:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7363E539FD;
	Thu, 21 Dec 2023 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTii675s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA16539E4
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703172625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cZkCmal2eYhdvEB2cLXCA/u0IOjOUAwA1vCuz38GOXU=;
	b=LTii675sJT4kudqws48Hrz8Fx+ZDN+235FUhP7H8FKTaM4k4mQgKwKHYzjN4JT2QCjs+FJ
	qa8JZVVQaNIdvHYW3rfwmbWwzsYqW1NwhZHoujvh2wIixbNLhptPFMglBFrY6EYwrkNXE/
	DlruN2MGEUpmFz4iVDrqvIf6q90jn18=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-qYteG4chOteRcviwmUQYXg-1; Thu,
 21 Dec 2023 10:30:19 -0500
X-MC-Unique: qYteG4chOteRcviwmUQYXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA317380606E;
	Thu, 21 Dec 2023 15:30:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6D5D62166B35;
	Thu, 21 Dec 2023 15:30:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
To: torvalds@linux-foundation.org
cc: dhowells@redhat.com, Markus Suvanto <markus.suvanto@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Wang Lei <wang840925@gmail.com>, Jeff Layton <jlayton@redhat.com>,
    Steve French <smfrench@gmail.com>,
    Jarkko Sakkinen <jarkko@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
    keyrings@vger.kernel.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs, dns: Fix dynamic root interaction with negative DNS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1843327.1703172564.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From: David Howells <dhowells@redhat.com>
Date: Thu, 21 Dec 2023 15:30:14 +0000
Message-ID: <1843374.1703172614@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Hi Linus,

Could you apply this, please?  It's intended to improve the interaction of
arbitrary lookups in the AFS dynamic root that hit DNS lookup failures[1]
where kafs behaves differently from openafs and causes some applications t=
o
fail that aren't expecting that.  Further, negative DNS results aren't
getting removed and are causing failures to persist.

 (1) Always delete unused (particularly negative) dentries as soon as
     possible so that they don't prevent future lookups from retrying.

 (2) Fix the handling of new-style negative DNS lookups in ->lookup() to
     make them return ENOENT so that userspace doesn't get confused when
     stat succeeds but the following open on the looked up file then fails=
.

 (3) Fix key handling so that DNS lookup results are reclaimed almost as
     soon as they expire rather than sitting round either forever or for a=
n
     additional 5 mins beyond a set expiry time returning EKEYEXPIRED.
     They persist for 1s as /bin/ls will do a second stat call if the firs=
t
     fails.

Reviewed-by: Jeffrey Altman <jaltman@auristor.com>

Thanks,
David

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216637 [1]
Link: https://lore.kernel.org/r/20231211163412.2766147-1-dhowells@redhat.c=
om/ # v1
Link: https://lore.kernel.org/r/20231211213233.2793525-1-dhowells@redhat.c=
om/ # v2
Link: https://lore.kernel.org/r/20231212144611.3100234-1-dhowells@redhat.c=
om/ # v3
Link: https://lore.kernel.org/r/20231221134558.1659214-1-dhowells@redhat.c=
om/ # v4
---
The following changes since commit ceb6a6f023fd3e8b07761ed900352ef574010bc=
b:

  Linux 6.7-rc6 (2023-12-17 15:19:28 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-fixes-20231221

for you to fetch changes up to 39299bdd2546688d92ed9db4948f6219ca1b9542:

  keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expi=
ry (2023-12-21 13:47:38 +0000)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
David Howells (3):
      afs: Fix the dynamic root's d_delete to always delete unused dentrie=
s
      afs: Fix dynamic root lookup DNS check
      keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on =
expiry

 fs/afs/dynroot.c           | 31 +++++++++++++++++--------------
 include/linux/key-type.h   |  1 +
 net/dns_resolver/dns_key.c | 10 +++++++++-
 security/keys/gc.c         | 31 +++++++++++++++++++++----------
 security/keys/internal.h   | 11 ++++++++++-
 security/keys/key.c        | 15 +++++----------
 security/keys/proc.c       |  2 +-
 7 files changed, 64 insertions(+), 37 deletions(-)


