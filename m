Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FCC295331
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 21:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439140AbgJUT5x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 15:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390855AbgJUT5x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:57:53 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE94C0613CE;
        Wed, 21 Oct 2020 12:57:53 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 140so3845710qko.2;
        Wed, 21 Oct 2020 12:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+lPCKW5tOZtG58NyWnAeE0Zhi9RI/0NMfb90IvbTyec=;
        b=NeaZEe+qLZeM3cStFY3FQ54k8gVoY57OD/2T1zTQwRIVwchAVNjzrOYENb3hj5G6r6
         hHhD4GuJwfAaWaJk+WMd23BXsJrjIvvzBLqv8f6nPs2jnnimjxUApaIi6LLtYsHD9eGq
         YIQgRFNUmUprMlX3KYOvm6iZK9YzajUs0klAkOI9nwydoZ6oc2mfdFAlkiPd8OIQjf67
         pSZBgZqOpF/LAzPNFP9+3AWD0S8qHNX6SiYssEIF8dOWEZU3HzTrnKxZEcxinDv3WvrZ
         ESurV2GAb39CfNy56RMrk71KUmLVgggOmy5vF6loQGRBwNsfIGCKPy16v3VkUv926ahw
         lX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+lPCKW5tOZtG58NyWnAeE0Zhi9RI/0NMfb90IvbTyec=;
        b=CCvXBmH1AcEc8IlBAbNtJ2ok/cuSC3Hn9ZmUhnTV89qxfkh1wxjWxIP5kFpyiDiAls
         wAuYcRjj9jzPnDVhC1V9rEL0LrHsXg94GlMeERKMDrncP5CeH36R9raZR88leIroOQ6Q
         8waluKsfND+9zZ100UbASJi5PBaB7Cbn5NYqsvrrENcl8RbnkjMxS63z+Wc0e46hZ7nD
         jDgglu77zocv1joPK7Ud1dhgD67MTCRb/L9e3zV9fUSzGHPyOs9m+KTWLOWElUZomw2k
         t5x8fKff7blcBy1gfmdAx19VNK7jZHPDhfupQTFfBfsUwSPCO3gJOJ6FJrPzpqx39ZLJ
         qYNA==
X-Gm-Message-State: AOAM533zkxAJRW3Al91GDI4JTT6Nx2HL3JWc2x4jDLgwFx9ezrnk4jdi
        DMk4fosGNww5qBRG1tFT8VmtfL0npqvh
X-Google-Smtp-Source: ABdhPJzFFjNURmmjppSB1UqWR0mCnlPJ/EYQqG+ktOu9xuUjvXYBaCnUyvyamABDWb+oaoC+/y4WTQ==
X-Received: by 2002:ae9:e20b:: with SMTP id c11mr4511280qkc.137.1603310272390;
        Wed, 21 Oct 2020 12:57:52 -0700 (PDT)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id 124sm1867603qkn.47.2020.10.21.12.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 12:57:51 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, sfrench@samba.org,
        linux-cifs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v2 0/2] kill add_to_page_cache_locked()
Date:   Wed, 21 Oct 2020 15:57:43 -0400
Message-Id: <20201021195745.3420101-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

since v1
 - kill a faulty assertion found by kernel test robot
 - drop an unneeded line break

Andrew, can this go through your tree?

Kent Overstreet (2):
  cifs: convert to add_to_page_cache()
  fs: kill add_to_page_cache_locked()

 fs/cifs/file.c          | 20 +++----------
 include/linux/pagemap.h | 20 ++-----------
 mm/filemap.c            | 64 ++++++++++++++++++++---------------------
 3 files changed, 37 insertions(+), 67 deletions(-)

-- 
2.28.0

