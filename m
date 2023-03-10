Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683106B402A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 14:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCJNWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 08:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCJNV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:21:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B31BF63A8
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Mar 2023 05:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678454466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ypNWiOV0Alhdg0JRPMsX5GhgyxLmJrd3belxb2VgEk0=;
        b=erk4PAEkvJbmijKVNGEugVZUO+8Ro8s9RbZ2DRH7bejZgudX1suVD4dRKYwqTyypyU2kYs
        kOjHitwYUDuc+0X4qzQuQhRESJow56sNwBJY9wB94fcikAmvyjOgpYhrXMAWpAMZ+CdIdh
        q6XH1y6v1B996xFgwBP8jYmgXKUvwIk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-INfVIdhAN9WNf3aZLr5B6Q-1; Fri, 10 Mar 2023 08:21:03 -0500
X-MC-Unique: INfVIdhAN9WNf3aZLr5B6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF09580D0F3;
        Fri, 10 Mar 2023 13:21:02 +0000 (UTC)
Received: from ws.net.home (ovpn-192-20.brq.redhat.com [10.40.192.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3C162166B26;
        Fri, 10 Mar 2023 13:21:01 +0000 (UTC)
Date:   Fri, 10 Mar 2023 14:20:59 +0100
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.39-rc1
Message-ID: <20230310132059.qrkfp25nzpvb5ogc@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The util-linux release v2.39-rc1 is available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.39/
 
Feedback and bug reports, as always, are welcomed.
 
  Karel


util-linux 2.39 Release Notes
=============================

Release highlights
------------------

mount(8) and libmount:


 * no more supports --enable-libmount-support-mtab. Yes, classic
   writable /etc/mtab is completely dead now.


 * supports new file descriptors based mount kernel API. This change is
   very aggressive to libmount code, but hopefully, it does not introduce
   regressions in traditional mount(8) behavior. The library is still backward
   compatible with old kernels and can fall back to classic mount(2) API
   if necessary. The old mount(2) is also used for btrfs when used with SELinux
   context= mount options because the btrfs kernel driver does not support this
   use-case yet; we may see the more in-kernel issue... Use
   --disable-libmount-mountfd-support to disable this feature.

  * X-mount.idmap= is a new mount option to create an ID-mapped mount.
    Thanks to Christian Brauner.

  * supports a new "recursive" argument for VFS flags, for example
    "mount -o bind,ro=recursive"

  * X-mount.auto-fstypes is a new option for automatic filesystem detection to
    specify allowed or forbidden filesystem types.

  * rootcontext=@target is a new mount option to set the root SELinux context
    of the new filesystem to the current context of the target mountpoint.

  * X-mount.{owner,group,mode}= is a new mount option that takes a user, group,
    and mode and sets them on the target after mounting.

  * uses autofs mount hint to ignore autofs mount entries.


blkpr(8) is a NEW COMMAND to run persistent reservations ioctls on a device
(typically SCSI and NVMe disk).

pipesz(1) is a NEW COMMAND to set or examine pipe and FIFO buffer sizes.

waitpid(1) is a NEW COMMAND to wait for arbitrary processes.

renice(1) supports posix-compliant -n (via POSIXLY_CORRECT) and add a new
option --relative.

blockdev(8) supports BLKGETDISKSEQ ioctl now.

lsfd(1):

  * uses NAME column to show cooked file names. Refer KNAME column if you need
    raw file names that appeared in /proc/$pid/fd.

  * uses TYPE column to show cooked file type names. Refer STTYPE if you need
    raw type reported by stat(2).

  * adds ENDPOINTS column for printing the endpoints of IPCs. This version
    supports FIFO.

  * decodes flags field of /proc/$PID/fdinfo/$fd correctly

  * adds columns for pidfd
  
  * adds columns for AF_INET and AF_INET6 sockets. This version uses /proc/net/*
    files as information sources.

  * adds columns for AF_NETLINK sockets.

  * adds columns for AF_PACKET sockets.

  * supports -i, --inet options for displaying only AF_INET and/or AF_INET6
    sockets.

cal(1) can be configured to use colors by terminal-colors.d(5).

dmesg(1):

  * supports subsecond granularity for --since and --until.

  * option --level accepts '+' prefix or postfix for a level name to specify
    all higher or all lower levels.

fstrim(8) supports a new option --types to filter out by filesystem types

blkid(8) and libblkid:

  * supports bcachefs

  * reports endianness (minix, befs, cramfs, ufs, squashfs3, zfs)

  * calculates check-sums for many filesystems and RAIDs to avoid false-positive
    detections (zonefs, nvidia reail, ubi, luks, romfs, f2fs, ...)


lsblk(8):

   * --nvme and --virtio are new options to filter out devices.

   * adds columns ID (udev ID), ID-LINK (the shortest udev /dev/disk/by-id
    link name), PARTN (partition number), and MQ (device queues).

   * improves detection of hotplug and removable status.

nsenter(1) supports a new option --env for allowing environment variables
inheritance.

namei(1) supports a new option -Z to report SELinux contexts

Upstream automated builds and testing have been improved to use more distros
and architectures.

The Meson build has been massively improved.

More man pages have been translated.


Extra thanks to Masatake YAMATO for his work on lsfd(1) and to Thomas Weißschuh
for his work on many areas.


Changes between v2.38 and v2.39
-------------------------------

Add 53/002:
   - Samsung Exynos-m3  [ThomasKaiser]
BSD:
   - Use byteswap.h and endian.h defined macos when present  [Warner Losh]
CI:
   - update gcc to 12  [Thomas Weißschuh]
Rename:
   - fix empty 'from' with / in filename.  [Philip Hazelden]
TODO:
   - drop agetty LOGIN_PLAIN_PROMPT todo  [Thomas Weißschuh]
agetty:
   - add support for LOGIN_PLAIN_PROMPT  [Karel Zak]
   - always pass user name to login with --  [dana]
   - cleanup login prompt macro use  [Karel Zak]
   - don't ignore --noclear when re-print issue file  [Karel Zak]
   - fix prompt  [Karel Zak]
   - support simplified color sequences in \e{name}  [Karel Zak]
asciidoc:
   - fix typo in hwclock.8  [Enze Li]
autotools:
   - add asciidoctor-includetracker to distributed files  [Thomas Weißschuh]
   - fix build for test_loopdev  [Thomas Weißschuh]
   - show test failure diff  [Thomas Weißschuh]
   - stop using AC_C_BIGENDIAN / WORDS_BIGENDIAN  [Thomas Weißschuh]
bash-completion:
   - add --zero to rev module  [Karel Zak]
   - add blkdiscard --quiet  [Karel Zak]
   - update lsns  [Karel Zak]
blkdiscard:
   - add --quiet  [Karel Zak]
   - add extra exit code when device does not support discard  [Karel Zak]
   - sort options  [Karel Zak]
blkid:
   - add FSSIZE tag with tests for XFS  [Andrey Albershteyn]
   - add image for btrfs testing  [Andrey Albershteyn]
   - add tests for FSLASTBLOCK tag  [Andrey Albershteyn]
   - cache  add test  [Thomas Weißschuh]
   - f2fs  update testfile to include checksum  [Thomas Weißschuh]
   - swap  test big endian swapfile  [Thomas Weißschuh]
blkpr:
   - add block persistent reservations command  [zhenwei pi]
   - add descriptions for arguments  [zhenwei pi]
   - change description formatting  [Karel Zak]
   - cleanup --help output and man page  [Karel Zak]
   - cosmetic coding style changes  [Karel Zak]
   - fix extra ';' outside of a function [clang]  [Karel Zak]
   - mark data const  [Thomas Weißschuh]
   - rename operation to command  [zhenwei pi]
blkzone:
   - make alignment check for zone size generic  [Pankaj Raghav]
blockdev:
   - add support for ioctl BLKGETDISKSEQ  [Thomas Weißschuh]
build:
   - harden cibuild.yml permissions  [Alex]
   - harden cifuzz.yml permissions  [Alex]
   - harden coverity.yml permissions  [Alex]
   - propagate failures from asciidoctor  [Thomas Weißschuh]
   - track dependencies of manpage generation  [Thomas Weißschuh]
   - warn about old-style definitions  [Thomas Weißschuh]
build-sys:
   - add --disable-libmount-mountfd-support  [Karel Zak]
   - add blkpr to gitignore  [Enze Li]
   - add gnu global outputs to gitignore  [Enze Li]
   - add hint to have_pty check  [Karel Zak]
   - check for mount_attr in linux/mount.h  [Karel Zak]
   - don't call AC_SUBST() if unnecessary  [Karel Zak]
   - improve dependences for lib/procfs.c  [Karel Zak]
   - make pipesz optional  [Karel Zak]
   - move login-utils/logindefs.c to lib  [Karel Zak]
   - remove --enable-libmount-support-mtab  [Karel Zak]
   - rename libmount loopdev code file  [Karel Zak]
   - sort the gitignore and add fadvise  [Thomas Voss]
   - use PKG_CHECK_VAR()  [Karel Zak]
   - work around broken cross-compiles on Debian  [Thomas Weißschuh]
build0sys:
   - fix make dist  [Karel Zak]
c.h:
   - avoid undefined behavior in SINT_MAX macro  [Thomas Weißschuh]
   - fix compiler warning [-Werror=shift-count-overflow]  [Karel Zak]
   - really avoid undefined behavior in SINT_MAX  [Thomas Weißschuh]
cal:
   - (man) add example for colors  [Karel Zak]
   - (man) document colorscheme  [Thomas Weißschuh]
   - (man) fix -c  [Karel Zak]
   - (tests) prevent loading of custom colorschemes  [Thomas Weißschuh]
   - Update column test to show full year output in 5-column mode.  [JadingTsunami]
   - add test for vertical colors  [Thomas Weißschuh]
   - add test for vertical week color  [Thomas Weißschuh]
   - add workday and weekday colors  [Karel Zak]
   - allow to specifiy columns  [Thomas Weißschuh]
   - convert existing highlight logic to color lib  [Thomas Weißschuh]
   - fix multi-month printing.  [JadingTsunami]
   - support arbitrary amount of months per row  [Thomas Weißschuh]
   - use escape codes from color-names.h  [Thomas Weißschuh]
cfdisk:
   - prevent unused variables  [Thomas Weißschuh]
chfn:
   - use -V for version  [Karel Zak]
chrt:
   - (man) fix indention and properly mark examples  [Karel Zak]
chsh:
   - add -V, update usage()  [Karel Zak]
ci:
   - Update Differential ShellCheck GitHub Action  [Jan Macku]
   - build & test util-linux on Fedora Rawhide via Packit  [Frantisek Sumsal]
   - disable shellcheck warning for unused variables  [Thomas Weißschuh]
   - don't run make with infinite parallel jobs  [Thomas Weißschuh]
   - install dependencies from setup-ubuntu.sh  [Thomas Weißschuh]
   - packit  enable -Werror  [Thomas Weißschuh]
   - run fuzz targets on i386 as well  [Evgeny Vereshchagin]
   - run packit builds for commits on master and releases  [Thomas Weißschuh]
   - s390x  install more test dependencies  [Thomas Weißschuh]
   - update llvm to version 15  [Thomas Weißschuh]
   - update shellcheck  [Thomas Weißschuh]
   - use CodeQL instead of LGTM  [Frantisek Sumsal]
ci(lint):
   - add shell linter - Differential ShellCheck  [Jan Macku]
clang:
   - ignore -Wunused-but-set-variable  [Thomas Weißschuh]
column:
   - add --table-column  [Karel Zak]
   - add --table-maxout  [Karel Zak]
   - add -1 placeholder to address last visible column  [Karel Zak]
   - add missing help entry  [Karel Zak]
   - don't require column name for JSON  [Karel Zak]
   - fix "0" placeholder  [Karel Zak]
   - fix buffer overflow when -l specified  [Karel Zak]
   - fix greedy mode on -l  [Karel Zak]
   - fix memory use [coverity scan]  [Karel Zak]
   - implement "--output-width unlimited"  [Karel Zak]
   - improve --table-hide  [Karel Zak]
   - support negative numbers in range  [Karel Zak]
   - support ranges when addressing columns by numbers  [Karel Zak]
configure.ac:
   - Improve check for magic  [Mateusz Marciniec]
   - add lsns option  [Fabrice Fontaine]
dmesg:
   - (man) add note about subsecond support  [Karel Zak]
   - (tests) prevent loading of custom colorscheme  [Thomas Weißschuh]
   - add subsecond granularity for --since and --until  [Thomas Weißschuh]
   - add test for --since and --until  [Thomas Weißschuh]
   - allow specification of level range  [Thomas Weißschuh]
   - fix --since and --until  [Karel Zak]
   - move fallthrough comment to correct place  [Thomas Weißschuh]
   - use subsecond granularity in iso format  [Thomas Weißschuh]
doc:
   - update renice.1 for spelling and style  [Jan Engelhardt]
docs:
   - update AUTHORS file  [Karel Zak]
documentation:
   - link to HTML versions of kernel docs on docs.kernel.org  [nl6720]
eject:
   - also use sysfs_blkdev_is_removable  [Thomas Weißschuh]
   - update file provenance of DRIVER_SENSE in the comments  [Enze Li]
exitcodes:
   - add EXIT_NOTSUPP  [Thomas Weißschuh]
fadvice:
   - delete a unused struct definition  [Masatake YAMATO]
fadvise:
   - add bash-completion script  [Masatake YAMATO]
   - fix parsing of option -V  [Thomas Weißschuh]
   - new command wrapping posix_fadvise  [Masatake YAMATO]
fdisk:
   - document expected answers to quit message  [Thomas Weißschuh]
   - fix --output option parsing  [Karel Zak]
   - make it more obvious that DOS means MBR  [Karel Zak]
fileeq/lsfd:
   - use correct format specifier  [Thomas Weißschuh]
flock:
   - timeout_expired must be volatile qualified  [Cristian Rodríguez]
fsck:
   - Processes may kill other processes.  [zhanchengbin]
   - only assign to cancel_requested  [Cristian Rodríguez]
   - use sig_atomic_t type fot signal handler global vars  [Cristian Rodríguez]
fsck.cramfs:
   - check directory entry names  [Samanta Navarro]
   - fix error message  [Samanta Navarro]
   - print correct error on 32-bit systems  [Samanta Navarro]
fstrim:
   - Remove all skipped entries before de-duplication  [Scott Shambarger]
   - add --types to filter out by filesystem types  [Karel Zak]
   - check for ENOSYS when using --quiet-unsupported  [Narthorn]
git:
   - ignore m4/libtool.m4.orig  [Yegor Yefremov]
   - update .gitignore  [Karel Zak]
github:
   - call checklibdoc and checkxalloc  [Karel Zak]
hardlink:
   - (tests) do not assert amount of compared files  [Thomas Weißschuh]
   - Document '-c' option in manpage  [FeRD (Frank Dana)]
   - Fix man page docs for '-v/--verbose'  [FeRD (Frank Dana)]
   - Move -c option in --help  [FeRD (Frank Dana)]
   - Move reflink options in manpage  [FeRD (Frank Dana)]
   - Wrap -b to 80 cols, in --help  [FeRD (Frank Dana)]
   - add --respect-dir  [Karel Zak]
   - calling putchar is off-limits on a signal handler  [Cristian Rodríguez]
   - cleanup options  [Karel Zak]
   - last_signal should be a volatile sig_atomic_t  [Cristian Rodríguez]
   - print supported feature on --version  [Karel Zak]
   - require statfs_magic.h only when reflink support enabled  [Karel Zak]
   - use info rather than warning message  [Karel Zak]
hwclock:
   - fix return value on successful --param-get  [Bastian Krause]
include:
   - Add additional GPT partition types (HPPA/PARISC)  [Sam James]
   - add MOVE_MOUNT_SET_GROUP fallback  [Karel Zak]
   - add fallback for statx  [Karel Zak]
   - add missing license lines  [Karel Zak]
   - add mount-api-utils.h  [Christian Brauner]
   - cleanup close_range fallback  [Karel Zak]
   - don't use UL_NG_ prefix  [Karel Zak]
   - improve statx fallback  [Karel Zak]
include/c:
   - add functions to print from signal handlers  [Karel Zak]
   - add prefix to print_features()  [Karel Zak]
   - add print_version_with_features()  [Karel Zak]
   - add sizeof_member()  [Karel Zak]
   - make err_oom() usable everywhere  [Karel Zak]
   - remove duplicate include, improve readablity  [Karel Zak]
include/cctype:
   - add c_strcasecmp() and c_strncasecmp()  [Karel Zak]
   - fix License header  [Karel Zak]
include/fileutils:
   - remove duplicated include  [Karel Zak]
include/mount-api-utils:
   - add new syscalls  [Karel Zak]
   - cleanup  [Karel Zak]
   - fix indention  [Karel Zak]
   - use standard uint64_t  [Karel Zak]
ipc_msg_get_limits:
   - always initialize memory  [Thomas Weißschuh]
irqtop:
   - fix compiler warning [-Werror=format-truncation=]  [Karel Zak]
   - improve delta-sort stability  [Richard Allen]
   - support -C/--cpu-list  [zhenwei pi]
iso9660.h:
   - avoid undefined signed integer shift  [Thomas Weißschuh]
   - use more correct function types  [Thomas Weißschuh]
kill:
   - Support mandating the presence of a userspace signal handler  [Chris Down]
   - fix buffer overflow  [Karel Zak]
last:
   - should not use errx/warnx on signal handlers  [Cristian Rodríguez]
   - use full size of the username  [Karel Zak]
   - use sizeof_member  [Thomas Weißschuh]
ldattach:
   - fix --intro-command and --pause  [Karel Zak]
lib:
   - add crc64 implementation  [Thomas Weißschuh]
   - add sha256 implementation  [Thomas Weißschuh]
   - add xxhash implementation  [Thomas Weißschuh]
   - allow safe_getenv to work for non-root users  [Mike Gilbert]
   - pager  fix signal safety issues  [Cristian Rodríguez]
   - procfs  add parsing cmd containing newline  [Thomas Weißschuh]
   - procfs  add unittests  [Thomas Weißschuh]
   - procfs  clarify name of procfs_process_get_data_for()  [Thomas Weißschuh]
   - procfs  fix error message during test  [Thomas Weißschuh]
   - procfs  fix typo in argument specification  [Thomas Weißschuh]
   - procfs  prefix support for tests  [Thomas Weißschuh]
   - sysfs  fix typo  [Thomas Weißschuh]
   - xxhash  customize for util-linux  [Thomas Weißschuh]
lib/blkdev:
   - handle interrupted read call  [Samanta Navarro]
   - set errno in more cases  [Samanta Navarro]
   - use off_t for max values  [Samanta Navarro]
lib/canonicalize:
   - improve code readability for coverity scan  [Karel Zak]
lib/colors:
   - ensure fallback to system directory  [Thomas Weißschuh]
   - introduce color_get_disable_sequence()  [Thomas Weißschuh]
   - move colors canonicalization to lib/color-names.c  [Karel Zak]
lib/env:
   - fix memory leak [coverity scan]  [Karel Zak]
lib/fileeq:
   - clean up ifdefs use  [Karel Zak]
lib/fileutils:
   - fix compiler warning  [Karel Zak]
lib/logindefs:
   - fix compiler warning [-Werror=format-truncation=]  [Karel Zak]
lib/loopdev:
   - consolidate ioctls calls on EAGAIN  [Karel Zak]
   - remove duplicate code  [Karel Zak]
lib/monotonic:
   - get_suspended_time  use usec_t  [Thomas Weißschuh]
lib/path:
   - ul_path_cpuparse  fix parsing of empty sysfs files  [Petr Štetiar]
lib/procfs:
   - add function to parse /proc/#/stat  [Karel Zak]
lib/pty:
   - Put master PTY into non-blocking mode and buffer its output to avoid deadlock  [наб]
   - minor cleanups  [Karel Zak]
lib/randutils:
   - drop unnecessary fcntl() in random_get_fd()  [Thomas Haller]
lib/shells:
   - make sure line does not start with '#'  [Karel Zak]
lib/signames:
   - ignore locales when searching for signal names  [Karel Zak]
lib/strutils:
   - add ul_strchr_escaped()  [Karel Zak]
   - fix compiler error  [Thomas Weißschuh]
   - improve strtoul_or_err() for negative numbers  [Karel Zak]
   - include strings.h  [Karel Zak]
   - make sure ul_strtoXX functions always set errno  [Karel Zak]
lib/sysfs:
   - add TODO about removable usb devices  [Thomas Weißschuh]
   - add function blkdev_is_removable  [Thomas Weißschuh]
   - allow parent redirect even for non-queue files  [Thomas Weißschuh]
   - fix semantics of blkdev_is_hotpluggable  [Thomas Weißschuh]
   - fix typo  [Karel Zak]
   - use temporary buffer  [Karel Zak]
lib/timeutils:
   - Add %s (seconds since the Epoch) to parse_timestamp()  [Peter Ujfalusi]
   - Require '@' prefix for seconds since the Epoch timestamp  [Peter Ujfalusi]
   - parse_timestamp  add unittests  [Thomas Weißschuh]
   - parse_timestamp  allow fixed reference time  [Thomas Weißschuh]
   - parse_timestamp  fix second parsing  [Thomas Weißschuh]
   - parse_timestamp  parse usecs  [Thomas Weißschuh]
   - set TZ=GMT for unit test  [Karel Zak]
libblkid:
   - (bcachefs) verify checksum before set probing result  [Karel Zak]
   - (bsd) fix buffer pointer use [fuzzing]  [Karel Zak]
   - (erofs) make blocksize use more restrictive  [Karel Zak]
   - (exfat) fix divide by zero [coverity scan]  [Karel Zak]
   - (hfs) fix label use [fuzzing]  [Karel Zak]
   - (hfs) fix make sure buffer is large enough  [Karel Zak]
   - (mac) make sure block size is large enough [fuzzing]  [Karel Zak]
   - (probe) fix size and offset overflows [fuzzing]  [Karel Zak]
   - (swap) fix magic string memcmp [fuzzing]  [Karel Zak]
   - (topology) init variables for DM  [Karel Zak]
   - (xfs) cleanup checksum code  [Karel Zak]
   - (xfs) fix typo in operators [coverity scan]  [Karel Zak]
   - Add detection of FileVault2 partitions  [Milan Broz]
   - add BLKID_SUBLKS_FSINFO to docs  [Karel Zak]
   - add FSBLOCKSIZE tag  [Andrey Albershteyn]
   - add FSLASTBLOCK field interface showing area occupied by fs  [Andrey Albershteyn]
   - add FSLASTBLOCK implementation for xfs, ext and btrfs  [Andrey Albershteyn]
   - add FSSIZE implementation for btrfs and ext  [Andrey Albershteyn]
   - add bcachefs support  [Thomas Weißschuh]
   - add blkid_probe_get_sb_buffer()  [Thomas Weißschuh]
   - add blkid_probe_set_fsendianness()  [Thomas Weißschuh]
   - add function blkid_probe_verify_csum_buf  [Thomas Weißschuh]
   - add interface for FSSIZE field  [Andrey Albershteyn]
   - add tags list to the man  [Andrey Albershteyn]
   - add test_blkid_fuzz_sample  [Thomas Weißschuh]
   - align nilfs superblock [OSS-Fuzz 55382]  [Karel Zak]
   - always initialize debugging  [Thomas Weißschuh]
   - apfs  add test  [Thomas Weißschuh]
   - avoid buffer overflow in ocfs superblock parsing  [Milan Broz]
   - bcache  add checksum support  [Thomas Weißschuh]
   - bcache  pack superblock struct  [Thomas Weißschuh]
   - bcache  remove unused macros  [Thomas Weißschuh]
   - bcache  report wiped area  [Thomas Weißschuh]
   - bcachefs  add crc32 checksum support  [Thomas Weißschuh]
   - bcachefs  add crc64 checksum support  [Thomas Weißschuh]
   - bcachefs  add reproducer for oss-fuzz 55282  [Thomas Weißschuh]
   - bcachefs  add xxhash checksum support  [Thomas Weißschuh]
   - bcachefs  avoid overflow in address comparisions  [Thomas Weißschuh]
   - bcachefs  fix endless loop  [Thomas Weißschuh]
   - bcachefs  fix field type  [Thomas Weißschuh]
   - bcachefs  fix member_field_end  [Thomas Weißschuh]
   - bcachefs  fix new magic detection  [Thomas Weißschuh]
   - bcachefs  limit maximum size of read superblock  [Thomas Weißschuh]
   - bcachefs  probe UUID_SUB  [Thomas Weißschuh]
   - bcachefs  remove superfluous validations  [Thomas Weißschuh]
   - bcachefs  simplify member field size validation  [Thomas Weißschuh]
   - bcachefs  use uint64_t for structure length  [Thomas Weißschuh]
   - bcachefs  validate device fields  [Thomas Weißschuh]
   - bcachefs  validate size of member field  [Thomas Weißschuh]
   - befs  report endianness  [Thomas Weißschuh]
   - befs - avoid undefined shift  [Milan Broz]
   - bitlocker  fix unaligned access  [Thomas Weißschuh]
   - bsd  add checksum support  [Thomas Weißschuh]
   - btrfs  add checksum support  [Thomas Weißschuh]
   - btrfs  add support for sha256 checksums  [Thomas Weißschuh]
   - btrfs  add support for xxhash checksums  [Thomas Weißschuh]
   - btrfs  prepare for more checksum algorithms  [Thomas Weißschuh]
   - btrfs - avoid calling clz with zero argument  [Milan Broz]
   - check fsync() return code  [Karel Zak]
   - check if device is OPAL locked on I/O error  [Luca Boccassi]
   - cleanup cramfs_verify_csum()  [Karel Zak]
   - cleanup definitions and add docs for return values  [Karel Zak]
   - cleanup indentation  [Karel Zak]
   - cleanup romfs prober  [Karel Zak]
   - cramfs  add checksum support  [Thomas Weißschuh]
   - cramfs  handle cross-endianess for checksums  [Thomas Weißschuh]
   - cramfs  report endianness  [Thomas Weißschuh]
   - cramfs  report filesystem size  [Thomas Weißschuh]
   - cramfs  report version  [Thomas Weißschuh]
   - define probing return values  [Karel Zak]
   - dos  ignore exfat superblocks  [Thomas Weißschuh]
   - erofs  add checksum support  [Thomas Weißschuh]
   - erofs  report fssize  [Thomas Weißschuh]
   - erofs - avoid undefined shift  [Milan Broz]
   - exfat  add checksum support  [Thomas Weißschuh]
   - exfat  rename superblocks fields to match specification  [Thomas Weißschuh]
   - exfat  report filesystem size  [Thomas Weißschuh]
   - exfat  validate more fields  [Thomas Weißschuh]
   - exfat - avoid undefined shift  [Milan Broz]
   - ext  add checksum support  [Thomas Weißschuh]
   - ext - avoid undefined shift  [Milan Broz]
   - ext4  add test  [Thomas Weißschuh]
   - f2fs  add checksum support  [Thomas Weißschuh]
   - f2fs  ensure checksum offset is within superblock  [Thomas Weißschuh]
   - f2fs  fix checksum initialization on big-endian  [Thomas Weißschuh]
   - f2fs  fix unaligned access  [Thomas Weißschuh]
   - f2fs  report fssize  [Thomas Weißschuh]
   - fix FSSIZE docs  [Karel Zak]
   - fix jmicron checksum and LE to CPU  [Karel Zak]
   - fix misaligned-address in probe_erofs  [Milan Broz]
   - fix misaligned-address in probe_exfat  [Milan Broz]
   - fix regression in setting BLOCK_SIZE value  [Milan Broz]
   - gpt  use generic checksum handling  [Thomas Weißschuh]
   - implement FSSIZE calculation for XFS  [Andrey Albershteyn]
   - iso9660  allocate enough space for UTF16 decoding  [Thomas Weißschuh]
   - iso9660  don't warn on isonum mismatch  [Thomas Weißschuh]
   - iso9660  read block size from superblock  [Thomas Weißschuh]
   - iso9660  use sizeof_member  [Thomas Weißschuh]
   - jfs - avoid undefined shift  [Milan Broz]
   - linux_raid  add checksum support  [Thomas Weißschuh]
   - luks  add checksum support  [Thomas Weißschuh]
   - mdraid  add test for version 1 superblock  [Thomas Weißschuh]
   - merge FS* flags into one FSINFO  [Andrey Albershteyn]
   - minix  report endianness  [Thomas Weißschuh]
   - minor changes to coding style  [Karel Zak]
   - new fuzz target  [David Flor]
   - ntfs  avoid UB in signed shift  [Thomas Weißschuh]
   - ntfs  report fssize  [Thomas Weißschuh]
   - nvidia_raid  validate checksum  [Thomas Weißschuh]
   - nvidia_raid  validate full signature  [Thomas Weißschuh]
   - nvidia_raid  verify superblock size  [Thomas Weißschuh]
   - remove strewn around calls to blkid_init_debug()  [Thomas Weißschuh]
   - romfs  add checksum support  [Thomas Weißschuh]
   - romfs  report fssize  [Thomas Weißschuh]
   - sgi  use generic checksum handling  [Thomas Weißschuh]
   - simplify 'leaf' detection  [Karel Zak]
   - squashfs  add more superblock fields  [Thomas Weißschuh]
   - squashfs  add testcase  [Thomas Weißschuh]
   - squashfs  report block sizes  [Thomas Weißschuh]
   - squashfs  report filesystem size  [Thomas Weißschuh]
   - squashfs3  add testcase  [Thomas Weißschuh]
   - squashfs3  report endianness  [Thomas Weißschuh]
   - sun  use generic checksum handling  [Thomas Weißschuh]
   - superblocks  add trailing comma to array  [Thomas Weißschuh]
   - swap  report endianess  [Thomas Weißschuh]
   - swap  report fsblocksize  [Thomas Weißschuh]
   - swap  report fssize  [Thomas Weißschuh]
   - test big endian cramfs image  [Thomas Weißschuh]
   - topolicy/ioctl  use union for multiple data types  [Thomas Weißschuh]
   - topology  add test  [Thomas Weißschuh]
   - topology  allow setting of 64bit values  [Thomas Weißschuh]
   - topology  constify some structures  [Thomas Weißschuh]
   - topology  probe diskseq  [Thomas Weißschuh]
   - topology/ioctl  fix uint64_t handling on 32bit systems  [Thomas Weißschuh]
   - topology/sysfs  fix uint64_t handling on 32bit systems  [Thomas Weißschuh]
   - try LUKS2 first when probing  [Luca Boccassi]
   - ubi  add checksum support  [Thomas Weißschuh]
   - ubifs  add checksum support  [Thomas Weißschuh]
   - ubifs  report fssize  [Thomas Weißschuh]
   - ufs  report endianness  [Thomas Weißschuh]
   - update documentation of BLOCK_SIZE tag  [Andrey Albershteyn]
   - use blkid_probe_set_value() in more consistent way  [Karel Zak]
   - use checksum for jmicron  [Karel Zak]
   - use optlist to detect propagation changes  [Karel Zak]
   - vfat  report fssize  [Thomas Weißschuh]
   - xfs  add checksum support  [Thomas Weißschuh]
   - xfs  add more superblock fields  [Thomas Weißschuh]
   - zfs  remove unnecessary newline from debug messages  [Thomas Weißschuh]
   - zfs  report endianness  [Thomas Weißschuh]
   - zonefs  add checksum support  [Thomas Weißschuh]
libblkid/src/topology/dm:
   - close redundant write file description for pipe before reading data.  [jiayi0118]
libfdisk:
   - (gpt) Add UUID for Marvell Armada 3700 Boot partition  [Pali Rohár]
   - (gpt) add comment  [Karel Zak]
   - (gpt) don't ignore fsync() errors  [Karel Zak]
   - (gpt) fix PMBR read overflow  [Karel Zak]
   - (gpt) remove unnecessary code  [Karel Zak]
   - (gpt) write PMBR only when useful  [Philippe Reynes]
   - Fix randomly generated GPT UUID's  [Toomas Losin]
   - fix typos  [Karel Zak]
   - make scripts portable between different sector sizes  [Karel Zak]
   - meson.build fix typo  [Anatoly Pugachev]
   - remove unused variable ct  [Thomas Weißschuh]
libmount:
   - (context) ask for utab path only once  [Karel Zak]
   - (context) don't use mount flags directly  [Karel Zak]
   - (context) use default options maps  [Karel Zak]
   - (docs) mark mnt_optstr_apply_flags() as deprecated  [Karel Zak]
   - (idmap) fix leak and doble free [coverity scan]  [Karel Zak]
   - (idmap) use optlist  [Karel Zak]
   - (legacy mount) use optlist  [Karel Zak]
   - (legacy) init regualer mount before propagation  [Karel Zak]
   - (loopdev) use optlist  [Karel Zak]
   - (mkdir) cannonicalize after mkdir  [Karel Zak]
   - (mkdir) simplify X-mount.mkdir check  [Karel Zak]
   - (mkdir) use optlist  [Karel Zak]
   - (mount) consolidate sysapi FDs close [coverity scan]  [Karel Zak]
   - (mount) create new FS instance by new Linux API  [Karel Zak]
   - (mount) de-duplicate when apply MS_SECURE  [Karel Zak]
   - (mount) fix mount by FS list/pattern for new API  [Karel Zak]
   - (mount) fix recursion  [Karel Zak]
   - (mount) implement remount by new Linux API  [Karel Zak]
   - (mount) improve code  [Karel Zak]
   - (mount) improve syscalls status handling  [Karel Zak]
   - (mount) remove last mountflags use  [Karel Zak]
   - (mount) support --move by new kernel API  [Karel Zak]
   - (mount) support propagation by new kernel API  [Karel Zak]
   - (mount) use MOUNT_ATTR__ATIME  [Karel Zak]
   - (mount) use independent hooks  [Karel Zak]
   - (mount) use optlist for mount(2) options and flags  [Karel Zak]
   - (mount) use optlist from options processing  [Karel Zak]
   - (optlist) NULL optstr is not error  [Karel Zak]
   - (optlist) add function to access option's map  [Karel Zak]
   - (optlist) add is_recursive shortcut  [Karel Zak]
   - (optlist) add is_silent shortcut  [Karel Zak]
   - (optlist) add mnt_optlist_strdup_optstr()  [Karel Zak]
   - (optlist) add new shortcuts, fix add_flags()  [Karel Zak]
   - (optlist) consolidate filter use  [Karel Zak]
   - (optlist) de-duplicate also according to invert mask  [Karel Zak]
   - (optlist) extend functionality  [Karel Zak]
   - (optlist) filter by optmap masks  [Karel Zak]
   - (optlist) fix ro/rw use  [Karel Zak]
   - (optlist) improve cache and filtering  [Karel Zak]
   - (optlist) improve mnt_optlist_insert_flags()  [Karel Zak]
   - (optlist) keep mnt_optlist_get_optstr() less verbose  [Karel Zak]
   - (optlist) keep parsed options without quotes  [Karel Zak]
   - (optlist) make sure flags are initialized  [Karel Zak]
   - (optlist) support merged optlist  [Karel Zak]
   - (optlist) use cache also for flags  [Karel Zak]
   - (optstr) do not use xalloc.h in test  [Karel Zak]
   - (optstr) remove unnecessary code  [Karel Zak]
   - (optstr) remove unused function  [Karel Zak]
   - (owner) call hooks when all mount stuff is done  [Karel Zak]
   - (owner) remove if-before-free  [Karel Zak]
   - (owner) use optlist for X-mount options  [Karel Zak]
   - (subdir) fix memory leak [coverity scan]  [Karel Zak]
   - (subdir) use new FD based API  [Karel Zak]
   - (subdir) use optlist  [Karel Zak]
   - (umount) use optlist  [Karel Zak]
   - (umount) use optlist for umount helper setup  [Karel Zak]
   - (umount) use optlist to keep options  [Karel Zak]
   - (umount) use optlist when evaluate permissions  [Karel Zak]
   - (verity) rewrite dlopen use  [Karel Zak]
   - (verity) rewrite to use hookset API  [Karel Zak]
   - (verity) use optlist  [Karel Zak]
   - Reuse the guessed root device  [Viktor Rosendahl (BMW)]
   - accept X-mount.idmap=  [Christian Brauner]
   - accept X-mount.{owner,group,mode}=  [наб]
   - add --onlyonce  [Karel Zak]
   - add MNT_STAGE_PREP  [Karel Zak]
   - add MOUNT_ATTR_NOSYMFOLLOW  [Karel Zak]
   - add MS_MOVE to options map  [Karel Zak]
   - add fsconfig() btrfs workaround  [Karel Zak]
   - add info about support for new mount syscalls  [Karel Zak]
   - add inline function to access API file descritors  [Karel Zak]
   - add libmnt_optlist  [Karel Zak]
   - add missing symbols to docs  [Karel Zak]
   - add mnt_optlist_remove_flags() and mnt_opt_set_external()  [Karel Zak]
   - add optlist tests  [Karel Zak]
   - apply fstab options to context optlist  [Karel Zak]
   - check for propagation-only in proper way  [Karel Zak]
   - cleanup UID and GIR parsing, add tests  [Karel Zak]
   - cleanup comments for hooks  [Karel Zak]
   - create a hook to set rootcontext=@target  [Karel Zak]
   - declare array of LSM options const  [Christian Göttsche]
   - don't refer optlist when copy libmnt_fs  [Karel Zak]
   - don't require return argument in get-like functions  [Karel Zak]
   - ensure child hangs around until we persisted namespace  [Christian Brauner]
   - fix and improve utab update on MS_MOVE  [Karel Zak]
   - fix compilation  [Karel Zak]
   - fix compilation without new API  [Karel Zak]
   - fix external helps call  [Karel Zak]
   - fix include  [Karel Zak]
   - fix memory leak [coverity scan]  [Karel Zak]
   - fix mflags  [Karel Zak]
   - fix mount -a to work with optlist  [Karel Zak]
   - fix mount hooks use  [Karel Zak]
   - fix new API code when use external helper  [Karel Zak]
   - fix possible double free  [Karel Zak]
   - fix possible leaks on error  [Karel Zak]
   - fix potentially uninitialized local variable [CodeQL]  [Karel Zak]
   - fix typo in debug message  [Karel Zak]
   - fix typos  [наб]
   - fix unused value [coverity scan]  [Karel Zak]
   - fix unused variable [coverity scan]  [Karel Zak]
   - idmap  fix sock write to child  [Pedro Tammela]
   - implement X-mount.auto-fstypes  [Karel Zak]
   - implement hooks for a legacy mount(2)  [Karel Zak]
   - improve context deinitialization  [Karel Zak]
   - improve debug messages  [Karel Zak]
   - improve optlist  [Karel Zak]
   - inhibit warning about mask being unused  [Thomas Weißschuh]
   - initial support for new FD based mount kernel API  [Karel Zak]
   - initialize tb in is_mounted_same_loopfile()  [Karel Zak]
   - keep context fs and optlist synchronized  [Karel Zak]
   - make NULL deference checks more consistent [coverity scan]  [Karel Zak]
   - make __buffer_append_option() usable in entire lib  [Karel Zak]
   - make it possible to define order of hooks  [Karel Zak]
   - make mnt_match_options() more robust  [Karel Zak]
   - move X-mount.mkdir to separate file  [Karel Zak]
   - move mount-only functions to context_mount.c  [Karel Zak]
   - move optstr parsing to lib/  [Karel Zak]
   - move selinux stuff to hook module  [Karel Zak]
   - new stuff to header file  [Karel Zak]
   - optimize built-in options map use  [Karel Zak]
   - reimplement X-mount.subdir= by hooks  [Karel Zak]
   - reimplement X-mount.{owner,group,mode}= by hooks  [Karel Zak]
   - reimplement loop= by hooks  [Karel Zak]
   - remove hooks initialization  [Karel Zak]
   - remove mtab locking  [Karel Zak]
   - remove mtab related code  [Karel Zak]
   - remove support for writable /etc/mtab  [Karel Zak]
   - remove unimplemented symbol  [Karel Zak]
   - remove unnecessary commented code  [Karel Zak]
   - remove unnecessary declarations  [Karel Zak]
   - remove unnecessary include  [Karel Zak]
   - remove unused context variables  [Karel Zak]
   - remove unused variable  [Karel Zak]
   - remove upper-case from debug message  [Karel Zak]
   - support "recursive" argument for VFS attributes  [Karel Zak]
   - support MOUNT_ATTR_ and rbind in optlist,  [Karel Zak]
   - support VFS flags attributes clear  [Karel Zak]
   - treat comma as terminator in mnt_match_options()  [Karel Zak]
   - use AT_RECURSIVE only when clone tree  [Karel Zak]
   - use MNT_ERR_APPLYFLAGS for failed mount_setattr()  [Karel Zak]
   - use autofs mount hint to ignore autofs mount entries  [Ian Kent]
   - use mount ID to merge utab and mountinfo files  [Karel Zak]
   - use optlist in permission evaluation  [Karel Zak]
   - use optlist to generate options for mount.<type> helpers  [Karel Zak]
   - use optlist to get infor about  MS_REC  [Karel Zak]
   - use optlist to set/get options in mount context  [Karel Zak]
   - when moving a mount point, all sub mount entries in utab should also be updated  [Franck Bui]
libsmartcols:
   - (sample) remove hidden variable [CodeQL scan]  [Karel Zak]
   - add scols_column_set_properties()  [Karel Zak]
   - fix divide by zero [coverity]  [Karel Zak]
   - improve columns reduction  [Karel Zak]
   - improve debug messages  [Karel Zak]
   - make columns reduction more backward compatible  [Karel Zak]
   - support simplified color sequences  [Karel Zak]
   - truncate by one char  [Karel Zak]
   - use local sqrt() implemenation  [Karel Zak]
   - use standard deviation to optimize columns width  [Karel Zak]
libuuid:
   - (man) uuid_copy() -- add missing parenthesis  [Andrew Price]
   - Implement continuous clock handling for time based UUIDs  [Michael Trapp]
   - check clock value from LIBUUID_CLOCK_FILE  [Michael Trapp]
   - fix lib internal cache size  [Michael Trapp]
   - improve cache handling  [d032747]
llib/pty-session:
   - split PTY and signalfd setup  [Karel Zak]
logger:
   - (man) fix examples  [Karel Zak]
   - always update header when read from stdin  [Karel Zak]
   - make sure structured data are escaped  [Karel Zak]
login:
   - never send signals to init  [Samanta Navarro]
loopdev:
   - set block_size when using LOOP_CONFIGURE  [Hideki EIRAKU]
losetup:
   - Fix typo for the --sector-size docs  [Alberto Ruiz]
   - improve backing-file column formatting  [Karel Zak]
lsblk:
   - add -N/--nvme  [zhenwei pi]
   - add -v/--virtio  [zhenwei pi]
   - add DISK-SEQ (aka /sys/block//diskseq  [Karel Zak]
   - add ID column  [Karel Zak]
   - add ID-LINK column  [Karel Zak]
   - add PARTN column  [Karel Zak]
   - add mmc transport  [Thomas Weißschuh]
   - add revision output to --nvme list  [Milan Broz]
   - align function prototype  [Thomas Weißschuh]
   - enable 'MQ' for NVMe/virtio by default  [zhenwei pi]
   - fix JSON output when without --bytes  [Karel Zak]
   - fix endless loop if device specified more than once  [Karel Zak]
   - fix memory leak and unnecessary allocation  [Karel Zak]
   - improve mountpoint columns formatting  [Karel Zak]
   - introduce 'MQ' column  [zhenwei pi]
   - make ID-LINK code more readable  [Karel Zak]
   - read firmware revision from udev  [Milan Broz]
   - remove huge all-function if-condition  [Karel Zak]
   - simplify code by ul_path_count_dirents()  [Karel Zak]
   - support virtio block  [zhenwei pi]
   - use strcoll() to sort  [Karel Zak]
   - use sysfs_blkdev_is_removable()  [Karel Zak]
lscpu:
   - (arm) don't use space in names  [Karel Zak]
   - Add Kryo 3XX Gold core  [ThomasKaiser]
   - Add Snapdragon parts  [Jeremy Linton]
   - Even more Arm part numbers  [Jeremy Linton]
   - add --hierarchic  [Karel Zak]
   - add MODELNAME column (for -e)  [Karel Zak]
   - add missing Apple parts  [James Calligeros]
   - add testcase for Linux 6.2 x86_64  [Thomas Weißschuh]
   - always create Architecture section  [Thomas Weißschuh]
   - fix incomplete column description  [Karel Zak]
   - keep bogomips locale output locale sensitive  [Karel Zak]
   - make Apple part names human-friendly  [James Calligeros]
   - test endianess  [Thomas Weißschuh]
   - use runtime byteorder  [Thomas Weißschuh]
   - use topology maps in more robust way  [Karel Zak]
lsfd:
   - (filter)  accept '.' used in column names  [Masatake YAMATO]
   - (filter)  fix a codeing style of if/else  [Masatake YAMATO]
   - (filter)  parse "" in filter expression correctly  [Masatake YAMATO]
   - (man) fix the description of NAME fields for TCP and UDP sockets  [Masatake YAMATO]
   - (man) fix typos  [Masatake YAMATO]
   - (man) write about PIDFD.* columns  [Masatake YAMATO]
   - (man) write about TCP scokets  [Masatake YAMATO]
   - (man) write about TCP6 related columns  [Masatake YAMATO]
   - (man) write about UNIX-STREAM and UNIX sockets  [Masatake YAMATO]
   - (man) write more about NAME column  [Masatake YAMATO]
   - (man) write more about TCP scokets  [Masatake YAMATO]
   - (style) reformat colinfo array  [Masatake YAMATO]
   - (test) add a case for TCPv6 sockets  [Masatake YAMATO]
   - <breaking comaptiblity> move PROTONAME column to SOCK. column namespace  [Masatake YAMATO]
   - add ENDPOINTS column  [Masatake YAMATO]
   - add SOCKLISTENING column  [Masatake YAMATO]
   - add a helper function decoding interface indexes  [Masatake YAMATO]
   - add a helper function to get 'struct proc' object for given pid  [Masatake YAMATO]
   - add basic code for tracking IPC endpoints  [Masatake YAMATO]
   - add methods to the L4 abstract layer for hidding differences in L3 protocols  [Masatake YAMATO]
   - add new columns  SOCKNETNS, SOCKSTATE, and SOCKTYPE as stubs  [Masatake YAMATO]
   - add static modifier to nodev_table  [Masatake YAMATO]
   - adjust coding style, insert space after "switch" keyword  [Masatake YAMATO]
   - adjust whitespaces in the help message  [Masatake YAMATO]
   - align --help output  [Karel Zak]
   - collect namespace files after collecting information about "nodev" fs  [Masatake YAMATO]
   - consider 64bit addresses when scanning /proc/pid/map_files dir  [Masatake YAMATO]
   - cosmetic change  [Masatake YAMATO]
   - cosmetic change, delete whitespaces  [Masatake YAMATO]
   - cosmetic changes  [Masatake YAMATO]
   - delete __unused__ attr from a used parameter  [Masatake YAMATO]
   - delete __unused__ attribute for an used parameter  [Masatake YAMATO]
   - delete a redundant cast operation  [Masatake YAMATO]
   - delete an unnecessary cast operation  [Masatake YAMATO]
   - don't put a spcae between a function and its arguments  [Masatake YAMATO]
   - don't require nsfs to be mounted  [Thomas Weißschuh]
   - facilitate the way to attach extra info loaded from /proc/net/* to sockets  [Masatake YAMATO]
   - fill ENDPOINTS column for FIFOs  [Masatake YAMATO]
   - fix compiler warning [-Werror,-Wextra-semi]  [Karel Zak]
   - fix compiler warning [-Werror=maybe-uninitialized]  [Karel Zak]
   - fix crash triggered by an empty filter expression  [Masatake YAMATO]
   - fix memory leak related to ENDPOINTS field  [Masatake YAMATO]
   - fix wrong counter expression used in --summary output  [Masatake YAMATO]
   - fix wrong identifier namings (L3->L4)  [Masatake YAMATO]
   - fix wrongly checked flag constants  [Masatake YAMATO]
   - implement -i/--inet option  [Masatake YAMATO]
   - implement code scanning lines in /proc/net/$proto as a method in the L4 abstract layer  [Masatake YAMATO]
   - introduce L4 abstract layer stacked on IP and IP6  [Masatake YAMATO]
   - introduce SOCK. column namespace  [Masatake YAMATO]
   - introduce a method table for supporting various anon inodes  [Masatake YAMATO]
   - introduce is_mapped_file macro  [Masatake YAMATO]
   - introduce is_opened_file macro  [Masatake YAMATO]
   - make TCP and UDP related code L3 protocol neutral  [Masatake YAMATO]
   - make a few structs const  [Thomas Weißschuh]
   - make items in netns_tree extensible  [Masatake YAMATO]
   - make self_netns_sb static  [Thomas Weißschuh]
   - make the logic for verifying the initial line of /proc/net/{tcp,udp} more flexible  [Masatake YAMATO, Thomas Weißschuh, Masatake YAMATO]
   - move kernel32_to_cpu() front in the source file  [Masatake YAMATO]
   - move the field representing connection state from tcp_xinfo to the L4 abstract layer  [Masatake YAMATO]
   - move xstrappend and xstrputc to lsfd.h  [Masatake YAMATO]
   - optimize -i/--inet option  [Masatake YAMATO]
   - prepare enough large buffer when reading /proc/net/unix  [Masatake YAMATO]
   - read the UNIX socket path including white spaces correctly  [Masatake YAMATO]
   - refactor the usage of tcp_decode_state()  [Masatake YAMATO]
   - remove an unused field from struct sock_xinfo_class  [Masatake YAMATO]
   - remove redundant parentheses surrounding return values  [Masatake YAMATO]
   - remove strcpy(), keep things based on sizeof()  [Karel Zak]
   - rename tcp_state to l4_state and use the type instead of unsigned int  [Masatake YAMATO]
   - revise the comment for UNIX_LINE_LEN  [Masatake YAMATO]
   - run netfs test  [Thomas Weißschuh]
   - show classes of anonyomous inodes in AINODECLASS column  [Masatake YAMATO]
   - show extra information returned from ioctl(..., NS_GET_NSTYPE)  [Masatake YAMATO]
   - show pid, comm, and nspid of pidfd in PIDFD.{PID,COMM,NSPID} columns  [Masatake YAMATO]
   - show pids targeted by pidfds in NAME column  [Masatake YAMATO]
   - simplify functions for comparing items  [Masatake YAMATO]
   - skip test mkfds-netns in qemu-user  [Thomas Weißschuh]
   - skip test mkfds-udp on s390x  [Thomas Weißschuh]
   - specify variables instead of types in sizeof operator  [Masatake YAMATO]
   - try including asm/fcntl.h first for decoding flags of fdinfo  [Masatake YAMATO]
   - unify the code for reading /proc/net/tcp and udp  [Masatake YAMATO]
   - use "struct in_addr" to represent IPv4 addresses  [Masatake YAMATO]
   - use /proc/$PID/map_files as the fallback information source  [Masatake YAMATO]
   - use NAME column to show cooked file names  [Masatake YAMATO]
   - use PRIu16 instead of SCNu16 in xasprintf  [Masatake YAMATO]
   - use SCNu16 format specifier instead of cast operations (unsigned short)  [Masatake YAMATO]
   - use TYPE column to show cooked file types  [Masatake YAMATO]
   - use constants defined in asm/fctl.h flags field of a fdinfo  [Masatake YAMATO]
   - use extra information loaded from /proc/net/icmp  [Masatake YAMATO]
   - use extra information loaded from /proc/net/icmp6  [Masatake YAMATO]
   - use extra information loaded from /proc/net/netlink  [Masatake YAMATO]
   - use extra information loaded from /proc/net/packet  [Masatake YAMATO]
   - use extra information loaded from /proc/net/raw  [Masatake YAMATO]
   - use extra information loaded from /proc/net/raw6  [Masatake YAMATO]
   - use extra information loaded from /proc/net/tcp  [Masatake YAMATO]
   - use extra information loaded from /proc/net/tcp6  [Masatake YAMATO]
   - use extra information loaded from /proc/net/udp  [Masatake YAMATO]
   - use extra information loaded from /proc/net/udp6  [Masatake YAMATO]
   - use extra information loaded from /proc/net/udplite  [Masatake YAMATO]
   - use extra information loaded from /proc/net/udplite6  [Masatake YAMATO]
   - use extra information loaded from /proc/net/unix  [Masatake YAMATO]
   - use runtime byteorder  [Thomas Weißschuh]
   - use skip_space()  [Masatake YAMATO]
   - use xstrdup() if included xalloc.h  [Karel Zak]
lsfd.1.adoc:
   - fix a wrong formatting  [Masatake YAMATO]
   - fix typos  [Masatake YAMATO]
   - use monospace face instead of italic face  [Masatake YAMATO]
   - write about how pidfds are represented in NAME column  [Masatake YAMATO]
   - write more about TYPE column  [Masatake YAMATO]
lsirq:
   - improve --sort IRQ  [Karel Zak]
   - use strcoll() to sort  [Karel Zak]
lslogins:
   - (man) add note about new accounts  [Karel Zak]
   - (man) reorder login statuses  [Karel Zak]
   - explain password statuses  [Karel Zak]
   - fix free()  invalid pointer  [Karel Zak]
   - improve prefixes interpretation  [Karel Zak]
   - support more password methods  [Karel Zak]
lsns:
   - (man) add ip-netns to "SEE ALSO" section  [Masatake YAMATO]
   - add TIMENS to the map from CLONE_* to LSNS_ID_*  [Masatake YAMATO]
   - fix the memory leak.  [lishengyu]
   - improve dependence on NS_GET_ ioctls  [Karel Zak]
   - report unsupported ioctl  [Thomas Weißschuh]
   - show persistent namespace, add --persistent  [Karel Zak]
meson:
   - Install binaries to prefix  [Kai Lüke]
   - add PACKAGE definition  [Rosen Penev]
   - add _GNU_SOURCE for sighandler_t  [Rosen Penev]
   - add blkpr  [Thomas Weißschuh]
   - add missing files  [Karel Zak]
   - build fadvise  [Masatake YAMATO]
   - build test_mkfds  [Thomas Weißschuh]
   - check for sys/pidfd.h  [Thomas Weißschuh]
   - check for xattr functions  [Thomas Weißschuh]
   - declare the minimum required version of meson itself  [Eli Schwartz]
   - define USE_LIBMOUNT_SUPPORT_NAMESPACES  [Thomas Weißschuh]
   - don't build po if no gettext  [Rosen Penev]
   - don't use run  [Rosen Penev]
   - enable nls support  [Rosen Penev]
   - enable warnings  [Thomas Weißschuh]
   - export dependencies as declared dependencies  [Eli Schwartz]
   - fix array issue  [Rosen Penev]
   - fix build with -Dselinux=enabled  [Chris Hofstaedtler]
   - fix compilation without systemd  [Rosen Penev]
   - fix cpu_set_t test  [Rosen Penev]
   - fix environ search  [Rosen Penev]
   - fix error in processing version for pc files  [Eli Schwartz]
   - fix isnan check  [Rosen Penev]
   - fix option value  [Rosen Penev]
   - fix pkg-config name of libaudit  [Chris Hofstaedtler]
   - fix static builds creating conflicting targets  [Eli Schwartz]
   - fix test for HAVE_LANGINFO_H  [Thomas Weißschuh]
   - fix test_sysfs build  [Thomas Weißschuh]
   - fix typoed copy-paste error that override other dependencies to blkid  [Eli Schwartz]
   - fix tzname check  [Rosen Penev]
   - fix tzname check and simplify strsignal  [Rosen Penev]
   - fix when HAVE_CLOCK_GETTIME is set  [Nicolas Caramelli]
   - get rid of get_pkgconfig_variable  [Rosen Penev]
   - get the project version from the version-gen script  [Eli Schwartz]
   - implement colors-default  [Thomas Weißschuh]
   - install uuidd.rc with -Dsysvinit=enabled  [Chris Hofstaedtler]
   - libmount  compile test helpers  [Thomas Weißschuh]
   - link shells.c into users of is_known_shell  [Thomas Weißschuh]
   - logindefs.c  handle libeconf dependency  [Thomas Weißschuh]
   - make libcap-ng dependent on setpriv  [Rosen Penev]
   - make libpam optional  [Rosen Penev]
   - pass the correct absolute path to config.h  [Eli Schwartz]
   - remove leftover explicit mentions of logindefs.c  [Thomas Weißschuh]
   - remove some unused variables  [Rosen Penev]
   - update for logindefs move  [Karel Zak]
   - update to build new libmount  [Karel Zak]
   - use -Wno-cast-function-type for libmount python bindings  [Thomas Weißschuh]
   - use dependency('dl')  [Rosen Penev]
   - use uniform indentation  [Thomas Weißschuh]
   - validate the return code of subprocess commands  [Eli Schwartz]
minor:
   - clarity in fstrim.timer  [Sebastian Pucilowski]
mkfs.bfs:
   - Support BSD lock  [plus]
mkfs.bfs, mkfs.cramfs:
   - cleanup optional argument use  [Karel Zak]
mkfs.cramfs:
   - Support BSD lock  [root]
mkswap:
   - add tests  [Thomas Weißschuh]
   - create files with specific endianness  [Thomas Weißschuh]
   - do not use uninitialized stack value  [Samanta Navarro]
   - make context_string const  [Thomas Weißschuh]
more:
   - (man) add note about POSIXLY_CORRECT  [Karel Zak]
   - avoid infinite loop on --squeeze  [Karel Zak]
   - drop unused #include "rpmatch.h"  [Thomas Weißschuh]
   - restore exit-on-eof if POSIXLY_CORRECT is not set  [Karel Zak]
   - update basic command  description  [Karel Zak]
mount:
   - (docs) fix typos in bind-mount references  [Karel Zak]
   - (man) add missing commas  [Jakub Wilk]
   - (man) add note about options order  [Karel Zak]
   - add rootcontext=@target  [Christian Göttsche]
   - split and cleanup usage()  [Karel Zak]
namei:
   - add -Z (selinux context report)  [Karel Zak, CJ Kucera]
nsenter:
   - add --env for allowing environment variables inheritance  [u2386]
   - read default UID and GID from target process  [Thomas Weißschuh]
oss-fuzz:
   - turn on the alignment check explicitly  [Evgeny Vereshchagin]
pg:
   - calling exit on signal handler is not allowed  [Cristian Rodríguez]
pidfd-utils:
   - include wait.h for siginfo_t  [Thomas Weißschuh]
pipesz:
   - add bash-completion script  [Nathan Sharp]
   - add manpage  [Nathan Sharp]
   - add tests  [Nathan Sharp]
   - add the pipesz utility  [Nathan Sharp]
   - correct manpage issues  [Nathan Sharp]
   - fix dead code [coverity scan]  [Karel Zak]
   - fix minor coding style issues  [Karel Zak]
   - use native PAGE_SIZE in tests  [Nathan Sharp]
po:
   - add ka.po (from translationproject.org)  [Temuri Doghonadze]
   - merge changes  [Karel Zak]
   - update ca.po (from translationproject.org)  [Jordi Mas i Hernàndez]
   - update de.po (from translationproject.org)  [Mario Blättermann]
   - update es.po (from translationproject.org)  [Antonio Ceballos Roa]
   - update hr.po (from translationproject.org)  [Božidar Putanec]
   - update ja.po (from translationproject.org)  [Takeshi Hamasaki]
   - update ko.po (from translationproject.org)  [Seong-ho Cho]
   - update uk.po (from translationproject.org)  [Yuri Chornoivan]
po-man:
   - add waitpid.1 manpage  [Thomas Weißschuh]
   - always convert common manpage fragments  [Thomas Weißschuh]
   - enable out of tree builds  [Thomas Weißschuh]
   - merge changes  [Karel Zak]
   - remove unicode dash from manpage NAME section  [Thomas Weißschuh]
   - update fr.po (from translationproject.org)  [Frédéric Marchal]
   - update sr.po (from translationproject.org)  [Мирослав Николић]
   - update uk.po (from translationproject.org)  [Yuri Chornoivan]
procfs:
   - get_stat_nth  handle braces in process name  [Thomas Weißschuh]
pylibmount:
   - properly mark initialization function  [Thomas Weißschuh]
rename:
   - (bash-completion) fix typo  [Karel Zak]
   - rename.1 document edge cases.  [Philip Hazelden]
rename tests:
   - stop clobbering error output.  [Philip Hazelden]
renice:
   - support posix-compliant -n (via POSIXLY_CORRECT) and add --relative flag  [David Anes]
rev:
   - allow zero-byte as separator  [Thomas Weißschuh]
   - make separator configurable  [Thomas Weißschuh]
   - use pointer-size-pairs instead of C-string  [Thomas Weißschuh]
rfkill:
   - (man) List options for supported device types  [Karel Zak]
   - add toggle to bash completion  [Daniel Peukert]
schedutils:
   - better illustrate the usage of cpu-lists with taskset  [Alison Chaiken]
   - clarify confusing mask example in taskset man page  [Alison Chaiken]
   - clarify meaning of taskset return code  [Alison Chaiken]
script:
   - (man) be more explicit about log purpose  [Karel Zak]
   - abort if unused arguments are given  [Chris Hofstaedtler]
   - fix use of utempter  [Karel Zak]
setarch:
   - show current personality  [Thomas Weißschuh]
   - use kernel address size if possible  [Thomas Weißschuh]
setterm:
   - (man) clarify --hbcolor, --ulcolor syntax  [Jakub Wilk]
sfdiks:
   - (man) fix example  [Karel Zak]
sfdisk:
   - (man) fix man page move example  [Karel Zak]
   - (man) fix sector-size description  [Karel Zak]
   - improve code readability for coverity scan  [Karel Zak]
   - inform about failed fsync() [coverity scan]  [Karel Zak]
sr.po:
   - add missing dash to manpage header  [Thomas Weißschuh]
   - fix mkfs.cramfs translation  [Thomas Weißschuh]
strutils:
   - add function strtotimespec_or_err  [Thomas Weißschuh]
su-common:
   - bool is a distinct type in c2x  [Cristian Rodríguez]
sulogin:
   - fix includes  [Karel Zak]
   - only assign to variables written by signal handlers  [Cristian Rodríguez]
   - print features on --version  [Karel Zak]
swapon:
   - add --fstab command line option  [Karel Zak]
switch_root:
   - (man) fix return code description  [Karel Zak]
sysfs:
   - add helper for /sys/kernel/address_bits  [Thomas Weißschuh]
   - read runtime byteorder  [Thomas Weißschuh]
   - sysfs_get_byteorder  add context parameter  [Thomas Weißschuh]
taskset:
   - warn if affinity is not settable  [Karel Zak]
test:
   - (lsfd) add a case for displaying PROTONAME column of mmap'ed AF_PACKET socket  [Masatake YAMATO]
   - (lsfd) add a case for testing ENDPOINTS column of FIFOs  [Masatake YAMATO]
   - (lsfd) extend test_mkfds to manage optional file descriptors  [Masatake YAMATO]
   - (lsfd) ignore noatime mnt flag when testing a fd opening / directory  [Masatake YAMATO]
test_blkid_fuzz:
   - fix test execution  [Thomas Weißschuh]
test_mkfds:
   - add missing terminator of the option spec list  [Masatake YAMATO]
   - avoid multiplication overflow  [Thomas Weißschuh]
tests:
   - (column) add range and negative numbers column addresses  [Karel Zak]
   - (hardlink) remove runtime depend output  [Karel Zak]
   - (libmount) remove unsupported test  [Karel Zak]
   - (libmount) update debug test  [Karel Zak]
   - (lsfd) add a case for PING and PINGv6 sockets  [Masatake YAMATO]
   - (lsfd) add a case for RAWv6 sockets  [Masatake YAMATO]
   - (lsfd) add a case for UDP-Lite sockets  [Masatake YAMATO]
   - (lsfd) add a case for UDPLITEv6 sockets  [Masatake YAMATO]
   - (lsfd) add a case for UDPv6 sockets  [Masatake YAMATO]
   - (lsfd) add a case for testing -i/--inet options  [Masatake YAMATO]
   - (lsfd) add a case for testing SOCKNETNS column  [Masatake YAMATO]
   - (lsfd) add a case testing TCP sockets  [Masatake YAMATO]
   - (lsfd) add a case testing UDP sockets  [Masatake YAMATO]
   - (lsfd) add a case testing UNIX+DGRAM socket  [Masatake YAMATO]
   - (lsfd) add a case testing UNIX-STREAM sockets  [Masatake YAMATO]
   - (lsfd) add cases for NETLINK sockets  [Masatake YAMATO]
   - (lsfd) add comments about the reason using ts_skip_qemu_user()  [Masatake YAMATO]
   - (lsfd) add missing dup2 calls to assign proper file descriptors  [Masatake YAMATO]
   - (lsfd) add more cases for packet sockets  [Masatake YAMATO]
   - (lsfd) delete an unused variable  [Masatake YAMATO]
   - (lsfd) extend unix-stream test case to test SEQPACKET socket  [Masatake YAMATO]
   - (lsfd) fix the potential problems reported by github-code-scan  [Masatake YAMATO]
   - (lsfd) put double quote characters around variable expansions  [Masatake YAMATO]
   - (lsfd) send a signal only if the target PID is know  [Masatake YAMATO]
   - (lsfd) skip if the platform doesn't attach a buffer to a packet socket  [Masatake YAMATO]
   - (lsfd) skip if the platform doesn't permit to use ioctl(fd, SIOCGSKNS)  [Masatake YAMATO]
   - (lsfd) skip if the platform doesn't permit to use unshare(2)  [Masatake YAMATO]
   - (lsfd) skip if the platform doesn't provide pidfd_open(2)  [Masatake YAMATO]
   - (lsfd) update the expected output for "test_mkfds symlink"  [Masatake YAMATO]
   - (lsfd) use ${PIPESTATUS[]} instead of $?  [Masatake YAMATO]
   - (lsfd,mkfds) define new error code for EPROTONOSUPPORT  [Masatake YAMATO]
   - (mkfds) add "lite" parameter to udp and udp6 factories  [Masatake YAMATO]
   - (mkfds) add a factory for making an inotify fd  [Masatake YAMATO]
   - (mkfds) add a factory making unix sockets  [Masatake YAMATO]
   - (mkfds) add a method for printing factory specific data to struct factory  [Masatake YAMATO]
   - (mkfds) add boolean, a new parameter type  [Masatake YAMATO]
   - (mkfds) add netlink factory  [Masatake YAMATO]
   - (mkfds) add ping and ping6 factories  [Masatake YAMATO]
   - (mkfds) add raw6 factory  [Masatake YAMATO]
   - (mkfds) add tcp6 factory  [Masatake YAMATO]
   - (mkfds) add udp6 factory  [Masatake YAMATO]
   - (mkfds) add unsigned int parameter type  [Masatake YAMATO]
   - (mkfds) allow a factory to make a factory specific temporarily data  [Masatake YAMATO]
   - (mkfds) call close method of factory only when it is specified  [Masatake YAMATO]
   - (mkfds) check the privilege required in the factory to run  [Masatake YAMATO]
   - (mkfds) cosmetic change, deleting an empty line  [Masatake YAMATO]
   - (mkfds) cosmetic change, deleting empty lines  [Masatake YAMATO]
   - (mkfds) delete per-factory "fork" field  [Masatake YAMATO]
   - (mkfds) delete unused "child" parameter for factories  [Masatake YAMATO]
   - (mkfds) don't specify a protocol in connect(2) for AF_PACKET socket  [Masatake YAMATO]
   - (mkfds) fix minor typo in comment  [Masatake YAMATO]
   - (mkfds) fix typos in error messages  [Masatake YAMATO]
   - (mkfds) fix typos in factory descriptions  [Masatake YAMATO]
   - (mkfds) introduce constants representing the limitation of the test environment  [Masatake YAMATO]
   - (mkfds) quit when a byte is given via standard input  [Masatake YAMATO]
   - (mkfds) use getpagesize()  [Karel Zak]
   - (pipesz) use helper to get pagesize  [Karel Zak]
   - add SPDX-License-Identifier to helper  [Karel Zak]
   - add X-mount.subdir test  [Karel Zak]
   - add blkid --offset test  [Karel Zak]
   - add complex mount test  [Karel Zak]
   - add function to inhibit loading of custom colorschemes  [Thomas Weißschuh]
   - add ts_check_native_byteorder  [Thomas Weißschuh]
   - add ts_skip_exitcode_not_supported  [Thomas Weißschuh]
   - allow paths in tests to contain '@' char  [David Anes]
   - be explicit with ext2 block size  [Karel Zak]
   - check for loopdevs  [Karel Zak]
   - disable nonfunctional tests under qemu user emulation  [Thomas Weißschuh]
   - don't compile lsfd/mkfds helper on macos, since it's linux only  [Anatoly Pugachev]
   - don't print mount hins on terminal  [Karel Zak]
   - fdisk/bsd  update expected output for ppc64le  [Chris Hofstaedtler]
   - fix misc/setarch run in a docker environment  [Anatoly Pugachev]
   - fix test file name  [Karel Zak]
   - fix typo in comment  [David Anes]
   - functions  allow partitions on loopdevs  [Thomas Weißschuh]
   - make libmount tests more portable  [Karel Zak]
   - make mk-input.sh scripts executable  [Thomas Weißschuh]
   - properly check for widestring functionality  [Thomas Weißschuh]
   - report failed tests  [Karel Zak]
   - test_buffer, return EXIT_SUCCESS at the end  [Anatoly Pugachev]
   - use KNOWN_FAIL for lsns/ioctl_ns  [Karel Zak]
   - wrap $TS_{TOPDIR,SELF} in "." cmdline with double quote chars  [Masatake YAMATO]
tetss:
   - use stat(1) in mount/set_ugid_mode  [Karel Zak]
timeutils:
   - add utilities for usec_t conversions  [Thomas Weißschuh]
tools:
   - update po/LINGUAS when downloading new translations  [Karel Zak]
tools/config-gen:
   - improve fuzzers  [Karel Zak]
umount:
   - don't ignore --quiet for non-root users  [Karel Zak]
   - properly handle special characters in completion  [Thomas Weißschuh]
unshare:
   - Don't waste an ID when -r is used with --map-auto  [Chris Webb]
   - Fix "you (user xxxx) don't exist" error when uid differs from primary gid  [Sol Boucher]
   - Fix PDEATHSIG race for --kill-child with --pid  [Earl Chew]
   - fix a --map-auto error message  [Chris Webb]
   - make pidfd_open() use more portable and robust  [Karel Zak]
   - support --map-users=inner outer count as well as outer,inner,count  [Chris Webb]
uuidd:
   - allow AF_INET in systemd service  [Karel Zak]
   - fix random UUIDs  [Karel Zak]
   - remove also PrivateNetwork=yes from systemd service  [Karel Zak]
   - use sizeof_member  [Thomas Weißschuh]
waipid:
   - print error message without pids  [Thomas Weißschuh]
waitpid:
   - adapt bash-completion for current functionality  [Thomas Weißschuh]
   - add new command  [Thomas Weißschuh]
   - add support for already exited PIDs  [Thomas Weißschuh]
   - add timeout support  [Thomas Weißschuh]
   - allow to only wait for a specific number of process exits  [Thomas Weißschuh]
   - delete trailing whitespace  [Thomas Weißschuh]
   - detect exlusive options with standard mechanism  [Thomas Weißschuh]
   - fix help alignment  [Thomas Weißschuh]
   - prettify options terminator  [Thomas Weißschuh]
wdctl:
   - mark flags field as unsigned long  [Thomas Weißschuh]
   - read firmware version from sysfs  [Thomas Weißschuh]
   - read options from sysfs  [Thomas Weißschuh]
whereis:
   - (man) fix example formatting  [Jakub Wilk]
   - (man) mark example section  [Karel Zak]
   - add glob(7) support (new option -g)  [Karel Zak]
write:
   - (man) fix history section  [Karel Zak]
   - signal_received should be volatile qualified  [Cristian Rodríguez]
zramctl:
   - fix compiler warning [-Werror=maybe-uninitialized]  [Karel Zak]


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

