Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AF4725EBA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 14:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbjFGMTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 08:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240634AbjFGMTF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:19:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBBB1BE3;
        Wed,  7 Jun 2023 05:19:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 992EB219BF;
        Wed,  7 Jun 2023 12:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686140340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B3Xg67NbOS5YKdaySGyicbSsoGzlBjyHFHEFD4Mj8fk=;
        b=Zf8A5Tyivs1LBVr9z9fcut+KsQs3kcPY5GvqULx5P0MxaNd5oWQGh+1UzbHH7L+ejvrrTh
        JDmnIQJNe0G+Z00BxJB1bq4IRuImozBYRQpd4LwynxswtstxT9j1wT23SZh+ZR9kxi9nY9
        fU/9FYrR7hcLl9YyuWLg9NqNhV/Ku4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686140340;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B3Xg67NbOS5YKdaySGyicbSsoGzlBjyHFHEFD4Mj8fk=;
        b=eV5SDjF+54GbLqg30Fap2sfm11c6Xv616rnS3/fxtHlHOpZy29z55XNlWk4So5K2w2nPsG
        Z+0rka3GXG+V67DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6987D13776;
        Wed,  7 Jun 2023 12:19:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ngODGbR1gGR3QAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 07 Jun 2023 12:19:00 +0000
Message-ID: <30183892-dce6-6946-2f7a-1bc693a657a2@suse.de>
Date:   Wed, 7 Jun 2023 14:19:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/31] block: share code between disk_check_media_change
 and disk_force_media_change
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
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
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230606073950.225178-9-hch@lst.de>
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

On 6/6/23 09:39, Christoph Hellwig wrote:
> Factor the common logic between disk_check_media_change and
> disk_force_media_change into a helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/disk-events.c | 37 ++++++++++++++++---------------------
>   1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/block/disk-events.c b/block/disk-events.c
> index 8b1b63225738f8..06f325662b3494 100644
> --- a/block/disk-events.c
> +++ b/block/disk-events.c
> @@ -262,6 +262,18 @@ static unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask)
>   	return pending;
>   }
>   
> +static bool __disk_check_media_change(struct gendisk *disk, unsigned int events)
> +{
> +	if (!(events & DISK_EVENT_MEDIA_CHANGE))
> +		return false;
> +
> +	if (__invalidate_device(disk->part0, true))
> +		pr_warn("VFS: busy inodes on changed media %s\n",
> +			disk->disk_name);
> +	set_bit(GD_NEED_PART_SCAN, &disk->state);
> +	return true;
> +}
> +
>   /**
>    * disk_check_media_change - check if a removable media has been changed
>    * @disk: gendisk to check
> @@ -274,18 +286,9 @@ static unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask)
>    */
>   bool disk_check_media_change(struct gendisk *disk)
>   {
> -	unsigned int events;
> -
> -	events = disk_clear_events(disk, DISK_EVENT_MEDIA_CHANGE |
> -				   DISK_EVENT_EJECT_REQUEST);
> -	if (!(events & DISK_EVENT_MEDIA_CHANGE))
> -		return false;
> -
> -	if (__invalidate_device(disk->part0, true))
> -		pr_warn("VFS: busy inodes on changed media %s\n",
> -			disk->disk_name);
> -	set_bit(GD_NEED_PART_SCAN, &disk->state);
> -	return true;
> +	return __disk_check_media_change(disk,
> +			disk_clear_events(disk, DISK_EVENT_MEDIA_CHANGE |
> +						DISK_EVENT_EJECT_REQUEST));

Can you move the call to disk_clear_events() out of the call to 
__disk_check_media_change()?
I find this pattern hard to read.

Cheers,

Hannes

