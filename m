Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C50290553
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 14:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405344AbgJPMiE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 08:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407656AbgJPMhz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:37:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFDBC0613D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 05:37:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j8so1429207pjy.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 05:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O1evu/uCI+QRNY7SsK/no8njk1hcUqNItCkuJRC3dLc=;
        b=bbJsAymhNU7wMqvb0WzSVgn1C9Jcd2lKiiaXod7R/qUN4qsDT63a+BhDt4ttf0Jl4C
         rjtiJa1dk4TOXpoKlArIjTaEtyzOWqWztAYpfgR1YZng7senS2eo6FvwC4oJxXRS3ELW
         /M62ON0214rJR8cODTrk/F8IWYlsvYFtJzBSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O1evu/uCI+QRNY7SsK/no8njk1hcUqNItCkuJRC3dLc=;
        b=YXlwRdf1dh/7SzOaJmQkw6/ZklOvI1C14j+7oUhc+xdeAA/4F4jvh0XrD4+fwFRbae
         bw2M0KMXFQzY5dl/nl0lSsuNbhVR43qkM8WpD07IoVn6USz9XEZEn7QVuoZHn4byUDRh
         EyOXpjq+nTkQ2VxxrzX7U392rIt8pUQ/8GJYALpcjsUaKE/GSjHiOU8/wABSCpXqax7h
         Ombw1f0h9Sz0gyzMn5kPgTWH7rMdd4MCvdjA+2tuTaMpYw7h25PkbEQZozLuCQAE6X5Y
         JUrxyjCgMG2FpWZnw8WvaDAjT6YsYera/aBWANM2xuntAbO+aGwPyACnvitwrLIPox7V
         +q8w==
X-Gm-Message-State: AOAM530oPbQOwOf7sPqJxZvpveW3joIM0xdESx+/Yz95FTYdm0Y9fAfX
        WP+7aw72XBFObN2MvMn/0HPziJHvUhiD5w==
X-Google-Smtp-Source: ABdhPJzsFH8TOOowaw0mIWd+vpBDOWRsXcrIqIPbu4xMwYtLhl/N2BPAgpaIC6rR8+z7FBQJsv7CTg==
X-Received: by 2002:a17:90a:65cc:: with SMTP id i12mr3772205pjs.193.1602851874366;
        Fri, 16 Oct 2020 05:37:54 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id q8sm2857216pfg.118.2020.10.16.05.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 05:37:53 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] NFS User Namespaces
Date:   Fri, 16 Oct 2020 05:37:42 -0700
Message-Id: <20201016123745.9510-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset adds some functionality to allow NFS to be used from
NFS namespaces (containers).

Changes since v1:
  * Added samples

Sargun Dhillon (3):
  NFS: Use cred from fscontext during fsmount
  samples/vfs: Split out common code for new syscall APIs
  samples/vfs: Add example leveraging NFS with new APIs and user
    namespaces

 fs/nfs/client.c                        |   2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c |   1 +
 fs/nfs/nfs4client.c                    |   2 +-
 samples/vfs/.gitignore                 |   2 +
 samples/vfs/Makefile                   |   5 +-
 samples/vfs/test-fsmount.c             |  86 +-----------
 samples/vfs/test-nfs-userns.c          | 181 +++++++++++++++++++++++++
 samples/vfs/vfs-helper.c               |  43 ++++++
 samples/vfs/vfs-helper.h               |  55 ++++++++
 9 files changed, 289 insertions(+), 88 deletions(-)
 create mode 100644 samples/vfs/test-nfs-userns.c
 create mode 100644 samples/vfs/vfs-helper.c
 create mode 100644 samples/vfs/vfs-helper.h

-- 
2.25.1

