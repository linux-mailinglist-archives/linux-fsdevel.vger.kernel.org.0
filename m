Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7A02AAEC4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 02:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgKIBfj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 20:35:39 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43484 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgKIBfj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 20:35:39 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A91Yj3e014180;
        Mon, 9 Nov 2020 01:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=muJfxRFhn2lydOWKxWHNNKL/op+SFa08lc1Nde0V9Pk=;
 b=jmTs2TRadqJuVgAQOTTn2t6E7eGKV74EpyaiWNADA917QtOAEMxHCopFeyNK2qT2E0P+
 75bMr/kCwv/pRwUxqWQBrd1CYct2JJMGgwle+Lq2ARxQZAxZF21N34Dz52zFu/p5+w/0
 d3rhPeKRueXLwxmi8m80M4Nv7f6yayceaM32J5RR7jddNAH3bl9aN/vDaZau9JP6aBV3
 4tZ7k6cmN7BmMf7QCwySfrZH2pLEzmi7yDtULddVV5xqqZGKL5T/dqMaedveREQlkRTw
 PUb6SH5FQYY+Yg/YTX5OPzd4UCKbpMYCm74+uav6NBzw1RXgPUWCZvr9HFjoaEh6QkqZ pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34nkhkkdgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 01:35:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A91Uwsk185503;
        Mon, 9 Nov 2020 01:33:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34p5bpv7nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 01:33:26 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A91XN2q001176;
        Mon, 9 Nov 2020 01:33:24 GMT
Received: from localhost (/10.159.144.121)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 08 Nov 2020 17:33:23 -0800
Date:   Sun, 8 Nov 2020 17:33:22 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amy Parker <enbyamy@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        Matthew Wilcox <willy@infradead.org>, dan.j.williams@intel.com,
        Jan Kara <jack@suse.cz>
Subject: Re: Best solution for shifting DAX_ZERO_PAGE to XA_ZERO_ENTRY
Message-ID: <20201109013322.GA9685@magnolia>
References: <CAE1WUT6O6uP12YMU1NaU-4CR-AaxRUhhWHY=zUtNXpHUfxrF=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE1WUT6O6uP12YMU1NaU-4CR-AaxRUhhWHY=zUtNXpHUfxrF=A@mail.gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090007
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=1 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090007
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 08, 2020 at 05:15:55PM -0800, Amy Parker wrote:
> I've been writing a patch to migrate the defined DAX_ZERO_PAGE
> to XA_ZERO_ENTRY for representing holes in files.

Why?  IIRC XA_ZERO_ENTRY ("no mapping in the address space") isn't the
same as DAX_ZERO_PAGE ("the zero page is mapped into the address space
because we took a read fault on a sparse file hole").

--D

> XA_ZERO_ENTRY
> is defined in include/linux/xarray.h, where it's defined using
> xa_mk_internal(257). This function returns a void pointer, which
> is incompatible with the bitwise arithmetic it is performed on with.
> 
> Currently, DAX_ZERO_PAGE is defined as an unsigned long,
> so I considered typecasting it. Typecasting every time would be
> repetitive and inefficient. I thought about making a new definition
> for it which has the typecast, but this breaks the original point of
> using already defined terms.
> 
> Should we go the route of adding a new definition, we might as
> well just change the definition of DAX_ZERO_PAGE. This would
> break the simplicity of the current DAX bit definitions:
> 
> #define DAX_LOCKED      (1UL << 0)
> #define DAX_PMD               (1UL << 1)
> #define DAX_ZERO_PAGE  (1UL << 2)
> #define DAX_EMPTY      (1UL << 3)
> 
> Any thoughts on this, and what could be the best solution here?
> 
> Best regards,
> Amy Parker
> (they/them)
