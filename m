Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EA21B8288
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 01:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDXXrH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 19:47:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36120 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgDXXrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 19:47:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03ONgjbO143506;
        Fri, 24 Apr 2020 23:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=kr0ezienOi1AcR+QZub9HSBptjuxq1qJkU9+y/9DssU=;
 b=APhXgpEycfEgLDNzW9Rm6NTTYoodaYnvz+xz+S9OifUolhv69pq/1sLxVF79AfNazlyC
 Q7dCnOkSUrxI0BP1yVXQnF/SxnG+j4ZZdj2NMp+mSy7wUQOx04GSB6YIFuU2pKK4LvnL
 bFLiXk+guXTF9S2z2+VQp+JxryYZxX9cSfVd8OlUcKpeIR/LEN51IlOhxkXNpOKdqYcx
 XMulIHVYOeSZrTBAUNyDX/Qa74Ic52jjL/uRXukGJfv3QH8LqcJE+6sf5/GqWENFCk0a
 BDLi9FkkFl9J8sbmv6e+LHecnOCpL60k9xB3/vkHj9+2ovux3Zh7L1AinH0Hu3hu2dLa Fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30ketdpwd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 23:46:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03ONcXpA002378;
        Fri, 24 Apr 2020 23:46:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30gb1qtksb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 23:46:52 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03ONknjm003732;
        Fri, 24 Apr 2020 23:46:50 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Apr 2020 16:46:49 -0700
Date:   Fri, 24 Apr 2020 16:46:47 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] fibmap: Warn and return an error in case of block >
 INT_MAX
Message-ID: <20200424234647.GX6749@magnolia>
References: <cover.1587670914.git.riteshh@linux.ibm.com>
 <e34d1ac05d29aeeb982713a807345a0aaafc7fe0.1587670914.git.riteshh@linux.ibm.com>
 <20200424191739.GA217280@gmail.com>
 <20200424225425.6521D4C040@d06av22.portsmouth.uk.ibm.com>
 <20200424234058.GA29705@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424234058.GA29705@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9601 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240179
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9601 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240180
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 24, 2020 at 04:40:58PM -0700, Matthew Wilcox wrote:
> On Sat, Apr 25, 2020 at 04:24:24AM +0530, Ritesh Harjani wrote:
> > Ok, I see.
> > Let me replace WARN() with below pr_warn() line then. If no objections,
> > then will send this in a v2 with both patches combined as Darrick
> > suggested. - (with Reviewed-by tags of Jan & Christoph).
> > 
> > pr_warn("fibmap: this would truncate fibmap result\n");
> 
> We generally don't like userspace to be able to trigger kernel messages
> on demand, so they can't swamp the logfiles.  printk_ratelimited()?

Or WARN_ON_ONCE...

--D
