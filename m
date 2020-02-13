Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4501C15CC5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 21:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgBMUYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 15:24:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41007 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727938AbgBMUYr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581625486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6WdwOaFsdBeuYn31kmg4N/dXknKYxiAKpK/9IIYLyZQ=;
        b=AP3RRSaInbTfUSsiEznCvxbypgdUalomcmk8DiMZxpRgy1x7E+GhKcialaIZ9XP2fQlqyq
        tIoWjWMwfYdskd/MXgSJ56B9NMDIyfnSeHDoabjcBxHdrwZPR2wRar15jDb1OY+O5BDyFJ
        tDpZ6nKu9vby15aLkQE2ttTtNmIiRA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-YRPQlKgDMoStszn5XUaf1w-1; Thu, 13 Feb 2020 15:24:44 -0500
X-MC-Unique: YRPQlKgDMoStszn5XUaf1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 363BF8017CC;
        Thu, 13 Feb 2020 20:24:43 +0000 (UTC)
Received: from max.home.com (ovpn-204-60.brq.redhat.com [10.40.204.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38C221001B0B;
        Thu, 13 Feb 2020 20:24:41 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 6/7] ceph: Switch to page_mkwrite_check_truncate in ceph_page_mkwrite
Date:   Thu, 13 Feb 2020 21:24:22 +0100
Message-Id: <20200213202423.23455-7-agruenba@redhat.com>
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
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 7ab616601141..ef958aa4adb4 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1575,7 +1575,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault=
 *vmf)
 	do {
 		lock_page(page);
=20
-		if ((off > size) || (page->mapping !=3D inode->i_mapping)) {
+		if (page_mkwrite_check_truncate(page, inode) < 0) {
 			unlock_page(page);
 			ret =3D VM_FAULT_NOPAGE;
 			break;
--=20
2.24.1

