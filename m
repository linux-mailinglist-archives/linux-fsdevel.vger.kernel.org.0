Return-Path: <linux-fsdevel+bounces-56097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80835B12FB8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 15:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B804C16DF7E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 13:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F96215F6C;
	Sun, 27 Jul 2025 13:28:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3361DA55;
	Sun, 27 Jul 2025 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753622909; cv=none; b=h4xC2GDjEGRlu3nqIgq/luHMCFgrqgGf41r8VYqQKG0wJdNuhCy5Eqyyq+0EOIxODPwAXE9jWa3oUtLu0NUqRAsU9kPat9kj+FRjQwREEeNHQPKHmAO2ysZledaeBuGYW1Mc0jwzJ0+M3NSsoiNtTGbdNnLUwPO3B8tS29hYH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753622909; c=relaxed/simple;
	bh=++Ww4R35e0OnlKhr3IBadsdolMZqf2v/oZK/kqbOdV0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EpqPB2P12JtSBLbm4JxslxVc++o2l/ar7FFiC5EwUF3kn/8cFzBkqluiiSqsJ5rOnbbbsYzeFnacrQlM30M1juNOzBjWhWCba+8euOHjGGabrRJny9yd0ZY+vyI1mqu7Sn837QoRFami0dfVgjgaX9nz1hevGa13yALiyBSJDQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56RDRleX082767;
	Sun, 27 Jul 2025 22:27:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56RDRlLm082764
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 27 Jul 2025 22:27:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a8f8da77-f099-499b-98e0-39ed159b6a2d@I-love.SAKURA.ne.jp>
Date: Sun, 27 Jul 2025 22:27:44 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "willy@infradead.org" <willy@infradead.org>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
 <b601d17a38a335afbe1398fc7248e4ec878cc1c6.camel@ibm.com>
 <38d8f48e-47c3-4d67-9caa-498f3b47004f@I-love.SAKURA.ne.jp>
 <aH-SbYUKE1Ydb-tJ@casper.infradead.org>
 <8333cf5e-a9cc-4b56-8b06-9b55b95e97db@I-love.SAKURA.ne.jp>
 <aH-enGSS7zWq0jFf@casper.infradead.org>
 <9ac7574508df0f96d220cc9c2f51d3192ffff568.camel@ibm.com>
 <65009dff-dd9d-4c99-aa53-5e87e2777017@I-love.SAKURA.ne.jp>
 <e00cff7b-3e87-4522-957f-996cb8ed5b41@I-love.SAKURA.ne.jp>
 <c99951ae12dc1f5a51b1f6c82bbf7b61b2f12e02.camel@ibm.com>
 <9a18338da59460bd5c95605d8b10f895a0b7dbb8.camel@ibm.com>
 <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
 <5ef2e2838b0d07d3f05edd2a2a169e7647782de5.camel@ibm.com>
 <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
 <d4abeee2-e291-4da4-9e0e-7880a9c213e3@I-love.SAKURA.ne.jp>
 <da34b1af424c855519b3e926c7bc891a338c327c.camel@ibm.com>
 <971671b3-fa79-4ac1-8929-e578c8fcb32e@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <971671b3-fa79-4ac1-8929-e578c8fcb32e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav201.rs.sakura.ne.jp

On 2025/07/26 7:25, Tetsuo Handa wrote:
> On 2025/07/26 2:45, Viacheslav Dubeyko wrote:
>> If we manage the inode IDs properly in hfs_read_inode(), then hfs_write_inode()
>> never will receive the invalid inode ID. I don't see the point to remove the
>> BUG() in hfs_write_inode().
> 
> As long as we don't check that rec.dir.DirID is HFS_ROOT_CNID at hfs_fill_super(), 
> hfs_write_inode() shall receive the invalid inode ID upon unmount operation.
> 

Here is the steps to confirm.

$ wget -O hfs.c 'https://syzkaller.appspot.com/text?tag=ReproC&x=111450f0580000'
$ patch -lp1 << "EOF"
--- a/hfs.c
+++ b/hfs.c
@@ -34,6 +34,7 @@
 #endif

 static unsigned long long procid;
+static unsigned int dirid;

 static void sleep_ms(uint64_t ms)
 {
@@ -437,6 +438,7 @@
       goto error_close_loop;
     }
   }
+  pwrite(memfd, &dirid, sizeof(dirid), 4096 + 548);
   close(memfd);
   *loopfd_p = loopfd;
   return 0;
@@ -669,8 +671,10 @@
   syz_mount_image(/*fs=*/0, /*dir=*/0x200000002080, /*flags=*/0, /*opts=*/0,
                   /*chdir=*/0, /*size=*/0, /*img=*/0);
 }
-int main(void)
+int main(int argc, char *argv[])
 {
+  if (argc == 2)
+    dirid = (atoi(argv[1]) & 15) * 0x1000000;
   syscall(__NR_mmap, /*addr=*/0x1ffffffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
           /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul,
           /*fd=*/(intptr_t)-1, /*offset=*/0ul);
EOF
$ gcc -Wall -O2 -o hfs hfs.c
# timeout 1 unshare -m ./hfs 1


