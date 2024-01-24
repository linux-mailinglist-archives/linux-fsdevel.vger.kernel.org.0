Return-Path: <linux-fsdevel+bounces-8701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0476983A806
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD221F22299
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C7A20B27;
	Wed, 24 Jan 2024 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btxmfPii"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F21B7E5
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096197; cv=none; b=MpbhBglUstWi5vJ+sXncMWx+i9sZbPCya6JYRtRPsuhntmcTtFshspP/zu8wrq2pA3bMa3dsZJEHdjQBXRQIWzBj9Ykc8ZwqoPeFKl10ud40WoaYPncSnM+PsU7nHU9oTegNiFCWtTGMOBWIthvWOVZNS1uV/5JgxOHbQyZISzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096197; c=relaxed/simple;
	bh=Gl0Riic7UVaTEGJ/GratX/bYALVw11r538bmMcFhQPU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NfyxGhAvLmUBRvR9q293qWfpEFpA/StT24YBZ5E45jWN8jzVMllnhc7iUzorkzlViir7AQ73FNxDvP6E4JWzfO2acmUwg4MRfID1ob9YGqNCpOaUkfZfmdW44NtP3uMv+Ub71r+NEKSzjKSvTehtMzED6WQjWInL8+tfHTZ8Vv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=btxmfPii; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706096192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mjlhAN1nseG5mKVVzvLPlojeF+m/tDhp1M8o/J+LaCw=;
	b=btxmfPiiGn4ya/cPAUC7gR7ret2L4KrNVVuHHcC2YpmVP3ve0K5H8NqE5Wb+YQ5ECSkdHT
	CXClApfMifrU2acAKoBK2WVMERVytagitn7LLVhGdJQWLF5r4GNy1He2g/uATfilAgzuHT
	kEi52aFdTUSSqFo9uX00t+V2GEnZxpI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-Jcrcc0cuPDarpc_kHR4V_g-1; Wed, 24 Jan 2024 06:36:28 -0500
X-MC-Unique: Jcrcc0cuPDarpc_kHR4V_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D62F85A588;
	Wed, 24 Jan 2024 11:36:28 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.22])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 630B33C2E;
	Wed, 24 Jan 2024 11:36:27 +0000 (UTC)
Date: Wed, 24 Jan 2024 12:36:25 +0100
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.40-rc1
Message-ID: <20240124113625.z6cldikqoszclwwf@ws.net.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1


The util-linux release v2.40-rc1 is available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.40/
 
Feedback and bug reports, as always, are welcomed.

    Karel 



util-linux 2.40 Release Notes
=============================

Release highlights
------------------

libmount:

    The libmount monitor has been enhanced to be more user-friendly for
    userspace-specific mount options (e.g., GNOME gVFS).

    The new mount kernel API can be enabled/disabled using the environment
    variable LIBMOUNT_FORCE_MOUNT2={always, never, auto}.

libsmartcols:

    The library now supports filtering expressions (refer to the scols-filter(5)
    man page). Applications can utilize the filter before gathering all data
    for output, reducing resource usage and improving performance. Currently,
    this feature is employed in lsfd and lsblk. Example:

	lsblk --filter 'NAME !~ "sd[ab]"'q

    The library now supports counters (based on filters). For instance:

        lsfd --summary=only \
                   -C 'netlink sockets':'(NAME =~ "NETLINK:.*")' \
                   -C 'unix sockets':'(NAME =~ "UNIX:.*")'
     VALUE COUNTER
        57 netlink sockets
      1552 unix sockets

* liblastlog2 and pam_lastlog2:

    Introducing a new library, liblastlog2, to implement lastlog replacement
    using a SQLite3 database in /var/lib/lastlog/lastlog2.db. This implementation
    is Y2038 safe, and the database size is independent of UIDs.

    A new command, lastlog2, is now available.

    lastlog2 is utilized in pam_lastlog2.


* libuuid iImproved support for 64-bit time.

* A new command, lsclocks, is introduced to display system clocks (realtime,
  monotonic, boottime, etc.).

* login(1) now supports systemd service credentials. 'login.noauth' is now
  supported.


Changes between v2.39 and v2.40
-------------------------------

AUTHORS:
   - add tools contributed by myself  [Thomas Weißschuh]
Add Phytium FTC862 cpu model. fix:
   - #2486  [unknown]
Documentation:
   - add basic smoketest for boilerplate.c  [Thomas Weißschuh]
Fix typo:
   - octen -> octet  [zeyun chen]
agetty:
   - Load autologin user from agetty.autologin credential  [Daan De Meyer]
   - include fileutils.h  [Thomas Weißschuh]
   - remove duplicate include  [Karel Zak]
   - use get_terminal_default_type()  [Karel Zak]
   - use sd_get_sessions() for number of users (#2088)  [Thorsten Kukuk]
audit-arch:
   - add support for alpha  [Thomas Weißschuh]
autotools:
   - add missing dist_noinst_DATA  [Karel Zak]
   - check for flex in autogen.sh  [Karel Zak]
   - fix AC_DEFINE_UNQUOTED() use  [Karel Zak]
   - fix AC_PROG_LEX use  [Karel Zak]
   - fix librtas check  [Karel Zak]
   - fix non-Linux build  [Karel Zak, Samuel Thibault]
   - fix typos  [Karel Zak]
   - use stamp file to build filter parser, improve portability  [Karel Zak]
bash-completion:
   - (fadvise)  fix a typo  [Masatake YAMATO]
   - (lslocks)  add --bytes option to the rules  [Masatake YAMATO]
   - add -T to last  [Karel Zak]
   - make sure that "lastb" actually completes  [Eli Schwartz]
   - update for mkswap  [Karel Zak]
blkdev.h:
   - avoid some unused argument warnings  [Thomas Weißschuh]
blkid:
   - fix call to err_exclusive_options  [Thomas Weißschuh]
blkpr:
   - store return value of getopt_long in int  [Thomas Weißschuh]
blkzone:
   - don't take address of struct blk_zone  [Thomas Weißschuh]
blockdev:
   - add missing verbose output for --getsz  [Christoph Anton Mitterer]
   - add support for BLKGETZONESZ  [Thomas Weißschuh]
   - properly check for BLKGETZONESZ ioctl  [Thomas Weißschuh]
build:
   - use -std=c99 and -std=c++11 by default  [Thomas Weißschuh]
build-sys:
   - (tests) validate that time_t is 64bit  [Thomas Weißschuh]
   - add --disable-exch  [Karel Zak]
   - add --disable-waitpid  [Frantisek Sumsal]
   - add AX_COMPARE_VERSION  [Thomas Weißschuh]
   - add enosys and syscalls.h to gitignore  [Enze Li]
   - backport autoconf year2038 macros  [Thomas Weißschuh]
   - don't call pkg-config --static if unnecessary  [Karel Zak]
   - fail build for untracked files  [Thomas Weißschuh]
   - fix libmount/src/hooks.c use  [Karel Zak]
   - fix po-man clean  [Karel Zak]
   - fix typo in waitpid check  [Thomas Weißschuh]
   - improve checkadoc  [Karel Zak]
   - only build col on glibc  [Thomas Weißschuh]
   - only pass --failure-level if supported  [Thomas Weißschuh]
   - rearrange gitignore in alphabetical order  [Enze Li]
   - try to always use 64bit time support on glibc  [Thomas Weißschuh]
buildsys:
   - warn on usage of VLAs  [Thomas Weißschuh]
   - warn on usage of alloca()  [Thomas Weißschuh]
c.h:
   - make err_nonsys available  [Thomas Weißschuh]
cal:
   - avoid out of bound write  [Thomas Weißschuh]
   - fix error message for bad -c argument  [Jakub Wilk]
   - fix long option name for -c  [Jakub Wilk]
cfdisk:
   - add hint about labels for bootable flag  [Karel Zak]
   - ask y/n before wipe  [Karel Zak]
   - fix menu behavior after writing changes  [Karel Zak]
   - properly handle out-of-order partitions during resize  [Thomas Weißschuh]
chrt:
   - (man) add note about --sched-period lower limit  [Karel Zak]
   - (tests) don't mark tests as known failed  [Thomas Weißschuh]
   - (tests) increase deadline test parameters  [Thomas Weißschuh]
   - allow option separator  [Thomas Weißschuh]
chsh:
   - use libeconf to read /etc/shells  [Thorsten Kukuk]
ci:
   - (codeql) ignore cpp/uncontrolled-process-operation  [Thomas Weißschuh]
   - add OpenWrt SDK based CI jobs  [Thomas Weißschuh]
   - also use GCC 13 for sanitizer builds  [Thomas Weißschuh]
   - build on old distro  [Thomas Weißschuh]
   - build with GCC 13/11  [Thomas Weißschuh]
   - build with clang 17  [Thomas Weißschuh]
   - cache openwrt sdk  [Thomas Weißschuh]
   - cancel running jobs on push  [Frantisek Sumsal]
   - collect coverage on _exit() as well  [Frantisek Sumsal]
   - disable cpp/path-injection rule  [Thomas Weißschuh]
   - don't combine -Werror and -fsanitize  [Thomas Weißschuh]
   - enable -Werror for meson  [Thomas Weißschuh]
   - fix indentation  [Frantisek Sumsal]
   - hide coverage-related stuff begind --enable-coverage  [Frantisek Sumsal]
   - mark source directory as safe  [Thomas Weißschuh]
   - packit  add flex  [Karel Zak]
   - prevent prompts during installation  [Thomas Weißschuh]
   - run full testsuite under musl libc  [Thomas Weißschuh]
   - tweak build dir's ACL when collecting coverage  [Frantisek Sumsal]
   - use clang 16  [Thomas Weißschuh]
column:
   - fix -l  [Karel Zak]
   - fix memory leak  [Thomas Weißschuh]
coverage.h:
   - mark _exit as noreturn  [Thomas Weißschuh]
ctrlaltdel:
   - remove unnecessary uid check  [JJ-Meng]
disk-utils:
   - add SPDX and Copyright notices  [Karel Zak]
dmesg:
   - (tests) validate json output  [Thomas Weißschuh]
   - -r LOG_MAKEPRI needs fac << 3  [Edward Chron]
   - Delete redundant pager setup  [Karel Zak]
   - add caller_id support  [Edward Chron]
   - add support for reserved and local facilities  [Thomas Weißschuh]
   - cleanup function names  [Karel Zak]
   - correctly print all supported facility names  [Thomas Weißschuh]
   - error out instead of silently ignoring force_prefix  [Thomas Weißschuh]
   - fix FD leak  [Karel Zak]
   - make kmsg read() buffer big enough for kernel  [anteater]
   - man and coding style changes  [Karel Zak]
   - only write one message to json  [Thomas Weißschuh]
   - open-code LOG_MAKEPRI  [Thomas Weißschuh]
   - support for additional human readable timestamp  [Rishabh Thukral]
   - support reading kmsg format from file  [Thomas Weißschuh]
   - use symbolic defines for second conversions  [Thomas Weißschuh]
docs:
   - add SPDX to boilerplate.c  [Karel Zak]
   - move Copyright in boilerplate.c  [Karel Zak]
   - update AUTHORS file  [Karel Zak]
   - use HTTPS for GitHub clone URLs  [Jakub Wilk]
eject:
   - (tests) don't write mount hint to terminal  [Karel Zak]
enosys:
   - add --list  [Thomas Weißschuh]
   - add bash completion  [Thomas Weißschuh]
   - add common arguments  [Thomas Weißschuh]
   - add manpage  [Thomas Weißschuh]
   - add support for MIPS, PowerPC and ARC  [Thomas Weißschuh]
   - add support for ioctl blocking  [Thomas Weißschuh]
   - add support for loongarch  [Thomas Weißschuh]
   - add support for sparc  [Thomas Weißschuh]
   - add test  [Thomas Weißschuh]
   - allow CPU speculation  [Thomas Weißschuh]
   - avoid warnings when no aliases are found  [Thomas Weißschuh]
   - build BPF dynamically  [Thomas Weißschuh]
   - don't require end-of-options marker  [Thomas Weißschuh]
   - don't validate that numbers are found from headers  [Thomas Weißschuh]
   - enable locale handling  [Thomas Weißschuh]
   - find syscalls at build time  [Thomas Weißschuh]
   - fix build on hppa  [John David Anglin]
   - fix native arch for s390x  [Thomas Weißschuh]
   - improve checks for EXIT_NOTSUPP  [Thomas Weißschuh]
   - include sys/syscall.h  [Thomas Weißschuh]
   - list syscall numbers  [Thomas Weißschuh]
   - make messages useful for users  [Thomas Weißschuh]
   - mark variable static  [Thomas Weißschuh]
   - move from tests/helpers/test_enosys.c  [Thomas Weißschuh]
   - only build if AUDIT_ARCH_NATIVE is defined  [Thomas Weißschuh]
   - properly block execve syscall  [Thomas Weißschuh]
   - provide a nicer build message for syscalls.h generation  [Thomas Weißschuh]
   - remove long jumps from BPF  [Thomas Weißschuh]
   - remove unneeded inline variable declaration  [Thomas Weißschuh]
   - split audit arch detection into dedicated header  [Thomas Weißschuh]
   - store blocked syscalls in list instead of array  [Thomas Weißschuh]
   - syscall numbers are "long"  [Thomas Weißschuh]
   - translate messages  [Thomas Weißschuh]
   - validate syscall architecture  [Thomas Weißschuh]
exch:
   - Add man page to po4a.cfg to make it translatable  [Mario Blättermann]
   - cosmetic changes  [Karel Zak]
   - fix typo  [Karel Zak]
   - new command exchaging two files atomically  [Masatake YAMATO]
   - properly terminate options array  [Thomas Weißschuh]
   - use NULL rather than zero  [Karel Zak]
exec_shell:
   - use xasprintf  [Thomas Weißschuh]
fadvise:
   - (test) don't compare fincore page counts  [Thomas Weißschuh]
   - (test) dynamically calculate expected test values  [Thomas Weißschuh]
   - (test) test with 64k blocks  [Thomas Weißschuh]
   - (tests) factor out calls to "fincore"  [Thomas Weißschuh]
   - Fix markup in man page  [Mario Blättermann]
fallocate:
   - fix the way to evaluate values returned from posix_fallocate  [Masatake YAMATO]
fdisk:
   - add support for partition resizing  [Thomas Weißschuh]
   - guard posix variable  [Thomas Weißschuh]
   - remove usage of VLA  [Thomas Weißschuh]
fileeq:
   - optimize size of ul_fileeq_method  [Thomas Weißschuh]
fincore:
   - (tests) adapt alternative testcases to new header format  [Thomas Weißschuh]
   - (tests) also use nosize error file  [Thomas Weißschuh]
   - (tests) fix double log output  [Chris Hofstaedtler]
   - add --output-all  [Thomas Weißschuh]
   - fix alignment of column listing in --help  [Thomas Weißschuh]
   - refactor output formatting  [Thomas Weißschuh]
   - report data from cachestat()  [Thomas Weißschuh]
findmnt:
   - add --list-columns  [Karel Zak]
   - add -I, --dfi options for imitating the output of df -i  [Masatake YAMATO]
   - add inode-related columns for implementing "df -i" like output  [Masatake YAMATO]
   - use zero to separate lines in multi-line cells  [Karel Zak]
flock:
   - initialize timevals [-Werror=maybe-uninitialized]  [Karel Zak]
fsck:
   - initialize timevals [-Werror=maybe-uninitialized]  [Karel Zak]
fstab:
   - Fix markup in man page  [Mario Blättermann]
   - add hint about systemd reload  [Karel Zak]
github:
   - add labeler  [Karel Zak]
   - check apt-cache in more robust way  [Karel Zak]
   - check apt-cache in more robust way (v2)  [Masatake YAMATO]
   - fix build with clang and in ubuntu build-root  [Karel Zak]
gitignore:
   - ignore exch  [Thomas Weißschuh]
   - ignore setpgid binary  [Christian Göttsche]
hardlink:
   - (man) add missing comma  [Jakub Wilk]
   - Fix markup in man page  [Mario Blättermann]
   - fix fiemap use  [Karel Zak]
hexdump:
   - Add missing section header in man page  [Mario Blättermann]
   - add '--one-byte-hex' format option  [Tomasz Wojdat]
   - add new format-strings test case  [Tomasz Wojdat]
   - use xasprintf to build string  [Thomas Weißschuh]
hwclock:
   - Improve set error in the face of jitter  [Eric Badger]
   - add --vl-read, --vl-clear documentation and bash-completion  [Rasmus Villemoes]
   - add support for RTC_VL_READ/RTC_VL_CLR ioctls  [Rasmus Villemoes]
   - handle failure of audit_log_user_message  [Thomas Weißschuh]
   - reuse error message  [Karel Zak]
include:
   - add DragonFlyBSD GPT partition types  [Thomas Weißschuh]
   - add U-Boot environment partition type  [Thomas Weißschuh]
   - add some more ChromeOS partition types  [Thomas Weißschuh]
   - define pidfd syscalls if needed  [Markus Mayer]
include/audit-arch:
   - add missing SPDX  [Karel Zak]
include/bitops.h:
   - Remove bswap* compatibility hack for FreeBSD  [Daniel Engberg]
include/c.h:
   - add helpers for unaligned structure access  [Thomas Weißschuh]
   - handle members of const struct  [Thomas Weißschuh]
   - implement reallocarray  [Thomas Weißschuh]
include/crc64:
   - add missing license header  [Karel Zak]
include/strutils:
   - add ul_strtold()  [Karel Zak]
irqtop:
   - fix numeric sorting  [Valery Ushakov]
jsonwrt:
   - add ul_jsonwrt_value_s_sized  [Thomas Weißschuh]
last:
   - Add -T option for tab-separated output  [Trag Date]
last(1):
   - Document -T option for tab-separated output  [Trag Date]
ldattach:
   - don't call exit() from signal handler  [Thomas Weißschuh]
ldfd:
   - delete unnecessary ';'  [Masatake YAMATO]
lib:
   - remove pager.c from libcommon  [Karel Zak]
lib/ include/:
   - cleanup licence headers  [Karel Zak]
lib/buffer:
   - make buffer usable for non-string data  [Karel Zak]
lib/caputils:
   - fix integer handling issues [coverity scan]  [Karel Zak]
lib/color-names:
   - fix licence header  [Karel Zak]
lib/colors:
   - correct documentation of colors_add_scheme()  [Thomas Weißschuh]
lib/env:
   - avoid underflow of read_all_alloc() return value  [Thomas Weißschuh]
   - fix function name remote_entry -> remove_entry  [Thomas Weißschuh]
lib/idcache:
   - always gracefully handle null cache  [Thomas Weißschuh]
lib/jsonwrt:
   - add support for float numbers  [Karel Zak]
lib/loopdev:
   - consistently return error values from loopcxt_find_unused()  [Thomas Weißschuh]
   - document function return values  [Thomas Weißschuh]
lib/mbsalign:
   - calculate size of decoded string  [Karel Zak]
lib/mbsedit:
   - remove usage of VLA  [Thomas Weißschuh]
lib/pager:
   - Allow PAGER commands with options  [Dragan Simic]
   - Apply pager-specific fixes only when needed  [Dragan Simic]
lib/path:
   - Set errno in case of fgets failure  [Tobias Stoeckmann]
   - fix possible out of boundary access  [Tobias Stoeckmann]
   - fix typos  [Tobias Stoeckmann]
   - remove ul_prefix_fopen  [Tobias Stoeckmann]
   - remove usage of VLA  [Thomas Weißschuh]
   - set errno in case of error  [Tobias Stoeckmann]
lib/pty-session:
   - initialize timevals [-Werror=maybe-uninitialized]  [Karel Zak]
lib/shells:
   - Plug econf memory leak  [Tobias Stoeckmann]
   - initialize free-able variables  [Karel Zak]
   - remove space after function name  [Karel Zak]
lib/strutils:
   - add strfappend and strvfappend  [Masatake YAMATO]
   - add ul_next_string()  [Karel Zak]
   - fix typo  [Jakub Wilk]
lib/timeutils:
   - (parse_timestamp_reference) report errors on overflow  [Thomas Weißschuh]
   - (tests) add test for formatting  [Thomas Weißschuh]
   - (tests) move to struct timespec  [Thomas Weißschuh]
   - constify some arguments  [Thomas Weißschuh]
   - don't use glibc strptime extension  [Thomas Weißschuh]
   - implement nanosecond formatting  [Thomas Weißschuh]
   - implement timespec formatting  [Thomas Weißschuh]
   - print error if timestamp can't be parsed  [Thomas Weißschuh]
   - test epoch timestamp  [Thomas Weißschuh]
lib/ttyutils:
   - add get_terminal_default_type()  [Karel Zak]
libblkid:
   - (adapted_raid) validate size in standard minsz predicate  [Thomas Weißschuh]
   - (bcache) also calculate checksum over journal buckets  [Thomas Weißschuh]
   - (bcache) extend superblock definition  [Thomas Weißschuh]
   - (bcache) report block size  [Thomas Weißschuh]
   - (bcache) report label  [Thomas Weißschuh]
   - (bcache) report version  [Thomas Weißschuh]
   - (bcachefs) adapt to major.minor version  [Thomas Weißschuh]
   - (bcachefs) add support for 2nd superblock at 2MiB  [Thomas Weißschuh]
   - (bcachefs) add support for sub-device labels  [Thomas Weißschuh]
   - (bcachefs) add support for superblock at end of disk  [Thomas Weißschuh]
   - (bcachefs) compare against offset from idmag  [Thomas Weißschuh]
   - (bcachefs) fix compiler warning [-Werror=sign-compare]  [Karel Zak]
   - (bcachefs) fix not detecting large superblocks  [Colin Gillespie]
   - (bcachefs) fix size validation  [Thomas Weißschuh]
   - (cramfs) use magic hint  [Thomas Weißschuh]
   - (ddf_raid) validate size in standard minsz predicate  [Thomas Weißschuh]
   - (dev) use strdup to duplicate string  [Thomas Weißschuh]
   - (drbd) avoid unaligned accesses  [Thomas Weißschuh]
   - (drbd) reduce false-positive  [biubiuzy]
   - (drbd) use magics  [Thomas Weißschuh]
   - (drbd) validate size in standard minsz predicate  [Thomas Weißschuh]
   - (drbd) validate zero padding  [Thomas Weißschuh]
   - (hfsplus) reduce false positive  [Karel Zak]
   - (highpoint_raid) validate size in standard minsz predicate  [Thomas Weißschuh]
   - (isw_raid) validate size in standard minsz predicate  [Thomas Weißschuh]
   - (jmicron_raid) avoid modifying shared buffer  [Thomas Weißschuh]
   - (jmicron_raid) use checksum APIs  [Thomas Weißschuh]
   - (jmicron_raid) validate size in standard minsz predicate  [Thomas Weißschuh]
   - (lsi_raid) validate size in standard minsz predicate  [Thomas Weißschuh]
   - (lvm2) read complete superblock  [Thomas Weißschuh]
   - (ntfs) validate that sector_size is a power of two  [Thomas Weißschuh]
   - (nvidia_raid) validate size in standard minsz predicate  [Thomas Weißschuh]
   - (probe) add magic hint  [Thomas Weißschuh]
   - (probe) allow superblock offset from end of device  [Thomas Weißschuh]
   - (probe) handle probe without chain gracefully  [Thomas Weißschuh]
   - (probe) read data in chunks  [Thomas Weißschuh]
   - (probe) remove chunking from blkid_probe_get_idmag()  [Thomas Weißschuh]
   - (probe) remove duplicate log  [Thomas Weißschuh]
   - (promise_raid) validate size in standard minsz predicate  [Thomas Weißschuh]
   - (silicon_raid) validate size in standard minsz predicate  [Thomas Weißschuh]
   - (stratis) remove usage of VLA  [Thomas Weißschuh]
   - (superblocks) add helper blkid32_to_cpu()  [Thomas Weißschuh]
   - (vfat) avoid modifying shared buffer  [Thomas Weißschuh]
   - (via_raid) validate size in standard minsz predicate  [Thomas Weißschuh]
   - (vxfs) add test files  [Thomas Weißschuh]
   - (vxfs) report endianness  [Thomas Weißschuh]
   - (vxfs) simplify prober  [Thomas Weißschuh]
   - (vxfs) use hex escape for magic  [Thomas Weißschuh]
   - (zonefs) avoid modifying shared buffer  [Thomas Weißschuh]
   - add remove_buffer helper  [Thomas Weißschuh]
   - avoid aligning out of probing area  [Thomas Weißschuh]
   - avoid memory leak of cachefile path  [Thomas Weißschuh]
   - avoid use of non-standard typeof()  [Thomas Weißschuh]
   - constify cached disk data  [Thomas Weißschuh]
   - constify return values of blkid_probe_get_sb  [Thomas Weißschuh]
   - exfat  fix fail to find volume label  [Yuezhang Mo]
   - fix topology chain types mismatch  [Karel Zak]
   - improve portability  [Samuel Thibault]
   - introduce blkid_wipe_all  [Thomas Weißschuh]
   - introduce helper to get offset for idmag  [Thomas Weißschuh]
   - iso9660  Define all fields in iso_volume_descriptor according to ECMA-119 4th edition spec  [Pali Rohár]
   - iso9660  Implement full High Sierra CDROM format support  [Pali Rohár]
   - jfs - avoid undefined shift  [Milan Broz]
   - limit read buffer size  [Thomas Weißschuh]
   - make enum libblkid_endianness lowercase  [Thomas Weißschuh]
   - protect shared buffers against modifications  [Thomas Weißschuh]
   - prune unneeded buffers  [Thomas Weißschuh]
   - reset errno before calling probefuncs  [Thomas Weißschuh]
libfdisk:
   - (dos) remove usage of VLA  [Thomas Weißschuh]
   - (sgi)  use strncpy over strcpy  [Thomas Weißschuh]
   - (sun) properly initialize partition data  [Thomas Weißschuh]
   - (tests) fix tests for removal of non-blockdev sync()  [Thomas Weißschuh]
   - add fdisk_partition_get_max_size  [Thomas Weißschuh]
   - add shortcut for Linux extended boot  [Thomas Weißschuh]
   - constify builtin fdisk_parttype  [Thomas Weißschuh]
   - fdisk_deassign_device  only sync(2) blockdevs  [наб]
   - fix typo in debug message  [Thomas Weißschuh]
   - handle allocation failure in fdisk_new_partition  [Thomas Weißschuh]
   - reset errno before calling read()  [Thomas Weißschuh]
   - use new blkid_wipe_all helper  [Thomas Weißschuh]
liblastlog2:
   - fix leaks  [Karel Zak]
libmount:
   - (context) avoid dead store  [Thomas Weißschuh]
   - (optlist) correctly detect ro status  [Thomas Weißschuh]
   - (python)  work around python 3.12 bug  [Thomas Weißschuh]
   - (tests) add helper for option list splitting  [Thomas Weißschuh]
   - (tests) don't require root for update tests  [Thomas Weißschuh]
   - (tests) fix --filesystems crash on invalid argument  [Thomas Weißschuh]
   - (tests) fix --filesystems test argument parsing  [Thomas Weißschuh]
   - (tests) split helper tests  [Thomas Weißschuh]
   - (utils) avoid dead store  [Thomas Weißschuh]
   - (utils) fix statx fallback  [Thomas Weißschuh]
   - (veritydev) use asprintf to build string  [Thomas Weißschuh]
   - Fix regression when mounting with atime  [Filipe Manana]
   - accept '\' as escape for options separator  [Karel Zak]
   - add helper to log mount messages as emitted by kernel  [Thomas Weißschuh]
   - add missing utab options after helper call  [Karel Zak]
   - add mnt_context_within_helper() wrapper  [Karel Zak]
   - add private mnt_optstr_get_missing()  [Karel Zak]
   - add sample to test fs and context relation  [Karel Zak]
   - add utab.act file  [Karel Zak]
   - always ignore user=<name>  [Karel Zak]
   - change syscall status macros to be functions  [Thomas Weißschuh]
   - check for availability of mount_setattr  [Thomas Weißschuh]
   - check for linux/mount.h  [Markus Mayer]
   - check for struct statx  [Markus Mayer]
   - cleanup --fake mode  [Karel Zak]
   - cleanup enosys returns from mount hoop  [Karel Zak]
   - cleanup locking in table update code  [Karel Zak]
   - don't assume errno after failed asprintf()  [Karel Zak]
   - don't call hooks after mount.<type> helper  [Karel Zak]
   - don't call mount.<type> helper with usernames  [Karel Zak]
   - don't canonicalize symlinks for bind operation  [Karel Zak]
   - don't pass option "defaults" to helper  [Thomas Weißschuh]
   - fix fsconfig value unescaping  [Karel Zak]
   - fix options prepend/insert and merging  [Karel Zak]
   - fix possible NULL dereference [coverity scan]  [Karel Zak]
   - fix statx() includes  [Karel Zak]
   - fix sync options between context and fs structs  [Karel Zak]
   - fix typo  [Debarshi Ray]
   - gracefully handle NULL path in mnt_resolve_target()  [Thomas Weißschuh]
   - guard against sysapi == NULL  [Thomas Weißschuh]
   - handle failure to apply flags as part of a mount operation  [Debarshi Ray]
   - ifdef statx() call  [Karel Zak]
   - ignore unwanted kernel events in monitor  [Karel Zak]
   - improve EPERM interpretation  [Karel Zak]
   - improve act file close  [Karel Zak]
   - improve mnt_table_next_child_fs()  [Karel Zak]
   - introduce /run/mount/utab.event  [Karel Zak]
   - introduce LIBMOUNT_FORCE_MOUNT2={always,never,auto}  [Karel Zak]
   - introduce reference counting for libmnt_lock  [Karel Zak]
   - make.stx_mnt_id use more robust  [Karel Zak]
   - reduce utab.lock permissions  [Karel Zak]
   - report all kernel messages for fd-based mount API  [Thomas Weißschuh]
   - report failed syscall name  [Karel Zak]
   - report statx in features list  [Karel Zak]
   - test utab options after helper call  [Thomas Weißschuh]
   - update documentation for MNT_ERR_APPLYFLAGS  [Debarshi Ray]
   - use mount(2) for remount on Linux < 5.14  [Karel Zak]
   - use some MS_* flags as superblock flags  [Karel Zak]
libmount (python):
   - simplify struct initialization  [Thomas Weißschuh]
libsmartcols:
   - (cell) consistently handle NULL argument  [Thomas Weißschuh]
   - (filter) Add on-demand data filler  [Karel Zak]
   - (filter) add ability to cast data  [Karel Zak]
   - (filter) add regular expression operators  [Karel Zak]
   - (filter) add upper case EQ,NE,LE,LT,GT and GE operators  [Karel Zak]
   - (filter) cleanup __filter_new_node()  [Karel Zak]
   - (filter) cleanup data types  [Karel Zak]
   - (filter) cleanup function arguments  [Karel Zak]
   - (filter) evaluate params  [Karel Zak]
   - (filter) fix dereferences and leaks [coverity scann]  [Karel Zak]
   - (filter) fix regex deallocation  [Karel Zak]
   - (filter) implement data basic operators  [Karel Zak]
   - (filter) implement logical operators  [Karel Zak]
   - (filter) improve holder status  [Karel Zak]
   - (filter) improve holder use  [Karel Zak]
   - (filter) improve scols_filter_assign_column()  [Karel Zak]
   - (filter) make holders API more generic  [Karel Zak]
   - (filter) move struct filter_expr  [Karel Zak]
   - (filter) move struct filter_param  [Karel Zak]
   - (filter) normalize param strings  [Karel Zak]
   - (filter) param data refactoring  [Karel Zak]
   - (filter) split code  [Karel Zak]
   - (filter) support empty values  [Karel Zak]
   - (filter) support period in identifier  [Karel Zak]
   - (filter) use also rpmatch() for boolean  [Karel Zak]
   - (man) fix typos  [Masatake YAMATO]
   - (sample) fix error message  [Karel Zak]
   - (samples)  fix format truncation warning  [Thomas Weißschuh]
   - (samples) remove filter.c  [Karel Zak]
   - (samples/fromfile) properly handle return value from getline()  [Thomas Weißschuh]
   - (tests) add test for continuous json output  [Thomas Weißschuh]
   - Add --highlight option to filter sample  [Karel Zak]
   - Export internally used types to API  [Karel Zak]
   - accept '% -' in column name for filters  [Karel Zak]
   - accept also '/' in column name for filters  [Karel Zak]
   - accept apostrophe as quote for strings in filter  [Karel Zak]
   - accept no data for custom wrapping cells  [Karel Zak]
   - add --{export,raw,json} to wrap sample  [Karel Zak]
   - add API to join filter and columns  [Karel Zak]
   - add filter API docs  [Karel Zak]
   - add filter sample  [Karel Zak]
   - add filter support to 'fromfile' sample  [Karel Zak]
   - add new functions to API docs  [Karel Zak]
   - add parser header files  [Karel Zak]
   - add scols-filter.5 man page  [Karel Zak]
   - add scols_cell_refer_memory()  [Karel Zak]
   - add support for zero separated wrap data  [Karel Zak]
   - add table cursor  [Karel Zak]
   - add wrap-zero test  [Karel Zak]
   - always print vertical symbol  [Karel Zak]
   - build filter scanner and parser header files too  [Karel Zak]
   - cleanup datafunc() API  [Karel Zak]
   - don't directly access struct members  [Karel Zak]
   - don't include hidden headers in column width calculation  [Thomas Weißschuh]
   - drop spourious newline in between streamed JSON objects  [Thomas Weißschuh]
   - fix columns reduction  [Karel Zak]
   - fix filter param copying  [Karel Zak]
   - fix filter parser initialization  [Karel Zak]
   - fix memory leak on filter parser error  [Karel Zak]
   - fix typo in comment  [Karel Zak]
   - fix typo in parser tokens  [Karel Zak]
   - fix uninitialized local variable in sample  [Karel Zak]
   - flush correct stream  [Thomas Weißschuh]
   - free after error in filter sample  [Karel Zak]
   - handle nameless tables in export format  [Thomas Weißschuh]
   - implement filter based counters  [Karel Zak]
   - improve and fix scols_column_set_properties()  [Karel Zak]
   - improve cell data preparation for non-wrapping cases  [Karel Zak]
   - improve filter integration, use JSON to dump  [Karel Zak]
   - improve parser error messages  [Karel Zak]
   - introduce basic files for filter implementation  [Karel Zak]
   - introduce column type  [Karel Zak]
   - make calculation more robust  [Karel Zak]
   - make cell data printing more robust  [Karel Zak]
   - make sure counter is initialized  [Karel Zak]
   - multi-line cells refactoring  [Karel Zak]
   - only recognize closed object as final element  [Thomas Weißschuh]
   - prefer float in filter expression  [Karel Zak]
   - reset cell wrapping if all done  [Karel Zak]
   - search also by normalized column names (aka 'shellvar' name)  [Karel Zak]
   - support SCOLS_JSON_FLOAT in print API  [Karel Zak]
   - support \x?? for data by samples/fromfile.c  [Karel Zak]
   - update gitignore  [Karel Zak]
libuuid:
   - (test_uuid) make reading UUIDs from file more robust  [Thomas Weißschuh]
   - Add uuid_time64 for 64bit time_t on 32bit  [Thorsten Kukuk]
   - avoid truncate clocks.txt to improve performance  [Goldwyn Rodrigues]
   - fix uint64_t printf and scanf format  [Karel Zak]
libuuid/src/gen_uuid.c:
   - fix cs_min declaration  [Fabrice Fontaine]
logger:
   - initialize socket credentials contol union  [Karel Zak]
   - make sure path is terminated [coverity scan]  [Karel Zak]
   - use strncpy instead of strcpy  [Thomas Weißschuh]
login:
   - Initialize noauth from login.noauth credential  [Daan De Meyer]
   - Use pid_t for child_pid  [Tobias Stoeckmann]
   - access login.noauth file directly  [Tobias Stoeckmann]
   - document blank treatment in shell field  [Tobias Stoeckmann]
   - fix memory leak [coverity scan]  [Karel Zak]
   - ignore return of audit_log_acct_message  [Thomas Weißschuh]
   - move comment  [Tobias Stoeckmann]
   - prevent undefined ioctl and tcsetattr calls  [Tobias Stoeckmann]
   - simplify name creation  [Tobias Stoeckmann]
   - unify pw_shell script test  [Tobias Stoeckmann]
   - use correct terminal fd during setup  [Tobias Stoeckmann]
   - use xasprintf  [Tobias Stoeckmann]
login-utils:
   - Report crashes on reboot lines insted of overlapping uptimes  [Troy Rollo]
   - include libgen.h for basename API  [Khem Raj]
loopdev:
   - report lost loop devices  [Junxiao Bi, Karel Zak]
losetup:
   - add --loop-ref and REF column  [Karel Zak]
   - add MAJ a MIN for device and backing-file  [Karel Zak]
   - cleanup device node modes  [Karel Zak]
   - deduplicate find_unused() logic  [Thomas Weißschuh]
   - fix JSON MAJ MIN  [Karel Zak]
   - improve "sector boundary" warning  [Karel Zak]
   - make --output-all more usable  [Karel Zak]
   - report lost loop devices for finding free loop  [Junxiao Bi]
lsblk:
   - add --filter  [Karel Zak]
   - add --highlight  [Karel Zak]
   - add --list-columns  [Karel Zak]
   - add docs for filters and counters  [Karel Zak]
   - add hint that partition start is in sectors  [Karel Zak]
   - add scols counters support  [Karel Zak]
   - add separate MAJ and MIN columns  [Karel Zak]
   - always set column type  [Karel Zak]
   - define cell data-types, use raw data for SIZEs  [Karel Zak]
   - explain FSAVAIL in better way  [Karel Zak]
   - fix in-tree filtering  [Karel Zak]
   - ignore duplicate lines for counters  [Karel Zak]
   - improve --tree description  [Karel Zak]
   - make sure all line data are deallocated  [Karel Zak]
   - rename sortdata to rawdata  [Karel Zak]
   - report all unknown columns in filter  [Karel Zak]
   - split filter allocation and initialization  [Karel Zak]
   - support normalized column names on command line  [Karel Zak]
   - update after rebase  [Karel Zak]
   - use zero to separate lines in multi-line cells  [Karel Zak]
lsclocks:
   - Fix markup and typos in man page  [Mario Blättermann]
   - Fix markup in man page  [Mario Blättermann]
   - add --output-all  [Thomas Weißschuh]
   - add COL_TYPE  [Thomas Weißschuh]
   - add NS_OFFSET column  [Thomas Weißschuh]
   - add column RESOL for clock resolution  [Thomas Weißschuh]
   - add relative time  [Thomas Weißschuh]
   - add support for RTC  [Thomas Weißschuh]
   - add support for cpu clocks  [Thomas Weißschuh]
   - add support for dynamic clocks  [Thomas Weißschuh]
   - automatically discover dynamic clocks  [Thomas Weißschuh]
   - don't fail without dynamic clocks  [Thomas Weißschuh]
   - factor out path based clocks  [Thomas Weißschuh]
   - improve dynamic clocks docs and completion  [Thomas Weißschuh]
   - new util to interact with system clocks  [Thomas Weißschuh]
   - refer to correct lsclocks(1) manpage  [Thomas Weißschuh]
   - remove unused code  [Karel Zak]
   - rename column RESOLUTION to RESOL_RAW  [Thomas Weißschuh]
   - split out data function  [Thomas Weißschuh]
   - trim default columns  [Thomas Weißschuh]
lscpu:
   - Even more Arm part numbers (early 2023)  [Jeremy Linton]
   - Use 4K buffer size instead of BUFSIZ  [Khem Raj]
   - add procfs-sysfs dump from VisionFive 2  [Jan Engelhardt]
   - cure empty output of lscpu -b/-p  [Jan Engelhardt]
   - fix caches separator for --parse=<list>  [Karel Zak]
   - remove usage of VLA  [Thomas Weißschuh]
lscpu-cputype.c:
   - assign value to multiple variables (ar->bit32 and ar->bit64) clang with -Wcomma will emit an warning of "misuse of comma operator". Since the value that will be assigned, is the same for both (bit32 and bit64), just assigning directly to both variables seems reasonable.  [rilysh]
lsdf:
   - make the code for filling SOURCE, PARTITION, and MAJMIN reusable  [Masatake YAMATO]
lsfd:
   - (comment) fix a typo  [Masatake YAMATO]
   - (filter) accept floating point numbers in expressions  [Masatake YAMATO]
   - (filter) improve error message  [Masatake YAMATO]
   - (filter) reduce duplicated code in macro definitions  [Masatake YAMATO]
   - (filter) support floating point number used in columns  [Masatake YAMATO]
   - (filter) weakly support ARRAY_STRING and ARRAY_NUMBER json types  [Masatake YAMATO]
   - (man) add bps(8) and ss(8) to the "SEE ALSO" section  [Masatake YAMATO]
   - (man) document --list-columns as the way to list columns  [Masatake YAMATO]
   - (man) document the ENDPOINT column for UNIX socket  [Masatake YAMATO]
   - (man) fix the broken page output for the description of NAME column  [Masatake YAMATO]
   - (man) fix the form for the optional argument of --inet option  [Masatake YAMATO]
   - (man) refer to scols-filter(5)  [Masatake YAMATO]
   - (man) update the description of ENDPOINTS column of UNIX-Stream sockets  [Masatake YAMATO]
   - (man) write about SOCK.SHUTDOWN column  [Masatake YAMATO]
   - (man) write about XMODE.m and classical system calls for multiplexing  [Masatake YAMATO]
   - (refactor) introduce a content data type for char devices  [Masatake YAMATO]
   - (refactor) make the code comparing struct lock objects reusable  [Masatake YAMATO]
   - (refactor) make the code for traversing threads reusable  [Masatake YAMATO]
   - (refactor) make the way to handle character devices extensible  [Masatake YAMATO]
   - (refactor) move miscdev specific code to cdev_misc_ops  [Masatake YAMATO]
   - (refactor) unify the invocations of  sysfs_get_byteorder()  [Masatake YAMATO]
   - (test) add a case for testing a unix socket including newline characters in its path name  [Masatake YAMATO]
   - (tests) don't run mqueue test on byteorder mismatch  [Thomas Weißschuh]
   - (tests) fix process leak  [Masatake YAMATO]
   - (tests) fix typo  [Thomas Weißschuh]
   - Fix typos in man page  [Mario Blättermann]
   - add "nsfs" to the nodev_table to fill SOURCE column for nsfs files  [Masatake YAMATO]
   - add 'D' flag for representing deleted files to XMODE column  [Masatake YAMATO]
   - add 'm' flag representing "multiplexed by epoll_wait(2)" to XMODE column  [Masatake YAMATO]
   - add BPF-MAP.TYPE, BPF-MAP.TYPE.RAW, and BPF-MAP.ID columns  [Masatake YAMATO]
   - add BPF-PROG.TYPE, BPF-PROG.TYPE.RAW, and BPF-PROG.ID columns  [Masatake YAMATO]
   - add BPF.NAME column  [Masatake YAMATO]
   - add EVENTFD.ID column  [Masatake YAMATO]
   - add PTMX.TTY-INDEX column  [Masatake YAMATO]
   - add SOCK.SHUTDOWN column  [Masatake YAMATO]
   - add TUN.IFFACE, a column for interfaces behind tun devices  [Masatake YAMATO]
   - add a back pointer as a member of anon_eventfd_data  [Masatake YAMATO]
   - add a helper function for adding a nodev to the nodev_table  [Masatake YAMATO]
   - add a helper function, add_endpoint  [Masatake YAMATO]
   - add a helper function, init_endpoint  [Masatake YAMATO]
   - add a helper function, new_ipc  [Masatake YAMATO]
   - add a helper macro, foreach_endpoint  [Masatake YAMATO]
   - add a new type "mqueue", a type for POSIX Mqueue  [Masatake YAMATO]
   - add a whitespace  [Masatake YAMATO]
   - add attach_xinfo and get_ipc_class methods to cdev_ops  [Masatake YAMATO]
   - add comment listing functions names importing via #include  [Masatake YAMATO]
   - add const modifier  [Thomas Weißschuh]
   - add flags, [-lL], representing file lock/lease states to XMODE column  [Masatake YAMATO]
   - add tmpfs as source of sysvipc to the the nodev_table  [Masatake YAMATO]
   - add xstrfappend and xstrvfappend  [Masatake YAMATO]
   - adjust coding style  [Masatake YAMATO]
   - append SOCK.SHUTDOWN value to ENDPOINTS column of UNIX-STREAM sockets  [Masatake YAMATO]
   - assign a class to the file in new_file()  [Masatake YAMATO]
   - avoid passing NULL to qsort()  [Thomas Weißschuh]
   - avoid undefined behavior  [Thomas Weißschuh]
   - build lsfd even if kcmp.h is not available  [Masatake YAMATO]
   - cache the result of checking whether "XMODE" column is enabled or not  [Masatake YAMATO]
   - call xinfo backend method before calling socket generic method when filling columns  [Masatake YAMATO]
   - choose anon_ops declarative way  [Masatake YAMATO]
   - cleanup --list-columns  [Karel Zak]
   - collect the device number for mqueue fs in the initialization stage  [Masatake YAMATO]
   - delete redundant parentheses surrounding return value  [Masatake YAMATO]
   - don't capitalize the help strings for the columns  [Masatake YAMATO]
   - don't check the value returned from new_file()  [Masatake YAMATO]
   - fill ENDPOINTS column for eventfd  [Masatake YAMATO]
   - fill ENDPOINTS column for pty devices  [Masatake YAMATO]
   - fill ENDPOINTS column of POSIX Mqueue  [Masatake YAMATO]
   - fill ENDPOINTS column of unix socket using UNIX_DIAG_PEER information  [Masatake YAMATO]
   - fill NAME column of inotify files with the information about their monitoring targets  [Masatake YAMATO]
   - fix a misleading parameter name  [Masatake YAMATO]
   - fix a sentence in comment  [Masatake YAMATO]
   - fix memory leak in append_filter_expr()  [Karel Zak]
   - fix specifying wrong JSON typs when building the help message  [Masatake YAMATO]
   - fix wrong inconsistency in extracting cwd and root associations  [Masatake YAMATO]
   - include common headers in lsfd.h  [Masatake YAMATO]
   - include system header files first  [Masatake YAMATO]
   - initialize pagesize in an earlier stage  [Masatake YAMATO]
   - initialize the ipc table before loading lists of unix socket peers via netlink diag  [Masatake YAMATO]
   - introduce -H, --list-columns option for making help messages short  [Masatake YAMATO]
   - introduce XMODE column, extensible variant of MODE  [Masatake YAMATO]
   - keep filter-only columns hidden  [Karel Zak]
   - make the order of calling finalize_* and initialize_* consistent  [Masatake YAMATO]
   - make the sock_xinfo layer be able to prepare an ipc_class for a given socket  [Masatake YAMATO]
   - mark XMODE.m on fds monitored by poll(2) and ppoll(2)  [Masatake YAMATO]
   - mark XMODE.m on fds monitored by select(2) and pselect6(2)  [Masatake YAMATO]
   - move a local variable to a narrower scope  [Masatake YAMATO]
   - print file descriptors targeted by eventpoll files  [Masatake YAMATO]
   - print the detail of the timer associated with a timerfd  [Masatake YAMATO]
   - print the masks specified in signalfds  [Masatake YAMATO]
   - re-fill unix socket paths with sockdiag netlink interface  [Masatake YAMATO]
   - rearrange the aligment of the help messages  [Masatake YAMATO]
   - show default columns in the help message  [Masatake YAMATO]
   - switch to c99-conformant alignment specification  [Thomas Weißschuh]
   - update the help message for XMODE column  [Masatake YAMATO]
   - use ARRAY_STRING and ARRAY_NUMBER json types in some columns  [Masatake YAMATO]
   - use SCOLS_JSON_FLOAT  [Karel Zak]
   - use \n as the separator in EVENTPOLL.TFDS column  [Masatake YAMATO]
   - use \n as the separator in INOTIFY.INODES and INOTIFY.INODES.RAW columns  [Masatake YAMATO]
   - use filter and counters from libsmartcols  [Karel Zak]
   - use helper functions in column-list-table.h  [Masatake YAMATO]
   - use scols_table_get_column_by_name  [Masatake YAMATO]
   - use the specified output stream for printing help messages  [Masatake YAMATO]
   - use xstrdup instead of xasprintf(...\"%s\"  [Masatake YAMATO]
   - utilize /proc/tty/drivers for filling SOURCE column of tty devices  [Masatake YAMATO]
   - write more about nsfs in comment  [Masatake YAMATO]
lsfd,test_mkfds:
   - (cosmetic) remove whitespaces between functions and their arglists  [Masatake YAMATO]
lsfd-filter:
   - constify filter logic  [Thomas Weißschuh]
lsfd.1.adoc:
   - document BPF.NAME column  [Masatake YAMATO]
   - fix a typo  [Masatake YAMATO]
   - fix typos  [Masatake YAMATO]
   - revise type names for columns  [Masatake YAMATO]
   - update for signalfds  [Masatake YAMATO]
   - write about timerfd  [Masatake YAMATO]
lslocks:
   - (fix) set JSON type for COL_SIZE even when --bytes is specified  [Masatake YAMATO]
   - (man) add missing fields  [Masatake YAMATO]
   - (man) document LEASE type  [Masatake YAMATO]
   - (man) update the note about OFDLCK  [Masatake YAMATO]
   - (preparation) add a fd number to the lock struct when loading lock info from /proc/$pid/fdinfo/$fd  [Masatake YAMATO]
   - (refactor) add a helper function returning JSON type for a given column  [Masatake YAMATO]
   - (refactor) lift up the code destroying the lock list for future extension  [Masatake YAMATO]
   - (refactor) make the data structure for storing lock information replacable  [Masatake YAMATO]
   - (refactor) remove 'pid' global variable  [Masatake YAMATO]
   - (refactor) use a tree for storing lock information extracted from /proc/$pid/fdinfo/$fd  [Masatake YAMATO]
   - (test) add a case  [Masatake YAMATO]
   - (test) add a case for OFDLCK type locks  [Masatake YAMATO]
   - add -H option printing avaiable columns  [Masatake YAMATO]
   - add HOLDERS column  [Masatake YAMATO]
   - add a missing "break;" in a switch/case statement  [Masatake YAMATO]
   - cleanup --list-columns  [Karel Zak]
   - don't attempt to open /proc/-1/fd/  [Jakub Wilk]
   - improve --list-columns  [Karel Zak]
   - refactor the code reading /proc/locks  [Masatake YAMATO]
   - rename functions for future extension  [Masatake YAMATO]
   - store list_add_tail when storing information extracted from /proc/$pid/fdinfo/$fd  [Masatake YAMATO]
   - use information extracted from "locks  " column of /proc/$pid/fdinfo/*  [Masatake YAMATO]
lslogins:
   - (man) fix -y option formatting  [Thomas Weißschuh]
   - fix realloc() loop allocation size  [Thomas Weißschuh]
m4:
   - update pkg.m4  [Thomas Weißschuh]
man:
   - Add enosys and lsclocks to po4a.cfg  [Mario Blättermann]
meson:
   - add check for linux/mount.h  [Thomas Weißschuh]
   - add check for struct statx  [Thomas Weißschuh]
   - add conditionalization for test progs  [Zbigniew Jędrzejewski-Szmek]
   - add missing scols sample  [Karel Zak]
   - avoid int operation with non-int  [Thomas Weißschuh]
   - build test_mount_optlist  [Thomas Weißschuh]
   - bump required version to 0.60.0  [Thomas Weißschuh]
   - check for HAVE_STRUCT_STATX_STX_MNT_ID  [Karel Zak]
   - check for _NL_TIME_WEEK_1STDAY in langinfo.h  [Christian Hesse]
   - conditionalize waitpid  [Zbigniew Jędrzejewski-Szmek]
   - don't try to build test_ca without libcap-ng  [Thomas Weißschuh]
   - fix copy & past error  [Karel Zak]
   - implement HAVE_PTY  [Zbigniew Jędrzejewski-Szmek]
   - include bash-completion for newgrp  [Christian Hesse]
   - include bash-completion for write  [Christian Hesse]
   - install chfn setuid  [Christian Hesse]
   - install chsh setuid  [Christian Hesse]
   - install mount setuid  [Christian Hesse]
   - install newgrp setuid  [Christian Hesse]
   - install su setuid  [Christian Hesse]
   - install symlink for vigr man page  [Christian Hesse]
   - install umount setuid  [Christian Hesse]
   - install wall executable with group 'tty'  [Christian Hesse]
   - install wall setgid  [Christian Hesse]
   - install write executable with group 'tty'  [Christian Hesse]
   - install write setgid  [Christian Hesse]
   - properly handle gettext non-existence  [Thomas Weißschuh]
   - remove scols filter sample  [Karel Zak]
   - require 0.57  [Thomas Weißschuh]
   - run tests if with option program-tests  [sewn]
   - try to always use 64bit time support on glibc  [Thomas Weißschuh]
   - update  for libsmartcols filter  [Karel Zak]
   - use bison --defines=HEADER  [Karel Zak]
   - use meson features instead of bash  [sewn]
misc:
   - constify some fields  [Thomas Weißschuh]
mkfs.minix:
   - handle 64bit time on 32bit system  [Thomas Weißschuh]
mkswap:
   - (tests) don't overwrite logfiles  [Thomas Weißschuh]
   - (tests) validate existence of truncate command  [Thomas Weißschuh]
   - implement --file  [Vicki Pfau]
   - implement --offset  [Thomas Weißschuh]
more:
   - avoid out-of-bound access  [Thomas Weißschuh]
   - exit if POLLERR and POLLHUP on stdin is received  [Goldwyn Rodrigues]
   - exit if POLLHUP or POLLERR on stdin is received  [Goldwyn Rodrigues]
   - remove usage of alloca()  [Thomas Weißschuh]
mount:
   - (tests) don't create /dev/nul  [Thomas Weißschuh]
   - (tests) explicitly use test fstab location  [Thomas Weißschuh]
   - (tests) reuse well-known per-test fstab location  [Thomas Weißschuh]
   - (tests) test mount helper with multiple filesystems  [Thomas Weißschuh]
   - Fix markup and typos in man page  [Mario Blättermann]
   - add --map-users and --map-groups convenience options  [Chris Webb]
   - improve code readability  [Karel Zak]
nsenter:
   - (man) add --keep-caps  [Karel Zak]
   - add missing free()  [Karel Zak]
   - add option `-c` to join the cgroup of target process  [u2386]
   - avoid NULL pointer dereference [coverity scan]  [Karel Zak]
   - fix possible NULL dereferece [coverity scan]  [Karel Zak]
pg:
   - use snprintf to build string  [Thomas Weißschuh]
pipesz:
   - avoid dead store  [Thomas Weißschuh]
po:
   - add ro.po (from translationproject.org)  [Remus-Gabriel Chelu]
   - merge changes  [Karel Zak]
   - update de.po (from translationproject.org)  [Hermann Beckers]
   - update es.po (from translationproject.org)  [Antonio Ceballos Roa]
   - update hr.po (from translationproject.org)  [Božidar Putanec]
   - update ja.po (from translationproject.org)  [Takeshi Hamasaki]
   - update sr.po (from translationproject.org)  [Мирослав Николић]
   - update tr.po (from translationproject.org)  [Emir SARI]
po-man:
   - add ko.po (from translationproject.org)  [Seong-ho Cho]
   - add ro.po (from translationproject.org)  [Remus-Gabriel Chelu]
   - merge changes  [Karel Zak]
   - update de.po (from translationproject.org)  [Mario Blättermann]
   - update fr.po (from translationproject.org)  [Frédéric Marchal]
   - update sr.po (from translationproject.org)  [Мирослав Николић]
   - update uk.po (from translationproject.org)  [Yuri Chornoivan]
prlimit:
   - (man) fix formatting  [Jakub Wilk]
   - reject trailing junk in limits without " "  [Jakub Wilk]
procfs:
   - add a helper function to access /proc/$pid/syscall  [Masatake YAMATO]
readprofile:
   - use xasprintf to build string  [Thomas Weißschuh]
rename:
   - properly handle directories with trailing slash  [Thomas Weißschuh]
runuser.1.adoc:
   - Move -m|-p|--preserve-environment in order  [Sebastian Pipping]
runuser|su:
   - Start supporting option -T|--no-pty  [Sebastian Pipping]
script-playutils:
   - close filestream in case ignore_line() fails  [Thomas Weißschuh]
scriptreplay:
   - support ctrl+s and ctrl+g  [Karel Zak]
setarch:
   - add PER_LINUX_FDPIC fallback  [Karel Zak]
   - add riscv64/riscv32 support  [Michal Biesek]
setpriv:
   - add landlock support  [Thomas Weißschuh]
   - fix group argument completion  [Thomas Weißschuh]
setterm:
   - avoid restoring flags from uninitialized memory  [Chris Hofstaedtler]
sfdisk:
   - Fix markup in man page  [Mario Blättermann]
   - add hint about duplicate UUIDs when use dump  [Karel Zak]
sha1:
   - properly wipe variables  [Thomas Weißschuh]
strv:
   - make strv_new_api static  [Thomas Weißschuh]
sulogin:
   - relabel terminal according to SELinux policy  [Christian Göttsche]
   - use get_terminal_default_type()  [Karel Zak]
swapon:
   - (man) fix --priority description  [Karel Zak]
   - (tests) abort test on failing commands  [Thomas Weißschuh]
sys-utils:
   - cleanup license lines, add SPDX  [Karel Zak]
   - fix SELinux context example in mount.8  [Todd Zullinger]
sys-utils/lscpu:
   - Use ul_path_scanf where possible  [Tobias Stoeckmann]
term-utils:
   - fix indentation  [Karel Zak]
test:
   - (lsfd  column-xmode)  add mising "wait" invocation  [Masatake YAMATO]
   - (lsfd)  add a case for l and L flags in XMODE column  [Masatake YAMATO]
   - (lsfd) add a case for testing BPF-MAP.TYPE and BPF-MAP.TYPE.RAW columns  [Masatake YAMATO]
   - (lsfd) add a case for testing BPF-PROG.TYPE and BPF-PROG.TYPE.RAW columns  [Masatake YAMATO]
   - (lsfd) add a case for testing DELETED column  [Masatake YAMATO]
   - (lsfd) add a subcase for testing NAME column for a deleted file  [Masatake YAMATO]
   - (mkfds  bpf-map) new factory  [Masatake YAMATO]
   - (mkfds  bpf-prog) new factory  [Masatake YAMATO]
   - (mkfds  make-regular-file) add a parameter for file locking  [Masatake YAMATO]
   - (mkfds  make-regular-file) add a parameter for making the new file readable  [Masatake YAMATO]
   - (mkfds  make-regular-file) add a parameter for writing some bytes  [Masatake YAMATO]
   - (mkfds  make-regular-file) delete the created file when an error occurs  [Masatake YAMATO]
   - (mkfds  make-regular-file) make 'fd' local variable reusable  [Masatake YAMATO]
   - (mkfds  ro-regular-file) add a parameter for a read lease  [Masatake YAMATO]
   - (mkfds) add "make-regular-file" factory  [Masatake YAMATO]
test_enosys:
   - fix build on old kernels  [Thomas Weißschuh]
test_mkfds:
   - avoid "ignoring return value of ‘write’ declared with attribute ‘warn_unused_result’"  [Masatake YAMATO]
test_uuidd:
   - make pthread_t formatting more robust  [Thomas Weißschuh]
tests:
   - (cosmetic,lslocks) trim whitespaces at the end of line  [Masatake YAMATO]
   - (functions.sh) create variable for test fstab location  [Thomas Weißschuh]
   - (functions.sh) use per-test fstab file  [Thomas Weißschuh]
   - (lsfd  column-xmode) do rm -f the file for testing before making it  [Masatake YAMATO]
   - (lsfd  column-xmode) ignore "rwx" mappings  [Masatake YAMATO]
   - (lsfd  column-xmode) skip some subtests if OFD locks are not available  [Masatake YAMATO]
   - (lsfd  filter-floating-point-nums) use --raw output to make the case more robust  [Masatake YAMATO]
   - (lsfd  mkfds-*) alter the L4 ports for avoiding the conflict with option-inet test case  [Masatake YAMATO]
   - (lsfd  mkfds-bpf-map) chmod a+x  [Masatake YAMATO]
   - (lsfd  mkfds-inotify) use findmnt(1) instead of stat(1) to get bdev numbers  [Masatake YAMATO]
   - (lsfd  mkfds-socketpair) make a case for testing DGRAM a subtest and add a subtest for STREAM  [Masatake YAMATO]
   - (lsfd  mkfds-unix-dgram) don't depend on the number of whitespaces in the output  [Masatake YAMATO]
   - (lsfd  option-inet) get child-processes' pids via fifo  [Masatake YAMATO]
   - (lsfd) add a case for testing ENDPOINTS column of UNIX-STREAM sockets  [Masatake YAMATO]
   - (lsfd) add a case for testing EVENTPOLL.TFDS column  [Masatake YAMATO]
   - (lsfd) add a case for testing INOTIFY.INODES.RAW column  [Masatake YAMATO]
   - (lsfd) add a case for testing SOCK.SHUTDOWN column  [Masatake YAMATO]
   - (lsfd) add a case for testing SOURCE column for SysV shmem mappings  [Masatake YAMATO]
   - (lsfd) add a case for testing signalfd related columns  [Masatake YAMATO]
   - (lsfd) add a case for testing timerfd related columns  [Masatake YAMATO]
   - (lsfd) add a case for verifying ENDPOINTS column output in JSON mode  [Masatake YAMATO]
   - (lsfd) add a case testing 'm' flag in XMODE column  [Masatake YAMATO]
   - (lsfd) add a case testing INOTIFY.INODES.RAW column on btrfs  [Masatake YAMATO]
   - (lsfd) add a case testing NAME, SOURCE, ENDPOINTS, and PTMX.TTY-INDEX columns of pts fds  [Masatake YAMATO]
   - (lsfd) add a case testing TUN.IFACE column  [Masatake YAMATO]
   - (lsfd) add a case testing XMODE.m for classical syscalls for multiplexing  [Masatake YAMATO]
   - (lsfd) add cases for POSIX Mqueue  [Masatake YAMATO]
   - (lsfd) add cases for eventfd  [Masatake YAMATO]
   - (lsfd) add lsfd_check_mkfds_factory as a help function  [Masatake YAMATO]
   - (lsfd) avoid race conditions (part 1)  [Masatake YAMATO]
   - (lsfd) don't run the unix-stream testcase including newlines in the path on qemu-user  [Masatake YAMATO]
   - (lsfd) extend the cases for testing BPF.NAME column  [Masatake YAMATO]
   - (lsfd) extend the mkfds-socketpair case to test ENDPOINTS with SOCK.SHUTDOWN info  [Masatake YAMATO]
   - (lsfd) show the entry for mqueue in /proc/self/mountinfo  [Masatake YAMATO]
   - (lsfd) skip mkfds-netns if SIOCGSKNS is not defined  [Masatake YAMATO]
   - (lsfd/filter) add a case for comparing floating point numbers  [Masatake YAMATO]
   - (lslcoks) insert a sleep between taking a lock and running lslocks  [Masatake YAMATO]
   - (lslocks) add cases testing HOLDERS column  [Masatake YAMATO]
   - (lslocks) add missing ts_finalize call  [Masatake YAMATO]
   - (mkfds) add / and /etc/fstab as the monitoring targets to inotify  [Masatake YAMATO]
   - (mkfds) add a factor for opening tun device  [Masatake YAMATO]
   - (mkfds) add a factory to make SysV shmem  [Masatake YAMATO]
   - (mkfds) add a factory to make a signalfd  [Masatake YAMATO]
   - (mkfds) add a factory to make a timerfd  [Masatake YAMATO]
   - (mkfds) add a factory to make an eventpoll fd  [Masatake YAMATO]
   - (mkfds) add eventfd factory  [Masatake YAMATO]
   - (mkfds) add mqueue factory  [Masatake YAMATO]
   - (mkfds) print a whitespace only when the running factory has "report" method  [Masatake YAMATO]
   - (mkfds) provide the way to declare the number of extra printing values  [Masatake YAMATO]
   - (refactor (test_mkfds, lsfd)) use TS_EXIT_NOTSUPP instead of EXIT_ENOSYS  [Masatake YAMATO]
   - (run.sh) detect builddir from working directory  [Thomas Weißschuh]
   - (test_mkfds  inotify) add "dir" and "file" parameters  [Masatake YAMATO]
   - (test_mkfds  make-regular-file) add a new parameter, "dupfd"  [Masatake YAMATO]
   - (test_mkfds  mkfds-multiplexing) dump /proc/$pid/syscall for debugging  [Masatake YAMATO]
   - (test_mkfds  mkfds-multiplexing) make the output of ts_skip_subtest visible  [Masatake YAMATO]
   - (test_mkfds  pty) add a new factory  [Masatake YAMATO]
   - (test_mkfds  socketpair) add "halfclose" parameter  [Masatake YAMATO]
   - (test_mkfds  {bpf-prog,bpf-map}) fix memory leaks  [Masatake YAMATO]
   - (test_mkfds) add --is-available option  [Masatake YAMATO]
   - (test_mkfds) add a new factory "multiplexing"  [Masatake YAMATO]
   - (test_mkfds) add missing PARAM_END marker  [Masatake YAMATO]
   - (test_mkfds) add poll multiplexer  [Masatake YAMATO]
   - (test_mkfds) add ppoll multiplexer  [Masatake YAMATO]
   - (test_mkfds) add pselect6 and select multiplexers  [Masatake YAMATO]
   - (test_mkfds) allow to add factory-made fds to the multiplexer as event source  [Masatake YAMATO]
   - (test_mkfds) include locale headers first to define _GNU_SOURCE  [Masatake YAMATO]
   - (test_mkfds) initialize a proper union member  [Masatake YAMATO]
   - (test_mkfds) monitor stdin by default  [Masatake YAMATO]
   - (test_mkfds) revise the usage of " __attribute__((__unused__))"  [Masatake YAMATO]
   - (test_mkfds) use SYS_bpf instead of __NR_bpf  [Masatake YAMATO]
   - (test_mkfds) use err() when a system call fails  [Masatake YAMATO]
   - (test_mkfds, refactor) make the function for waiting events plugable  [Masatake YAMATO]
   - add libsmartcols filter tests  [Karel Zak]
   - add missing file and improve options-missing test  [Karel Zak]
   - add omitted files  [Karel Zak]
   - add optlist tests  [Karel Zak]
   - add sysinfo to show sizeof(time_t)  [Thomas Weißschuh]
   - add ts_skip_capability  [Masatake YAMATO]
   - add ts_skip_docker  [Thomas Weißschuh]
   - add user and user=name mount test  [Karel Zak]
   - constify a sysinfo helpers struct  [Thomas Weißschuh]
   - don't keep bison messages in tests  [Karel Zak]
   - fix capability testing  [Thomas Weißschuh]
   - fix memory leak in scols fromfile  [Karel Zak]
   - fix subtests containing spaces in their name  [Thomas Weißschuh]
   - increase delay for waitpid test  [Goldwyn Rodrigues]
   - make mount/special more robust  [Karel Zak]
   - make ts_skip_capability accepts the output of older version of getpcaps  [Masatake YAMATO]
   - skip broken tests on docker  [Thomas Weißschuh]
   - update lsfd broken filter test  [Karel Zak]
   - use array keys in more robust way  [Karel Zak]
   - use scols_column_set_properties() in 'fromfile' sample  [Karel Zak]
tests,autotools:
   - add TESTS_COMPONENTS macro for specfying test components from make cmdline  [Masatake YAMATO]
timeutils:
   - add an inline funciton, is_timespecset()  [Masatake YAMATO]
   - add strtimespec_relative  [Thomas Weißschuh]
tools:
   - (asciidoctor) explicitly require extensions module  [Thomas Weißschuh]
tools/all_syscalls:
   - use pipefail  [sewn]
   - use sh and replace awk with grep & sed  [sewn]
treewide:
   - explicitly mark unused arguments  [Thomas Weißschuh]
   - fix newlines when using fputs  [Thomas Weißschuh]
   - use (x)reallocarray() when applicable  [Thomas Weißschuh]
   - use reallocarray to allocated memory that will be reallocated  [Thomas Weißschuh]
ttyutils:
   - improve get_terminal_default_type() code  [Karel Zak]
uclampset:
   - Remove validation logic  [Qais Yousef]
   - doc  Add a reference to latest kernel documentation  [Qais Yousef]
umount:
   - handle bindmounts during --recursive  [Thomas Weißschuh]
unshare:
   - Add --map-users=all and --map-groups=all  [Chris Webb]
   - Move implementation of --keep-caps option to library function  [David Gibson]
   - Set uid and gid maps directly when run as root  [Chris Webb]
   - Support multiple ID ranges for user and group maps  [Chris Webb]
   - allow negative time offsets  [Thomas Weißschuh]
   - don't try to reset the disposition of SIGKILL  [Chris Webb]
   - fix error message for unexpected time offsets  [Thomas Weißschuh]
   - make sure map_range.next is initialized [coverity scan]  [Karel Zak]
utmpdump:
   - validate subsecond granularity  [Thomas Weißschuh]
uuidd:
   - Fix markup in man page (uuidd.8)  [Mario Blättermann]
   - add cont_clock persistence  [Michael Trapp]
   - enable cont-clock in service file  [Karel Zak]
   - improve man page for -cont-clock  [Karel Zak]
uuidgen:
   - add option --count  [Karel Zak]
   - mark some options mutually exclusive  [Karel Zak]
verity:
   - modernize example in manpage  [Luca Boccassi]
   - use <roothash>-verity as the device mapper name instead of libmnt_<image>  [Luca Boccassi]
waitpid:
   - only build when pidfd_open is available  [Thomas Weißschuh]
   - warn of "exited" only when --verbose is given  [Masatake YAMATO]
wall:
   - do not error for ttys that do not exist  [Mike Gilbert]
   - fix calloc cal [-Werror=calloc-transposed-args]  [Karel Zak]
   - query logind for list of users with tty (#2088)  [Thorsten Kukuk]
wdctl:
   - properyl test timeout conditions  [Thomas Weißschuh]
   - use only sysfs if sufficient  [Thomas Weißschuh]
wipefs:
   - (man) fix typos  [codefiles]
   - (tests) add test for all detected signatures  [Thomas Weißschuh]
   - (tests) remove necessity of root permissions  [Thomas Weißschuh]
   - allow storage of backups in specific location  [Thomas Weißschuh]
write:
   - Add missing section header in man page  [Mario Blättermann]
   - query logind for list of users with tty (#2088)  [Thorsten Kukuk]
xalloc.h:
   - add new functions  xstrappend, xstrputc, xstrvfappend, and xstrfappend  [Masatake YAMATO]
zramctl:
   - add hint about supported algorithms  [Karel Zak]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


