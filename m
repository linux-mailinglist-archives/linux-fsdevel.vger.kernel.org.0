Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6403B73F037
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 03:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjF0BQB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 21:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjF0BPu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 21:15:50 -0400
X-Greylist: delayed 150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Jun 2023 18:15:49 PDT
Received: from resqmta-h1p-028591.sys.comcast.net (resqmta-h1p-028591.sys.comcast.net [IPv6:2001:558:fd02:2446::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D7D198D
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 18:15:49 -0700 (PDT)
Received: from resomta-h1p-028516.sys.comcast.net ([96.102.179.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resqmta-h1p-028591.sys.comcast.net with ESMTP
        id DvA2q8zHX6ZQQDxGfqSs5f; Tue, 27 Jun 2023 01:13:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1687828397;
        bh=lWIrrdBwU2Z2iSXjnUlbUEi7uBI4b1rraPxssPyuNw0=;
        h=Received:Received:From:To:Subject:Date:MIME-Version:Message-ID:
         Content-Type:Xfinity-Spam-Result;
        b=ld4wwcPME9dVc+n2UjdZWZqFwnv1y3ca9BnFYY8uXUg5OGmXIpz4oRnmKLLRBQ3l9
         5osCahyYRF4DS+m5fMUICXzSvqd3OKmekWo4E6F8BqKvq5/Vc2PmVoVa/madgUYgFG
         /53HhQLKqyiI9Eo9ZBVRkIjX921uSVlCo/KVeYf2TfotAXd70+WEVmCbZMO9GrMJBg
         7LSrCHB1NBdO87rl7/TBC27Wu7o+Zv9llZs3i6IDY/DPD3vYzLKw+TeD5aa/TeJyvz
         Ub8XTs4lGyhMWBpJ63i3jyyOFBNyBAxC2E7M8VfvtxnNOSYGKQurDoX6uOG2eN4pCb
         BrNQB47N/TVyw==
Received: from localhost ([IPv6:2601:18c:9082:afd:219:d1ff:fe75:dc2f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resomta-h1p-028516.sys.comcast.net with ESMTPSA
        id DxGHq6r532VAEDxGJquU81; Tue, 27 Jun 2023 01:12:55 +0000
X-Xfinity-VMeta: sc=0.00;st=legit
From:   Matt Whitlock <kernel@mattwhitlock.name>
To:     <linux-fsdevel@vger.kernel.org>
Subject: [Reproducer] Corruption, possible race between splice and =?iso-8859-1?Q?FALLOC=5FFL=5FPUNCH=5FHOLE?=
Date:   Mon, 26 Jun 2023 21:12:52 -0400
MIME-Version: 1.0
Message-ID: <ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name>
User-Agent: Trojita/v0.7-595-g7738cd47; Qt/5.15.10; xcb; Linux; Gentoo Linux
Content-Type: multipart/mixed;
        boundary="trojita=_a96e5a88-7dc2-4bd2-9532-de033b9131da"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,MIME_QP_LONG_LINE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multipart/mixed message in MIME format.

--trojita=_a96e5a88-7dc2-4bd2-9532-de033b9131da
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello, all. I am experiencing a data corruption issue on Linux 6.1.24 when=20=

calling fallocate with FALLOC_FL_PUNCH_HOLE to punch out pages that have=20
just been spliced into a pipe. It appears that the fallocate call can zero=20=

out the pages that are sitting in the pipe buffer, before those pages are=20
read from the pipe.

Simplified code excerpt (eliding error checking):

int fd =3D /* open file descriptor referring to some disk file */;
for (off_t consumed =3D 0;;) {
   ssize_t n =3D splice(fd, NULL, STDOUT_FILENO, NULL, SIZE_MAX, 0);
   if (n <=3D 0) break;
   consumed +=3D n;
   fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, consumed);
}

Expected behavior:
Punching holes in a file after splicing pages out of that file into a pipe=20=

should not corrupt the spliced-out pages in the pipe buffer.

Observed behavior:
Some of the pages that have been spliced into the pipe get zeroed out by=20
the subsequent fallocate call before they can be consumed from the read=20
side of the pipe.


Steps to reproduce:

1. Save the attached ones.c, dontneed.c, and consume.c.

2. gcc -o ones ones.c
   gcc -o dontneed dontneed.c
   gcc -o consume consume.c

3. Fill a file with 32 MiB of 0xFF:
   ./ones | head -c$((1<<25)) >testfile

4. Evict the pages of the file from the page cache:
   sync testfile && ./dontneed testfile

5. Splice the file into a pipe, punching out batches of pages after=20
splicing them:
   ./consume testfile | hexdump -C

The expected output from hexdump should show 32 MiB of 0xFF. Indeed, on my=20=

system, if I omit the POSIX_FADV_DONTNEED advice, then I do get the=20
expected output. However, if the pages of the file are not already present=20=

in the page cache (i.e., if the splice call faults them in from disk), then=20=

the hexdump output shows some pages full of 0xFF and some pages full of=20
0x00.

Note #1: I am running a fairly antiquated x86_64 system. You may need to=20
use a file larger than 32 MiB to reproduce the misbehavior on a more modern=20=

system. In particular, even I cannot reproduce the problem when I use 16=20
MiB. Conversely, when I use a very large file (too large to fit entirely in=20=

the page cache), then I don't need the "dontneed" call to reproduce the=20
problem.

Note #2: I am siting my test file on an XFS file system running on a=20
hardware RAID volume at /dev/sda1. I'm not sure if that's relevant.
--trojita=_a96e5a88-7dc2-4bd2-9532-de033b9131da
Content-Type: text/x-csrc
Content-Disposition: attachment;
	filename=ones.c
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0cmluZy5oPgoKI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxlcnJvci5o
PgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPHN5c2V4aXRzLmg+CiNpbmNsdWRlIDx1bmlz
dGQuaD4KCmludCBtYWluKCkgewoJY2hhciBidWZbNDA5Nl07CgltZW1zZXQoYnVmLCAweEZGLCBz
aXplb2YgYnVmKTsKCWZvciAoOzspCgkJaWYgKHdyaXRlKFNURE9VVF9GSUxFTk8sIGJ1Ziwgc2l6
ZW9mIGJ1ZikgPCAwKQoJCQllcnJvcihFWF9JT0VSUiwgZXJybm8sICJ3cml0ZSIpOwoJcmV0dXJu
IEVYX09LOwp9Cg==

--trojita=_a96e5a88-7dc2-4bd2-9532-de033b9131da
Content-Type: text/x-csrc
Content-Disposition: attachment;
	filename=dontneed.c
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGVycm9yLmg+
CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8c3lzZXhpdHMuaD4KI2luY2x1ZGUgPHVuaXN0
ZC5oPgoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkgewoJaWYgKGFyZ2MgPCAyKSB7
CgkJcHJpbnRmKCJ1c2FnZTogJXMgPGZpbGU+IFsuLi5dXG4iLCBhcmdjID4gMCA/ICphcmd2IDog
ImRvbnRuZWVkIik7CgkJcmV0dXJuIEVYX1VTQUdFOwoJfQoJaW50IHJldCA9IEVYX09LOwoJd2hp
bGUgKCsrYXJndiwgLS1hcmdjID4gMCkgewoJCWludCBmZCA9IG9wZW4oKmFyZ3YsIE9fUkRPTkxZ
KTsKCQlpZiAoZmQgPCAwKSB7CgkJCWVycm9yKDAsIGVycm5vLCAiJXMiLCAqYXJndik7CgkJCXJl
dCA9IHJldCA/OiBFWF9OT0lOUFVUOwoJCQljb250aW51ZTsKCQl9CgkJaWYgKHBvc2l4X2ZhZHZp
c2UoZmQsIDAsIDAsIFBPU0lYX0ZBRFZfRE9OVE5FRUQpIDwgMCkgewoJCQllcnJvcigwLCBlcnJu
bywgIiVzOiBwb3NpeF9mYWR2aXNlIiwgKmFyZ3YpOwoJCQlyZXQgPSBFWF9PU0VSUjsKCQl9CgkJ
aWYgKGNsb3NlKGZkKSA8IDApCgkJCWVycm9yKEVYX09TRVJSLCBlcnJubywgIiVzOiBjbG9zZSIs
ICphcmd2KTsKCX0KCXJldHVybiByZXQ7Cn0K

--trojita=_a96e5a88-7dc2-4bd2-9532-de033b9131da
Content-Type: text/x-csrc
Content-Disposition: attachment;
	filename=consume.c
Content-Transfer-Encoding: base64

I2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPHN0ZGludC5oPgoKI2luY2x1ZGUgPGVycm5v
Lmg+CiNpbmNsdWRlIDxlcnJvci5oPgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPHN5c2V4
aXRzLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KCmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2
W10pIHsKCSsrYXJndiwgLS1hcmdjOwoJZG8gewoJCWNvbnN0IGNoYXIgKmZpbGVuYW1lID0gIjxz
dGRpbj4iOwoJCWlmIChhcmdjID4gMCkgewoJCQljbG9zZShTVERJTl9GSUxFTk8pOwoJCQlpZiAo
b3BlbihmaWxlbmFtZSA9ICphcmd2LCBPX1JEV1IpICE9IFNURElOX0ZJTEVOTykKCQkJCWVycm9y
KEVYX05PSU5QVVQsIGVycm5vLCAiJXMiLCBmaWxlbmFtZSk7CgkJfQoJCWZvciAob2ZmX3QgY29u
c3VtZWQgPSAwOzspIHsKCQkJc3NpemVfdCBuID0gc3BsaWNlKFNURElOX0ZJTEVOTywgTlVMTCwg
U1RET1VUX0ZJTEVOTywgTlVMTCwgU0laRV9NQVgsIDApOwoJCQlpZiAobiA8PSAwKSB7CgkJCQlp
ZiAobiA8IDApCgkJCQkJZXJyb3IoRVhfSU9FUlIsIGVycm5vLCAiJXM6IHNwbGljZSIsIGZpbGVu
YW1lKTsKCQkJCWJyZWFrOwoJCQl9CgkJCWlmIChmYWxsb2NhdGUoU1RESU5fRklMRU5PLCBGQUxM
T0NfRkxfUFVOQ0hfSE9MRSB8IEZBTExPQ19GTF9LRUVQX1NJWkUsIDAsIGNvbnN1bWVkICs9IG4p
IDwgMCkKCQkJCWVycm9yKEVYX09TRVJSLCBlcnJubywgIiVzOiBmYWxsb2NhdGUiLCBmaWxlbmFt
ZSk7CgkJfQoJCWlmIChhcmdjID4gMCAmJiB1bmxpbmsoZmlsZW5hbWUpIDwgMCkKCQkJZXJyb3Io
RVhfT1NFUlIsIGVycm5vLCAiJXM6IHVubGluayIsIGZpbGVuYW1lKTsKCX0gd2hpbGUgKCsrYXJn
diwgLS1hcmdjID4gMCk7CglyZXR1cm4gRVhfT0s7Cn0K

--trojita=_a96e5a88-7dc2-4bd2-9532-de033b9131da--

