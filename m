Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA1B0168B56
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 02:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgBVBAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 20:00:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46282 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgBVBAn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 20:00:43 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01M0wwHb129568;
        Sat, 22 Feb 2020 01:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=VcOdDrdgp6sTa2C/PE8UFkKJ4XmWQi4h4q5KM+wvorQ=;
 b=Qw9/5EygXyPqZTaT1/YntEwofNrMw4v86w6icv8lCqeyY+8kexnyOFb7+8XLTT1hyWWJ
 tEEQxaNC0+/AWCv8NKpg0xnsAIwKPe5Pu8cyP1sB66hBY/h4m/euRaClgUVYzuBmpgs8
 1tJLQrIvuEeN9AeNQD3tE00eUTYUJoQDicvqX6hlwrP2i4OqShE5zpGZxrDPiOK0/w3Q
 Ju1O2Zc2cdfyIH1Mw2INeYU+ooi8ekwGDOxhgP/e443KVEtqp81ZRwjQkyilp18I5+Az
 SEQRfVIjVNGt2OwZZmRFTo5xmlZjCSjSg7XjD2+k4ub0ZEx3yaV87SMBmUKXlWuUsDC7 4Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2y8uddkkxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Feb 2020 01:00:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01M0wAGX166595;
        Sat, 22 Feb 2020 01:00:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 2y8udrmdde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 22 Feb 2020 01:00:16 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01M10Gmj170782;
        Sat, 22 Feb 2020 01:00:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2y8udrmdb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Feb 2020 01:00:16 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01M10Ft2027686;
        Sat, 22 Feb 2020 01:00:15 GMT
Received: from localhost (/10.145.179.117)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Feb 2020 17:00:15 -0800
Date:   Fri, 21 Feb 2020 17:00:13 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 22/24] iomap: Convert from readpages to readahead
Message-ID: <20200222010013.GH9506@magnolia>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-23-willy@infradead.org>
 <20200220154912.GC19577@infradead.org>
 <20200220165734.GZ24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220165734.GZ24185@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002220003
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 08:57:34AM -0800, Matthew Wilcox wrote:
> On Thu, Feb 20, 2020 at 07:49:12AM -0800, Christoph Hellwig wrote:
> > > +/**
> > > + * iomap_readahead - Attempt to read pages from a file.
> > > + * @rac: Describes the pages to be read.
> > > + * @ops: The operations vector for the filesystem.
> > > + *
> > > + * This function is for filesystems to call to implement their readahead
> > > + * address_space operation.
> > > + *
> > > + * Context: The file is pinned by the caller, and the pages to be read are
> > > + * all locked and have an elevated refcount.  This function will unlock
> > > + * the pages (once I/O has completed on them, or I/O has been determined to
> > > + * not be necessary).  It will also decrease the refcount once the pages
> > > + * have been submitted for I/O.  After this point, the page may be removed
> > > + * from the page cache, and should not be referenced.
> > > + */
> > 
> > Isn't the context documentation something that belongs into the aop
> > documentation?  I've never really seen the value of duplicating this
> > information in method instances, as it is just bound to be out of date
> > rather sooner than later.
> 
> I'm in two minds about it as well.  There's definitely no value in
> providing kernel-doc for implementations of a common interface ... so
> rather than fixing the nilfs2 kernel-doc, I just deleted it.  But this
> isn't just the implementation, like nilfs2_readahead() is, it's a library
> function for filesystems to call, so it deserves documentation.  On the
> other hand, there's no real thought to this on the part of the filesystem;
> the implementation just calls this with the appropriate ops pointer.
> 
> Then again, I kind of feel like we need more documentation of iomap to
> help filesystems convert to using it.  But maybe kernel-doc isn't the
> mechanism to provide that.

I think we need more documentation of the parts of iomap where it can
call back into the filesystem (looking at you, iomap_dio_ops).

I'm not opposed to letting this comment stay, though I don't see it as
all that necessary since iomap_readahead implements a callout that's
documented in vfs.rst and is thus subject to all the constraints listed
in the (*readahead) documentation.

--D
