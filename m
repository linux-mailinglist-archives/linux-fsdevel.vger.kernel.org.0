Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C201058BFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 22:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfF0UtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 16:49:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35796 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0UtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 16:49:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5RKmlJt138548;
        Thu, 27 Jun 2019 20:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=usEbhKUubJqAyKMe84VK/QUHzNxZ7h5CLD/lV2JoXTY=;
 b=3DCpydkRs2k0EE6F6PNkDOMbVB9Qk27b9PXxp4vGhFxqa4J7vzxgEgfBjgJNPwBTjkB7
 d6ArRnjj8RxSOQiVHgbxYNcn7MEx8aXbbNRG2ZYqku5ifRCyrkKjyHaMRkirY14HPMBs
 PKn5DDYiSsZL0Ah/KIlxrVZuprWMsBn46zeZbwhTYsU5HHMZRGVMeIOM6CgLY8w2QWsA
 VaSEsRjgve8EXIVBJW+O/iomYYbsRSGwrdwX6UZzW1/IQfgzymBxQFCgeAUce8a9dIsc
 qUuZhTapslmdtC8pNOPy9dVRKO9smU5E4bjEX3BoUxqsGHLMe5ZuQsbDTEZcwQqlm6EV yQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t9cyqtb5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 20:48:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5RKlh2X056729;
        Thu, 27 Jun 2019 20:48:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t9p6vj1v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 20:48:44 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5RKmhVc024270;
        Thu, 27 Jun 2019 20:48:43 GMT
Received: from localhost (/10.145.179.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 13:48:43 -0700
Date:   Thu, 27 Jun 2019 13:48:42 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] list.h: add list_pop and list_pop_entry helpers
Message-ID: <20190627204842.GR5171@magnolia>
References: <20190627104836.25446-1-hch@lst.de>
 <20190627104836.25446-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627104836.25446-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270239
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270240
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 27, 2019 at 12:48:24PM +0200, Christoph Hellwig wrote:
> We have a very common pattern where we want to delete the first entry
> from a list and return it as the properly typed container structure.
> 
> Add two helpers to implement this behavior.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

LGTM,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  include/linux/list.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index e951228db4b2..ba6e27d2235a 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -500,6 +500,39 @@ static inline void list_splice_tail_init(struct list_head *list,
>  	pos__ != head__ ? list_entry(pos__, type, member) : NULL; \
>  })
>  
> +/**
> + * list_pop - delete the first entry from a list and return it
> + * @list:	the list to take the element from.
> + *
> + * Return the list entry after @list.  If @list is empty return NULL.
> + */
> +static inline struct list_head *list_pop(struct list_head *list)
> +{
> +	struct list_head *pos = READ_ONCE(list->next);
> +
> +	if (pos == list)
> +		return NULL;
> +	list_del(pos);
> +	return pos;
> +}
> +
> +/**
> + * list_pop_entry - delete the first entry from a list and return the
> + *			containing structure
> + * @list:	the list to take the element from.
> + * @type:	the type of the struct this is embedded in.
> + * @member:	the name of the list_head within the struct.
> + *
> + * Return the containing structure for the list entry after @list.  If @list
> + * is empty return NULL.
> + */
> +#define list_pop_entry(list, type, member)			\
> +({								\
> +	struct list_head *pos__ = list_pop(list);		\
> +								\
> +	pos__ ? list_entry(pos__, type, member) : NULL;		\
> +})
> +
>  /**
>   * list_next_entry - get the next element in list
>   * @pos:	the type * to cursor
> -- 
> 2.20.1
> 
