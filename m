Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A8962FCCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 19:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241312AbiKRSak (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 13:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242691AbiKRSaU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:30:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEAF1A83F;
        Fri, 18 Nov 2022 10:30:03 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AII1GH6025589;
        Fri, 18 Nov 2022 18:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=1BrhQFIxbeVAdLbsZjDrNsQmQVP6sEy31cpaVz6jIgw=;
 b=LwaI78v641UBwyd3+kRGVwoH/yqx8AIU51SrMKAG4gqX3d42/6CaAKf81hwc/wOS6oe7
 hA9ueSX/mpq88qeG4EIbETfEjwTPAlpg0ztRcS+4vhdgH1cf5BRkbR+tYSRyg2rJlu1/
 9m1TwPQiqN9dF8ib4qWVDlHN6rP+vL70VCo3oERFx56xlNwHY/QVeTMLJCmxVR6K3JE/
 YcxikoOJZrpDFqKhx3q/ofsP+I9mY1fNc5AeoLkhx+Pf/CyIgOSDSDMKDdPrLgT/x/pC
 BwMUtyfNt/bq/YBaEj34icHGPI2F3Jp66saFc22GqJhSBgcOCtECp5zrTrYr16w/gLIc zQ== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kxd3w3hpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 18:29:54 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AIIKkda012967;
        Fri, 18 Nov 2022 18:29:53 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 3kt34abfbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 18:29:53 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AIITrRM36504088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 18:29:54 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C89CF5805E;
        Fri, 18 Nov 2022 18:29:51 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2ABA95805A;
        Fri, 18 Nov 2022 18:29:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.49.134])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 18 Nov 2022 18:29:51 +0000 (GMT)
Message-ID: <9989ecccca46cbbecd12ae8ecdfc693ea115a09a.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] lsm,fs: fix vfs_getxattr_alloc() return type and
 caller error paths
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 18 Nov 2022 13:29:50 -0500
In-Reply-To: <CAHC9VhSNGSpdYWf_6if+Q+8BZvR-zYYxBMmoYhRNH9rWpn7=AA@mail.gmail.com>
References: <20221110043614.802364-1-paul@paul-moore.com>
         <20221118015414.GA19423@mail.hallyn.com>
         <CAHC9VhSNGSpdYWf_6if+Q+8BZvR-zYYxBMmoYhRNH9rWpn7=AA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mD84k1kfKsfL8HAczuRW0MRyo_wDmJ8Y
X-Proofpoint-ORIG-GUID: mD84k1kfKsfL8HAczuRW0MRyo_wDmJ8Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=864 malwarescore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-11-18 at 08:44 -0500, Paul Moore wrote:
> On Thu, Nov 17, 2022 at 8:54 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> > On Wed, Nov 09, 2022 at 11:36:14PM -0500, Paul Moore wrote:
> > > The vfs_getxattr_alloc() function currently returns a ssize_t value
> > > despite the fact that it only uses int values internally for return
> > > values.  Fix this by converting vfs_getxattr_alloc() to return an
> > > int type and adjust the callers as necessary.  As part of these
> > > caller modifications, some of the callers are fixed to properly free
> > > the xattr value buffer on both success and failure to ensure that
> > > memory is not leaked in the failure case.
> 
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> >
> > Do I understand right that the change to process_measurement()
> > will avoid an unnecessary call to krealloc() if the xattr has
> > not changed size between the two calls to ima_read_xattr()?
> > If something more than that is going on there, it might be
> > worth pointing out in the commit message.
> 
> Yes, that was the intent, trying to avoid extra calls to krealloc().
> 
> Mimi, have you had a chance to look at this patch yet?  In addition to
> cleaning up the vfs_getxattr_alloc() function it resolves some issues
> with IMA (memory leaks), but as you're the IMA expert I really need
> your review on this ...b

All the other vfs_{get/set/list}xattr functions return ssize_t.  Why
should vfs_getxattr_alloc() be any different?

The only time there could be a memory leak is when the
vfs_getxattr_alloc() caller provides a buffer which isn't large enough.
The one example in IMA/EVM is the call to evm_calc_hmac_or_hash(),
which is freeing the memory.

Perhaps I'm missing something, but from an IMA/EVM perspective, I see a
style change (common exit), but not any memory leak fixes.  I'm fine
with the style change.

-- 
thanks,

Mimi

