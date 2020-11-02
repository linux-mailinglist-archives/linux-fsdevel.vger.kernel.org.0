Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263272A31F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 18:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgKBRrs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 12:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBRrp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:47:45 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8568BC0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 09:47:45 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 72so5047930pfv.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fgdp9Q5Ryos9FWUvwhnwrJKEhYJ+1M5L8BMrT6meyNY=;
        b=wWq2ykhXi6fVitAbeMVisX3fyxKKKGyoNOTC1c0zV20h/DEuDmnjoaXg4y2VX4hdoC
         FvBCsdTGS3ca52CRqIwng2Zqk/Jz7/JmR/lkXZnpPiqJAuFq6koEjyCC+nTXw5HBFMr6
         zNqBe7GmyDQ8IAxRHg9MQmGEstUGKVn4a0Up0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fgdp9Q5Ryos9FWUvwhnwrJKEhYJ+1M5L8BMrT6meyNY=;
        b=t8ZAuT+BFSykTscJV/VLV20WoYT4JNW5oJKR5Y/66AmYEn7cOaeM8pn5aXs1fsIp6V
         cqUjcUJ/9OKw1917TvsFr2eTVnRy4heKXt2fXRz6t7c2uwr3m4aKRohYp7SfdyHUqZYi
         92AR+Undil5mLjrMHyM9LbyHL+vOXKmke8zkhCi3L7xDBM6iCYKM1PoAVPY9wNNGA4sK
         pyiE0nMkK6bFxEocWzYCweILT/STTD1C4ZBf1msCeURIg1HtFBdLSg68WHRxwZP2RbKU
         aSNEVKSnXprSPK+o+kIZRBCfa9E1nwaTN/gqkvhGWnARJ5lTgGmnPBnU/JPyHlPEgV0Z
         QB+A==
X-Gm-Message-State: AOAM532Lm6xrG/KmWIUn4pZuPoKMoFHl8HPY5tdTlBKucw2RPTMJsJoZ
        PA6sEdirR5Gl3Ec0V7umPa3oBNuDQxqRoqEKydg=
X-Google-Smtp-Source: ABdhPJwJxojkON8BTRl7uxWAP/jj+ExC2FAQKTI1xauZE+CTwqlXP7ivXNS/9FOvx0XVp7+jhulgNg==
X-Received: by 2002:a63:d456:: with SMTP id i22mr14208167pgj.440.1604339264860;
        Mon, 02 Nov 2020 09:47:44 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id f4sm115989pjs.8.2020.11.02.09.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:47:44 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Anna Schumaker <schumaker.anna@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] NFS: Fix interaction between fs_context and user namespaces
Date:   Mon,  2 Nov 2020 09:47:35 -0800
Message-Id: <20201102174737.2740-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is effectively a resend, but re-based atop Anna's current tree. I can
add the samples back in an another patchset.

Right now, it is possible to mount NFS with an non-matching super block
user ns, and NFS sunrpc user ns. This (for the user) results in an awkward
set of interactions if using anything other than auth_null, where the UIDs
being sent to the server are different than the local UIDs being checked.
This can cause "breakage", where if you try to communicate with the NFS
server with any other set of mappings, it breaks.

This is after the initial v5.10 merge window, so hopefully this patchset
can be reconsidered, and maybe we can make forward progress? I think that
it takes a relatively conservative approach in enabling user namespaces,
and it prevents the case where someone is using auth_gss (for now), as the
mappings are non-trivial.

Changes since v3:
  * Rebase atop Anna's tree
Changes since v2:
  * Removed samples
  * Split out NFSv2/v3 patchset from NFSv4 patchset
  * Added restrictions around use
Changes since v1:
  * Added samples

Sargun Dhillon (2):
  NFS: NFSv2/NFSv3: Use cred from fs_context during mount
  NFSv4: Refactor NFS to use user namespaces

 fs/nfs/client.c     | 10 ++++++++--
 fs/nfs/nfs4client.c | 27 ++++++++++++++++++++++++++-
 fs/nfs/nfs4idmap.c  |  2 +-
 fs/nfs/nfs4idmap.h  |  3 ++-
 4 files changed, 37 insertions(+), 5 deletions(-)


base-commit: 8c39076c276be0b31982e44654e2c2357473258a
-- 
2.25.1

