Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344731C663E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 05:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEFDWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 23:22:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45170 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgEFDWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 23:22:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0463HmrV168030;
        Wed, 6 May 2020 03:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=emyg0heyYIZN3i1/6CvPV9EO/3L0WNJTfnpzvb2DuVU=;
 b=wIG48GxDEAJdsYBcn75Ydu9AfXkhZ/U6rZkShFojVOp9+O+vwCFSHHcr2ThpxBDMyfa2
 2Tx0fKIjcHE2MD/0g2zfpKi+kutx1g2HX8aoaSBdmw98G7w3DY69b36HiEltnBYvdTxe
 eRZsrLMAySdrW4AFidYbvKH68MfBYNtmvMDBavHI69mksYA0Bqs7dQAtDQqfTDHg3UyI
 3VzMpWBpgKqmYcQZGe9vHVvRT4aGAST17VNc7O9NHqUw1tkcR51a6MfIUnxtHwIpbs7n
 9w3D0+VcwZxDv9OjBIWYkUUgD+u2PtrGahszx8k0hPQJ7e4wEeKZ36Uokz2Idm+DkIEa aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30s09r81n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 03:21:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0463Hk8R180967;
        Wed, 6 May 2020 03:21:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30t1r6mwt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 03:21:58 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0463Ls47021729;
        Wed, 6 May 2020 03:21:54 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 May 2020 20:21:54 -0700
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v9 08/11] scsi: sd_zbc: emulate ZONE_APPEND commands
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
        <20200428104605.8143-9-johannes.thumshirn@wdc.com>
Date:   Tue, 05 May 2020 23:21:52 -0400
In-Reply-To: <20200428104605.8143-9-johannes.thumshirn@wdc.com> (Johannes
        Thumshirn's message of "Tue, 28 Apr 2020 19:46:02 +0900")
Message-ID: <yq1zhal929b.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060025
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Johannes,

> @@ -3665,19 +3679,19 @@ static int __init init_sd(void)
>  	if (!sd_page_pool) {
>  		printk(KERN_ERR "sd: can't init discard page pool\n");
>  		err = -ENOMEM;
> -		goto err_out_ppool;
> +		goto err_out_cdb_pool;
>  	}
>  
>  	err = scsi_register_driver(&sd_template.gendrv);
>  	if (err)
> -		goto err_out_driver;
> +		goto err_out_ppool;
>  
>  	return 0;
>  
> -err_out_driver:
> +err_out_ppool:
>  	mempool_destroy(sd_page_pool);
>  
> -err_out_ppool:
> +err_out_cdb_pool:
>  	mempool_destroy(sd_cdb_pool);
>  
>  err_out_cache:

This change seems unrelated!?

> --- a/drivers/scsi/sd.h
> +++ b/drivers/scsi/sd.h
> @@ -79,6 +79,12 @@ struct scsi_disk {
>  	u32		zones_optimal_open;
>  	u32		zones_optimal_nonseq;
>  	u32		zones_max_open;
> +	u32		*zones_wp_ofst;
> +	spinlock_t	zones_wp_ofst_lock;
> +	u32		*rev_wp_ofst;
> +	struct mutex	rev_mutex;
> +	struct work_struct zone_wp_ofst_work;
> +	char		*zone_wp_update_buf;

I agree with the comments about ofst making things harder to read. OFST
could just as easily have been a new SCSI protocol knob.

My preference is to spell it out as "offset" so it is crystal clear what
it describes, and massage the code accordingly.

> +		/*FALLTHRU*/

fallthrough; to please the static checkers.

> +	case REQ_OP_ZONE_APPEND:
> +		rq->__sector += sdkp->zones_wp_ofst[zno];
> +		/* fallthrough */

One more fallthrough;

Otherwise this looks OK.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
