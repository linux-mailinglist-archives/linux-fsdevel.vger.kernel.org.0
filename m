Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3057C95AC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 11:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfHTJQ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 05:16:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfHTJQ4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:16:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43C8830A0188;
        Tue, 20 Aug 2019 09:16:55 +0000 (UTC)
Received: from localhost (ovpn-117-123.ams2.redhat.com [10.36.117.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 224591D2;
        Tue, 20 Aug 2019 09:16:51 +0000 (UTC)
Date:   Tue, 20 Aug 2019 10:16:50 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     wangyan <wangyan122@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>, mszeredi@redhat.com
Subject: Re: [Virtio-fs] [QUESTION] A performance problem for buffer write
 compared with 9p
Message-ID: <20190820091650.GE9855@stefanha-x1.localdomain>
References: <5abd7616-5351-761c-0c14-21d511251006@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline
In-Reply-To: <5abd7616-5351-761c-0c14-21d511251006@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 20 Aug 2019 09:16:55 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2019 at 08:30:43AM +0800, wangyan wrote:
> Hi all,
>=20
> I met a performance problem when I tested buffer write compared with 9p.

CCing Miklos, FUSE maintainer, since this is mostly a FUSE file system
writeback question.

>=20
> Guest configuration:
>     Kernel: https://github.com/rhvgoyal/linux/tree/virtio-fs-dev-5.1
>     2vCPU
>     8GB RAM
> Host configuration:
>     Intel(R) Xeon(R) CPU E5-2620 v2 @ 2.10GHz
>     128GB RAM
>     Linux 3.10.0
>     Qemu: https://gitlab.com/virtio-fs/qemu/tree/virtio-fs-dev
>     EXT4 + ramdisk for shared folder
>=20
> ------------------------------------------------------------------------
>=20
> For virtiofs:
> virtiofsd cmd:
>     ./virtiofsd -o vhost_user_socket=3D/tmp/vhostqemu -o source=3D/mnt/sh=
are/ -o
> cache=3Dalways -o writeback
> mount cmd:
>     mount -t virtio_fs myfs /mnt/virtiofs -o
> rootmode=3D040000,user_id=3D0,group_id=3D0
>=20
> For 9p:
> mount cmd:
>     mount -t 9p -o
> trans=3Dvirtio,version=3D9p2000.L,rw,dirsync,nodev,msize=3D1000000000,cac=
he=3Dfscache
> sharedir /mnt/virtiofs/
>=20
> ------------------------------------------------------------------------
>=20
> Compared with 9p, the test result:
> 1. Latency
>     Test model=EF=BC=9A
>         fio -filename=3D/mnt/virtiofs/test -rw=3Dwrite -bs=3D4K -size=3D1G
> -iodepth=3D1 \
>             -ioengine=3Dpsync -numjobs=3D1 -group_reporting -name=3D4K -t=
ime_based
> -runtime=3D30
>=20
>     virtiofs: avg-lat is 6.37 usec
>         4K: (g=3D0): rw=3Dwrite, bs=3D4K-4K/4K-4K/4K-4K, ioengine=3Dpsync=
, iodepth=3D1
>         fio-2.13
>         Starting 1 process
>         Jobs: 1 (f=3D1): [W(1)] [100.0% done] [0KB/471.9MB/0KB /s] [0/121=
K/0
> iops] [eta 00m:00s]
>         4K: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D5558: Fri Aug  9 09:=
21:13 2019
>           write: io=3D13758MB, bw=3D469576KB/s, iops=3D117394, runt=3D 30=
001msec
>             clat (usec): min=3D2, max=3D10316, avg=3D 5.75, stdev=3D81.80
>              lat (usec): min=3D3, max=3D10317, avg=3D 6.37, stdev=3D81.80
>=20
>     9p: avg-lat is 3.94 usec
>         4K: (g=3D0): rw=3Dwrite, bs=3D4K-4K/4K-4K/4K-4K, ioengine=3Dpsync=
, iodepth=3D1
>         fio-2.13
>         Starting 1 process
>         Jobs: 1 (f=3D1): [W(1)] [100.0% done] [0KB/634.2MB/0KB /s] [0/162=
K/0
> iops] [eta 00m:00s]
>         4K: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D5873: Fri Aug  9 09:=
53:46 2019
>           write: io=3D19700MB, bw=3D672414KB/s, iops=3D168103, runt=3D 30=
001msec
>             clat (usec): min=3D2, max=3D632, avg=3D 3.34, stdev=3D 3.77
>              lat (usec): min=3D2, max=3D633, avg=3D 3.94, stdev=3D 3.82
>=20
>=20
> 2. Bandwidth
>     Test model:
>         fio -filename=3D/mnt/virtiofs/test -rw=3Dwrite -bs=3D1M -size=3D1G
> -iodepth=3D1 \
>             -ioengine=3Dpsync -numjobs=3D1 -group_reporting -name=3D1M -t=
ime_based
> -runtime=3D30
>=20
>     virtiofs: bandwidth is 718961KB/s
>         1M: (g=3D0): rw=3Dwrite, bs=3D1M-1M/1M-1M/1M-1M, ioengine=3Dpsync=
, iodepth=3D1
>         fio-2.13
>         Starting 1 process
>         Jobs: 1 (f=3D1): [W(1)] [100.0% done] [0KB/753.8MB/0KB /s] [0/753=
/0
> iops] [eta 00m:00s]
>         1M: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D5648: Fri Aug  9 09:=
24:36 2019
>             write: io=3D21064MB, bw=3D718961KB/s, iops=3D702, runt=3D 300=
01msec
>              clat (usec): min=3D390, max=3D11127, avg=3D1361.41, stdev=3D=
1551.50
>               lat (usec): min=3D432, max=3D11170, avg=3D1414.72, stdev=3D=
1553.28
>=20
>     9p: bandwidth is 2305.5MB/s
>         1M: (g=3D0): rw=3Dwrite, bs=3D1M-1M/1M-1M/1M-1M, ioengine=3Dpsync=
, iodepth=3D1
>         fio-2.13
>         Starting 1 process
>         Jobs: 1 (f=3D1): [W(1)] [100.0% done] [0KB/2406MB/0KB /s] [0/2406=
/0
> iops] [eta 00m:00s]
>         1M: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D5907: Fri Aug  9 09:=
55:14 2019
>           write: io=3D69166MB, bw=3D2305.5MB/s, iops=3D2305, runt=3D 3000=
1msec
>             clat (usec): min=3D287, max=3D17678, avg=3D352.00, stdev=3D50=
3.43
>              lat (usec): min=3D330, max=3D17721, avg=3D402.76, stdev=3D50=
3.41
>=20
> 9p has a lower latency and higher bandwidth than virtiofs.
>=20
> ------------------------------------------------------------------------
>=20
>=20
> I found that the judgement statement 'if (!TestSetPageDirty(page))' always
> true in function '__set_page_dirty_nobuffers', it will waste much time
> to mark inode dirty, no one page is dirty when write it the second time.
> The buffer write stack:
>     fuse_file_write_iter
>       ->fuse_cache_write_iter
>         ->generic_file_write_iter
>           ->__generic_file_write_iter
>             ->generic_perform_write
>               ->fuse_write_end
>                 ->set_page_dirty
>                   ->__set_page_dirty_nobuffers
>=20
> The reason for 'if (!TestSetPageDirty(page))' always true may be the pdfl=
ush
> process will clean the page's dirty flags in clear_page_dirty_for_io(),
> and call fuse_writepages_send() to flush all pages to the disk of the hos=
t.
> So when the page is written the second time, it always not dirty.
> The pdflush stack for fuse:
>     pdflush
>       ->...
>         ->do_writepages
>           ->fuse_writepages
>             ->write_cache_pages         // will clear all page's dirty fl=
ags
>               ->clear_page_dirty_for_io // clear page's dirty flags
>             ->fuse_writepages_send      // write all pages to the host, b=
ut
> don't wait the result
> Why not wait for getting the result of writing back pages to the host
> before cleaning all page's dirty flags?
>=20
> As for 9p, pdflush will call clear_page_dirty_for_io() to clean the page's
> dirty flags. Then call p9_client_write() to write the page to the host,
> waiting for the result, and then flush the next page. In this case, buffer
> write of 9p will hit the dirty page many times before it is being write
> back to the host by pdflush process.
> The pdflush stack for 9p:
>     pdflush
>       ->...
>         ->do_writepages
>           ->generic_writepages
>             ->write_cache_pages
>               ->clear_page_dirty_for_io // clear page's dirty flags
>               ->__writepage
>                 ->v9fs_vfs_writepage
>                   ->v9fs_vfs_writepage_locked
>                     ->p9_client_write   // it will get the writing back
> page's result
>=20
>=20
> According to the test result, is the handling method of 9p for page writi=
ng
> back more reasonable than virtiofs?
>=20
> Thanks,
> Yan Wang
>=20
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1buoIACgkQnKSrs4Gr
c8jWqggAiKTazBsZGkUXZAbi8fbS7WSQrSGR+Fg+7EcRZfghcJCALIXtFe70W6L3
dHZYDEc0t/eO8SU5ZpmpXfr3hAZUomJg03VLtHDF7vEfYuoBOyDRcUayp92PvP0H
JwG2hOEjnbV1ryvJfQmczWKEpk8hXK8zw/u4tdc9Dd3saqIUE1eFitDAqZdloiPB
7LYICR7zDuR7B7QA0WS1A6xVGIYkP+HcSD7MDZQzs5ifN9Az2GIIjPUWyaV0B12h
5UqytPJn0uqxnn9moKGiVybzrFMzeTvZPPm1EP3Py/6J6oHZ7+/hSCxMbHVtkf9K
4Oshfphar41lnhwBywZtYhwDzkXYnQ==
=FuXv
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
