Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1F4542409
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 08:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiFHEbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 00:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiFHEa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:30:29 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4A439B22C
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 19:05:40 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220608020504epoutp02467a41a1955fbe252a7933f2661c70d2~2gvWR89-E2168421684epoutp02M
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 02:05:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220608020504epoutp02467a41a1955fbe252a7933f2661c70d2~2gvWR89-E2168421684epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654653904;
        bh=zV++LEuLCtfADlbIL+S4XEKvrkR3B7fzf/3W6WqqlXE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=KE6nOKFRTAXVoN5bXm/k0P67vdubXxge6WUdNMYa4U+cPuzNvWvmoZfyMKRsGSQa9
         XNN6PGbJk4nuFeeN3RssUSudl1XngBUSSC83dWDI7I/+IBsWdbKV06bYC3IFD342Me
         54tIPH25LPhnA6WCtY5tEn5iFYgOfA//vk+i+W9U=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220608020503epcas1p453af091c62ceca012d5725ee44685fd9~2gvV6E_7r0582005820epcas1p4Q;
        Wed,  8 Jun 2022 02:05:03 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.243]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LHrCM0rfNz4x9Q9; Wed,  8 Jun
        2022 02:05:03 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.6C.10063.EC300A26; Wed,  8 Jun 2022 11:05:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220608020502epcas1p14911cac6731ee98fcb9c64282455caf7~2gvUqFrRa3160731607epcas1p1q;
        Wed,  8 Jun 2022 02:05:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220608020502epsmtrp27109742c01b157316f7169686850bf9b~2gvUpDv7O0065500655epsmtrp2k;
        Wed,  8 Jun 2022 02:05:02 +0000 (GMT)
X-AuditID: b6c32a35-1dbff7000000274f-95-62a003ce46dc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.66.11276.EC300A26; Wed,  8 Jun 2022 11:05:02 +0900 (KST)
Received: from U20PB1-0435.tn.corp.samsungelectronics.net (unknown
        [10.91.133.14]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220608020502epsmtip175c4ee626a432d6f06729d48657aa8e2~2gvUc6E5Q2678226782epsmtip1e;
        Wed,  8 Jun 2022 02:05:02 +0000 (GMT)
From:   Sungjong Seo <sj1557.seo@samsung.com>
To:     linkinjeon@kernel.org
Cc:     sj1557.seo@samsung.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] exfat: use updated exfat_chain directly during renaming
Date:   Wed,  8 Jun 2022 11:04:08 +0900
Message-Id: <20220608020408.2351676-1-sj1557.seo@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmge555gVJBq/FLCZOW8pssWfvSRaL
        y7vmsFls+XeE1YHFY9OqTjaPvi2rGD0+b5ILYI5qYLRJLErOyCxLVUjNS85PycxLt1UKDXHT
        tVBSyMgvLrFVijY0NNIzNDDXMzIy0jO2jLUyMlVSyEvMTbVVqtCF6lVSKEouAKrNrSwGGpCT
        qgcV1ytOzUtxyMovBblQrzgxt7g0L10vOT9XSaEsMacUaISSfsI3xoym599YCjbyVixbPZOt
        gXE6dxcjJ4eEgInE+cYt7F2MXBxCAjsYJW7OmADlfGKUWLXnBRuE841R4s+NJkaYll9L5jCB
        2EICexklls5jhihqZ5L4fayJDSTBJqAtsbxpGVCCg0NEQFJi7f1UkDCzQKTE5IuL2UFsYQEP
        iY3P/4LZLAKqErO6DoLZvAK2EpuuzGSG2CUvMfPSd6i4oMTJmU9YIObISzRvnQ22V0JgFbvE
        8aeL2EB2SQi4SMxeZwrRKyzx6vgWdghbSuLzu71sEHYzo0RzoxGE3cEo8XSjLESrvcT7SxYg
        JrOApsT6XfoQFYoSO3/PhfpcUOL0tW5miAv4JN597WGF6OSV6GgTgihRkfj+YScLzNIrP64y
        QdgeEjuXXmaBBFqsxJXfq5gnMCrMQvLXLCR/zUI4YgEj8ypGsdSC4tz01GLDAkPkCN7ECE6P
        WqY7GCe+/aB3iJGJg/EQowQHs5IIr2T4/CQh3pTEyqrUovz4otKc1OJDjMnAkJ7ILCWanA9M
        0Hkl8YYmxgYGRsB0Z25pbkyEsKWBiZmRiYWxpbGZkjjvqmmnE4UE0hNLUrNTUwtSi2C2MHFw
        SjUwLbj8NypBa5It253NLHeEmBX3fn/waCfb5Mlu1j/09r9ucb289OvNXTzJb//bnAtVjFSe
        W/VNQdLypsZ0d+6dHBqVTMm/N85Z3t1mebCD79bF62FVvu28e32nLdrnbblv6fpE618WKwOT
        r0lNuPBO3VK57j5vJasGu/rrtfYSgrt/z7zaHKbDrKP/NqlN5f6vu58yNstd/Pj9+dnb1nn+
        J03O+c1LLSjkfLnuQVjgUsFtFeUuzkcZvzQ4tExY7KjVbMgxU9S2K/Htqes6Mj17dPgFX99d
        aNp3w2mTuZ4JY+eqXyWzjixgu7t9w1mxGIaaNW9PVsoVzlsZfEbK9cy+fT563JMf7o0Nb9A8
        KxsdpMRSnJFoqMVcVJwIAGpvhhRGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsWy7bCSnO455gVJBvc3SltMnLaU2WLP3pMs
        Fpd3zWGz2PLvCKsDi8emVZ1sHn1bVjF6fN4kF8AcxWWTkpqTWZZapG+XwJXR9PwbS8FG3opl
        q2eyNTBO5+5i5OSQEDCR+LVkDlMXIxeHkMBuRolHO9vZuhg5gBJSEgf3aUKYwhKHDxdDlLQy
        SZz9eIkdpJdNQFtiedMyZpAaEQFJibX3U0HCzALREk1//jKC2MICHhIbn/8FK2cRUJWY1XUQ
        zOYVsJXYdGUmM8QJ8hIzL32HigtKnJz5hAVijrxE89bZzBMY+WYhSc1CklrAyLSKUTK1oDg3
        PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM43LQ0dzBuX/VB7xAjEwfjIUYJDmYlEV7J8PlJQrwp
        iZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTDVLj9xu/Sibffs
        xSWMfbuyDryYpuXxmT07QeRNbAinhOklj/Ls48cf/uDhaPDednrD+5jGmo6339YZrP3nMNPy
        CFNuQZPjjen9x1bJ/t6v++rlxfjrnXfCtu86cKTu0j/ukkvl6SKLpv/lvNngtHiK0Id1x9/8
        jyr5o7tbWZHfXjYnK+plwDrzvluOvPenz0w+vqlkudjP5juPPvat9OdpORa7zkH5kabAI2Up
        R0Wth1P5XAVWOc5avjBph8UtuQXn9Pa/Y3556naJWK3w/eMT5dsf+3DwHM7gUZ90tPbp8Xe7
        wgWuc1XH6csER2sFBUeKMU/icbhaJX+p3GfCyrW/moq7vm/pLty4RZ3/46KFSizFGYmGWsxF
        xYkAB1lNpqYCAAA=
X-CMS-MailID: 20220608020502epcas1p14911cac6731ee98fcb9c64282455caf7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220608020502epcas1p14911cac6731ee98fcb9c64282455caf7
References: <CGME20220608020502epcas1p14911cac6731ee98fcb9c64282455caf7@epcas1p1.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order for a file to access its own directory entry set,
exfat_inode_info(ei) has two copied values. One is ei->dir, which is
a snapshot of exfat_chain of the parent directory, and the other is
ei->entry, which is the offset of the start of the directory entry set
in the parent directory.

Since the parent directory can be updated after the snapshot point,
it should be used only for accessing one's own directory entry set.

However, as of now, during renaming, it could try to traverse or to
allocate clusters via snapshot values, it does not make sense.

This potential problem has been revealed when exfat_update_parent_info()
was removed by commit d8dad2588add ("exfat: fix referencing wrong parent
directory information after renaming"). However, I don't think it's good
idea to bring exfat_update_parent_info() back.

Instead, let's use the updated exfat_chain of parent directory diectly.

Fixes: d8dad2588add ("exfat: fix referencing wrong parent directory information after renaming")

Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/namei.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 76acc3721951..c6eaf7e9ea74 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1198,7 +1198,9 @@ static int __exfat_rename(struct inode *old_parent_inode,
 		return -ENOENT;
 	}
 
-	exfat_chain_dup(&olddir, &ei->dir);
+	exfat_chain_set(&olddir, EXFAT_I(old_parent_inode)->start_clu,
+		EXFAT_B_TO_CLU_ROUND_UP(i_size_read(old_parent_inode), sbi),
+		EXFAT_I(old_parent_inode)->flags);
 	dentry = ei->entry;
 
 	ep = exfat_get_dentry(sb, &olddir, dentry, &old_bh);
-- 
2.25.1

