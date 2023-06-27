Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1E873F4D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 08:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjF0GwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 02:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjF0GwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:52:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F367D109;
        Mon, 26 Jun 2023 23:52:08 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R6lkxi014094;
        Tue, 27 Jun 2023 06:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=ljMzO1E71unERBxVtqDA2RJAX7kAFF0nnhouWnI+x8Y=;
 b=Bb6b4LU5d1BFCqwd3S0uR+rF7w/+MRWWr/bg1agFbyVE8b6L2zkomk7FK5cVINKNdmpe
 jffL4TbyHvSVh+l+vzEab5PVmWi2WscmXX7/tAhFhCTiH7k9YjU2wqvNdDBG4MDKSjXP
 Ic7Kfg1o4i7H91OXfN9Nh7na3IYZvxKchHSquFSd3s+icQPu+I7Hm0bSujsbemCxNjfo
 wwp1KV93bC0Kk2mTEESk+7vEU5qgKEQc66Bj5XdDauwf1k+Wih+DatPX5QxyrpDsTfwB
 7xW6XKdtj3t0agiOqXprtIacepjTASe8JJyA4PzTbNhGYUq9YrkBvTlPbHzlN5yhyPQK yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfttc82ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 06:51:50 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35R6mRKu015631;
        Tue, 27 Jun 2023 06:51:50 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfttc82ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 06:51:50 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35R3onYl010114;
        Tue, 27 Jun 2023 06:51:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3rdr451aec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 06:51:47 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35R6pjn342271132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 06:51:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75DAD2004B;
        Tue, 27 Jun 2023 06:51:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2881320043;
        Tue, 27 Jun 2023 06:51:42 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 27 Jun 2023 06:51:41 +0000 (GMT)
Date:   Tue, 27 Jun 2023 12:21:38 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v2 09/12] ext4: Ensure ext4_mb_prefetch_fini() is called
 for all prefetched BGs
Message-ID: <ZJqG+rEl9DATNRIX@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
 <05e648ae04ec5b754207032823e9c1de9a54f87a.1685449706.git.ojaswin@linux.ibm.com>
 <c3173405-713d-d2eb-bd9c-af8b8c747533@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3173405-713d-d2eb-bd9c-af8b8c747533@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pIP5lKK82fE7DkKe64js4SX9CTWH7DqX
X-Proofpoint-ORIG-GUID: nsge9KerDHTbCxBtf8Qx2XrdE4HLaU4K
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_03,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306270061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 10:00:57PM +0800, Guoqing Jiang wrote:
> Hello,
> 
> On 5/30/23 20:33, Ojaswin Mujoo wrote:
> > Before this patch, the call stack in ext4_run_li_request is as follows:
> > 
> >    /*
> >     * nr = no. of BGs we want to fetch (=s_mb_prefetch)
> >     * prefetch_ios = no. of BGs not uptodate after
> >     * 		    ext4_read_block_bitmap_nowait()
> >     */
> >    next_group = ext4_mb_prefetch(sb, group, nr, prefetch_ios);
> >    ext4_mb_prefetch_fini(sb, next_group prefetch_ios);
> > 
> > ext4_mb_prefetch_fini() will only try to initialize buddies for BGs in
> > range [next_group - prefetch_ios, next_group). This is incorrect since
> > sometimes (prefetch_ios < nr), which causes ext4_mb_prefetch_fini() to
> > incorrectly ignore some of the BGs that might need initialization. This
> > issue is more notable now with the previous patch enabling "fetching" of
> > BLOCK_UNINIT BGs which are marked buffer_uptodate by default.
> > 
> > Fix this by passing nr to ext4_mb_prefetch_fini() instead of
> > prefetch_ios so that it considers the right range of groups.
> 
> Thanks for the series.
> 
> > Similarly, make sure we don't pass nr=0 to ext4_mb_prefetch_fini() in
> > ext4_mb_regular_allocator() since we might have prefetched BLOCK_UNINIT
> > groups that would need buddy initialization.
> 
> Seems ext4_mb_prefetch_fini can't be called by ext4_mb_regular_allocator
> if nr is 0.

Hi Guoqing,

Sorry I was on vacation so didn't get a chance to reply to this sooner.
Let me explain what I meant by that statement in the commit message.

So basically, the prefetch_ios output argument is incremented whenever
ext4_mb_prefetch() reads a block group with !buffer_uptodate(bh).
However, for BLOCK_UNINIT BGs the buffer is marked uptodate after
initialization and hence prefetch_ios is not incremented when such BGs
are prefetched. 

This leads to nr becoming 0 due to the following line (removed in this patch):

				if (prefetch_ios == curr_ios)
					nr = 0;

hence ext4_mb_prefetch_fini() would never pre initialise the corresponding 
buddy structures. Instead, these structures would then get initialized
probably at a later point during the slower allocation criterias. The
motivation of making sure the BLOCK_UNINIT BGs' buddies are pre
initialized is so the faster allocation criterias can utilize the data
to make better decisions.

Regards,
ojaswin

> 
> https://elixir.bootlin.com/linux/v6.4-rc5/source/fs/ext4/mballoc.c#L2816
> 
> Am I miss something?
> 
> Thanks,
> Guoqing
> 
