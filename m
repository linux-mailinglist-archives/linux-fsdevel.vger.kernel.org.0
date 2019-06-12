Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E39A42B86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 17:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438019AbfFLP7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 11:59:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406027AbfFLP7Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:59:25 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CFvCho011351
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2019 11:59:24 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t33w81j6b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2019 11:59:24 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 12 Jun 2019 16:59:22 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Jun 2019 16:59:19 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5CFxI2m40042810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 15:59:18 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B2FF4C044;
        Wed, 12 Jun 2019 15:59:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28C034C050;
        Wed, 12 Jun 2019 15:59:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.109.218])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 Jun 2019 15:59:17 +0000 (GMT)
Subject: Re: [PATCH 1/2] vfs: replace i_readcount with a biased i_count
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Wed, 12 Jun 2019 11:59:06 -0400
In-Reply-To: <CAOQ4uxhooVwtHcDCr4hu+ovzKGUdWfQ+3F3nbgK3HXgV+fUK9w@mail.gmail.com>
References: <20190608135717.8472-1-amir73il@gmail.com>
         <20190608135717.8472-2-amir73il@gmail.com>
         <1560343899.4578.9.camel@linux.ibm.com>
         <CAOQ4uxhooVwtHcDCr4hu+ovzKGUdWfQ+3F3nbgK3HXgV+fUK9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061215-0016-0000-0000-000002887DF7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061215-0017-0000-0000-000032E5B4BB
Message-Id: <1560355146.4578.61.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=776 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906120107
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2019-06-12 at 18:09 +0300, Amir Goldstein wrote:
> On Wed, Jun 12, 2019 at 3:52 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Sat, 2019-06-08 at 16:57 +0300, Amir Goldstein wrote:
> > > Count struct files open RO together with inode reference count instead
> > > of using a dedicated i_readcount field.  This will allow us to use the
> > > RO count also when CONFIG_IMA is not defined and will reduce the size of
> > > struct inode for 32bit archs when CONFIG_IMA is defined.
> > >
> > > We need this RO count for posix leases code, which currently naively
> > > checks i_count and d_count in an inaccurate manner.
> > >
> > > Should regular i_count overflow into RO count bias by struct files
> > > opened for write, it's not a big deal, as we mostly need the RO count
> > > to be reliable when the first writer comes along.
> >
> > "i_count" has been defined forever.  Has its meaning changed?  This
> > patch implies that "i_readcount" was never really needed.
> >
> 
> Not really.
> i_count is only used to know if object is referenced.
> It does not matter if user takes 1 or more references on i_count
> as long as user puts back all the references it took.
> 
> If user took i_readcount, i_count cannot be zero, so short of overflow,
> we can describe i_readcount as a biased i_count.

Having a count was originally to make sure we weren't missing
anything.  As long as we can detect if a file is opened for read, the
less IMA specific code there is, the better.

> 
> But if I am following Miklos' suggestion to make i_count 64bit, inode
> struct size is going to grow for 32bit arch when  CONFIG_IMA is not
> defined, so to reduce impact, I will keep i_readcount as a separate
> member and let it be defined also when BITS_PER_LONG == 64
> and implement inode_is_open_rdonly() using d_count and i_count
> when i_readcount is not defined.
> 
> Let's see what people will have to say about that...

Ok

Mimi

