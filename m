Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FEA6C8EE4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Mar 2023 15:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjCYOoJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Mar 2023 10:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCYOoI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Mar 2023 10:44:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A9B55AD;
        Sat, 25 Mar 2023 07:44:07 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32PDTA5E018654;
        Sat, 25 Mar 2023 14:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=nL1zCzPyQOuXPRa9neoTN7K15C+Qg5B46gWFRP2q/6Q=;
 b=nONKV1lOdp7WXENKaTyOw7imY87djMsCiS8tU+7/L3ixwCAxAW9KIBTAjZv4mPvn5ZXp
 EwnA/Xb85QgLDeRyZKZwxx4mQNZiubxean50FX7hLzLCpAyHfjzeahcmEOJRVK5aCvY9
 wx3pViB0xdnw2HeW8f6M4GdS3YPbrJN23UiRnXtxi2gnaf16kluk+yELztro5l5WOrv/
 /2qDK+TJN54Tgan9ekGIKYQ5gHlBBXucjHE4oqqpyXNVBGWKlm89PHaEsDFrs6Z4ofuG
 yaCjGLPmAxoQy2i5hOPe7uaHlNEtOuS72S8QmGniJdfwM01HMlsZi0tFUiIVu8z9Zdtg +A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3phuwq5v5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 14:44:02 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32PEZkhI020221;
        Sat, 25 Mar 2023 14:44:02 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3phuwq5v4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 14:44:01 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32P2sgd3007243;
        Sat, 25 Mar 2023 14:43:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3phrk6gfn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 14:43:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32PEhvRl41157272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Mar 2023 14:43:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9F9820040;
        Sat, 25 Mar 2023 14:43:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 230AB20043;
        Sat, 25 Mar 2023 14:43:55 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.64.140])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sat, 25 Mar 2023 14:43:54 +0000 (GMT)
Date:   Sat, 25 Mar 2023 20:13:52 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [RFC 08/11] ext4: Don't skip prefetching BLOCK_UNINIT groups
Message-ID: <ZB8IqLFypLZ3dOLg@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <4881693a4f5ba1fed367310b27c793e4e78520d3.1674822311.git.ojaswin@linux.ibm.com>
 <20230309141422.b2nbl554ngna327k@quack3>
 <ZBRHCHySeQ0KC/f7@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230323105710.mdhamc3hza4223cb@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323105710.mdhamc3hza4223cb@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ljknFXhlj6fLG35NDOB_4dzFX-e4h7hQ
X-Proofpoint-ORIG-GUID: Oib0xDH-P9gNCVMw1PCg0LNWnkY9UduT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=856 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303250120
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 23, 2023 at 11:57:10AM +0100, Jan Kara wrote:
> On Fri 17-03-23 16:25:04, Ojaswin Mujoo wrote:
> > On Thu, Mar 09, 2023 at 03:14:22PM +0100, Jan Kara wrote:
> > > On Fri 27-01-23 18:07:35, Ojaswin Mujoo wrote:
> > > > Currently, ext4_mb_prefetch() and ext4_mb_prefetch_fini() skip
> > > > BLOCK_UNINIT groups since fetching their bitmaps doesn't need disk IO.
> > > > As a consequence, we end not initializing the buddy structures and CR0/1
> > > > lists for these BGs, even though it can be done without any disk IO
> > > > overhead. Hence, don't skip such BGs during prefetch and prefetch_fini.
> > > > 
> > > > This improves the accuracy of CR0/1 allocation as earlier, we could have
> > > > essentially empty BLOCK_UNINIT groups being ignored by CR0/1 due to their buddy
> > > > not being initialized, leading to slower CR2 allocations. With this patch CR0/1
> > > > will be able to discover these groups as well, thus improving performance.
> > > > 
> > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > 
> > > The patch looks good. I just somewhat wonder - this change may result in
> > > uninitialized groups being initialized and used earlier (previously we'd
> > > rather search in other already initialized groups) which may spread
> > > allocations more. But I suppose that's fine and uninit groups are not
> > > really a feature meant to limit fragmentation and as the filesystem ages
> > > the differences should be minimal. So feel free to add:
> > > 
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > 
> > > 								Honza
> > Thanks for the review. As for the allocation spread, I agree that it
> > should be something our goal determination logic should take care of
> > rather than limiting the BGs available to the allocator.
> > 
> > Another point I wanted to discuss wrt this patch series was why were the
> > BLOCK_UNINIT groups not being prefetched earlier. One point I can think
> > of is that this might lead to memory pressure when we have too many
> > empty BGs in a very large (say terabytes) disk.
> > 
> > But i'd still like to know if there's some history behind not
> > prefetching block uninit.
> 
> Hum, I don't remember anything. Maybe Ted will. You can ask him today on a
> call.
Unfortunately, couldn't join it last time :) I'll check with him on
upcoming Thurs.

Regards,
ojaswin
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
