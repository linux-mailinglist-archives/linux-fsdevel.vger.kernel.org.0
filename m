Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2EF59EA02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 19:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiHWRnX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 13:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiHWRmw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:42:52 -0400
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654B29E697;
        Tue, 23 Aug 2022 08:36:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1661268948; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=eagV3hFkZYnwbakrbXhtc9g3aO1gVBHqpu49XGBsd3+riRGCjc1oktdH+w7r4IbYLLIVVQi1HljbXyXp/jCzh7pncfWAjTtGq1QUmLsFPvlH+TPR0Qitado+YS4+REvYsCUrZ3N+ZFDEC6R9QUXA1gYCrecZS/VJIA7cMRgzpRI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1661268948; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=48lrmCnAI4BOdsVRvDHdoRgNfI9n5wEdayysaFK+3kw=; 
        b=dcXD5TxeXwwuSU4lCx5knnXQi3YYxBXdqNMZ1FEYGJ0RJFARdapUM9ThPe8Ra+P8ShAm8l94E2SncPcW2iTtlh1N1LWRSGu7bQssYKiOGZhdqTjv5TZqIoQUMttsWm+TVVn4eFTZOKGm8ExuQfgN7qxTwpZPPfoS3RuYSSSA9mg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1661268948;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=48lrmCnAI4BOdsVRvDHdoRgNfI9n5wEdayysaFK+3kw=;
        b=Lj9kFMfAziwo1q654cN0YK+O2sMEGsVXCZzKujidPyswNAmPuVfgHRWm3aTBi+7T
        XzUV4DySRehhXIf3yV1BM5TXdx+S8MyfZUt7813tUg+gn49Rj9dbjDRGI5xI23Z7lFq
        djguecRrI4L/ogPprIO9/E4slDxNGdtxb79m6yuk=
Received: from localhost.localdomain (103.249.234.81 [103.249.234.81]) by mx.zoho.in
        with SMTPS id 1661268946863160.31652801965868; Tue, 23 Aug 2022 21:05:46 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     willy@infradead.org
Cc:     code@siddh.me, david@fromorbit.com, djwong@kernel.org,
        fgheet255t@gmail.com, hch@infradead.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        riteshh@linux.ibm.com,
        syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Message-ID: <20220823153542.177799-1-code@siddh.me>
Subject: Re: [syzbot] WARNING in iomap_iter
Date:   Tue, 23 Aug 2022 21:05:42 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YwTyO0yZmUT1MVZW@casper.infradead.org>
References: <YwTyO0yZmUT1MVZW@casper.infradead.org>
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

Oof, I didn't mean it to be there. That would actually be wrong anyways.

Extremely sorry for the avoidable oversight,
Siddh

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master

---
 drivers/block/loop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e3c0ba93c1a3..e1fe8eda020f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -979,6 +979,11 @@ loop_set_status_from_info(struct loop_device *lo,
=20
 =09lo->lo_offset =3D info->lo_offset;
 =09lo->lo_sizelimit =3D info->lo_sizelimit;
+
+=09/* loff_t vars have been assigned __u64 */
+=09if (lo->lo_offset < 0 || lo->lo_sizelimit < 0)
+=09=09return -EOVERFLOW;
+
 =09memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 =09lo->lo_file_name[LO_NAME_SIZE-1] =3D 0;
 =09lo->lo_flags =3D info->lo_flags;
--=20
2.35.1


