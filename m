Return-Path: <linux-fsdevel+bounces-42011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EFEA3AA84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 22:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF9C1665C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 21:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6933117A313;
	Tue, 18 Feb 2025 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MU3tAO7X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C172286287
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739912916; cv=none; b=Gltq2qAA5rBJ+W0dupNdhZuekpO0eIVQUjPUz2APt7xmnPW/Y9FhnGRpYfX717BIkglpF8icLepFoJAnQh5Hp2yhFtl6Vm8W6HnDIkw+6c7jF1c4NQMcZUfuzLoEwKT7sNsTppSy69pdGvLppxpcfBjDdpj/LjrSvhry81p0tjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739912916; c=relaxed/simple;
	bh=/69T7zMjPJtwtzpzlP0BaBgTA5ET6ggoxxzCvKNy17o=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZkoNKb27DggDBTt1EhvolTth8JTLjAY/+znzz+l/kVK9dfgh0PD1OQpFONVqJhYEPj3ckoWapg/pyVtAcZwF3xpy3hTKBXu2wv4ac+w/vQAoZslGXXcf43vW/Lonbq8pomn0J9cu6Cehdr374cgXuJD5kErQK55iqBAvQRWDEVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MU3tAO7X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739912912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rRDupzGYR7qNVjAKsM+rVJ21zIAFNzPQrSuVlEvkaV0=;
	b=MU3tAO7Xlnua+X6aKLyNqznfwnIW0ebnJxuBkfVoOUyNLyiXV81Ujgra9Uf44dZxxqhA6k
	T648k/zkMmvn4jhSdAYlmpYbuubDhVZrJL1uOneQV5zKWZ4wrOxWxDvMNiF+xuknI+XNY+
	JCqyJP+QFjF7XcN3lh99ZRYC9U5qbHQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-s1LQVlKGPRaQoIBLnkWwow-1; Tue,
 18 Feb 2025 16:08:29 -0500
X-MC-Unique: s1LQVlKGPRaQoIBLnkWwow-1
X-Mimecast-MFC-AGG-ID: s1LQVlKGPRaQoIBLnkWwow_1739912908
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D6251800876;
	Tue, 18 Feb 2025 21:08:28 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB5F41800359;
	Tue, 18 Feb 2025 21:08:25 +0000 (UTC)
Date: Tue, 18 Feb 2025 22:08:22 +0100
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.41-rc1
Message-ID: <yjic6yol5fmaftythlppbfoafsaqhaoh77spzp6m2izd757pcg@siegv7vwz6lf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93


The util-linux release v2.41-rc1 is now available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.41/
 
Feedback and bug reports, as always, are welcomed.
 
  Karel



util-linux 2.41 Release Notes
=============================
 
Release highlights
------------------

agetty:
  - Fixed an issue where issue files were not being printed from additional
    locations, such as /run or /usr/lib. This change now allows for the use of
    local information from /etc, in addition to generated files from /run and
    distribution-specific files from /usr/lib.

cfdisk and sfdisk:
  - Added support for the --sector-size command line option.

sfdisk:
  - Added a new option, --discard-free.

fdisk:
  - Added a new command, 'T', to discard sectors.

chrt:
  - The --sched-runtime now supports SCHED_{OTHER,BATCH} policies.

column:
  - Can now handle ANSI SGR colors inside OSC 8 hyperlink escape codes and sequences.

enosys:
  - Can now dump defined filters.

libmount:
  - Added experimental support for statmount() and listmount() syscalls.
  - This new functionality can be accessed using "findmnt --kernel=listmount".
  - Added a new mount option, X-mount.nocanonicalize[=source|target].
  - Added new mount extensions to the "ro" flag (ro[=vfs,fs]).
  - Added a new option, X-mount.noloop, to disable automatic loop device creation.
  - Now supports bind symlinks over symlinks.
  - Reads all kernel info/warning/error messages from new API syscalls (and mount(8) prints them).

libuuid:
  - Now supports RFC9562 UUIDs.

findmnt, lsblk, and lsfd:
  - Added a new --hyperlink command line option to print paths as terminal hyperlinks.

fdinmnt:
  - Can now address filesystems using --id and --uniq-id (requires listmount() kernel support).

flock:
  - Added support for the --fcntl command line option.

hardlink:
  - Can now prioritize specified trees on the command line using --prioritize-trees.
  - Can exclude sub-trees using --exclude-subtree or keep them in the current mount using --mount.
  - Duplicates can now be printed using --list-duplicates.

kwclock:
  - Added a new --param-index option to address position for RTC_PARAM_{GET,SET} ioctls.

kill:
  - Can now decode signal masks (e.g. as used in /proc) to signal names.

libblkid:
  - Made many changes to improve detection, including exfat, GPT, LUKS2, bitlocker, etc.

login:
  - Added support for LOGIN_ENV_SAFELIST in /etc/login.def.

lsfd:
  - Now supports pidfs and AF_VSOCK sockets.

lsipc, ipcmk, ipcrm:
  - Now supports POSIX ipc.

lslogins:
  - Now supports lastlog2.

lsns:
  - Added support for the --filter option.

build by meson:
  - Now supports translated man pages and has fixed many bugs.

mkswap:
  - The option --file should now be usable on btrfs.

nsenter:
  - Improved support for pidfd and can now join target process's socket net namespace.

scriptlive:
  - Added a new option, --echo <never|always|auto>.

zramctl:
  - Now supports COMP-RATIO and --algorithm-params.


Changes between v2.40 and v2.41
-------------------------------

CI:
   - Downgrade checkout version for compat build  [Michal Suchanek]
Include/strutils:
   - xstrncpy() returns the number of copied bytes  [Karel Zak]
README.licensing/flock:
   - Add MIT license mention  [Richard Purdie]
Wall:
   - Fix terminal flag usage . Signed-off-by Karel Zak <kzak@redhat.com>  [Karel Zak]
agetty:
   - Don't override TERM passed by the user  [Daan De Meyer]
   - Prevent cursor escape  [Stanislav Brabec]
   - add "systemd" to --version output  [Karel Zak]
   - always read additional issue file locations  [Karel Zak]
   - fix ambiguous ‘else’ [-Werror=dangling-else]  [Karel Zak]
   - fix resource leak  [Karel Zak]
   - make reload code more robust  [Karel Zak]
all_errnos/all_syscalls:
   - don't hardcode AWK invocation  [Thomas Weißschuh]
   - don't warn during cleanup  [Thomas Weißschuh]
   - fail if any step fails  [Thomas Weißschuh]
   - use sed to extract defines from headers  [Thomas Weißschuh]
audit-arch.h:
   - add defines for m68k, sh  [Chris Hofstaedtler]
autotools:
   - Check for BPF_OBJ_NAME_LEN (required by lsfd)  [Karel Zak]
   - Properly order install dependencies of pam_lastlog2  [Thomas Weißschuh]
   - add --disable-enosys, check for linux/audit.h  [Karel Zak]
   - add --disable-makeinstall-tty-setgid  [Karel Zak]
   - add Libs.private to uuid.pc  [Karel Zak]
   - add dependence on libsmartcols for lsclocks  [Karel Zak]
   - add missing HAVE_LIBLASTLOG2  [Karel Zak]
   - add sysusers support  [Karel Zak]
   - allow enabling dmesg with --disable-all-programs  [Henrik Lindström]
   - allow enabling lsblk with --disable-all-programs  [Henrik Lindström]
   - always add man-common/ to EXTRA_DIST  [Karel Zak]
   - check for statmount and listmount syscalls  [Karel Zak]
   - check for sys/vfs.h and linux/bpf.h  [Karel Zak]
   - define HAVE_LIBPTHREAD and PTHREAD_LIBS  [Karel Zak]
   - distribute pam_lastlog2/meson.build  [Thomas Weißschuh]
   - fix po-man discheck  [Karel Zak]
   - fix securedir and pam_lastlog2 install  [Karel Zak]
   - improve devel-non-docs config-gen scenario  [Karel Zak]
   - make errnos.h available without lsfd  [Thomas Weißschuh]
   - make pam install path configurable  [Thomas Weißschuh]
   - update po-man files on make dist  [Karel Zak]
bash-completion:
   - add `--pty` and `--no-pty` options for `su` and `runuser`  [Christoph Anton Mitterer]
   - add logger --sd-* completions  [Ville Skyttä]
   - add nsenter --net-socket  [Karel Zak]
   - complete `--user` only for `runuser`, not for `su`  [Christoph Anton Mitterer]
   - look rewrite completion logic  [Yao Zi]
   - updated lsns bash completion  [Prasanna Paithankar]
bcachefs:
   - Remove BCACHEFS_SB_MAX_SIZE & check  [Tony Asleson]
bits:
   - cleanup --help output, add missing _( )  [Karel Zak]
blkdev.h:
   - update location of SCSI device types  [Christoph Anton Mitterer]
blkdiscard:
   - (man) add note about fdisk  [Karel Zak]
blkid:
   - (tests) test output formats  [Thomas Weißschuh]
   - (tests) use correct blkid binary  [Thomas Weißschuh]
   - add json output format  [Thomas Weißschuh]
   - allow up to 64k erofs block sizes  [Eric Sandeen]
   - say "override" instead of "overwrite" in the --help text  [Benno Schulenberg]
blkpr:
   - grammarize the description of the tool and its options  [Benno Schulenberg]
blkzone:
   - correct the wording of an error message, from ioctl to function  [Benno Schulenberg]
   - improve the wording of an error message  [Benno Schulenberg]
buffer:
   - replace include of c.h with stddef.h  [Thomas Weißschuh]
build(deps):
   - bump actions/cache from 3 to 4  [dependabot[bot]]
   - bump actions/checkout from 1 to 4  [dependabot[bot]]
   - bump github/codeql-action from 2 to 3  [dependabot[bot]]
   - bump redhat-plumbers-in-action/differential-shellcheck  [dependabot[bot]]
build-sys:
   - build sample-mount-overwrite only on Linux  [Pino Toscano]
   - introduce localstatedir  [Karel Zak]
   - make sure everywhere is localstatedir  [Karel Zak]
   - update version dates  [Karel Zak]
c.h:
   - consolidate THREAD_LOCAL.  [Karel Zak]
cal:
   - colorize --vertical output.  [Karel Zak]
   - fix --week use and colors  [Karel Zak]
   - make sure day_in_week() does not overrun array size [coverity scan]  [Karel Zak]
   - properly colorize the week number in vertical output.  [Karel Zak]
   - use unsigned int to follow union with unsigned int  [Karel Zak]
cfdisk:
   - Remove unused struct 'cfdisk_extra'  [Dr. David Alan Gilbert]
   - add --sector-size commanand line option  [Karel Zak]
   - fix possible integer overflow [coverity scan]  [Karel Zak]
chcpu(8):
   - Document CPU deconfiguring behavior  [Mete Durlu]
   - Fix typo  [Mete Durlu]
   - document limitations of -g  [Stanislav Brabec]
chrt:
   - (man) Add note for custom slice length on SCHED_{OTHER,BATCH}  [Petre Tudor]
   - (tests) Add new cases for custom slice on SCHED_{OTHER,BATCH}  [Petre Tudor]
   - Add --sched_runtime support for SCHED_{OTHER,BATCH} policies  [Petre Tudor]
ci:
   - bump coveralls compiler version to gcc 13  [Karel Zak]
   - enable dependency manager for GitHub Actions  [Jan Macku]
   - reduce aslr level to avoid issues with ASAN  [Thomas Weißschuh]
   - temporarily switch the alt-arch job worker to Ubuntu 22.04  [Frantisek Sumsal]
   - test on armv7  [Thomas Weißschuh]
   - use OpenWRT SDK v23.05.4  [Thomas Weißschuh]
   - use clang 18  [Thomas Weißschuh]
   - use clang 19  [Thomas Weißschuh]
   - use upload action v4  [Thomas Weißschuh]
codeql:
   - don't report world-writable files  [Thomas Weißschuh]
colrm:
   - make the wording of the doc string analogous to that of `col`  [Benno Schulenberg]
column:
   - Adds option -S <num> so whitespaces are used instead of tabs in non table mode.  [drax]
   - add doc comment explaining ansi code detection  [Juarez Rudsatz]
   - add test for ansi escapes  [Juarez Rudsatz]
   - fix regression tests complaint  [Juarez Rudsatz]
   - fix unaligned cols in text with ansi escapes  [Juarez Rudsatz]
   - handle ANSI SGR colors inside OSC 8 hyperlink escape codes  [Juarez Rudsatz]
   - handle OSC 8 hyperlink escape sequences  [Juarez Rudsatz]
   - test ANSI SGR colors inside OSC 8 hyperlink escape codes  [Juarez Rudsatz]
   - test OSC 8 hyperlink escape sequences  [Juarez Rudsatz]
column.1.adoc:
   - Fix spelling and improve option descriptions  [Nejc Bertoncelj]
coresched:
   - Manage core scheduling cookies for tasks  [Thijs Raymakers, Phil Auld]
   - add bash completions  [Thijs Raymakers]
disk-utils:
   - make pointer arrays const  [Max Kellermann]
dmesg:
   - don't affect delta by --since  [Karel Zak]
   - fix --notime use  [Karel Zak]
   - fix delta calculation  [Karel Zak]
   - fix wrong size calculation  [Karel Zak]
   - print object closing brace while waiting for next message  [Thomas Weißschuh]
doc:
   - fsck.8.adoc - fix email typo  [Geoffrey Casper]
docs:
   - add COPYING.MIT  [Karel Zak]
   - add European Public License v1.2  [Thijs Raymakers]
   - add hints about systemd  [Karel Zak]
   - add note about stable branches  [Karel Zak]
   - cleanup public domain license texts  [Karel Zak]
   - fix GPL name typo  [Karel Zak]
   - fix typos  [Jakub Wilk]
   - improve howto-pull-request  [Karel Zak]
   - lsns(8) ENVIRONMENT describe LSNS_DEBUG  [Masatake YAMATO]
   - move GPL-2.0 license text to Docimentation directory  [Karel Zak]
   - reduce AUTHORS file  [Karel Zak]
   - reduce and freeze NEWS file  [Karel Zak]
   - remove duplicated author name in namei.1.adoc  [Emanuele Torre]
   - rename v*-devel tag to v*-start  [Karel Zak]
   - update README  [Karel Zak]
   - use proper XSPD identifier for GPL-2.0  [Karel Zak]
enosys:
   - (man) add missing word  [Jakub Wilk]
   - add functionality to dump filter  [Thomas Weißschuh]
   - add support for alternative error codes  [Thomas Weißschuh]
   - allow dumping to file  [Thomas Weißschuh]
   - generalize named number parsing  [Thomas Weißschuh]
env:
   - add "overwrite" argument to env_list_setenv()  [Karel Zak]
   - add env_list_add_getenv() and env_list_add_getenvs()  [Karel Zak]
   - cleanup env_list API  [Karel Zak]
   - save parsed variables into ul_env_list  [Karel Zak]
fadvise:
   - fix a typo of an option name in the bash completion rule  [Masatake YAMATO]
fallocate:
   - forbid --posix with special options  [Chris Hofstaedtler]
   - keep-size and zero-range are compatible  [Antonio Russo]
fdisk:
   - (man) improve --sector-size description  [Karel Zak]
   - add 'T' command to discard sectors  [Karel Zak]
   - fix SGI boot file prompt  [mr-bronson]
   - fix fdisk_sgi_set_bootfile return value  [mr-bronson]
   - fix sgi_check_bootfile name size minimum  [mr-bronson]
   - fix sgi_menu_cb return value  [mr-bronson]
   - fix typos  [Karel Zak]
   - improve list_freespace()  [Karel Zak]
fincore:
   - Use correct syscall number for cachestat on alpha  [John Paul Adrian Glaubitz]
findfs:
   - (man) be more accurate in describing non-tags  [Karel Zak]
findmnt:
   - (man) write about -Q,--filter option  [Masatake YAMATO]
   - (refactor) add a helper function making an instance of libscols_table  [Masatake YAMATO]
   - (refactor) convert add_column macro to a function  [Masatake YAMATO]
   - (refactor) remove global variables shared between findmnt.c and fintmnt-verify.c  [Masatake YAMATO]
   - add --hyperlink command line option  [Karel Zak]
   - add --id and --uniq-id options  [Karel Zak]
   - add --kernel=listmount  [Karel Zak]
   - add -Q,--filter option  [Masatake YAMATO]
   - add UNIQ-ID column  [Karel Zak]
   - add docs for --kernel  [Karel Zak]
   - add optional argument to --kernel  [Karel Zak]
   - always zero-terminate SOURCES data  [Thomas Weißschuh]
   - fix resource leaks [coverity scan]  [Karel Zak]
   - improve --help output  [Karel Zak]
   - improve -Q to output tree  [Karel Zak]
   - improve reliability of match testing  [Karel Zak]
   - remove deleted option from manual  [Chris Hofstaedtler]
   - revise the code for -I and -D option  [Masatake YAMATO]
flock:
   - add support for using fcntl() with open file description locks  [Rasmus Villemoes]
   - bash-completion add --fcntl  [Rasmus Villemoes]
   - document --fcntl  [Rasmus Villemoes]
format:
   - CamelCase to SnakeCase  [jNullj]
   - fix comments and if braces format  [jNullj]
   - fix switch case indent  [jNullj]
fsck:
   - warn if fsck.<type> not found and device is specified  [Karel Zak]
fsck.minix:
   - fix possible overrun  [Karel Zak]
fstab.5 mount:
   - fstab.5 mount.8 add note about field separator  [Karel Zak]
fstrim:
   - fix SYNOPSIS/usage (mandatory fstrim -A|-a|mountpoint)  [наб]
getopt:
   - remove free-before-exit  [Karel Zak]
github:
   - enable verbose output, don't generate docs default  [Karel Zak]
gitignore:
   - ignore `test/failures`  [LiviaMedeiros]
hardlink:
   - add --list-duplicates and --zero  [наб]
   - add --prioritize-trees  [Karel Zak]
   - add missing verbose messages and unify them  [Karel Zak]
   - add new options to the bash-completion  [Karel Zak]
   - fix 0-sized file processing  [наб]
   - fix memory corruption (size calculation)  [Karel Zak]
   - fix memory corruption in read buffers  [Karel Zak]
   - hardlink.1 directory|file is mandatory  [наб]
   - implement --exclude-subtree  [Karel Zak]
   - implement --mount  [Karel Zak]
   - re-raise SIGINT instead of exiting  [наб]
   - use xcalloc rather than xmalloc  [Karel Zak]
hexdump:
   - allow enabling with --disable-all-programs  [Robert Marko]
   - check blocksize when display data  [Karel Zak]
hwclock:
   - Remove ioperm declare as it causes nested extern declare warning  [Zhaoming Luo]
   - Support GNU Hurd  [Zhaoming Luo]
   - add -param-index  [Karel Zak]
   - cleanup save_adjtime()  [Karel Zak]
   - free temporary variable before return  [Karel Zak]
   - initialize parser variables  [Karel Zak]
include:
   - Include <unistd.h> in pidfd-utils.h for syscall()  [Xi Ruoyao]
   - add functions to implement --hyperlink  [Karel Zak]
   - introduce seccomp.h  [Thomas Weißschuh]
include/blkdev:
   - share BLKDISCARD macros  [Karel Zak]
include/c:
   - add BIT()  [Karel Zak]
include/c.h:
   - pass const pointer array to print_features()  [Max Kellermann]
include/debug:
   - Relicense to Public Domain  [Karel Zak]
include/mount-api-utils:
   - add statmount and listmount  [Karel Zak]
   - fix typo  [Karel Zak]
include/optstr:
   - improve optstr parsing  [Karel Zak]
include/pidfd-utils:
   - add namespaces ioctls  [Karel Zak]
   - provide ENOSYS stubs if pidfd functions are missing  [Thomas Weißschuh]
   - remove hardcoded syscall fallback  [Karel Zak]
include/timeutils:
   - add time_diff()  [Karel Zak]
include/ttyutils:
   - add terminal hyperlink ESC sequences  [Karel Zak]
ipc:
   - coding style cosmetic changes  [Karel Zak]
ipcrm:
   - simplify code  [Yang Kun]
jsonwrt:
   - add ul_jsonwrt_flush  [Thomas Weißschuh]
kill:
   - (test) add a case for testing -l 0xSIGMASK and -d $PID options  [Masatake YAMATO]
   - add a feature decoding signal masks  [Masatake YAMATO]
last:
   - avoid out of bounds array access  [biubiuzy]
lastlog:
   - cleanup function definitions  [Karel Zak]
   - improve errors printing  [Karel Zak]
lastlog2:
   - Don't print space if Service column is not printed  [Miika Alikirri]
   - Fix various issues with meson  [Fabian Vogt]
   - Improve comments and documentation  [Tobias Stoeckmann]
   - begin descriptions of options with a lowercase letter  [Benno Schulenberg]
   - convert check_user() to boolean-like macro  [Karel Zak]
   - improve coding style  [Karel Zak]
   - make longopts[] static-const  [Karel Zak]
   - rename tmpfiles  [Christian Hesse]
lastlog2,uuidd:
   - rename tmpfiles config file  [Zbigniew Jędrzejewski-Szmek]
lib:
   - make pointer arrays const  [Max Kellermann]
lib/buffer:
   - introduce ul_buffer_get_string()  [Thomas Weißschuh]
lib/colors:
   - fix fallback to system directory  [Thomas Weißschuh]
   - free unnecessary ncurses resources  [Karel Zak]
lib/fileutils:
   - add ul_basename()  [Karel Zak]
lib/jsonwrt:
   - introduce ul_jsonwrt_empty()  [Karel Zak]
lib/pager:
lib/path:
   - add ul_path_statf() and ul_path_vstatf()  [Karel Zak]
   - introduce ul_path_vreadf_buffer  [Thomas Weißschuh]
   - use _read_buffer for _read_string()  [Thomas Weißschuh]
   - use _vreadf_buffer for _cpuparse()  [Thomas Weißschuh]
lib/pty-session:
   - Don't ignore SIGHUP.  [Kuniyuki Iwashima]
lib/sha1:
   - fix for old glibc  [Karel Zak]
lib/sysfs:
   - abort device hierarchy walk at root of sysfs  [Thomas Weißschuh]
   - zero-terminate result of sysfs_blkdev_get_devchain()  [Thomas Weißschuh]
libblkid:
   - (exfat) validate fields used by prober  [Thomas Weißschuh]
   - (gpt) use blkid_probe_verify_csum() for partition array checksum  [Thomas Weißschuh]
   - Check offset in LUKS2 header  [Milan Broz]
   - Fix segfault when blkid.conf doesn't exist  [Karel Zak]
   - add FSLASTBLOCK for swaparea  [Karel Zak]
   - apfs validate checksums  [Thomas Weißschuh]
   - bitlocker add drive label  [Victor Westerhuis]
   - bitlocker add image for Windows 7+ BitLocker  [Victor Westerhuis]
   - bitlocker fix version on big-endian systems  [Victor Westerhuis]
   - bitlocker use volume identifier as UUID  [Victor Westerhuis]
   - check OPAL lock only when necessary  [Oldřich Jedlička]
   - fix potential memory leaks  [Karel Zak]
   - fix spurious ext superblock checksum mismatches  [Krister Johansen]
   - improve portability  [Yang Kun]
   - introduce luks opal prober  [Thomas Weißschuh]
   - make example more robust  [Karel Zak]
   - make pointer arrays const  [Max Kellermann]
   - topology/ioctl correctly handle kernel types  [Thomas Weißschuh]
   - topology/ioctl simplify ioctl handling  [Thomas Weißschuh]
   - use correct logging prefix for checksum mismatch  [Thomas Weißschuh]
   - zfs Use nvlist for detection instead of Uber blocks  [Ameer Hamza]
   - zfs fix overflow warning [coverity scan]  [Ameer Hamza]
libfdisk:
   - (dos) ignore incomplete EBR for non-wholedisk  [Karel Zak]
   - add fdisk_ask_menu()  [Karel Zak]
   - add initializer to geometry  [Karel Zak]
   - add missing va_end() [coverity scan]  [Karel Zak]
   - check alignment reset return codes  [Karel Zak]
   - fix fdisk_partition_start_follow_default() docs  [Karel Zak]
   - make pointer arrays const  [Max Kellermann]
   - make sure libblkid uses the same sector size  [Karel Zak]
liblastlog2:
   - Improved sqlite3 error handling  [Stefan Schubert]
   - tests provide fallback PATH_MAX definition  [Pino Toscano]
libmount:
   - (docs) add missing api indexes  [Karel Zak]
   - (loop) detect and report lost loop nodes  [Karel Zak]
   - Add API to get/set unique IDs  [Karel Zak]
   - Add integer type headers to private header file  [Karel Zak]
   - Fix access check for utab in context  [Karel Zak]
   - Fix atime remount for new API  [Karel Zak]
   - Fix export of mnt_context_is_lazy and mnt_context_is_onlyonce  [Matt Turner]
   - add API to read ID by statx()  [Karel Zak]
   - add X-mount.nocanonicalize[=source|target]  [Karel Zak]
   - add functions to use error buffer  [Karel Zak]
   - add listmount() sample  [Karel Zak]
   - add mnt_context_sprintf_errmsg()  [Karel Zak]
   - add mnt_table_find_[uniq]_id() function  [Karel Zak]
   - add mount-api-utils.h to mountP.h  [Karel Zak]
   - add private mnt_context_read_mesgs()  [Karel Zak]
   - add statmount to features list  [Karel Zak]
   - add support for listmount()  [Karel Zak]
   - add support for statmount()  [Karel Zak]
   - cleanup comments  [Karel Zak]
   - create EROFS loopdev only after ENOTBLK  [Karel Zak]
   - don't hold write fd to mounted device  [Jan Kara]
   - don't initialize variable twice (#2714)  [Thorsten Kukuk]
   - expose exec errors  [Karel Zak]
   - extract common error handling function  [John Keeping]
   - fix __table_insert_fs()  [Karel Zak]
   - fix comment typo for mnt_fs_get_comment()  [Tianjia Zhang]
   - fix copy & past bug in lock initialization  [Karel Zak]
   - fix mnt_fs_match_target()  [Karel Zak]
   - fix possible memory leak  [Karel Zak]
   - fix table_init_listmount()  [Karel Zak]
   - fix tree FD usage in subdir hook  [Karel Zak]
   - fix typo in symbols list  [Karel Zak]
   - fix umount --read-only  [Karel Zak]
   - fix use-after free, etc. [coverity scan]  [Karel Zak]
   - ifdef STATMOUNT_* in sample  [Karel Zak]
   - ifdef STATX_MNT_ID_UNIQUE  [Karel Zak]
   - ifdef listmount and statmount stuff  [Karel Zak]
   - implement ro[=vfs,fs]  [Karel Zak]
   - improve error messages in ID-mapping hook  [Karel Zak]
   - improve fs->stmnt_done mask use  [Karel Zak]
   - improve how library generates fs->optstr  [Karel Zak]
   - improving readability  [Karel Zak]
   - improving robustness in reading kernel messages  [Karel Zak]
   - make sure "option=" is used as string  [Karel Zak]
   - map unsupported LISTMOUNT_REVERSE to ENOSYS  [Karel Zak]
   - propagate first error of multiple filesystem types  [John Keeping]
   - read all types of kernel messages  [Karel Zak]
   - reduce size of syscall-failed message  [Karel Zak]
   - remember parsed propagation  [Karel Zak]
   - remove unnecessary include  [Karel Zak]
   - report kernel message from new API  [Karel Zak]
   - support X-mount.noloop  [Karel Zak]
   - support bind symlink over symlink  [Karel Zak]
   - update tests  [Karel Zak]
   - use __unused__ for dummy get_mnt_id()  [Karel Zak]
   - use regular function to save/reset syscalls status  [Karel Zak]
   - use unique ID in utab  [Karel Zak]
libmount/context_mount:
   - fix argument number comments  [nilfsuser5678]
libmount/hooks:
   - make `hooksets` array const  [Max Kellermann]
libmount/utils:
   - add pidfs to pseudo fs list  [Mike Yuan]
libsmartcol docs:
   - Format samples, lists, tables  [FeRD (Frank Dana)]
libsmartcols:
   - (filter) accept prefixes like k, M, G as a parts of a number  [Karel Zak, Masatake YAMATO]
   - (filter) check vasprintf() return value  [Karel Zak]
   - (filter) emulate YYerror for old Bison  [Karel Zak]
   - (filter) use variable argument lists for yyerror()  [Karel Zak]
   - (sample) add wrap repeating example  [Karel Zak]
   - add printf api to fill in column data  [Robin Jarry]
   - add support for terminal hyperlinks  [Karel Zak]
   - fix column reduction  [Karel Zak]
   - fix reduction stages use  [Karel Zak]
   - make __attributes__ more portable  [Karel Zak]
   - make pointer arrays const  [Max Kellermann]
   - print empty arrays in better way  [Karel Zak]
   - reset wrap after calculation  [Karel Zak]
libsmartcols/src/Makemodule.am:
   - ensure filter-scanner/paser.c file is newer than the .h file  [Chen Qi]
libuuid:
   - (man) fix function declarations  [CismonX]
   - add helper to set version and variant in uuid_t  [Thomas Weißschuh]
   - add support for RFC9562 UUIDs  [Thomas Weißschuh]
   - clear uuidd cache on fork()  [Thomas Weißschuh]
   - construct UUIDv6 without "struct uuid"  [Thomas Weißschuh]
   - construct UUIDv7 without "struct uuid"  [Thomas Weißschuh]
   - drop check for HAVE_TLS  [Thomas Weißschuh]
   - drop duplicate assignment liuuid_la_LDFLAGS  [Karel Zak]
   - fix gcc15 warnings  [Cristian Rodríguez]
   - fix v6 generation  [Thomas Weißschuh]
   - link test_uuid_time with pthread  [Thomas Weißschuh]
   - set variant in the corrrect byte __uuid_set_variant_and_version  [oittaa]
   - split uuidd cache into dedicated struct  [Thomas Weißschuh]
   - support non-cached scenarios (when -lpthread is unavailable)  [Karel Zak]
   - test time-based UUID generation  [Thomas Weißschuh]
logger:
   - (man) fix --socket-error  [Karel Zak]
   - correctly format tv_usec  [Thomas Weißschuh]
   - do not show arguments of --socket-errors as optional in --help  [Benno Schulenberg]
   - grammarize the description of --socket-errors in the man page  [Benno Schulenberg]
   - handle failures of gettimeofday()  [Thomas Weißschuh]
   - rework error handling in logger_gettimeofday()  [Thomas Weißschuh]
login:
   - actually honour $HOME for chdir()  [Lennart Poettering]
   - add LOGIN_ENV_SAFELIST /etc/login.def item  [Karel Zak]
login,libblkid:
   - use econf_readConfig rather than deprecated econf_readDirs  [Karel Zak]
login-utils:
   - make pointer arrays const  [Max Kellermann]
login-utils/su-common:
   - Check that the user didn't change during PAM transaction  [Marco Trevisan (Treviño)]
   - Validate all return values again  [Thomas Weißschuh]
losetup:
   - losetup.8 Clarify --direct-io  [Colin Walters]
lsblk:
   - (refactor) refer to a parameter instead of a file static var  [Masatake YAMATO]
   - add --hyperlink command line option  [Karel Zak]
   - add --properties-by option  [Karel Zak]
   - simplify SOURCES code  [Karel Zak]
   - update --help  [Karel Zak]
   - update bash-completion/lsblk  [Karel Zak]
lsclocks:
   - fix FD leak  [Karel Zak]
   - fix dynamic clock ids  [Thomas Weißschuh]
lscpu:
   - Add FUJITSU aarch64 MONAKA cpupart  [Emi, Kisanuki]
   - New Arm Cortex part numbers  [Jeremy Linton]
   - Skip aarch64 decode path for rest of the architectures  [Pratik R. Sampat]
   - add --raw command line option  [Karel Zak]
   - add procfs–sysfs dump from Milk-V Pioneer  [Jan Engelhardt]
   - don't use NULL sharedmap  [Karel Zak]
   - fix incorrect number of sockets during hotplug  [Anjali K]
   - initialize all variables (#2714)  [Thorsten Kukuk]
   - make code more readable  [Karel Zak]
   - make three column descriptions more grammatical  [Benno Schulenberg]
   - optimize query virt pci device  [Guixin Liu]
   - restructure op-mode printing  [Thomas Weißschuh]
   - skip frequencies of 0 MHz when getting minmhz  [Ricardo Neri]
   - use CPU types de-duplication  [Karel Zak]
   - use bool type in control structs  [Karel Zak]
lsfd:
   - (bugfix) fix wrong type usage in anon_bpf_map_fill_column  [Masatake YAMATO]
   - (cosmetic) normalize whitespaces  [Masatake YAMATO]
   - (man) add commas between SEE ALSO items  [Jakub Wilk]
   - (man) add more filter examples related to unix stream sockets  [Masatake YAMATO]
   - (man) fix license name  [Jakub Wilk]
   - (man) fix the decoration of an optional parameter  [Masatake YAMATO]
   - (man) fix typos  [Jakub Wilk]
   - (po-man) update po4a.cfg  [Karel Zak]
   - (refactor) add abst_class as super class of file_class  [Masatake YAMATO]
   - (refactor) flatten bit fields in struct file  [Masatake YAMATO]
   - (refactor) make the steps for new_file consistent  [Masatake YAMATO]
   - (refactor) rename a local variable and a parameter  [Masatake YAMATO]
   - (refactor) rename a member of struct proc  [Masatake YAMATO]
   - (refactor) rename add_nodevs to read_mountinfo  [Masatake YAMATO]
   - (refactor) simplify the step to copy a file struct if the result of its stat is reusable  [Masatake YAMATO]
   - (refactor) simplify the step to make a file struct  [Masatake YAMATO]
   - (refactor) split the function processing mountinfo file  [Masatake YAMATO]
   - (refactor) store a mnt_namespace object to struct process  [Masatake YAMATO]
   - (refactor) use a binary tree as the implementation for mnt_namespaces  [Masatake YAMATO]
   - (refactor) use ul_path_statf and ul_path_readlinkf  [Masatake YAMATO]
   - (tests) skip tests using fd flags on qemu-user  [Thomas Weißschuh]
   - Gather information on target socket's net namespace  [Dmitry Safonov]
   - Refactor the pidfd logic into lsfd-pidfd.c  [Xi Ruoyao]
   - Support pidfs  [Xi Ruoyao]
   - add --_drop-prvilege option for testing purpose  [Masatake YAMATO]
   - add --hyperlink command line option  [Karel Zak, Masatake YAMTO]
   - add BPF-PROG.TAG column  [Masatake YAMATO]
   - add ERROR as a new type  [Masatake YAMATO]
   - add LSFD_DEBUG env var for debugging  [Masatake YAMATO]
   - add meson.build for the command  [Masatake YAMATO]
   - avoid accessing an uninitialized value  [Masatake YAMATO]
   - consolidate add_column()  [Karel Zak]
   - don't enable hyperlinks for deleted files  [Masatake YAMATO]
   - enable hyperlinks only for regular files and directories  [Masatake YAMATO]
   - extend nodev table to decode "btrfs" on SOURCE column  [Masatake YAMATO]
   - finalize abst_class  [Masatake YAMATO]
   - fix typos of a function name  [Masatake YAMATO]
   - include buffer.h in decode-file-flags.h  [Thomas Weißschuh]
   - include linux/fcntl.h  [Thomas Weißschuh]
   - make the way to read /proc/$pid/mountinfo robust  [Masatake YAMATO]
   - minimize the output related to lsfd itself  [Masatake YAMATO]
   - move interface of decode-file-flags to header  [Thomas Weißschuh]
   - move the source code to new ./lsfd-cmd directory  [Masatake YAMATO]
   - read /proc/$pid/ns/mnt earlier  [Masatake YAMATO]
   - remove C++ comment  [Karel Zak]
   - support AF_VSOCK sockets  [Masatake YAMATO]
   - test Adapt test cases for pidfs  [Xi Ruoyao]
   - update bpf related tables  [Masatake YAMATO]
lsfd,test_mkfds:
   - (refactor) specify the variable itself as an operand of sizeof  [Masatake YAMATO]
lsfd-cmd:
   - make pointer arrays const  [Max Kellermann]
lsipc:
   - (man) add note about default outputs  [Karel Zak]
   - fix semaphore USED counter  [Karel Zak]
   - improve variable naming  [Karel Zak]
lsirq:
   - add option to limit cpus  [Robin Jarry]
lsirq,irqtop:
   - add threshold option  [Robin Jarry]
   - cleanup threshold datatype  [Karel Zak]
lslocks:
   - don't abort gathering per-process information even if opening a /proc/[0-9]* fails  [Masatake YAMATO]
   - fix buffer overflow  [Karel Zak]
   - remove a unused local variable  [Masatake YAMATO]
   - remove deadcode [coverity scan]  [Karel Zak]
   - remove unnecessary code  [Karel Zak]
lslogins:
   - Add support for lastlog2  [Stefan Schubert]
   - don't ignore stat error  [Thorsten Kukuk]
lsmem:
   - improve coding style  [Karel Zak]
   - make an error message identical to one used in seven other places  [Benno Schulenberg]
   - make lsmem to check for the nodes more robust  [zhangyao]
lsns:
   - (man) make the namespace parameter optional  [Masatake YAMATO]
   - (refactor) add get_{parent|owner}_ns_ino() implementing some parts of get_ns_ino()  [Masatake YAMATO]
   - (refactor) give a enumeration name 'lsns_type' to LSNS_TYPE_ enumerators  [Masatake YAMATO]
   - (refactor) make the function names for reading namespaces consistent  [Masatake YAMATO]
   - (refactor) rename LSNS_ID_.* to LSNS_TYPE_.*  [Masatake YAMATO]
   - (refactor) rename get_ns_ino() to get_ns_inos()  [Masatake YAMATO]
   - (refactor) rename read_related_namespaces to connect_namespaces  [Masatake YAMATO]
   - (refactor) use get_{parent|owner}_ns_ino() in add_namespace_for_nsfd  [Masatake YAMATO]
   - (refactor) use ls_path_{openf|statf} to make the code simple  [Masatake YAMATO]
   - (refactor) use ul_new_path and procfs_process_init_path  [Masatake YAMATO]
   - List network namespaces that are held by a socket  [Dmitry Safonov]
   - add --filter option to the --help optout and the completion rule  [Masatake YAMATO]
   - add -H, --list-columns option  [Masatake YAMATO]
   - add a missing '=' character in the help message  [Masatake YAMATO]
   - add more print-debug code  [Masatake YAMATO]
   - check for mnt_fs_get_target return value  [Karel Zak]
   - continue the executing even if opening a /proc/$pid fails  [Masatake YAMATO]
   - don't call close(2) if unnecessary  [Masatake YAMATO]
   - fill the netsid member of lsns_process with reliable value  [Masatake YAMATO]
   - fix netns use  [Karel Zak]
   - fix ul_path_stat() error handling [coverity scan]  [Karel Zak]
   - ignore ESRCH errors reported when accessing files under /proc  [Masatake YAMATO]
   - implement -Q, --filter option  [Masatake YAMATO]
   - report with warnx if a namespace related ioctl fails with ENOSYS  [Masatake YAMATO]
   - show namespaces only kept alive by open file descriptors  [Masatake YAMATO]
   - tolerate lsns_ioctl(fd, NS_GET_{PARENT,USERNS}) failing with ENOSYS  [Masatake YAMATO]
   - verify the uniqueness of a namespace in ls->namespaces list  [Masatake YAMATO]
man pages:
   - document `--user` option for `runuser`  [Christoph Anton Mitterer]
   - use `user` rather than `username`  [Christoph Anton Mitterer]
   - use the same verb for --version as for --help, like in usages  [Benno Schulenberg]
mesg:
   - remove ability to compile with fchmod(S_IWOTH)  [Karel Zak]
meson:
   - Add build-blkdiscard option  [Jordan Williams]
   - Add build-blkpr option  [Jordan Williams]
   - Add build-blkzone option  [Jordan Williams]
   - Add build-blockdev option  [Jordan Williams]
   - Add build-chcpu option  [Jordan Williams]
   - Add build-dmesg option  [Jordan Williams]
   - Add build-enosys option  [Jordan Williams]
   - Add build-fadvise option  [Jordan Williams]
   - Add build-fsfreeze option  [Jordan Williams]
   - Add build-hexdump option  [Alexander Shursha]
   - Add build-ipcmk option  [Jordan Williams]
   - Add build-ldattach option  [Jordan Williams]
   - Add build-lsclocks option  [Jordan Williams]
   - Add build-lsfd option and make rt dependency optional  [Jordan Williams]
   - Add build-rtcwake option  [Jordan Williams]
   - Add build-script option  [Jordan Williams]
   - Add build-scriptlive option  [Jordan Williams]
   - Add build-setarch option  [Jordan Williams]
   - Add have_pty variable to check if pty is available  [Jordan Williams]
   - Add missing check for build-ipcrm option  [Jordan Williams]
   - Check options for building lib_pam_misc  [Alexander Shursha]
   - Correctly require the Python.h header for the python dependency  [Jordan Williams]
   - Define _DARWIN_C_SOURCE on macOS as is done in Autotools  [Jordan Williams]
   - Disable targets requiring pam when it is missing  [Jordan Williams]
   - Don't define HAVE_ENVIRON_DECL when environ is unavailable  [Jordan Williams]
   - Enforce sqlite dependency for liblastlog2  [Jordan Williams]
   - Fix build by default and install behavior for build-pipesz option  [Jordan Williams]
   - Fix build-python option  [Jordan Williams]
   - Fix checking options build-bits.  [Alexander Shursha]
   - Fix false positive detection of mempcpy on macOS  [Jordan Williams]
   - Make ncurses dependency a disabler when not found  [Jordan Williams]
   - Make the zlib dependency a disabler when not found  [Jordan Williams]
   - Make tinfo dependency a disabler when not found  [Jordan Williams]
   - Only build blkzone and blkpr if the required linux header exists  [Jordan Williams]
   - Only build libmount python module if python was found  [Fabian Vogt]
   - Only build libmount when required  [Jordan Williams]
   - Only pick up the rt library once  [Jordan Williams]
   - Only require Python module when building pylibmount  [Jordan Williams]
   - Only require the crypt library when necessary  [Jordan Williams]
   - Only use the --version-script linker flag where it is supported  [Jordan Williams]
   - Remove libblkid dependency on libmount  [Jordan Williams]
   - Require Python dependency which can be embedded for pylibmount  [Jordan Williams]
   - Require pty for the su and runuser executables  [Jordan Williams]
   - Require the seminfo type for ipcmk, ipcrm, and ipcs  [Jordan Williams]
   - Require the sys/vfs.h header for libmount and fstrim  [Jordan Williams]
   - Use has_type instead of sizeof to detect cpu_set_t type  [Jordan Williams]
   - Use is_absolute to determine if the prefix directory is absolute  [Jordan Williams]
   - Use libblkid as a dependency  [Jordan Williams]
   - Use libmount as a dependency  [Jordan Williams]
   - add -D tty-setgid=[false|true]  [Karel Zak]
   - add HAVE_LIBPTHREAD  [Karel Zak]
   - add checking build-cal  [Alexander Shursha]
   - add checking build-findfs.  [Alexander Shursha]
   - add forgotten files to lists  [Zbigniew Jędrzejewski-Szmek]
   - add missing `is_disabler` checks  [Sam James]
   - add missing sample-mount-overwrite  [Karel Zak]
   - add options for more utilities  [Rosen Penev]
   - avoid future-deprecated feature  [Thomas Weißschuh]
   - check for BPF_OBJ_NAME_LEN and linux/bpf.h  [Karel Zak]
   - check for blkzoned.h  [Karel Zak]
   - check for statmount and listmount syscalls  [Karel Zak]
   - checking build_libblkid for manadocs  [Alexander Shursha]
   - checking build_libsmartcols for manadocs.  [Alexander Shursha]
   - correctly detect posix_fallocate  [Chris Hofstaedtler]
   - define have_linux_blkzoned_h  [Frantisek Sumsal]
   - do not hardcode /var in uuidd-sysusers.conf.  [Karel Zak]
   - don't install getopt examples if disabled  [Rosen Penev]
   - fix LIBBLKID_VERSION definition  [Karel Zak]
   - fix after rebase  [Karel Zak]
   - fix build of lslogins with -Dbuild-liblastlog2=disabled  [Thomas Weißschuh]
   - fix checking build-cramfs  [Alexander Shursha]
   - fix checking build-login  [Alexander Shursha]
   - fix checking build-sulogin  [Alexander Shursha]
   - fix disablement check  [Zbigniew Jędrzejewski-Szmek]
   - fix generated header paths  [amibranch]
   - fix mismatch with handling of lib_dl dependency  [Zbigniew Jędrzejewski-Szmek]
   - generate man page translations  [Jordan Williams]
   - install lastlog2.h library header file  [Karel Zak]
   - po disable if nls is disabled  [Rosen Penev]
   - remove unused lastlog-compat-symlink option  [Jordan Williams]
   - respect c_args/CFLAGS when generating syscalls/errnos  [Thomas Weißschuh]
   - run compiler checks with -D_GNU_SOURCE when necessary  [Thomas Weißschuh]
   - simplify code  [Yang Kun]
   - test for pidfd_getfd()  [Thomas Weißschuh]
   - use a / b instead of join_paths(a, b)  [Dmitry V. Levin]
   - use files() for man page source files  [Jordan Williams]
   - use signed chars  [Thomas Weißschuh]
   - use tmpfilesdir pkg-config variable  [Karel Zak]
misc-utils:
   - make pointer arrays const  [Max Kellermann]
   - uuidd Use ul_sig_err instead of errx  [Cristian Rodríguez]
mkfs.cramfs:
   - in usage text, separate two direct arguments from options  [Benno Schulenberg]
mkswap:
   - add features list to --version output  [Karel Zak]
   - fix includes  [Karel Zak]
   - improve --file option for use on btrfs  [Karel Zak]
   - remove unused variable for non-nocow systems  [Karel Zak]
   - set selinux label also when creating file  [Zbigniew Jędrzejewski-Szmek]
mkswap.8.adoc:
   - update note regarding swapfile creation  [Mike Yuan]
more:
   - fix compilation  [Yang Kun]
   - fix poll() use  [Karel Zak]
   - make sure we have data on stderr  [Karel Zak]
   - remove second check for EOF (#2714)  [Thorsten Kukuk]
mount:
   - (man) add note about -o bind,rw  [Karel Zak]
   - (man) add note about symlink over symlink  [Karel Zak]
   - print info and warning messages  [Karel Zak]
   - properly mark the arguments of the 'ro' and 'rw' extended options  [Benno Schulenberg]
   - use ul_optstr_is_valid()  [Karel Zak]
nsenter:
   - Provide an option to join target process's socket net namespace  [Dmitry Safonov]
   - Rewrite --user-parent to use pidfd  [Karel Zak]
   - add functions to enable/disable namespaces  [Karel Zak]
   - improve portability to older kernels  [Karel Zak]
   - reuse pidfd for --net-socket  [Karel Zak]
   - support empty environ[]  [Karel Zak]
   - use macros to access the nsfiles array  [Karel Zak]
   - use pidfd to enter target namespaces  [Karel Zak]
   - use separate function to enter namespaces  [Karel Zak]
pam_lastlog2:
   - drop duplicate assignment pam_lastlog2_la_LDFLAGS  [Thomas Weißschuh]
   - link against liblastlog  [Thomas Weißschuh]
   - remove symbol that doesn't exist from version script  [psykose]
partx:
   - Fix example in man page  [Michal Suchanek]
pg:
   - make sure cmdline[] not overflow [coverity scan]  [Karel Zak]
po:
   - merge changes  [Karel Zak]
   - update cs.po (from translationproject.org)  [Petr Písař]
   - update de.po (from translationproject.org)  [Mario Blättermann]
   - update es.po (from translationproject.org)  [Antonio Ceballos Roa]
   - update fr.po (from translationproject.org)  [Frédéric Marchal]
   - update hr.po (from translationproject.org)  [Božidar Putanec]
   - update ja.po (from translationproject.org)  [Hideki Yoshida]
   - update ko.po (from translationproject.org)  [Seong-ho Cho]
   - update nl.po (from translationproject.org)  [Benno Schulenberg]
   - update pl.po (from translationproject.org)  [Jakub Bogusz]
   - update pt_BR.po (from translationproject.org)  [Rafael Fontenelle]
   - update ro.po (from translationproject.org)  [Remus-Gabriel Chelu]
   - update sr.po (from translationproject.org)  [Мирослав Николић]
   - update tr.po (from translationproject.org)  [Emir SARI]
   - update uk.po (from translationproject.org)  [Yuri Chornoivan]
   - update zh_CN.po (from translationproject.org)  [Mingye Wang (Artoria2e5)]
po-man:
   - add asciidoctor --trace  [Karel Zak]
   - add missing asciidoctor-unicodeconverter  [Karel Zak]
   - add missing langs to po4a.cfg  [Karel Zak]
   - add missing pages, improve output  [Karel Zak]
   - cleanup install  [Karel Zak]
   - fix 'make dist'  [Karel Zak]
   - fix typo, update .gitignore  [Karel Zak]
   - fix uninstall  [Karel Zak]
   - improve translation and install scripts  [Karel Zak]
   - merge changes  [Karel Zak]
   - move scripts tools/  [Karel Zak]
   - rewrite autotools code  [Karel Zak]
   - update de.po (from translationproject.org)  [Mario Blättermann]
   - update fr.po (from translationproject.org)  [Frédéric Marchal]
   - update ko.po (from translationproject.org)  [Seong-ho Cho]
   - update pt_BR.po (from translationproject.org)  [Rafael Fontenelle]
   - update ro.po (from translationproject.org)  [Remus-Gabriel Chelu]
   - update sr.po (from translationproject.org)  [Мирослав Николић]
   - update uk.po (from translationproject.org)  [Yuri Chornoivan]
prlimit:
   - in man page, mark --resource as placeholder, not literal option  [Benno Schulenberg]
readprofile:
   - put two things that belong together into a single message  [Benno Schulenberg]
rename:
   - use ul_basename()  [Karel Zak]
renice:
   - put text that belongs together into a single translatable message  [Benno Schulenberg]
rev:
   - Check for wchar conversion errors  [Tim Hallmann]
   - standardize the usage header, making the synopsis equal to another  [Benno Schulenberg]
schedutils:
   - make pointer arrays const  [Max Kellermann]
script:
   - mention in usage that value for <size> may have a suffix  [Benno Schulenberg]
scriptlive:
   - add --echo <never|always|auto>  [Karel Zak]
   - echo re-run commands from in stream  [Matt Cover]
scriptreplay:
   - add key bindings info to --help  [Karel Zak]
   - fix compiler warning  [Karel Zak]
   - fix uninitialized value [coverity scan]  [Karel Zak]
setpriv:
   - (tests) add seccomp test  [Thomas Weißschuh]
   - Add --ptracer, which calls PR_SET_PTRACER  [Geoffrey Thomas]
   - add support for seccomp filters  [Thomas Weißschuh]
   - consistently use "<caps>" to indicate a list of capabilities  [Benno Schulenberg]
   - describe --groups more correctly in the usage text  [Benno Schulenberg]
   - make message for failing PR_GET_PDEATHSIG the same as the other  [Benno Schulenberg]
setpriv.c:
   - fix memory leak in parse_groups function  [AntonMoryakov]
setterm:
   - Document behavior of redirection  [Stanislav Brabec]
   - improve "bright %s" error message  [Karel Zak]
   - mark literal values in the man page in bold  [Benno Schulenberg]
   - put an option and its description in a single message  [Benno Schulenberg]
sfdisk:
   - add --discard-free  [Karel Zak]
   - add --sector-size commanand line option  [Karel Zak]
   - ignore last-lba from script on --force  [Karel Zak]
   - make sure partition number > 0 [coverity scan]  [Karel Zak]
strutils.h:
   - Include strings.h header for strncasecmp function  [Jordan Williams]
su:
   - fix use after free in run_shell  [Tanish Yadav]
   - use lib/env.c for --whitelist-environment  [Karel Zak]
su, agetty:
   - don't use program_invocation_short_name for openlog()  [Karel Zak]
sulogin:
   - extend --version features list  [Karel Zak]
   - fix POSIX locale use  [Karel Zak]
swapoff:
   - avoid being killed by OOM  [Karel Zak]
sys-utils:
   - (save_adjtime) fix memory leak  [Maks Mishin]
   - (setpriv) fix potential memory leak  [Maks Mishin]
   - fix add NULL check for mnt_fs_get_target return value  [AntonMoryakov]
   - fixed build system for POSIX IPC tools  [Prasanna Paithankar]
   - hwclock-rtc fix pointer usage  [Karthikeyan Krishnasamy]
   - make pointer arrays const  [Max Kellermann]
   - remove redundant comparison in read_hypervisor_dmi in lscpu-virt.c  [Anton Moryakov]
   - warns if mqueue fs is not mounted  [Prasanna Paithankar]
sys-utils/irq-common:
   - fix SPDX typos  [Karel Zak]
sys-utils/setarch.c:
   - fix build with uclibc-ng < 1.0.39  [Fabrice Fontaine]
sys-utils/setpgid:
   - fix --help typo (foregound > foreground) + alignment  [Emanuele Torre]
   - make -f work  [Emanuele Torre]
term-utils:
   - make pointer arrays const  [Max Kellermann]
test:
   - (test_mkfds) add -O option for describing output values  [Masatake YAMATO]
test_mkfds:
   - (bugfix) listing ALL output values for a given factory  [Masatake YAMATO]
   - (cosmetic) remove whitespaces between a function and its arguments  [Masatake YAMATO]
   - reserve file descriptors in the early stage of execution  [Masatake YAMATO]
tests:
   - (findmnt) add a case testing -Q option  [Masatake YAMATO]
   - (functions.sh) add a helper funcion making a device number from given major and minor nums  [Masatake YAMATO]
   - (liblastlog2) don't write to stderr and stdout  [Karel Zak]
   - (lsfd) add a case testing ERROR type appeared in TYPE column  [Masatake YAMATO]
   - (lsfd) don't refer "$?" on the line follwoing the use of "local"  [Masatake YAMATO]
   - (lsfd) fix typoes in an error name  [Masatake YAMATO]
   - (lsfd) quote '$' in patterns in a case/esac block  [Masatake YAMATO]
   - (lsfd) skip some cases if NETLINK_SOCK_DIAG for AF_UNIX is not available  [Masatake YAMATO]
   - (lsfd) verify SOCK.NETID and ENDPOINTS for sockets made in another netns  [Masatake YAMATO]
   - (lsfd-functions.bash) add a missing constant  [Masatake YAMATO]
   - (lsfd-functions.bash,cosmetic) unify the style to define functions  [Masatake YAMATO]
   - (lsfdmkfds-bpf-prog) verify BPF-PROG.{ID,TAG} column  [Masatake YAMATO]
   - (lsfdmkfds-inotify) consider environments not having / as a mount point  [Masatake YAMATO]
   - (lsfdmkfds-inotify-btrfs) test INOTIFY.INODES cooked output  [Masatake YAMATO]
   - (lsfdmkfds-multiplexing) skip if /proc/$pid/syscall is broken  [Masatake YAMATO]
   - (lsfdmkfds_vsock) skip if diag socket for AF_VSOCK is unavailable  [Masatake YAMATO]
   - (lslogins) use GMT timezone  [Karel Zak]
   - (lslogins) use fixed time format  [Karel Zak]
   - (lslogins) write to TS_OUTDIR only, check for sqlite3  [Karel Zak]
   - (lsns) add a case testing -Q, --filter option  [Masatake YAMATO]
   - (lsns) verify the code finding an isolated netns via socket  [Masatake YAMATO]
   - (lsnsfiledesc) enable debug output and show the exit status  [Masatake YAMATO]
   - (lsnsfiledesc) skip if NS_GET_NSTYPE ioctl cmd not available  [Masatake YAMATO]
   - (lsnsfilter) add more debug printing  [Masatake YAMATO]
   - (lsnsfilter) delete an unused variable  [Masatake YAMATO]
   - (lsnsfilter) don't use double-quotes chars for PID  [Masatake YAMATO]
   - (lsnsfilter) skip if /proc/self/uid_map is not writable  [Masatake YAMATO]
   - (lsnsioctl_ns) add more debug print  [Masatake YAMATO]
   - (lsnsioctl_ns) record stdout/stderr for debugging the case  [Masatake YAMATO]
   - (nsenter) verify the code entering the network ns via socket made in the ns  [Masatake YAMATO]
   - (test_mkfds) add a missing word in a comment  [Masatake YAMATO]
   - (test_mkfds) don't close fds and free memory objects when exiting with EXIT_FAILURE  [Masatake YAMATO]
   - (test_mkfds) fix a typo in an option name  [Masatake YAMATO]
   - (test_mkfds) fix the way to detect errors in fork(2)  [Masatake YAMATO]
   - (test_mkfds) save errno before calling system calls for clean-up  [Masatake YAMATO]
   - (test_mkfds, cosmetic) add an empty line before the definition of struct sysvshm_data  [Masatake YAMATO]
   - (test_mkfds, refactor) use xmemdup newly added in xalloc.h  [Masatake YAMATO]
   - (test_mkfds,refactor) simplify nested if conditions  [Masatake YAMATO]
   - (test_mkfdsbpf-prog) report id and tag  [Masatake YAMATO]
   - (test_mkfdsforeign-sockets) new factory  [Masatake YAMATO]
   - (test_mkfdsmake-regular-file) fix the default union member for \"readable\" parameter  [Masatake YAMATO]
   - (test_mkfdsmmap) new factory  [Masatake YAMATO]
   - (test_mkfdsmultiplexing) fix the factory description  [Masatake YAMATO]
   - (test_mkfdsnetlink) pass a correct file descriptor to bind(2)  [Masatake YAMATO]
   - (test_mkfdssockdiag) new factory  [Masatake YAMATO]
   - (test_mkfdssockdiag) support AF_VSOCK family  [Masatake YAMATO]
   - (test_mkfdssockdiag) verify the recieved message to detect whether the socket is usable or not  [Masatake YAMATO]
   - (test_mkfdsuserns) add a new factory  [Masatake YAMATO]
   - (test_sysinfo) add a helper to call xgethostname  [Masatake YAMATO]
   - (test_sysinfo) add a helper to detect NS_GET_USERNS  [Masatake YAMATO]
   - add --fcntl testing to flock  [Rasmus Villemoes]
   - add X-mount.nocanonicalize tests  [Karel Zak]
   - add color schema to cal(1) tests  [Karel Zak]
   - add dump from ARM with A510+A710+A715+X3  [Karel Zak]
   - add findmnt --kernel=listmount  [Karel Zak]
   - add mount-api-utils.h to linux only ifdef  [Karel Zak]
   - add skips when IPv6 is not supported  [LiviaMedeiros]
   - add su --whitelist-environment test  [Karel Zak]
   - fdisk/bsd Update expected output for alpha  [John Paul Adrian Glaubitz]
   - include <sys/mount.h> only on Linux  [Pino Toscano]
   - prepare flock for testing --fcntl  [Rasmus Villemoes]
   - properly look for ts_cap helper  [Thomas Weißschuh]
   - update dmesg deltas  [Karel Zak]
   - update findmnt -Q tests  [Karel Zak]
   - update lscpu vmware_fpe output  [Karel Zak]
text-utils:
   - add bits command  [Robin Jarry]
   - make pointer arrays const  [Max Kellermann]
textual:
   - consistently mark "=" as literal before an optional argument  [Benno Schulenberg]
   - fix some typos and inconsistencies in usage and error messages  [Benno Schulenberg]
   - fix three misspellings of "unsupported"  [Benno Schulenberg]
   - give seven error messages the same form as two others  [Benno Schulenberg]
   - make two incorrect synopses identical to a better one  [Benno Schulenberg]
   - remove other inconsistent uses of "=" before option argument  [Benno Schulenberg]
textutils:
   - introduce and use fgetwc_or_err  [Thomas Weißschuh]
   - use fgetwc() instead of getwc()  [Thomas Weißschuh]
tmpfiles:
   - add and install for uuidd, generate /run/uuidd & /var/lib/libuuid  [Christian Hesse]
   - depend on systemd...  [Christian Hesse]
treewide:
   - use fgetc() instead of getc()  [Thomas Weißschuh]
   - use scols printf api where possible  [Robin Jarry]
umount, losetup:
   - Document loop destroy behavior  [Stanislav Brabec]
unshare:
   - Add options to identity map the user's subordinate uids and gids  [David Gibson]
   - don't mark "|" and "" as part of the placeholders  [Benno Schulenberg]
   - don't use "=" before a required option argument  [Benno Schulenberg]
   - in usage text, reshuffle options into somewhat related groups  [Benno Schulenberg]
   - load binfmt_misc interpreter  [Laurent Vivier]
   - mount binfmt_misc  [Laurent Vivier]
   - use single asterisks around long options, double around values  [Benno Schulenberg]
usage:
   - mention also the missing KiB and MiB as permissible suffixes  [Benno Schulenberg]
uuidd:
   - add sysusers file  [Zbigniew Jędrzejewski-Szmek]
   - fix /var/lib/libuuid mode uuidd-tmpfiles.conf  [Karel Zak]
   - fix typo in tmpfiles.conf  [Karel Zak]
uuidd.rc:
   - create localstatedir in init script  [Christian Hesse]
uuidgen:
   - add support for RFC9562 UUIDs  [Thomas Weißschuh]
   - use xmalloc instead of malloc (#2714)  [Thorsten Kukuk]
uuidparse:
   - add support for RFC9562 UUIDs  [Thomas Weißschuh]
   - only report type/version for DCE variant  [Thomas Weißschuh]
wall:
   - always use utmp as fallback  [Karel Zak]
   - check sysconf() returnvalue  [Karel Zak]
   - fix escape sequence Injection [CVE-2024-28085]  [Karel Zak]
   - fix possible memory leak  [Karel Zak]
   - make sure unsigned variable not underflow  [Karel Zak]
wdctl:
   - always query device node when sysfs is unavailable  [Thomas Weißschuh]
whereis:
   - avoid accessing uninitialized memory  [xiovwx]
wipefs:
   - fix typo  [Karel Zak]
xalloc.h:
   - Include stdio.h header for vasprintf function  [Jordan Williams]
   - add xmemdup  [Masatake YAMATO]
zramctl:
   - add COMP-RATIO column  [Karel Zak, davidemanin]
   - add algorithm-params to bash-completion  [Karel Zak]
   - add support for `algorithm_params`  [LiviaMedeiros]
   - fix typo and memory leak  [Karel Zak]
   - improve grammar in usage and don't gettextize list of algorithms  [Benno Schulenberg]
   - rename `--params` into `--algorithm-params`  [LiviaMedeiros]
   - support -o+list notation  [Karel Zak]

- spelling and grammar fixes  [Ville Skyttä]
- Fixed report error code in blockdev. - Minor:
- Added a period at the end of "--rereadpt" description.  [EvgeniyRogov]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


