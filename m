Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF14D15CC58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 21:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgBMUYk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 15:24:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47285 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727926AbgBMUYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581625479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t3/PicjsaEbx6Lq+NpmHhZDHuMbNepYoytXnxjT+hNw=;
        b=J/xg7fxBKUDc90eso2vGqGJo5n0PvmEA4AxPTv5xj1+7kyx70JLii3w7GFVFsDxclB1aPT
        OW9/vBZam0+5+erIAeiTJP1RDukzZykbKfnVTrpkFGMSM+Wx+miTZ3AWBvVCh65viTMZQV
        RcO5s4stdd0Q0G6m01jwRr3e4gXmssE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-8JzXEXabPfuHrPxlqbM6VQ-1; Thu, 13 Feb 2020 15:24:37 -0500
X-MC-Unique: 8JzXEXabPfuHrPxlqbM6VQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C941013E4;
        Thu, 13 Feb 2020 20:24:35 +0000 (UTC)
Received: from max.home.com (ovpn-204-60.brq.redhat.com [10.40.204.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB52B100032E;
        Thu, 13 Feb 2020 20:24:33 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 3/7] ubifs: Switch to page_mkwrite_check_truncate in ubifs_vm_page_mkwrite
Date:   Thu, 13 Feb 2020 21:24:19 +0100
Message-Id: <20200213202423.23455-4-agruenba@redhat.com>
In-Reply-To: <20200213202423.23455-1-agruenba@redhat.com>
References: <20200213202423.23455-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the "page has been truncated" logic in page_mkwrite_check_truncate
instead of reimplementing it here.  Other than with the existing code,
fail with -EFAULT / VM_FAULT_NOPAGE when page_offset(page) =3D=3D size he=
re
as well, as should be expected.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Acked-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 743928efffc1..395ff2081ecb 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1559,8 +1559,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_f=
ault *vmf)
 	}
=20
 	lock_page(page);
-	if (unlikely(page->mapping !=3D inode->i_mapping ||
-		     page_offset(page) > i_size_read(inode))) {
+	if (unlikely(page_mkwrite_check_truncate(page, inode) < 0)) {
 		/* Page got truncated out from underneath us */
 		goto sigbus;
 	}
--=20
2.24.1

