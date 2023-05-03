Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4F56F5E7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjECStF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjECSs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:48:59 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965291FCF;
        Wed,  3 May 2023 11:48:45 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-63b4bf2d74aso3961667b3a.2;
        Wed, 03 May 2023 11:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139725; x=1685731725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XuZdnAT/CQoJVHT3dd2kMfmEP+YdLoqLBmiyeRwGCT0=;
        b=e8NdoRKfa1X2HkE8HBLHmECQjKIVBHYK7cjvDC65b30gG04OpJtvNYuqg5ckBI0Kva
         K8+HfazqajqCOUR1eaTu1ugL9ylRT+KTMZA+RB8ih/LgD/Z9++s2KUD1UxDtH8WhQrW3
         MkWiqKjp4n9HGsz8wNWw4y4oNr0wMo/ETxxdZugNdw524z7BHsjpT8xrO3OFna+UIMQ6
         Wstz1rmZqoyfqvGuSF9B9uuDxETqLY04iJ/m123b2pfA1sR3o0BI3ls50Bygej3QqTsU
         9cCoI0ZvVu00DFVzVnR0j7hWB4F7IPc8G3x10xRNdhFBx6+u0WpIkvMcgX9OiQcii6xp
         tdqg==
X-Gm-Message-State: AC+VfDw0hjSvPL/2I0sGPuQJD9JhLSi5J9DEYPblcvTaRjbgZ5IMI1/8
        zRy2+n44rsVEXdoYkzNZ2IQ=
X-Google-Smtp-Source: ACHHUZ5F6Az63900qigR1giHZvAPngXjFjcguLu9ABSQRGHDFzMdwXwdp/xGRc4SUkbW0gFEAodEnw==
X-Received: by 2002:a05:6a20:258e:b0:ef:b02a:b35b with SMTP id k14-20020a056a20258e00b000efb02ab35bmr28209835pzd.0.1683139724862;
        Wed, 03 May 2023 11:48:44 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:c683:a90b:5f41:5878? ([2620:15c:211:201:c683:a90b:5f41:5878])
        by smtp.gmail.com with ESMTPSA id b20-20020a056a0002d400b006348cb791f4sm23919397pft.192.2023.05.03.11.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 11:48:44 -0700 (PDT)
Message-ID: <81ce524d-6186-e016-f597-153d214036bf@acm.org>
Date:   Wed, 3 May 2023 11:48:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RFC 14/16] scsi: sd: Add WRITE_ATOMIC_16 support
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-15-john.g.garry@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230503183821.1473305-15-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/3/23 11:38, John Garry wrote:
> +static blk_status_t sd_setup_atomic_cmnd(struct scsi_cmnd *cmd,
> +					sector_t lba, unsigned int nr_blocks,
> +					unsigned char flags)
> +{
> +	cmd->cmd_len  = 16;
> +	cmd->cmnd[0]  = WRITE_ATOMIC_16;
> +	cmd->cmnd[1]  = flags;
> +	put_unaligned_be64(lba, &cmd->cmnd[2]);
> +	cmd->cmnd[10] = 0;
> +	cmd->cmnd[11] = 0;
> +	put_unaligned_be16(nr_blocks, &cmd->cmnd[12]);
> +	cmd->cmnd[14] = 0;
> +	cmd->cmnd[15] = 0;
> +
> +	return BLK_STS_OK;
> +}

A single space in front of the assignment operator please.

> +
>   static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>   {
>   	struct request *rq = scsi_cmd_to_rq(cmd);
> @@ -1149,6 +1166,7 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>   	unsigned int nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
>   	unsigned int mask = logical_to_sectors(sdp, 1) - 1;
>   	bool write = rq_data_dir(rq) == WRITE;
> +	bool atomic_write = !!(rq->cmd_flags & REQ_ATOMIC) && write;

Isn't the !! superfluous in the above expression? I have not yet seen 
any other kernel code where a flag test is used in a boolean expression 
and where !! occurs in front of the flag test.

Thanks,

Bart.
