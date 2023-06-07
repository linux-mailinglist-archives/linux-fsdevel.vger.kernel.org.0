Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69915725E4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 14:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbjFGMOQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 08:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238985AbjFGMON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:14:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AB41BD4;
        Wed,  7 Jun 2023 05:14:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 32FBE218A4;
        Wed,  7 Jun 2023 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686140051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RbDdkBkAkihlvgimUEyqaDFQQ7hWsta3TpQfoTGouF4=;
        b=YcolPPrC7jE6w3Zyqtw/FMFFlvUTz+YgmXz15Y/Ja5pGbYcQOI2xWKpEk6rOkAGv4OEQOe
        GUHXGoC7dkbxH62fllqUSMkwEBzB9qfyJl+oVpr4TOfBAt0t4eLEElqNjd3xnhlOocxLsj
        cB70lchn4Bjk/oeQCWvsAfXocb0270I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686140051;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RbDdkBkAkihlvgimUEyqaDFQQ7hWsta3TpQfoTGouF4=;
        b=u60i6Cv0BWCHzE4lMuQ5hya3mWAVv5LUT6kBJLXzktzjRnyf9Hn68uapE1JN/pfx1XLC7b
        BcGGQlzMBD2ak5AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB95513776;
        Wed,  7 Jun 2023 12:14:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ThfIOJJ0gGTVPQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 07 Jun 2023 12:14:10 +0000
Message-ID: <e9817476-c4a4-daa3-5855-1cad65f34702@suse.de>
Date:   Wed, 7 Jun 2023 14:14:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/31] cdrom: remove the unused mode argument to
 cdrom_release
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
 <20230606073950.225178-7-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230606073950.225178-7-hch@lst.de>
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
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/cdrom/cdrom.c | 2 +-
>   drivers/cdrom/gdrom.c | 2 +-
>   drivers/scsi/sr.c     | 2 +-
>   include/linux/cdrom.h | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

