Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2E44F4D18
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581462AbiDEXjG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455545AbiDEQAJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:00:09 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AEB6C1EB;
        Tue,  5 Apr 2022 08:16:23 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 235DphYc023351;
        Tue, 5 Apr 2022 17:16:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=selector1;
 bh=qSYGeN3qiBxsULhHOw6em+QZIRWZ5+DPQhMMpjB8q70=;
 b=j6bQQrFx7gKjGCzxBcvBet2tqkZO91G/goGzTxEt2tUTyYrpG0vG/pV4DFgKNrDHHAfR
 hNxLmnzEV7s8gRfLbKW9t3kCOOgNH+ipo71+x1pPnqEnsVnym+QTnZI/TOd+g4ZZNRC2
 sg+trOQvqBLQEXlO3ZauRr54b/OUIzVWmoXRlfPaHgftv1cRkgRrlvqp8+zDnJJ8/2cr
 KplEe6kGM+vkrgUjfRsqCFMN3f5cMVBqZ1SrX4JcgPmoJFB05UBGylKVYqN8sHDxOqqM
 j3ZZ3fiTFrOCb3UT7eMAbJC4brXiC+sfephrTQZG7vvsN2AI2z0kc4Q7V7puoKq0OZNl og== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3f6dcgtuq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Apr 2022 17:16:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 38BD710002A;
        Tue,  5 Apr 2022 17:15:59 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2D0B421E690;
        Tue,  5 Apr 2022 17:15:59 +0200 (CEST)
Received: from [10.201.21.201] (10.75.127.46) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 5 Apr
 2022 17:15:58 +0200
Message-ID: <481a13f8-d339-f726-0418-ab4258228e91@foss.st.com>
Date:   Tue, 5 Apr 2022 17:15:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     <hughd@google.com>, <mpatocka@redhat.com>, <lczerner@redhat.com>,
        <djwong@kernel.org>, <hch@lst.de>, <zkabelac@redhat.com>,
        <djwong@kernel.org>, <miklos@szeredi.hu>, <bp@suse.de>,
        <akpm@linux-foundation.org>
CC:     Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        Valentin CARON - foss <valentin.caron@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: Regression with v5.18-rc1 tag on STM32F7 and STM32H7 based boards
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-05_04,2022-04-05_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Guys

We found an issue with last kernel tag v5.18-rc1 on stm32f746-disco and 
stm32h743-disco boards (ARMV7-M SoCs).

Kernel hangs when executing SetPageUptodate(ZERO_PAGE(0)); in mm/filemap.c.

By reverting commit 56a8c8eb1eaf ("tmpfs: do not allocate pages on read"), 
kernel boots without any issue.

Thanks
Patrice
