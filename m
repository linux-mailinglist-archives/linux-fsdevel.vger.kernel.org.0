Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC4A5C5C1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2019 00:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfGAWoc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 18:44:32 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35740 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726341AbfGAWoc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 18:44:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 36CE98EE0E3;
        Mon,  1 Jul 2019 15:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562021072;
        bh=m0tNNukF7xF3egFzci432mYmOW/txTHRHkDLaD3r0gI=;
        h=Subject:From:To:Cc:Date:From;
        b=eEISfa5LQLXOvG/SkdKV8GqMYVDg089+LHRoPt6gSY58WROr08Ldy+H+/gcksv3nZ
         oNdVjQq5d4PpYU0Y3gTaoHUCPB+iWOHbN7oHQGodV7ckv321IRgL5vbE74F4D3EOYl
         n+gx45e2HRCThUZw4joEq0yG5zpIk1+z31pPft4g=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cl_bLoQOAoej; Mon,  1 Jul 2019 15:44:32 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B583C8EE0E0;
        Mon,  1 Jul 2019 15:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562021071;
        bh=m0tNNukF7xF3egFzci432mYmOW/txTHRHkDLaD3r0gI=;
        h=Subject:From:To:Cc:Date:From;
        b=jsX6GdVXxECfcsXbXJMNy0nT+o4FuyJdpvwVdu2IhWxU/0psLUo+4BYvEG9cXXGNV
         ssQu01I7rxO8KGLpOOEgjcpkaFDBY26SSRpPojpaMsJuliaNLL52KBLz0FsHHbp5Wg
         i8Y5JvONLVeitVymW91F7DYazx1BUOoWCIJwKjiA=
Message-ID: <1562021070.2762.36.camel@HansenPartnership.com>
Subject: [BUG] mke2fs produces corrupt filesystem if badblock list contains
 a block under 251
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Parisc List <linux-parisc@vger.kernel.org>
Date:   Mon, 01 Jul 2019 15:44:30 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Background: we actually use the badblocks feature of the ext filesystem
group to do a poorman's boot filesystem for parisc: Our system chunks
up the disk searching for an Initial Program Loader (IPL) signature and
then executes it, so we poke a hole in an ext3 filesystem at creation
time and place the IPL into it.  Our IP can read ext3 files and
directories, so it allows us to load the kernel directly from the file.

The problem is that our IPL needs to be aligned at 256k in absolute
terms on the disk, so, in the usual situation of having a 64k partition
label and the boot partition being the first one we usually end up
poking the badblock hole beginning at block 224 (using a 1k block
size).

The problem is that this used to work long ago (where the value of long
seems to be some time before 2011) but no longer does.  The problem can
be illustrated simply by doing

---
# dd if=/dev/zero of=bbtest.img bs=1M count=100
# losetup /dev/loop0 bbtest.img
# a=237; while [ $a -le 450 ]; do echo $a >> bblist.txt; a=$[$a+1]; done
# mke2fs -b 1024 -l /home/jejb/bblist.txt  /dev/loop0
---

Now if you try to do an e2fsck on the partition you'll get this

---
# e2fsck  -f /dev/loop0
e2fsck 1.45.2 (27-May-2019)
Pass 1: Checking inodes, blocks, and sizes
Programming error?  block #237 claimed for no reason in process_bad_block.
Programming error?  block #238 claimed for no reason in process_bad_block.
Programming error?  block #239 claimed for no reason in process_bad_block.
Programming error?  block #240 claimed for no reason in process_bad_block.
Programming error?  block #241 claimed for no reason in process_bad_block.
Programming error?  block #242 claimed for no reason in process_bad_block.
Programming error?  block #243 claimed for no reason in process_bad_block.
Programming error?  block #244 claimed for no reason in process_bad_block.
Programming error?  block #245 claimed for no reason in process_bad_block.
Programming error?  block #246 claimed for no reason in process_bad_block.
Programming error?  block #247 claimed for no reason in process_bad_block.
Programming error?  block #248 claimed for no reason in process_bad_block.
Programming error?  block #249 claimed for no reason in process_bad_block.
Programming error?  block #250 claimed for no reason in process_bad_block.
Programming error?  block #251 claimed for no reason in process_bad_block.
Programming error?  block #252 claimed for no reason in process_bad_block.
Programming error?  block #253 claimed for no reason in process_bad_block.
Programming error?  block #254 claimed for no reason in process_bad_block.
Programming error?  block #255 claimed for no reason in process_bad_block.
Programming error?  block #256 claimed for no reason in process_bad_block.
Programming error?  block #257 claimed for no reason in process_bad_block.
Programming error?  block #258 claimed for no reason in process_bad_block.
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Free blocks count wrong for group #0 (7556, counted=7578).
Fix<y>? 
---

So mke2fs has created an ab-inito corrupt filesystem.  Empirically,
this only seems to happen if there is a block in the bad block list
under 251, but I haven't verified this extensively.

James

