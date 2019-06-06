Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4204A3758C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 15:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfFFNo2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 09:44:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51512 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbfFFNoY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:44:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id f10so10342wmb.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2019 06:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fvQrk6QqMWIbLlAcsJuBVoZshDn5zuagYNbpKnSUNYk=;
        b=ZesqP08QI2a2cCi5fQdLu7o52AAZGx22ZZYszKIm4/0sAcYm8gmt3S8Xdy9/quXxo8
         fCc9Svaa7NjdeYsBcL7Z3PfXcbwUby41EXbz72I8BMIqAQD5+dH7o0DtybR6fEJClRXf
         UM+9oBxCF775fHhmCTgv7wTlyfvcGjkIx7jQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fvQrk6QqMWIbLlAcsJuBVoZshDn5zuagYNbpKnSUNYk=;
        b=ViESnXasV0fY5urJY2JUkcCOYdMS2mUHlVooAnAz7Om3LnhpVLQt8Ja8oD+BX5behH
         3tmOohmxmUnWr0dXxxrgy/WY1/7e/0CBIdsUf2OVq8rT25pPSlVRHel+yGF+Ukv1be5I
         yLy2Ue7kOrTzWKbTz1N6kCnNyqU5F5gC9/tbMCcZo0umzXBrcMAG4rX0gpDKTtY7Zmfu
         qPLMViFLnVKyEaEIWygMYnrKOwpU60lvnenBLkTkJYQ96zCkNhO1C+YDguInw7deh1WN
         mZ7KoqJb5ZnrtSeCnYL1KQEXOiONJeFAIGiHxY0wlLnKX6d+mozIHdu7ka3J9e3uFvUd
         dL4g==
X-Gm-Message-State: APjAAAWEFVT4sXXGifyvlUXoQYxl54/h8gc2bUsi8mUIGApx26zLmuxm
        68RCLoIUxF6q+SKnvrkWjQyX00BkxwE=
X-Google-Smtp-Source: APXvYqyd5ViDsM/ozDX+i5BT0Qs/6fseaDiqhur2F81bUtGwOj65M5uwWd0P+3/cqvLibI+BQjOSDw==
X-Received: by 2002:a1c:700b:: with SMTP id l11mr68339wmc.106.1559828661872;
        Thu, 06 Jun 2019 06:44:21 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v6sm2252245wru.6.2019.06.06.06.44.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 06:44:21 -0700 (PDT)
Date:   Thu, 6 Jun 2019 15:44:18 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 5.2-rc4
Message-ID: <20190606134418.GB26408@miu.piliscsaba.redhat.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.2-rc4

Here's one fix for a class of bugs triggered by syzcaller, and one that
makes xfstests fail less.

Thanks,
Miklos

----------------------------------------------------------------
Amir Goldstein (2):
      ovl: support the FS_IOC_FS[SG]ETXATTR ioctls
      ovl: detect overlapping layers

Miklos Szeredi (1):
      ovl: doc: add non-standard corner cases

---
 Documentation/filesystems/overlayfs.txt |  16 ++-
 fs/overlayfs/file.c                     |   9 +-
 fs/overlayfs/inode.c                    |  48 +++++++++
 fs/overlayfs/namei.c                    |   8 ++
 fs/overlayfs/overlayfs.h                |   3 +
 fs/overlayfs/ovl_entry.h                |   6 ++
 fs/overlayfs/super.c                    | 169 ++++++++++++++++++++++++++++----
 fs/overlayfs/util.c                     |  12 +++
 8 files changed, 249 insertions(+), 22 deletions(-)
