Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3444A9AC3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 15:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359229AbiBDOPF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 09:15:05 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58928 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240322AbiBDOPE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:15:04 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 07F2D1F38F;
        Fri,  4 Feb 2022 14:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643984103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x7Xef+LHLUOFJjJq2zLv1fwP3izEqk/6tFjtKVXKieo=;
        b=d7Njk3prV8hRniilXg/s9deMKAnPYFs5GdS70Bmm+70rRO+ce6K48fI4rpFMhZZ6lDtbxb
        ZJKCKTjLIvqpo41/2xP6jQUrmQnWomfOOWz4nxZh4VEpa5JMi3hKS9x1ufRYkQxx1KYF8R
        X2KfxyuIlFXKhCENQvezESv5XTR/EC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643984103;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x7Xef+LHLUOFJjJq2zLv1fwP3izEqk/6tFjtKVXKieo=;
        b=+An9ufe0fv2coZRexo04U1M024Rg6ufMB1+/yhsOF1ytaTXPzfgX8IJsWFnIOkqEihajpN
        BnNcKVaccT4T6SDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8AFF13AE2;
        Fri,  4 Feb 2022 14:15:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WXHDLOY0/WFfCQAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 04 Feb 2022 14:15:02 +0000
Message-ID: <befa49b3-7606-a3ce-24f7-e184e3df41a3@suse.de>
Date:   Fri, 4 Feb 2022 15:15:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        Kanchan Joshi <joshi.k@samsung.com>
References: <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <270f30df-f14c-b9e4-253f-bff047d32ff0@nvidia.com>
 <20220203153843.szbd4n65ru4fx5hx@garbanzo>
 <CGME20220203165248uscas1p1f0459e548743e6be26d13d3ed8aa4902@uscas1p1.samsung.com>
 <20220203165238.GA142129@dhcp-10-100-145-180.wdc.com>
 <20220203195155.GB249665@bgt-140510-bm01>
 <863d85e3-9a93-4d8c-cf04-88090eb4cc02@nvidia.com>
 <2bbed027-b9a1-e5db-3a3d-90c40af49e09@opensource.wdc.com>
 <9d5d0b50-2936-eac3-12d3-a309389e03bf@nvidia.com>
 <20220204082445.hczdiy2uhxfi3x2g@ArmHalley.local>
 <4d5410a5-93c3-d73c-6aeb-2c1c7f940963@nvidia.com>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
In-Reply-To: <4d5410a5-93c3-d73c-6aeb-2c1c7f940963@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/4/22 10:58, Chaitanya Kulkarni wrote:
> On 2/4/22 12:24 AM, Javier González wrote:
[ .. ]
>> For a software-only solution, we have experimented with something
>> similar to the nvme-debug code tha Mikulas is proposing. Adam pointed to
>> the nvme-loop target as an alternative and this seems to work pretty
>> nicely. I do not believe there should be many changes to support copy
>> offload using this.
>>
> 
> If QEMU is so incompetent then we need to add every big feature into
> the NVMeOF test target so that we can test it better ? is that what
> you are proposing ? since if we implement one feature, it will be
> hard to nack any new features that ppl will come up with
> same rationale "with QEMU being slow and hard to test race
> conditions etc .."
> 

How would you use qemu for bare-metal testing?

> and if that is the case why we don't have ZNS NVMeOF target
> memory backed emulation ? Isn't that a bigger and more
> complicated feature than Simple Copy where controller states
> are involved with AENs ?
> 
> ZNS kernel code testing is also done on QEMU, I've also fixed
> bugs in the ZNS kernel code which are discovered on QEMU and I've not
> seen any issues with that. Given that simple copy feature is way smaller
> than ZNS it will less likely to suffer from slowness and etc (listed
> above) in QEMU.
> 
> my point is if we allow one, we will be opening floodgates and we need
> to be careful not to bloat the code unless it is _absolutely
> necessary_ which I don't think it is based on the simple copy
> specification.
> 

I do have a slightly different view on the nvme target code; it should 
provide the necessary means to test the nvme host code.
And simple copy is on of these features, especially as it will operate 
as an exploiter of the new functionality.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
