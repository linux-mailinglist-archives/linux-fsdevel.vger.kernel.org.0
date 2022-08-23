Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC9459E9C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 19:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiHWRhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 13:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiHWRhL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:37:11 -0400
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E6C844DA;
        Tue, 23 Aug 2022 08:21:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1661268069; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=A8R8WP4pX54ShsjmNzGakU44eL/5AJc9TPNKzOiMEVAnU3l9xngOjxB4jdeZvShYmcZ/g/PCyMI9mjFFJaulybsx6frGRyastXKZMkyWcv4BppV/aXlpxe8Xq/ntH4RAhTaGamPJ4CLMhUjrQzuI+6ob4XkHl7tFNcUqN9LzeXk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1661268069; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=dDz9V3Znq8yZ15TOlRARYvw+VZde7mrsNRQSC5a6arE=; 
        b=TyrWcohKxMEsCxq2x395JALlX8+ubeLUlMXVbZ3lrWH2eTjl1hvridLouQZzuRLNo87xO1yyfVSQozPJE+CKLWbDQuIAb/Vbk5twbISQWFNvBHNkrAMiEHHxMA5FYILQaUfIuJbeCIcqfhrj5/Kw4i2qimNtMT+DNmdwJo2QinU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1661268069;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=dDz9V3Znq8yZ15TOlRARYvw+VZde7mrsNRQSC5a6arE=;
        b=OwGrEVfSBRHeToglwMkvZuq9ze9Cid6OCQKcqaorKTt3zP4y9ICKnWWRhmJHxUEN
        IsQ0Gbp+L63Se8YfpcPrG9c0A7qJt60yYHtqxXztzHb4T+QzN2StURUL0jN9slXQ3BL
        IEWBzERqgGJrKuPq1qD6gjsR8suM4oCrFntM7dAg=
Received: from localhost.localdomain (103.249.234.81 [103.249.234.81]) by mx.zoho.in
        with SMTPS id 1661268067258201.55463256934252; Tue, 23 Aug 2022 20:51:07 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     code@siddh.me
Cc:     david@fromorbit.com, djwong@kernel.org, fgheet255t@gmail.com,
        hch@infradead.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, riteshh@linux.ibm.com,
        syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Message-ID: <20220823152101.165538-1-code@siddh.me>
Subject: Re: [syzbot] WARNING in iomap_iter
Date:   Tue, 23 Aug 2022 20:51:01 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <182c6137693.20a934d213186.5712495322312393662@siddh.me>
References: <182c6137693.20a934d213186.5712495322312393662@siddh.me>
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
+=09if (lo->lo_offset < 0 || lo->lo_sizelimit < 0 || lo->lo_flags < 0)
+=09=09return -EOVERFLOW;
+
 =09memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 =09lo->lo_file_name[LO_NAME_SIZE-1] =3D 0;
 =09lo->lo_flags =3D info->lo_flags;
--=20
2.35.1


