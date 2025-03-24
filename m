Return-Path: <linux-fsdevel+bounces-44860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A1DA6D869
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 11:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4121E16BB8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 10:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7327525DCFC;
	Mon, 24 Mar 2025 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b="t0tM5kh+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0049325DCE0;
	Mon, 24 Mar 2025 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.129.21.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742812815; cv=none; b=b7jH36No4qRE7xQKQDZEoO67X+48uIWy7WklZCB8uyESIIhaCxAV0PqJe7te/mt2qnJClUq+Kc9ajPZkyeYXqBr7lrISkOCtdXPjam6Tzo+GonPOKK1i9EMqi4m+DMK1YdU9nLGCikQGs/L9vtObvSrhaGBWFHBjh/M9PNJB5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742812815; c=relaxed/simple;
	bh=3zyKTjQs/OB6iAaRE9Ife3b39lro/KTj1mbHsGu+BpE=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=Gl+qaG4Ch0hMqVBvYl2RhOADEJSPNh1EDJyEWvU1ddH0ZOMS+edUqseLkiUBnsiIdTip5u9KfnNo/TV5bgF6W/ON1tUoCru8ivyr4jH+ugmoqVMdYcRi+w5tyOs0WKEiGwG8ThhYHo7JKEMr1PGb8vKKleW+6k/KBy0q5GA3OIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr; spf=pass smtp.mailfrom=3xo.fr; dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b=t0tM5kh+; arc=none smtp.client-ip=212.129.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xo.fr
Received: from localhost (mail.3xo.fr [212.129.21.66])
	by mail.3xo.fr (Postfix) with ESMTP id 0AA44CB;
	Mon, 24 Mar 2025 11:40:11 +0100 (CET)
X-Virus-Scanned: Debian amavis at nxo2.3xo.fr
Received: from mail.3xo.fr ([212.129.21.66])
 by localhost (mail.3xo.fr [212.129.21.66]) (amavis, port 10024) with ESMTP
 id TBIROaVj1m-o; Mon, 24 Mar 2025 11:40:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.3xo.fr D5CA58D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xo.fr; s=3xo;
	t=1742812809; bh=jAatwW99hb+aFvtznLhiTkgdJUYkBUYSrPmdAagNwv4=;
	h=Date:From:To:Cc:Subject:From;
	b=t0tM5kh+dyxp1nOdT4I36YGQhcvMEji0z1wKVUhoV8ZgT3XY2AefeXQR6w3p4uOuq
	 FGI9P5WaYWOIXoMAfFPnlSvHnfHW8WuNjDkGzvXQtru+BvUmdGua3sylaUQoJc9nH/
	 KfNrn7lSqcyufMa/Q7tASGsjzR7uVrplbD3COYW5m28PLoMstMnm7/o9+sQGU9s9T+
	 Yx1Vxk+Ui7cX3TDv3SJy4jq8UQakoa9OUy1dXaytteJODDaM6hZl5iTc/lwq6Hv4HC
	 7GA+UXS4t+a+Tpbw6pE1t5NIfa+93Gt4IoEEHtn8ahvNJB0ctu6FaDncQBu+siWe8Q
	 Q4UYS7wn/xEzA==
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.3xo.fr (Postfix) with ESMTPSA id D5CA58D;
	Mon, 24 Mar 2025 11:40:08 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Mar 2025 11:40:08 +0100
From: Nicolas Baranger <nicolas.baranger@3xo.fr>
To: Christoph Hellwig <hch@infradead.org>, David Howells
 <dhowells@redhat.com>, netfs@lists.linux.dev, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Steve French <smfrench@gmail.com>, Jeff Layton <jlayton@kernel.org>,
 Christian Brauner <brauner@kernel.org>
Subject: [netfs/cifs - Linux 6.14] loop on file cat + file copy when files are
 on CIFS share
Message-ID: <10bec2430ed4df68bde10ed95295d093@3xo.fr>
X-Sender: nicolas.baranger@3xo.fr
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph, David

Sorry my last mail didn't arrive at the top of the list so I resend it 
with a new title

I don't know if it had already been reported but after building Linux 
6.14-rc1 I constat the following behaviour:

'cat' command is going on a loop when I cat a file which reside on cifs 
share

And so 'cp' command does the same: it copy the content of a file on cifs 
share and loop writing it to the destination
I did test with a file named 'toto' and containing only ascii string 
'toto'.

When I started copying it from cifs share to local filesystem, I had to 
CTRL+C the copy of this 5 bytes file after some time because the 
destination file was using all the filesystem free space and containing 
billions of 'toto' lines

Here is an example with cat:

CIFS SHARE is mounted as /mnt/fbx/FBX-24T

CIFS mount options:
grep cifs /proc/mounts
//10.0.10.100/FBX24T /mnt/fbx/FBX-24T cifs 
rw,nosuid,nodev,noexec,relatime,vers=3.1.1,cache=none,upcall_target=app,username=fbx,domain=HOMELAN,uid=0,noforceuid,gid=0,noforcegid,addr=10.0.10.100,file_mode=0666,dir_mode=0755,iocharset=utf8,soft,nounix,serverino,mapposix,mfsymlinks,reparse=nfs,nativesocket,symlink=mfsymlinks,rsize=65536,wsize=65536,bsize=16777216,retrans=1,echo_interval=60,actimeo=1,closetimeo=1 
0 0

KERNEL: uname -a
Linux 14RV-SERVER.14rv.lan 6.14.0.1-ast-rc2-amd64 #0 SMP PREEMPT_DYNAMIC 
Wed Feb 12 18:23:00 CET 2025 x86_64 GNU/Linux


To be reproduced:
echo toto >/mnt/fbx/FBX-24T/toto

ls -l /mnt/fbx/FBX-24T/toto
-rw-rw-rw- 1 root root 5 20 mars  09:20 /mnt/fbx/FBX-24T/toto

cat /mnt/fbx/FBX-24T/toto
toto
toto
toto
toto
toto
toto
toto
^C

strace cat /mnt/fbx/FBX-24T/toto
execve("/usr/bin/cat", ["cat", "/mnt/fbx/FBX-24T/toto"], 0x7ffc39b41848 
/* 19 vars */) = 0
brk(NULL)                               = 0x55755b1c1000
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7f55f95d6000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (Aucun fichier ou 
dossier de ce type)
openat(AT_FDCWD, "glibc-hwcaps/x86-64-v3/libc.so.6", O_RDONLY|O_CLOEXEC) 
= -1 ENOENT (Aucun fichier ou dossier de ce type)
openat(AT_FDCWD, "glibc-hwcaps/x86-64-v2/libc.so.6", O_RDONLY|O_CLOEXEC) 
= -1 ENOENT (Aucun fichier ou dossier de ce type)
openat(AT_FDCWD, "tls/haswell/x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = 
-1 ENOENT (Aucun fichier ou dossier de ce type)
openat(AT_FDCWD, "tls/haswell/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 
ENOENT (Aucun fichier ou dossier de ce type)
openat(AT_FDCWD, "tls/x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT 
(Aucun fichier ou dossier de ce type)
openat(AT_FDCWD, "tls/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (Aucun 
fichier ou dossier de ce type)
openat(AT_FDCWD, "haswell/x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 
ENOENT (Aucun fichier ou dossier de ce type)
openat(AT_FDCWD, "haswell/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT 
(Aucun fichier ou dossier de ce type)
openat(AT_FDCWD, "x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT 
(Aucun fichier ou dossier de ce type)
openat(AT_FDCWD, "libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (Aucun 
fichier ou dossier de ce type)
openat(AT_FDCWD, 
"/usr/local/cuda-12.6/lib64/glibc-hwcaps/x86-64-v3/libc.so.6", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (Aucun fichier ou dossier de ce type)
newfstatat(AT_FDCWD, 
"/usr/local/cuda-12.6/lib64/glibc-hwcaps/x86-64-v3", 0x7fff25937800, 0) 
= -1 ENOENT (Aucun fichier ou dossier de ce type)
openat(AT_FDCWD, 
"/usr/local/cuda-12.6/lib64/glibc-hwcaps/x86-64-v2/libc.so.6", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (Aucun fichier ou dossier de ce type)
newfstatat(AT_FDCWD, 
"/usr/local/cuda-12.6/lib64/glibc-hwcaps/x86-64-v2", 0x7fff25937800, 0) 
= -1 ENOENT (Aucun fichier ou dossier de ce type)
openat(AT_FDCWD, 
"/usr/local/cuda-12.6/lib64/tls/haswell/x86_64/libc.so.6", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (Aucun fichier ou dossier de ce type)
newfstatat(AT_FDCWD, "/usr/local/cuda-12.6/lib64/tls/haswell/x86_64", 
0x7fff25937800, 0) = -1 ENOENT (Aucun fichier ou dossier de ce type)
openat(AT_FDCWD, "/usr/local/cuda-12.6/lib64/tls/haswell/libc.so.6", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (Aucun fichier ou dossier de ce type)
newfstatat(AT_FDCWD, "/usr/local/cuda-12.6/lib64/tls/haswell", 
0x7fff25937800, 0) = -1 ENOENT (Aucun fichier ou dossier de ce type)
openat(AT_FDCWD, "/usr/local/cuda-12.6/lib64/tls/x86_64/libc.so.6", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (Aucun fichier ou dossier de ce type)
newfstatat(AT_FDCWD, "/usr/local/cuda-12.6/lib64/tls/x86_64", 
0x7fff25937800, 0) = -1 ENOENT (Aucun fichier ou dossier de ce type)
openat(AT_FDCWD, "/usr/local/cuda-12.6/lib64/tls/libc.so.6", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (Aucun fichier ou dossier de ce type)
newfstatat(AT_FDCWD, "/usr/local/cuda-12.6/lib64/tls", 0x7fff25937800, 
0) = -1 ENOENT (Aucun fichier ou dossier de ce type)
openat(AT_FDCWD, "/usr/local/cuda-12.6/lib64/haswell/x86_64/libc.so.6", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (Aucun fichier ou dossier de ce type)
newfstatat(AT_FDCWD, "/usr/local/cuda-12.6/lib64/haswell/x86_64", 
0x7fff25937800, 0) = -1 ENOENT (Aucun fichier ou dossier de ce type)
openat(AT_FDCWD, "/usr/local/cuda-12.6/lib64/haswell/libc.so.6", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (Aucun fichier ou dossier de ce type)
newfstatat(AT_FDCWD, "/usr/local/cuda-12.6/lib64/haswell", 
0x7fff25937800, 0) = -1 ENOENT (Aucun fichier ou dossier de ce type)
openat(AT_FDCWD, "/usr/local/cuda-12.6/lib64/x86_64/libc.so.6", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (Aucun fichier ou dossier de ce type)
newfstatat(AT_FDCWD, "/usr/local/cuda-12.6/lib64/x86_64", 
0x7fff25937800, 0) = -1 ENOENT (Aucun fichier ou dossier de ce type)
openat(AT_FDCWD, "/usr/local/cuda-12.6/lib64/libc.so.6", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (Aucun fichier ou dossier de ce type)
newfstatat(AT_FDCWD, "/usr/local/cuda-12.6/lib64", 
{st_mode=S_IFDIR|S_ISGID|0755, st_size=4570, ...}, 0) = 0
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
newfstatat(3, "", {st_mode=S_IFREG|0644, st_size=148466, ...}, 
AT_EMPTY_PATH) = 0
mmap(NULL, 148466, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f55f95b1000
close(3)                                = 0
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) 
= 3
read(3, 
"\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\20t\2\0\0\0\0\0"..., 
832) = 832
pread64(3, 
"\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 784, 
64) = 784
newfstatat(3, "", {st_mode=S_IFREG|0755, st_size=1922136, ...}, 
AT_EMPTY_PATH) = 0
pread64(3, 
"\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 784, 
64) = 784
mmap(NULL, 1970000, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 
0x7f55f93d0000
mmap(0x7f55f93f6000, 1396736, PROT_READ|PROT_EXEC, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x26000) = 0x7f55f93f6000
mmap(0x7f55f954b000, 339968, PROT_READ, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x17b000) = 0x7f55f954b000
mmap(0x7f55f959e000, 24576, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1ce000) = 0x7f55f959e000
mmap(0x7f55f95a4000, 53072, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f55f95a4000
close(3)                                = 0
mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0x7f55f93cd000
arch_prctl(ARCH_SET_FS, 0x7f55f93cd740) = 0
set_tid_address(0x7f55f93cda10)         = 38427
set_robust_list(0x7f55f93cda20, 24)     = 0
rseq(0x7f55f93ce060, 0x20, 0, 0x53053053) = 0
mprotect(0x7f55f959e000, 16384, PROT_READ) = 0
mprotect(0x55754475e000, 4096, PROT_READ) = 0
mprotect(0x7f55f960e000, 8192, PROT_READ) = 0
prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024, 
rlim_max=RLIM64_INFINITY}) = 0
munmap(0x7f55f95b1000, 148466)          = 0
getrandom("\x19\x6b\x9e\x55\x7e\x09\x74\x5f", 8, GRND_NONBLOCK) = 8
brk(NULL)                               = 0x55755b1c1000
brk(0x55755b1e2000)                     = 0x55755b1e2000
openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 
3
newfstatat(3, "", {st_mode=S_IFREG|0644, st_size=3048928, ...}, 
AT_EMPTY_PATH) = 0
mmap(NULL, 3048928, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f55f9000000
close(3)                                = 0
newfstatat(1, "", {st_mode=S_IFCHR|0600, st_rdev=makedev(0x88, 0), ...}, 
AT_EMPTY_PATH) = 0
openat(AT_FDCWD, "/mnt/fbx/FBX-24T/toto", O_RDONLY) = 3
newfstatat(3, "", {st_mode=S_IFREG|0666, st_size=5, ...}, AT_EMPTY_PATH) 
= 0
fadvise64(3, 0, 0, POSIX_FADV_SEQUENTIAL) = 0
mmap(NULL, 16785408, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0x7f55f7ffe000
read(3, 
"toto\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
16777216) = 16711680
write(1, 
"toto\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
16711680toto
) = 16711680
read(3, 
"toto\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
16777216) = 16711680
write(1, 
"toto\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
16711680toto
) = 16711680
read(3, 
"toto\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
16777216) = 16711680
write(1, 
"toto\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
16711680toto
) = 16711680
read(3, 
"toto\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
16777216) = 16711680
write(1, 
"toto\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
16711680toto
) = 16711680
read(3, 
"toto\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
16777216) = 16711680
write(1, 
"toto\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
16711680toto
) = 16711680
read(3, 
"toto\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
16777216) = 16711680
write(1, 
"toto\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
16711680toto
) = 16711680
read(3, 
"toto\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
16777216) = 16711680
write(1, 
"toto\n\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
16711680toto
^Cstrace: Process 38427 detached
  <detached ...>


Please let me know if it had already been fixed or reported and if 
you're able to reproduce this issue.

Thanks for help

Kind regards
Nicolas Baranger


