Return-Path: <linux-fsdevel+bounces-38550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBB6A039C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 09:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA57B165245
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85E81E1A3D;
	Tue,  7 Jan 2025 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b="0Dy1kcjU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2531AAA10;
	Tue,  7 Jan 2025 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.129.21.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736238401; cv=none; b=U/0TtI9SoIDaXL1nr/9HTuxqhq5G+yMW/7AQcm9xrMtEjY0XXVjCUcql1Ibix7PpBw3xpQbb8EjBRtIATMLTj6qBkcJMrBJOqbN/9R/Rsc9XZNtusY+kWOerxvaFhUF+4M7m3uqflixVj33B9dGeFYXyc6/2Yueo9139GuEZLuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736238401; c=relaxed/simple;
	bh=jZ0+OGaIgzg1CHNIaj8SAXWPI9x1twG7QWvI5xB7uKI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=UdaFTJg3LVmY29qmLPmGhMfX6nM55sT0UDpw6dBzY8nhIdOifo14ezvu+Xo5LRsc861P627N+lUW4r0Sf9HAflQo7MmoZtml5gi3VaafIlGQh/r3xonqW87LoxeWHirSzGcaeme288mBqlToz7J3jRX2smYUNAYlZAj5l67k7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr; spf=pass smtp.mailfrom=3xo.fr; dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b=0Dy1kcjU; arc=none smtp.client-ip=212.129.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xo.fr
Received: from localhost (mail.3xo.fr [212.129.21.66])
	by mail.3xo.fr (Postfix) with ESMTP id 8C308C6;
	Tue,  7 Jan 2025 09:26:34 +0100 (CET)
X-Virus-Scanned: Debian amavis at nxo2.3xo.fr
Received: from mail.3xo.fr ([212.129.21.66])
 by localhost (mail.3xo.fr [212.129.21.66]) (amavis, port 10024) with ESMTP
 id 1TM8fVmCoesI; Tue,  7 Jan 2025 09:26:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.3xo.fr 0F9E69A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xo.fr; s=3xo;
	t=1736238389; bh=mAo05H522WX53Hk4wwUxmtgyssL8mKB7kPAfERuCX2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0Dy1kcjUNuSdweDJBY94RHlIgmtyEm+KdgNepv9WDm1zQG2gmC83u+C17/nLptmcq
	 qABU8ZIcj2JvoibEjdMKH5dfIq7YlHCF/HV02kGL7750VfKAm/23LEN5R4e9kYsP5a
	 c3ZEVdhnzeVWy6Xb/eiuqx8KlPVSLzWXgkOTpsV/EyZZUCwlz+KwBXCdyXrZR8vdJa
	 fMb+q8+kBfLiEtPUxjcGg7A8oGRJVMbI8BmHRtXqSZwsNURv5M2P9oUmc2wYJcl6ok
	 yR6OOwi51YJJqzasqMIAaudwsrMq2cg3A5tvE0fvUVCYsM9PDtI1nuHJE7ku9V5AcY
	 +mn8qGyxqCZ/w==
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3xo.fr (Postfix) with ESMTPSA id 0F9E69A;
	Tue,  7 Jan 2025 09:26:29 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 07 Jan 2025 09:26:28 +0100
From: nicolas.baranger@3xo.fr
To: David Howells <dhowells@redhat.com>
Cc: Steve French <smfrench@gmail.com>, Christoph Hellwig
 <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>, Christian Brauner
 <brauner@kernel.org>, netfs@lists.linux.dev, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix kernel async DIO
In-Reply-To: <b3e8129937055ff8971d8be44286f0b8@3xo.fr>
References: <fedd8a40d54b2969097ffa4507979858@3xo.fr>
 <669f22fc89e45dd4e56d75876dc8f2bf@3xo.fr>
 <286638.1736163444@warthog.procyon.org.uk>
 <b3e8129937055ff8971d8be44286f0b8@3xo.fr>
Message-ID: <d98ca4470c447182020b576841115a20@3xo.fr>
X-Sender: nicolas.baranger@3xo.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi David

As your patch was written on top on linux-next I was required to make 
some small modifications to make it work on mainline (6.13-rc6).
The following patch is working fine for me on mainline, but i think it 
would be better to wait for your confirmation / validation (or new 
patch) before applying it on production.

#-------- PATCH --------#

diff --git a/linux-6.13-rc6/nba/_orig_fs.netfs.direct_write.c 
b/linux-6.13-rc6/fs/netfs/direct_write.c
index 88f2adf..94a1ee8 100644
--- a/linux-6.13-rc6/nba/_orig_fs.netfs.direct_write.c
+++ b/linux-6.13-rc6/fs/netfs/direct_write.c
@@ -67,7 +67,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct 
kiocb *iocb, struct iov_iter *
                  * allocate a sufficiently large bvec array and may 
shorten the
                  * request.
                  */
-               if (async || user_backed_iter(iter)) {
+               if (user_backed_iter(iter)) {
                         n = netfs_extract_user_iter(iter, len, 
&wreq->iter, 0);
                         if (n < 0) {
                                 ret = n;
@@ -77,6 +77,11 @@ ssize_t netfs_unbuffered_write_iter_locked(struct 
kiocb *iocb, struct iov_iter *
                         wreq->direct_bv_count = n;
                         wreq->direct_bv_unpin = 
iov_iter_extract_will_pin(iter);
                 } else {
+                       /* If this is a kernel-generated async DIO 
request,
+                        * assume that any resources the iterator points 
to
+                        * (eg. a bio_vec array) will persist till the 
end of
+                        * the op.
+                        */
                         wreq->iter = *iter;
                 }


#-------- TESTS --------#

Using this patch Linux 6.13-rc6 build with no error and '--direct-io=on' 
is working :


18:38:47 root@deb12-lab-10d:~# uname -a
Linux deb12-lab-10d.lab.lan 6.13.0-rc6-amd64 #0 SMP PREEMPT_DYNAMIC Mon 
Jan  6 18:14:07 CET 2025 x86_64 GNU/Linux

18:39:29 root@deb12-lab-10d:~# losetup
NAME          SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                    
    DIO LOG-SEC
/dev/loop2046         0      0         0  0 
/mnt/FBX24T/FS-LAN/bckcrypt2046   1    4096

18:39:32 root@deb12-lab-10d:~# dmsetup ls | grep bckcrypt
bckcrypt    (254:7)

18:39:55 root@deb12-lab-10d:~# cryptsetup status bckcrypt
/dev/mapper/bckcrypt is active and is in use.
   type:    LUKS2
   cipher:  aes-xts-plain64
   keysize: 512 bits
   key location: keyring
   device:  /dev/loop2046
   loop:    /mnt/FBX24T/FS-LAN/bckcrypt2046
   sector size:  512
   offset:  32768 sectors
   size:    8589901824 sectors
   mode:    read/write

18:40:36 root@deb12-lab-10d:~# df -h | egrep 'cifs|bckcrypt'
//10.0.10.100/FBX24T      cifs        22T     13T  9,0T  60% /mnt/FBX24T
/dev/mapper/bckcrypt      btrfs      4,0T    3,3T  779G  82% 
/mnt/bckcrypt


09:08:44 root@deb12-lab-10d:~# LANG=en_US.UTF-8
09:08:46 root@deb12-lab-10d:~# dd if=/dev/zero 
of=/mnt/bckcrypt/test/test.dd bs=256M count=16 oflag=direct 
status=progress
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 14 s, 302 MB/s
16+0 records in
16+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 14.2061 s, 302 MB/s



No write errors using '--direct-io=on' option of losetup with this patch 
=> writing to the back-file is more than 20x faster ...
It seems to be ok !

Let me know if something's wrong in this patch or if it can safely be 
used in production.

Again thanks everyone for help.
Nicolas



Le 2025-01-06 13:07, nicolas.baranger@3xo.fr a écrit :

> Hi David
> 
> Thanks for the job !
> I will buid Linux 6.10 and mainline with the provided change and I'm 
> comming here as soon as I get results from tests (CET working time).
> 
> Thanks again for help in this issue
> Nicolas
> 
> Le 2025-01-06 12:37, David Howells a écrit :
> 
>> Hi Nicolas,
>> 
>> Does the attached fix your problem?
>> 
>> David
>> ---
>> netfs: Fix kernel async DIO
>> 
>> Netfslib needs to be able to handle kernel-initiated asynchronous DIO 
>> that
>> is supplied with a bio_vec[] array.  Currently, because of the async 
>> flag,
>> this gets passed to netfs_extract_user_iter() which throws a warning 
>> and
>> fails because it only handles IOVEC and UBUF iterators.  This can be
>> triggered through a combination of cifs and a loopback blockdev with
>> something like:
>> 
>> mount //my/cifs/share /foo
>> dd if=/dev/zero of=/foo/m0 bs=4K count=1K
>> losetup --sector-size 4096 --direct-io=on /dev/loop2046 /foo/m0
>> echo hello >/dev/loop2046
>> 
>> This causes the following to appear in syslog:
>> 
>> WARNING: CPU: 2 PID: 109 at fs/netfs/iterator.c:50 
>> netfs_extract_user_iter+0x170/0x250 [netfs]
>> 
>> and the write to fail.
>> 
>> Fix this by removing the check in netfs_unbuffered_write_iter_locked() 
>> that
>> causes async kernel DIO writes to be handled as userspace writes.  
>> Note
>> that this change relies on the kernel caller maintaining the existence 
>> of
>> the bio_vec array (or kvec[] or folio_queue) until the op is complete.
>> 
>> Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
>> Reported by: Nicolas Baranger <nicolas.baranger@3xo.fr>
>> Closes: 
>> https://lore.kernel.org/r/fedd8a40d54b2969097ffa4507979858@3xo.fr/
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> cc: Steve French <smfrench@gmail.com>
>> cc: Jeff Layton <jlayton@kernel.org>
>> cc: netfs@lists.linux.dev
>> cc: linux-cifs@vger.kernel.org
>> cc: linux-fsdevel@vger.kernel.org
>> ---
>> fs/netfs/direct_write.c |    7 ++++++-
>> 1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
>> index eded8afaa60b..42ce53cc216e 100644
>> --- a/fs/netfs/direct_write.c
>> +++ b/fs/netfs/direct_write.c
>> @@ -67,7 +67,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct 
>> kiocb *iocb, struct iov_iter *
>> * allocate a sufficiently large bvec array and may shorten the
>> * request.
>> */
>> -        if (async || user_backed_iter(iter)) {
>> +        if (user_backed_iter(iter)) {
>> n = netfs_extract_user_iter(iter, len, &wreq->buffer.iter, 0);
>> if (n < 0) {
>> ret = n;
>> @@ -77,6 +77,11 @@ ssize_t netfs_unbuffered_write_iter_locked(struct 
>> kiocb *iocb, struct iov_iter *
>> wreq->direct_bv_count = n;
>> wreq->direct_bv_unpin = iov_iter_extract_will_pin(iter);
>> } else {
>> +            /* If this is a kernel-generated async DIO request,
>> +             * assume that any resources the iterator points to
>> +             * (eg. a bio_vec array) will persist till the end of
>> +             * the op.
>> +             */
>> wreq->buffer.iter = *iter;
>> }
>> }

