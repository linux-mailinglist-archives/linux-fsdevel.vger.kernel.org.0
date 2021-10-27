Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28FD43CBF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 16:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242477AbhJ0OXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 10:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242518AbhJ0OXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635344453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooYPMUcYLaO+4QN8jxKsu1JBRRa+uzG5tHODsPo08r4=;
        b=hLjjE/0iblb7XJtVCbfnL//1DmayO4rw5LOe1DYQv/i0TZmwxjgUvkl4xeohVpiurxIF5J
        E0I965JuMmN+9nkyJ4iJR0fqvZIsqTLhpgs0Hi8+/q7ytlYA6lRHgxpreXJtmpiH95dNVA
        0/vGmEkrKisiQQ1LMArahni/e0rPeic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-CitBmqR8Mn-RyDrmWIEblw-1; Wed, 27 Oct 2021 10:20:52 -0400
X-MC-Unique: CitBmqR8Mn-RyDrmWIEblw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 411C810168C0;
        Wed, 27 Oct 2021 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C21761281;
        Wed, 27 Oct 2021 14:20:49 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH v4 11/13] ext4: change token2str() to use ext4_param_specs
Date:   Wed, 27 Oct 2021 16:18:55 +0200
Message-Id: <20211027141857.33657-12-lczerner@redhat.com>
In-Reply-To: <20211027141857.33657-1-lczerner@redhat.com>
References: <20211027141857.33657-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change token2str() to use ext4_param_specs instead of tokens so that we
can get rid of tokens entirely.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/ext4/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b66087f55009..67efe9c6b9e8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3039,12 +3039,12 @@ static inline void ext4_show_quota_options(struct seq_file *seq,
 
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

