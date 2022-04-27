Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5A3511614
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 13:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiD0LAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 07:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiD0K72 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:59:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7036D22C3C1;
        Wed, 27 Apr 2022 03:37:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DE5591F747;
        Wed, 27 Apr 2022 10:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651055827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwRuU3lN9KI8hyzt5BRGcUdxQu2aFhndVDrcib1zzbI=;
        b=feYJC2od1AKLT8mJSoDbAoyzHedIgJQwZvNS3KNVkgnc7RzT6txrdyC7qHmbKtqm0eHZ1C
        nwtyIUFNi9tG48N+Y74qTSYSX6kwlgGkYQd3TgrHBB36BxazEEJwyWSiqJG/CA/Henk0as
        Q442kgxgzolK1QTcIhmgJfFSnVSSaYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651055827;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwRuU3lN9KI8hyzt5BRGcUdxQu2aFhndVDrcib1zzbI=;
        b=Z5DGjHUwr8LqYy6Y4hmCD5vvVYHZlNaZpZ9cOR3X70LSGdN3HKPIIQ+uUPD5pElrFfGesW
        b/jCF0GqeLUhBNBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 942411323E;
        Wed, 27 Apr 2022 10:37:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VQRnI9McaWJTBQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 27 Apr 2022 10:37:07 +0000
Message-ID: <a885def5-7373-28d9-6ed6-bc836864c67c@suse.de>
Date:   Wed, 27 Apr 2022 12:37:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, kbusch@kernel.org, hch@lst.de,
        Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Arnav Dawn <arnav.dawn@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <20220426101241.30100-1-nj.shetty@samsung.com>
 <CGME20220426101938epcas5p291690dd1f0e931cd9f8139daaf3f9296@epcas5p2.samsung.com>
 <20220426101241.30100-4-nj.shetty@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 03/10] block: Introduce a new ioctl for copy
In-Reply-To: <20220426101241.30100-4-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/26/22 12:12, Nitesh Shetty wrote:
> Add new BLKCOPY ioctl that offloads copying of one or more sources ranges
> to one or more destination in a device. COPY ioctl accepts a 'copy_range'
> structure that contains no of range, a reserved field , followed by an
> array of ranges. Each source range is represented by 'range_entry' that
> contains source start offset, destination start offset and length of
> source ranges (in bytes)
> 
> MAX_COPY_NR_RANGE, limits the number of entries for the IOCTL and
> MAX_COPY_TOTAL_LENGTH limits the total copy length, IOCTL can handle.
> 
> Example code, to issue BLKCOPY:
> /* Sample example to copy three entries with [dest,src,len],
> * [32768, 0, 4096] [36864, 4096, 4096] [40960,8192,4096] on same device */
> 
> int main(void)
> {
> 	int i, ret, fd;
> 	unsigned long src = 0, dst = 32768, len = 4096;
> 	struct copy_range *cr;
> 	cr = (struct copy_range *)malloc(sizeof(*cr)+
> 					(sizeof(struct range_entry)*3));
> 	cr->nr_range = 3;
> 	cr->reserved = 0;
> 	for (i = 0; i< cr->nr_range; i++, src += len, dst += len) {
> 		cr->range_list[i].dst = dst;
> 		cr->range_list[i].src = src;
> 		cr->range_list[i].len = len;
> 		cr->range_list[i].comp_len = 0;
> 	}
> 	fd = open("/dev/nvme0n1", O_RDWR);
> 	if (fd < 0) return 1;
> 	ret = ioctl(fd, BLKCOPY, cr);
> 	if (ret != 0)
> 	       printf("copy failed, ret= %d\n", ret);
> 	for (i=0; i< cr->nr_range; i++)
> 		if (cr->range_list[i].len != cr->range_list[i].comp_len)
> 			printf("Partial copy for entry %d: requested %llu, completed %llu\n",
> 								i, cr->range_list[i].len,
> 								cr->range_list[i].comp_len);
> 	close(fd);
> 	free(cr);
> 	return ret;
> }
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Javier González <javier.gonz@samsung.com>
> Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
> ---
>   block/ioctl.c           | 32 ++++++++++++++++++++++++++++++++
>   include/uapi/linux/fs.h |  9 +++++++++
>   2 files changed, 41 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
