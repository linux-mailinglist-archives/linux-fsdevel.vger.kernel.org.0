Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88A8547FFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 08:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbiFMG5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 02:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiFMG47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:56:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D122140F8;
        Sun, 12 Jun 2022 23:56:52 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25D5DFNr037410;
        Mon, 13 Jun 2022 06:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=sg4r/3HlNtUZCzfEQKxVVhzIMzc01uTkxBUOjFJpuKA=;
 b=NTLr3Rw9NouBrw7ClKulUEjebkO6A5itEqempmqPPPMIe5WxzTU1RSeuSNqgfcQn+Qel
 mpyWvvRoLkX7BBylqpkYunkyAsl/lIGSSHiWYnubBtx0gSiorItaeUnSnErhVKh1TYVb
 G6DM9VtcvymwPUdxADeoOwB370fMvCzk3ag/yA/bfNUIAGHLBm5gy/BIuEuLSd+rfBFo
 ScYM+CzYJZsSDOfTyT1jJMuHuhBoFfgAdXkwemiKCqxo5iqi4dpnLscBe+et+zL7PfDK
 I9Adon6TD+u/6m2HYQfxfvzeSbDXAYku8Dd0+d8W7hGVcYHuGVi7UIhMuQ6Gzx7IjLiC uQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gn53qhkpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 06:56:29 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25D6oulj030905;
        Mon, 13 Jun 2022 06:56:28 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3gmjp8srqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 06:56:28 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25D6uOd822544728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 06:56:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB10811C052;
        Mon, 13 Jun 2022 06:56:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FC3B11C050;
        Mon, 13 Jun 2022 06:56:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.48.106])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Jun 2022 06:56:24 +0000 (GMT)
Date:   Mon, 13 Jun 2022 08:56:22 +0200
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 06/10] hugetlbfs: Convert remove_inode_hugepages() to use
 filemap_get_folios()
Message-ID: <YqbflvrB9oEZ1whX@localhost.localdomain>
References: <20220605193854.2371230-7-willy@infradead.org>
 <20220610155205.3111213-1-sumanthk@linux.ibm.com>
 <YqO08Dsq8ZcAcWDQ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqO08Dsq8ZcAcWDQ@casper.infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: avIoxhTFiSlJjY2R9CmSKMJMnKj8Jgxi
X-Proofpoint-ORIG-GUID: avIoxhTFiSlJjY2R9CmSKMJMnKj8Jgxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_02,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=774
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130029
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 10, 2022 at 10:17:36PM +0100, Matthew Wilcox wrote:
> On Fri, Jun 10, 2022 at 05:52:05PM +0200, Sumanth Korikkar wrote:
> > To reproduce:
> > * clone libhugetlbfs:
> > * Execute, PATH=$PATH:"obj64/" LD_LIBRARY_PATH=../obj64/ alloc-instantiate-race shared
> 
> ... it's a lot harder to set up hugetlb than that ...
> 
> anyway, i figured it out without being able to run the reproducer.
> 
> Can you try this?
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index a30587f2e598..8ef861297ffb 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2160,7 +2160,11 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
>  		if (xa_is_value(folio))
>  			continue;
>  		if (!folio_batch_add(fbatch, folio)) {
> -			*start = folio->index + folio_nr_pages(folio);
> +			unsigned long nr = folio_nr_pages(folio);
> +
> +			if (folio_test_hugetlb(folio))
> +				nr = 1;
> +			*start = folio->index + nr;
>  			goto out;
>  		}
>  	}

Yes, With the patch, The above tests works fine. 

--
Thanks,
Sumanth
