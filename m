Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F5A131DA1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 03:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgAGCda (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 21:33:30 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:46257 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbgAGCd3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 21:33:29 -0500
Received: by mail-pg1-f202.google.com with SMTP id t12so34621668pgs.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2020 18:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=O1rrw6EvjMbKpG10O7fcEnuEhFH7c83ZPqm4a4bC03o=;
        b=htuxPhrn4gnUnAYmqPZuewdNt56B7rhDViUelJJXizJ6hLd3Emt8h8B7+Ak7wal+TZ
         jXu02HNW7sLG6jo4F/wxLWT3OTfVjIC/f0J5nBTsTvztSpJxr8W51jwkBrZFHkH5uAxb
         PcIvCcWyyvfAnrZ44k3o3eErD+NdKMkWQDEIjfqx+EFuDmvfZ/r40MymSQQ2b0BV5hio
         UlKTVzdsBE9TWgpvFn8DNzlst42kW/j2fOYkSQaQhrth1jjzeAVhn55zIMmnkjKwiLlj
         DjGbu4pSDNIOlcS2D5PUzv/GGfqF4UFfHHiknx5CHBV8UrH67zKRznLTRWkFmm0SVoro
         azDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=O1rrw6EvjMbKpG10O7fcEnuEhFH7c83ZPqm4a4bC03o=;
        b=jNOzul/c9FbLXChNZPEikn8MgAqBlHvaIr9T114qoU0k85WVc5W4X5c8Y+Xcfag7hM
         qP6Khi1PBYDcLY5roogWoSwJOZlBy7fGg6R2QN1Kn9St2Rh9TbWJ3a9T/JO0f0yCE7ia
         k+EwSoLuxKgXKYkUQ4sXodzJl2ki7NgsCKSRlLp1psEOMYTPWj+86bhXRWz6/Z5oUVPD
         7HRNAGj/TgDYfshDK++B0WSp0GnBNicSXbU58gLu5vEbQ0aIGfuUvOjekq8hkKsuhgmi
         U356kfmW2LDqPBX+xyjv6h574N1mjAliUY/2yPuxFw7am6bKEnjO/tRHNevPTco7nzSQ
         IPUg==
X-Gm-Message-State: APjAAAVgkW6qb1l2W5xPZB/dORC+M6YXUH2FJ8kXQIEpB+XqWVrgMcYs
        hKSj5ETNlHh3xrpSgBDqXOxS1lH09lY=
X-Google-Smtp-Source: APXvYqydaS5YEyJeIQa/tWsZtekS/LbVCoM6/8jRQLEddU8j5tYHjcjZ8FzSad5aqvPrlTbStAyAUSKpGNY=
X-Received: by 2002:a63:4664:: with SMTP id v36mr112296109pgk.147.1578364408910;
 Mon, 06 Jan 2020 18:33:28 -0800 (PST)
Date:   Mon,  6 Jan 2020 18:33:20 -0800
Message-Id: <20200107023323.38394-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 0/3] Fscrypt support for casefolded encryption
From:   Daniel Rosenberg <drosen@google.com>
To:     Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These patches are to prepare fscrypt to support casefolding and
encryption at the same time. Other patches will add those to the
vfs, ext4 and f2fs. These patches are against fscrypt/master

Daniel Rosenberg (3):
  fscrypt: Add siphash and hash key for policy v2
  fscrypt: Don't allow v1 policies with casefolding
  fscrypt: Change format of no-key token

 fs/crypto/Kconfig           |   1 +
 fs/crypto/fname.c           | 232 ++++++++++++++++++++++++++++--------
 fs/crypto/fscrypt_private.h |   9 ++
 fs/crypto/keysetup.c        |  35 ++++--
 fs/crypto/policy.c          |  39 ++++++
 fs/inode.c                  |   7 ++
 include/linux/fscrypt.h     |  95 ++++-----------
 7 files changed, 284 insertions(+), 134 deletions(-)

-- 
2.24.1.735.g03f4e72817-goog

