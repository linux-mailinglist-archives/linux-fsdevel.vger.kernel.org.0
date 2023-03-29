Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E314C6CD0AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 05:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjC2DaC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 23:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjC2D3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:29:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E0A35A0;
        Tue, 28 Mar 2023 20:29:52 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T10d0M030341;
        Wed, 29 Mar 2023 03:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : mime-version : content-type; s=qcppdkim1;
 bh=qMYAKtazM96mw3n7WQj57jjWCtzRMxVdu0bjew/CIUQ=;
 b=hWnSrtkOyATP2EWkQt/uGjIkjpH4L1+0mzXYUdHHRKEb03/70AFokB30g74ptKEKMnVO
 694iGbLXzSQNKlZDwGfxNDHSNk00THNNgibyP0QwkaWQugvidj3u/iKrVDhdfZukkFDZ
 IE9efFFCgokl2qrxXkj/RIpeWJ0gA3XSEeEBUVJMeF9Nx+0H3788WAq0YRtYe92UG851
 zNNTSBju8LmQjDu7HzGbEDPnaYJPHARH1Sg7vdFIFi4VEvfBC/OKQctWBkabFY1v6vmB
 MkvZ9aowTyHr4ZOSA8IroglMa/BiwHjLQW9dueNv10XprlnI9qvQykCYfFkm76GkvrCl LA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pmb8h08g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 03:29:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32T3Th8Y008673
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 03:29:43 GMT
Received: from hu-cgoldswo-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 28 Mar 2023 20:29:42 -0700
Date:   Tue, 28 Mar 2023 20:29:41 -0700
From:   Chris Goldsworthy <quic_cgoldswo@quicinc.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Multi-index entries, clarifying storage overhead with respect to
 range alignment
Message-ID: <20230329032731.GA3319@hu-cgoldswo-sd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1aF1erczc4A0QE5ciVsbovgA7QCO6-hB
X-Proofpoint-GUID: 1aF1erczc4A0QE5ciVsbovgA7QCO6-hB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303290027
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

Consider the following excerpt from the Xarray documentation on multi-index
entries, summarizing the [2^N, 2^(N+1) - 1] alignment requirement for
utilizing multi-index entries [1]:

"The current implementation only allows tying ranges which are aligned powers of
two together; eg indices 64-127 may be tied together, but 2-6 may not be. This
may save substantial quantities of memory; for example tying 512 entries
together will save over 4kB."

Won't we still use multi-index entries for power-of-two ranges that are aligned
for the size of the range? That is, the range [i, j] satisfies:

	(A): j - i = 2^k for some k and i % 2^k == 0 .

This is more permissive than [2^N, 2^(N+1) - 1] . I'm basing this assumption
(calling it this as I'm not 100% certain yet) off of the following:

(1) Counting the number of kmem_cache_alloc_lru() calls using ranges satisfying (A)
whilst varying the starting position.

(2) Walking through xa_store_range(). The call to xas_set_range() [2] sets the
final xa_shift S that corresponds to the range we want to cover. When calling
xas_store() [3], inside of which is a call to xas_create() [4], the shift of the
lowest-level node [5] we allocate is no smaller than S - XA_CHUNK_SHIFT + 1,
i.e. the entry will still cover multiple entries so long as S is large enough
(though we still might need multiple entries to do this). This will happen
despite the alignment of things, based of what happens in xas_store_range(). Let
me know if I'm misinterpreting something.

Thanks,

Chris.

[1] https://docs.kernel.org/core-api/xarray.html#multi-index-entries
[2] https://elixir.bootlin.com/linux/latest/source/lib/xarray.c#L1740
[3] https://elixir.bootlin.com/linux/latest/source/lib/xarray.c#L1741
[4] https://elixir.bootlin.com/linux/latest/source/lib/xarray.c#L789
[5] https://elixir.bootlin.com/linux/latest/source/lib/xarray.c#L679
