Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94F28F71FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 11:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfKKK3a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 05:29:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49666 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726923AbfKKK31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573468166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pcVRVS2wigfNxAtSVYLPPaPRSK4c2t19oDRB3orBUZ8=;
        b=Qu8oR+yS+SqKnZKhq7MLdSGa7rTRFICVguQD0H8Odfe6wr9GUAVwXwMnBOJSX7jzKbEi5o
        gzUH6SjKbp9xeBjhAjRy6mERaKnfY9eSs1cQBcUOMDvMOm6UcGlBD92+7O6wB8xKtXIHXA
        ZrAYGJhK0OkDbK4QJiUdDjUt72GFF2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-z809MnJvNym6fsK2ylp1rQ-1; Mon, 11 Nov 2019 05:29:23 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 531491005500;
        Mon, 11 Nov 2019 10:29:21 +0000 (UTC)
Received: from dustball.usersys.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 640765D6A3;
        Mon, 11 Nov 2019 10:29:18 +0000 (UTC)
From:   Jan Stancek <jstancek@redhat.com>
To:     darrick.wong@oracle.com, naresh.kamboju@linaro.org,
        hch@infradead.org
Cc:     ltp@lists.linux.it, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, chrubis@suse.cz,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        broonie@kernel.org, arnd@arndb.de, lkft-triage@lists.linaro.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu, jstancek@redhat.com
Subject: [PATCH] iomap: fix return value of iomap_dio_bio_actor on 32bit systems
Date:   Mon, 11 Nov 2019 11:28:10 +0100
Message-Id: <b757ff64ddf68519fc3d55b66fcd8a1d4b436395.1573467154.git.jstancek@redhat.com>
In-Reply-To: <20191111083815.GA29540@infradead.org>
References: <20191111083815.GA29540@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: z809MnJvNym6fsK2ylp1rQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Naresh reported LTP diotest4 failing for 32bit x86 and arm -next
kernels on ext4. Same problem exists in 5.4-rc7 on xfs.

The failure comes down to:
  openat(AT_FDCWD, "testdata-4.5918", O_RDWR|O_DIRECT) =3D 4
  mmap2(NULL, 4096, PROT_READ, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0xb7f7=
b000
  read(4, 0xb7f7b000, 4096)              =3D 0 // expects -EFAULT

Problem is conversion at iomap_dio_bio_actor() return. Ternary
operator has a return type and an attempt is made to convert each
of operands to the type of the other. In this case "ret" (int)
is converted to type of "copied" (unsigned long). Both have size
of 4 bytes:
    size_t copied =3D 0;
    int ret =3D -14;
    long long actor_ret =3D copied ? copied : ret;

    On x86_64: actor_ret =3D=3D -14;
    On x86   : actor_ret =3D=3D 4294967282

Replace ternary operator with 2 return statements to avoid this
unwanted conversion.

Fixes: 4721a6010990 ("iomap: dio data corruption and spurious errors when p=
ipes fill")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 fs/iomap/direct-io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 1fc28c2da279..7c58f51d7da7 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -318,7 +318,9 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 =09=09if (pad)
 =09=09=09iomap_dio_zero(dio, iomap, pos, fs_block_size - pad);
 =09}
-=09return copied ? copied : ret;
+=09if (copied)
+=09=09return copied;
+=09return ret;
 }
=20
 static loff_t
--=20
1.8.3.1

