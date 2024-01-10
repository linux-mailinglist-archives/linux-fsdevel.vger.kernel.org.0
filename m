Return-Path: <linux-fsdevel+bounces-7729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353D5829F0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 18:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5777E1C22A9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 17:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DB84CE1A;
	Wed, 10 Jan 2024 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyZJjSUO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79BD4EB4C
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704907420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jocqRgtMadaCQwvnSiqn2EsI9KXVShv2lHTrjFxLh1M=;
	b=EyZJjSUOWPRm3AwfJ6dDuswNHgmw6HTSNnY2No3JkiOTM2FzjjB3O1GI/xVZKhCtV3Gs65
	dBcqoJdxZO2NENtUVf90RO7ylP74vAFrXg7Y/U2IHkUt5nFYmLVe94UWrmT8I6fUb0cpcG
	a+aL/aQKpRX7cLhOIg2MmG9JYjF19lM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-cbBMg0BXOm21eCxa6xC7xg-1; Wed, 10 Jan 2024 12:23:38 -0500
X-MC-Unique: cbBMg0BXOm21eCxa6xC7xg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C547688CC43;
	Wed, 10 Jan 2024 17:23:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 914741C060AF;
	Wed, 10 Jan 2024 17:23:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZZ56MMinZLrmF9Z+@xpf.sh.intel.com>
References: <ZZ56MMinZLrmF9Z+@xpf.sh.intel.com> <ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com> <CAHk-=wgJz36ZE66_8gXjP_TofkkugXBZEpTr_Dtc_JANsH1SEw@mail.gmail.com> <1843374.1703172614@warthog.procyon.org.uk> <20231223172858.GI201037@kernel.org> <2592945.1703376169@warthog.procyon.org.uk> <1694631.1704881668@warthog.procyon.org.uk>
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: dhowells@redhat.com, eadavis@qq.com,
    Linus Torvalds <torvalds@linux-foundation.org>,
    "Simon
 Horman" <horms@kernel.org>,
    Markus Suvanto <markus.suvanto@gmail.com>,
    "Jeffrey E Altman" <jaltman@auristor.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    "Wang Lei" <wang840925@gmail.com>, Jeff Layton <jlayton@redhat.com>,
    Steve French <smfrench@gmail.com>,
    Jarkko Sakkinen <jarkko@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
    keyrings@vger.kernel.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, heng.su@intel.com
Subject: Re: [PATCH] keys, dns: Fix missing size check of V1 server-list header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1784440.1704907412.1@warthog.procyon.org.uk>
Date: Wed, 10 Jan 2024 17:23:32 +0000
Message-ID: <1784441.1704907412@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Meh.  Does the attached fix it for you?

David
---
diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index f18ca02aa95a..c42ddd85ff1f 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -104,7 +104,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 		const struct dns_server_list_v1_header *v1;
 
 		/* It may be a server list. */
-		if (datalen <= sizeof(*v1))
+		if (datalen < sizeof(*v1))
 			return -EINVAL;
 
 		v1 = (const struct dns_server_list_v1_header *)data;


