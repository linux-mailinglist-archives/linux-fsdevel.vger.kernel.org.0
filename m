Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3217B3942
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 19:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjI2R7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 13:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjI2R7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:59:19 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA76E1AC;
        Fri, 29 Sep 2023 10:59:17 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1e113555a47so1025267fac.2;
        Fri, 29 Sep 2023 10:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010357; x=1696615157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKmSy9nYMevIdhZdG3nCQj5JvLdfTswn5XDlCNJCRqs=;
        b=eTDIl/GoeNWOsScZcrUFheR/thLjVMUTLjKWbTo+Fx9Fr+c+urm7uWT/N9EUPFbGJ5
         Mwz3gpAF24pvBtwFpJ+rPS4U1ooJ+gt4EBCUIIHzeQDRxHEAIAjE2gTbLWbkizwKTeJa
         A75CUCXWhzQeSFc9kxnGUmqoaast7CxUXOpa3R623H7BwFQ1s4r3XulcOys57LDU/HPE
         R8U8i0B6NldAJGLdcXF0h1Aovima/gzHGACs9UF1GvdOVFm6Pa/8nsSNdRrqhbqQrXEf
         HPj6Y524RB7hHocogYbUxrmUw9XNjFpLvgiGjyYAtOjP9ud+bJ5iBYHC28XjET/zYuak
         N2+g==
X-Gm-Message-State: AOJu0YzhlOe++pUtPMoS/yYg1mvWkR/IDWk43KoBnmFO32+vOmn3Wfqz
        JeHTipTW0EyzPYPdZKnlXEMpiZc3w797TA==
X-Google-Smtp-Source: AGHT+IFGOtUOVVnTjR70judkp2CAL1bg7IpOYVhdJtj/g+DmpMMTkZUqHC4hofJt5GNiQMWUQXGnOA==
X-Received: by 2002:a05:6870:230d:b0:1bb:a912:9339 with SMTP id w13-20020a056870230d00b001bba9129339mr5301433oao.7.1696010356848;
        Fri, 29 Sep 2023 10:59:16 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id x28-20020a63b21c000000b00564b313d526sm15006265pge.54.2023.09.29.10.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 10:59:16 -0700 (PDT)
Message-ID: <2abb1fb8-88c6-401d-b65f-b7001b2203ec@acm.org>
Date:   Fri, 29 Sep 2023 10:59:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] scsi: sd: Add WRITE_ATOMIC_16 support
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-20-john.g.garry@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230929102726.2985188-20-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/29/23 03:27, John Garry wrote:
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

Please store the 'dld' value in the GROUP NUMBER field. See e.g.
sd_setup_rw16_cmnd().

> @@ -1139,6 +1156,7 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>   	unsigned int nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
>   	unsigned int mask = logical_to_sectors(sdp, 1) - 1;
>   	bool write = rq_data_dir(rq) == WRITE;
> +	bool atomic_write = !!(rq->cmd_flags & REQ_ATOMIC) && write;

Please leave out the superfluous "!!".

Thanks,

Bart.
