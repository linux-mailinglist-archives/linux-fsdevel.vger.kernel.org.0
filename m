Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB84710EEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 17:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbjEYPAu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbjEYPAt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 11:00:49 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47188191;
        Thu, 25 May 2023 08:00:44 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PEuBK2013223;
        Thu, 25 May 2023 15:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=HEaA0SnACFr+FUUA4vFdDc5HJuDhxRyje+Mm0nAY+ZM=;
 b=p8Ye07mO8CTSu1WRW+JgiPjAYwph3UffmX0LQlbe9ujJvK82JkjkXIHgNMR/lgHL4CCt
 eB1cg368Lc7VfnQi1aSajKLJsfCBn3KczawHxm1lCZKmrqiy2riw/RvXcDGzeqpb5pMr
 zjSZTyg14AB/Auhumf0Bup/DqsFsNNifnusI9VdV2VYDtlYjvfROuCmRrLTBWq2ZC33n
 RmOpc+gDd6EQAmx45jSDf2/WLA4a8rxs9AfVtsJyrnw5nqgb5/MBUZypQ3lzw//oBWcR
 3ztem2nX6pnaC1PiX3LMhf3exh8+duebJ3jYW9T0oy6l6XnkUf/P1UectOks+gzCWvle 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt9vdg2nk-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 15:00:32 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34PEU9FY019836;
        Thu, 25 May 2023 14:43:30 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt9fngdq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 14:43:30 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34PCoFgv016415;
        Thu, 25 May 2023 14:43:29 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3qppdta0vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 14:43:29 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34PEhSCP60424648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 14:43:28 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4ED2C58055;
        Thu, 25 May 2023 14:43:28 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B7D558059;
        Thu, 25 May 2023 14:43:27 +0000 (GMT)
Received: from wecm-9-67-23-194.wecm.ibm.com (unknown [9.67.23.194])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 25 May 2023 14:43:27 +0000 (GMT)
Message-ID: <ba494e92990e520bd8660208b3cc10bb9af8dd26.camel@linux.ibm.com>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM
 after writes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Date:   Thu, 25 May 2023 10:43:26 -0400
In-Reply-To: <CAHC9VhS7uMMgvwRRDzpZPUQDAeibdkLi0OCdp=j_Q-EcMHm0cw@mail.gmail.com>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
         <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
         <cbffa3dee65ecc0884dd16eb3af95c09a28f4297.camel@linux.ibm.com>
         <CAHC9VhSeBn-4UN48NcQWhJqLvQuydt4OvdyUsk9AXcviJ9Cqyw@mail.gmail.com>
         <49a31515666cb0ecf78909f09d40d29eb5528e0f.camel@linux.ibm.com>
         <CAHC9VhS7uMMgvwRRDzpZPUQDAeibdkLi0OCdp=j_Q-EcMHm0cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uwPqM4NirCy91ZQJ05ShddySVI9qgyX1
X-Proofpoint-GUID: 7QZbnswjjeRPFa_t9axwduAacG9ioe-q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_08,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-05-19 at 10:58 -0400, Paul Moore wrote:
> On Thu, May 18, 2023 at 4:56 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Thu, 2023-05-18 at 16:46 -0400, Paul Moore wrote:
> > > On Fri, Apr 21, 2023 at 10:44 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > On Fri, 2023-04-07 at 09:29 -0400, Jeff Layton wrote:
> 
> ...
> 
> > > I'm going through my review queue to make sure I haven't missed
> > > anything and this thread popped up ... Stefan, Mimi, did you get a fix
> > > into an upstream tree somewhere?  If not, is it because you are
> > > waiting on a review/merge from me into the LSM tree?
> >
> > Sorry for the delay.  Between vacation and LSS, I just started testing
> > Jeff Layton's patch.
> 
> No worries, I'm a bit behind too, I just wanted to make sure I wasn't
> blocking this thread :)

FYI, Jeff Layton's patch is now queued in next-integrity.

-- 
thanks,

Mimi

