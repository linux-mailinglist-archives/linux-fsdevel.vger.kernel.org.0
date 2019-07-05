Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3059B60C0C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 22:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfGEUHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 16:07:15 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59652 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725884AbfGEUHO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:07:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 938FA8EE1F7;
        Fri,  5 Jul 2019 13:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562357234;
        bh=OBIIiomNCsO92MOnn0j+HDJBu3oOCAUo34RxRZP8VxQ=;
        h=Subject:From:To:Date:From;
        b=Ify4ZdA14JSPLJ2wCMfHW6vWJgCGPoouCpcmg44h2mwIjZju4bbRl6USAzHgg0LHi
         LJFjafrt77eae1MS53r7W8YzrnVgKP9hbDGumwpNoplWZDru93pRqo6TfjmUqmzuNl
         oE5TMNmJzQIgBJ/Q6WtpBbWAYCufW/vDxjzbUYnU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VuvkfAKMvSM9; Fri,  5 Jul 2019 13:07:14 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0FA958EE0CF;
        Fri,  5 Jul 2019 13:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562357234;
        bh=OBIIiomNCsO92MOnn0j+HDJBu3oOCAUo34RxRZP8VxQ=;
        h=Subject:From:To:Date:From;
        b=Ify4ZdA14JSPLJ2wCMfHW6vWJgCGPoouCpcmg44h2mwIjZju4bbRl6USAzHgg0LHi
         LJFjafrt77eae1MS53r7W8YzrnVgKP9hbDGumwpNoplWZDru93pRqo6TfjmUqmzuNl
         oE5TMNmJzQIgBJ/Q6WtpBbWAYCufW/vDxjzbUYnU=
Message-ID: <1562357231.10899.5.camel@HansenPartnership.com>
Subject: [PATCH 0/4] bring parisc linux into the modern age by adding ext4
 support to the bootloader
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>
Date:   Fri, 05 Jul 2019 13:07:11 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The parisc bootloader, palo, has understood how to read ext2/3
filesystems for decades.  However, keeping an ext2/3 partition around
simply to boot from is becoming a bit old, so add support for ext4 to
the iplboot code.  Note, this still doesn't fix ipl specific
limitations, like the inability to read a disk beyond 2GB, so you will
still need a low sector /boot partition for this.

The assumptions I've made adding ext4 are that the only additional
variables over ext2/3 are the variable group descriptor size support,
conditioned on the EXT4_FEATURE_INCOMPAT_64BIT flag and extent based
inodes conditioned on the EXT3_EXTENTS_FL (it's been renamed to
EXT4_EXTENTS_FL now in libext2fs).

Filesystem people interested in reviewing the extent handling code
probably only need look at patch 3/4 iplboot: add ext4 support

James

---

James Bottomley (4):
  iplboot: eliminate unused struct bootfs
  iplboot: update the ext2_fs.h header
  iplboot: add ext4 support
  palo: add support for formatting as ext4

 ipl/bootloader.h |  13 ---
 ipl/ext2.c       | 256 +++++++++++++++++++++++++++++++++++++++++++------------
 ipl/ext2_fs.h    |  42 ++++++++-
 iplboot          | Bin 45056 -> 45056 bytes
 palo/palo.c      |   6 +-
 5 files changed, 245 insertions(+), 72 deletions(-)

-- 
2.16.4

