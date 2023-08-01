Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D6276BE53
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 22:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjHAUN2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 16:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHAUN1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:13:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52B62683
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 13:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690920765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eS079lTc6uMyHb9fOEpx+7PdtvoQL179wIlpAdqGQ6s=;
        b=WQC6VgDYWXFipl5Wmqu7Op54MdhqGOi7sA/EPFPRZ9ZT6IE6gGbHVb9KPMHqfE00Azlb+B
        OKTqnQGwKewR1InJfKHlcuFKGUiqRWJWxtZGbIwLJMvbyzHdOGLMozZghg8zLMLFAXtGnO
        PvdI3vo5hVTELp2HYcUSeaaA4DSw0qo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-loSXWq-lM_edaYjHQd4WLw-1; Tue, 01 Aug 2023 16:12:32 -0400
X-MC-Unique: loSXWq-lM_edaYjHQd4WLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 721B28C46F9;
        Tue,  1 Aug 2023 20:11:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CC00112132D;
        Tue,  1 Aug 2023 20:11:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <64c93109c084e_1c5e3529452@willemb.c.googlers.com.notmuch>
References: <64c93109c084e_1c5e3529452@willemb.c.googlers.com.notmuch> <1420063.1690904933@warthog.procyon.org.uk>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] udp: Fix __ip_append_data()'s handling of MSG_SPLICE_PAGES
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1501752.1690920713.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 01 Aug 2023 21:11:53 +0100
Message-ID: <1501753.1690920713@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> __ip6_append_data probably needs the same.

Now that's interesting.  __ip6_append_data() has a check for this and retu=
rns
-EINVAL in this case:

		copy =3D datalen - transhdrlen - fraggap - pagedlen;
		if (copy < 0) {
			err =3D -EINVAL;
			goto error;
		}

but should I bypass that check for MSG_SPLICE_PAGES?  It hits the check wh=
en
it should be able to get past it.  The code seems to go back to prehistori=
c
times, so I'm not sure why it's there.

For an 8192 MTU, the breaking point is at a send of 8137 bytes.  The attac=
hed
test program iterates through different send sizes until it hits the point=
.

David
---
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <fcntl.h>
#include <netinet/ip6.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/mman.h>
#include <sys/uio.h>

#define OSERROR(R, S) do { if ((long)(R) =3D=3D -1L) { perror((S)); exit(1=
); } } while(0)

int main()
{
	struct sockaddr_storage ss;
	struct sockaddr_in6 sin6;
	void *buffer;
	unsigned int tmp;
	int pfd[2], sfd;
	int res, i;

	OSERROR(pipe(pfd), "pipe");

	sfd =3D socket(AF_INET6, SOCK_DGRAM, 0);
	OSERROR(sfd, "socket/2");

	memset(&sin6, 0, sizeof(sin6));
	sin6.sin6_family =3D AF_INET6;
	sin6.sin6_port =3D htons(7);
#warning set dest IPv6 address below
	sin6.sin6_addr.s6_addr32[0] =3D htonl(0x01020304);
	sin6.sin6_addr.s6_addr32[1] =3D htonl(0x05060708);
	sin6.sin6_addr.s6_addr32[2] =3D htonl(0x00000000);
	sin6.sin6_addr.s6_addr32[3] =3D htonl(0x00000001);
	OSERROR(connect(sfd, (struct sockaddr *)&sin6, sizeof(sin6)), "connect");

	buffer =3D mmap(NULL, 1024*1024, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_AN=
ON, -1, 0);
	OSERROR(buffer, "mmap");

	for (i =3D 1000; i < 65535; i++) {
		printf("%d\n", i);
		OSERROR(send(sfd, buffer, i, MSG_MORE), "send");

		OSERROR(write(pfd[1], buffer, 8), "write");

		OSERROR(splice(pfd[0], 0, sfd, 0, 0x4ffe0ul, 0), "splice");
	}
	return 0;
}

