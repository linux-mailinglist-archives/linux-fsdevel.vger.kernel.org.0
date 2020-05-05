Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629101C5255
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 11:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgEEJ7h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 05:59:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46392 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728715AbgEEJ7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 05:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588672773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iwN6rUp8u34Wlj1xDcqihvpusXAKoRcj4IW0NO+hiJk=;
        b=YrznLMeCkyiJ47quM1H3ZK5K+iQTMFdJsOPriW8HZBQne5M3xgKhIHvx3VXsGOkTVrGVbF
        1udvjiaxLqBlwTlloDRCgxqsJxv98gDdOQh96HmM8pKDSB2zBV+fxRqd4a4NWkl4VMt0H7
        IRYk4HUltV8OC2hlBPJd1PYtJuwTJaQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-QnGNP_hNNpmGywqa9789Qg-1; Tue, 05 May 2020 05:59:32 -0400
X-MC-Unique: QnGNP_hNNpmGywqa9789Qg-1
Received: by mail-wm1-f72.google.com with SMTP id f81so640717wmf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 02:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iwN6rUp8u34Wlj1xDcqihvpusXAKoRcj4IW0NO+hiJk=;
        b=jj896c9k7i+GLyIIL8Re+mNK5FmaHnek+oLYWBiTmCdlgKeukPYKabgIs8MC9v+rgE
         iD7oEdpP9BVrD2IDRKOtrfTXoo5OkkmuCaIU5GhTvLsDDOc6FLSgdIggWX/ePhaf3f2y
         8pPynTl4GDeIHlbDO+/uu0Aqkl64M0mrMF8ZwtgAFF8KEj7ePLedtWfFUC0FUeQl+I1q
         HQsf/RP/zSuPrwtj2w5v/DaGIYWLR0p7OXfXmk74eU1nT1V/kbKzIuvRS0HvOd89i8vn
         W/X8yxIIwQ6qxP10NnDA2wxXgTkGz1gaUfEPSTUzhuoOxkevHh2+LEdF/X5UxgyOycmg
         CeGw==
X-Gm-Message-State: AGi0PubXEmk5Jo0idCx6kW4SICnieABe0QgvbOXcPBS67LP+0x0x8AFA
        FRgG9HRcoWbuxwqVnRCEK25cur77SpeVUizyvjX8jPKb07H0zRJJIDuu/fCDEBEK9p0RnX2tNrE
        gC87tEFXg5Xh9xlyrBCsHc99Zsw==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr2477569wmi.98.1588672770498;
        Tue, 05 May 2020 02:59:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypJfeC9g7vOlKgl6jyM9ZWJYYITo5ISdmsZhuFjOdTEXf/idZKyJK5BCIqVtFBf82lVBlKK2+Q==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr2477557wmi.98.1588672770329;
        Tue, 05 May 2020 02:59:30 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t16sm2862734wmi.27.2020.05.05.02.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 02:59:29 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/12] vfs: don't parse "posixacl" option
Date:   Tue,  5 May 2020 11:59:14 +0200
Message-Id: <20200505095915.11275-12-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200505095915.11275-1-mszeredi@redhat.com>
References: <20200505095915.11275-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unlike the others, this is _not_ a standard option accepted by mount(8).

In fact SB_POSIXACL is an internal flag, and accepting MS_POSIXACL on the
mount(2) interface is possibly a bug.

The only filesystem that apparently wants to handle the "posixacl" option
is 9p, but it has special handling of that option besides setting
SB_POSIXACL.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 07e09bcf256c..82019569d493 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -42,7 +42,6 @@ static const struct constant_table common_set_sb_flag[] = {
 	{ "dirsync",	SB_DIRSYNC },
 	{ "lazytime",	SB_LAZYTIME },
 	{ "mand",	SB_MANDLOCK },
-	{ "posixacl",	SB_POSIXACL },
 	{ "ro",		SB_RDONLY },
 	{ "sync",	SB_SYNCHRONOUS },
 	{ },
-- 
2.21.1

