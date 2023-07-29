Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE2E76820D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jul 2023 23:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjG2Vu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jul 2023 17:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjG2VuW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jul 2023 17:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6A82728
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jul 2023 14:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690667373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9xoC7L2bOOoVu4fgnru97jFTPx3UfbeG/oW1+7jnOPk=;
        b=XhQ5b3bExgf1CT1oXbGpZjvZeGYT3zya+s/z4mm3MX4bLmiwN6bpiMiEfCH4OaWLfMBand
        1A7lBsqs7sh/KfLbrZS4CGxuWtkB/lR9Fe8OTV3Wq9p5MPCJSg2Z5VwJo8Z2ZiKJBCQTxR
        SWE6kZsMT780uy97UYrQN07pIZmZVzQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-hWbhkitSMLSaI_dUnS9x_w-1; Sat, 29 Jul 2023 17:49:30 -0400
X-MC-Unique: hWbhkitSMLSaI_dUnS9x_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98B08858F1E;
        Sat, 29 Jul 2023 21:49:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D50992166B25;
        Sat, 29 Jul 2023 21:49:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230718160737.52c68c73@kernel.org>
References: <20230718160737.52c68c73@kernel.org> <000000000000881d0606004541d1@google.com> <0000000000001416bb06004ebf53@google.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Endless loop in udp with MSG_SPLICE_READ - Re: [syzbot] [fs?] INFO: task hung in pipe_release (4)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <792237.1690667367.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Sat, 29 Jul 2023 22:49:27 +0100
Message-ID: <792238.1690667367@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jakub, Willem,

I think I'm going to need your help with this one.

> > syzbot has bisected this issue to:
> > =

> > commit 7ac7c987850c3ec617c778f7bd871804dc1c648d
> > Author: David Howells <dhowells@redhat.com>
> > Date:   Mon May 22 12:11:22 2023 +0000
> > =

> >     udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES
> > =

> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D15853bc=
aa80000
> > start commit:   3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git=
://w..
> > git tree:       upstream
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D17853bc=
aa80000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13853bcaa8=
0000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D150188feee=
7071a7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Df527b971b4bd=
c8e79f9e
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12a86682=
a80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1520ab6ca8=
0000
> > =

> > Reported-by: syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com
> > Fixes: 7ac7c987850c ("udp: Convert udp_sendpage() to use MSG_SPLICE_PA=
GES")
> > =

> > For information about bisection process see: https://goo.gl/tpsmEJ#bis=
ection

The issue that syzbot is triggering seems to be something to do with the
calculations in the "if (copy <=3D 0) { ... }" chunk in __ip_append_data()=
 when
MSG_SPLICE_PAGES is in operation.

What seems to happen is that the test program uses sendmsg() + MSG_MORE to
loads a UDP packet with 1406 bytes of data to the MTU size (1434) and then
splices in 8 extra bytes.

	r3 =3D socket$inet_udp(0x2, 0x2, 0x0)
	setsockopt$sock_int(r3, 0x1, 0x6, &(0x7f0000000140)=3D0x32, 0x4)
	bind$inet(r3, &(0x7f0000000000)=3D{0x2, 0x0, @dev=3D{0xac, 0x14, 0x14, 0x=
15}}, 0x10)
	connect$inet(r3, &(0x7f0000000200)=3D{0x2, 0x0, @broadcast}, 0x10)
	sendmmsg(r3, &(0x7f0000000180)=3D[{{0x0, 0x0, 0x0}}, {{0x0, 0xfffffffffff=
ffed3, &(0x7f0000000940)=3D[{&(0x7f00000006c0)=3D'O', 0x57e}], 0x1}}], 0x4=
000000000003bd, 0x8800)
	write$binfmt_misc(r1, &(0x7f0000000440)=3DANY=3D[], 0x8)
	splice(r0, 0x0, r2, 0x0, 0x4ffe0, 0x0)

This results in some negative intermediate values turning up in the
calculations - and this results in the remaining length being made longer
from 8 to 14.

I added some printks (patch attached), resulting in the attached traceline=
s:

	=3D=3D>splice_to_socket() 7099
	udp_sendmsg(8,8)
	__ip_append_data(copy=3D-6,len=3D8, mtu=3D1434 skblen=3D1434 maxfl=3D1428=
)
	pagedlen 14 =3D 14 - 0
	copy -6 =3D 14 - 0 - 6 - 14
	length 8 -=3D -6 + 0
	__ip_append_data(copy=3D1414,len=3D14, mtu=3D1434 skblen=3D20 maxfl=3D142=
8)
	copy=3D1414 len=3D14
	skb_splice_from_iter(8,14)
	__ip_append_data(copy=3D1406,len=3D6, mtu=3D1434 skblen=3D28 maxfl=3D1428=
)
	copy=3D1406 len=3D6
	skb_splice_from_iter(0,6)
	__ip_append_data(copy=3D1406,len=3D6, mtu=3D1434 skblen=3D28 maxfl=3D1428=
)
	copy=3D1406 len=3D6
	skb_splice_from_iter(0,6)
	__ip_append_data(copy=3D1406,len=3D6, mtu=3D1434 skblen=3D28 maxfl=3D1428=
)
	copy=3D1406 len=3D6
	skb_splice_from_iter(0,6)
	__ip_append_data(copy=3D1406,len=3D6, mtu=3D1434 skblen=3D28 maxfl=3D1428=
)
	copy=3D1406 len=3D6
	skb_splice_from_iter(0,6)
	copy=3D1406 len=3D6
	skb_splice_from_iter(0,6)
	...

'copy' gets calculated as -6 because the maxfraglen (maxfl=3D1428) is 8 by=
tes
less than the amount of data then in the packet (skblen=3D1434).

'copy' gets recalculated part way down as -6 from datalen (14) - transhdrl=
en
(0) - fraggap (6) - pagedlen (14).

datalen is 14 because it was length (8) + fraggap (6).

Inside skb_splice_from_iter(), we eventually end up in an enless loop in w=
hich
msg_iter.count is 0 and the length to be copied is 6.  It always returns 0
because there's nothing to copy, and so __ip_append_data() cycles round th=
e
loop endlessly.

Any suggestion as to how to fix this?

Thanks,
David
---

Debug hang in pipe_release's pipe_lock
---
 fs/splice.c          |    3 +++
 net/core/skbuff.c    |    7 +++++++
 net/ipv4/ip_output.c |   24 ++++++++++++++++++++++++
 net/ipv4/udp.c       |    3 +++
 4 files changed, 37 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 004eb1c4ce31..9ee82b818bd6 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -801,6 +801,8 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe,=
 struct file *out,
 	size_t spliced =3D 0;
 	bool need_wakeup =3D false;
 =

+	printk("=3D=3D>splice_to_socket() %u\n", current->pid);
+
 	pipe_lock(pipe);
 =

 	while (len > 0) {
@@ -911,6 +913,7 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe,=
 struct file *out,
 	pipe_unlock(pipe);
 	if (need_wakeup)
 		wakeup_pipe_writers(pipe);
+	printk("<=3D=3Dsplice_to_socket() =3D %zd\n", spliced ?: ret);
 	return spliced ?: ret;
 }
 #endif
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a298992060e6..c3d60da9e3f7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6801,6 +6801,13 @@ ssize_t skb_splice_from_iter(struct sk_buff *skb, s=
truct iov_iter *iter,
 	ssize_t spliced =3D 0, ret =3D 0;
 	unsigned int i;
 =

+	static int __pcount;
+
+	if (__pcount < 6) {
+		printk("skb_splice_from_iter(%zu,%zd)\n", iter->count, maxsize);
+		__pcount++;
+	}
+
 	while (iter->count > 0) {
 		ssize_t space, nr, len;
 		size_t off;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 6e70839257f7..8c84a7d13627 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1066,6 +1066,14 @@ static int __ip_append_data(struct sock *sk,
 		copy =3D mtu - skb->len;
 		if (copy < length)
 			copy =3D maxfraglen - skb->len;
+		if (flags & MSG_SPLICE_PAGES) {
+			static int __pcount;
+			if (__pcount < 6) {
+				printk("__ip_append_data(copy=3D%d,len=3D%d, mtu=3D%d skblen=3D%d max=
fl=3D%d)\n",
+				       copy, length, mtu, skb->len, maxfraglen);
+				__pcount++;
+			}
+		}
 		if (copy <=3D 0) {
 			char *data;
 			unsigned int datalen;
@@ -1112,6 +1120,10 @@ static int __ip_append_data(struct sock *sk,
 			else {
 				alloclen =3D fragheaderlen + transhdrlen;
 				pagedlen =3D datalen - transhdrlen;
+				if (flags & MSG_SPLICE_PAGES) {
+					printk("pagedlen %d =3D %d - %d\n",
+					       pagedlen, datalen, transhdrlen);
+				}
 			}
 =

 			alloclen +=3D alloc_extra;
@@ -1158,6 +1170,9 @@ static int __ip_append_data(struct sock *sk,
 			}
 =

 			copy =3D datalen - transhdrlen - fraggap - pagedlen;
+			if (flags & MSG_SPLICE_PAGES)
+				printk("copy %d =3D %d - %d - %d - %d\n",
+				       copy, datalen, transhdrlen, fraggap, pagedlen);
 			if (copy > 0 && getfrag(from, data + transhdrlen, offset, copy, fragga=
p, skb) < 0) {
 				err =3D -EFAULT;
 				kfree_skb(skb);
@@ -1165,6 +1180,8 @@ static int __ip_append_data(struct sock *sk,
 			}
 =

 			offset +=3D copy;
+			if (flags & MSG_SPLICE_PAGES)
+				printk("length %d -=3D %d + %d\n", length, copy, transhdrlen);
 			length -=3D copy + transhdrlen;
 			transhdrlen =3D 0;
 			exthdrlen =3D 0;
@@ -1192,6 +1209,13 @@ static int __ip_append_data(struct sock *sk,
 			continue;
 		}
 =

+		if (flags & MSG_SPLICE_PAGES) {
+			static int __qcount;
+			if (__qcount < 6) {
+				printk("copy=3D%d len=3D%d\n", copy, length);
+				__qcount++;
+			}
+		}
 		if (copy > length)
 			copy =3D length;
 =

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 42a96b3547c9..bd3f4e62574b 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1081,6 +1081,9 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg,=
 size_t len)
 	if (msg->msg_flags & MSG_OOB) /* Mirror BSD error message compatibility =
*/
 		return -EOPNOTSUPP;
 =

+	if (msg->msg_flags & MSG_SPLICE_PAGES)
+		printk("udp_sendmsg(%zx,%zx)\n", msg->msg_iter.count, len);
+
 	getfrag =3D is_udplite ? udplite_getfrag : ip_generic_getfrag;
 =

 	fl4 =3D &inet->cork.fl.u.ip4;

