Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB04B726100
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 15:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbjFGNS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbjFGNSv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:18:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8944C1735;
        Wed,  7 Jun 2023 06:18:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B2C71FDAB;
        Wed,  7 Jun 2023 13:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686143929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Udh/Vtqb23Sw8g+BkC8HMo4Q973SRGdJCkPyY7KWLNs=;
        b=AG50lh6cNYbwFkDgaT6ESY/6kXvuXC7sDHKKcw8pqjJuajtZFb5iJMjU+bUHLK8tmhUW/e
        3ggaoVJAuSiXjFOzMcU4WcpaNZCGv6jm+/3d19A6Snff4yAvXS0PckIuYdEhm38+y+iNCH
        we5Xow+88Kal0HjgD/hcxHzey97Vt2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686143929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Udh/Vtqb23Sw8g+BkC8HMo4Q973SRGdJCkPyY7KWLNs=;
        b=yrTu3ioEdQb/jvgg+opgbJOkJi/9oj9MdczoHd3QPBmppQ7hl9wTr/b/RUlZdWJ4DBVXYd
        uqhxaF5C7dZDCxAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3BEE1346D;
        Wed,  7 Jun 2023 13:18:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xHLBMriDgGQvYwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 07 Jun 2023 13:18:48 +0000
Message-ID: <82a4143b-f800-09b9-98f2-6cda791877da@suse.de>
Date:   Wed, 7 Jun 2023 15:18:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/31] block: share code between disk_check_media_change
 and disk_force_media_change
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-9-hch@lst.de>
 <30183892-dce6-6946-2f7a-1bc693a657a2@suse.de>
 <20230607122131.GB14579@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230607122131.GB14579@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/7/23 14:21, Christoph Hellwig wrote:
> On Wed, Jun 07, 2023 at 02:19:00PM +0200, Hannes Reinecke wrote:
>>> -	return true;
>>> +	return __disk_check_media_change(disk,
>>> +			disk_clear_events(disk, DISK_EVENT_MEDIA_CHANGE |
>>> +						DISK_EVENT_EJECT_REQUEST));
>>
>> Can you move the call to disk_clear_events() out of the call to
>> __disk_check_media_change()?
>> I find this pattern hard to read.
> 
> I suspect you've not done enough functional programming in your youth :)

That's why I said 'I find'; purely personal preference.
If you're happy with:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
(In my youth? One is tempted to quote Falco: "If you remember the '90s 
you haven't experienced them...")

