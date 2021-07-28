Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0061D3D8E30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 14:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbhG1Mrm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 08:47:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236214AbhG1Mrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627476458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZozCbX2m1W/OrnW2mCMcnQdN7vYQjUpGw86JNBK1Hco=;
        b=SrjsZKuYpQuIyZCLD+6rsAOH0836ANhxzFEyqYrOvvu9FnTORVwSQDVPMd4lVDd1vbJl/W
        I5tmPNTITOAAoyQiXc5Hxb1g1QdA/0g0gyvDrrLEytqaWhLGSlN+rcctnK9GAczLus2APl
        ji+w30U2C/OKl+cpOfmYJomcpvau7B0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-okCb4SCQOoKqZKVrWfFNZQ-1; Wed, 28 Jul 2021 08:47:37 -0400
X-MC-Unique: okCb4SCQOoKqZKVrWfFNZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34D3C1008064;
        Wed, 28 Jul 2021 12:47:36 +0000 (UTC)
Received: from vishnu.redhat.com (ovpn-112-120.phx2.redhat.com [10.3.112.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8DB55C1BB;
        Wed, 28 Jul 2021 12:47:35 +0000 (UTC)
From:   Bob Peterson <rpeterso@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org
Subject: [vfs PATCH 0/2] Fix gfs2 setattr bug
Date:   Wed, 28 Jul 2021 07:47:32 -0500
Message-Id: <20210728124734.227375-1-rpeterso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

Here is a set of two patches from Andreas Gruenbacher to fix a problem
that causes xfstests generic/079 to fail on gfs2. The first patch moves a
chunk of code from notify_change to its own function, may_setattr, so gfs2
can use it. The second patch makes gfs2 use it.

Bob Peterson

Andreas Gruenbacher (2):
  fs: Move notify_change permission checks into may_setattr
  gfs2: Switch to may_setattr in gfs2_setattr

 fs/attr.c          | 50 ++++++++++++++++++++++++++++------------------
 fs/gfs2/inode.c    |  4 ++--
 include/linux/fs.h |  2 ++
 3 files changed, 35 insertions(+), 21 deletions(-)

-- 
2.31.1

