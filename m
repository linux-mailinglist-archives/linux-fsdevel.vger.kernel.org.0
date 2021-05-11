Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2947137AD1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 19:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhEKRaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 13:30:05 -0400
Received: from sandeen.net ([63.231.237.45]:59188 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhEKRaF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 13:30:05 -0400
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 690985286FD;
        Tue, 11 May 2021 12:28:40 -0500 (CDT)
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
From:   Eric Sandeen <sandeen@sandeen.net>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        Pavel Reichl <preichl@redhat.com>
Subject: problem with exfat on 4k logical sector devices
Message-ID: <372ffd94-d1a2-04d6-ac38-a9b61484693d@sandeen.net>
Date:   Tue, 11 May 2021 12:28:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Namjae - 

It seems that exfat is unhappy on 4k logical sector size devices:

[root@big18 exfatprogs]# modprobe scsi_debug sector_size=4096 dev_size_mb=256
[root@big18 exfatprogs]# dmesg | tail -n 1
[933449.931608] sd 16:0:0:0: [sdh] Attached SCSI disk
[root@big18 exfatprogs]# mkfs.exfat /dev/sdh
exfatprogs version : 1.0.4
Creating exFAT filesystem(/dev/sdh, cluster size=4096)

Writing volume boot record: done
Writing backup volume boot record: done
Fat table creation: done
Allocation bitmap creation: done
Upcase table creation: done
Writing root directory entry: done
Synchronizing...

exFAT format complete!

[root@big18 exfatprogs]# fsck.exfat /dev/sdh
exfatprogs version : 1.0.4
checksums of boot sector are not correct. 0x44e6c5, but expected 0xda55694. Fix (y/N)? n

[root@big18 exfatprogs]# mount /dev/sdh /mnt/test
mount: /mnt/test: wrong fs type, bad option, bad superblock on /dev/sdh, missing codepage or helper program, or other error.
[root@big18 exfatprogs]# dmesg
<...>
[933485.685102] exFAT-fs (sdh): Invalid exboot-signature(sector = 1): 0x00000000
[933485.686134] exFAT-fs (sdh): Invalid exboot-signature(sector = 2): 0x00000000
[933485.687173] exFAT-fs (sdh): Invalid exboot-signature(sector = 3): 0x00000000
[933485.688209] exFAT-fs (sdh): Invalid exboot-signature(sector = 4): 0x00000000
[933485.689247] exFAT-fs (sdh): Invalid exboot-signature(sector = 5): 0x00000000
[933485.690283] exFAT-fs (sdh): Invalid exboot-signature(sector = 6): 0x00000000
[933485.691318] exFAT-fs (sdh): Invalid exboot-signature(sector = 7): 0x00000000
[933485.692352] exFAT-fs (sdh): Invalid exboot-signature(sector = 8): 0x00000000
[933485.695450] exFAT-fs (sdh): Invalid boot checksum (boot checksum : 0x0044e6c5, checksum : 0x04653cbf)
[933485.695452] exFAT-fs (sdh): invalid boot region
[933485.695453] exFAT-fs (sdh): failed to recognize exfat type

I think the primary problem here is that the boot sector disk structures are always 512 bytes, even if the underlying disk sectors are 4k. There is a mismatch between mkfs, fsck, and the kernel in this respect. mkfs calculates checksums using 512 bytes for all but the OEM and reserved sectors, where it uses sector_size instead (which may be 4k)

3 mkfs/mkfs.c    exfat_write_boot_sector            129 boot_calc_checksum((unsigned char *)ppbr, sizeof(struct pbr),
4 mkfs/mkfs.c    exfat_write_extended_boot_sectors  155 boot_calc_checksum((unsigned char *) &eb, sizeof(struct exbs),
5 mkfs/mkfs.c    exfat_write_oem_sector             184 boot_calc_checksum((unsigned char *)oem, bd->sector_size, false,
6 mkfs/mkfs.c    exfat_write_oem_sector             196 boot_calc_checksum((unsigned char *)oem, bd->sector_size, false,

but fsck uses the disk sector size (4k) for everything, so there is a checksum mismatch and failure.

exfat_update_boot_checksum()
...
        int sector_size = bd->sector_size;
...
                boot_calc_checksum(buf, sector_size, is_boot_sec,
                        &checksum);

The kernel has similar problems at mount time.

(the kernel also has an issue where exfat_verify_boot_region is looking at 4 bytes from the end of the sector for EXBOOT_SIGNATURE, rather than 4 bytes from the end of the boot_sector.  Also, s_blocksize_bits never gets set...)

Anyway, this can all be fixed, but first there is a question about what is proper:

For these 11 regions (main boot sector, main extended boot sectors, OEM, and reserved, I think?) should the checksums be calculated on the full sector size (possibly 4k) or 512, or is it calculated on 512 (structure size) for all but the OEM sector as mkfs does? It's not clear to me from a quick read of the spec.

(But from the example at https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification#figure-1-boot-checksum-computation it almost looks like the checksum calculation should cover the entire 4k for all these regions, even if the disk structure itself is smaller?)

Thanks,
-Eric
