Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1106E29582B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 07:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508097AbgJVF61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 01:58:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:59080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409361AbgJVF61 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 01:58:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15CBCAC55;
        Thu, 22 Oct 2020 05:58:25 +0000 (UTC)
Subject: Re: [PATCH 0/2] block layer filter and block device snapshot module
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hch@infradead.org" <hch@infradead.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <71926887-5707-04a5-78a2-ffa2ee32bd68@suse.de>
 <20201021141044.GF20749@veeam.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ca8eaa40-b422-2272-1fd9-1d0a354c42bf@suse.de>
Date:   Thu, 22 Oct 2020 07:58:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201021141044.GF20749@veeam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/21/20 4:10 PM, Sergei Shtepa wrote:
> The 10/21/2020 16:31, Hannes Reinecke wrote:
>> I do understand where you are coming from, but then we already have a
>> dm-snap which does exactly what you want to achieve.
>> Of course, that would require a reconfiguration of the storage stack on
>> the machine, which is not always possible (or desired).
> 
> Yes, reconfiguring the storage stack on a machine is almost impossible.
> 
>>
>> What I _could_ imagine would be a 'dm-intercept' thingie, which
>> redirects the current submit_bio() function for any block device, and
>> re-routes that to a linear device-mapper device pointing back to the
>> original block device.
>>
>> That way you could attach it to basically any block device, _and_ can
>> use the existing device-mapper functionality to do fancy stuff once the
>> submit_io() callback has been re-routed.
>>
>> And it also would help in other scenarios, too; with such a
>> functionality we could seamlessly clone devices without having to move
>> the whole setup to device-mapper first.
> 
> Hm...
> Did I understand correctly that the filter itself can be left approximately
> as it is, but the blk-snap module can be replaced with 'dm-intercept',
> which would use the re-route mechanism from the dm?
> I think I may be able to implement it, if you describe your idea in more
> detail.
> 
> 
Actually, once we have an dm-intercept, why do you need the block-layer 
filter at all?
 From you initial description the block-layer filter was implemented 
such that blk-snap could work; but if we have dm-intercept (and with it 
the ability to use device-mapper functionality even for normal block 
devices) there wouldn't be any need for the block-layer filter, no?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
