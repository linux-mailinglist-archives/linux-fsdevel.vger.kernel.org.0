Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7436A22C06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 08:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfETGZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 02:25:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36677 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbfETGZ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 02:25:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id d21so6224719plr.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 May 2019 23:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=63xHHZG4cCJKLX16xEPSfZS7UyrdZwd6ga9JsMxKYuA=;
        b=Px5FqM/mS1qyALv+qJhcikuGpTx7I75PqW5boA29rD51XQx76h2wTajAGDbEZbxspY
         bxlnJQW5+dQICDbCxrvtk6px/wRRXsisMheeia/L8MThczsPUsR/lTbwznXHMmrYdHdd
         Yy4Qt5CfjIehQFSi50fwMq7vUMfAShTqOv0ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=63xHHZG4cCJKLX16xEPSfZS7UyrdZwd6ga9JsMxKYuA=;
        b=YeJxYH/SPhTby2IAr7jUYnCHzkG83iu1vr0UG9U0Pf9uF+dVFerPyYCSLw67rpV/Kf
         As6MKetFhmIOcLn4JcRdFxxqI31L50B+sFURsp9Z0n6daQ8jq9eCDfYcNMOed03+gCa5
         PddvgcPL5vYxVrmUcZN7m3JJAMecF7JrO6WXOeVw8c8XnXBlUOz4D6W+Xufgw/1KMkih
         902qvSrKJxdrUDwBo+AkmJZ5Qs57+ASj91pSXonLCqvUD+s5HiZTkdR8BL8C+sz8SWt/
         DWu3nauuXa682eV9lu6OwFcFD7drzUN2qWRKS9vG4GKQLhzMqh5Lbsvd72LqB+T6Tf7q
         cI1Q==
X-Gm-Message-State: APjAAAWnhdA0msYoYgwOtCfJgVMiKWGsh7mpXA23r7ukBCeqcVLFYL5u
        kh1+ZhE31gyPh1EgQtc8Sm33IQ==
X-Google-Smtp-Source: APXvYqwzCBetVhqi03nlstH+2xiRvE1S8LLzzKPoHl8PnMWGRbi9WPqIjh6DlV3BAMChVYt4vLwyIQ==
X-Received: by 2002:a17:902:bc4b:: with SMTP id t11mr67117635plz.255.1558333558539;
        Sun, 19 May 2019 23:25:58 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id q17sm28567910pfq.74.2019.05.19.23.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 May 2019 23:25:57 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     nayna@linux.ibm.com, cclaudio@linux.ibm.com,
        linux-fsdevel@vger.kernel.org, greg@kroah.com,
        linuxppc-dev@lists.ozlabs.org
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [WIP RFC PATCH 0/6] Generic Firmware Variable Filesystem
Date:   Mon, 20 May 2019 16:25:47 +1000
Message-Id: <20190520062553.14947-1-dja@axtens.net>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

As PowerNV moves towards secure boot, we need a place to put secure
variables. One option that has been canvassed is to make our secure
variables look like EFI variables. This is an early sketch of another
approach where we create a generic firmware variable file system,
fwvarfs, and an OPAL Secure Variable backend for it.

In short, platforms provide a simple backend that can interface with
the hardware, and fwvarfs deals with translating that into a
filesystem that you can use. Almost all of the hard work is done by
kernfs: fwvarfs provides a pretty thin layer on top of that to make
backends a simple as possible.

Behaviour and the API is documented in Documentation/filesystems/fwvarfs.txt

To demonstrate the concept, a fully functional memory-based backend is
provided, and a read-only but userspace-compatible EFI backend.

For OPAL secure variables, I have taken Claudio's commit, tweaked it
to apply to linux-next, replaced all the EFI support with a generic
API, and then written a backend against that. There's a coming version
from Claudio that moves the opal calls towards a simple key/value
interface rather than (name, vendor) pairs - I haven't waited for
that: this is really just to demonstrate that it could be done rather
than an attempt to get mergable code.  It is also compile tested only
as I haven't yet set myself up with a test machine.

The patches are a bit rough, and there are a number of outstanding
TODOs sprinkled in everywhere. The idea is just to do a proof of
concept to inform our discussions:

 - Is this the sort of approach you'd like (generic vs specific)?
 
 - Does the backend API make sense?
 
 - Is the use of kernfs the correct decision, or is it potentially too
   limiting? (e.g. no ability to do case-insensitivity like efivarfs)

 - Is assuming flat fwvars correct or is there a firmware with a
   hierarchical structure?

Regards,
Daniel

Claudio Carvalho (1):
  powerpc/powernv: Add support for OPAL secure variables

Daniel Axtens (5):
  kernfs: add create() and unlink() hooks
  fwvarfs: a generic firmware variable filesystem
  fwvarfs: efi backend
  powerpc/powernv: Remove EFI support for OPAL secure variables
  fwvarfs: Add opal_secvar backend

 Documentation/filesystems/fwvarfs.txt        | 154 ++++++++++
 arch/powerpc/include/asm/opal-api.h          |   6 +-
 arch/powerpc/include/asm/opal-secvar.h       |  58 ++++
 arch/powerpc/include/asm/opal.h              |  10 +
 arch/powerpc/platforms/powernv/Kconfig       |   8 +
 arch/powerpc/platforms/powernv/Makefile      |   1 +
 arch/powerpc/platforms/powernv/opal-call.c   |   4 +
 arch/powerpc/platforms/powernv/opal-secvar.c | 121 ++++++++
 fs/Kconfig                                   |   1 +
 fs/Makefile                                  |   1 +
 fs/fwvarfs/Kconfig                           |  47 +++
 fs/fwvarfs/Makefile                          |  10 +
 fs/fwvarfs/efi.c                             | 177 +++++++++++
 fs/fwvarfs/fwvarfs.c                         | 294 +++++++++++++++++++
 fs/fwvarfs/fwvarfs.h                         | 124 ++++++++
 fs/fwvarfs/mem.c                             | 113 +++++++
 fs/fwvarfs/opal_secvar.c                     | 218 ++++++++++++++
 fs/kernfs/dir.c                              |  54 ++++
 include/linux/kernfs.h                       |   3 +
 include/uapi/linux/magic.h                   |   1 +
 20 files changed, 1404 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/filesystems/fwvarfs.txt
 create mode 100644 arch/powerpc/include/asm/opal-secvar.h
 create mode 100644 arch/powerpc/platforms/powernv/opal-secvar.c
 create mode 100644 fs/fwvarfs/Kconfig
 create mode 100644 fs/fwvarfs/Makefile
 create mode 100644 fs/fwvarfs/efi.c
 create mode 100644 fs/fwvarfs/fwvarfs.c
 create mode 100644 fs/fwvarfs/fwvarfs.h
 create mode 100644 fs/fwvarfs/mem.c
 create mode 100644 fs/fwvarfs/opal_secvar.c

-- 
2.19.1

