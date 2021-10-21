Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33724360AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 13:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhJULsD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 07:48:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231216AbhJULrs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634816731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f7EfK4fH4+K5jyI+x+ALkVgR0rPVo53olum02EqwWwc=;
        b=Q7srr0Oz+HJzd91Az40dzAoNkKJ8vzIu9U6XtKdPYAMauW7X59UGTzyvsIJ9MijIUcACaE
        qZyZZ6lhDAvAjmjz0oFE/pctyCe4nSOWizVz5pod5zt4kh7dFdBBlSU1R+UUhFWnSF49P9
        7411T8cSY4eLap7IHGXvcrZILbSDBmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-DzQePWEkOoihfivyDDT9hg-1; Thu, 21 Oct 2021 07:45:27 -0400
X-MC-Unique: DzQePWEkOoihfivyDDT9hg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE5CF1808308;
        Thu, 21 Oct 2021 11:45:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E587C652AC;
        Thu, 21 Oct 2021 11:45:25 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 11/13] ext4: change token2str() to use ext4_param_specs
Date:   Thu, 21 Oct 2021 13:45:06 +0200
Message-Id: <20211021114508.21407-12-lczerner@redhat.com>
In-Reply-To: <20211021114508.21407-1-lczerner@redhat.com>
References: <20211021114508.21407-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chage token2str() to use ext4_param_specs instead of tokens so that we
can get rid of tokens entirely.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index bdcaa158eab8..0ccd47f3fa91 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3037,12 +3037,12 @@ static inline void ext4_show_quota_options(struct seq_file *seq,
 
 static const char *token2str(int token)
 {
-	const struct match_token *t;
+	const struct fs_parameter_spec *spec;
 
-	for (t = tokens; t->token != Opt_err; t++)
-		if (t->token == token && !strchr(t->pattern, '='))
+	for (spec = ext4_param_specs; spec->name != NULL; spec++)
+		if (spec->opt == token && !spec->type)
 			break;
-	return t->pattern;
+	return spec->name;
 }
 
 /*
-- 
2.31.1

