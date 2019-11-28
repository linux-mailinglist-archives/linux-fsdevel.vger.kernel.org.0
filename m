Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF37210CC52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 16:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfK1P7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 10:59:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57970 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726729AbfK1P7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574956791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YjAad0xTPYZMQK4+SFhaX2rD4NfE+U8u/1/zOVVncQQ=;
        b=VIHLCA+9oVXkZrTZpw1T67kG2X8eyeWKA4gBTx1F6slGeeHbjNxaTdHnsuGQ1GOXlzPRBc
        yJnIJAFVcICknA5IkPha/ederN7AFMGCHsaIrAcCM/qCIZaxj3Cy5jeMjmpnyhwq00zrKD
        b0i96a3mQLZHZPFv6lBheqgAVT9KJ/U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-p0Z6hHR9Nc-4ic_oV9vpCQ-1; Thu, 28 Nov 2019 10:59:50 -0500
Received: by mail-wr1-f71.google.com with SMTP id h30so463148wrh.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 07:59:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DR6cgU4eXMRJbinjgGr1odh7ZKMuSb0Fdk7Mm6wgT3U=;
        b=bczB7we/VCaIEqOSrpDCOhUhh4PenMjgyiNxbAIZKaas4SZczOhoLd4IotWTNP2WJX
         Mdy50gHWiVh6AdrOYXI6U8h6E66FRT93QMqmjf+IEATAojWc0EvWmprUejztyuTdAZGv
         w85ycEeFVbExUIYFRj8D9/nO8Upfe+sLRs4Q0ooZ8MfspquWr5YQokd1o+TPNYJa2NVJ
         Fqeo2bie185kZ3QP0me5Kjatm1yUCHgenu4Da5BEwF1JM9aHzBGVOjBk9lwJa+FP/o2e
         v62ZmquzWWDN0BZ9ns/f3qKnQF8gScn3MbF3VHcsiCd3EkTrehOqUC3IbV8rnxxjxkQD
         d3oQ==
X-Gm-Message-State: APjAAAU/zLB84UkYYGKpv+q7KfsJIqyHmZE6zFhVUYc0GvCJE7/OEm5H
        DMfT2gG+bPJ1KE2h+9JegdFOTDwNsO/OSmLN+/IH74Qu+4LJ5eOSmTvLIaTqEMsoadkL/LlMKoH
        nrpEvbP32+gu9hgoGsFTwNVmjig==
X-Received: by 2002:a05:600c:21c6:: with SMTP id x6mr9865933wmj.156.1574956789154;
        Thu, 28 Nov 2019 07:59:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqw9Ja5EmD8kfcoo8o1Dw+rBaxWXK7/AviWnaeBcvYyKsi/5kRC/jyE1eh1lVl5NtFHEYBdn+Q==
X-Received: by 2002:a05:600c:21c6:: with SMTP id x6mr9865922wmj.156.1574956788935;
        Thu, 28 Nov 2019 07:59:48 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 2sm23689474wrq.31.2019.11.28.07.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 07:59:48 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 05/12] statx: don't clear STATX_ATIME on SB_RDONLY
Date:   Thu, 28 Nov 2019 16:59:33 +0100
Message-Id: <20191128155940.17530-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128155940.17530-1-mszeredi@redhat.com>
References: <20191128155940.17530-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: p0Z6hHR9Nc-4ic_oV9vpCQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

IS_NOATIME(inode) is defined as __IS_FLG(inode, SB_RDONLY|SB_NOATIME), so
generic_fillattr() will clear STATX_ATIME from the result_mask if the super
block is marked read only.

This was probably not the intention, so fix to only clear STATX_ATIME if
the fs doesn't support atime at all.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Acked-by: David Howells <dhowells@redhat.com>
---
 fs/stat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index 7899d15722a0..fc49f705a83c 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -71,7 +71,8 @@ int vfs_getattr_nosec(const struct path *path, struct kst=
at *stat,
 =09query_flags &=3D KSTAT_QUERY_FLAGS;
=20
 =09/* allow the fs to override these if it really wants to */
-=09if (IS_NOATIME(inode))
+=09/* SB_NOATIME means filesystem supplies dummy atime value */
+=09if (inode->i_sb->s_flags & SB_NOATIME)
 =09=09stat->result_mask &=3D ~STATX_ATIME;
 =09if (IS_AUTOMOUNT(inode))
 =09=09stat->attributes |=3D STATX_ATTR_AUTOMOUNT;
--=20
2.21.0

