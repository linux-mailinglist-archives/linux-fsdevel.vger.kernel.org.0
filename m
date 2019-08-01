Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB427D850
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 11:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbfHAJOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 05:14:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:37662 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726799AbfHAJOd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:14:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 245C5ACFE;
        Thu,  1 Aug 2019 09:14:31 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Sergei Turchanov <turchanov@farpost.com>
Date:   Thu, 01 Aug 2019 19:14:22 +1000
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [BUG] lseek on /proc/meminfo is broken in 4.19.59 maybe due to commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
In-Reply-To: <eab812ef-ba79-11d6-0a4e-232872f0fcc4@farpost.com>
References: <3bd775ab-9e31-c6b3-374e-7a9982a9a8cd@farpost.com> <5c4c0648-2a96-4132-9d22-91c22e7c7d4d@huawei.com> <eab812ef-ba79-11d6-0a4e-232872f0fcc4@farpost.com>
Message-ID: <877e7xl029.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01 2019, Sergei Turchanov wrote:

> Hello!
>
> [
>   As suggested in previous discussion this behavior may be caused by your
>   commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code a=
nd interface")
> ]

Yes.... I think I can see what happened.
 removing:
=2D               if (!m->count) {
=2D                       m->from =3D 0;
=2D                       m->index++;
=2D               }

from seq_read meant that ->index didn't get updated in a case that it
needs to be.

Please confirm that the following patch fixes the problem.
I think it is correct, but I need to look it over more carefully in the
morning, and see if I can explain why it is correct.

Thanks for the report.
NeilBrown

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 04f09689cd6d..1600034a929b 100644
=2D-- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -119,6 +119,7 @@ static int traverse(struct seq_file *m, loff_t offset)
 		}
 		if (seq_has_overflowed(m))
 			goto Eoverflow;
+		p =3D m->op->next(m, p, &m->index);
 		if (pos + m->count > offset) {
 			m->from =3D offset - pos;
 			m->count -=3D m->from;
@@ -126,7 +127,6 @@ static int traverse(struct seq_file *m, loff_t offset)
 		}
 		pos +=3D m->count;
 		m->count =3D 0;
=2D		p =3D m->op->next(m, p, &m->index);
 		if (pos =3D=3D offset)
 			break;
 	}


>
> Original bug report:
>
> Seeking (to an offset within file size) in /proc/meminfo is broken in 4.1=
9.59. It does seek to a desired position, but reading from that position re=
turns the remainder of file and then a whole copy of file. This doesn't hap=
pen with /proc/vmstat or /proc/self/maps for example.
>
> Seeking did work correctly in kernel 4.14.47. So it seems something broke=
 in the way.
>
> Background: this kind of access pattern (seeking to /proc/meminfo) is use=
d by libvirt-lxc fuse driver for virtualized view of /proc/meminfo. So that=
 /proc/meminfo is broken in guests when running kernel 4.19.x.
>
>  > On 01.08.2019 17:11, Gao Xiang wrote:
>> Hi,
>>
>> I just took a glance, maybe due to
>> commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code an=
d interface")
>>
>> I simply reverted it just now and it seems fine... but I haven't digged =
into this commit.
>>
>> Maybe you could Cc NeilBrown <neilb@suse.com> for some more advice and
>> I have no idea whether it's an expected behavior or not...
>>
>> Thanks,
>> Gao Xiang
>>
>> On 2019/8/1 14:16, Sergei Turchanov wrote:
>
>
> $ ./test /proc/meminfo 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Work=
s as expected
>
> MemTotal:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 394907728 kB
> MemFree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 173738328 kB
> ...
> DirectMap2M:=C2=A0=C2=A0=C2=A0 13062144 kB
> DirectMap1G:=C2=A0=C2=A0=C2=A0 390070272 kB
>
> -----------------------------------------------------------------------
>
> $ ./test /proc/meminfo 1024=C2=A0=C2=A0=C2=A0=C2=A0 # returns a copy of f=
ile after the remainder
>
> Will seek to 1024
>
>
> Data read at offset 1024
> gePages:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 kB
> ShmemHugePages:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 kB
> ShmemPmdMapped:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 kB
> HugePages_Total:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> HugePages_Free:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> HugePages_Rsvd:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> HugePages_Surp:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
> Hugepagesize:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2048 kB
> Hugetlb:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0 kB
> DirectMap4k:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 245204 kB
> DirectMap2M:=C2=A0=C2=A0=C2=A0 13062144 kB
> DirectMap1G:=C2=A0=C2=A0=C2=A0 390070272 kB
> MemTotal:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 394907728 kB
> MemFree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 173738328 kB
> MemAvailable:=C2=A0=C2=A0 379989680 kB
> Buffers:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 355812 kB
> Cached:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 207216224 kB
> ...
> DirectMap2M:=C2=A0=C2=A0=C2=A0 13062144 kB
> DirectMap1G:=C2=A0=C2=A0=C2=A0 390070272 kB
>
> As you see, after "DirectMap1G:" line, a whole copy of /proc/meminfo retu=
rned by "read".
>
> Test program:
>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <stdlib.h>
>
> #define SIZE 1024
> char buf[SIZE + 1];
>
> int main(int argc, char *argv[]) {
>  =C2=A0=C2=A0=C2=A0 int=C2=A0=C2=A0=C2=A0=C2=A0 fd;
>  =C2=A0=C2=A0=C2=A0 ssize_t rd;
>  =C2=A0=C2=A0=C2=A0 off_t=C2=A0=C2=A0 ofs =3D 0;
>
>  =C2=A0=C2=A0=C2=A0 if (argc < 2) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("Usage: test <file> [<=
offset>]\n");
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>  =C2=A0=C2=A0=C2=A0 }
>
>  =C2=A0=C2=A0=C2=A0 if (-1 =3D=3D (fd =3D open(argv[1], O_RDONLY))) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror("open failed");
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>  =C2=A0=C2=A0=C2=A0 }
>
>  =C2=A0=C2=A0=C2=A0 if (argc > 2) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofs =3D atol(argv[2]);
>  =C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0 printf("Will seek to %ld\n", ofs);
>
>  =C2=A0=C2=A0=C2=A0 if (-1 =3D=3D (lseek(fd, ofs, SEEK_SET))) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror("lseek failed");
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>  =C2=A0=C2=A0=C2=A0 }
>
>  =C2=A0=C2=A0=C2=A0 for (;; ofs +=3D rd) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("\n\nData read at offs=
et %ld\n", ofs);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (-1 =3D=3D (rd =3D read(fd=
, buf, SIZE))) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perro=
r("read failed");
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(=
1);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf[rd] =3D '\0';
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf(buf);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rd < SIZE) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0 }
>
>  =C2=A0=C2=A0=C2=A0 return 0;
> }

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl1CrW8ACgkQOeye3VZi
gblT1g/9E6hqLaqxu949VnKqTZVmJQmxEo4OzqEVf0pEOcZM5EXqZHUZRISx9Con
Yb8mX+4/09PQkZR7aGowlA6W63+PHoaN7aQrX3rZtJ08JXf4ZzYceYaeCgmSiXRa
OgJSj9+WkNnfJp8HL1TG9dLaqZCp+LZ933WCxruyUvDGzYRWTlxZrFSbOnp5vpnS
GyLnP03vC5cvAaT6JNsc+5cohZAv0WM0a/fegowm27no7a3uRtGDiJurm9QbOY50
ojujTOXjzYgAcVkHb4M+qc74qbjFSudn05mO+ruze4k5O0GXJBKLsH+FD6CF08PB
U8MWeVyGP2mSU6CBJivrAU6X5GpkiE2sqW+L1goAi8hIrLg5SXxf4FAThUpHqXKT
UJnrGsuQecNZzJbFjvGuv8xcr+T6tBxh9EVTS/4hubbmDgZB+CG+q04OPjxry+AZ
GYTj00DIWMp/SQGu5zAlA2lqiFrv0u3htY6I/C7eZ1kk9dzAZ5u+1LGHQnGnLvi9
2F1gRWkYKuZeuUywNKGcO1XuHdOdEIfYkau4fi5Xc5j7lIQxPhA+8Tm9F4CRrAgS
d/4RML9dPSvZU1uzZnYV+U7OtIDR/orMazviiqMo7pIpfmHqFtkDA3BsemKhcBEY
eUUtesbb63D7FbzFL5U6lQAH2ecZ6nRLv7mVLPZFPeawwxQRfg0=
=Yuuw
-----END PGP SIGNATURE-----
--=-=-=--
