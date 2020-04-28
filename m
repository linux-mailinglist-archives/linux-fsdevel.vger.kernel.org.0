Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F541BB49E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 05:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD1D2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 23:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgD1D2G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:28:06 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4585AC03C1AC
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 20:28:06 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id ck5so21069837qvb.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 20:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oz1fQ07v4YKej2hlWP6qWEvyAtsuOx0qHOmBf6H8EEU=;
        b=I3TqNZ+omoMhei62DCjjFhvToBgLQ/mzKXtTiQk26/Z5mE9W3slhueOYb+z8GilAMC
         uJiJnXNo6zMWUJK5fxe8p2Clt0BrANXorqf5ejL3fjOyojaAeijiBitnGvTxkfmUvtk5
         Oo7NlfGIo6V3y/5pocLkkx6t8Ss8qBGDmgrARr+67qmzWEXVLYp/RFVVh/KoqwASWwPE
         LeSD+Oj61O/Z74sMssGhSL5Fu1c3GwuoL3JonPdkpa7ffE2p5AG02vHLj7jS4QiYw7q5
         cGhGmYlwlCMnZ+TzyelO2CkY4EzLolMoho7DCGot0I1FyuWa+tJ3zOEFil++xSYeEETq
         eZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oz1fQ07v4YKej2hlWP6qWEvyAtsuOx0qHOmBf6H8EEU=;
        b=WX729MNZd0k1DSy50AxMplnLqH7ea4+YkzOLx90jzIFtvUAVLexJleM9rtDiVqQha+
         KaMbUueYr4kg4hAY83DX85ebrcUP5mhkAEBZJ4i0QoewBuhveLKWFvGVo1GGVRJnjsPX
         mWWGIFpYxBF+Klp3vVmxGMdQU5lPvqR51I0CYiy7chFTXsBMArGsAgchfcWr9fmXneWs
         mNnxdfyQUPMvpN7vfkrDZfnv0iWKtOyFw3/9y5jq2QxIgryd4gF9XSu/dJBrMfDqbTv5
         WuLfdBpCLwOZIMlPkfYY8b0rmRSbPXvxUU890ivOlimiQRU14vAOI47QyjJxGtefj9Pm
         spCw==
X-Gm-Message-State: AGi0Pua0Vit+PHT4Nfj53g9FOwXyu+J6rv8pyT4tFbTrYRVNYvPaQ21O
        wdauRMO4tsEaLs+i/VwHojVmUDY+1A==
X-Google-Smtp-Source: APiQypJE2oducFJ7QqE/S1GqpExEa0j+XC+oVynygSXLNhNvPC4n0hoqiHIFqgoaUYcyeTNIUgqu5F2EbA==
X-Received: by 2002:a0c:8b48:: with SMTP id d8mr26408306qvc.195.1588044485433;
 Mon, 27 Apr 2020 20:28:05 -0700 (PDT)
Date:   Tue, 28 Apr 2020 05:27:42 +0200
In-Reply-To: <20200428032745.133556-1-jannh@google.com>
Message-Id: <20200428032745.133556-3-jannh@google.com>
Mime-Version: 1.0
References: <20200428032745.133556-1-jannh@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 2/5] coredump: Fix handling of partial writes in dump_emit()
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After a partial write, we have to update the input buffer pointer.

Fixes: 2507a4fbd48a ("make dump_emit() use vfs_write() instead of banging at ->f_op->write directly")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/coredump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 408418e6aa131..047f5a11dbee7 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -833,6 +833,7 @@ int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 		cprm->written += n;
 		cprm->pos += n;
 		nr -= n;
+		addr += n;
 	}
 	return 1;
 }
-- 
2.26.2.303.gf8c07b1a785-goog

