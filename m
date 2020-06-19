Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9ADD2000AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 05:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbgFSDU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 23:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgFSDU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:20:56 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9032C06174E;
        Thu, 18 Jun 2020 20:20:54 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q2so7779917qkb.2;
        Thu, 18 Jun 2020 20:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7rG31ouebqs0ESzgr7K1aKbxssJ2xYwHTH5m2zIqKSI=;
        b=TzTuwN7Q2o7D9DWdQpLpg0PlboYfx9ppS5c9v0XE8kYlBjkjlpDB5DbXqaIKNiqXZB
         lGUz7ypDVYzi12uoBq3Rb6CUn3aZBsDqlTv032AX9YkHhv1V/mIlpywcnwLUN25n6gcB
         Ktv6U9cj+2bGVoxI1yMhVk2OWGhoTcEulIdj7kfvghATYfI+LU1MHgDD8BKBtod2PVfq
         i0216Dw3FLIE1RFnxYgALbpnJLtN2jfNrpCH/R2O2mbBmHULImtXb5IliGWms7TLnR/Z
         tCbdhzpnhMImPUrYoXufEQZUjbOItqmL1RXhmnGkI0FKRqNG290O+u7YFNnQEZssQ9+L
         W4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7rG31ouebqs0ESzgr7K1aKbxssJ2xYwHTH5m2zIqKSI=;
        b=UcIdmQytqDg8H3TctwbJ8W1kybKI0CHpPG5vMpklLNcZ6+rfht00WeyzUlM7ME2cK4
         BGh5Jvx7DbivTpcks0xvZGMmHdAaTbSEeBvv9qe01LiNliW6uhr5489xLU/6ZSXkjoX6
         0Qf2+OHraO9ojyZvmL8m4Mgxa1tjlpkATYAriXasT7QXnvVFMpCJfGYsZ8WtWjlRgS94
         j7acCEfTBbYy+P1kloSn5e6vG+2rNvFilvl9u8WXeP3rCsGdS154EnvWX+YMZ3Cf3Z6q
         s4yijw6bkDroMjSr9YBgeOS+QfLWYQzZ6+p+8J1VTU/RTLSFgXxbRbkXUi+QjYvWa0gc
         8SxQ==
X-Gm-Message-State: AOAM533aiC/xCyR45RlX2JLbygFMNR9vC7oQVBuScbSdQikerm1c7oum
        n7hOA1k4FPiuX8OOfdfL8nP4jwM=
X-Google-Smtp-Source: ABdhPJyqvyLUXH7m3fpzBAxZC1XFTeR+vHXmO/KJJFrjVnFPdzR8OhVpMgaC1/5wiwmWldS5Vwj3vA==
X-Received: by 2002:a37:8dc2:: with SMTP id p185mr1471199qkd.117.1592536854003;
        Thu, 18 Jun 2020 20:20:54 -0700 (PDT)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id b185sm5081564qkg.86.2020.06.18.20.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 20:20:53 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/2] generic_file_buffered_read() refactoring & optimization
Date:   Thu, 18 Jun 2020 23:20:47 -0400
Message-Id: <20200619032049.2687598-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617180558.9722e7337cbe3b88c4767126@linux-foundation.org>
References: <20200617180558.9722e7337cbe3b88c4767126@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ok - here's a new version, I fixed the checkpatch stuff and the thing with ret
should be more readable now:

Kent Overstreet (2):
  fs: Break generic_file_buffered_read up into multiple functions
  fs: generic_file_buffered_read() now uses find_get_pages_contig

 mm/filemap.c | 497 +++++++++++++++++++++++++++++----------------------
 1 file changed, 287 insertions(+), 210 deletions(-)

-- 
2.26.2

