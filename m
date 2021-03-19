Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75390341FA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 15:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhCSOgZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 10:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229925AbhCSOfx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616164552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WBpjOhjd+vmj4vtopl/ZTa7342hJ/aupO1u5xG6bHHA=;
        b=ByMUjmdiMv+YVjpwbCNRW2+IlMiU3+Mhw0auQOPlD5Z6y3u9WCUxwohdNv5doJhN5D0sYr
        CGWnaBbY4PugKuRO1f1TmN0YwJRY0DcxEXfWauLv8eqDlBELTLOXFZquX1PxmFs/sIhwkj
        mEojCs2tE5g/ZcvTadciy7T0UftU7GI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-G1yX0G6NP0aku4EWChsoKA-1; Fri, 19 Mar 2021 10:35:48 -0400
X-MC-Unique: G1yX0G6NP0aku4EWChsoKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EA419393D;
        Fri, 19 Mar 2021 14:35:46 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-11.ams2.redhat.com [10.36.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DE20610F4;
        Fri, 19 Mar 2021 14:35:24 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Minchan Kim <minchan@kernel.org>,
        huang ying <huang.ying.caritas@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Rob Herring <robh@kernel.org>,
        "Pavel Machek (CIP)" <pavel@denx.de>,
        Theodore Dubois <tblodt@icloud.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Robert Richter <rric@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Kairui Song <kasong@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
Subject: [PATCH RFC 1/3] drivers/char: remove /dev/kmem for good
Date:   Fri, 19 Mar 2021 15:34:50 +0100
Message-Id: <20210319143452.25948-2-david@redhat.com>
In-Reply-To: <20210319143452.25948-1-david@redhat.com>
References: <20210319143452.25948-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Exploring /dev/kmem and /dev/mem in the context of memory hot(un)plug and
memory ballooning, I started questioning the existance of /dev/kmem.

Comparing it with the /proc/kcore implementation, it does not seem to be
able to deal with things like
a) Pages unmapped from the direct mapping (e.g., to be used by secretmem)
  -> kern_addr_valid(). virt_addr_valid() is not sufficient.
b) Special cases like gart aperture memory that is not to be touched
  -> mem_pfn_is_ram()
Unless I am missing something, it's at least broken in some cases and might
fault/crash the machine.

Looks like its existance has been questioned before in 2005 and 2010
[1], after ~11 additional years, it might make sense to revive the
discussion.

CONFIG_DEVKMEM is only enabled in a single defconfig (on purpose or by
mistake?). All distributions I looked at disable it.

1) /dev/kmem was popular for rootkits [2] before it got disabled
   basically everywhere. Ubuntu documents [3] "There is no modern user of
   /dev/kmem any more beyond attackers using it to load kernel rootkits.".
   RHEL documents in a BZ [5] "it served no practical purpose other than to
   serve as a potential security problem or to enable binary module drivers
   to access structures/functions they shouldn't be touching"

2) /proc/kcore is a decent interface to have a controlled way to read
   kernel memory for debugging puposes. (will need some extensions to
   deal with memory offlining/unplug, memory ballooning, and poisoned
   pages, though)

3) It might be useful for corner case debugging [1]. KDB/KGDB might be a
   better fit, especially, to write random memory; harder to shoot
   yourself into the foot.

4) "Kernel Memory Editor" hasn't seen any updates since 2000 and seems
   to be incompatible with 64bit [1]. For educational purposes,
   /proc/kcore might be used to monitor value updates -- or older
   kernels can be used.

5) It's broken on arm64, and therefore, completely disabled there.

Looks like it's essentially unused and has been replaced by better
suited interfaces for individual tasks (/proc/kcore, KDB/KGDB). Let's
just remove it.

[1] https://lwn.net/Articles/147901/
[2] https://www.linuxjournal.com/article/10505
[3] https://wiki.ubuntu.com/Security/Features#A.2Fdev.2Fkmem_disabled
[4] https://sourceforge.net/projects/kme/
[5] https://bugzilla.redhat.com/show_bug.cgi?id=154796

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: huang ying <huang.ying.caritas@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Brian Cain <bcain@codeaurora.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Rich Felker <dalias@libc.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Rob Herring <robh@kernel.org>
Cc: "Pavel Machek (CIP)" <pavel@denx.de>
Cc: Theodore Dubois <tblodt@icloud.com>
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Xiaoming Ni <nixiaoming@huawei.com>
Cc: Robert Richter <rric@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Cc: Corentin Labbe <clabbe@baylibre.com>
Cc: Kairui Song <kasong@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: uclinux-h8-devel@lists.sourceforge.jp
Cc: linux-hexagon@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: openrisc@lists.librecores.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-fsdevel@vger.kernel.org
Cc: Linux API <linux-api@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/devices.txt     |   2 +-
 arch/arm/configs/dove_defconfig           |   1 -
 arch/arm/configs/magician_defconfig       |   1 -
 arch/arm/configs/moxart_defconfig         |   1 -
 arch/arm/configs/mps2_defconfig           |   1 -
 arch/arm/configs/mvebu_v5_defconfig       |   1 -
 arch/arm/configs/xcep_defconfig           |   1 -
 arch/h8300/configs/edosk2674_defconfig    |   1 -
 arch/h8300/configs/h8300h-sim_defconfig   |   1 -
 arch/h8300/configs/h8s-sim_defconfig      |   1 -
 arch/hexagon/configs/comet_defconfig      |   1 -
 arch/m68k/configs/amcore_defconfig        |   1 -
 arch/openrisc/configs/or1ksim_defconfig   |   1 -
 arch/sh/configs/edosk7705_defconfig       |   1 -
 arch/sh/configs/se7206_defconfig          |   1 -
 arch/sh/configs/sh2007_defconfig          |   1 -
 arch/sh/configs/sh7724_generic_defconfig  |   1 -
 arch/sh/configs/sh7770_generic_defconfig  |   1 -
 arch/sh/configs/sh7785lcr_32bit_defconfig |   1 -
 arch/sparc/configs/sparc64_defconfig      |   1 -
 arch/xtensa/configs/xip_kc705_defconfig   |   1 -
 drivers/char/Kconfig                      |  10 -
 drivers/char/mem.c                        | 231 ----------------------
 include/linux/fs.h                        |   2 +-
 include/linux/vmalloc.h                   |   2 +-
 kernel/configs/android-base.config        |   1 -
 mm/ksm.c                                  |   2 +-
 mm/vmalloc.c                              |   2 +-
 28 files changed, 5 insertions(+), 267 deletions(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 63fd4e6a014b..beffd5e9130a 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -4,7 +4,7 @@
 
    1 char	Memory devices
 		  1 = /dev/mem		Physical memory access
-		  2 = /dev/kmem		Kernel virtual memory access
+		  2 = /dev/kmem		OBSOLETE - replaced by /proc/kcore
 		  3 = /dev/null		Null device
 		  4 = /dev/port		I/O port access
 		  5 = /dev/zero		Null byte source
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index e70c997d5f4c..b935162a8bba 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -63,7 +63,6 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_MOUSE_PS2 is not set
 # CONFIG_SERIO is not set
 CONFIG_LEGACY_PTY_COUNT=16
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
diff --git a/arch/arm/configs/magician_defconfig b/arch/arm/configs/magician_defconfig
index b4670d42f378..abde1fb23b20 100644
--- a/arch/arm/configs/magician_defconfig
+++ b/arch/arm/configs/magician_defconfig
@@ -72,7 +72,6 @@ CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_UINPUT=m
 # CONFIG_SERIO is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_PXA=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
diff --git a/arch/arm/configs/moxart_defconfig b/arch/arm/configs/moxart_defconfig
index 6834e97af348..eacc089d86c5 100644
--- a/arch/arm/configs/moxart_defconfig
+++ b/arch/arm/configs/moxart_defconfig
@@ -79,7 +79,6 @@ CONFIG_INPUT_EVBUG=y
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=1
diff --git a/arch/arm/configs/mps2_defconfig b/arch/arm/configs/mps2_defconfig
index 1d923dbb9928..89f4a6ff30bd 100644
--- a/arch/arm/configs/mps2_defconfig
+++ b/arch/arm/configs/mps2_defconfig
@@ -69,7 +69,6 @@ CONFIG_SMSC911X=y
 # CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_NONSTANDARD=y
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_MPS2_UART_CONSOLE=y
 CONFIG_SERIAL_MPS2_UART=y
 # CONFIG_HW_RANDOM is not set
diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index 4f16716bfc32..d57ff30dabff 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -100,7 +100,6 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_LEGACY_PTY_COUNT=16
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
diff --git a/arch/arm/configs/xcep_defconfig b/arch/arm/configs/xcep_defconfig
index f1fbdfc5c8c6..4d8e7f2eaef7 100644
--- a/arch/arm/configs/xcep_defconfig
+++ b/arch/arm/configs/xcep_defconfig
@@ -53,7 +53,6 @@ CONFIG_NET_ETHERNET=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_PXA=y
 CONFIG_SERIAL_PXA_CONSOLE=y
 # CONFIG_LEGACY_PTYS is not set
diff --git a/arch/h8300/configs/edosk2674_defconfig b/arch/h8300/configs/edosk2674_defconfig
index 23791dcf6c25..7137883ff4c7 100644
--- a/arch/h8300/configs/edosk2674_defconfig
+++ b/arch/h8300/configs/edosk2674_defconfig
@@ -32,7 +32,6 @@ CONFIG_BINFMT_FLAT=y
 # CONFIG_VT is not set
 # CONFIG_UNIX98_PTYS is not set
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
diff --git a/arch/h8300/configs/h8300h-sim_defconfig b/arch/h8300/configs/h8300h-sim_defconfig
index 7fc9c2f0acc0..d4e066a1529a 100644
--- a/arch/h8300/configs/h8300h-sim_defconfig
+++ b/arch/h8300/configs/h8300h-sim_defconfig
@@ -32,7 +32,6 @@ CONFIG_BINFMT_FLAT=y
 # CONFIG_VT is not set
 # CONFIG_UNIX98_PTYS is not set
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_EARLYCON=y
 # CONFIG_HW_RANDOM is not set
diff --git a/arch/h8300/configs/h8s-sim_defconfig b/arch/h8300/configs/h8s-sim_defconfig
index 23791dcf6c25..7137883ff4c7 100644
--- a/arch/h8300/configs/h8s-sim_defconfig
+++ b/arch/h8300/configs/h8s-sim_defconfig
@@ -32,7 +32,6 @@ CONFIG_BINFMT_FLAT=y
 # CONFIG_VT is not set
 # CONFIG_UNIX98_PTYS is not set
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
diff --git a/arch/hexagon/configs/comet_defconfig b/arch/hexagon/configs/comet_defconfig
index f19ae2ab0aaa..c5a214716a38 100644
--- a/arch/hexagon/configs/comet_defconfig
+++ b/arch/hexagon/configs/comet_defconfig
@@ -34,7 +34,6 @@ CONFIG_NET_ETHERNET=y
 # CONFIG_SERIO is not set
 # CONFIG_CONSOLE_TRANSLATIONS is not set
 CONFIG_LEGACY_PTY_COUNT=64
-# CONFIG_DEVKMEM is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_SPI=y
 CONFIG_SPI_DEBUG=y
diff --git a/arch/m68k/configs/amcore_defconfig b/arch/m68k/configs/amcore_defconfig
index 3a84f24d41c8..6d9ed2198170 100644
--- a/arch/m68k/configs/amcore_defconfig
+++ b/arch/m68k/configs/amcore_defconfig
@@ -60,7 +60,6 @@ CONFIG_DM9000=y
 # CONFIG_VT is not set
 # CONFIG_UNIX98_PTYS is not set
 # CONFIG_DEVMEM is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_MCF=y
 CONFIG_SERIAL_MCF_BAUDRATE=115200
 CONFIG_SERIAL_MCF_CONSOLE=y
diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
index 75f2da324d0e..6e1e004047c7 100644
--- a/arch/openrisc/configs/or1ksim_defconfig
+++ b/arch/openrisc/configs/or1ksim_defconfig
@@ -43,7 +43,6 @@ CONFIG_MICREL_PHY=y
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
diff --git a/arch/sh/configs/edosk7705_defconfig b/arch/sh/configs/edosk7705_defconfig
index ef7cc31997b1..9ee35269bee2 100644
--- a/arch/sh/configs/edosk7705_defconfig
+++ b/arch/sh/configs/edosk7705_defconfig
@@ -23,7 +23,6 @@ CONFIG_SH_PCLK_FREQ=31250000
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
-# CONFIG_DEVKMEM is not set
 # CONFIG_UNIX98_PTYS is not set
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
diff --git a/arch/sh/configs/se7206_defconfig b/arch/sh/configs/se7206_defconfig
index 315b04a8dd2f..601d062250d1 100644
--- a/arch/sh/configs/se7206_defconfig
+++ b/arch/sh/configs/se7206_defconfig
@@ -71,7 +71,6 @@ CONFIG_SMC91X=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=4
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
diff --git a/arch/sh/configs/sh2007_defconfig b/arch/sh/configs/sh2007_defconfig
index 99975db461d8..79f02f1c0dc8 100644
--- a/arch/sh/configs/sh2007_defconfig
+++ b/arch/sh/configs/sh2007_defconfig
@@ -75,7 +75,6 @@ CONFIG_INPUT_FF_MEMLESS=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_VT_HW_CONSOLE_BINDING=y
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_LEGACY_PTYS is not set
diff --git a/arch/sh/configs/sh7724_generic_defconfig b/arch/sh/configs/sh7724_generic_defconfig
index 2c46c0004780..cbc9389a89a8 100644
--- a/arch/sh/configs/sh7724_generic_defconfig
+++ b/arch/sh/configs/sh7724_generic_defconfig
@@ -18,7 +18,6 @@ CONFIG_CPU_IDLE=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=6
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
diff --git a/arch/sh/configs/sh7770_generic_defconfig b/arch/sh/configs/sh7770_generic_defconfig
index 88193153e51b..ee2357deba0f 100644
--- a/arch/sh/configs/sh7770_generic_defconfig
+++ b/arch/sh/configs/sh7770_generic_defconfig
@@ -20,7 +20,6 @@ CONFIG_CPU_IDLE=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=6
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
diff --git a/arch/sh/configs/sh7785lcr_32bit_defconfig b/arch/sh/configs/sh7785lcr_32bit_defconfig
index 9b885c14c400..5c725c75fcef 100644
--- a/arch/sh/configs/sh7785lcr_32bit_defconfig
+++ b/arch/sh/configs/sh7785lcr_32bit_defconfig
@@ -66,7 +66,6 @@ CONFIG_INPUT_FF_MEMLESS=m
 CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_EVBUG=m
 CONFIG_VT_HW_CONSOLE_BINDING=y
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=6
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index 12a4fb0bd52a..18099099583e 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -122,7 +122,6 @@ CONFIG_INPUT_SPARCSPKR=y
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIO_PCIPS2=m
 CONFIG_SERIO_RAW=m
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_SUNSU=y
 CONFIG_SERIAL_SUNSU_CONSOLE=y
 CONFIG_SERIAL_SUNSAB=y
diff --git a/arch/xtensa/configs/xip_kc705_defconfig b/arch/xtensa/configs/xip_kc705_defconfig
index 4f1ff9531f6a..062148e17135 100644
--- a/arch/xtensa/configs/xip_kc705_defconfig
+++ b/arch/xtensa/configs/xip_kc705_defconfig
@@ -72,7 +72,6 @@ CONFIG_MARVELL_PHY=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
-CONFIG_DEVKMEM=y
 CONFIG_SERIAL_8250=y
 # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index d229a2d0c017..b151e0fcdeb5 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -334,16 +334,6 @@ config DEVMEM
 	  memory.
 	  When in doubt, say "Y".
 
-config DEVKMEM
-	bool "/dev/kmem virtual device support"
-	# On arm64, VMALLOC_START < PAGE_OFFSET, which confuses kmem read/write
-	depends on !ARM64
-	help
-	  Say Y here if you want to support the /dev/kmem device. The
-	  /dev/kmem device is rarely used, but can be used for certain
-	  kind of kernel debugging operations.
-	  When in doubt, say "N".
-
 config NVRAM
 	tristate "/dev/nvram support"
 	depends on X86 || HAVE_ARCH_NVRAM_OPS
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 869b9f5e8e03..15dc54fa1d47 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -403,221 +403,6 @@ static int mmap_mem(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
-static int mmap_kmem(struct file *file, struct vm_area_struct *vma)
-{
-	unsigned long pfn;
-
-	/* Turn a kernel-virtual address into a physical page frame */
-	pfn = __pa((u64)vma->vm_pgoff << PAGE_SHIFT) >> PAGE_SHIFT;
-
-	/*
-	 * RED-PEN: on some architectures there is more mapped memory than
-	 * available in mem_map which pfn_valid checks for. Perhaps should add a
-	 * new macro here.
-	 *
-	 * RED-PEN: vmalloc is not supported right now.
-	 */
-	if (!pfn_valid(pfn))
-		return -EIO;
-
-	vma->vm_pgoff = pfn;
-	return mmap_mem(file, vma);
-}
-
-/*
- * This function reads the *virtual* memory as seen by the kernel.
- */
-static ssize_t read_kmem(struct file *file, char __user *buf,
-			 size_t count, loff_t *ppos)
-{
-	unsigned long p = *ppos;
-	ssize_t low_count, read, sz;
-	char *kbuf; /* k-addr because vread() takes vmlist_lock rwlock */
-	int err = 0;
-
-	read = 0;
-	if (p < (unsigned long) high_memory) {
-		low_count = count;
-		if (count > (unsigned long)high_memory - p)
-			low_count = (unsigned long)high_memory - p;
-
-#ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
-		/* we don't have page 0 mapped on sparc and m68k.. */
-		if (p < PAGE_SIZE && low_count > 0) {
-			sz = size_inside_page(p, low_count);
-			if (clear_user(buf, sz))
-				return -EFAULT;
-			buf += sz;
-			p += sz;
-			read += sz;
-			low_count -= sz;
-			count -= sz;
-		}
-#endif
-		while (low_count > 0) {
-			sz = size_inside_page(p, low_count);
-
-			/*
-			 * On ia64 if a page has been mapped somewhere as
-			 * uncached, then it must also be accessed uncached
-			 * by the kernel or data corruption may occur
-			 */
-			kbuf = xlate_dev_kmem_ptr((void *)p);
-			if (!virt_addr_valid(kbuf))
-				return -ENXIO;
-
-			if (copy_to_user(buf, kbuf, sz))
-				return -EFAULT;
-			buf += sz;
-			p += sz;
-			read += sz;
-			low_count -= sz;
-			count -= sz;
-			if (should_stop_iteration()) {
-				count = 0;
-				break;
-			}
-		}
-	}
-
-	if (count > 0) {
-		kbuf = (char *)__get_free_page(GFP_KERNEL);
-		if (!kbuf)
-			return -ENOMEM;
-		while (count > 0) {
-			sz = size_inside_page(p, count);
-			if (!is_vmalloc_or_module_addr((void *)p)) {
-				err = -ENXIO;
-				break;
-			}
-			sz = vread(kbuf, (char *)p, sz);
-			if (!sz)
-				break;
-			if (copy_to_user(buf, kbuf, sz)) {
-				err = -EFAULT;
-				break;
-			}
-			count -= sz;
-			buf += sz;
-			read += sz;
-			p += sz;
-			if (should_stop_iteration())
-				break;
-		}
-		free_page((unsigned long)kbuf);
-	}
-	*ppos = p;
-	return read ? read : err;
-}
-
-
-static ssize_t do_write_kmem(unsigned long p, const char __user *buf,
-				size_t count, loff_t *ppos)
-{
-	ssize_t written, sz;
-	unsigned long copied;
-
-	written = 0;
-#ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
-	/* we don't have page 0 mapped on sparc and m68k.. */
-	if (p < PAGE_SIZE) {
-		sz = size_inside_page(p, count);
-		/* Hmm. Do something? */
-		buf += sz;
-		p += sz;
-		count -= sz;
-		written += sz;
-	}
-#endif
-
-	while (count > 0) {
-		void *ptr;
-
-		sz = size_inside_page(p, count);
-
-		/*
-		 * On ia64 if a page has been mapped somewhere as uncached, then
-		 * it must also be accessed uncached by the kernel or data
-		 * corruption may occur.
-		 */
-		ptr = xlate_dev_kmem_ptr((void *)p);
-		if (!virt_addr_valid(ptr))
-			return -ENXIO;
-
-		copied = copy_from_user(ptr, buf, sz);
-		if (copied) {
-			written += sz - copied;
-			if (written)
-				break;
-			return -EFAULT;
-		}
-		buf += sz;
-		p += sz;
-		count -= sz;
-		written += sz;
-		if (should_stop_iteration())
-			break;
-	}
-
-	*ppos += written;
-	return written;
-}
-
-/*
- * This function writes to the *virtual* memory as seen by the kernel.
- */
-static ssize_t write_kmem(struct file *file, const char __user *buf,
-			  size_t count, loff_t *ppos)
-{
-	unsigned long p = *ppos;
-	ssize_t wrote = 0;
-	ssize_t virtr = 0;
-	char *kbuf; /* k-addr because vwrite() takes vmlist_lock rwlock */
-	int err = 0;
-
-	if (p < (unsigned long) high_memory) {
-		unsigned long to_write = min_t(unsigned long, count,
-					       (unsigned long)high_memory - p);
-		wrote = do_write_kmem(p, buf, to_write, ppos);
-		if (wrote != to_write)
-			return wrote;
-		p += wrote;
-		buf += wrote;
-		count -= wrote;
-	}
-
-	if (count > 0) {
-		kbuf = (char *)__get_free_page(GFP_KERNEL);
-		if (!kbuf)
-			return wrote ? wrote : -ENOMEM;
-		while (count > 0) {
-			unsigned long sz = size_inside_page(p, count);
-			unsigned long n;
-
-			if (!is_vmalloc_or_module_addr((void *)p)) {
-				err = -ENXIO;
-				break;
-			}
-			n = copy_from_user(kbuf, buf, sz);
-			if (n) {
-				err = -EFAULT;
-				break;
-			}
-			vwrite(kbuf, (char *)p, sz);
-			count -= sz;
-			buf += sz;
-			virtr += sz;
-			p += sz;
-			if (should_stop_iteration())
-				break;
-		}
-		free_page((unsigned long)kbuf);
-	}
-
-	*ppos = p;
-	return virtr + wrote ? : err;
-}
-
 static ssize_t read_port(struct file *file, char __user *buf,
 			 size_t count, loff_t *ppos)
 {
@@ -855,7 +640,6 @@ static int open_port(struct inode *inode, struct file *filp)
 #define write_zero	write_null
 #define write_iter_zero	write_iter_null
 #define open_mem	open_port
-#define open_kmem	open_mem
 
 static const struct file_operations __maybe_unused mem_fops = {
 	.llseek		= memory_lseek,
@@ -869,18 +653,6 @@ static const struct file_operations __maybe_unused mem_fops = {
 #endif
 };
 
-static const struct file_operations __maybe_unused kmem_fops = {
-	.llseek		= memory_lseek,
-	.read		= read_kmem,
-	.write		= write_kmem,
-	.mmap		= mmap_kmem,
-	.open		= open_kmem,
-#ifndef CONFIG_MMU
-	.get_unmapped_area = get_unmapped_area_mem,
-	.mmap_capabilities = memory_mmap_capabilities,
-#endif
-};
-
 static const struct file_operations null_fops = {
 	.llseek		= null_lseek,
 	.read		= read_null,
@@ -924,9 +696,6 @@ static const struct memdev {
 } devlist[] = {
 #ifdef CONFIG_DEVMEM
 	 [DEVMEM_MINOR] = { "mem", 0, &mem_fops, FMODE_UNSIGNED_OFFSET },
-#endif
-#ifdef CONFIG_DEVKMEM
-	 [2] = { "kmem", 0, &kmem_fops, FMODE_UNSIGNED_OFFSET },
 #endif
 	 [3] = { "null", 0666, &null_fops, 0 },
 #ifdef CONFIG_DEVPORT
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..a727186ef4cd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -144,7 +144,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* Expect random access pattern */
 #define FMODE_RANDOM		((__force fmode_t)0x1000)
 
-/* File is huge (eg. /dev/kmem): treat loff_t as unsigned */
+/* File is huge (eg. /dev/mem): treat loff_t as unsigned */
 #define FMODE_UNSIGNED_OFFSET	((__force fmode_t)0x2000)
 
 /* File is opened with O_PATH; almost nothing can be done with it */
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index df92211cf771..390af680e916 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -198,7 +198,7 @@ static inline void set_vm_flush_reset_perms(void *addr)
 }
 #endif
 
-/* for /dev/kmem */
+/* for /proc/kcore */
 extern long vread(char *buf, char *addr, unsigned long count);
 extern long vwrite(char *buf, char *addr, unsigned long count);
 
diff --git a/kernel/configs/android-base.config b/kernel/configs/android-base.config
index d3fd428f4b92..eb701b2ac72f 100644
--- a/kernel/configs/android-base.config
+++ b/kernel/configs/android-base.config
@@ -1,5 +1,4 @@
 #  KEEP ALPHABETICALLY SORTED
-# CONFIG_DEVKMEM is not set
 # CONFIG_DEVMEM is not set
 # CONFIG_FHANDLE is not set
 # CONFIG_INET_LRO is not set
diff --git a/mm/ksm.c b/mm/ksm.c
index 9694ee2c71de..901cab89299d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -461,7 +461,7 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
  * but taking great care only to touch a ksm page, in a VM_MERGEABLE vma,
  * in case the application has unmapped and remapped mm,addr meanwhile.
  * Could a ksm page appear anywhere else?  Actually yes, in a VM_PFNMAP
- * mmap of /dev/mem or /dev/kmem, where we would not want to touch it.
+ * mmap of /dev/mem, where we would not want to touch it.
  *
  * FAULT_FLAG/FOLL_REMOTE are because we do this outside the context
  * of the process that owns 'vma'.  We also do not want to enforce
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4f5f8c907897..ccb405b82581 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2875,7 +2875,7 @@ static int aligned_vwrite(char *buf, char *addr, unsigned long count)
  * Note: In usual ops, vread() is never necessary because the caller
  * should know vmalloc() area is valid and can use memcpy().
  * This is for routines which have to access vmalloc area without
- * any information, as /dev/kmem.
+ * any information, as /proc/kcore.
  *
  * Return: number of bytes for which addr and buf should be increased
  * (same number as @count) or %0 if [addr...addr+count) doesn't
-- 
2.29.2

