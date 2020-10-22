Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491C8296188
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 17:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901281AbgJVPPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 11:15:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59410 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509904AbgJVPPW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:15:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09MF4mnk016525;
        Thu, 22 Oct 2020 15:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=nLO8sRXFYpUQiwJEfuTU4CZ+g0g8h2RhbpdmgN5Y+ZI=;
 b=Lgfj/QcigNg8QFu6Y2BR/yBjN7jQxSJ+R2uX2FPIQz5G7kTbNftMK0zuZfQ5p5Bg3H8t
 mZpBMAT8LRgmn3uOpk2x5f3U+PWoHuEd7bebPEaTTEVE4s+E4fQ11S4g0aIAJ7srVV9T
 eZ3LRQQSlcH8L6kpvZHCjbHTsT1bPW6wIaqM7jicrDu+xi5T0gMQ9DC/iXmMry+Xrc+s
 vAQhfbIkQ61tzxH/hI9+1FpldlF9IYounWQZeiWzRLgK3KjH206xJvmZKWziWFQQq0zB
 JlOe8hbBK1SevVExweNF5I9lXsiFkUgF78RjdIZnR4/wFxcDiaD9garniIo0Ko8cISeu Tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34ak16psv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Oct 2020 15:14:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09MF1HY3176840;
        Thu, 22 Oct 2020 15:14:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 348ahyvxma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Oct 2020 15:14:29 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09MFELTb031437;
        Thu, 22 Oct 2020 15:14:21 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Oct 2020 08:14:20 -0700
Date:   Thu, 22 Oct 2020 08:14:18 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/2] block layer filter and block device snapshot module
Message-ID: <20201022151418.GR9832@magnolia>
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <71926887-5707-04a5-78a2-ffa2ee32bd68@suse.de>
 <20201021141044.GF20749@veeam.com>
 <ca8eaa40-b422-2272-1fd9-1d0a354c42bf@suse.de>
 <20201022094402.GA21466@veeam.com>
 <BL0PR04MB6514AC1B1FF313E6A14D122CE71D0@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20201022135213.GB21466@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022135213.GB21466@veeam.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220103
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 22, 2020 at 04:52:13PM +0300, Sergei Shtepa wrote:
> The 10/22/2020 13:28, Damien Le Moal wrote:
> > On 2020/10/22 18:43, Sergei Shtepa wrote:
> > > 
> > > Maybe, but the problem is that I can't imagine how to implement
> > > dm-intercept yet. 
> > > How to use dm to implement interception without changing the stack
> > > of block devices. We'll have to make a hook somewhere, isn`t it?
> > 
> > Once your dm-intercept target driver is inserted with "dmsetup" or any user land
> > tool you implement using libdevicemapper, the "hooks" will naturally be in place
> > since the dm infrastructure already does that: all submitted BIOs will be passed
> > to dm-intercept through the "map" operation defined in the target_type
> > descriptor. It is then that driver job to execute the BIOs as it sees fit.
> > 
> > Look at simple device mappers like dm-linear or dm-flakey for hints of how
> > things work (driver/md/dm-linear.c). More complex dm drivers like dm-crypt,
> > dm-writecache or dm-thin can give you hints about more features of device mapper.
> > Functions such as __map_bio() in drivers/md/dm.c are the core of DM and show
> > what happens to BIOs depending on the the return value of the map operation.
> > dm_submit_bio() and __split_and_process_bio() is the entry points for BIO
> > processing in DM.
> > 
> 
> Is there something I don't understand? Please correct me.
> 
> Let me remind that by the condition of the problem, we can't change
> the configuration of the block device stack.
> 
> Let's imagine this configuration: /root mount point on ext filesystem
> on /dev/sda1.
> +---------------+
> |               |
> |  /root        |
> |               |
> +---------------+
> |               |
> | EXT FS        |
> |               |
> +---------------+
> |               |
> | block layer   |
> |               |
> | sda queue     |
> |               |
> +---------------+
> |               |
> | scsi driver   |
> |               |
> +---------------+
> 
> We need to add change block tracking (CBT) and snapshot functionality for
> incremental backup.
> 
> With the DM we need to change the block device stack. Add device /dev/sda1
> to LVM Volume group, create logical volume, change /etc/fstab and reboot.
> 
> The new scheme will look like this:
> +---------------+
> |               |
> |  /root        |
> |               |
> +---------------+
> |               |
> | EXT FS        |
> |               |
> +---------------+
> |               |
> | LV-root       |
> |               |
> +------------------+
> |                  |
> | dm-cbt & dm-snap |
> |                  |
> +------------------+
> |               |
> | sda queue     |
> |               |
> +---------------+
> |               |
> | scsi driver   |
> |               |
> +---------------+
> 
> But I cannot change block device stack. And so I propose a scheme with
> interception.
> +---------------+
> |               |
> |  /root        |
> |               |
> +---------------+
> |               |
> | EXT FS        |
> |               |
> +---------------+   +-----------------+
> |  |            |   |                 |
> |  | blk-filter |-> | cbt & snapshot  |
> |  |            |<- |                 |
> |  +------------+   +-----------------+
> |               |
> | sda blk queue |
> |               |
> +---------------+
> |               |
> | scsi driver   |
> |               |
> +---------------+
> 
> Perhaps I can make "cbt & snapshot" inside the DM, but without interception
> in any case, it will not work. Isn't that right?

Stupid question: Why don't you change the block layer to make it
possible to insert device mapper devices after the blockdev has been set
up?

--D

> 
> -- 
> Sergei Shtepa
> Veeam Software developer.
