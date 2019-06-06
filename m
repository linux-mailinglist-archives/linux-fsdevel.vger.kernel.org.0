Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC6D37559
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 15:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfFFNg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 09:36:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35685 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfFFNg7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:36:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so2488330wrv.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2019 06:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dMQoje3A+0QuY6d03qdojH8LCBsthMNo+3SlZkjo5Dg=;
        b=JcFFeyYh1751+B47UcZHbFJZ+QYlZUmSkfkKyepILPP91d69zlPjfNw4NUshuxLjuv
         c6+f+6AJ4xxxwgIl2CbkBXFQZEpDWxbTvGrRoV1RKknqD1mmRiYzylSYYDu8gRRQi2W5
         Spbo8ckjPSBHizQyNoOlm7DULD9gs7T+7S030=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dMQoje3A+0QuY6d03qdojH8LCBsthMNo+3SlZkjo5Dg=;
        b=Mtk4Eaa/Qxq63TCAguERjfhYFjofEqrqN6/6zWaRZBo3Q+DZfEbZApUzZ8z0FiwhzZ
         26l7PRBWpQiFVCQpIEsEqe+N5BOiQ7aZkEsUOLmbWGGMlSg3IIxA1hEDd+TMPJlf5aHd
         m+XFVtUoFPKeWbiAr6xjxeX4BJQir2w5AsEHBUL7Neu11R8iipAUrl2mmr5wJdAZ4DnH
         SIVN0QBVYYasRz0zfa+peJcFHNRSlNVWZTB5R0WeAeNR41XGrUiypjFIydYgdz8KVPQU
         ayYtzG2p9kjO9x3CHAIvaAWg0ZwXka1AWobnC4TnzPAKXqzk0ldNRc1of4uc9I76G8S7
         yP3g==
X-Gm-Message-State: APjAAAV3zKcWqYGjgWdo+kEbRIFNiCYTGQnJ9ZZJEWy+yb5BDiFygeAf
        YWgC0B8CX9b2f86mB0UNhAQvyg==
X-Google-Smtp-Source: APXvYqx74mqUhMOOqkkyB7ZGXf3YbkwFJ8aN77g/VlWrPdi+A4qCmByDgKoJoXVqxagoPQdNO9l/Sw==
X-Received: by 2002:a5d:684c:: with SMTP id o12mr16899507wrw.305.1559828217675;
        Thu, 06 Jun 2019 06:36:57 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id s9sm1809917wmc.1.2019.06.06.06.36.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 06:36:56 -0700 (PDT)
Date:   Thu, 6 Jun 2019 15:36:50 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.2-rc4
Message-ID: <20190606133650.GA26408@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.2-rc4

This fixes a leaked inode lock in an error cleanup path and a data
consistency issue with copy_file_range().  It also adds a new flag for the
WRITE request that allows userspace filesystems to clear suid/sgid bits on
the file if necessary.

Thanks,
Miklos

----------------------------------------------------------------
Miklos Szeredi (4):
      fuse: fallocate: fix return with locked inode
      fuse: add FUSE_WRITE_KILL_PRIV
      fuse: fix copy_file_range() in the writeback case
      fuse: extract helper for range writeback

---
 fs/fuse/file.c            | 43 ++++++++++++++++++++++++++++++++-----------
 include/uapi/linux/fuse.h |  7 ++++++-
 2 files changed, 38 insertions(+), 12 deletions(-)
