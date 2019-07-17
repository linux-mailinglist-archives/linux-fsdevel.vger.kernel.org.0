Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2066BE9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 16:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfGQOxr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 10:53:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45544 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfGQOxr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:53:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HEmVMa110128;
        Wed, 17 Jul 2019 14:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=TZykMoFd4AOJBT4fCUlgegRKNvBfCOB/CMQ+3AdJlVM=;
 b=Ecog8whliIzvdAC9aPX2wXtFI35LgP9Qas9u8QMWVda0SgfXtz754evNhMhhiBosigXw
 Ryziqvfol40TK185oX/GyCGluJWozI+XeAjy+zP3iWYjZRC7yZbKcBBcUxBnPdrJ+8C6
 o8EKnI33oPWia0vTN0dGTGOa86vbYNQ4bmckHjlzD3gKehY8XuNSmcwefED/22KxxMnN
 uEyAxAqqhv+yxyRlSpXnYBzOMiixBHEOD3RT8Hl7tMlaJGlRrrMBoEUTzP6xjBSj8dcL
 GcGrl/COZeBt7Qbin3px1iE8Zfrs3BNpXgl734aKTt8tBO1F5TSME3Zb6et55zd2BEs0 cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2tq7xr3aat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 14:53:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HEmTdJ053370;
        Wed, 17 Jul 2019 14:53:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2tq4dujrxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 14:53:37 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6HEragr021074;
        Wed, 17 Jul 2019 14:53:36 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 14:53:36 +0000
Date:   Wed, 17 Jul 2019 07:53:35 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 4/9] iomap: move the SEEK_HOLE code into a separate file
Message-ID: <20190717145335.GD7093@magnolia>
References: <156321356040.148361.7463881761568794395.stgit@magnolia>
 <156321358581.148361.8774330141606166898.stgit@magnolia>
 <20190717050118.GD7113@infradead.org>
 <CAHc6FU7A3U1FZXwXfvJRL1FazUu=zfJ4=AwpggNG5QWvsywt2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU7A3U1FZXwXfvJRL1FazUu=zfJ4=AwpggNG5QWvsywt2A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170174
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170174
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 17, 2019 at 02:44:20PM +0200, Andreas Gruenbacher wrote:
> On Wed, 17 Jul 2019 at 07:01, Christoph Hellwig <hch@infradead.org> wrote:
> > > diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
> > > new file mode 100644
> > > index 000000000000..0c36bef46522
> > > --- /dev/null
> > > +++ b/fs/iomap/seek.c
> > > @@ -0,0 +1,214 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2010 Red Hat, Inc.
> > > + * Copyright (c) 2016-2018 Christoph Hellwig.
> > > + */
> >
> > This looks a little odd.  There is nothing in here from Daves original
> > iomap prototype.  It did start out with code from Andreas though which
> > might or might not be RH copyright.  So we'll need Andreas and/or RH
> > legal to chime in.
> 
> That code should be Copyright (C) 2017 Red Hat, Inc.

Ok, fixed.

--D

> > Otherwise looks good:
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Thanks,
> Andreas
