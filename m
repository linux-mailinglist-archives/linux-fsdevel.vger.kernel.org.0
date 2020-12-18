Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33372DDD6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 04:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgLRDuQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 22:50:16 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38480 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgLRDuQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 22:50:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BI3i0TM015386;
        Fri, 18 Dec 2020 03:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=LIwujB5reJPpKPd0TNJ4s00yRFeVMTgcLTo3JiXpJic=;
 b=LB/IHwsQbjaq0Bm2V6SUYRH59yiRsBVst/8PKZ7PZlHL/lBgsGbQN/1uC2Bav0O7+S4s
 hHC/e2c9bWlsQsvyTn1T83Ykdpq4E1aBZjroluXAiN/mblg94hgM1GtcsyawhGCp1iYj
 IsZIaTfX6bJC7Eqr1a3e/Viesx9qnb8otkChHKwWENKTYnpdDo1BWfEJrYncWMTUSu1E
 bx6DO6CceKpWYaILCZ/FuDBb79WF3hI47xEKDC2OpmSAiZTeoxXWwFFYfrsbprALpBYG
 RVVjKXals9/03C2h4kty5eWhAui1zELwe4VqEkBdO+rQXTTdpd7MloRSrW7+6gthCoNw Bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35cntmgf70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Dec 2020 03:49:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BI3jJO8147213;
        Fri, 18 Dec 2020 03:49:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 35g3rfkd11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Dec 2020 03:49:13 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BI3n95J022125;
        Fri, 18 Dec 2020 03:49:09 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Dec 2020 19:49:09 -0800
Date:   Thu, 17 Dec 2020 19:49:07 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Cc:     Jane Chu <jane.chu@oracle.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-raid@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de,
        qi.fuli@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [RFC PATCH v3 0/9] fsdax: introduce fs query to support reflink
Message-ID: <20201218034907.GG6918@magnolia>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <7fc7ba7c-f138-4944-dcc7-ce4b3f097528@oracle.com>
 <a57c44dd-127a-3bd2-fcb3-f1373572de27@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a57c44dd-127a-3bd2-fcb3-f1373572de27@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180025
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 18, 2020 at 10:44:26AM +0800, Ruan Shiyang wrote:
> 
> 
> On 2020/12/17 上午4:55, Jane Chu wrote:
> > Hi, Shiyang,
> > 
> > On 12/15/2020 4:14 AM, Shiyang Ruan wrote:
> > > The call trace is like this:
> > > memory_failure()
> > >   pgmap->ops->memory_failure()      => pmem_pgmap_memory_failure()
> > >    gendisk->fops->corrupted_range() => - pmem_corrupted_range()
> > >                                        - md_blk_corrupted_range()
> > >     sb->s_ops->currupted_range()    => xfs_fs_corrupted_range()
> > >      xfs_rmap_query_range()
> > >       xfs_currupt_helper()
> > >        * corrupted on metadata
> > >            try to recover data, call xfs_force_shutdown()
> > >        * corrupted on file data
> > >            try to recover data, call mf_dax_mapping_kill_procs()
> > > 
> > > The fsdax & reflink support for XFS is not contained in this patchset.
> > > 
> > > (Rebased on v5.10)
> > 
> > So I tried the patchset with pmem error injection, the SIGBUS payload
> > does not look right -
> > 
> > ** SIGBUS(7): **
> > ** si_addr(0x(nil)), si_lsb(0xC), si_code(0x4, BUS_MCEERR_AR) **
> > 
> > I expect the payload looks like
> > 
> > ** si_addr(0x7f3672e00000), si_lsb(0x15), si_code(0x4, BUS_MCEERR_AR) **
> 
> Thanks for testing.  I test the SIGBUS by writing a program which calls
> madvise(... ,MADV_HWPOISON) to inject memory-failure.  It just shows that
> the program is killed by SIGBUS.  I cannot get any detail from it.  So,
> could you please show me the right way(test tools) to test it?

I'm assuming that Jane is using a program that calls sigaction to
install a SIGBUS handler, and dumps the entire siginfo_t structure
whenever it receives one...

--D

> 
> --
> Thanks,
> Ruan Shiyang.
> 
> > 
> > thanks,
> > -jane
> > 
> > 
> > 
> > 
> > 
> > 
> 
> 
