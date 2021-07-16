Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0D83CB645
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 12:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbhGPKtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 06:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238724AbhGPKti (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:49:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA48B613F9;
        Fri, 16 Jul 2021 10:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626432404;
        bh=GuXsR1fFgkoj7fLf3lWdJFPJsThuVrYv5R5gCHH0rps=;
        h=From:To:Cc:Subject:Date:From;
        b=DY0wM7ZgkKLtkTM/LS5jXXEhpS2Scbo0U+MZfBt/NACV69/CaDW3E8Pk3oGaPv9yi
         72xdSWDCJHlaG+O5Xh8s+eCgUnMkGeXG0Im6kHoA+iDKCtSutiKBVkc+4yHL6XtTmc
         CJk38XFdPy0/3y4/g98zDbJ8a0M6h5IOwDsv16Bv/1bfWOB+X2VXKAq4gNV9oK+LT7
         pz9Ah2Soi9LHLeYkfSFaSucKVt9GY6eSePImrVzw1vUyAzzZOWyPTo+f++nt3IdhsH
         L4Z3aLaUBmntT8ewq2xjbAnRYx/sPG5A4ce8XwtdI4CRpiERw8NXjcdu2EASFJ96Pq
         fHX+5sKqGsxpg==
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: [RESEND PATCH v6 0/5] proc: subset=pid: Relax check of mount visibility
Date:   Fri, 16 Jul 2021 12:45:58 +0200
Message-Id: <cover.1626432185.git.legion@kernel.org>
X-Mailer: git-send-email 2.29.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow to mount procfs with subset=pid option even if the entire procfs
is not fully accessible to the mounter.

Changelog
---------
v6:
* Add documentation about procfs mount restrictions.
* Reorder commits for better review.

v4:
* Set SB_I_DYNAMIC only if pidonly is set.
* Add an error message if subset=pid is canceled during remount.

v3:
* Add 'const' to struct cred *mounter_cred (fix kernel test robot warning).

v2:
* cache the mounters credentials and make access to the net directories
  contingent of the permissions of the mounter of procfs.

--

Alexey Gladkov (5):
  docs: proc: add documentation about mount restrictions
  proc: subset=pid: Show /proc/self/net only for CAP_NET_ADMIN
  proc: Disable cancellation of subset=pid option
  proc: Relax check of mount visibility
  docs: proc: add documentation about relaxing visibility restrictions

 Documentation/filesystems/proc.rst | 15 +++++++++++++++
 fs/namespace.c                     | 30 ++++++++++++++++++------------
 fs/proc/proc_net.c                 |  8 ++++++++
 fs/proc/root.c                     | 24 +++++++++++++++++++-----
 include/linux/fs.h                 |  1 +
 include/linux/proc_fs.h            |  1 +
 6 files changed, 62 insertions(+), 17 deletions(-)

-- 
2.29.3

