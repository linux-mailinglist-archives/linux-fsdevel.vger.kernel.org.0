Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1801B3C97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 16:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388661AbfIPOdH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 10:33:07 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:43165 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727934AbfIPOdH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:33:07 -0400
Received: by mail-lj1-f181.google.com with SMTP id d5so116709lja.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2019 07:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=CBA02vsKz3X4vPhHfot7VoCaRBHle23OIMDmGoJFyFU=;
        b=pplGOA8so8eGCdQAqfORSyxuzrMHamhwyhCR3XRnRlwNE+d6WoWhuzLqu/igMmXatX
         Gdp/C1s4135ew1RthGHDFJibIR4jwvsuVEPkvuojdnwnfQtWABpEVdBWGEqNJoHJtSGO
         AiFNB0X3xTzDRZ27jM3irsQe5vYUvsxwWdInkP+fAq2sR+JkcyQ3rfsEWmc1encJIUrh
         +caaDELUkQHxuUS6Cg+8H/gnaG/WJEuwMEI3KvsQED2maw3xnxfry8mx4l+OfN4LzQpd
         azJH4SxY8NW1WDsA2Q5JDV1G/4Jpq6DDSrSy8F124fETuHixkpWcrg8lp4rqz2PSWigb
         AUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CBA02vsKz3X4vPhHfot7VoCaRBHle23OIMDmGoJFyFU=;
        b=SEAYa7hjEvIYhGhFGfaGSrdAJ9jty1KNtfOinJ0C2tTBxyTndWkqkS9DlntwpRKg3B
         5FD8EVqWzLWtCgd+Om6ZqGANRyzZ/peKim/iZYTJKO1fxGRqq54hs5rMoUo1eMcKJhej
         mRwNDtUVOovmR8bK7AHXydOqNlLy+QcMFsJu12R1+bj373iVuWAyuKgh6GLv/kjrOmsE
         5Nj1N8c0/mvACOrlSsSFv6oYqbYWJv6KjHsamIZ6WITj0F7mRBVy8izaQdMaItPJCEPr
         Z+x2w1UKLQSVQCZZZelokGiBt+gqyDRYW/hvqnZKM6NcV5njqmY/fxhAyzt6Xw4epIMv
         B28g==
X-Gm-Message-State: APjAAAUMWSlXGcUu8D3s/FeY7k+RghOrirBn/7uOoL9CbAEdrMkPfuCj
        ED2jYqhk10eRTcKGrAYM6fnAGhlarSURBfzmxfLxZA==
X-Google-Smtp-Source: APXvYqwdFbLlpXJvdT0XGCSCI1fgVhZfMyOmuGgO1meJ19XDA3TiBG8Lrire62D6nNhp5IY7aakEhW3uNovSPpUlMSY=
X-Received: by 2002:a2e:9e57:: with SMTP id g23mr23014397ljk.89.1568644383422;
 Mon, 16 Sep 2019 07:33:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:e00f:0:0:0:0:0 with HTTP; Mon, 16 Sep 2019 07:33:02
 -0700 (PDT)
From:   Daegyu Han <hdg9400@gmail.com>
Date:   Mon, 16 Sep 2019 23:33:02 +0900
Message-ID: <CAARcW+r3EvFktaw-PfxN_V-EjtU6BvT7wxNvUtFiwHOdbNn2iA@mail.gmail.com>
Subject: Sharing ext4 on target storage to multiple initiators using NVMeoF
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi linux file system experts,

I want to share ext4 on the storage server to multiple initiators(node
A,B) using NVMeoF.
Node A will write file to ext4 on the storage server, and I will mount
read-only option on Node B.

Actually, the reason I do this is for a prototype test.

I can't see the file's dentry and inode written in Node A on Node B
unless remount(umount and then mount) it.

Why is that?

I think if there is file system cache(dentry, inode) on Node B, then
disk IO will occur to read the data written by Node A.

Curiously, drop cache on Node B and do blockdev --flushbufs, then I
can access the file written by Node A.

I checked the kernel code and found that flushbufs incurs
sync_filesystem() which flushes the superblock and all dirty file
system caches.

Should the superblock data structure be flushed (updated) when
accessing the disk inode?

I wonder why this happens.

Regards,
