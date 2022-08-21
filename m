Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1648659B396
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Aug 2022 13:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiHULs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Aug 2022 07:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiHULsz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Aug 2022 07:48:55 -0400
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F44A19026;
        Sun, 21 Aug 2022 04:48:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1661082501; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=a6mvjVOBl8ChnzBxpui+qVndI/h3HGnpx16bhUNbBlOrv6Z8sMO+jghYzTS1p5ryAQe2KvZXtJ3rfnyzCzgha2ANxtZS79E85N9mCWfU2hjcySHoy7h3OEAzHXzK8BXyKGIfzsnehOqyf6OIHS+4yQ8GX3JAeit36DljlV8h9bM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1661082501; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=AwgN4RsZJTA9+iQk7/8UqzCd1O7MqN7cM+CxvUfw26E=; 
        b=C71iFaUNYsWoivWc9//6C7fKwUDTKxhw+sTJ1b6ww3UIrsuL5gSaMN/F+Opogy10uhzCdSuLJ3wVlk2e2Os6gXffeY5GeNnnKqLma5bCBuJd4wOfvF/w6mVegPmTJG7VywRSiPdE8pHvrog/XehsbjwQGwh1mDDaCweZnt+Vz8I=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1661082501;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=AwgN4RsZJTA9+iQk7/8UqzCd1O7MqN7cM+CxvUfw26E=;
        b=aRlO49NTaAJWJhgr67LQPL3GjwcBhrLc7M/r0WoO5Ds+sKDfKnpfwopBXNyVHvhX
        K1MY1nhYnlMpWNe6LZv9kemOcsz7NARqLH21hGZFH/qucpaFaAvGwJ+VlZGOc0QRWGb
        khp0PoWz7Ns7RYHNUcVaYnlpwjHq+nIoO6YHN5K0=
Received: from localhost.localdomain (43.250.157.244 [43.250.157.244]) by mx.zoho.in
        with SMTPS id 1661082500389589.0087066634392; Sun, 21 Aug 2022 17:18:20 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     code@siddh.me
Cc:     david@fromorbit.com, djwong@kernel.org, fgheet255t@gmail.com,
        hch@infradead.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, riteshh@linux.ibm.com,
        syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Message-ID: <20220821114816.24193-1-code@siddh.me>
Subject: Re: [syzbot] WARNING in iomap_iter
Date:   Sun, 21 Aug 2022 17:18:16 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <182c028abf0.2dc6f7c973088.2963173753499991828@siddh.me>
References: <182c028abf0.2dc6f7c973088.2963173753499991828@siddh.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master

---
 drivers/block/loop.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e3c0ba93c1a3..a3d9af0a2077 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -979,9 +979,15 @@ loop_set_status_from_info(struct loop_device *lo,
=20
 =09lo->lo_offset =3D info->lo_offset;
 =09lo->lo_sizelimit =3D info->lo_sizelimit;
+=09lo->lo_flags =3D info->lo_flags;
+
+=09/* loff_t/int vars are assigned __u64/__u32 vars (respectively) */
+=09if (lo->lo_offset < 0 || lo->lo_sizelimit < 0 || lo->lo_flags < 0)
+=09=09return -EOVERFLOW;
+
 =09memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 =09lo->lo_file_name[LO_NAME_SIZE-1] =3D 0;
-=09lo->lo_flags =3D info->lo_flags;
+
 =09return 0;
 }
=20
--=20
2.35.1


