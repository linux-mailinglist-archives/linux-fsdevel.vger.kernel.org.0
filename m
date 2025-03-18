Return-Path: <linux-fsdevel+bounces-44322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD4FA675A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 14:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB86A88285B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 13:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDF520DD51;
	Tue, 18 Mar 2025 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgyTj8tJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5707E20D4EF
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306087; cv=none; b=N+aTrp5sUPrne9ut6A7M6bOL8EZrfVa4g99iK3B2JTCfEMq3LRS5zY7zFlZdOKlPatLrof80He+H+l/ANYFPQGqi+igqfXblNOLAx3zSUpGS0EsSIpGp1JGtar4eVlU/djNCZJrEqrHj7bHZk95e2Yrl0oiGZMSMV+G+1NtE9e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306087; c=relaxed/simple;
	bh=oXfYaXyDtdF/5wq3+DYIow9j725C9FV/+uj9p/N9svg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gaStpGaUfXwWU5h6A6PuyV+cINF08qzUZ1p7x3YT+1P/TUZ4HaXsvKBKPpX/8m8FlVSlwU1aFHIhl5n4TuW1F7Ux8iSppF7sSDlwtjciwuvhx6WKywV2yNhl7HVPNrgFWa4/HLFij1IIhiE95raA8dHCvkWTb2rYBvMDDwddlQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XgyTj8tJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742306082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N6hg6REF9UZ6uheD1xaeKC2dOoc0qsB2URNF6VdcL0Q=;
	b=XgyTj8tJAbQDlHHq0oxI6YIIrISCdkVM0QW6ZjXc5HVkFmgRsmfqrKafahjRCq6VgO8+Mc
	ychDLo2g1HGeGkKwSF9O0wu31PssDfaYVGdkhFjUihEyVVDihpouHz9bOL8qkvyIswSwuk
	p+5xeX10wCqzCSR0BpwOXmARdMJCWMI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-FvtzCDlhN0mU7AfC22RUag-1; Tue,
 18 Mar 2025 09:54:38 -0400
X-MC-Unique: FvtzCDlhN0mU7AfC22RUag-1
X-Mimecast-MFC-AGG-ID: FvtzCDlhN0mU7AfC22RUag_1742306077
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C372A1800265;
	Tue, 18 Mar 2025 13:54:37 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.181])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32B49180174E;
	Tue, 18 Mar 2025 13:54:34 +0000 (UTC)
Date: Tue, 18 Mar 2025 14:54:31 +0100
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.41
Message-ID: <2cifsg7vkdiivfsmmximhbzybrsopn7zfqgwz2f6hyflh35pjr@ecyicq2cbsro>
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


 The util-linux release v2.41 is now available at
                         
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

findmnt:
  - Can now address filesystems using --id and --uniq-id (requires listmount() kernel support).

flock:
  - Added support for the --fcntl command line option.

hardlink:
  - Can now prioritize specified trees on the command line using --prioritize-trees.
  - Can exclude sub-trees using --exclude-subtree or keep them in the current mount using --mount.
  - Duplicates can now be printed using --list-duplicates.

hwclock:
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

*:
    - spelling and grammar fixes (by Ville Skyttä)

agetty:
    - fix stdin conversion to tty name (by Karel Zak)
    - always read additional issue file locations (by Karel Zak)
    - fix ambiguous ‘else’ [-Werror=dangling-else] (by Karel Zak)
    - Prevent cursor escape (by Stanislav Brabec)
    - add "systemd" to --version output (by Karel Zak)
    - make reload code more robust (by Karel Zak)
    - fix resource leak (by Karel Zak)
    - Don't override TERM passed by the user (by Daan De Meyer)

all_errnos/all_syscalls:
    - use sed to extract defines from headers (by Thomas Weißschuh)
    - don't hardcode AWK invocation (by Thomas Weißschuh)
    - don't warn during cleanup (by Thomas Weißschuh)
    - fail if any step fails (by Thomas Weißschuh)

audit-arch.h:
    - add defines for m68k, sh (by Chris Hofstaedtler)

autotools:
    - add missing meson.build files (by Karel Zak)
    - Fix use of mq_open and mq_close (by Samuel Thibault)
    - remove tools/git-tp-sync-man (by Karel Zak)
    - fix po-man discheck (by Karel Zak)
    - update po-man files on make dist (by Karel Zak)
    - add missing HAVE_LIBLASTLOG2 (by Karel Zak)
    - always add man-common/ to EXTRA_DIST (by Karel Zak)
    - define HAVE_LIBPTHREAD and PTHREAD_LIBS (by Karel Zak)
    - add sysusers support (by Karel Zak)
    - check for statmount and listmount syscalls (by Karel Zak)
    - add --disable-makeinstall-tty-setgid (by Karel Zak)
    - allow enabling dmesg with --disable-all-programs (by Henrik Lindström)
    - allow enabling lsblk with --disable-all-programs (by Henrik Lindström)
    - add Libs.private to uuid.pc (by Karel Zak)
    - improve devel-non-docs config-gen scenario (by Karel Zak)
    - fix securedir and pam_lastlog2 install (by Karel Zak)
    - Check for BPF_OBJ_NAME_LEN (required by lsfd) (by Karel Zak)
    - Properly order install dependencies of pam_lastlog2 (by Thomas Weißschuh)
    - make pam install path configurable (by Thomas Weißschuh)
    - add --disable-enosys, check for linux/audit.h (by Karel Zak)
    - check for sys/vfs.h and linux/bpf.h (by Karel Zak)
    - distribute pam_lastlog2/meson.build (by Thomas Weißschuh)
    - add dependence on libsmartcols for lsclocks (by Karel Zak)
    - make errnos.h available without lsfd (by Thomas Weißschuh)

bash-completion:
    - updated lsns bash completion (by Prasanna Paithankar)
    - add `--pty` and `--no-pty` options for `su` and `runuser` (by Christoph Anton Mitterer)
    - complete `--user` only for `runuser`, not for `su` (by Christoph Anton Mitterer)
    - add nsenter --net-socket (by Karel Zak)
    - look rewrite completion logic (by Yao Zi)
    - add logger --sd-* completions (by Ville Skyttä)

bcachefs:
    - Remove BCACHEFS_SB_MAX_SIZE & check (by Tony Asleson)

bits:
    - cleanup --help output, add missing _( ) (by Karel Zak)

blkdev.h:
    - update location of SCSI device types (by Christoph Anton Mitterer)

blkdiscard:
    - (man) add note about fdisk (by Karel Zak)

blkid:
    - allow up to 64k erofs block sizes (by Eric Sandeen)
    - say "override" instead of "overwrite" in the --help text (by Benno Schulenberg)
    - add json output format (by Thomas Weißschuh)
    - (tests) test output formats (by Thomas Weißschuh)
    - (tests) use correct blkid binary (by Thomas Weißschuh)

blkpr:
    - grammarize the description of the tool and its options (by Benno Schulenberg)

blkzone:
    - improve the wording of an error message (by Benno Schulenberg)
    - correct the wording of an error message, from ioctl to function (by Benno Schulenberg)

buffer:
    - replace include of c.h with stddef.h (by Thomas Weißschuh)

build(deps):
    - bump redhat-plumbers-in-action/differential-shellcheck (by dependabot[bot])
    - bump actions/cache from 3 to 4 (by dependabot[bot])
    - bump github/codeql-action from 2 to 3 (by dependabot[bot])
    - bump actions/checkout from 1 to 4 (by dependabot[bot])

build-sys:
    - update release dates (by Karel Zak)
    - keep the most recent version in NEWS (by Karel Zak)
    - update version dates (by Karel Zak)
    - build sample-mount-overwrite only on Linux (by Pino Toscano)
    - make sure everywhere is localstatedir (by Karel Zak)
    - introduce localstatedir (by Karel Zak)

cal:
    - make sure day_in_week() does not overrun array size [coverity scan] (by Karel Zak)
    - colorize --vertical output. (by Karel Zak)
    - properly colorize the week number in vertical output. (by Karel Zak)
    - fix --week use and colors (by Karel Zak)
    - use unsigned int to follow union with unsigned int (by Karel Zak)

cfdisk:
    - add --sector-size commanand line option (by Karel Zak)
    - fix possible integer overflow [coverity scan] (by Karel Zak)
    - Remove unused struct 'cfdisk_extra' (by Dr. David Alan Gilbert)

c.h:
    - consolidate THREAD_LOCAL. (by Karel Zak)

chcpu(8):
    - Document CPU deconfiguring behavior (by Mete Durlu)
    - Fix typo (by Mete Durlu)
    - document limitations of -g (by Stanislav Brabec)

chrt:
    - (tests) Add new cases for custom slice on SCHED_{OTHER,BATCH} (by Petre Tudor)
    - (man) Add note for custom slice length on SCHED_{OTHER,BATCH} (by Petre Tudor)
    - Add --sched_runtime support for SCHED_{OTHER,BATCH} policies (by Petre Tudor)

ci:
    - bump uraimo/run-on-arch-action to v3 (by Frantisek Sumsal)
    - (reverted) temporarily switch the alt-arch job worker to Ubuntu 22.04 (by Frantisek Sumsal)
    - temporarily switch the alt-arch job worker to Ubuntu 22.04 (by Frantisek Sumsal)
    - bump coveralls compiler version to gcc 13 (by Karel Zak)
    - use clang 19 (by Thomas Weißschuh)
    - use upload action v4 (by Thomas Weißschuh)
    - use OpenWRT SDK v23.05.4 (by Thomas Weißschuh)
    - test on armv7 (by Thomas Weißschuh)
    - enable dependency manager for GitHub Actions (by Jan Macku)
    - reduce aslr level to avoid issues with ASAN (by Thomas Weißschuh)
    - use clang 18 (by Thomas Weißschuh)

CI:
    - Downgrade checkout version for compat build (by Michal Suchanek)

codeql:
    - don't report world-writable files (by Thomas Weißschuh)

colrm:
    - make the wording of the doc string analogous to that of `col` (by Benno Schulenberg)

column:
    - replace a mistaken word in an error message (by Benno Schulenberg)
    - test ANSI SGR colors inside OSC 8 hyperlink escape codes (by Juarez Rudsatz)
    - handle ANSI SGR colors inside OSC 8 hyperlink escape codes (by Juarez Rudsatz)
    - test OSC 8 hyperlink escape sequences (by Juarez Rudsatz)
    - handle OSC 8 hyperlink escape sequences (by Juarez Rudsatz)
    - Adds option -S <num> so whitespaces are used instead of tabs in non table mode. (by drax)
    - add doc comment explaining ansi code detection (by Juarez Rudsatz)
    - fix regression tests complaint (by Juarez Rudsatz)
    - add test for ansi escapes (by Juarez Rudsatz)
    - fix unaligned cols in text with ansi escapes (by Juarez Rudsatz)

column.1.adoc:
    - Fix spelling and improve option descriptions (by Nejc Bertoncelj)

{configure.ac,meson.build}:
    - conditionally build {enosys,setpriv} if seccomp is present #3280 (by Thomas Devoogdt)

coresched:
    - add bash completions (by Thijs Raymakers)
    - Manage core scheduling cookies for tasks (by Thijs Raymakers)

disk-utils:
    - make pointer arrays const (by Max Kellermann)

dmesg:
    - fix --notime use (by Karel Zak)
    - print object closing brace while waiting for next message (by Thomas Weißschuh)
    - fix wrong size calculation (by Karel Zak)
    - fix delta calculation (by Karel Zak)
    - don't affect delta by --since (by Karel Zak)

doc:
    - fsck.8.adoc - fix email typo (by Geoffrey Casper)

docs:
    - update v2.41-rc2-ReleaseNotes (by Karel Zak)
    - fix typo in v2.41-ReleaseNotes (by Chris Hofstaedtler)
    - add v2.41-ReleaseNotes (by Karel Zak)
    - reduce and freeze NEWS file (by Karel Zak)
    - reduce AUTHORS file (by Karel Zak)
    - rename v*-devel tag to v*-start (by Karel Zak)
    - add European Public License v1.2 (by Thijs Raymakers)
    - fix GPL name typo (by Karel Zak)
    - update README (by Karel Zak)
    - lsns(8) ENVIRONMENT describe LSNS_DEBUG (by Masatake YAMATO)
    - add COPYING.MIT (by Karel Zak)
    - fix typos (by Jakub Wilk)
    - add note about stable branches (by Karel Zak)
    - move GPL-2.0 license text to Docimentation directory (by Karel Zak)
    - use proper XSPD identifier for GPL-2.0 (by Karel Zak)
    - cleanup public domain license texts (by Karel Zak)
    - improve howto-pull-request (by Karel Zak)
    - remove duplicated author name in namei.1.adoc (by Emanuele Torre)
    - add hints about systemd (by Karel Zak)

enosys:
    - (man) add missing word (by Jakub Wilk)
    - allow dumping to file (by Thomas Weißschuh)
    - add support for alternative error codes (by Thomas Weißschuh)
    - generalize named number parsing (by Thomas Weißschuh)
    - add functionality to dump filter (by Thomas Weißschuh)

env:
    - add env_list_add_getenv() and env_list_add_getenvs() (by Karel Zak)
    - cleanup env_list API (by Karel Zak)
    - add "overwrite" argument to env_list_setenv() (by Karel Zak)
    - save parsed variables into ul_env_list (by Karel Zak)

exch:
    - cosmetic code changes (by Karel Zak)
    - fix compile error if renameat2 is not present (by Thomas Devoogdt)

fadvise:
    - fix a typo of an option name in the bash completion rule (by Masatake YAMATO)

fallocate:
    - rework incompatible options (by Antonio Russo)
    - keep-size and zero-range are compatible (by Antonio Russo)
    - forbid --posix with special options (by Chris Hofstaedtler)

fdisk:
    - (man) add note about partition size calculation (by Karel Zak)
    - (man) improve --sector-size description (by Karel Zak)
    - fix sgi_menu_cb return value (by mr-bronson)
    - fix fdisk_sgi_set_bootfile return value (by mr-bronson)
    - fix sgi_check_bootfile name size minimum (by mr-bronson)
    - fix SGI boot file prompt (by mr-bronson)
    - fix typos (by Karel Zak)
    - add 'T' command to discard sectors (by Karel Zak)
    - improve list_freespace() (by Karel Zak)

fincore:
    - Use correct syscall number for cachestat on alpha (by John Paul Adrian Glaubitz)

findfs:
    - (man) be more accurate in describing non-tags (by Karel Zak)

findmnt:
    - fix resource leaks [coverity scan] (by Karel Zak)
    - add --id and --uniq-id options (by Karel Zak)
    - improve --help output (by Karel Zak)
    - improve reliability of match testing (by Karel Zak)
    - add UNIQ-ID column (by Karel Zak)
    - add docs for --kernel (by Karel Zak)
    - add --kernel=listmount (by Karel Zak)
    - add optional argument to --kernel (by Karel Zak)
    - add --hyperlink command line option (by Karel Zak)
    - improve -Q to output tree (by Karel Zak)
    - (man) write about -Q,--filter option (by Masatake YAMATO)
    - add -Q,--filter option (by Masatake YAMATO)
    - (refactor) convert add_column macro to a function (by Masatake YAMATO)
    - (refactor) add a helper function making an instance of libscols_table (by Masatake YAMATO)
    - (refactor) remove global variables shared between findmnt.c and fintmnt-verify.c (by Masatake YAMATO)
    - always zero-terminate SOURCES data (by Thomas Weißschuh)
    - revise the code for -I and -D option (by Masatake YAMATO)
    - remove deleted option from manual (by Chris Hofstaedtler)

- Fixed report error code in blockdev. - Minor:
    - Added a period at the end of "--rereadpt" description. (by EvgeniyRogov)

flock:
    - document --fcntl (by Rasmus Villemoes)
    - bash-completion add --fcntl (by Rasmus Villemoes)
    - add support for using fcntl() with open file description locks (by Rasmus Villemoes)

format:
    - fix switch case indent (by jNullj)
    - fix comments and if braces format (by jNullj)
    - CamelCase to SnakeCase (by jNullj)

fsck:
    - warn if fsck.<type> not found and device is specified (by Karel Zak)

fsck.minix:
    - fix possible overrun (by Karel Zak)

fstab.5 mount.8:
    - add note about field separator (by Karel Zak)

fstrim:
    - fix SYNOPSIS/usage (mandatory fstrim -A (by -a|mountpoint)|наб)

getopt:
    - remove free-before-exit (by Karel Zak)

github:
    - enable verbose output, don't generate docs default (by Karel Zak)

gitignore:
    - ignore `test/failures` (by LiviaMedeiros)

hardlink:
    - replace a strange word in an error message (by Benno Schulenberg)
    - fix memory corruption in read buffers (by Karel Zak)
    - fix memory corruption (size calculation) (by Karel Zak)
    - add new options to the bash-completion (by Karel Zak)
    - implement --mount (by Karel Zak)
    - add missing verbose messages and unify them (by Karel Zak)
    - implement --exclude-subtree (by Karel Zak)
    - re-raise SIGINT instead of exiting (by наб)
    - fix 0-sized file processing (by наб)
    - add --list-duplicates and --zero (by наб)
    - add --prioritize-trees (by Karel Zak)
    - use xcalloc rather than xmalloc (by Karel Zak)

hardlink.1:
    - directory (by file is mandatory|наб)

hexdump:
    - allow enabling with --disable-all-programs (by Robert Marko)
    - check blocksize when display data (by Karel Zak)

hwclock:
    - avoid dereferencing a pointer [coverity scan] (by Karel Zak)
    - Support GNU Hurd (by Zhaoming Luo)
    - Remove ioperm declare as it causes nested extern declare warning (by Zhaoming Luo)
    - cleanup save_adjtime() (by Karel Zak)
    - add -param-index (by Karel Zak)
    - free temporary variable before return (by Karel Zak)
    - initialize parser variables (by Karel Zak)

include:
    - use public domain for colors.{c,h} and xalloc.h (by Karel Zak)
    - add functions to implement --hyperlink (by Karel Zak)
    - Include <unistd.h> in pidfd-utils.h for syscall() (by Xi Ruoyao)
    - introduce seccomp.h (by Thomas Weißschuh)

include/blkdev:
    - share BLKDISCARD macros (by Karel Zak)

include/c:
    - add BIT() (by Karel Zak)

include/c.h:
    - pass const pointer array to print_features() (by Max Kellermann)

include/debug:
    - Relicense to Public Domain (by Karel Zak)

include/mount-api-utils:
    - improve coding style (by Karel Zak)
    - fix typo (by Karel Zak)
    - add statmount and listmount (by Karel Zak)

include/optstr:
    - improve optstr parsing (by Karel Zak)

include/pidfd-utils:
    - improve robustness (by Karel Zak)
    - add namespaces ioctls (by Karel Zak)
    - provide ENOSYS stubs if pidfd functions are missing (by Thomas Weißschuh)
    - remove hardcoded syscall fallback (by Karel Zak)

Include/strutils:
    - xstrncpy() returns the number of copied bytes (by Karel Zak)

include/timeutils:
    - add time_diff() (by Karel Zak)

include/ttyutils:
    - add terminal hyperlink ESC sequences (by Karel Zak)

ipc:
    - coding style cosmetic changes (by Karel Zak)

ipcrm:
    - simplify code (by Yang Kun)

irqtop,lsirq:
    - set up locale path, so messages get actually translated (by Benno Schulenberg)

jsonwrt:
    - add ul_jsonwrt_flush (by Thomas Weißschuh)

kill:
    - (test) add a case for testing -l 0xSIGMASK and -d $PID options (by Masatake YAMATO)
    - add a feature decoding signal masks (by Masatake YAMATO)

last:
    - avoid out of bounds array access (by biubiuzy)

lastlog:
    - cleanup function definitions (by Karel Zak)
    - improve errors printing (by Karel Zak)

lastlog2:
    - Improve comments and documentation (by Tobias Stoeckmann)
    - begin descriptions of options with a lowercase letter (by Benno Schulenberg)
    - rename tmpfiles (by Christian Hesse)
    - convert check_user() to boolean-like macro (by Karel Zak)
    - make longopts[] static-const (by Karel Zak)
    - improve coding style (by Karel Zak)
    - Don't print space if Service column is not printed (by Miika Alikirri)
    - Fix various issues with meson (by Fabian Vogt)

lastlog2,uuidd:
    - rename tmpfiles config file (by Zbigniew Jędrzejewski-Szmek)

lib:
    - make pointer arrays const (by Max Kellermann)

libblkid:
    - fix potential memory leaks (by Karel Zak)
    - (gpt) use blkid_probe_verify_csum() for partition array checksum (by Thomas Weißschuh)
    - fix spurious ext superblock checksum mismatches (by Krister Johansen)
    - zfs fix overflow warning [coverity scan] (by Ameer Hamza)
    - make pointer arrays const (by Max Kellermann)
    - zfs Use nvlist for detection instead of Uber blocks (by Ameer Hamza)
    - add FSLASTBLOCK for swaparea (by Karel Zak)
    - (exfat) validate fields used by prober (by Thomas Weißschuh)
    - improve portability (by Yang Kun)
    - apfs validate checksums (by Thomas Weißschuh)
    - bitlocker add drive label (by Victor Westerhuis)
    - bitlocker use volume identifier as UUID (by Victor Westerhuis)
    - bitlocker add image for Windows 7+ BitLocker (by Victor Westerhuis)
    - bitlocker fix version on big-endian systems (by Victor Westerhuis)
    - make example more robust (by Karel Zak)
    - topology/ioctl simplify ioctl handling (by Thomas Weißschuh)
    - topology/ioctl correctly handle kernel types (by Thomas Weißschuh)
    - Fix segfault when blkid.conf doesn't exist (by Karel Zak)
    - check OPAL lock only when necessary (by Oldřich Jedlička)
    - use correct logging prefix for checksum mismatch (by Thomas Weißschuh)
    - introduce luks opal prober (by Thomas Weißschuh)
    - Check offset in LUKS2 header (by Milan Broz)

lib/buffer:
    - introduce ul_buffer_get_string() (by Thomas Weißschuh)

lib/colors:
    - fix fallback to system directory (by Thomas Weißschuh)
    - free unnecessary ncurses resources (by Karel Zak)

libfdisk:
    - make pointer arrays const (by Max Kellermann)
    - make sure libblkid uses the same sector size (by Karel Zak)
    - (dos) ignore incomplete EBR for non-wholedisk (by Karel Zak)
    - check alignment reset return codes (by Karel Zak)
    - fix fdisk_partition_start_follow_default() docs (by Karel Zak)
    - add initializer to geometry (by Karel Zak)
    - add missing va_end() [coverity scan] (by Karel Zak)
    - add fdisk_ask_menu() (by Karel Zak)

lib/fileutils:
    - add ul_basename() (by Karel Zak)

lib/jsonwrt:
    - introduce ul_jsonwrt_empty() (by Karel Zak)

liblastlog2:
    - (test) fix memory leak in failed test [coverity scan] (by Karel Zak)
    - tests provide fallback PATH_MAX definition (by Pino Toscano)
    - Improved sqlite3 error handling (by Stefan Schubert)

libmount:
    - remove possible leak in mnt_context_guess_srcpath_fstype() [coverity scan] (by Karel Zak)
    - add support for STATMOUNT_SB_SOURCE (by Karel Zak)
    - fix table_init_listmount() (by Karel Zak)
    - fix use-after free, etc. [coverity scan] (by Karel Zak)
    - improve error messages in ID-mapping hook (by Karel Zak)
    - add private mnt_context_read_mesgs() (by Karel Zak)
    - reduce size of syscall-failed message (by Karel Zak)
    - (reverted) exec mount helpers with posixly correct argument order (by Karel Zak)
    - read all types of kernel messages (by Karel Zak)
    - map unsupported LISTMOUNT_REVERSE to ENOSYS (by Karel Zak)
    - add mnt_table_find_[uniq]_id() function (by Karel Zak)
    -  fix mnt_fs_match_target() (by Karel Zak)
    - improve fs->stmnt_done mask use (by Karel Zak)
    - improve how library generates fs->optstr (by Karel Zak)
    - remove unnecessary include (by Karel Zak)
    - Add integer type headers to private header file (by Karel Zak)
    - use __unused__ for dummy get_mnt_id() (by Karel Zak)
    - update tests (by Karel Zak)
    - ifdef STATMOUNT_* in sample (by Karel Zak)
    - ifdef STATX_MNT_ID_UNIQUE (by Karel Zak)
    - ifdef listmount and statmount stuff (by Karel Zak)
    - fix typo in symbols list (by Karel Zak)
    - (docs) add missing api indexes (by Karel Zak)
    - add listmount() sample (by Karel Zak)
    - add support for listmount() (by Karel Zak)
    - fix __table_insert_fs() (by Karel Zak)
    - add support for statmount() (by Karel Zak)
    - use unique ID in utab (by Karel Zak)
    - add API to read ID by statx() (by Karel Zak)
    - Add API to get/set unique IDs (by Karel Zak)
    - remember parsed propagation (by Karel Zak)
    - add statmount to features list (by Karel Zak)
    - add mount-api-utils.h to mountP.h (by Karel Zak)
    - create EROFS loopdev only after ENOTBLK (by Karel Zak)
    - exec mount helpers with posixly correct argument order (by nilfsuser5678)
    - support X-mount.noloop (by Karel Zak)
    - implement ro[=vfs,fs] (by Karel Zak)
    - improving readability (by Karel Zak)
    - support bind symlink over symlink (by Karel Zak)
    - add X-mount.nocanonicalize[=source (by target]|Karel Zak)
    - cleanup comments (by Karel Zak)
    - propagate first error of multiple filesystem types (by John Keeping)
    - extract common error handling function (by John Keeping)
    - improving robustness in reading kernel messages (by Karel Zak)
    - fix tree FD usage in subdir hook (by Karel Zak)
    - expose exec errors (by Karel Zak)
    - (loop) detect and report lost loop nodes (by Karel Zak)
    - add mnt_context_sprintf_errmsg() (by Karel Zak)
    - add functions to use error buffer (by Karel Zak)
    - use regular function to save/reset syscalls status (by Karel Zak)
    - Fix atime remount for new API (by Karel Zak)
    - fix possible memory leak (by Karel Zak)
    - fix umount --read-only (by Karel Zak)
    - Fix access check for utab in context (by Karel Zak)
    - fix comment typo for mnt_fs_get_comment() (by Tianjia Zhang)
    - don't initialize variable twice (#2714) (by Thorsten Kukuk)
    - make sure "option=" is used as string (by Karel Zak)
    - Fix export of mnt_context_is_lazy and mnt_context_is_onlyonce (by Matt Turner)
    - report kernel message from new API (by Karel Zak)
    - don't hold write fd to mounted device (by Jan Kara)
    - (reverted) don't canonicalize symlinks for bind operation (by Karel Zak)
    - fix copy & past bug in lock initialization (by Karel Zak)

Libmount:
    - Fix removal of "owner" option when executed as root (by Karel Zak)

libmount/context_mount:
    - fix argument number comments (by nilfsuser5678)

libmount/hooks:
    - make `hooksets` array const (by Max Kellermann)

libmount/utils:
    - add pidfs to pseudo fs list (by Mike Yuan)

lib/pager:
    - (reverted) Apply pager-specific fixes only when needed (by Thomas Weißschuh)

lib/path:
    - use _vreadf_buffer for _cpuparse() (by Thomas Weißschuh)
    - introduce ul_path_vreadf_buffer (by Thomas Weißschuh)
    - use _read_buffer for _read_string() (by Thomas Weißschuh)
    - add ul_path_statf() and ul_path_vstatf() (by Karel Zak)

lib/pty-session:
    - Don't ignore SIGHUP. (by Kuniyuki Iwashima)

lib/sha1:
    - fix for old glibc (by Karel Zak)

libsmartcol docs:
    - Format samples, lists, tables (by FeRD (Frank Dana))

libsmartcols:
    - add support for terminal hyperlinks (by Karel Zak)
    - make pointer arrays const (by Max Kellermann)
    - make __attributes__ more portable (by Karel Zak)
    - add printf api to fill in column data (by Robin Jarry)
    - fix reduction stages use (by Karel Zak)
    - fix column reduction (by Karel Zak)
    - (sample) add wrap repeating example (by Karel Zak)
    - reset wrap after calculation (by Karel Zak)
    - (filter) emulate YYerror for old Bison (by Karel Zak)
    - (filter) check vasprintf() return value (by Karel Zak)
    - (filter) accept prefixes like k, M, G as a parts of a number (by Karel Zak)
    - (filter) use variable argument lists for yyerror() (by Karel Zak)
    - print empty arrays in better way (by Karel Zak)

libsmartcols/src/Makemodule.am:
    - ensure filter-scanner/paser.c file is newer than the .h file (by Chen Qi)

lib/sysfs:
    - zero-terminate result of sysfs_blkdev_get_devchain() (by Thomas Weißschuh)
    - abort device hierarchy walk at root of sysfs (by Thomas Weißschuh)

libuuid:
    - support non-cached scenarios (when -lpthread is unavailable) (by Karel Zak)
    - fix gcc15 warnings (by Cristian Rodríguez)
    - set variant in the corrrect byte __uuid_set_variant_and_version (by oittaa)
    - link test_uuid_time with pthread (by Thomas Weißschuh)
    - construct UUIDv7 without "struct uuid" (by Thomas Weißschuh)
    - construct UUIDv6 without "struct uuid" (by Thomas Weißschuh)
    - add helper to set version and variant in uuid_t (by Thomas Weißschuh)
    - test time-based UUID generation (by Thomas Weißschuh)
    - drop duplicate assignment liuuid_la_LDFLAGS (by Karel Zak)
    - fix v6 generation (by Thomas Weißschuh)
    - clear uuidd cache on fork() (by Thomas Weißschuh)
    - split uuidd cache into dedicated struct (by Thomas Weißschuh)
    - drop check for HAVE_TLS (by Thomas Weißschuh)
    - add support for RFC9562 UUIDs (by Thomas Weißschuh)
    - (man) fix function declarations (by CismonX)

logger:
    - grammarize the description of --socket-errors in the man page (by Benno Schulenberg)
    - (man) fix --socket-error (by Karel Zak)
    - do not show arguments of --socket-errors as optional in --help (by Benno Schulenberg)
    - correctly format tv_usec (by Thomas Weißschuh)
    - rework error handling in logger_gettimeofday() (by Thomas Weißschuh)
    - handle failures of gettimeofday() (by Thomas Weißschuh)

login:
    - actually honour $HOME for chdir() (by Lennart Poettering)
    - add LOGIN_ENV_SAFELIST /etc/login.def item (by Karel Zak)

login,libblkid:
    - use econf_readConfig rather than deprecated econf_readDirs (by Karel Zak)

login-utils:
    - make pointer arrays const (by Max Kellermann)

login-utils/su-common:
    - Validate all return values again (by Thomas Weißschuh)
    - Check that the user didn't change during PAM transaction (by Marco Trevisan (Treviño))

losetup.8:
    - Clarify --direct-io (by Colin Walters)

lsblk:
    - add --hyperlink command line option (by Karel Zak)
    - update bash-completion/lsblk (by Karel Zak)
    - update --help (by Karel Zak)
    - add --properties-by option (by Karel Zak)
    - simplify SOURCES code (by Karel Zak)
    - (refactor) refer to a parameter instead of a file static var (by Masatake YAMATO)

lsclocks:
    - fix dynamic clock ids (by Thomas Weißschuh)
    - fix FD leak (by Karel Zak)

lscpu:
    - New Arm part numbers (by Jeremy Linton)
    - skip frequencies of 0 MHz when getting minmhz (by Ricardo Neri)
    - make three column descriptions more grammatical (by Benno Schulenberg)
    - Add FUJITSU aarch64 MONAKA cpupart (by Emi, Kisanuki)
    - use bool type in control structs (by Karel Zak)
    - add --raw command line option (by Karel Zak)
    - fix incorrect number of sockets during hotplug (by Anjali K)
    - add procfs–sysfs dump from Milk-V Pioneer (by Jan Engelhardt)
    - optimize query virt pci device (by Guixin Liu)
    - make code more readable (by Karel Zak)
    - Skip aarch64 decode path for rest of the architectures (by Pratik R. Sampat)
    - use CPU types de-duplication (by Karel Zak)
    - New Arm Cortex part numbers (by Jeremy Linton)
    - initialize all variables (#2714) (by Thorsten Kukuk)
    - don't use NULL sharedmap (by Karel Zak)
    - restructure op-mode printing (by Thomas Weißschuh)

lsfd:
    - (man) fix a typo (by Masatake YAMATO)
    - initialize struct stat [coverity scan] (by Karel Zak)
    - (man) fix a typo (by Masatake YAMATO)
    - remove C++ comment (by Karel Zak)
    - support AF_VSOCK sockets (by Masatake YAMATO)
    - don't enable hyperlinks for deleted files (by Masatake YAMATO)
    - enable hyperlinks only for regular files and directories (by Masatake YAMATO)
    - add --hyperlink command line option (by Karel Zak)
    - consolidate add_column() (by Karel Zak)
    - (man) add more filter examples related to unix stream sockets (by Masatake YAMATO)
    - add BPF-PROG.TAG column (by Masatake YAMATO)
    - update bpf related tables (by Masatake YAMATO)
    - (bugfix) fix wrong type usage in anon_bpf_map_fill_column (by Masatake YAMATO)
    - avoid accessing an uninitialized value (by Masatake YAMATO)
    - finalize abst_class (by Masatake YAMATO)
    - Gather information on target socket's net namespace (by Dmitry Safonov)
    - minimize the output related to lsfd itself (by Masatake YAMATO)
    - (tests) skip tests using fd flags on qemu-user (by Thomas Weißschuh)
    - (refactor) use ul_path_statf and ul_path_readlinkf (by Masatake YAMATO)
    - include linux/fcntl.h (by Thomas Weißschuh)
    - include buffer.h in decode-file-flags.h (by Thomas Weißschuh)
    - move interface of decode-file-flags to header (by Thomas Weißschuh)
    - (man) add commas between SEE ALSO items (by Jakub Wilk)
    - (man) fix license name (by Jakub Wilk)
    - (man) fix typos (by Jakub Wilk)
    - add meson.build for the command (by Masatake YAMATO)
    - (po-man) update po4a.cfg (by Karel Zak)
    - move the source code to new ./lsfd-cmd directory (by Masatake YAMATO)
    - add LSFD_DEBUG env var for debugging (by Masatake YAMATO)
    - test Adapt test cases for pidfs (by Xi Ruoyao)
    - Support pidfs (by Xi Ruoyao)
    - Refactor the pidfd logic into lsfd-pidfd.c (by Xi Ruoyao)
    - (man) fix the decoration of an optional parameter (by Masatake YAMATO)
    - extend nodev table to decode "btrfs" on SOURCE column (by Masatake YAMATO)
    - (refactor) rename a member of struct proc (by Masatake YAMATO)
    - (refactor) rename a local variable and a parameter (by Masatake YAMATO)
    - (refactor) split the function processing mountinfo file (by Masatake YAMATO)
    - (refactor) store a mnt_namespace object to struct process (by Masatake YAMATO)
    - (refactor) use a binary tree as the implementation for mnt_namespaces (by Masatake YAMATO)
    - read /proc/$pid/ns/mnt earlier (by Masatake YAMATO)
    - (refactor) rename add_nodevs to read_mountinfo (by Masatake YAMATO)
    - make the way to read /proc/$pid/mountinfo robust (by Masatake YAMATO)
    - (cosmetic) normalize whitespaces (by Masatake YAMATO)
    - add --_drop-prvilege option for testing purpose (by Masatake YAMATO)
    - add ERROR as a new type (by Masatake YAMATO)
    - (refactor) make the steps for new_file consistent (by Masatake YAMATO)
    - (refactor) add abst_class as super class of file_class (by Masatake YAMATO)
    - (refactor) simplify the step to make a file struct (by Masatake YAMATO)
    - (refactor) simplify the step to copy a file struct if the result of its stat is reusable (by Masatake YAMATO)
    - (refactor) flatten bit fields in struct file (by Masatake YAMATO)
    - fix typos of a function name (by Masatake YAMATO)

lsfd-cmd:
    - make pointer arrays const (by Max Kellermann)

lsfd,test_mkfds:
    - (refactor) specify the variable itself as an operand of sizeof (by Masatake YAMATO)

lsipc:
    - doesn't mount /dev/mqueue (by Prasanna Paithankar)
    - (man) add note about default outputs (by Karel Zak)
    - improve variable naming (by Karel Zak)
    - fix semaphore USED counter (by Karel Zak)

lsirq:
    - add option to limit cpus (by Robin Jarry)

lsirq,irqtop:
    - cleanup threshold datatype (by Karel Zak)
    - add threshold option (by Robin Jarry)

lslocks:
    - remove unnecessary code (by Karel Zak)
    - remove deadcode [coverity scan] (by Karel Zak)
    - remove a unused local variable (by Masatake YAMATO)
    - don't abort gathering per-process information even if opening a /proc/[0-9]* fails (by Masatake YAMATO)
    - fix buffer overflow (by Karel Zak)

lslogins:
    - fix typo (by Karel Zak)
    - remove possible memory leaks [coverity scan] (by Karel Zak)
    - don't ignore stat error (by Thorsten Kukuk)

lsmem:
    - increase the available width for the summary text labels (by Benno Schulenberg)
    - make an error message identical to one used in seven other places (by Benno Schulenberg)
    - improve coding style (by Karel Zak)
    - make lsmem to check for the nodes more robust (by zhangyao)

lsns:
    - check for mnt_fs_get_target return value (by Karel Zak)
    - List network namespaces that are held by a socket (by Dmitry Safonov)
    - don't call close(2) if unnecessary (by Masatake YAMATO)
    - ignore ESRCH errors reported when accessing files under /proc (by Masatake YAMATO)
    - (refactor) use ls_path_{openf (by statf} to make the code simple|Masatake YAMATO)
    - verify the uniqueness of a namespace in ls->namespaces list (by Masatake YAMATO)
    - (refactor) make the function names for reading namespaces consistent (by Masatake YAMATO)
    - (refactor) rename read_related_namespaces to connect_namespaces (by Masatake YAMATO)
    - (refactor) rename get_ns_ino() to get_ns_inos() (by Masatake YAMATO)
    - (refactor) use get_{parent (by owner}_ns_ino() in add_namespace_for_nsfd|Masatake YAMATO)
    - (refactor) add get_{parent (by owner}_ns_ino() implementing some parts of get_ns_ino()|Masatake YAMATO)
    - (refactor) give a enumeration name 'lsns_type' to LSNS_TYPE_ enumerators (by Masatake YAMATO)
    - (refactor) rename LSNS_ID_.* to LSNS_TYPE_.* (by Masatake YAMATO)
    - fix netns use (by Karel Zak)
    - add --filter option to the --help optout and the completion rule (by Masatake YAMATO)
    - report with warnx if a namespace related ioctl fails with ENOSYS (by Masatake YAMATO)
    - fill the netsid member of lsns_process with reliable value (by Masatake YAMATO)
    - tolerate lsns_ioctl(fd, NS_GET_{PARENT,USERNS}) failing with ENOSYS (by Masatake YAMATO)
    - add more print-debug code (by Masatake YAMATO)
    - continue the executing even if opening a /proc/$pid fails (by Masatake YAMATO)
    - fix ul_path_stat() error handling [coverity scan] (by Karel Zak)
    - show namespaces only kept alive by open file descriptors (by Masatake YAMATO)
    - (refactor) use ul_new_path and procfs_process_init_path (by Masatake YAMATO)
    - add -H, --list-columns option (by Masatake YAMATO)
    - implement -Q, --filter option (by Masatake YAMATO)
    - add a missing '=' character in the help message (by Masatake YAMATO)
    - (man) make the namespace parameter optional (by Masatake YAMATO)

man pages:
    - use the same verb for --version as for --help, like in usages (by Benno Schulenberg)
    - document `--user` option for `runuser` (by Christoph Anton Mitterer)
    - use `user` rather than `username` (by Christoph Anton Mitterer)

mesg:
    - remove ability to compile with fchmod(S_IWOTH) (by Karel Zak)

meson:
    - bring hexdump in line with others (by Christian Hesse)
    - demote two libraries to library (by Rosen Penev)
    - generate man page translations (by Jordan Williams)
    - use files() for man page source files (by Jordan Williams)
    - define have_linux_blkzoned_h (by Frantisek Sumsal)
    - check for blkzoned.h (by Karel Zak)
    - add HAVE_LIBPTHREAD (by Karel Zak)
    - correctly detect posix_fallocate (by Chris Hofstaedtler)
    - use tmpfilesdir pkg-config variable (by Karel Zak)
    - do not hardcode /var in uuidd-sysusers.conf. (by Karel Zak)
    - fix after rebase (by Karel Zak)
    - check for statmount and listmount syscalls (by Karel Zak)
    - add missing `is_disabler` checks (by Sam James)
    - add checking build-findfs. (by Alexander Shursha)
    - Fix checking options build-bits. (by Alexander Shursha)
    - Check options for building lib_pam_misc (by Alexander Shursha)
    - checking build_libsmartcols for manadocs. (by Alexander Shursha)
    - checking build_libblkid for manadocs (by Alexander Shursha)
    - add checking build-cal (by Alexander Shursha)
    - fix checking build-sulogin (by Alexander Shursha)
    - fix checking build-login (by Alexander Shursha)
    - fix checking build-cramfs (by Alexander Shursha)
    - Add build-hexdump option (by Alexander Shursha)
    - remove unused lastlog-compat-symlink option (by Jordan Williams)
    - add -D tty-setgid=[false (by true]|Karel Zak)
    - test for pidfd_getfd() (by Thomas Weißschuh)
    - don't install getopt examples if disabled (by Rosen Penev)
    - check for BPF_OBJ_NAME_LEN and linux/bpf.h (by Karel Zak)
    - fix generated header paths (by amibranch)
    - simplify code (by Yang Kun)
    - use a / b instead of join_paths(a, b) (by Dmitry V. Levin)
    - add options for more utilities (by Rosen Penev)
    - add missing sample-mount-overwrite (by Karel Zak)
    - po disable if nls is disabled (by Rosen Penev)
    - Correctly require the Python.h header for the python dependency (by Jordan Williams)
    - Only require Python module when building pylibmount (by Jordan Williams)
    - Fix build-python option (by Jordan Williams)
    - Add build-lsclocks option (by Jordan Williams)
    - Add build-enosys option (by Jordan Williams)
    - Define _DARWIN_C_SOURCE on macOS as is done in Autotools (by Jordan Williams)
    - Fix build by default and install behavior for build-pipesz option (by Jordan Williams)
    - Add build-fadvise option (by Jordan Williams)
    - Add build-scriptlive option (by Jordan Williams)
    - Add build-script option (by Jordan Williams)
    - Require pty for the su and runuser executables (by Jordan Williams)
    - Add have_pty variable to check if pty is available (by Jordan Williams)
    - Add build-blockdev option (by Jordan Williams)
    - Add build-chcpu option (by Jordan Williams)
    - Use has_type instead of sizeof to detect cpu_set_t type (by Jordan Williams)
    - Add build-setarch option (by Jordan Williams)
    - Add build-rtcwake option (by Jordan Williams)
    - Add build-ldattach option (by Jordan Williams)
    - Add build-blkdiscard option (by Jordan Williams)
    - Add build-fsfreeze option (by Jordan Williams)
    - Add build-blkzone option (by Jordan Williams)
    - Add build-blkpr option (by Jordan Williams)
    - Add build-dmesg option (by Jordan Williams)
    - Use is_absolute to determine if the prefix directory is absolute (by Jordan Williams)
    - Require the seminfo type for ipcmk, ipcrm, and ipcs (by Jordan Williams)
    - Add build-ipcmk option (by Jordan Williams)
    - Add missing check for build-ipcrm option (by Jordan Williams)
    - Remove libblkid dependency on libmount (by Jordan Williams)
    - Make the zlib dependency a disabler when not found (by Jordan Williams)
    - Make ncurses dependency a disabler when not found (by Jordan Williams)
    - Make tinfo dependency a disabler when not found (by Jordan Williams)
    - Only use the --version-script linker flag where it is supported (by Jordan Williams)
    - Require the sys/vfs.h header for libmount and fstrim (by Jordan Williams)
    - Disable targets requiring pam when it is missing (by Jordan Williams)
    - Require Python dependency which can be embedded for pylibmount (by Jordan Williams)
    - Enforce sqlite dependency for liblastlog2 (by Jordan Williams)
    - use signed chars (by Thomas Weißschuh)
    - Only build libmount when required (by Jordan Williams)
    - Use libblkid as a dependency (by Jordan Williams)
    - Use libmount as a dependency (by Jordan Williams)
    - Only pick up the rt library once (by Jordan Williams)
    - Add build-lsfd option and make rt dependency optional (by Jordan Williams)
    - Fix false positive detection of mempcpy on macOS (by Jordan Williams)
    - respect c_args/CFLAGS when generating syscalls/errnos (by Thomas Weißschuh)
    - Don't define HAVE_ENVIRON_DECL when environ is unavailable (by Jordan Williams)
    - Only require the crypt library when necessary (by Jordan Williams)
    - Only build blkzone and blkpr if the required linux header exists (by Jordan Williams)
    - fix LIBBLKID_VERSION definition (by Karel Zak)
    - avoid future-deprecated feature (by Thomas Weißschuh)
    - run compiler checks with -D_GNU_SOURCE when necessary (by Thomas Weißschuh)
    - fix build of lslogins with -Dbuild-liblastlog2=disabled (by Thomas Weißschuh)
    - install lastlog2.h library header file (by Karel Zak)
    - Only build libmount python module if python was found (by Fabian Vogt)
    - fix mismatch with handling of lib_dl dependency (by Zbigniew Jędrzejewski-Szmek)
    - add forgotten files to lists (by Zbigniew Jędrzejewski-Szmek)
    - fix disablement check (by Zbigniew Jędrzejewski-Szmek)

misc-utils:
    - make pointer arrays const (by Max Kellermann)

misc-utils/lastlog2:
    - Add option -a for listing active users only (by WanBingjiang)

misc-utils:uuidd:
    - Use ul_sig_err instead of errx (by Cristian Rodríguez)

mkfs.cramfs:
    - in usage text, separate two direct arguments from options (by Benno Schulenberg)

mkswap:
    - remove unused variable for non-nocow systems (by Karel Zak)
    - add features list to --version output (by Karel Zak)
    - fix includes (by Karel Zak)
    - improve --file option for use on btrfs (by Karel Zak)
    - set selinux label also when creating file (by Zbigniew Jędrzejewski-Szmek)

mkswap.8.adoc:
    - update note regarding swapfile creation (by Mike Yuan)

more:
    - remove a duplicate call of setlocale() (by Benno Schulenberg)
    - fix repeat command (by Karel Zak)
    - fix compilation (by Yang Kun)
    - make sure we have data on stderr (by Karel Zak)
    - remove second check for EOF (#2714) (by Thorsten Kukuk)
    - fix poll() use (by Karel Zak)

mount:
    - (man) add info about info messages (by Karel Zak)
    - properly mark the arguments of the 'ro' and 'rw' extended options (by Benno Schulenberg)
    - print info and warning messages (by Karel Zak)
    - use ul_optstr_is_valid() (by Karel Zak)
    - (man) add note about symlink over symlink (by Karel Zak)
    - (man) add note about -o bind,rw (by Karel Zak)

nsenter:
    - support empty environ[] (by Karel Zak)
    - improve portability to older kernels (by Karel Zak)
    - Rewrite --user-parent to use pidfd (by Karel Zak)
    - reuse pidfd for --net-socket (by Karel Zak)
    - use macros to access the nsfiles array (by Karel Zak)
    - use pidfd to enter target namespaces (by Karel Zak)
    - use separate function to enter namespaces (by Karel Zak)
    - add functions to enable/disable namespaces (by Karel Zak)
    - Provide an option to join target process's socket net namespace (by Dmitry Safonov)

pam_lastlog2:
    - remove symbol that doesn't exist from version script (by psykose)
    - drop duplicate assignment pam_lastlog2_la_LDFLAGS (by Thomas Weißschuh)
    - link against liblastlog (by Thomas Weißschuh)

partx:
    - Fix example in man page (by Michal Suchanek)

pg:
    - make sure cmdline[] not overflow [coverity scan] (by Karel Zak)

po:
    - update uk.po (from translationproject.org) (by Yuri Chornoivan)
    - update ro.po (from translationproject.org) (by Remus-Gabriel Chelu)
    - update pl.po (from translationproject.org) (by Jakub Bogusz)
    - update nl.po (from translationproject.org) (by Benno Schulenberg)
    - update ko.po (from translationproject.org) (by Seong-ho Cho)
    - update hr.po (from translationproject.org) (by Božidar Putanec)
    - update fr.po (from translationproject.org) (by Frédéric Marchal)
    - merge changes (by Karel Zak)
    - update nl.po (from translationproject.org) (by Benno Schulenberg)
    - update es.po (from translationproject.org) (by Antonio Ceballos Roa)
    - merge changes (by Karel Zak)
    - update LINGUAS list (by Karel Zak)
    - update hr.po (from translationproject.org) (by Božidar Putanec)
    - merge changes (by Karel Zak)
    - update zh_CN.po (from translationproject.org) (by Mingye Wang (Artoria2e5))
    - update uk.po (from translationproject.org) (by Yuri Chornoivan)
    - update tr.po (from translationproject.org) (by Emir SARI)
    - update sr.po (from translationproject.org) (by Мирослав Николић)
    - update ro.po (from translationproject.org) (by Remus-Gabriel Chelu)
    - update pt_BR.po (from translationproject.org) (by Rafael Fontenelle)
    - update pl.po (from translationproject.org) (by Jakub Bogusz)
    - update nl.po (from translationproject.org) (by Benno Schulenberg)
    - update ko.po (from translationproject.org) (by Seong-ho Cho)
    - update ja.po (from translationproject.org) (by Hideki Yoshida)
    - update hr.po (from translationproject.org) (by Božidar Putanec)
    - update fr.po (from translationproject.org) (by Frédéric Marchal)
    - update es.po (from translationproject.org) (by Antonio Ceballos Roa)
    - update de.po (from translationproject.org) (by Mario Blättermann)
    - update cs.po (from translationproject.org) (by Petr Písař)

po-man:
    - merge changes (by Karel Zak)
    - add pl.po (from translationproject.org) (by Michał Kułach)
    - update uk.po (from translationproject.org) (by Yuri Chornoivan)
    - update ro.po (from translationproject.org) (by Remus-Gabriel Chelu)
    - update fr.po (from translationproject.org) (by Frédéric Marchal)
    - fix typos in configuration (by Karel Zak)
    - merge changes (by Karel Zak)
    - merge changes (by Karel Zak)
    - update uk.po (from translationproject.org) (by Yuri Chornoivan)
    - update sr.po (from translationproject.org) (by Мирослав Николић)
    - update ro.po (from translationproject.org) (by Remus-Gabriel Chelu)
    - update pt_BR.po (from translationproject.org) (by Rafael Fontenelle)
    - update ko.po (from translationproject.org) (by Seong-ho Cho)
    - update fr.po (from translationproject.org) (by Frédéric Marchal)
    - update de.po (from translationproject.org) (by Mario Blättermann)
    - add missing pages, improve output (by Karel Zak)
    - add asciidoctor --trace (by Karel Zak)
    - add missing asciidoctor-unicodeconverter (by Karel Zak)
    - fix uninstall (by Karel Zak)
    - fix 'make dist' (by Karel Zak)
    - cleanup install (by Karel Zak)
    - move scripts tools/ (by Karel Zak)
    - rewrite autotools code (by Karel Zak)
    - improve translation and install scripts (by Karel Zak)
    - fix typo, update .gitignore (by Karel Zak)
    - add missing langs to po4a.cfg (by Karel Zak)

prlimit:
    - in man page, mark --resource as placeholder, not literal option (by Benno Schulenberg)

README.licensing/flock:
    - Add MIT license mention (by Richard Purdie)

readprofile:
    - put two things that belong together into a single message (by Benno Schulenberg)

rename:
    - use ul_basename() (by Karel Zak)

renice:
    - put text that belongs together into a single translatable message (by Benno Schulenberg)

rev:
    - standardize the usage header, making the synopsis equal to another (by Benno Schulenberg)
    - Check for wchar conversion errors (by Tim Hallmann)

schedutils:
    - make pointer arrays const (by Max Kellermann)

script:
    - mention in usage that value for <size> may have a suffix (by Benno Schulenberg)

scriptlive:
    - improve some descriptions, markup, and grammar in the manpage (by Benno Schulenberg)
    - reduce two usage synopses to one simple one (by Benno Schulenberg)
    - add --echo <never (by always|auto>|Karel Zak)
    - echo re-run commands from in stream (by Matt Cover)

scriptreplay:
    - mark literal values in the man page in bold, not italic (by Benno Schulenberg)
    - reduce two usage synopses to one, and drop the -t from it (by Benno Schulenberg)
    - make Up/Down keys use a percentage instead of fixed amount (by Benno Schulenberg)
    - indicate that <divisor> is conditional on <typescript> (by Benno Schulenberg)
    - add key bindings info to --help (by Karel Zak)
    - fix compiler warning (by Karel Zak)
    - fix uninitialized value [coverity scan] (by Karel Zak)

setpriv:
    - make message for failing PR_GET_PDEATHSIG the same as the other (by Benno Schulenberg)
    - describe --groups more correctly in the usage text (by Benno Schulenberg)
    - consistently use "<caps>" to indicate a list of capabilities (by Benno Schulenberg)
    - Add --ptracer, which calls PR_SET_PTRACER (by Geoffrey Thomas)
    - (tests) add seccomp test (by Thomas Weißschuh)
    - add support for seccomp filters (by Thomas Weißschuh)

setpriv.c:
    - fix memory leak in parse_groups function (by AntonMoryakov)

setterm:
    - mark literal values in the man page in bold (by Benno Schulenberg)
    - put an option and its description in a single message (by Benno Schulenberg)
    - improve "bright %s" error message (by Karel Zak)
    - Document behavior of redirection (by Stanislav Brabec)

sfdisk:
    - make sure partition number > 0 [coverity scan] (by Karel Zak)
    - add --sector-size commanand line option (by Karel Zak)
    - add --discard-free (by Karel Zak)
    - ignore last-lba from script on --force (by Karel Zak)

strutils.h:
    - Include strings.h header for strncasecmp function (by Jordan Williams)

su:
    - (man) fix duplicate asterisk (by Gaël PORTAY)
    - use lib/env.c for --whitelist-environment (by Karel Zak)
    - fix use after free in run_shell (by Tanish Yadav)

su, agetty:
    - don't use program_invocation_short_name for openlog() (by Karel Zak)

sulogin:
    - extend --version features list (by Karel Zak)
    - fix POSIX locale use (by Karel Zak)

swapoff:
    - avoid being killed by OOM (by Karel Zak)

swapon:
    - remove unnecessary variable usage (by Karel Zak)
    - make options --help and --version override --summary (by Benno Schulenberg)

sys-utils:
    - remove redundant comparison in read_hypervisor_dmi in lscpu-virt.c (by Anton Moryakov)
    - warns if mqueue fs is not mounted (by Prasanna Paithankar)
    - fixed build system for POSIX IPC tools (by Prasanna Paithankar)
    - fix add NULL check for mnt_fs_get_target return value (by AntonMoryakov)
    - (setpriv) fix potential memory leak (by Maks Mishin)
    - make pointer arrays const (by Max Kellermann)
    - (save_adjtime) fix memory leak (by Maks Mishin)
    - (setpriv) fix potential memory leak (by Maks Mishin)
    - hwclock-rtc fix pointer usage (by Karthikeyan Krishnasamy)

sys-utils/chmem:
    - fix typo. (by WanBingjiang)

sys-utils/irq-common:
    - fix SPDX typos (by Karel Zak)

sys-utils/lscpu:
    - Change object type to SCOLS_JSON_STRING if data == "-" (by WanBingjiang)

sys-utils/setarch.c:
    - fix build with uclibc-ng < 1.0.39 (by Fabrice Fontaine)

sys-utils/setpgid:
    - fix --help typo (foregound > foreground) + alignment (by Emanuele Torre)
    - make -f work (by Emanuele Torre)

terminal-colors.d:
    - support NO_COLOR (by Karel Zak)

term-utils:
    - make pointer arrays const (by Max Kellermann)

test:
    - (test_mkfds) add -O option for describing output values (by Masatake YAMATO)

test_mkfds:
    - disable ppoll multiplexer if sigset_t is not defined (by Masatake YAMATO)
    - remove local pidfd_open() fallback (by Karel Zak)
    - reserve file descriptors in the early stage of execution (by Masatake YAMATO)
    - (bugfix) listing ALL output values for a given factory (by Masatake YAMATO)
    - (cosmetic) remove whitespaces between a function and its arguments (by Masatake YAMATO)

tests:
    - update lsmem outputs (by Karel Zak)
    - (lsns/nsfs) consider the cases that lsns returns multiple paths (by Masatake YAMATO)
    - (lsns/nsfs) check test_sysinfo helper (by Masatake YAMATO)
    - improve test_sysinfo to check for NS_GET_NSTYPE usability (by Karel Zak)
    - check for ns-get*-ok (by Karel Zak)
    - mark lsns/filer as TS_KNOWN_FAIL (by Karel Zak)
    - (lslogins) use GMT timezone (by Karel Zak)
    - (lslogins) write to TS_OUTDIR only, check for sqlite3 (by Karel Zak)
    - (lslogins) use fixed time format (by Karel Zak)
    - add findmnt --kernel=listmount (by Karel Zak)
    - (lsfd::mkfds_vsock) skip if diag socket for AF_VSOCK is unavailable (by Masatake YAMATO)
    - (test_mkfds::sockdiag) support AF_VSOCK family (by Masatake YAMATO)
    - (lsns::filter) skip if /proc/self/uid_map is not writable (by Masatake YAMATO)
    - (lsfd-functions.bash) add a missing constant (by Masatake YAMATO)
    - (lsfd) quote '$' in patterns in a case/esac block (by Masatake YAMATO)
    - fdisk/bsd Update expected output for alpha (by John Paul Adrian Glaubitz)
    - add skips when IPv6 is not supported (by LiviaMedeiros)
    - (test_sysinfo) add a helper to call xgethostname (by Masatake YAMATO)
    - (test_mkfds::make-regular-file) fix the default union member for \"readable\" parameter (by Masatake YAMATO)
    - (lsfd::mkfds-bpf-prog) verify BPF-PROG.{ID,TAG} column (by Masatake YAMATO)
    - (test_mkfds::bpf-prog) report id and tag (by Masatake YAMATO)
    - (liblastlog2) don't write to stderr and stdout (by Karel Zak)
    - (test_mkfds) add a missing word in a comment (by Masatake YAMATO)
    - (lsfd) verify SOCK.NETID and ENDPOINTS for sockets made in another netns (by Masatake YAMATO)
    - (lsns) verify the code finding an isolated netns via socket (by Masatake YAMATO)
    - (nsenter) verify the code entering the network ns via socket made in the ns (by Masatake YAMATO)
    - (test_sysinfo) add a helper to detect NS_GET_USERNS (by Masatake YAMATO)
    - (test_mkfds::foreign-sockets) new factory (by Masatake YAMATO)
    - (test_mkfds, refactor) use xmemdup newly added in xalloc.h (by Masatake YAMATO)
    - (test_mkfds) fix a typo in an option name (by Masatake YAMATO)
    - add X-mount.nocanonicalize tests (by Karel Zak)
    - (test_mkfds) don't close fds and free memory objects when exiting with EXIT_FAILURE (by Masatake YAMATO)
    - (test_mkfds,refactor) simplify nested if conditions (by Masatake YAMATO)
    - (test_mkfds) save errno before calling system calls for clean-up (by Masatake YAMATO)
    - (test_mkfds, cosmetic) add an empty line before the definition of struct sysvshm_data (by Masatake YAMATO)
    - (test_mkfds) fix the way to detect errors in fork(2) (by Masatake YAMATO)
    - add su --whitelist-environment test (by Karel Zak)
    - update findmnt -Q tests (by Karel Zak)
    - properly look for ts_cap helper (by Thomas Weißschuh)
    - add mount-api-utils.h to linux only ifdef (by Karel Zak)
    - include <sys/mount.h> only on Linux (by Pino Toscano)
    - (findmnt) add a case testing -Q option (by Masatake YAMATO)
    - add dump from ARM with A510+A710+A715+X3 (by Karel Zak)
    - update lscpu vmware_fpe output (by Karel Zak)
    - add color schema to cal(1) tests (by Karel Zak)
    - add --fcntl testing to flock (by Rasmus Villemoes)
    - prepare flock for testing --fcntl (by Rasmus Villemoes)
    - (lsns::ioctl_ns) add more debug print (by Masatake YAMATO)
    - (lsns::ioctl_ns) record stdout/stderr for debugging the case (by Masatake YAMATO)
    - (lsfd) don't refer "$?" on the line follwoing the use of "local" (by Masatake YAMATO)
    - (functions.sh) add a helper funcion making a device number from given major and minor nums (by Masatake YAMATO)
    - (lsns::filedesc) skip if NS_GET_NSTYPE ioctl cmd not available (by Masatake YAMATO)
    - (lsns::filedesc) enable debug output and show the exit status (by Masatake YAMATO)
    - (lsns::filter) don't use double-quotes chars for PID (by Masatake YAMATO)
    - (lsns::filter) add more debug printing (by Masatake YAMATO)
    - (lsns::filter) delete an unused variable (by Masatake YAMATO)
    - (lsfd::mkfds-multiplexing) skip if /proc/$pid/syscall is broken (by Masatake YAMATO)
    - (test_mkfds::sockdiag) verify the recieved message to detect whether the socket is usable or not (by Masatake YAMATO)
    - (lsfd) skip some cases if NETLINK_SOCK_DIAG for AF_UNIX is not available (by Masatake YAMATO)
    - (test_mkfds::sockdiag) new factory (by Masatake YAMATO)
    - (lsfd-functions.bash,cosmetic) unify the style to define functions (by Masatake YAMATO)
    - (lsfd) fix typoes in an error name (by Masatake YAMATO)
    - (test_mkfds::netlink) pass a correct file descriptor to bind(2) (by Masatake YAMATO)
    - (lsns) add a case testing -Q, --filter option (by Masatake YAMATO)
    - (test_mkfds::userns) add a new factory (by Masatake YAMATO)
    - (test_mkfds::multiplexing) fix the factory description (by Masatake YAMATO)
    - (lsfd::mkfds-inotify) consider environments not having / as a mount point (by Masatake YAMATO)
    - (lsfd::mkfds-inotify-btrfs) test INOTIFY.INODES cooked output (by Masatake YAMATO)
    - update dmesg deltas (by Karel Zak)
    - (lsfd) add a case testing ERROR type appeared in TYPE column (by Masatake YAMATO)
    - (test_mkfds::mmap) new factory (by Masatake YAMATO)

test_sysinfo:
    - remove memory lea [coverity scan] (by Karel Zak)

textual:
    - make two incorrect synopses identical to a better one (by Benno Schulenberg)
    - fix three misspellings of "unsupported" (by Benno Schulenberg)
    - give seven error messages the same form as two others (by Benno Schulenberg)
    - consistently mark "=" as literal before an optional argument (by Benno Schulenberg)
    - remove other inconsistent uses of "=" before option argument (by Benno Schulenberg)
    - fix some typos and inconsistencies in usage and error messages (by Benno Schulenberg)

text-utils:
    - make pointer arrays const (by Max Kellermann)
    - add bits command (by Robin Jarry)

textutils:
    - introduce and use fgetwc_or_err (by Thomas Weißschuh)
    - use fgetwc() instead of getwc() (by Thomas Weißschuh)

tmpfiles:
    - depend on systemd... (by Christian Hesse)
    - add and install for uuidd, generate /run/uuidd & /var/lib/libuuid (by Christian Hesse)

tools:
    - add SPDX-License-Identifier (by Karel Zak)

tools/git-grouped-log:
    - sort output (by Karel Zak)
    - add from master branch (by Karel Zak)

tools/git-tp-sync:
    - update also po-man (by Karel Zak)
    - fix checkout -f use (by Karel Zak)
    - require git (by Karel Zak)
    - merge changes to PO files (by Karel Zak)
    - support multiple directories (by Karel Zak)
    - reuse git ls-files calls (by Karel Zak)
    - add --dry-run and --help (by Karel Zak)
    - Compare Revisions (by Karel Zak)

tools/git-tp-sync-man:
    - remove obsolete script (by Karel Zak)

tools/git-version-bump:
    - add from master branch (by Karel Zak)

tools/poman-translate:
    - fix to work outside on source dir (by Karel Zak)

treewide:
    - use scols printf api where possible (by Robin Jarry)
    - use fgetc() instead of getc() (by Thomas Weißschuh)

umount, losetup:
    - Document loop destroy behavior (by Stanislav Brabec)

unshare:
    - fix typo in --map-groups=subids map name [coverity scan] (by Karel Zak)
    - make strings more robust (by Karel Zak)
    - in usage text, reshuffle options into somewhat related groups (by Benno Schulenberg)
    - don't mark " (by " and ":" as part of the placeholders|Benno Schulenberg)
    - use single asterisks around long options, double around values (by Benno Schulenberg)
    - don't use "=" before a required option argument (by Benno Schulenberg)
    - Add options to identity map the user's subordinate uids and gids (by David Gibson)
    - load binfmt_misc interpreter (by Laurent Vivier)
    - mount binfmt_misc (by Laurent Vivier)

usage:
    - mention also the missing KiB and MiB as permissible suffixes (by Benno Schulenberg)

uuidd:
    - add sysusers file (by Zbigniew Jędrzejewski-Szmek)
    - fix typo in tmpfiles.conf (by Karel Zak)
    - fix /var/lib/libuuid mode uuidd-tmpfiles.conf (by Karel Zak)

uuidd.rc:
    - create localstatedir in init script (by Christian Hesse)

uuidgen:
    - add support for RFC9562 UUIDs (by Thomas Weißschuh)
    - use xmalloc instead of malloc (#2714) (by Thorsten Kukuk)

uuidparse:
    - add support for RFC9562 UUIDs (by Thomas Weißschuh)
    - only report type/version for DCE variant (by Thomas Weißschuh)

various:
    - (man) list --help and --version last among the options (by Benno Schulenberg)

wall:
    - always use utmp as fallback (by Karel Zak)
    - check sysconf() returnvalue (by Karel Zak)
    - fix possible memory leak (by Karel Zak)
    - make sure unsigned variable not underflow (by Karel Zak)
    - fix escape sequence Injection [CVE-2024-28085] (by Karel Zak)

Wall:
    - Fix terminal flag usage . Signed-off-by Karel Zak <kzak@redhat.com> (by Karel Zak)

wdctl:
    - always query device node when sysfs is unavailable (by Thomas Weißschuh)

whereis:
    - avoid accessing uninitialized memory (by xiovwx)

wipefs:
    - fix typo (by Karel Zak)

xalloc.h:
    - add xmemdup (by Masatake YAMATO)
    - Include stdio.h header for vasprintf function (by Jordan Williams)

zramctl:
    - improve grammar in usage and don't gettextize list of algorithms (by Benno Schulenberg)
    - add algorithm-params to bash-completion (by Karel Zak)
    - rename `--params` into `--algorithm-params` (by LiviaMedeiros)
    - add support for `algorithm_params` (by LiviaMedeiros)
    - fix typo and memory leak (by Karel Zak)
    - support -o+list notation (by Karel Zak)
    - add COMP-RATIO column (by Karel Zak)

Misc:
    - Use ipc_stat::cgid for the column COL_CGID. (by Koutheir Attouchi)
    - remove duplicate includes (by Karel Zak)
    - Defined macros for POSIX IPC compilation and removed path buffer. (by Prasanna Paithankar)
    - Fix CodeQL warning (by Prasanna Paithankar)
    - bash completions for IPC tools (by Prasanna Paithankar)
    - Fix --disable-widechar compile warnings (by Marc Aurèle La France)
    - rectified long formatting error (by Prasanna Paithankar)
    - configured for meson build system (by Prasanna Paithankar)
    - added POSIX IPC paathnames; modified sys-utils/Makemodule.am (by Prasanna Paithankar)
    - added POSIX IPC support to lsipc, ipcrm, ipcmk (by Prasanna Paithankar)
    - Add fuse.portal to list of pseudo file systems (by Stanislav Brabec)
    - refactor things to avoid an other header. (by Mark Harfouche)
    - Include errno.h within lsfd.c (by Mark Harfouche)
    - Fix non-Linux build (by Samuel Thibault)
    - test_sysinfo; fix fsopen() ifdef (by Karel Zak)
    - Fix table formatting (by M Sirabella)
    - Drop pointless bitfields (by Zbigniew Jędrzejewski-Szmek)
    - Skip tmpfs-sensitive tests if fstype cannot be determined (by Chris Hofstaedtler)
    - Update chsh.1.adoc to avoid duplicates in man page (by bearhoney)
    - Fix typos in TODO (by Firas Khalil Khana)
    - Update description of --disable-poman in configure.ac (by Firas Khalil Khana)
    - Optionally execute a program after group change (by Gábor Németh)
    - Define EXIT_ENOSYS in test helpers (by Mark Harfouche)
    - fix it's vs. its, and some adjacent errors (by mr-bronson)
    - fix spelling and typos (by mr-bronson)
    - fix typos (by Yang Hau)
    - Add missing section comment (by Uwe Seimet)
    - Add GPT type for Minix filesystem (by Uwe Seimet)
    - Fix typos (by Tobias Stoeckmann)
    - Treat out of memory as error (by Tobias Stoeckmann)
    - Add GPT type "Atari TOS raw data (XHDI)" (by Uwe Seimet)
    - Fix the typos (by Yang Hau)
    - Add thread dep to libuuid meson.build (by Satadru Pramanik, DO, MPH, MEng)
    - Add GPT type "Atari TOS basic data" (734E5AFE-F61A-11E6-BC64-92361F002671) (by Uwe Seimet)
    - Prevent problems with period after the URL (by Thomas Bertels)
    - fix clang compile (by jNullj)
    - replace fgetwc with fgetc (by jNullj)
    - Add Qualcomm Oryon ARM core (by Sophon)
    - Refactor convoluted switch case into if else (by jNullj)
    - Conditionally add uuid_time64 to sym. version map (by Nicholas Vinson)
    - Fix fstab order in `column` manpage example. (by Rom)
    - fix formatting and add mising break (by jNullj)
    - Add missing author (by jNullj)
    - Add interactive playback docs (by jNullj)
    - Add right arrow key to step forward in playback (by jNullj)
    - Fix ul_path_read_buffer() (by Daan De Meyer)
    - Remove uneeded veriable (by jNullj)
    - Add support for adjusting replay speed with arrow keys (by jNullj)
    - Refactor to handle responsive input (by jNullj)
    - Add pause functionality to replay (by jNullj)
    - Refactor delay_for function signature to use const struct timeval (by jNullj)
    - Set stdin to nonblock (by jNullj)
    - last/lastb field truncation indicator (by Jason Stewart)
    - Allow printf to be used on signal handlers (by Cristian Rodríguez)
    - suL fix use after free on error (by Karel Zak)
    - (minor) update sulogin.c (by Leaflet)
    - libsmartcols; (filter) make libscols_filter accessible in lex (by Karel Zak)
    - Fix misplaced else in mnt_update_already_done (by Gavin Lloyd)
    - add static partx (by BinBashBanana)
    - Adding Neoverse-V3/-N3 ARM cores (by Thomas Kaiser)
    - Add Microsoft as vendor and Cobalt 100 core (by Thomas Kaiser)
    - Save and restore errno on signal handlers (by Cristian Rodríguez)
    - added build option login-lastlogin (by Stefan Schubert)
    - added sqlite3 to packit (by Stefan Schubert)
    - added sqlite3 to debian build (by Stefan Schubert)
    - fixed time (by Stefan Schubert)
    - unifiy test output (by Stefan Schubert)
    - cleanup tests (by Stefan Schubert)
    - cleanup tests (by Stefan Schubert)
    - fixed time-stamp (by Stefan Schubert)
    - creating lastlog2 database in the tests (by Stefan Schubert)
    - check test output (by Stefan Schubert)
    - cleanup; Added testcase for lslogins and lastlog2 DB (by Stefan Schubert)



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


