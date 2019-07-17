Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB1A06B622
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 07:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfGQFyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 01:54:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40376 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfGQFyS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 01:54:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H5s3pN113586;
        Wed, 17 Jul 2019 05:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=fEkUF/7i13EWJcuCi+GWKcZMHBOyWJCr8FCnppezGMU=;
 b=RL2HbS2yQoPTt0NeTO9XjeBWFMWwjOTpXhD6CIcY8unbu43MY3cAp38D9GhFgvpcqTOU
 UIs5eofYQ/0XLyy/PJXUYiffOUdCdvubySrkL0x0pz2aD6xv1dj8v1vy60skESmGgkAi
 CoFyIOFvzzYzyTMbAL2sK1gJ3TEh+psqu4sfyCopG2zp0EPzK6OWu+m5EpGmDVregv1Z
 bAyKFkMGnDnZLeaceEav7zTTzU9hwKQsbz/8c78JQNXctlKi3azOqnWR6SwanSARcsoQ
 FaaQaInVQEF5AGF+18xLsEy/hU0UfFIX7CbYReIW7BN2wCDZWXkNcwGgA6pZqnUUPxsl 0Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2tq78prat7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 05:54:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H5qmjQ119727;
        Wed, 17 Jul 2019 05:54:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2tq4dua89y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 05:54:01 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6H5s00O016478;
        Wed, 17 Jul 2019 05:54:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 05:53:59 +0000
Date:   Tue, 16 Jul 2019 22:53:58 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        agruenba@redhat.com
Subject: Re: [PATCH 7/9] iomap: move the page migration code into a separate
 file
Message-ID: <20190717055358.GB7093@magnolia>
References: <156321356040.148361.7463881761568794395.stgit@magnolia>
 <156321360519.148361.2779156857011152900.stgit@magnolia>
 <20190717050503.GG7113@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717050503.GG7113@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=728
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=781 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170073
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:05:03PM -0700, Christoph Hellwig wrote:
> I wonder if this should go with the rest of the buffered I/O code into
> buffered-io.c?  Yes, it would need an ifdef, but it is closely related
> to it in how we use the page private information.

Hmmm, I suppose the fact that we need a page migration function that
moves page_private from one page to another reflects what we do with
pages, even though we don't explicitly dereference the page private
pointer itself.

> > diff --git a/fs/iomap/migrate.c b/fs/iomap/migrate.c
> > new file mode 100644
> > index 000000000000..d8116d35f819
> > --- /dev/null
> > +++ b/fs/iomap/migrate.c
> > @@ -0,0 +1,39 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2010 Red Hat, Inc.
> > + * Copyright (c) 2016-2018 Christoph Hellwig.
> > + */
> 
> Bit if you don't want to move it, this is all new code from me from
> 2018.

Ok, will shove it all into buffered-io.c then.

--D
