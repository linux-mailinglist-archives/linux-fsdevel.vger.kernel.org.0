Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAB717550A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 09:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgCBIAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 03:00:14 -0500
Received: from mail1.windriver.com ([147.11.146.13]:54755 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgCBIAO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:00:14 -0500
X-Greylist: delayed 14590 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Mar 2020 03:00:02 EST
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 0223towc025562
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 1 Mar 2020 19:55:50 -0800 (PST)
Received: from [128.224.162.175] (128.224.162.175) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sun, 1 Mar
 2020 19:55:49 -0800
To:     Christoph Hellwig <hch@lst.de>, <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>,
        <bvanassche@acm.org>, <keith.busch@intel.com>,
        <tglx@linutronix.de>, <mwilck@suse.com>, <yuyufen@huawei.com>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, He Zhe <Zhe.He@windriver.com>
From:   He Zhe <zhe.he@windriver.com>
Subject: disk revalidation updates and OOM
Message-ID: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com>
Date:   Mon, 2 Mar 2020 11:55:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.175]
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Since the following commit
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.5/disk-revalidate&id=6917d0689993f46d97d40dd66c601d0fd5b1dbdd
until now(v5.6-rc4),

If we start udisksd service of systemd(v244), systemd-udevd will scan /dev/hdc
(the cdrom device created by default in qemu(v4.2.0)). systemd-udevd will
endlessly run and cause OOM.



It works well by reverting the following series of commits.

979c690d block: move clearing bd_invalidated into check_disk_size_change
f0b870d block: remove (__)blkdev_reread_part as an exported API
142fe8f block: fix bdev_disk_changed for non-partitioned devices
a1548b6 block: move rescan_partitions to fs/block_dev.c
6917d06 block: merge invalidate_partitions into rescan_partitions



I found the number of some block events increase thousands per second.

root@qemux86:~# perf top -e block:*
9 block:block_touch_buffer
2 block:block_dirty_buffer
0 block:block_rq_requeue
307K block:block_rq_complete
174K block:block_rq_insert
174K block:block_rq_issue
0 block:block_bio_bounce
0 block:block_bio_complete
2 block:block_bio_backmerge
0 block:block_bio_frontmerge
9 block:block_bio_queue
7 block:block_getrq
0 block:block_sleeprq
4 block:block_plug
4 block:block_unplug
0 block:block_split
0 block:block_bio_remap
0 block:block_rq_remap



Here is the strace log from systemd-udevd. It repeats the following actions
endlessly.

epoll_wait(3, [{EPOLLIN, {u32=6274288, u64=6274288}}], 2, -1) = 1                                                                           
clock_gettime64(CLOCK_REALTIME, {tv_sec=1582858384, tv_nsec=264944457}) = 0                                                                 
clock_gettime64(CLOCK_MONOTONIC, {tv_sec=146, tv_nsec=493809949}) = 0                                                                       
clock_gettime64(CLOCK_BOOTTIME, {tv_sec=146, tv_nsec=502760142}) = 0                                                                        
recvmsg(14, {msg_name={sa_family=AF_NETLINK, nl_pid=-206275536, nl_groups=00000000}, msg_namelen=128->12, msg_iov=[{iov_base={{len=1969383786
getrandom("\x05\xca\xeb\xf4\x3f\x01\xb8\x0f\x7c\x89\xf9\x4b\x46\x73\x9b\xd5", 16, GRND_NONBLOCK) = 16                                       
clock_gettime64(CLOCK_MONOTONIC, {tv_sec=146, tv_nsec=613235420}) = 0                                                                       
openat(AT_FDCWD, "/dev/hdc", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC) = 6                                                      
flock(6, LOCK_SH|LOCK_NB)               = 0                                                                                                 
openat(AT_FDCWD, "/sys/devices/pci0000:00/0000:00:01.1/ide1/1.0/block/hdc/uevent", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 15                     
fstat64(15, {st_mode=S_IFREG|0644, st_size=4096, ...}) = 0                                                                                  
fstat64(15, {st_mode=S_IFREG|0644, st_size=4096, ...}) = 0                                                                                  
read(15, "MAJOR=22\nMINOR=0\nDEVNAME=hdc\nDEV"..., 4096) = 42
read(15, "", 4096)                      = 0
close(15)                               = 0
openat(AT_FDCWD, "/run/udev/data/b22:0", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 15
fstat64(15, {st_mode=S_IFREG|0644, st_size=34, ...}) = 0
fstat64(15, {st_mode=S_IFREG|0644, st_size=34, ...}) = 0
read(15, "I:4680519\nE:ID_FS_TYPE=\nG:system"..., 4096) = 34
read(15, "", 4096)                      = 0
close(15)                               = 0
getrandom("\x22\xda\x6d\x9d\x97\x44\xcc\x2d\x82\x52\x00\xb4\x7b\x75\x8d\x6a", 16, GRND_NONBLOCK) = 16
openat(AT_FDCWD, "/proc/cmdline", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 15
fstat64(15, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
read(15, "root=/dev/vda rw  console=ttyS0 "..., 1024) = 118
ioctl(15, TCGETS, 0xbfb8b7ec)           = -1 ENOTTY (Inappropriate ioctl for device)
read(15, "", 1024)                      = 0
close(15)                               = 0
openat(AT_FDCWD, "/proc/cmdline", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 15
fstat64(15, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
read(15, "root=/dev/vda rw  console=ttyS0 "..., 1024) = 118
ioctl(15, TCGETS, 0xbfb8b7ec)           = -1 ENOTTY (Inappropriate ioctl for device)
read(15, "", 1024)                      = 0
close(15)                               = 0
openat(AT_FDCWD, "/", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15
openat(15, "sys", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 16
fstat64(16, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
close(15)                               = 0
openat(16, "devices", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15
fstat64(15, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(16)                               = 0
openat(15, "pci0000:00", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 16
fstat64(16, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(15)                               = 0
openat(16, "0000:00:01.1", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15
fstat64(15, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(16)                               = 0
openat(15, "ide1", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 16
fstat64(16, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(15)                               = 0
openat(16, "1.0", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15
fstat64(15, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(16)                               = 0
openat(15, "block", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 16
fstat64(16, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(15)                               = 0
close(16)                               = 0
access("/sys/devices/pci0000:00/0000:00:01.1/ide1/1.0/block/uevent", F_OK) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15
openat(15, "sys", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 16
fstat64(16, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
close(15)                               = 0
openat(16, "devices", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15
fstat64(15, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(16)                               = 0
openat(15, "pci0000:00", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 16
fstat64(16, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(15)                               = 0
openat(16, "0000:00:01.1", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15
fstat64(15, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(16)                               = 0
openat(15, "ide1", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 16
fstat64(16, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(15)                               = 0
openat(16, "1.0", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15
fstat64(15, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(16)                               = 0
close(15)                               = 0
access("/sys/devices/pci0000:00/0000:00:01.1/ide1/1.0/uevent", F_OK) = 0
openat(AT_FDCWD, "/sys/devices/pci0000:00/0000:00:01.1/ide1/1.0/uevent", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 15
fstat64(15, {st_mode=S_IFREG|0644, st_size=4096, ...}) = 0
fstat64(15, {st_mode=S_IFREG|0644, st_size=4096, ...}) = 0
read(15, "DRIVER=ide-cdrom\nMEDIA=cdrom\nDRI"..., 4096) = 64
read(15, "", 4096)                      = 0
close(15)                               = 0
readlinkat(AT_FDCWD, "/sys/devices/pci0000:00/0000:00:01.1/ide1/1.0/subsystem", "../../../../../bus/ide", 4096) = 22
openat(AT_FDCWD, "/run/udev/data/+ide:1.0", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/run/udev/data/+ide:1.0", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/run/udev/data/+ide:1.0", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/run/udev/data/+ide:1.0", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/run/udev/data/+ide:1.0", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/run/udev/data/+ide:1.0", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/run/udev/data/+ide:1.0", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15
openat(15, "sys", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 16
fstat64(16, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
close(15)                               = 0
openat(16, "devices", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15
fstat64(15, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(16)                               = 0
openat(15, "pci0000:00", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 16
fstat64(16, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(15)                               = 0
openat(16, "0000:00:01.1", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15
fstat64(15, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(16)                               = 0
openat(15, "ide1", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 16
fstat64(16, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(15)                               = 0
close(16)                               = 0
access("/sys/devices/pci0000:00/0000:00:01.1/ide1/uevent", F_OK) = 0
readlinkat(AT_FDCWD, "/sys/devices/pci0000:00/0000:00:01.1/ide1/subsystem", 0x5f5b30, 4096) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15
openat(15, "sys", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 16
fstat64(16, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
close(15)                               = 0
openat(16, "devices", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15
fstat64(15, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(16)                               = 0
openat(15, "pci0000:00", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 16
fstat64(16, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(15)                               = 0
openat(16, "0000:00:01.1", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15
fstat64(15, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(16)                               = 0
close(15)                               = 0
access("/sys/devices/pci0000:00/0000:00:01.1/uevent", F_OK) = 0
readlinkat(AT_FDCWD, "/sys/devices/pci0000:00/0000:00:01.1/subsystem", "../../../bus/pci", 4096) = 16
openat(AT_FDCWD, "/", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15
openat(15, "sys", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 16
fstat64(16, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
close(15)                               = 0
openat(16, "devices", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15
fstat64(15, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(16)                               = 0
openat(15, "pci0000:00", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 16
fstat64(16, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(15)                               = 0
close(16)                               = 0
access("/sys/devices/pci0000:00/uevent", F_OK) = 0
readlinkat(AT_FDCWD, "/sys/devices/pci0000:00/subsystem", 0x5f5b30, 4096) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15                                                                
openat(15, "sys", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 16
fstat64(16, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
close(15)                               = 0
openat(16, "devices", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15
fstat64(15, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
close(16)                               = 0
close(15)                               = 0
access("/sys/devices/uevent", F_OK)     = -1 ENOENT (No such file or directory)
readlinkat(AT_FDCWD, "/sys/devices/pci0000:00/0000:00:01.1/ide1/1.0/block/hdc/driver", 0x5f5b30, 4096) = -1 ENOENT (No such file or director)
readlinkat(AT_FDCWD, "/sys/devices/pci0000:00/0000:00:01.1/ide1/1.0/driver", "../../../../../bus/ide/drivers/i"..., 4096) = 40
readlinkat(AT_FDCWD, "/sys/devices/pci0000:00/0000:00:01.1/ide1/driver", 0x5f5b30, 4096) = -1 ENOENT (No such file or directory)
readlinkat(AT_FDCWD, "/sys/devices/pci0000:00/0000:00:01.1/driver", "../../../bus/pci/drivers/PIIX_ID"..., 4096) = 33
readlinkat(AT_FDCWD, "/sys/devices/pci0000:00/driver", 0x5f5b30, 4096) = -1 ENOENT (No such file or directory)
lstat64("/dev/hdc", {st_mode=S_IFBLK|0660, st_rdev=makedev(0x16, 0), ...}) = 0
utimensat_time64(AT_FDCWD, "/dev/hdc", NULL, 0) = 0
lstat64("/dev/block/22:0", {st_mode=S_IFLNK|0777, st_size=6, ...}) = 0
readlinkat(AT_FDCWD, "/dev/block/22:0", "../hdc", 4096) = 6
utimensat_time64(AT_FDCWD, "/dev/block/22:0", NULL, AT_SYMLINK_NOFOLLOW) = 0
stat64("/run/udev/tags/systemd", {st_mode=S_IFDIR|0755, st_size=720, ...}) = 0
openat(AT_FDCWD, "/run/udev/tags/systemd/b22:0", O_RDONLY|O_LARGEFILE|O_NOFOLLOW|O_CLOEXEC|O_PATH) = 15
fstat64(15, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
utimensat_time64(AT_FDCWD, "/proc/self/fd/15", NULL, 0) = 0
close(15)                               = 0
stat64("/run/udev/data", {st_mode=S_IFDIR|0755, st_size=4180, ...}) = 0
umask(077)                              = 022
getpid()                                = 404
clock_gettime64(CLOCK_MONOTONIC, {tv_sec=147, tv_nsec=105469823}) = 0
openat(AT_FDCWD, "/run/udev/data/.#b22:03qtXsM", O_RDWR|O_CREAT|O_EXCL|O_LARGEFILE|O_CLOEXEC, 0600) = 15
umask(022)                              = 077
fcntl64(15, F_GETFL)                    = 0x8002 (flags O_RDWR|O_LARGEFILE)
fchmod(15, 0644)                        = 0
fstat64(15, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
write(15, "I:4680519\nE:ID_FS_TYPE=\nG:system"..., 34) = 34
rename("/run/udev/data/.#b22:03qtXsM", "/run/udev/data/b22:0") = 0
close(15)                               = 0
close(6)                                = 0
sendmsg(14, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=0x000002}, msg_namelen=12, msg_iov=[{iov_base={{len=1969383788, type=0x65648
write(7, "", 0)                         = 0
epoll_wait(3, [{EPOLLIN, {u32=6274288, u64=6274288}}], 2, -1) = 1



Thanks,
Zhe
