Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3545A635038
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 07:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbiKWGOU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 01:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiKWGNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 01:13:50 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235FFF3939
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 22:13:47 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221123061345epoutp0237f94d15a1b5a38f8611adb8ce228524~qIgcSsn_91913519135epoutp02W
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 06:13:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221123061345epoutp0237f94d15a1b5a38f8611adb8ce228524~qIgcSsn_91913519135epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669184025;
        bh=5O5uDT9HWnn4Ccadtd7fTCupkIwM/OnWfdBNErBUieg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+Mp0uJ/u1QezkgGdk6cxZ6zr6/HgR++wRRwC4b22S7PuLmdEvzQBaNJ9o6OQJsMc
         I2oZOaIoaZ6m0Q13tWZ+zKnsNw15pxba+7UP3GwStQYKquOOme3zv7G8MQm9l2kNDI
         UtA58eDXJnUCjrBR2F8T98bL2575T+9iEbz0u7SM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221123061342epcas5p119115974f34a518d3b83d7dabac38e90~qIgZzf6Yo2805328053epcas5p1S;
        Wed, 23 Nov 2022 06:13:42 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NH9mh4966z4x9Pp; Wed, 23 Nov
        2022 06:13:40 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.91.01710.41ABD736; Wed, 23 Nov 2022 15:13:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221123061037epcas5p4d57436204fbe0065819b156eeeddbfac~qIdtZjzIm1387613876epcas5p4L;
        Wed, 23 Nov 2022 06:10:37 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221123061037epsmtrp29863525cb7f744d91a2508cf38d69191~qIdtYR1U20473504735epsmtrp2Q;
        Wed, 23 Nov 2022 06:10:37 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-f4-637dba14c7fb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.C2.18644.D59BD736; Wed, 23 Nov 2022 15:10:37 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221123061034epsmtip15ed7fc7e8497363a6f994535aa0d13b8~qIdqfGl_e2064620646epsmtip1F;
        Wed, 23 Nov 2022 06:10:34 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, james.smart@broadcom.com, kch@nvidia.com,
        damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH v5 08/10] dm: Enable copy offload for dm-linear target
Date:   Wed, 23 Nov 2022 11:28:25 +0530
Message-Id: <20221123055827.26996-9-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20221123055827.26996-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxTPvbf3tsVVLoXNj7JH6caMMGjLCvtwgIsyvOwVpskeGoNNuaFI
        X2nLAOOgFRiCEcTBhPIQxjTjEQgFFMuKFUSEiWQ6MOJ4jAGLIEVgT5GxlsLmf7/z+875nfM7
        Xw4L4+YyeaxElZ7WqqQKAeHGuNi9Y3ugl+VzmSjT4A6b+q9j8PjpVQzWjxYQcGVgEINWexkO
        79kuo7C2vgeFHdWLKOxZmyfgz7+NMOCZrmEETg+ZUGgdCYDfWfsY8I6lnIDnLkwzYWFvCw7b
        p4wIvLhyDoPL57OYsHFugQFvjPjAwdVe/K1tlGl8gKAum0aZ1OBYM4O6M5BMmetyCarlmwyq
        456BoE5l2h0J2eM4tdA5RFD5rXUItWx+kcqxnUQp89Q8Grv1QFK4nJbG01o+rZKp4xNVCRGC
        d/fH7YkLCRWJA8Vh8A0BXyVV0hGCqPdiA6MTFQ7/Av5nUkWyg4qV6nQCYWS4Vp2sp/lytU4f
        IaA18QqNRBOkkyp1yaqEIBWt3ykWiYJDHImHk+TGkuuIxoinXrpZgRuQEkYewmYBUgJuNZSj
        eYgbi0t2IOC2sRFzBUsIONMyvBEsI6Dh61lis6Rybg53Yi5pQcDMWrgrKRsFkzUPHFosFkEG
        gO/XWE7ei8xHwYkO27oSRpahYP7CE6az2pOMBtfGf1/HDNIPfNnyI+rEHHInOL9UhjuFACkE
        BeMeTppNvglu/mDZSPEAfaVT6x4w8iWQ2Va2rg/IGjYoauvBXZNGgYnF4xtTe4LZ3lamC/PA
        st26waeA2qJvCVdxFgJMd02I62EXyO4vwJxDYOQO0GQRuugXQHF/I+pqvBWcWplCXTwHtFdu
        4pdBQ1PVhr43GP7TSLi8UGDWoHQtKx8BkzlWxmmEb3rKj+kpP6b/O1chWB3iTWt0ygRaF6IR
        q+iU/35ZplaakfWb8I9pR0YnHgV1ISgL6UIACxN4cTJijsm4nHhp2lFaq47TJitoXRcS4th3
        IcZ7VqZ2HJVKHyeWhIkkoaGhkrDXQ8WCbZyaEn8Zl0yQ6ukkmtbQ2s06lMXmGVB22dkjtm5F
        Sv61Q/uqH6W83fdx7T57fae5+uhVn7vuYQrLJ1EJnelVlfb7bqk9B/OQZ9Jq5JO322fltSJe
        L/638pXyZt9Dxy51jcFdnKU/Sua+EuNKnwKD/ie/Ex+Wyh9WZD3ss0VHbk9leMyk+/r/82qG
        xC99y2KFsptbUf6a98m5ogOh7xcWHzZd+eUvLne/Kjv3oPGDq8F7mEd2C0frPI1e3tHmvQH3
        hb5euL9xiP5osNR3UcBWjc12GwKsONDe4sRIg5M67Y8T03Ju6J78ij0XGNXa31wcEQ2iCvgz
        W4RX3G22yOkHvBh+yTsLEZ9Kvmizn82fKNz7eCCQYXl+NU7A0MmlYn9Mq5P+C5JtjUecBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCSnG7sztpkg1NbDSzWnzrGbNE04S+z
        xeq7/WwWv8+eZ7bY+242q8XNAzuZLFauPspksXvhRyaLo//fslk8/HKLxWLSoWuMFk+vzmKy
        2HtL22LP3pMsFpd3zWGzmL/sKbvFxOObWS12PGlktNj2ez6zxeelLewW616/Z7E4cUva4vzf
        46wO4h6z7p9l89g56y67x/l7G1k8Lp8t9di0qpPNY/OSeo/dNxvYPHqb3wEVtN5n9Xi/7yqb
        R9+WVYwenzfJebQf6Gby2PTkLVMAXxSXTUpqTmZZapG+XQJXRuOMY4wFjawV28/MZW1gnMHS
        xcjJISFgIjHv9WvWLkYuDiGBHYwSS45OYoJISEos+3uEGcIWllj57zk7RFEzk0TPveNADgcH
        m4C2xOn/HCBxEYEFTBKX771iBnGYBZYyScy+cpcNpFtYwE3iyP2v7CA2i4CqxOTNV8A28ApY
        SSz9NJsVZJCEgL5E/31BkDCngLXEmYu7mEDCQkAle5bpQFQLSpyc+QTsaGYBeYnmrbOZJzAK
        zEKSmoUktYCRaRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnAca2ntYNyz6oPeIUYm
        DsZDjBIczEoivPWeNclCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2C
        yTJxcEo1MO2yXhF2Qi7QSmuv6vK51VWXFj6ReNfcM/0V98NIubneVyI+66XeT7zvOWe7aPrD
        XMvn73N+ee9SUXL7uHzd49cMuhOMpn15W/G5vGffpKz0Ty61e5v9nv57JCbd/nLZloi9jowf
        Jm6cd01TYFlg5ZmiaLU9bf5Nr1j+Nv7wW+QjeSOGxfdb2ro793Jez1DUqTa6oPNELPm7uuSv
        G70MTNsWB0yTvMUUcqTkTLHpizfJHa4Hdd/GhL/f1ah5altL0nrTbxe93ljFPK97nGNxJsdi
        Z2/V1ognHP+O7f69fLNGw83TZ8tF5+5U3Sp+5zd7gUT2MmOh5C/231weiXzfzf398KRz3DV7
        Zmy+eEtkjcZFJZbijERDLeai4kQAu1HpnVIDAAA=
X-CMS-MailID: 20221123061037epcas5p4d57436204fbe0065819b156eeeddbfac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221123061037epcas5p4d57436204fbe0065819b156eeeddbfac
References: <20221123055827.26996-1-nj.shetty@samsung.com>
        <CGME20221123061037epcas5p4d57436204fbe0065819b156eeeddbfac@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Setting copy_offload_supported flag to enable offload.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-linear.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 3212ef6aa81b..b4b57bead495 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -61,6 +61,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_discard_bios = 1;
 	ti->num_secure_erase_bios = 1;
 	ti->num_write_zeroes_bios = 1;
+	ti->copy_offload_supported = 1;
 	ti->private = lc;
 	return 0;
 
-- 
2.35.1.500.gb896f729e2

