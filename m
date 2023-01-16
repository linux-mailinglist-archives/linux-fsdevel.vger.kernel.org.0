Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D311266B8E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 09:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjAPIQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 03:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjAPIQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:16:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A304A5DF;
        Mon, 16 Jan 2023 00:16:39 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30G5phGm006477;
        Mon, 16 Jan 2023 08:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=aAM1gLVGcu5OKZYvuiecaAAKU0vH+ia5dUsj4lRlqpU=;
 b=c/0EyJIQQNjsWQUKOS2qzqjHxzDF10KYn2DMKorbld2iLPwfqAlEE5kd00S1cs2K6CK5
 JG2/ZLVysstStLNLl4x2FbisaJgspp3xAMjskHHO1J9M4a+dVO053FcbEFeLa672fjJe
 wISQ85kHhmEygaVU5yeZAYVEtNSE2MaKkntELa9+eh0fWb26gr+xXwbC6th/dsoQ5gkD
 GbeNpfhzzLui/ZbVFCve//rMl13Fe7KFcVkrckQNyc8wLRhf6n+meX7UaJQysyA7twTz
 7NB+/8KJFoPG1gtUAa7SUupcLN0FrbAmgKbPVk+lg8PKVN2LWZmttgTxZfJmV8+1+HJG eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n4gdc9dte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 08:16:33 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30G7cs5v008622;
        Mon, 16 Jan 2023 08:16:33 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n4gdc9ds9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 08:16:33 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30G1j8EK007008;
        Mon, 16 Jan 2023 08:16:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n3knfj4cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 08:16:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30G8GSGO45679016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 08:16:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04EE720049;
        Mon, 16 Jan 2023 08:16:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0734420043;
        Mon, 16 Jan 2023 08:16:26 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 16 Jan 2023 08:16:25 +0000 (GMT)
Date:   Mon, 16 Jan 2023 13:46:20 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v2 7/8] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <Y8UH1AuwC812hrqi@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1665776268.git.ojaswin@linux.ibm.com>
 <8421bbe2feb4323f5658757a3232e4c02e20c697.1665776268.git.ojaswin@linux.ibm.com>
 <Y4V3OrSwxA8rZHyy@mit.edu>
 <Y4YZPreNi7QGPZLK@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4YZPreNi7QGPZLK@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F8aeOGXA2ICStcD9onMa_5OIs-Gl3XPt
X-Proofpoint-ORIG-GUID: AmMjrjVRzXZUwEe5a8i2H6euRF1l-XZM
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_06,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 adultscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301160058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 29, 2022 at 08:07:50PM +0530, Ojaswin Mujoo wrote:
> On Mon, Nov 28, 2022 at 10:06:34PM -0500, Theodore Ts'o wrote:
> > Looking at the stack trace it looks like we're hitting this BUG_ON:
> > 
> > 		spin_lock(&tmp_pa->pa_lock);
> > 		if (tmp_pa->pa_deleted == 0)
> > 			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
> > 		spin_unlock(&tmp_pa->pa_lock);
> > 
> > ... in the inline function ext4_mb_pa_assert_overlap(), called from
> > ext4_mb_pa_adjust_overlap().
> > 
> > The generic/269 test runs fstress with an ENOSPC hitter as an
> > antogonist process.  The ext3 configuration disables delayed
> > allocation, which means that fstress is going to be allocating blocks
> > at write time (instead of dirty page writeback time).
> > 
> > Could you take a look?   Thanks!
> Hi Ted,
> 
> Thanks for pointing this out, I'll have a look into this.
> 
> PS: I'm on vacation so might be a bit slow to update on this.
> 
> Regards,
> Ojaswin
> > 
> > 						- Ted

Hi Ted,

Apologies for the delay on this due to new years/replication issues. I
was not able to replicate it at my end for some time before ultimately
replicating this in gce-xfstests. I have sent a v3 [1] that fixes the
issue by introducing an optimization related to delted PAs found in
rbtree traversal in functions like ext4_mb_adjust_overlap() and
ext4_mb_use_preallocated(). Let me quote the commit message which
explains the issue and the fix we proposed:

---- snip ----

In ext4_mb_adjust_overlap(), it is possible for an allocating thread to
come across a PA that is marked deleted via
ext4_mb_discard_group_preallocations() but not yet removed from the
inode PA rbtree. In such a case, we ignore any overlaps with this PA
node and simply move forward in the rbtree by comparing logical start of
to-be-inserted PA and the deleted PA node.

Although this usually doesn't cause an issue and we can move forward in
the tree, in one special case, i.e if range of deleted PA lies
completely inside the normalized range, we might require to travese both
the sub-trees under such a deleted PA.

To simplify this special scenario and also as an optimization, undelete
the PA If the allocating thread determines that this PA might be needed
in the near future. This results in the following changes:

- ext4_mb_use_preallocated(): Use a deleted PA if original request lies in it.
- ext4_mb_pa_adjust_overlap(): Undelete a PA if it is deleted but there
		is an overlap with the normalized range.
- ext4_mb_discard_group_preallocations(): Rollback delete operation if
		allocation path undeletes a PA before it is erased from inode PA
		list.

Since this covers the special case we discussed above, we will always
un-delete the PA when we encounter the special case and we can then
adjust for overlap and traverse the PA rbtree without any issues.

---- snip ----

The above optimization is now straight forward as we completely lock the
rbtree during traversals and modifications. Earlier in case of list,
the locking would have been tricky due to usage of RCU.

[1]
https://lore.kernel.org/linux-ext4/20230116080216.249195-1-ojaswin@linux.ibm.com/
