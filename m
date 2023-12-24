Return-Path: <linux-fsdevel+bounces-6858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA8981D756
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 01:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14571F21B3B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 00:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04837381;
	Sun, 24 Dec 2023 00:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGMishtg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6FE20316
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 00:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703376177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2Rh5CNVsutE5oVr7mjP/qOsDM7D/4ihkvki7rZGwjY=;
	b=WGMishtg4wQPnAedYPiXVRNdOpnX3xfOtDpyS3lD6Ygvk4gn6JbVK7oEzWgYP90TsnlbLF
	0IL/zoS1U7Nd6k6fcNVUg3IbGR4kjSAHnHLdRavtBc/kuEourmIewSCsXdfZoYa4FAx69z
	JdcaBjtT3S1KqErwvsFi/5B4PyJuSrU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-R6RYiUWMPziAVk9Kh69GVQ-1; Sat, 23 Dec 2023 19:02:54 -0500
X-MC-Unique: R6RYiUWMPziAVk9Kh69GVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C5D1803915;
	Sun, 24 Dec 2023 00:02:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E5D7E3C25;
	Sun, 24 Dec 2023 00:02:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wgJz36ZE66_8gXjP_TofkkugXBZEpTr_Dtc_JANsH1SEw@mail.gmail.com>
References: <CAHk-=wgJz36ZE66_8gXjP_TofkkugXBZEpTr_Dtc_JANsH1SEw@mail.gmail.com> <1843374.1703172614@warthog.procyon.org.uk> <20231223172858.GI201037@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
    Edward Adam Davis <eadavis@qq.com>
Cc: dhowells@redhat.com, Simon Horman <horms@kernel.org>,
    Markus Suvanto <markus.suvanto@gmail.com>,
    Jeffrey E Altman <jaltman@auristor.com>,
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
Subject: [PATCH] keys, dns: Fix missing size check of V1 server-list header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2592944.1703376169.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 Dec 2023 00:02:49 +0000
Message-ID: <2592945.1703376169@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Hi Linus, Edward,

Here's Linus's patch dressed up with a commit message.  I would marginally
prefer just to insert the missing size check, but I'm also fine with Linus=
's
approach for now until we have different content types or newer versions.

Note that I'm not sure whether I should require Linus's S-o-b since he mad=
e
modifications or whether I should use a Codeveloped-by line for him.

David
---
From: Edward Adam Davis <eadavis@qq.com>

keys, dns: Fix missing size check of V1 server-list header

The dns_resolver_preparse() function has a check on the size of the payloa=
d
for the basic header of the binary-style payload, but is missing a check
for the size of the V1 server-list payload header after determining that's
what we've been given.

Fix this by getting rid of the the pointer to the basic header and just
assuming that we have a V1 server-list payload and moving the V1 server
list pointer inside the if-statement.  Dealing with other types and
versions can be left for when such have been defined.

This can be tested by doing the following with KASAN enabled:

        echo -n -e '\x0\x0\x1\x2' | keyctl padd dns_resolver foo @p

and produces an oops like the following:

        BUG: KASAN: slab-out-of-bounds in dns_resolver_preparse+0xc9f/0xd6=
0 net/dns_resolver/dns_key.c:127
        Read of size 1 at addr ffff888028894084 by task syz-executor265/50=
69
        ...
        Call Trace:
         <TASK>
         __dump_stack lib/dump_stack.c:88 [inline]
         dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
         print_address_description mm/kasan/report.c:377 [inline]
         print_report+0xc3/0x620 mm/kasan/report.c:488
         kasan_report+0xd9/0x110 mm/kasan/report.c:601
         dns_resolver_preparse+0xc9f/0xd60 net/dns_resolver/dns_key.c:127
         __key_create_or_update+0x453/0xdf0 security/keys/key.c:842
         key_create_or_update+0x42/0x50 security/keys/key.c:1007
         __do_sys_add_key+0x29c/0x450 security/keys/keyctl.c:134
         do_syscall_x64 arch/x86/entry/common.c:52 [inline]
         do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
         entry_SYSCALL_64_after_hwframe+0x62/0x6a

This patch was originally by Edward Adam Davis, but was modified by Linus.

Fixes: b946001d3bb1 ("keys, dns: Allow key types (eg. DNS) to be reclaimed=
 immediately on expiry")
Reported-and-tested-by: syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.=
com
Link: https://lore.kernel.org/r/0000000000009b39bc060c73e209@google.com/
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: David Howells <dhowells@redhat.com>
cc: Edward Adam Davis <eadavis@qq.com>
cc: Simon Horman <horms@kernel.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: Jeffrey E Altman <jaltman@auristor.com>
cc: Wang Lei <wang840925@gmail.com>
cc: Jeff Layton <jlayton@redhat.com>
cc: Steve French <sfrench@us.ibm.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-cifs@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: ceph-devel@vger.kernel.org
cc: keyrings@vger.kernel.org
cc: netdev@vger.kernel.org
---
 net/dns_resolver/dns_key.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index 2a6d363763a2..f18ca02aa95a 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -91,8 +91,6 @@ const struct cred *dns_resolver_cache;
 static int
 dns_resolver_preparse(struct key_preparsed_payload *prep)
 {
-	const struct dns_server_list_v1_header *v1;
-	const struct dns_payload_header *bin;
 	struct user_key_payload *upayload;
 	unsigned long derrno;
 	int ret;
@@ -103,27 +101,28 @@ dns_resolver_preparse(struct key_preparsed_payload *=
prep)
 		return -EINVAL;
 =

 	if (data[0] =3D=3D 0) {
+		const struct dns_server_list_v1_header *v1;
+
 		/* It may be a server list. */
-		if (datalen <=3D sizeof(*bin))
+		if (datalen <=3D sizeof(*v1))
 			return -EINVAL;
 =

-		bin =3D (const struct dns_payload_header *)data;
-		kenter("[%u,%u],%u", bin->content, bin->version, datalen);
-		if (bin->content !=3D DNS_PAYLOAD_IS_SERVER_LIST) {
+		v1 =3D (const struct dns_server_list_v1_header *)data;
+		kenter("[%u,%u],%u", v1->hdr.content, v1->hdr.version, datalen);
+		if (v1->hdr.content !=3D DNS_PAYLOAD_IS_SERVER_LIST) {
 			pr_warn_ratelimited(
 				"dns_resolver: Unsupported content type (%u)\n",
-				bin->content);
+				v1->hdr.content);
 			return -EINVAL;
 		}
 =

-		if (bin->version !=3D 1) {
+		if (v1->hdr.version !=3D 1) {
 			pr_warn_ratelimited(
 				"dns_resolver: Unsupported server list version (%u)\n",
-				bin->version);
+				v1->hdr.version);
 			return -EINVAL;
 		}
 =

-		v1 =3D (const struct dns_server_list_v1_header *)bin;
 		if ((v1->status !=3D DNS_LOOKUP_GOOD &&
 		     v1->status !=3D DNS_LOOKUP_GOOD_WITH_BAD)) {
 			if (prep->expiry =3D=3D TIME64_MAX)


