Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2202F5981FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 13:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244303AbiHRLMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 07:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243897AbiHRLL6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:11:58 -0400
X-Greylist: delayed 628 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 Aug 2022 04:11:56 PDT
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F723A5C57;
        Thu, 18 Aug 2022 04:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1660821087; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=CK+0SxAcSS6Nr2B+ne/H3MWMkiC1taz5FsR2IymBmR8eHwRqr05o0KleO6clc2g4+a3vA6Zzp0qzSSLFgkTEfOtxwzREBNj3B7ecpPEgkErCgWjW8l8NhIoGI8u8G3xNY70IHPLSIkxHUX2PCZ2OHFm4dLDodpL7wv/5rqLMiSI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1660821087; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=y+G1krJ8CXTDXn6qZTth7DCyPot/zzg8W1f8MXUNSdI=; 
        b=BXEIBvr6GH4KJjl0jR0jZsY34OPzAV5c1XD2B8yOlA0omfCOGEpZzyZDUV4fwxXBac7gZmZbAJH4qUC0wkmtz5H37DAo+maxpr6oqzKxsIxyw1tZ4qBF3pizqGQCxq6uVpDPJIk8ofrK7+WDa+hMbzvo0Mur7wSzVxSRpq6bJ3g=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1660821087;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=y+G1krJ8CXTDXn6qZTth7DCyPot/zzg8W1f8MXUNSdI=;
        b=OdpzWta8ueF1lTahkP72qgf9IErRfIuKV/RyxF+9g476kcZEaCJRCnAHaFlUf4Cc
        SP3OVYaWI0Ku5SZz+3lTwVgXDYiK5F00aqFFKFqvsBrLRR/d1TdJH/6fh/j/jYucXNz
        ppnU/TUKtsECR9TfMsnP7stYhGQn7C96AQJ3RjsA=
Received: from localhost.localdomain (103.86.19.2 [103.86.19.2]) by mx.zoho.in
        with SMTPS id 166082108572024.568604130410563; Thu, 18 Aug 2022 16:41:25 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     code@siddh.me
Cc:     david@fromorbit.com, djwong@kernel.org, fgheet255t@gmail.com,
        hch@infradead.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, riteshh@linux.ibm.com,
        syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Message-ID: <20220818111117.102681-1-code@siddh.me>
Subject: Re: [syzbot] WARNING in iomap_iter
Date:   Thu, 18 Aug 2022 16:41:17 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818110031.89467-1-code@siddh.me>
References: <20220818110031.89467-1-code@siddh.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The last test patch accidentally left out less-than-zero checks...

Is there a way to cancel previously requested tests?

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master

---
 drivers/block/loop.c      |  3 +++
 include/uapi/linux/loop.h | 12 ++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e3c0ba93c1a3..4ca20ce3158d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -977,6 +977,9 @@ loop_set_status_from_info(struct loop_device *lo,
 =09=09return -EINVAL;
 =09}
=20
+=09if (info->lo_offset < 0 || info->lo_sizelimit < 0)
+=09=09return -EINVAL;
+
 =09lo->lo_offset =3D info->lo_offset;
 =09lo->lo_sizelimit =3D info->lo_sizelimit;
 =09memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
index 6f63527dd2ed..973565f38f9d 100644
--- a/include/uapi/linux/loop.h
+++ b/include/uapi/linux/loop.h
@@ -53,12 +53,12 @@ struct loop_info64 {
 =09__u64=09=09   lo_device;=09=09=09/* ioctl r/o */
 =09__u64=09=09   lo_inode;=09=09=09/* ioctl r/o */
 =09__u64=09=09   lo_rdevice;=09=09=09/* ioctl r/o */
-=09__u64=09=09   lo_offset;
-=09__u64=09=09   lo_sizelimit;/* bytes, 0 =3D=3D max available */
-=09__u32=09=09   lo_number;=09=09=09/* ioctl r/o */
-=09__u32=09=09   lo_encrypt_type;=09=09/* obsolete, ignored */
-=09__u32=09=09   lo_encrypt_key_size;=09=09/* ioctl w/o */
-=09__u32=09=09   lo_flags;
+=09__s64=09=09   lo_offset;
+=09__s64=09=09   lo_sizelimit;/* bytes, 0 =3D=3D max available */
+=09__s32=09=09   lo_number;=09=09=09/* ioctl r/o */
+=09__s32=09=09   lo_encrypt_type;=09=09/* obsolete, ignored */
+=09__s32=09=09   lo_encrypt_key_size;=09=09/* ioctl w/o */
+=09__s32=09=09   lo_flags;
 =09__u8=09=09   lo_file_name[LO_NAME_SIZE];
 =09__u8=09=09   lo_crypt_name[LO_NAME_SIZE];
 =09__u8=09=09   lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
--=20
2.35.1


