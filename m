Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1813162FDC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 20:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiKRTJS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 14:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiKRTJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:09:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F946167FF;
        Fri, 18 Nov 2022 11:09:16 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIHlEDh025654;
        Fri, 18 Nov 2022 19:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ZHvkdtTxGcAYwukcBLGIquU21MOWuR1bsjsvrKFaGug=;
 b=TG9kuAo46hOEiVwzYWwUighe/PIqoYIku5HJXZxmwStsc4+g0Wfr8A5WlZDKLj7YIXts
 MoFNOQ/h74LP5G+R+NEyEAfxHVtVDq4qRCfXqTc2HMssiLKVDugSxC0OZfUVoVj475EZ
 m7eBro/lYMXrCk5MkRXCW8KErf23HrjYHOq8fP715nMDEAdPRAlqK7ue5AJu6O6O73Up
 66XwCdusfZU6ok647qE3BnOWpNXtaCKfrjJYjsD2Fp4JM89X9xp9p2kZ7bKRWfQh9S/H
 6Iz3RBD9KC8jxhmqT1fWuzritiLejhQuGju3mGVC5P+gMrfGmaxQsc5SuM6B6ZDRq/6x yg== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kxd3w4c04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 19:09:12 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AIJ5O42008746;
        Fri, 18 Nov 2022 19:09:12 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03dal.us.ibm.com with ESMTP id 3kt34akja6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 19:09:12 +0000
Received: from smtpav05.dal12v.mail.ibm.com ([9.208.128.132])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AIJ9BvD33620514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 19:09:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C47FA5804C;
        Fri, 18 Nov 2022 19:09:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FA195805D;
        Fri, 18 Nov 2022 19:09:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.49.134])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 18 Nov 2022 19:09:10 +0000 (GMT)
Message-ID: <89e8f4c2e1bc59c76715fc00a0578564ecf4077d.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] lsm,fs: fix vfs_getxattr_alloc() return type and
 caller error paths
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 18 Nov 2022 14:09:10 -0500
In-Reply-To: <CAHC9VhRUfJAYxZUDSkmoHdr5Z+TPCHSbv-nfvJ8t4_zg04NNXQ@mail.gmail.com>
References: <20221110043614.802364-1-paul@paul-moore.com>
         <20221118015414.GA19423@mail.hallyn.com>
         <CAHC9VhSNGSpdYWf_6if+Q+8BZvR-zYYxBMmoYhRNH9rWpn7=AA@mail.gmail.com>
         <9989ecccca46cbbecd12ae8ecdfc693ea115a09a.camel@linux.ibm.com>
         <CAHC9VhRUfJAYxZUDSkmoHdr5Z+TPCHSbv-nfvJ8t4_zg04NNXQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AVXjbM40LhwEuOCx1YGysanpbE38px9X
X-Proofpoint-ORIG-GUID: AVXjbM40LhwEuOCx1YGysanpbE38px9X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=967 malwarescore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-11-18 at 13:44 -0500, Paul Moore wrote:
> On Fri, Nov 18, 2022 at 1:30 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Fri, 2022-11-18 at 08:44 -0500, Paul Moore wrote:
> > > On Thu, Nov 17, 2022 at 8:54 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> > > > On Wed, Nov 09, 2022 at 11:36:14PM -0500, Paul Moore wrote:
> > > > > The vfs_getxattr_alloc() function currently returns a ssize_t value
> > > > > despite the fact that it only uses int values internally for return
> > > > > values.  Fix this by converting vfs_getxattr_alloc() to return an
> > > > > int type and adjust the callers as necessary.  As part of these
> > > > > caller modifications, some of the callers are fixed to properly free
> > > > > the xattr value buffer on both success and failure to ensure that
> > > > > memory is not leaked in the failure case.
> > >
> > > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > >
> > > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > > >
> > > > Do I understand right that the change to process_measurement()
> > > > will avoid an unnecessary call to krealloc() if the xattr has
> > > > not changed size between the two calls to ima_read_xattr()?
> > > > If something more than that is going on there, it might be
> > > > worth pointing out in the commit message.
> > >
> > > Yes, that was the intent, trying to avoid extra calls to krealloc().
> > >
> > > Mimi, have you had a chance to look at this patch yet?  In addition to
> > > cleaning up the vfs_getxattr_alloc() function it resolves some issues
> > > with IMA (memory leaks), but as you're the IMA expert I really need
> > > your review on this ...b
> >
> > All the other vfs_{get/set/list}xattr functions return ssize_t.  Why
> > should vfs_getxattr_alloc() be any different?
> 
> The xattr_handler::get() function, the main engine behind
> vfs_getxattr_alloc() and the source of the non-error return values,
> returns an int.  The error return values returned by
> vfs_getxattr_alloc() are the usual -E* integer values.
> 
> > The only time there could be a memory leak is when the
> > vfs_getxattr_alloc() caller provides a buffer which isn't large enough.
> > The one example in IMA/EVM is the call to evm_calc_hmac_or_hash(),
> > which is freeing the memory.
> >
> > Perhaps I'm missing something, but from an IMA/EVM perspective, I see a
> > style change (common exit), but not any memory leak fixes.  I'm fine
> > with the style change.
> 
> Picking one at random, what about the change in
> ima_eventevmsig_init()?  The current code does not free @xattr_data on
> error which has the potential to leak memory if vfs_getxattr_alloc()'s
> second call to the xattr get'er function fails.  Granted, the
> likelihood of this, if it is even possible, is an open question, but I
> don't think that is an excuse for the callers to not do The Right
> Thing.

Oh!  This is about the 2nd handler call failing.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>b

