Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B187768FDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 10:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjGaIRj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 04:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjGaIRP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABF01A6
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 01:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690791242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=84A7MRcr6j0wpILuwXBGqg5ue7ADRIvAJFMR99EWls0=;
        b=NsAUfwj0yFkWnh4e5KLr28luj91srAMxsJxA6WQQHZkbJCEPLW1KA6pVbAjR6ACaV2+eah
        pyvtjqai7yocfcRAHAQIT0ILXi/hN/JaXow/YQy0lAtHoQ28/cSr42Juz1n7rnzsjaounz
        WDSa9r74L6CRbriryWWLZKb3+5s4HEw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-8IG60DfBNI6WHWTz4-XXtw-1; Mon, 31 Jul 2023 04:13:56 -0400
X-MC-Unique: 8IG60DfBNI6WHWTz4-XXtw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83470803470;
        Mon, 31 Jul 2023 08:13:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D687740C2063;
        Mon, 31 Jul 2023 08:13:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <64c6672f580e3_11d0042944e@willemb.c.googlers.com.notmuch>
References: <64c6672f580e3_11d0042944e@willemb.c.googlers.com.notmuch> <20230718160737.52c68c73@kernel.org> <000000000000881d0606004541d1@google.com> <0000000000001416bb06004ebf53@google.com> <792238.1690667367@warthog.procyon.org.uk>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
        syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: Endless loop in udp with MSG_SPLICE_READ - Re: [syzbot] [fs?] INFO: task hung in pipe_release (4)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <831027.1690791233.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 31 Jul 2023 09:13:53 +0100
Message-ID: <831028.1690791233@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Hi Willem,

Here's a reduced testcase.  I doesn't require anything special; the key is
that the amount of data placed in the packet by the send() - it's related =
to
the MTU size.  It needs to stuff in sufficient data to go over the
fragmentation limit (I think).

In this case, my interface's MTU is 8192.  send() is sticking in 8161 byte=
s of
data and then the output from the aforeposted debugging patch is:

	=3D=3D>splice_to_socket() 6630
	udp_sendmsg(8,8)
	__ip_append_data(copy=3D-1,len=3D8, mtu=3D8192 skblen=3D8189 maxfl=3D8188=
)
	pagedlen 9 =3D 9 - 0
	copy -1 =3D 9 - 0 - 1 - 9
	length 8 -=3D -1 + 0
	__ip_append_data(copy=3D8172,len=3D9, mtu=3D8192 skblen=3D20 maxfl=3D8188=
)
	copy=3D8172 len=3D9
	skb_splice_from_iter(8,9)
	__ip_append_data(copy=3D8164,len=3D1, mtu=3D8192 skblen=3D28 maxfl=3D8188=
)
	copy=3D8164 len=3D1
	skb_splice_from_iter(0,1)
	__ip_append_data(copy=3D8164,len=3D1, mtu=3D8192 skblen=3D28 maxfl=3D8188=
)
	copy=3D8164 len=3D1
	skb_splice_from_iter(0,1)
	__ip_append_data(copy=3D8164,len=3D1, mtu=3D8192 skblen=3D28 maxfl=3D8188=
)
	copy=3D8164 len=3D1
	skb_splice_from_iter(0,1)
	__ip_append_data(copy=3D8164,len=3D1, mtu=3D8192 skblen=3D28 maxfl=3D8188=
)
	copy=3D8164 len=3D1
	skb_splice_from_iter(0,1)
	copy=3D8164 len=3D1
	skb_splice_from_iter(0,1)

It looks like send() pushes 1 byte over the fragmentation limit, then the
splice sees -1 crop up, the length to be copied is increased by 1, but
insufficient data is available and we go into an endless loop.

---
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <fcntl.h>
#include <netinet/in.h>
#include <stdarg.h>
#include <stdbool.h>
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
	struct sockaddr_in sin;
	void *buffer;
	unsigned int tmp;
	int pfd[2], sfd;
	int res;

	OSERROR(pipe(pfd), "pipe");

	sfd =3D socket(AF_INET, SOCK_DGRAM, 0);
	OSERROR(sfd, "socket/2");

	memset(&sin, 0, sizeof(sin));
	sin.sin_family =3D AF_INET;
	sin.sin_port =3D htons(0);
	sin.sin_addr.s_addr =3D htonl(0xc0a80601);
#warning you might want to set the address here - this is 192.168.6.1
	OSERROR(connect(sfd, (struct sockaddr *)&sin, sizeof(sin)), "connect");

	buffer =3D mmap(NULL, 1024*1024, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_AN=
ON, -1, 0);
	OSERROR(buffer, "mmap");

	OSERROR(send(sfd, buffer, 8161, MSG_CONFIRM|MSG_MORE), "send");
#warning you need to adjust the length on the above line to match your MTU

	OSERROR(write(pfd[1], buffer, 8), "write");

	OSERROR(splice(pfd[0], 0, sfd, 0, 0x4ffe0ul, 0), "splice");
	return 0;
}

