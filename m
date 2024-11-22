Return-Path: <linux-fsdevel+bounces-35562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6F69D5DEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41E51F23B21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 11:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC731DE4FB;
	Fri, 22 Nov 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoRAD0CM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29025142E83;
	Fri, 22 Nov 2024 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732274325; cv=none; b=d0e5py9f0A12eJHRQREcD5lB+wWJkLVJZDCkAn7C/ze4z59MJn9k/kOxkMUw3jvdTPIYxn8lkd2ng2jgP1lUy/f5/ItDRY30dvzG7bQkUJ419I1gI8PCb2NdBT9fk1t7sHr8fvxrrVQMj/+pB4uqEqMm1WGgrWOvgSvvb9HxaV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732274325; c=relaxed/simple;
	bh=/fKxJSUOP+Zb4ztb2hVxxM3ytaUxDd3fvJRkm2EaDTM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=FSqIn0bRiye06PbgCYuMkZ5p+qGwuZVsx3UYy4cP9Z20zxS8gwL4dxUDp1S2MdD9c7Q+8Led7ywpD0ONK2ajF/NMYBOa5VrCvoCtRZLHdhJT4bQpN5fJgdo9XRbqnwDLbJaykYzn4zYffRzDvzKg0WcjTH+OTtrsoHFVa3ZjQXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoRAD0CM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3807e72c468so195436f8f.3;
        Fri, 22 Nov 2024 03:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732274322; x=1732879122; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:content-language
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0BC5siRWyi3JlY6lsL0F4LUp8ht8za020rXeAp4qrIQ=;
        b=AoRAD0CMLS49JvE8+H0a0IPe9DUj8bwTMxppwJnjRzMAxB7ad/iapVRBhzjsXA8rSR
         N03l85hfvwiOyT1J1XLieYKtYvAFI23YVAFO4aqRdaB7o2Zi38Iz29wPxZKi669PpExm
         XWsYMgNsdVPXoscK5OkZUm9R4eZAMS6ubbLggQnNfouIZADnc0ZhhcAC/f5i2pa4i5nY
         PaG/5IdRD3jl3GswG33Nr0jta6OCg8imQR1XU6vYTuBV1VN8LUIDv2w2fxKDFhmr15Wj
         EmnrrU34B2G9txnAIdsyiSn9gTPjeW0G3PI6c4uIIlN8XJ4vnI5N8bHNEN1QMHZr1l0v
         pjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732274322; x=1732879122;
        h=content-transfer-encoding:to:subject:from:content-language
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0BC5siRWyi3JlY6lsL0F4LUp8ht8za020rXeAp4qrIQ=;
        b=NO9DxC/4aQL7CTHwBIsSMDGA/qXlAMhYaUHuzg0xWDES8ZMOCP2N5fmc7vIUOxaH4M
         KljI1vaVlGuDHZXOs8/FyyHct2gG5u7r+Ujxx4f1jbEHZaLcdKnWlJR8UFumcp2/N4I7
         vSgcrq+rk5pc+hqFXMJfolRSnYZf7Vi3ySzTFBl9KhasW3OrQn7LIBbnFwq+6GhIY9XH
         7IW4HxyytlUvRiWksm3+52uokbXBIUhPCcz8EKllro1n4z8d0FA98E1fY9S+9OLzE/cI
         O/+0zWg0aeh1q9IetfL1dbSFKw7yyoxIinnY4gqEfYxdeeNQuRf3Zg0rjbCrHwQ9WGWo
         HLZw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Ye00uctNCBgXvurg7qdAQpjEPqA9bHOmEzN1Cc6PZeXEnz9otWiHdkeAg5itdv4yniNptBDUQnZZlGDqzjM=@vger.kernel.org, AJvYcCXG33elRKXULUJUYDHIx7VAMUxP7b4nSlJQmzyPnlyD1yUNRZiDtnhGIFKQceUUSfhsJde30oISYSVbtjji@vger.kernel.org
X-Gm-Message-State: AOJu0YzQR4y5EknZHWGSPBs4CLizOU25IR7wCK7KryCsd58RoQf8Furx
	13IU3Ge1QE3XDiu3TDLGpo4d/pyLCBl2j3CY0HvyyVuQyN5FxFObS30VYGk=
X-Gm-Gg: ASbGncsmLyFJxVoTY2RCBjxVMA/1/X0D969m+U9Q4t1qk4l4EfrS+vhe3K5+pKX+rl6
	cwhOvm5NFAwBMASF5ytzIsWnK5OB384oOR/75Dtv2BRZgGsl2SO6Mhzcmw9yiiMI6MqXOmfIYXR
	lYHmosXLRj4kSRhTt68WzhtKCFeHiVhk0UeQwT3TVcDU9XGODoZUuOzVmD1sHM+D4Zkf51vmsBE
	q7Ljmj2XoRJFWpmP08xhxGRpzqahJkNL1slSPvLNH2Lnk+Op0O7QlpcBzNjG6DbDkyKDdYH0OBh
	jBLsFEE3KWIsGlolFg==
X-Google-Smtp-Source: AGHT+IEihv/rLuDEibkXzI4PwKpylOIJi1rGlO6aQT+qxuE8tcevTsY7AcKepxtOPL+DpMS5g/B1Ow==
X-Received: by 2002:a5d:59af:0:b0:382:5066:3257 with SMTP id ffacd0b85a97d-38260b59c40mr874365f8f.4.1732274322154;
        Fri, 22 Nov 2024 03:18:42 -0800 (PST)
Received: from localhost (145.red-81-44-150.dynamicip.rima-tde.net. [81.44.150.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3defsm2170288f8f.70.2024.11.22.03.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 03:18:41 -0800 (PST)
Message-ID: <4b454953-eafa-4bb4-824d-6012f7924d5c@gmail.com>
Date: Fri, 22 Nov 2024 12:18:40 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US, en-GB, es-ES
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
Subject: Re: GIT PULL] Remove reiserfs
To: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 reiserfs-devel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Still traces in the tree:

$ git grep -iE "reiserfs|reiser4|reiser2"
Documentation/admin-guide/ext4.rst:  a similar level of journaling as that of XFS, JFS, and ReiserFS in its default
Documentation/admin-guide/laptops/laptop-mode.rst:* If you mount some of your ext3/reiserfs filesystems with the -n option, then
Documentation/admin-guide/laptops/laptop-mode.rst:ext3 or ReiserFS filesystems (also done automatically by the control script),
Documentation/admin-guide/laptops/laptop-mode.rst:                                      "ext3"|"reiserfs")
Documentation/admin-guide/laptops/laptop-mode.rst:                                      "ext3"|"reiserfs")
Documentation/arch/powerpc/eeh-pci-error-recovery.rst:   Reiserfs does not tolerate errors returned from the block device.
Documentation/process/3.Early-stage.rst: - The Reiser4 filesystem included a number of capabilities which, in the
Documentation/process/3.Early-stage.rst:   address some of them - has caused Reiser4 to stay out of the mainline
Documentation/process/changes.rst:reiserfsprogs          3.6.3            reiserfsck -V
Documentation/process/changes.rst:Reiserfsprogs
Documentation/process/changes.rst:The reiserfsprogs package should be used for reiserfs-3.6.x
Documentation/process/changes.rst:versions of ``mkreiserfs``, ``resize_reiserfs``, ``debugreiserfs`` and
Documentation/process/changes.rst:``reiserfsck``. These utils work on both i386 and alpha platforms.
Documentation/process/changes.rst:Reiserfsprogs
Documentation/process/changes.rst:- <https://git.kernel.org/pub/scm/linux/kernel/git/jeffm/reiserfsprogs.git/>
Documentation/trace/ftrace.rst:    360.774528 |   1)               |                                  reiserfs_prepare_for_journal() {
Documentation/translations/it_IT/process/3.Early-stage.rst: - Il filesystem Reiser4 include una seria di funzionalità che, secondo
Documentation/translations/it_IT/process/changes.rst:reiserfsprogs          3.6.3              reiserfsck -V
Documentation/translations/it_IT/process/changes.rst:Reiserfsprogs
Documentation/translations/it_IT/process/changes.rst:Il pacchetto reiserfsprogs dovrebbe essere usato con reiserfs-3.6.x (Linux
Documentation/translations/it_IT/process/changes.rst:funzionanti di ``mkreiserfs``, ``resize_reiserfs``, ``debugreiserfs`` e
Documentation/translations/it_IT/process/changes.rst:``reiserfsck``.  Questi programmi funzionano sulle piattaforme i386 e alpha.
Documentation/translations/it_IT/process/changes.rst:Reiserfsprogs
Documentation/translations/it_IT/process/changes.rst:- <https://git.kernel.org/pub/scm/linux/kernel/git/jeffm/reiserfsprogs.git/>
Documentation/translations/zh_CN/process/3.Early-stage.rst: - Reiser4文件系统包含许多功能，核心内核开发人员认为这些功能应该在虚拟文件
Documentation/translations/zh_CN/process/3.Early-stage.rst:   导致Reiser4置身主线内核之外。
Documentation/translations/zh_TW/process/3.Early-stage.rst: - Reiser4文件系統包含許多功能，核心內核開發人員認爲這些功能應該在虛擬文件
Documentation/translations/zh_TW/process/3.Early-stage.rst:   導致Reiser4置身主線內核之外。
Documentation/userspace-api/ioctl/ioctl-number.rst:0xCD  01     linux/reiserfs_fs.h                                     Dead since 6.13
fs/btrfs/tree-log.c: * ext3/4, xfs, f2fs, reiserfs, nilfs2). Note that when logging the inodes
fs/ubifs/key.h: * node. We use "r5" hash borrowed from reiserfs.
fs/ubifs/key.h: * key_r5_hash - R5 hash function (borrowed from reiserfs).
include/linux/stringhash.h:/* Hash courtesy of the R5 hash in reiserfs modulo sign bits */
include/uapi/linux/magic.h:#define REISERFS_SUPER_MAGIC 0x52654973      /* used by gcc */
include/uapi/linux/magic.h:#define REISERFS_SUPER_MAGIC_STRING  "ReIsErFs"
include/uapi/linux/magic.h:#define REISER2FS_SUPER_MAGIC_STRING "ReIsEr2Fs"
include/uapi/linux/magic.h:#define REISER2FS_JR_SUPER_MAGIC_STRING      "ReIsEr3Fs"
scripts/selinux/install_policy.sh:      grep -E "ext[234]|jfs|xfs|reiserfs|jffs2|gfs2|btrfs|f2fs|ocfs2" | \
scripts/ver_linux:      printversion("Reiserfsprogs", version("reiserfsck -V"))
scripts/ver_linux:      printversion("Reiser4fsprogs", version("fsck.reiser4 -V"))

