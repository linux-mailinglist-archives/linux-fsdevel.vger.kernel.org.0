Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3B12A1766
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 13:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgJaMiH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 08:38:07 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17158 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbgJaMiH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 08:38:07 -0400
X-Greylist: delayed 927 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Oct 2020 08:37:54 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1604146927; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=dTZK8g3cHmAUtfBhL/NIyJI5HJt0UCL+mtSZighO/h8H7W0aoEWumlVoLuLvnWkPhffLu+CBNAqOQHYn/XLAX/EyNCeCYI8tlKuUA7YKsEw0OS8xNOd5VPIGL3PKebuMAZnF0jtjtnkelnS2Hrd6YPxl1vYZhi6ZkOYQ6RGysaM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1604146927; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=C5XnXM/OxJFsNz5G1Y6UpizDhfR6dVUaM+f4PfZiVf4=; 
        b=NyB9Zb2FPt86obRAOdQoq8sbAOXJgaaSSJD21kMMQZw1/og2zfcRatWfBBGWthFuYMJ5IMN4TJIKLQdlcCZvmFWNHUiSGEBz/FBHVGRYKkfUnRecVenKYhEfQcELo+AMW7ERQWbbPHZzITJ7jTGOCoCVPhBhf1f+QdSr5Fvv79w=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604146927;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=C5XnXM/OxJFsNz5G1Y6UpizDhfR6dVUaM+f4PfZiVf4=;
        b=VlTlJfLUq+Z4duaLKisIFyP5PX7qbxf1HAnGieRpwbJHEKO/rj7BeNAml0W/wg19
        yKhE7F4AW+GPoIcsYL+1ajLnHVfMvLl/H9MKDVTXLGBrdn1lcy2KnxTVQOhxexQpMpM
        27BfBRVVdDg/MrzZgefZLYNeFvbkMqaXhnUc7mCY=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1604146925789404.7192684957482; Sat, 31 Oct 2020 20:22:05 +0800 (CST)
Date:   Sat, 31 Oct 2020 20:22:05 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Message-ID: <1757e9b90db.10c024288229.900734846219816716@mykernel.net>
In-Reply-To: <CAJfpegu-bn2BjkLaykk-gZLRv71n=PgrsrwBnuAav1GHzWO5iQ@mail.gmail.com>
References: <20201025034117.4918-1-cgxu519@mykernel.net> <CAJfpegu-bn2BjkLaykk-gZLRv71n=PgrsrwBnuAav1GHzWO5iQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/8] implement containerized syncfs for overlayfs
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2020-10-30 23:46:00 Miklos Sze=
redi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 > On Sun, Oct 25, 2020 at 4:42 AM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
 > >
 > > Current syncfs(2) syscall on overlayfs just calls sync_filesystem()
 > > on upper_sb to synchronize whole dirty inodes in upper filesystem
 > > regardless of the overlay ownership of the inode. In the use case of
 > > container, when multiple containers using the same underlying upper
 > > filesystem, it has some shortcomings as below.
 > >
 > > (1) Performance
 > > Synchronization is probably heavy because it actually syncs unnecessar=
y
 > > inodes for target overlayfs.
 > >
 > > (2) Interference
 > > Unplanned synchronization will probably impact IO performance of
 > > unrelated container processes on the other overlayfs.
 > >
 > > This series try to implement containerized syncfs for overlayfs so tha=
t
 > > only sync target dirty upper inodes which are belong to specific overl=
ayfs
 > > instance. By doing this, it is able to reduce cost of synchronization =
and
 > > will not seriously impact IO performance of unrelated processes.
 >=20
 > Series looks good at first glance.  Still need to do an in-depth review.
 >=20
 > In the meantime can you post some numbers showing the performance improv=
ements?
 >=20

Actually, the performance improvement depends on workload and the number of=
 overlay instances.

I did a very simple test on my dev box (intel NUC ) and the result seems qu=
ite obvious.

I made two overlay instances and untar a kernel source to an overlay then c=
ompare

umount time(sys part) of two instances.=20

------------------------------------------
test env:
Intel(R) Core(TM) i7-8809G CPU @ 3.10GHz  8core
32GB memory
Samsung NVMe SSD 970 pro

test script:

[root@localhost ovl]# cat do.sh
#!/bin/sh

rm -rf upper/* &> /dev/null
echo 3 > /proc/sys/vm/drop_caches

mount -t overlay overlay -o lowerdir=3Dlower,workdir=3Dwork,upperdir=3Duppe=
r merged
mount -t overlay overlay -o lowerdir=3Dlower2,workdir=3Dwork2,upperdir=3Dup=
per2 merged2

tar Jxvf linux-5.9.tar.xz -C merged &> /dev/null

time umount merged2
time umount merged

---------------------------------
test result:

[root@localhost ovl]# seq 3 | while read line ; do sh -x do.sh ; done
+ rm -rf upper/linux-5.9
+ echo 3
+ mount -t overlay overlay -o lowerdir=3Dlower,workdir=3Dwork,upperdir=3Dup=
per merged
+ mount -t overlay overlay -o lowerdir=3Dlower2,workdir=3Dwork2,upperdir=3D=
upper2 merged2
+ tar Jxvf linux-5.9.tar.xz -C merged
+ umount merged2

real    0m0.437s
user    0m0.001s
sys     0m0.001s
+ umount merged

real    0m2.107s
user    0m0.002s
sys     0m0.090s
+ rm -rf upper/linux-5.9
+ echo 3
+ mount -t overlay overlay -o lowerdir=3Dlower,workdir=3Dwork,upperdir=3Dup=
per merged
+ mount -t overlay overlay -o lowerdir=3Dlower2,workdir=3Dwork2,upperdir=3D=
upper2 merged2
+ tar Jxvf linux-5.9.tar.xz -C merged
+ umount merged2

real    0m0.443s
user    0m0.002s
sys     0m0.001s
+ umount merged

real    0m2.032s
user    0m0.001s
sys     0m0.105s
+ rm -rf upper/linux-5.9
+ echo 3
+ mount -t overlay overlay -o lowerdir=3Dlower,workdir=3Dwork,upperdir=3Dup=
per merged
+ mount -t overlay overlay -o lowerdir=3Dlower2,workdir=3Dwork2,upperdir=3D=
upper2 merged2
+ tar Jxvf linux-5.9.tar.xz -C merged
+ umount merged2

real    0m0.263s
user    0m0.001s
sys     0m0.001s
+ umount merged

real    0m2.094s
user    0m0.000s
sys     0m0.083s
[root@localhost o




Thanks,
Chengguang

