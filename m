Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982F841C304
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 12:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245558AbhI2K4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 06:56:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47804 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245275AbhI2K4E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 06:56:04 -0400
Received: from localhost.localdomain (unknown [IPv6:2401:4900:1c20:3124:6d32:b2f4:daed:4666])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3E7591F43F7F;
        Wed, 29 Sep 2021 11:54:20 +0100 (BST)
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     tytso@mit.edu, viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        krisman@collabora.com
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH 0/2] Handle a soft hang and the inconsistent name issue
Date:   Wed, 29 Sep 2021 16:23:37 +0530
Message-Id: <cover.1632909358.git.shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When d_add_ci is called from the fs layer, we face a soft hang which is
caused by the deadlock in d_alloc_parallel. First patch in the series
tries to resolve it by doing a case-exact match instead of the
case-inexact match done by d_same_name function.

The second patch resolves the inconsistent name that is exposed by
/proc/self/cwd in case of a case-insensitive filesystem.
/proc/self/cwd uses the dentry name stored in dcache. Since the dcache
is populated only on the first lookup, with the string used in that lookup,
cwd will have an unexpected case, depending on how the data was first
looked-up in a case-insesitive filesystem.


Shreeya Patel (2):
  fs: dcache: Handle case-exact lookup in d_alloc_parallel
  fs: ext4: Fix the inconsistent name exposed by /proc/self/cwd

 fs/dcache.c     | 20 ++++++++++++++++++--
 fs/ext4/namei.c | 13 +++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.30.2

