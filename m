Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7867B5967
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 19:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbjJBRm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 13:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjJBRm6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:42:58 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4062290;
        Mon,  2 Oct 2023 10:42:56 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c760b34d25so444455ad.3;
        Mon, 02 Oct 2023 10:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696268576; x=1696873376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzfoNyI7EtAoSUXJSkLswvCWk9zxuBz7mX5SZWqHLNk=;
        b=bN3P0Mvn366ZZvlest09e4DPb2iJMhAv30aQacK2KmfSONzb4uZbnrSJ9rl9p65+Fe
         FT5lNKVP9Reuy5DgULAqJ6rRlWfMbiLZvV+lO4Ue5wXh6sy+WsjQx2P0pxQtKbWvsYw+
         KkcybewKnGtyZ4EuWaS299IXD26S0iBxepRzxYD6tp68GpnSvo/t0yeSArLy5iwY6OKZ
         lg1+GpHdhFFLQYwAoT4tvjFYCsvcHqS5jkUj4hcMU3R5VUt5/Ga3cgsGQqXGbQc9XW6A
         1qGyhf6Ti8MgnVcBQereDBovzhDX5KytL0jtqBoPhPAwg5+nZS3hnIjBUbG0poZk16KM
         sm9w==
X-Gm-Message-State: AOJu0YzR6ZbSBZIK5zddYKVuN5xxGFIvAxsKccXupuLfz29paGeg8RGa
        P4YFGwqUF4OHGW/ODYhOiOE=
X-Google-Smtp-Source: AGHT+IEPQSNHWLKb6e5RVZ4Bu2+fMqMDXD5b9ZwPXm+S7oNcAusoPb4P+LN1k8uh46Fuo0SUOqvb7Q==
X-Received: by 2002:a17:902:6806:b0:1c3:64f9:45ad with SMTP id h6-20020a170902680600b001c364f945admr9650084plk.48.1696268575546;
        Mon, 02 Oct 2023 10:42:55 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6ad7:f663:5f97:db57? ([2620:15c:211:201:6ad7:f663:5f97:db57])
        by smtp.gmail.com with ESMTPSA id b12-20020a170903228c00b001bdd7579b5dsm22227499plh.240.2023.10.02.10.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 10:42:55 -0700 (PDT)
Message-ID: <1b89c38e-55dc-484a-9bf3-b9d69d960ebe@acm.org>
Date:   Mon, 2 Oct 2023 10:42:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] sd: Translate data lifetime information
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <20230920191442.3701673-8-bvanassche@acm.org>
 <DM6PR04MB6575B74B6F5526C9860A56F1FCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB6575B74B6F5526C9860A56F1FCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/2/23 06:11, Avri Altman wrote:
>> sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>>                  ret = sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
>>                                           protect | fua, dld);
>>          } else if ((nr_blocks > 0xff) || (lba > 0x1fffff) ||
>> -                  sdp->use_10_for_rw || protect) {
>> +                  sdp->use_10_for_rw || protect ||
>> +                  rq->write_hint != WRITE_LIFE_NOT_SET) {
>
> Is this a typo?

I don't see a typo? Am I perhaps overlooking something?

>> +static void sd_read_io_hints(struct scsi_disk *sdkp, unsigned char *buffer)
>> +{
>> +       struct scsi_device *sdp = sdkp->device;
>> +       const struct scsi_io_group_descriptor *desc, *start, *end;
>> +       struct scsi_sense_hdr sshdr;
>> +       struct scsi_mode_data data;
>> +       int res;
>> +
>> +       res = scsi_mode_sense(sdp, /*dbd=*/0x8, /*modepage=*/0x0a,
>> +                             /*subpage=*/0x05, buffer, SD_BUF_SIZE,
>> +                             SD_TIMEOUT, sdkp->max_retries, &data, &sshdr);
>> +       if (res < 0)
>> +               return;
>> +       start = (void *)buffer + data.header_length + 16;
>> +       end = (void *)buffer + ((data.header_length + data.length)
>> +                               & ~(sizeof(*end) - 1));
>> +       /*
>> +        * From "SBC-5 Constrained Streams with Data Lifetimes": Device severs
>> +        * should assign the lowest numbered stream identifiers to permanent
>> +        * streams.
>> +        */
>> +       for (desc = start; desc < end; desc++)
>> +               if (!desc->st_enble)
>> +                       break;
> I don't see how you can conclude that the stream is permanent,
> without reading the perm bit from the stream status descriptor.

I will add code that retrieves the stream status and that checks the 
PERM bit.

>> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
>> index 84685168b6e0..1863de5ebae4 100644
>> --- a/drivers/scsi/sd.h
>> +++ b/drivers/scsi/sd.h
>> @@ -125,6 +125,7 @@ struct scsi_disk {
>>          unsigned int    physical_block_size;
>>          unsigned int    max_medium_access_timeouts;
>>          unsigned int    medium_access_timed_out;
>> +       u16             permanent_stream_count; /* maximum number of streams
>> */
>
> This comment is a bit misleading:
> The Block Limits Extension VPD page has a "maximum number of streams" field.
> Maybe avoid the unnecessary confusion?

I will change that comment or leave it out.

Thanks,

Bart.

