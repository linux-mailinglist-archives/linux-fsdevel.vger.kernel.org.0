Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD0B59821A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 13:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244374AbiHRLQz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 07:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiHRLQy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:16:54 -0400
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892A8AE228
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 04:16:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1660820437; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=BTMANjpPQ649xN1Ilw1xe5PDp07xqQayiOObxnMnehCh0whAnkBvvKzF96CLAtFZp4YQ8ODaEjbyfxO+8O3f/gIsCrn3d6QS0J7Ec5vbrkdOL7AdTYuhDWEn0Ytbzy53JRClJKXWGM2IHiZXzEaVpHOx4vYLVjY+pkiYXP8DU0I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1660820437; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=w3q3/luKQmtc+VjV/Gf2sz+X/or73ffditweh+vTyCw=; 
        b=RmUvCSOkclpZwMa6RoA6xFuaJBY/zqVsEm+96Q2v/o3+19cq7Jj+Cy1SOxYqBYt1p7y89zQmwA8ZtL63NN/GcveCbgYuiP+CjjbGq4SzrNz3Eff23eS6+YvUPTXaFpKSL3LcUceRTPAPCWioyQMgL5PvnmFoIk9DH7SRFqhNRho=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1660820437;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=w3q3/luKQmtc+VjV/Gf2sz+X/or73ffditweh+vTyCw=;
        b=IPmmJF2k6/1SqT02GUNG6cNF9PRrVOBVauI7Gxr3vl6IzUfgHFmetHP6xEJSEs+f
        UTnuUpVVI0CfxUgWtgfQkowITG0Lu07mgkTl5c/ddZaVDBGWcELlHyYMeBgo7rIUoqi
        U2aUCQNU7weOGb/EPhCeuYwTPXiR65CFg0+dX/NQ=
Received: from localhost.localdomain (103.86.19.2 [103.86.19.2]) by mx.zoho.in
        with SMTPS id 1660820435766507.18754371954867; Thu, 18 Aug 2022 16:30:35 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     david@fromorbit.com
Cc:     djwong@kernel.org, fgheet255t@gmail.com, hch@infradead.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        riteshh@linux.ibm.com,
        syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Message-ID: <20220818110031.89467-1-code@siddh.me>
Subject: Re: [syzbot] WARNING in iomap_iter
Date:   Thu, 18 Aug 2022 16:30:31 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220214025849.GP59729@dread.disaster.area>
References: <20220214025849.GP59729@dread.disaster.area>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is probably due to mismatch in types between userspace API struct
and the kernel's internal struct, which leads to offset being overflowed
after getting converted from __u64 (unsigned long long) to loff_t (signed
long long), resulting in ridiculously negative offset value.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master

---
 include/uapi/linux/loop.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
index 6f63527dd2ed..33c07c467da4 100644
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
+=09__s64=09=09   lo_sizelimit;=09/* bytes, 0 =3D=3D max available */
+=09__s32=09=09   lo_number;=09=09=09/* ioctl r/o */
+=09__s32=09=09   lo_encrypt_type;=09=09/* obsolete, ignored */
+=09__s32=09=09   lo_encrypt_key_size;=09=09/* ioctl w/o */
+=09__s32=09=09   lo_flags;
 =09__u8=09=09   lo_file_name[LO_NAME_SIZE];
 =09__u8=09=09   lo_crypt_name[LO_NAME_SIZE];
 =09__u8=09=09   lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
--=20
2.35.1


