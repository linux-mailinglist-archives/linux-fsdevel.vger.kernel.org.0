Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B238F1B2B81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 17:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgDUPoI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 11:44:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48790 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgDUPoI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:44:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LFYLpu158456;
        Tue, 21 Apr 2020 15:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=eOpQsTy+r52WApbn5F48tilahuPcKCpRcdAW8A4UlGA=;
 b=S2Ei/2rA/w6p0BxCFzMel9pG0tGXIyv5DeGr5XvUhFbU/FjplPPc6aqDy4JxcbEku14D
 Ve4KWY5YmbeBuXRXCsbf7lWvIDxvAxl5bn20O+GNaQ32NHoyZHCqMQSHMKcRBb10fCGM
 o/51uH2YV97a00SwX+fh06iFH6xzm0JyHmkZcBNw44/EwVbYwCA7g+aAK9IOk0hCuZIl
 1TMs2+mIycw+CdB0kyCDrT5jTqCO4edVKXuYma4P0FKbRvw+UO0hPGFNIPhOCTvXX/Ob
 XRbS6J5OBxfcOj96IpHq8uQPVw8U98ESv9zgk42yaYDfgyZ0UU5Cyh2ro1iggUA/fBsM Dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30grpgj7g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 15:43:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LFbbiG157058;
        Tue, 21 Apr 2020 15:43:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30gb90aye7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 15:43:42 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03LFhcFu029521;
        Tue, 21 Apr 2020 15:43:38 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Apr 2020 08:43:37 -0700
Date:   Tue, 21 Apr 2020 08:43:33 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, mkleinsoft@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] hibernate: unlock swap bdev for writing when uswsusp is
 active
Message-ID: <20200421154333.GG6749@magnolia>
References: <20200229170825.GX8045@magnolia>
 <20200229180716.GA31323@dumbo>
 <20200229183820.GA8037@magnolia>
 <20200229200200.GA10970@dumbo>
 <CAJZ5v0iHaZyfuTnqJyM6u=UU=+W6yRuM_Q6iUvB2UudANuwfgA@mail.gmail.com>
 <20200420185255.GA20916@dumbo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420185255.GA20916@dumbo>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004210121
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 08:52:55PM +0200, Domenico Andreoli wrote:
> On Sun, Mar 01, 2020 at 10:35:36PM +0100, Rafael J. Wysocki wrote:
> > On Sat, Feb 29, 2020 at 9:02 PM Domenico Andreoli <domenico.andreoli@linux.com> wrote:
> > >
> > > Maybe user-space hibernation should be a separate option.
> > 
> > That actually is not a bad idea at all in my view.
> 
> I prepared a patch for this:
> https://lore.kernel.org/linux-pm/20200413190843.044112674@gmail.com/

If you succeed in making uswsusp a kconfig option, can you amend the
"!hibernation available()" test in blkdev_write_iter so that users of
in-kernel hibernate are protected against userspace swap device
scribbles, please?

--D

> Regards,
> Domenico
> 
> -- 
> rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
> ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05


