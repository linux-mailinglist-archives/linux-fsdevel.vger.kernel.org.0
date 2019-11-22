Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A786E10682C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 09:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKVIij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 03:38:39 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43816 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfKVIij (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 03:38:39 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM8ZVbY195913;
        Fri, 22 Nov 2019 08:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=WTM18YWQ1cM3mzHoTUydCbnnPVUiFtDYoYFk0U4GsgI=;
 b=QrM3gVoNsZnLCLt5F0bp4TEdTP0ShkGYIFQLzNSXyoyD2Weg0LAABxoqm1I2iwF+M2P+
 2iiIAiStz3c2uBk0T3f9sOrRpLvPTJ7nGzQqa5ThyyE8FP5IODlwQUFqudPee7MbP4E4
 NhV6JV5iyrRkwLPFLcHo86s0F04uLDSuaHekC/dQA6POWs98Z1XteyP2ws993Wu+P1LM
 otC5d8qESast0kHW7L8ECwZ+4Yy0Ffi8A3l9M18rdI9cJ62niuWAIoOfn4lpsKJU3jfW
 KluaN5TrViWHDTGVh1p8jDe2WlAY4/cynOqZOlN7nsuI1/26ZXk1s73HUhayMvuiTTIH 5A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wa9rr12dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 08:37:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM8X515106484;
        Fri, 22 Nov 2019 08:35:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2wdfry4y2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 08:35:02 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAM8Yvig025684;
        Fri, 22 Nov 2019 08:34:57 GMT
Received: from kadam (/41.210.147.129)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Nov 2019 00:34:56 -0800
Date:   Fri, 22 Nov 2019 11:34:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     "'Markus Elfring'" <Markus.Elfring@web.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "'Christoph Hellwig'" <hch@lst.de>,
        "'Daniel Wagner'" <dwagner@suse.de>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Nikolay Borisov'" <nborisov@suse.com>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        "'Valdis =?utf-8?Q?Kl=C4=93tnieks'?=" <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 04/13] exfat: add directory operations
Message-ID: <20191122083446.GG5604@kadam>
References: <20191121052618.31117-1-namjae.jeon@samsung.com>
 <CGME20191121052917epcas1p259b8cb61ab86975cabc0cf4815a8dc38@epcas1p2.samsung.com>
 <20191121052618.31117-5-namjae.jeon@samsung.com>
 <498a958f-9066-09c6-7240-114234965c1a@web.de>
 <004901d5a0e0$f7bf1030$e73d3090$@samsung.com>
 <0e17c0a7-9b40-12a4-3f3f-500b9abb66de@web.de>
 <00a001d5a10d$da529670$8ef7c350$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a001d5a10d$da529670$8ef7c350$@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911220074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911220075
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 22, 2019 at 05:21:34PM +0900, Namjae Jeon wrote:
> > The software development opinions can vary also for this change pattern
> > according to different design goals.
> > Is such a transformation just another possibility to reduce duplicate
> > source code a bit?
> I changed it without unnecessary goto abuse. Look at the next version later.
> Thanks!

Markus, could you stop adding kernel-janitors to the CC list?  None of
this is at all related to kernel-janitors.  We can't see the context and
we will never see the "next version" mentioned here.

:P

regards,
dan carpenter

