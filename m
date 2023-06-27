Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B72740305
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 20:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjF0SQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 14:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjF0SPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:15:35 -0400
Received: from resqmta-h1p-028588.sys.comcast.net (resqmta-h1p-028588.sys.comcast.net [IPv6:2001:558:fd02:2446::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3501C30F0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 11:15:13 -0700 (PDT)
Received: from resomta-h1p-027916.sys.comcast.net ([96.102.179.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resqmta-h1p-028588.sys.comcast.net with ESMTP
        id EBPIqj9f5qqnBEDDbqtiMX; Tue, 27 Jun 2023 18:15:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1687889711;
        bh=wEwFJy1tz/xg01w4rSRHtJBUcjeLgVU/WBhe3MVixsw=;
        h=Received:Received:From:To:Subject:Date:MIME-Version:Message-ID:
         Content-Type:Xfinity-Spam-Result;
        b=aLjz7q+b/Hgp03nDoa59M57s/2z9JlAVpQyDsuSLxh8sA4Zgnoi0HO354vgdEJDOx
         4onREOkJD7uYj+Grb+TuQD+LFDo/6aZ6vJwaKI83L09jMd2p4NKbRPVn3ST3k7AyCz
         GdbjInLzdju3eAhqNFdiVmhVHzGA4wmQcKtWo0VeuzjZolUbJa0AF4lEDqh65MfJiQ
         Ejtz7JSVxYFkOxsxz4klJSObbbJKPLQx1iVY+1ToiZNbU0bWIll+lNs++3fFXCMpTu
         8V3jrtPiuicyQDcoZ22vX1nxBeeuxqgmyJqCdzKupYlRZC8+TTCQoKhIdJP6V6ZK5x
         V200UfEXVP2jA==
Received: from localhost ([IPv6:2601:18c:9082:afd:219:d1ff:fe75:dc2f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resomta-h1p-027916.sys.comcast.net with ESMTPSA
        id EDD8qVxPvQLmDEDDAqoWo3; Tue, 27 Jun 2023 18:14:48 +0000
X-Xfinity-VMeta: sc=0.00;st=legit
From:   Matt Whitlock <kernel@mattwhitlock.name>
To:     Dave Chinner <david@fromorbit.com>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [Reproducer] Corruption, possible race between splice and =?iso-8859-1?Q?FALLOC=5FFL=5FPUNCH=5FHOLE?=
Date:   Tue, 27 Jun 2023 14:14:41 -0400
MIME-Version: 1.0
Message-ID: <858f34c7-6f9c-499d-b0b4-fecce16541a7@mattwhitlock.name>
In-Reply-To: <ZJp4Df8MnU8F3XAt@dread.disaster.area>
References: <ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name>
 <ZJp4Df8MnU8F3XAt@dread.disaster.area>
User-Agent: Trojita/v0.7-595-g7738cd47; Qt/5.15.10; xcb; Linux; Gentoo Linux
Content-Type: multipart/mixed;
        boundary="trojita=_f24de9da-24be-4bda-8ff8-71f55c350df9"
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

--trojita=_f24de9da-24be-4bda-8ff8-71f55c350df9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Tuesday, 27 June 2023 01:47:57 EDT, Dave Chinner wrote:
> On Mon, Jun 26, 2023 at 09:12:52PM -0400, Matt Whitlock wrote:
>> Hello, all. I am experiencing a data corruption issue on Linux 6.1.24 when=

>> calling fallocate with FALLOC_FL_PUNCH_HOLE to punch out pages that have
>> just been spliced into a pipe. It appears that the fallocate call can zero=

>> out the pages that are sitting in the pipe buffer, before those pages are
>> read from the pipe.
>>=20
>> Simplified code excerpt (eliding error checking):
>>=20
>> int fd =3D /* open file descriptor referring to some disk file */;
>> for (off_t consumed =3D 0;;) {
>>   ssize_t n =3D splice(fd, NULL, STDOUT_FILENO, NULL, SIZE_MAX, 0);
>>   if (n <=3D 0) break;
>>   consumed +=3D n;
>>   fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, consumed);
>> }
>
> Huh. Never seen that pattern before - what are you trying to
> implement with this?

It's part of a tool I wrote that implements an indefinitely expandable=20
user-space pipe buffer backed by an unlinked-on-creation disk file. It's=20
very useful as a shim in a pipeline between a process that produces a large=20=

but finite amount of data quickly and a process that consumes data slowly.=20=

My canonical use case is in my nightly backup cronjob, where I have 'tar=20
-c' piped into 'xz' piped into a tool that uploads its stdin to an Amazon=20
S3-compatible data store. I insert my diskbuffer tool between tar and xz so=20=

that the tar process can complete as quickly as possible (thus achieving a=20=

snapshot as close to atomic as practically possible without freezing the=20
file system) and the xz process can take its sweet time crunching the=20
tarball down as small as possible, yet the disk space consumed by the=20
temporary (uncompressed) tarball can be released progressively as xz=20
consumes the tarball, and all of the disk space will be released=20
automatically if the pipeline dies, such as if the system is rebooted=20
during a backup run.

Conceptually:

tar -c /home | diskbuffer /var/tmp | xz -9e | s3upload ...

The 'diskbuffer' tool creates an unlinked temporary file (using=20
O_TMPFILE|O_EXCL) in the specified directory and then enters a loop,=20
splicing bytes from stdin into the file and splicing bytes from the file=20
into stdout, incrementally punching out the file as it successfully splices=20=

to stdout.

Source code for the tool is attached. (It has a bit more functionality than=20=

I have described here.)


--trojita=_f24de9da-24be-4bda-8ff8-71f55c350df9
Content-Type: text/x-csrc
Content-Disposition: attachment;
	filename=diskbuffer.c
Content-Transfer-Encoding: base64

I2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPGxpbWl0cy5oPgojaW5jbHVkZSA8c3RkYm9v
bC5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3Ry
aW5nLmg+CgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGVycm9yLmg+CiNpbmNsdWRlIDxm
Y250bC5oPgojaW5jbHVkZSA8cG9sbC5oPgojaW5jbHVkZSA8c3lzZXhpdHMuaD4KI2luY2x1ZGUg
PHVuaXN0ZC5oPgojaW5jbHVkZSA8c3lzL3N0YXQuaD4KI2luY2x1ZGUgPHN5cy9zdGF0ZnMuaD4K
I2luY2x1ZGUgPHN5cy90eXBlcy5oPgoKCnN0YXRpYyBpbmxpbmUgc2l6ZV90IHNwbGljZV9sZW4o
b2ZmX3QgbGVuKSB7CglyZXR1cm4gKHNpemVfdCkgKGxlbiA+IElOVF9NQVggPyBJTlRfTUFYIDog
bGVuKTsKfQoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkgewoJYm9vbCBkZWZlciA9
IGZhbHNlLCBrZWVwID0gZmFsc2U7CglpZiAoYXJnYyA+IDEgJiYgc3RyY21wKGFyZ3ZbMV0sICIt
LWRlZmVyIikgPT0gMCkgewoJCWRlZmVyID0gdHJ1ZTsKCQlhcmd2WzFdID0gYXJndlswXTsKCQkt
LWFyZ2MsICsrYXJndjsKCX0KCWlmIChhcmdjID4gMSAmJiBzdHJjbXAoYXJndlsxXSwgIi0ta2Vl
cCIpID09IDApIHsKCQlrZWVwID0gdHJ1ZTsKCQlhcmd2WzFdID0gYXJndlswXTsKCQktLWFyZ2Ms
ICsrYXJndjsKCX0KCWlmIChhcmdjID4gMiB8fCBrZWVwICYmIGFyZ2MgPCAyKSB7CgkJZnByaW50
ZihzdGRlcnIsICJ1c2FnZTogJXMgWy0tZGVmZXJdIHsgWzx0bXBkaXI+XSB8IC0ta2VlcCA8Zmls
ZT4gfVxuIiwgYXJndlswXSk7CgkJcmV0dXJuIEVYX1VTQUdFOwoJfQoJY29uc3QgY2hhciAqcGF0
aDsKCWludCBmZDsKCWlmIChrZWVwKSB7CgkJaWYgKChmZCA9IG9wZW4oYXJndlsxXSwgT19SRFdS
IHwgT19DUkVBVCB8IE9fRVhDTCwgMDY2NikpIDwgMCkgewoJCQllcnJvcihFWF9OT0lOUFVULCBl
cnJubywgIiVzIiwgYXJndlsxXSk7CgkJfQoJfQoJZWxzZSB7CgkJaWYgKGFyZ2MgPiAxKSB7CgkJ
CXBhdGggPSBhcmd2WzFdOwoJCX0KCQllbHNlIGlmICghKHBhdGggPSBnZXRlbnYoIlRNUERJUiIp
KSkgewoJCQlwYXRoID0gIi90bXAiOwoJCX0KCQlpZiAoKGZkID0gb3BlbihwYXRoLCBPX1JEV1Ig
fCBPX1RNUEZJTEUgfCBPX0VYQ0wsIDAwMDApKSA8IDApIHsKCQkJZXJyb3IoRVhfTk9JTlBVVCwg
ZXJybm8sICIlcyIsIHBhdGgpOwoJCX0KCX0KCglib29sIGVvZiA9IGZhbHNlLCBwdW5jaCA9ICFr
ZWVwOwoJb2ZmX3Qgbl9pbiA9IDAsIG5fb3V0ID0gMCwgbWF4ID0gMCwgbWFzayA9IDA7Cglmb3Ig
KDs7KSB7CgkJb2ZmX3Qgbl9idWYgPSBuX2luIC0gbl9vdXQ7CgkJaWYgKG5fYnVmID09IG1heCkg
ewoJCQlzdHJ1Y3Qgc3RhdGZzIGY7CgkJCWlmIChmc3RhdGZzKGZkLCAmZikgPCAwKSB7CgkJCQll
cnJvcihFWF9OT0lOUFVULCBlcnJubywgIiVzIiwgcGF0aCk7CgkJCX0KCQkJbWF4ID0gZi5mX2Jh
dmFpbCAvIDIgKiBmLmZfYnNpemU7CgkJCW1hc2sgPSB+KChvZmZfdCkgZi5mX2JzaXplIC0gMSk7
CgkJfQoJCXN0cnVjdCBwb2xsZmQgcGZkc1syXSA9IHsgfTsKCQluZmRzX3QgbmZkcyA9IDA7CgkJ
aWYgKCFlb2YgJiYgbl9idWYgPCBtYXgpIHsKCQkJcGZkc1tuZmRzXS5mZCA9IFNURElOX0ZJTEVO
TzsKCQkJcGZkc1tuZmRzXS5ldmVudHMgPSBQT0xMSU47CgkJCSsrbmZkczsKCQl9CgkJaWYgKG5f
YnVmID4gMCAmJiAoIWRlZmVyIHx8IGVvZikpIHsKCQkJcGZkc1tuZmRzXS5mZCA9IFNURE9VVF9G
SUxFTk87CgkJCXBmZHNbbmZkc10uZXZlbnRzID0gUE9MTE9VVDsKCQkJKytuZmRzOwoJCX0KCQlp
ZiAobmZkcyA9PSAwKSB7CgkJCWlmIChlb2YpIHsKCQkJCWJyZWFrOwoJCQl9CgkJCXNsZWVwKDEp
OwoJCQljb250aW51ZTsKCQl9CgkJaWYgKHBvbGwocGZkcywgbmZkcywgLTEpID4gMCkgewoJCQlm
b3IgKG5mZHNfdCBpID0gMDsgaSA8IG5mZHM7ICsraSkgewoJCQkJaWYgKHBmZHNbaV0ucmV2ZW50
cykgewoJCQkJCWlmIChwZmRzW2ldLmZkID09IFNURElOX0ZJTEVOTykgewoJCQkJCQlzc2l6ZV90
IG4gPSBzcGxpY2UoU1RESU5fRklMRU5PLCBOVUxMLCBmZCwgJm5faW4sIHNwbGljZV9sZW4obWF4
IC0gbl9idWYpLCBTUExJQ0VfRl9NT1ZFIHwgU1BMSUNFX0ZfTk9OQkxPQ0sgfCBTUExJQ0VfRl9N
T1JFKTsKCQkJCQkJaWYgKG4gPD0gMCkgewoJCQkJCQkJaWYgKG4gPT0gMCkgewoJCQkJCQkJCWVv
ZiA9IHRydWU7CgkJCQkJCQl9CgkJCQkJCQllbHNlIGlmIChlcnJubyAhPSBFQUdBSU4pIHsKCQkJ
CQkJCQllcnJvcihFWF9JT0VSUiwgZXJybm8sICIlczogc3BsaWNlIiwgIjxzdGRpbj4iKTsKCQkJ
CQkJCX0KCQkJCQkJfQoJCQkJCQllbHNlIHsKCQkJCQkJCW5fYnVmICs9IG47CgkJCQkJCX0KCQkJ
CQl9CgkJCQkJZWxzZSBpZiAocGZkc1tpXS5mZCA9PSBTVERPVVRfRklMRU5PKSB7CgkJCQkJCXNz
aXplX3QgbiA9IHNwbGljZShmZCwgTlVMTCwgU1RET1VUX0ZJTEVOTywgTlVMTCwgc3BsaWNlX2xl
bihuX2J1ZiksIFNQTElDRV9GX01PVkUgfCBTUExJQ0VfRl9OT05CTE9DSyB8IFNQTElDRV9GX01P
UkUpOwoJCQkJCQlpZiAobiA8PSAwKSB7CgkJCQkJCQlpZiAobiA8IDAgJiYgZXJybm8gIT0gRUFH
QUlOKSB7CgkJCQkJCQkJZXJyb3IoRVhfSU9FUlIsIGVycm5vLCAiJXM6IHNwbGljZSIsICI8c3Rk
b3V0PiIpOwoJCQkJCQkJfQoJCQkJCQl9CgkJCQkJCWVsc2UgaWYgKCgobl9vdXQgKz0gbikgJiBt
YXNrKSAmJiBwdW5jaCAmJiBmYWxsb2NhdGUoZmQsIEZBTExPQ19GTF9QVU5DSF9IT0xFIHwgRkFM
TE9DX0ZMX0tFRVBfU0laRSwgMCwgbl9vdXQgJiBtYXNrKSA8IDApIHsKCQkJCQkJCWlmIChlcnJu
byAhPSBFT1BOT1RTVVBQICYmIGVycm5vICE9IEVOT1NZUykgewoJCQkJCQkJCWVycm9yKEVYX0lP
RVJSLCBlcnJubywgIiVzOiBmYWxsb2NhdGUiLCBwYXRoKTsKCQkJCQkJCX0KCQkJCQkJCWZwcmlu
dGYoc3RkZXJyLCAiV0FSTklORzogdGVtcCBmaWxlIGluICVzIGRvZXMgbm90IHN1cHBvcnQgRkFM
TE9DX0ZMX1BVTkNIX0hPTEVcbiIsIHBhdGgpOwoJCQkJCQkJcHVuY2ggPSBmYWxzZTsKCQkJCQkJ
fQoJCQkJCX0KCQkJCX0KCQkJfQoJCX0KCQllbHNlIGlmIChlcnJubyAhPSBFSU5UUikgewoJCQll
cnJvcihFWF9PU0VSUiwgZXJybm8sICJwb2xsIik7CgkJfQoJfQoJcmV0dXJuIEVYX09LOwp9Cg==

--trojita=_f24de9da-24be-4bda-8ff8-71f55c350df9--

