Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636FA4C124E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 13:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbiBWMFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 07:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiBWMFj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:05:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC1298F4D;
        Wed, 23 Feb 2022 04:05:11 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NBkjN8005236;
        Wed, 23 Feb 2022 12:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=cAqsjmvAs3DfqRV7gSoiMSp/RNJjRqeiylIgknhlfbM=;
 b=Z843OxjHX5NLNTb0Hm4IMMVG8mJ1j1iFjrAR/arZphlXc77Pujxvcsc5KDWbG4Mg/cGE
 DJjWVWyd7X0QPgOsVrotDIwyw5gFUSAIhMjh5MJ5KKl9BRPFgz08RUvm1gqFef87XP5f
 OQ8YSDJJTYHTy2N9fJq2+aUUlQm9khHFsAF483Eje9QMckTrcwYqD5dZjwP0ihy+HJrt
 J1zecz3SmQ58XXRphlr/joN/A4/qoSpCRbBnrjBDwQlQugnrXoyNG3g6FPZKcBSV30zh
 kYVryo1O41Ht118OMSM5mENOXJqkThnN1Lm1vs4Ft+HmfRw2qs7OUxIezppN/xiS3IPu XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3edmbr8bpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 12:05:08 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21NBvN6r008390;
        Wed, 23 Feb 2022 12:05:07 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3edmbr8bnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 12:05:07 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21NC1id5028101;
        Wed, 23 Feb 2022 12:05:05 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3ear699mnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 12:05:05 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21NC52BB45089250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 12:05:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A498DA4051;
        Wed, 23 Feb 2022 12:05:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE8DBA4057;
        Wed, 23 Feb 2022 12:05:00 +0000 (GMT)
Received: from localhost (unknown [9.43.68.5])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Feb 2022 12:05:00 +0000 (GMT)
Date:   Wed, 23 Feb 2022 17:34:57 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/9] ext4: Add couple of more fast_commit tracepoints
Message-ID: <20220223120457.a6mx3uufvainfi2n@riteshh-domain>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
 <90608d31b7ad8500c33d875d3a7fa50e3456dc1a.1645558375.git.riteshh@linux.ibm.com>
 <20220223094057.53zcovnazrqwbngw@quack3.lan>
 <20220223101159.ekwbylvbmec5v35q@riteshh-domain>
 <20220223115313.3s73bu7p454bodvl@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223115313.3s73bu7p454bodvl@quack3.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mfiuBmmEeruvcLuHMfmnrzevTk-Oz7M4
X-Proofpoint-GUID: OZj7rKQW6lhngJSE81vl9WGJ0SrZQe5E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_03,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=43 lowpriorityscore=0
 mlxscore=43 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 mlxlogscore=12 bulkscore=0
 malwarescore=0 spamscore=43 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202230068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/02/23 12:53PM, Jan Kara wrote:
> On Wed 23-02-22 15:41:59, Ritesh Harjani wrote:
> > On 22/02/23 10:40AM, Jan Kara wrote:
> > > On Wed 23-02-22 02:04:11, Ritesh Harjani wrote:
> > > > This adds two more tracepoints for ext4_fc_track_template() &
> > > > ext4_fc_cleanup() which are helpful in debugging some fast_commit issues.
> > > >
> > > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > >
> > > So why is this more useful than trace_ext4_fc_track_range() and other
> > > tracepoints? I don't think it provides any more information? What am I
> > > missing?
> >
> > Thanks Jan for all the reviews.
> >
> > So ext4_fc_track_template() adds almost all required information
> > (including the caller info) in this one trace point along with transaction tid
> > which is useful for tracking issue similar to what is mentioned in Patch-9.
> >
> > (race with if inode is part of two transactions tid where jbd2 full commit
> > may begin for txn n-1 while inode is still in sbi->s_fc_q[MAIN])
>
> I understand commit tid is interesting but cannot we just add it to
> tracepoints like trace_ext4_fc_track_range() directly? It would seem useful
> to have it there and when it is there, the need for
> ext4_fc_track_template() is not really big. I don't care too much but

Yes make sense. Sure, I will look into adding this info to existing trace
points then. With that I think trace_ext4_fc_track_template() won't be required.

Will add those changes in V2.

> this tracepoint looked a bit superfluous to me.
>
> > And similarly ext4_fc_cleanup() helps with that information about which tid
> > completed and whether it was called from jbd2 full commit or from fast_commit.
>
> Yeah, that one is clear.

Will retain trace_ext4_fc_cleanup() then.


-ritesh
>
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
