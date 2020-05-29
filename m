Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997EF1E71A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 02:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgE2AfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 20:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgE2AfO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 20:35:14 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679FEC08C5C6;
        Thu, 28 May 2020 17:35:14 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSzQ-00HFQj-Pv; Fri, 29 May 2020 00:35:12 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 01/10] comedi: move compat ioctl handling to native fops
Date:   Fri, 29 May 2020 01:35:04 +0100
Message-Id: <20200529003512.4110852-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200529003419.GX23230@ZenIV.linux.org.uk>
References: <20200529003419.GX23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

mechanical move

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/staging/comedi/Makefile          |   1 -
 drivers/staging/comedi/comedi_compat32.c | 455 -------------------------------
 drivers/staging/comedi/comedi_compat32.h |  28 --
 drivers/staging/comedi/comedi_fops.c     | 451 +++++++++++++++++++++++++++++-
 4 files changed, 448 insertions(+), 487 deletions(-)
 delete mode 100644 drivers/staging/comedi/comedi_compat32.c
 delete mode 100644 drivers/staging/comedi/comedi_compat32.h

diff --git a/drivers/staging/comedi/Makefile b/drivers/staging/comedi/Makefile
index 6af5da3b4315..072ed83a5a6a 100644
--- a/drivers/staging/comedi/Makefile
+++ b/drivers/staging/comedi/Makefile
@@ -4,7 +4,6 @@ ccflags-$(CONFIG_COMEDI_DEBUG)		:= -DDEBUG
 comedi-y				:= comedi_fops.o range.o drivers.o \
 					   comedi_buf.o
 comedi-$(CONFIG_PROC_FS)		+= proc.o
-comedi-$(CONFIG_COMPAT)			+= comedi_compat32.o
 
 obj-$(CONFIG_COMEDI_PCI_DRIVERS)	+= comedi_pci.o
 obj-$(CONFIG_COMEDI_PCMCIA_DRIVERS)	+= comedi_pcmcia.o
diff --git a/drivers/staging/comedi/comedi_compat32.c b/drivers/staging/comedi/comedi_compat32.c
deleted file mode 100644
index 36a3564ba1fb..000000000000
--- a/drivers/staging/comedi/comedi_compat32.c
+++ /dev/null
@@ -1,455 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * comedi/comedi_compat32.c
- * 32-bit ioctl compatibility for 64-bit comedi kernel module.
- *
- * Author: Ian Abbott, MEV Ltd. <abbotti@mev.co.uk>
- * Copyright (C) 2007 MEV Ltd. <http://www.mev.co.uk/>
- *
- * COMEDI - Linux Control and Measurement Device Interface
- * Copyright (C) 1997-2007 David A. Schleef <ds@schleef.org>
- */
-
-#include <linux/uaccess.h>
-#include <linux/compat.h>
-#include <linux/fs.h>
-#include "comedi.h"
-#include "comedi_compat32.h"
-
-#define COMEDI32_CHANINFO _IOR(CIO, 3, struct comedi32_chaninfo_struct)
-#define COMEDI32_RANGEINFO _IOR(CIO, 8, struct comedi32_rangeinfo_struct)
-/*
- * N.B. COMEDI32_CMD and COMEDI_CMD ought to use _IOWR, not _IOR.
- * It's too late to change it now, but it only affects the command number.
- */
-#define COMEDI32_CMD _IOR(CIO, 9, struct comedi32_cmd_struct)
-/*
- * N.B. COMEDI32_CMDTEST and COMEDI_CMDTEST ought to use _IOWR, not _IOR.
- * It's too late to change it now, but it only affects the command number.
- */
-#define COMEDI32_CMDTEST _IOR(CIO, 10, struct comedi32_cmd_struct)
-#define COMEDI32_INSNLIST _IOR(CIO, 11, struct comedi32_insnlist_struct)
-#define COMEDI32_INSN _IOR(CIO, 12, struct comedi32_insn_struct)
-
-struct comedi32_chaninfo_struct {
-	unsigned int subdev;
-	compat_uptr_t maxdata_list;	/* 32-bit 'unsigned int *' */
-	compat_uptr_t flaglist;	/* 32-bit 'unsigned int *' */
-	compat_uptr_t rangelist;	/* 32-bit 'unsigned int *' */
-	unsigned int unused[4];
-};
-
-struct comedi32_rangeinfo_struct {
-	unsigned int range_type;
-	compat_uptr_t range_ptr;	/* 32-bit 'void *' */
-};
-
-struct comedi32_cmd_struct {
-	unsigned int subdev;
-	unsigned int flags;
-	unsigned int start_src;
-	unsigned int start_arg;
-	unsigned int scan_begin_src;
-	unsigned int scan_begin_arg;
-	unsigned int convert_src;
-	unsigned int convert_arg;
-	unsigned int scan_end_src;
-	unsigned int scan_end_arg;
-	unsigned int stop_src;
-	unsigned int stop_arg;
-	compat_uptr_t chanlist;	/* 32-bit 'unsigned int *' */
-	unsigned int chanlist_len;
-	compat_uptr_t data;	/* 32-bit 'short *' */
-	unsigned int data_len;
-};
-
-struct comedi32_insn_struct {
-	unsigned int insn;
-	unsigned int n;
-	compat_uptr_t data;	/* 32-bit 'unsigned int *' */
-	unsigned int subdev;
-	unsigned int chanspec;
-	unsigned int unused[3];
-};
-
-struct comedi32_insnlist_struct {
-	unsigned int n_insns;
-	compat_uptr_t insns;	/* 32-bit 'struct comedi_insn *' */
-};
-
-/* Handle translated ioctl. */
-static int translated_ioctl(struct file *file, unsigned int cmd,
-			    unsigned long arg)
-{
-	if (file->f_op->unlocked_ioctl)
-		return file->f_op->unlocked_ioctl(file, cmd, arg);
-
-	return -ENOTTY;
-}
-
-/* Handle 32-bit COMEDI_CHANINFO ioctl. */
-static int compat_chaninfo(struct file *file, unsigned long arg)
-{
-	struct comedi_chaninfo __user *chaninfo;
-	struct comedi32_chaninfo_struct __user *chaninfo32;
-	int err;
-	union {
-		unsigned int uint;
-		compat_uptr_t uptr;
-	} temp;
-
-	chaninfo32 = compat_ptr(arg);
-	chaninfo = compat_alloc_user_space(sizeof(*chaninfo));
-
-	/* Copy chaninfo structure.  Ignore unused members. */
-	if (!access_ok(chaninfo32, sizeof(*chaninfo32)) ||
-	    !access_ok(chaninfo, sizeof(*chaninfo)))
-		return -EFAULT;
-
-	err = 0;
-	err |= __get_user(temp.uint, &chaninfo32->subdev);
-	err |= __put_user(temp.uint, &chaninfo->subdev);
-	err |= __get_user(temp.uptr, &chaninfo32->maxdata_list);
-	err |= __put_user(compat_ptr(temp.uptr), &chaninfo->maxdata_list);
-	err |= __get_user(temp.uptr, &chaninfo32->flaglist);
-	err |= __put_user(compat_ptr(temp.uptr), &chaninfo->flaglist);
-	err |= __get_user(temp.uptr, &chaninfo32->rangelist);
-	err |= __put_user(compat_ptr(temp.uptr), &chaninfo->rangelist);
-	if (err)
-		return -EFAULT;
-
-	return translated_ioctl(file, COMEDI_CHANINFO, (unsigned long)chaninfo);
-}
-
-/* Handle 32-bit COMEDI_RANGEINFO ioctl. */
-static int compat_rangeinfo(struct file *file, unsigned long arg)
-{
-	struct comedi_rangeinfo __user *rangeinfo;
-	struct comedi32_rangeinfo_struct __user *rangeinfo32;
-	int err;
-	union {
-		unsigned int uint;
-		compat_uptr_t uptr;
-	} temp;
-
-	rangeinfo32 = compat_ptr(arg);
-	rangeinfo = compat_alloc_user_space(sizeof(*rangeinfo));
-
-	/* Copy rangeinfo structure. */
-	if (!access_ok(rangeinfo32, sizeof(*rangeinfo32)) ||
-	    !access_ok(rangeinfo, sizeof(*rangeinfo)))
-		return -EFAULT;
-
-	err = 0;
-	err |= __get_user(temp.uint, &rangeinfo32->range_type);
-	err |= __put_user(temp.uint, &rangeinfo->range_type);
-	err |= __get_user(temp.uptr, &rangeinfo32->range_ptr);
-	err |= __put_user(compat_ptr(temp.uptr), &rangeinfo->range_ptr);
-	if (err)
-		return -EFAULT;
-
-	return translated_ioctl(file, COMEDI_RANGEINFO,
-				(unsigned long)rangeinfo);
-}
-
-/* Copy 32-bit cmd structure to native cmd structure. */
-static int get_compat_cmd(struct comedi_cmd __user *cmd,
-			  struct comedi32_cmd_struct __user *cmd32)
-{
-	int err;
-	union {
-		unsigned int uint;
-		compat_uptr_t uptr;
-	} temp;
-
-	/* Copy cmd structure. */
-	if (!access_ok(cmd32, sizeof(*cmd32)) ||
-	    !access_ok(cmd, sizeof(*cmd)))
-		return -EFAULT;
-
-	err = 0;
-	err |= __get_user(temp.uint, &cmd32->subdev);
-	err |= __put_user(temp.uint, &cmd->subdev);
-	err |= __get_user(temp.uint, &cmd32->flags);
-	err |= __put_user(temp.uint, &cmd->flags);
-	err |= __get_user(temp.uint, &cmd32->start_src);
-	err |= __put_user(temp.uint, &cmd->start_src);
-	err |= __get_user(temp.uint, &cmd32->start_arg);
-	err |= __put_user(temp.uint, &cmd->start_arg);
-	err |= __get_user(temp.uint, &cmd32->scan_begin_src);
-	err |= __put_user(temp.uint, &cmd->scan_begin_src);
-	err |= __get_user(temp.uint, &cmd32->scan_begin_arg);
-	err |= __put_user(temp.uint, &cmd->scan_begin_arg);
-	err |= __get_user(temp.uint, &cmd32->convert_src);
-	err |= __put_user(temp.uint, &cmd->convert_src);
-	err |= __get_user(temp.uint, &cmd32->convert_arg);
-	err |= __put_user(temp.uint, &cmd->convert_arg);
-	err |= __get_user(temp.uint, &cmd32->scan_end_src);
-	err |= __put_user(temp.uint, &cmd->scan_end_src);
-	err |= __get_user(temp.uint, &cmd32->scan_end_arg);
-	err |= __put_user(temp.uint, &cmd->scan_end_arg);
-	err |= __get_user(temp.uint, &cmd32->stop_src);
-	err |= __put_user(temp.uint, &cmd->stop_src);
-	err |= __get_user(temp.uint, &cmd32->stop_arg);
-	err |= __put_user(temp.uint, &cmd->stop_arg);
-	err |= __get_user(temp.uptr, &cmd32->chanlist);
-	err |= __put_user((unsigned int __force *)compat_ptr(temp.uptr),
-			  &cmd->chanlist);
-	err |= __get_user(temp.uint, &cmd32->chanlist_len);
-	err |= __put_user(temp.uint, &cmd->chanlist_len);
-	err |= __get_user(temp.uptr, &cmd32->data);
-	err |= __put_user(compat_ptr(temp.uptr), &cmd->data);
-	err |= __get_user(temp.uint, &cmd32->data_len);
-	err |= __put_user(temp.uint, &cmd->data_len);
-	return err ? -EFAULT : 0;
-}
-
-/* Copy native cmd structure to 32-bit cmd structure. */
-static int put_compat_cmd(struct comedi32_cmd_struct __user *cmd32,
-			  struct comedi_cmd __user *cmd)
-{
-	int err;
-	unsigned int temp;
-
-	/*
-	 * Copy back most of cmd structure.
-	 *
-	 * Assume the pointer values are already valid.
-	 * (Could use ptr_to_compat() to set them.)
-	 */
-	if (!access_ok(cmd, sizeof(*cmd)) ||
-	    !access_ok(cmd32, sizeof(*cmd32)))
-		return -EFAULT;
-
-	err = 0;
-	err |= __get_user(temp, &cmd->subdev);
-	err |= __put_user(temp, &cmd32->subdev);
-	err |= __get_user(temp, &cmd->flags);
-	err |= __put_user(temp, &cmd32->flags);
-	err |= __get_user(temp, &cmd->start_src);
-	err |= __put_user(temp, &cmd32->start_src);
-	err |= __get_user(temp, &cmd->start_arg);
-	err |= __put_user(temp, &cmd32->start_arg);
-	err |= __get_user(temp, &cmd->scan_begin_src);
-	err |= __put_user(temp, &cmd32->scan_begin_src);
-	err |= __get_user(temp, &cmd->scan_begin_arg);
-	err |= __put_user(temp, &cmd32->scan_begin_arg);
-	err |= __get_user(temp, &cmd->convert_src);
-	err |= __put_user(temp, &cmd32->convert_src);
-	err |= __get_user(temp, &cmd->convert_arg);
-	err |= __put_user(temp, &cmd32->convert_arg);
-	err |= __get_user(temp, &cmd->scan_end_src);
-	err |= __put_user(temp, &cmd32->scan_end_src);
-	err |= __get_user(temp, &cmd->scan_end_arg);
-	err |= __put_user(temp, &cmd32->scan_end_arg);
-	err |= __get_user(temp, &cmd->stop_src);
-	err |= __put_user(temp, &cmd32->stop_src);
-	err |= __get_user(temp, &cmd->stop_arg);
-	err |= __put_user(temp, &cmd32->stop_arg);
-	/* Assume chanlist pointer is unchanged. */
-	err |= __get_user(temp, &cmd->chanlist_len);
-	err |= __put_user(temp, &cmd32->chanlist_len);
-	/* Assume data pointer is unchanged. */
-	err |= __get_user(temp, &cmd->data_len);
-	err |= __put_user(temp, &cmd32->data_len);
-	return err ? -EFAULT : 0;
-}
-
-/* Handle 32-bit COMEDI_CMD ioctl. */
-static int compat_cmd(struct file *file, unsigned long arg)
-{
-	struct comedi_cmd __user *cmd;
-	struct comedi32_cmd_struct __user *cmd32;
-	int rc, err;
-
-	cmd32 = compat_ptr(arg);
-	cmd = compat_alloc_user_space(sizeof(*cmd));
-
-	rc = get_compat_cmd(cmd, cmd32);
-	if (rc)
-		return rc;
-
-	rc = translated_ioctl(file, COMEDI_CMD, (unsigned long)cmd);
-	if (rc == -EAGAIN) {
-		/* Special case: copy cmd back to user. */
-		err = put_compat_cmd(cmd32, cmd);
-		if (err)
-			rc = err;
-	}
-
-	return rc;
-}
-
-/* Handle 32-bit COMEDI_CMDTEST ioctl. */
-static int compat_cmdtest(struct file *file, unsigned long arg)
-{
-	struct comedi_cmd __user *cmd;
-	struct comedi32_cmd_struct __user *cmd32;
-	int rc, err;
-
-	cmd32 = compat_ptr(arg);
-	cmd = compat_alloc_user_space(sizeof(*cmd));
-
-	rc = get_compat_cmd(cmd, cmd32);
-	if (rc)
-		return rc;
-
-	rc = translated_ioctl(file, COMEDI_CMDTEST, (unsigned long)cmd);
-	if (rc < 0)
-		return rc;
-
-	err = put_compat_cmd(cmd32, cmd);
-	if (err)
-		rc = err;
-
-	return rc;
-}
-
-/* Copy 32-bit insn structure to native insn structure. */
-static int get_compat_insn(struct comedi_insn __user *insn,
-			   struct comedi32_insn_struct __user *insn32)
-{
-	int err;
-	union {
-		unsigned int uint;
-		compat_uptr_t uptr;
-	} temp;
-
-	/* Copy insn structure.  Ignore the unused members. */
-	err = 0;
-	if (!access_ok(insn32, sizeof(*insn32)) ||
-	    !access_ok(insn, sizeof(*insn)))
-		return -EFAULT;
-
-	err |= __get_user(temp.uint, &insn32->insn);
-	err |= __put_user(temp.uint, &insn->insn);
-	err |= __get_user(temp.uint, &insn32->n);
-	err |= __put_user(temp.uint, &insn->n);
-	err |= __get_user(temp.uptr, &insn32->data);
-	err |= __put_user(compat_ptr(temp.uptr), &insn->data);
-	err |= __get_user(temp.uint, &insn32->subdev);
-	err |= __put_user(temp.uint, &insn->subdev);
-	err |= __get_user(temp.uint, &insn32->chanspec);
-	err |= __put_user(temp.uint, &insn->chanspec);
-	return err ? -EFAULT : 0;
-}
-
-/* Handle 32-bit COMEDI_INSNLIST ioctl. */
-static int compat_insnlist(struct file *file, unsigned long arg)
-{
-	struct combined_insnlist {
-		struct comedi_insnlist insnlist;
-		struct comedi_insn insn[1];
-	} __user *s;
-	struct comedi32_insnlist_struct __user *insnlist32;
-	struct comedi32_insn_struct __user *insn32;
-	compat_uptr_t uptr;
-	unsigned int n_insns, n;
-	int err, rc;
-
-	insnlist32 = compat_ptr(arg);
-
-	/* Get 32-bit insnlist structure.  */
-	if (!access_ok(insnlist32, sizeof(*insnlist32)))
-		return -EFAULT;
-
-	err = 0;
-	err |= __get_user(n_insns, &insnlist32->n_insns);
-	err |= __get_user(uptr, &insnlist32->insns);
-	insn32 = compat_ptr(uptr);
-	if (err)
-		return -EFAULT;
-
-	/* Allocate user memory to copy insnlist and insns into. */
-	s = compat_alloc_user_space(offsetof(struct combined_insnlist,
-					     insn[n_insns]));
-
-	/* Set native insnlist structure. */
-	if (!access_ok(&s->insnlist, sizeof(s->insnlist)))
-		return -EFAULT;
-
-	err |= __put_user(n_insns, &s->insnlist.n_insns);
-	err |= __put_user(&s->insn[0], &s->insnlist.insns);
-	if (err)
-		return -EFAULT;
-
-	/* Copy insn structures. */
-	for (n = 0; n < n_insns; n++) {
-		rc = get_compat_insn(&s->insn[n], &insn32[n]);
-		if (rc)
-			return rc;
-	}
-
-	return translated_ioctl(file, COMEDI_INSNLIST,
-				(unsigned long)&s->insnlist);
-}
-
-/* Handle 32-bit COMEDI_INSN ioctl. */
-static int compat_insn(struct file *file, unsigned long arg)
-{
-	struct comedi_insn __user *insn;
-	struct comedi32_insn_struct __user *insn32;
-	int rc;
-
-	insn32 = compat_ptr(arg);
-	insn = compat_alloc_user_space(sizeof(*insn));
-
-	rc = get_compat_insn(insn, insn32);
-	if (rc)
-		return rc;
-
-	return translated_ioctl(file, COMEDI_INSN, (unsigned long)insn);
-}
-
-/*
- * compat_ioctl file operation.
- *
- * Returns -ENOIOCTLCMD for unrecognised ioctl codes.
- */
-long comedi_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	int rc;
-
-	switch (cmd) {
-	case COMEDI_DEVCONFIG:
-	case COMEDI_DEVINFO:
-	case COMEDI_SUBDINFO:
-	case COMEDI_BUFCONFIG:
-	case COMEDI_BUFINFO:
-		/* Just need to translate the pointer argument. */
-		arg = (unsigned long)compat_ptr(arg);
-		rc = translated_ioctl(file, cmd, arg);
-		break;
-	case COMEDI_LOCK:
-	case COMEDI_UNLOCK:
-	case COMEDI_CANCEL:
-	case COMEDI_POLL:
-	case COMEDI_SETRSUBD:
-	case COMEDI_SETWSUBD:
-		/* No translation needed. */
-		rc = translated_ioctl(file, cmd, arg);
-		break;
-	case COMEDI32_CHANINFO:
-		rc = compat_chaninfo(file, arg);
-		break;
-	case COMEDI32_RANGEINFO:
-		rc = compat_rangeinfo(file, arg);
-		break;
-	case COMEDI32_CMD:
-		rc = compat_cmd(file, arg);
-		break;
-	case COMEDI32_CMDTEST:
-		rc = compat_cmdtest(file, arg);
-		break;
-	case COMEDI32_INSNLIST:
-		rc = compat_insnlist(file, arg);
-		break;
-	case COMEDI32_INSN:
-		rc = compat_insn(file, arg);
-		break;
-	default:
-		rc = -ENOIOCTLCMD;
-		break;
-	}
-	return rc;
-}
diff --git a/drivers/staging/comedi/comedi_compat32.h b/drivers/staging/comedi/comedi_compat32.h
deleted file mode 100644
index dc3e2a9442c7..000000000000
--- a/drivers/staging/comedi/comedi_compat32.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * comedi/comedi_compat32.h
- * 32-bit ioctl compatibility for 64-bit comedi kernel module.
- *
- * Author: Ian Abbott, MEV Ltd. <abbotti@mev.co.uk>
- * Copyright (C) 2007 MEV Ltd. <http://www.mev.co.uk/>
- *
- * COMEDI - Linux Control and Measurement Device Interface
- * Copyright (C) 1997-2007 David A. Schleef <ds@schleef.org>
- */
-
-#ifndef _COMEDI_COMPAT32_H
-#define _COMEDI_COMPAT32_H
-
-#ifdef CONFIG_COMPAT
-
-struct file;
-long comedi_compat_ioctl(struct file *file, unsigned int cmd,
-			 unsigned long arg);
-
-#else /* CONFIG_COMPAT */
-
-#define comedi_compat_ioctl	NULL
-
-#endif /* CONFIG_COMPAT */
-
-#endif /* _COMEDI_COMPAT32_H */
diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index 08d1bbbebf2d..9dfb81dfe43c 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -4,13 +4,14 @@
  * comedi kernel module
  *
  * COMEDI - Linux Control and Measurement Device Interface
- * Copyright (C) 1997-2000 David A. Schleef <ds@schleef.org>
+ * Copyright (C) 1997-2007 David A. Schleef <ds@schleef.org>
+ * compat ioctls:
+ * Author: Ian Abbott, MEV Ltd. <abbotti@mev.co.uk>
+ * Copyright (C) 2007 MEV Ltd. <http://www.mev.co.uk/>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include "comedi_compat32.h"
-
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -27,6 +28,7 @@
 
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/compat.h>
 
 #include "comedi_internal.h"
 
@@ -2806,6 +2808,449 @@ static int comedi_close(struct inode *inode, struct file *file)
 	return 0;
 }
 
+#ifdef CONFIG_COMPAT
+
+#define COMEDI32_CHANINFO _IOR(CIO, 3, struct comedi32_chaninfo_struct)
+#define COMEDI32_RANGEINFO _IOR(CIO, 8, struct comedi32_rangeinfo_struct)
+/*
+ * N.B. COMEDI32_CMD and COMEDI_CMD ought to use _IOWR, not _IOR.
+ * It's too late to change it now, but it only affects the command number.
+ */
+#define COMEDI32_CMD _IOR(CIO, 9, struct comedi32_cmd_struct)
+/*
+ * N.B. COMEDI32_CMDTEST and COMEDI_CMDTEST ought to use _IOWR, not _IOR.
+ * It's too late to change it now, but it only affects the command number.
+ */
+#define COMEDI32_CMDTEST _IOR(CIO, 10, struct comedi32_cmd_struct)
+#define COMEDI32_INSNLIST _IOR(CIO, 11, struct comedi32_insnlist_struct)
+#define COMEDI32_INSN _IOR(CIO, 12, struct comedi32_insn_struct)
+
+struct comedi32_chaninfo_struct {
+	unsigned int subdev;
+	compat_uptr_t maxdata_list;	/* 32-bit 'unsigned int *' */
+	compat_uptr_t flaglist;	/* 32-bit 'unsigned int *' */
+	compat_uptr_t rangelist;	/* 32-bit 'unsigned int *' */
+	unsigned int unused[4];
+};
+
+struct comedi32_rangeinfo_struct {
+	unsigned int range_type;
+	compat_uptr_t range_ptr;	/* 32-bit 'void *' */
+};
+
+struct comedi32_cmd_struct {
+	unsigned int subdev;
+	unsigned int flags;
+	unsigned int start_src;
+	unsigned int start_arg;
+	unsigned int scan_begin_src;
+	unsigned int scan_begin_arg;
+	unsigned int convert_src;
+	unsigned int convert_arg;
+	unsigned int scan_end_src;
+	unsigned int scan_end_arg;
+	unsigned int stop_src;
+	unsigned int stop_arg;
+	compat_uptr_t chanlist;	/* 32-bit 'unsigned int *' */
+	unsigned int chanlist_len;
+	compat_uptr_t data;	/* 32-bit 'short *' */
+	unsigned int data_len;
+};
+
+struct comedi32_insn_struct {
+	unsigned int insn;
+	unsigned int n;
+	compat_uptr_t data;	/* 32-bit 'unsigned int *' */
+	unsigned int subdev;
+	unsigned int chanspec;
+	unsigned int unused[3];
+};
+
+struct comedi32_insnlist_struct {
+	unsigned int n_insns;
+	compat_uptr_t insns;	/* 32-bit 'struct comedi_insn *' */
+};
+
+/* Handle translated ioctl. */
+static int translated_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	if (file->f_op->unlocked_ioctl)
+		return file->f_op->unlocked_ioctl(file, cmd, arg);
+
+	return -ENOTTY;
+}
+
+/* Handle 32-bit COMEDI_CHANINFO ioctl. */
+static int compat_chaninfo(struct file *file, unsigned long arg)
+{
+	struct comedi_chaninfo __user *chaninfo;
+	struct comedi32_chaninfo_struct __user *chaninfo32;
+	int err;
+	union {
+		unsigned int uint;
+		compat_uptr_t uptr;
+	} temp;
+
+	chaninfo32 = compat_ptr(arg);
+	chaninfo = compat_alloc_user_space(sizeof(*chaninfo));
+
+	/* Copy chaninfo structure.  Ignore unused members. */
+	if (!access_ok(chaninfo32, sizeof(*chaninfo32)) ||
+	    !access_ok(chaninfo, sizeof(*chaninfo)))
+		return -EFAULT;
+
+	err = 0;
+	err |= __get_user(temp.uint, &chaninfo32->subdev);
+	err |= __put_user(temp.uint, &chaninfo->subdev);
+	err |= __get_user(temp.uptr, &chaninfo32->maxdata_list);
+	err |= __put_user(compat_ptr(temp.uptr), &chaninfo->maxdata_list);
+	err |= __get_user(temp.uptr, &chaninfo32->flaglist);
+	err |= __put_user(compat_ptr(temp.uptr), &chaninfo->flaglist);
+	err |= __get_user(temp.uptr, &chaninfo32->rangelist);
+	err |= __put_user(compat_ptr(temp.uptr), &chaninfo->rangelist);
+	if (err)
+		return -EFAULT;
+
+	return translated_ioctl(file, COMEDI_CHANINFO, (unsigned long)chaninfo);
+}
+
+/* Handle 32-bit COMEDI_RANGEINFO ioctl. */
+static int compat_rangeinfo(struct file *file, unsigned long arg)
+{
+	struct comedi_rangeinfo __user *rangeinfo;
+	struct comedi32_rangeinfo_struct __user *rangeinfo32;
+	int err;
+	union {
+		unsigned int uint;
+		compat_uptr_t uptr;
+	} temp;
+
+	rangeinfo32 = compat_ptr(arg);
+	rangeinfo = compat_alloc_user_space(sizeof(*rangeinfo));
+
+	/* Copy rangeinfo structure. */
+	if (!access_ok(rangeinfo32, sizeof(*rangeinfo32)) ||
+	    !access_ok(rangeinfo, sizeof(*rangeinfo)))
+		return -EFAULT;
+
+	err = 0;
+	err |= __get_user(temp.uint, &rangeinfo32->range_type);
+	err |= __put_user(temp.uint, &rangeinfo->range_type);
+	err |= __get_user(temp.uptr, &rangeinfo32->range_ptr);
+	err |= __put_user(compat_ptr(temp.uptr), &rangeinfo->range_ptr);
+	if (err)
+		return -EFAULT;
+
+	return translated_ioctl(file, COMEDI_RANGEINFO,
+				(unsigned long)rangeinfo);
+}
+
+/* Copy 32-bit cmd structure to native cmd structure. */
+static int get_compat_cmd(struct comedi_cmd __user *cmd,
+			  struct comedi32_cmd_struct __user *cmd32)
+{
+	int err;
+	union {
+		unsigned int uint;
+		compat_uptr_t uptr;
+	} temp;
+
+	/* Copy cmd structure. */
+	if (!access_ok(cmd32, sizeof(*cmd32)) ||
+	    !access_ok(cmd, sizeof(*cmd)))
+		return -EFAULT;
+
+	err = 0;
+	err |= __get_user(temp.uint, &cmd32->subdev);
+	err |= __put_user(temp.uint, &cmd->subdev);
+	err |= __get_user(temp.uint, &cmd32->flags);
+	err |= __put_user(temp.uint, &cmd->flags);
+	err |= __get_user(temp.uint, &cmd32->start_src);
+	err |= __put_user(temp.uint, &cmd->start_src);
+	err |= __get_user(temp.uint, &cmd32->start_arg);
+	err |= __put_user(temp.uint, &cmd->start_arg);
+	err |= __get_user(temp.uint, &cmd32->scan_begin_src);
+	err |= __put_user(temp.uint, &cmd->scan_begin_src);
+	err |= __get_user(temp.uint, &cmd32->scan_begin_arg);
+	err |= __put_user(temp.uint, &cmd->scan_begin_arg);
+	err |= __get_user(temp.uint, &cmd32->convert_src);
+	err |= __put_user(temp.uint, &cmd->convert_src);
+	err |= __get_user(temp.uint, &cmd32->convert_arg);
+	err |= __put_user(temp.uint, &cmd->convert_arg);
+	err |= __get_user(temp.uint, &cmd32->scan_end_src);
+	err |= __put_user(temp.uint, &cmd->scan_end_src);
+	err |= __get_user(temp.uint, &cmd32->scan_end_arg);
+	err |= __put_user(temp.uint, &cmd->scan_end_arg);
+	err |= __get_user(temp.uint, &cmd32->stop_src);
+	err |= __put_user(temp.uint, &cmd->stop_src);
+	err |= __get_user(temp.uint, &cmd32->stop_arg);
+	err |= __put_user(temp.uint, &cmd->stop_arg);
+	err |= __get_user(temp.uptr, &cmd32->chanlist);
+	err |= __put_user((unsigned int __force *)compat_ptr(temp.uptr),
+			  &cmd->chanlist);
+	err |= __get_user(temp.uint, &cmd32->chanlist_len);
+	err |= __put_user(temp.uint, &cmd->chanlist_len);
+	err |= __get_user(temp.uptr, &cmd32->data);
+	err |= __put_user(compat_ptr(temp.uptr), &cmd->data);
+	err |= __get_user(temp.uint, &cmd32->data_len);
+	err |= __put_user(temp.uint, &cmd->data_len);
+	return err ? -EFAULT : 0;
+}
+
+/* Copy native cmd structure to 32-bit cmd structure. */
+static int put_compat_cmd(struct comedi32_cmd_struct __user *cmd32,
+			  struct comedi_cmd __user *cmd)
+{
+	int err;
+	unsigned int temp;
+
+	/*
+	 * Copy back most of cmd structure.
+	 *
+	 * Assume the pointer values are already valid.
+	 * (Could use ptr_to_compat() to set them.)
+	 */
+	if (!access_ok(cmd, sizeof(*cmd)) ||
+	    !access_ok(cmd32, sizeof(*cmd32)))
+		return -EFAULT;
+
+	err = 0;
+	err |= __get_user(temp, &cmd->subdev);
+	err |= __put_user(temp, &cmd32->subdev);
+	err |= __get_user(temp, &cmd->flags);
+	err |= __put_user(temp, &cmd32->flags);
+	err |= __get_user(temp, &cmd->start_src);
+	err |= __put_user(temp, &cmd32->start_src);
+	err |= __get_user(temp, &cmd->start_arg);
+	err |= __put_user(temp, &cmd32->start_arg);
+	err |= __get_user(temp, &cmd->scan_begin_src);
+	err |= __put_user(temp, &cmd32->scan_begin_src);
+	err |= __get_user(temp, &cmd->scan_begin_arg);
+	err |= __put_user(temp, &cmd32->scan_begin_arg);
+	err |= __get_user(temp, &cmd->convert_src);
+	err |= __put_user(temp, &cmd32->convert_src);
+	err |= __get_user(temp, &cmd->convert_arg);
+	err |= __put_user(temp, &cmd32->convert_arg);
+	err |= __get_user(temp, &cmd->scan_end_src);
+	err |= __put_user(temp, &cmd32->scan_end_src);
+	err |= __get_user(temp, &cmd->scan_end_arg);
+	err |= __put_user(temp, &cmd32->scan_end_arg);
+	err |= __get_user(temp, &cmd->stop_src);
+	err |= __put_user(temp, &cmd32->stop_src);
+	err |= __get_user(temp, &cmd->stop_arg);
+	err |= __put_user(temp, &cmd32->stop_arg);
+	/* Assume chanlist pointer is unchanged. */
+	err |= __get_user(temp, &cmd->chanlist_len);
+	err |= __put_user(temp, &cmd32->chanlist_len);
+	/* Assume data pointer is unchanged. */
+	err |= __get_user(temp, &cmd->data_len);
+	err |= __put_user(temp, &cmd32->data_len);
+	return err ? -EFAULT : 0;
+}
+
+/* Handle 32-bit COMEDI_CMD ioctl. */
+static int compat_cmd(struct file *file, unsigned long arg)
+{
+	struct comedi_cmd __user *cmd;
+	struct comedi32_cmd_struct __user *cmd32;
+	int rc, err;
+
+	cmd32 = compat_ptr(arg);
+	cmd = compat_alloc_user_space(sizeof(*cmd));
+
+	rc = get_compat_cmd(cmd, cmd32);
+	if (rc)
+		return rc;
+
+	rc = translated_ioctl(file, COMEDI_CMD, (unsigned long)cmd);
+	if (rc == -EAGAIN) {
+		/* Special case: copy cmd back to user. */
+		err = put_compat_cmd(cmd32, cmd);
+		if (err)
+			rc = err;
+	}
+
+	return rc;
+}
+
+/* Handle 32-bit COMEDI_CMDTEST ioctl. */
+static int compat_cmdtest(struct file *file, unsigned long arg)
+{
+	struct comedi_cmd __user *cmd;
+	struct comedi32_cmd_struct __user *cmd32;
+	int rc, err;
+
+	cmd32 = compat_ptr(arg);
+	cmd = compat_alloc_user_space(sizeof(*cmd));
+
+	rc = get_compat_cmd(cmd, cmd32);
+	if (rc)
+		return rc;
+
+	rc = translated_ioctl(file, COMEDI_CMDTEST, (unsigned long)cmd);
+	if (rc < 0)
+		return rc;
+
+	err = put_compat_cmd(cmd32, cmd);
+	if (err)
+		rc = err;
+
+	return rc;
+}
+
+/* Copy 32-bit insn structure to native insn structure. */
+static int get_compat_insn(struct comedi_insn __user *insn,
+			   struct comedi32_insn_struct __user *insn32)
+{
+	int err;
+	union {
+		unsigned int uint;
+		compat_uptr_t uptr;
+	} temp;
+
+	/* Copy insn structure.  Ignore the unused members. */
+	err = 0;
+	if (!access_ok(insn32, sizeof(*insn32)) ||
+	    !access_ok(insn, sizeof(*insn)))
+		return -EFAULT;
+
+	err |= __get_user(temp.uint, &insn32->insn);
+	err |= __put_user(temp.uint, &insn->insn);
+	err |= __get_user(temp.uint, &insn32->n);
+	err |= __put_user(temp.uint, &insn->n);
+	err |= __get_user(temp.uptr, &insn32->data);
+	err |= __put_user(compat_ptr(temp.uptr), &insn->data);
+	err |= __get_user(temp.uint, &insn32->subdev);
+	err |= __put_user(temp.uint, &insn->subdev);
+	err |= __get_user(temp.uint, &insn32->chanspec);
+	err |= __put_user(temp.uint, &insn->chanspec);
+	return err ? -EFAULT : 0;
+}
+
+/* Handle 32-bit COMEDI_INSNLIST ioctl. */
+static int compat_insnlist(struct file *file, unsigned long arg)
+{
+	struct combined_insnlist {
+		struct comedi_insnlist insnlist;
+		struct comedi_insn insn[1];
+	} __user *s;
+	struct comedi32_insnlist_struct __user *insnlist32;
+	struct comedi32_insn_struct __user *insn32;
+	compat_uptr_t uptr;
+	unsigned int n_insns, n;
+	int err, rc;
+
+	insnlist32 = compat_ptr(arg);
+
+	/* Get 32-bit insnlist structure.  */
+	if (!access_ok(insnlist32, sizeof(*insnlist32)))
+		return -EFAULT;
+
+	err = 0;
+	err |= __get_user(n_insns, &insnlist32->n_insns);
+	err |= __get_user(uptr, &insnlist32->insns);
+	insn32 = compat_ptr(uptr);
+	if (err)
+		return -EFAULT;
+
+	/* Allocate user memory to copy insnlist and insns into. */
+	s = compat_alloc_user_space(offsetof(struct combined_insnlist,
+					     insn[n_insns]));
+
+	/* Set native insnlist structure. */
+	if (!access_ok(&s->insnlist, sizeof(s->insnlist)))
+		return -EFAULT;
+
+	err |= __put_user(n_insns, &s->insnlist.n_insns);
+	err |= __put_user(&s->insn[0], &s->insnlist.insns);
+	if (err)
+		return -EFAULT;
+
+	/* Copy insn structures. */
+	for (n = 0; n < n_insns; n++) {
+		rc = get_compat_insn(&s->insn[n], &insn32[n]);
+		if (rc)
+			return rc;
+	}
+
+	return translated_ioctl(file, COMEDI_INSNLIST,
+				(unsigned long)&s->insnlist);
+}
+
+/* Handle 32-bit COMEDI_INSN ioctl. */
+static int compat_insn(struct file *file, unsigned long arg)
+{
+	struct comedi_insn __user *insn;
+	struct comedi32_insn_struct __user *insn32;
+	int rc;
+
+	insn32 = compat_ptr(arg);
+	insn = compat_alloc_user_space(sizeof(*insn));
+
+	rc = get_compat_insn(insn, insn32);
+	if (rc)
+		return rc;
+
+	return translated_ioctl(file, COMEDI_INSN, (unsigned long)insn);
+}
+
+/*
+ * compat_ioctl file operation.
+ *
+ * Returns -ENOIOCTLCMD for unrecognised ioctl codes.
+ */
+static long comedi_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int rc;
+
+	switch (cmd) {
+	case COMEDI_DEVCONFIG:
+	case COMEDI_DEVINFO:
+	case COMEDI_SUBDINFO:
+	case COMEDI_BUFCONFIG:
+	case COMEDI_BUFINFO:
+		/* Just need to translate the pointer argument. */
+		arg = (unsigned long)compat_ptr(arg);
+		rc = translated_ioctl(file, cmd, arg);
+		break;
+	case COMEDI_LOCK:
+	case COMEDI_UNLOCK:
+	case COMEDI_CANCEL:
+	case COMEDI_POLL:
+	case COMEDI_SETRSUBD:
+	case COMEDI_SETWSUBD:
+		/* No translation needed. */
+		rc = translated_ioctl(file, cmd, arg);
+		break;
+	case COMEDI32_CHANINFO:
+		rc = compat_chaninfo(file, arg);
+		break;
+	case COMEDI32_RANGEINFO:
+		rc = compat_rangeinfo(file, arg);
+		break;
+	case COMEDI32_CMD:
+		rc = compat_cmd(file, arg);
+		break;
+	case COMEDI32_CMDTEST:
+		rc = compat_cmdtest(file, arg);
+		break;
+	case COMEDI32_INSNLIST:
+		rc = compat_insnlist(file, arg);
+		break;
+	case COMEDI32_INSN:
+		rc = compat_insn(file, arg);
+		break;
+	default:
+		rc = -ENOIOCTLCMD;
+		break;
+	}
+	return rc;
+}
+#else
+#define comedi_compat_ioctl NULL
+#endif
+
 static const struct file_operations comedi_fops = {
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = comedi_unlocked_ioctl,
-- 
2.11.0

