Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01002296CE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 12:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462364AbgJWKbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 06:31:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:37798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S462259AbgJWKbJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:31:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A0192ABD1;
        Fri, 23 Oct 2020 10:31:07 +0000 (UTC)
Subject: Re: [PATCH 0/2] block layer filter and block device snapshot module
To:     "hch@infradead.org" <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sergei Shtepa <sergei.shtepa@veeam.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
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
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        device-mapper development <dm-devel@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <71926887-5707-04a5-78a2-ffa2ee32bd68@suse.de>
 <20201021141044.GF20749@veeam.com>
 <ca8eaa40-b422-2272-1fd9-1d0a354c42bf@suse.de>
 <20201022094402.GA21466@veeam.com>
 <BL0PR04MB6514AC1B1FF313E6A14D122CE71D0@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20201022135213.GB21466@veeam.com> <20201022151418.GR9832@magnolia>
 <CAMM=eLfO_L-ZzcGmpPpHroznnSOq_KEWignFoM09h7Am9yE83g@mail.gmail.com>
 <20201023091346.GA25115@infradead.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d50062cd-929d-c8ff-5851-4e1d517dc4cb@suse.de>
Date:   Fri, 23 Oct 2020 12:31:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201023091346.GA25115@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/23/20 11:13 AM, hch@infradead.org wrote:
> On Thu, Oct 22, 2020 at 01:54:16PM -0400, Mike Snitzer wrote:
>> On Thu, Oct 22, 2020 at 11:14 AM Darrick J. Wong
>>> Stupid question: Why don't you change the block layer to make it
>>> possible to insert device mapper devices after the blockdev has been set
>>> up?
>>
>> Not a stupid question.  Definitely something that us DM developers
>> have wanted to do for a while.  Devil is in the details but it is the
>> right way forward.
>>
> 
> Yes, I think that is the right thing to do.  And I don't think it should
> be all that hard.  All we'd need in the I/O path is something like the
> pseudo-patch below, which will allow the interposer driver to resubmit
> bios using submit_bio_noacct as long as the driver sets BIO_INTERPOSED.
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ac00d2fa4eb48d..3f6f1eb565e0a8 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1051,6 +1051,9 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
>   		return BLK_QC_T_NONE;
>   	}
>   
> +	if (blk_has_interposer(bio->bi_disk) &&
> +	    !(bio->bi_flags & BIO_INTERPOSED))
> +		return __submit_bio_interposed(bio);
>   	if (!bio->bi_disk->fops->submit_bio)
>   		return __submit_bio_noacct_mq(bio);
>   	return __submit_bio_noacct(bio);
> 
My thoughts went more into the direction of hooking into ->submit_bio, 
seeing that it's a NULL pointer for most (all?) block drivers.

But sure, I'll check how the interposer approach would turn out.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
