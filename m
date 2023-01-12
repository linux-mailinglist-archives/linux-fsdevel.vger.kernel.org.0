Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D22A66863D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 22:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240280AbjALV6F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 16:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjALV5d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:57:33 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A619D69525;
        Thu, 12 Jan 2023 13:49:17 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z4-20020a17090a170400b00226d331390cso22427006pjd.5;
        Thu, 12 Jan 2023 13:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H3LXhqO82WfcabPaoTrO7Wrl1oYU6tcqj0csTasRlTs=;
        b=HhQcONsmZxScJWpttKDg9E9ykRzXn286wpzbvEKuqoxWbJOTIspQvnAy1dPB6zmKnF
         3XCPOc2JmXiPin9LvoBabV3KCRO1JekPAyrw+lZXRgywSg8g8quhskfbwyNNFauSplL9
         ggk6x2DHj4yqabV1yPJroOjVEbh+XlDT37Dyba8OmXJtCMDVDFg6qZwcjO2tdi6H7O4v
         PTt2lUt7WmpQWNe7uyZMpkvBvwmcdza32qEsiwfT/ChEIdFlSk+TGQi302c4jsP6UQBd
         QQfDDqr7BNcbyOC8ZFiy8XnrfdH/OIU8FqVPoYvOAXqdHyy89g3BIIWODDKMScWb6fp7
         fprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H3LXhqO82WfcabPaoTrO7Wrl1oYU6tcqj0csTasRlTs=;
        b=G6mnV0Sd7uiND0VEcPmWOA30lREQ0KZ2Cxz/4Pd5Oory3uQF9triVfq70BzRragPHE
         w0ZgK3qP6NUywPIzgl3mZTN+vjp0NGNZz2RHBzQioHPezg3u8i7cH/GM0zgSSzd+lbE0
         /QfvFtokXn6rOVBngor2Ggp0SwQX7CZGKSadv8ZdmP+olXcLNOB75EIs3lwj4XveRix7
         xoBM5gPh5oAAtsOMrJF3jG3EOfVIoCvV9J/dMudy6oJ7uCCVp71yELkqdh33zDnOWQvk
         QVeL8fkadYHam1uRkd5/LDX09meOhDQTGedlxBfsFc16gD50XYbn0TKu/VOggHvSsXOV
         62+A==
X-Gm-Message-State: AFqh2krfkn03+wMDfLdhzGwz/fnvjlYGUyigKR550DekZQEzFFIFioxm
        5aI37uUvI9REjfvszmZUTuc=
X-Google-Smtp-Source: AMrXdXvlJ+9v2gDaJv2DvPz7xjddcCc8Z1lBn+Mvaf5cIopX6ySGYfcEoZ8MNkDSOa2MKJDTO8Sn0w==
X-Received: by 2002:a17:902:ef50:b0:189:9031:6761 with SMTP id e16-20020a170902ef5000b0018990316761mr90580560plx.22.1673560156748;
        Thu, 12 Jan 2023 13:49:16 -0800 (PST)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090341c300b00192f4fbdeb5sm12702164ple.102.2023.01.12.13.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 13:49:15 -0800 (PST)
Message-ID: <c6f4014e-d199-d5e8-515c-5ffcd9946c80@gmail.com>
Date:   Thu, 12 Jan 2023 13:49:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 3/9] iov_iter: Use IOCB/IOMAP_WRITE if available rather
 than iterator direction
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>
References: <Y7+8r1IYQS3sbbVz@infradead.org>
 <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
 <167344727810.2425628.4715663653893036683.stgit@warthog.procyon.org.uk>
 <15330.1673519461@warthog.procyon.org.uk> <Y8AUTlRibL+pGDJN@infradead.org>
 <Y8BFVgdGYNQqK3sB@ZenIV>
From:   Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <Y8BFVgdGYNQqK3sB@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/12/23 09:37, Al Viro wrote:
> On Thu, Jan 12, 2023 at 06:08:14AM -0800, Christoph Hellwig wrote:
>> On Thu, Jan 12, 2023 at 10:31:01AM +0000, David Howells wrote:
>>>> And use the information in the request for this one (see patch below),
>>>> and then move this patch first in the series, add an explicit direction
>>>> parameter in the gup_flags to the get/pin helper and drop iov_iter_rw
>>>> and the whole confusing source/dest information in the iov_iter entirely,
>>>> which is a really nice big tree wide cleanup that remove redundant
>>>> information.
>>>
>>> Fine by me, but Al might object as I think he wanted the internal checks.  Al?
>>
>> I'm happy to have another discussion, but the fact the information in
>> the iov_iter is 98% redundant and various callers got it wrong and
>> away is a pretty good sign that we should drop this information.  It
>> also nicely simplified the API.
> 
> I have no problem with getting rid of iov_iter_rw(), but I would really like to
> keep ->data_source.  If nothing else, any place getting direction wrong is
> a trouble waiting to happen - something that is currently dealing only with
> iovec and bvec might be given e.g. a pipe.
> 
> Speaking of which, I would really like to get rid of the kludge /dev/sg is
> pulling - right now from-device requests there do the following:
> 	* copy the entire destination in (and better hope that nothing is mapped
> write-only, etc.)
> 	* form a request + bio, attach the pages with the destination copy to it
> 	* submit
> 	* copy the damn thing back to destination after the completion.
> The reason for that is (quoted in commit ecb554a846f8)
> 
> ====
>      The semantics of SG_DXFER_TO_FROM_DEV were:
>         - copy user space buffer to kernel (LLD) buffer
>         - do SCSI command which is assumed to be of the DATA_IN
>           (data from device) variety. This would overwrite
>           some or all of the kernel buffer
>         - copy kernel (LLD) buffer back to the user space.
>      
>      The idea was to detect short reads by filling the original
>      user space buffer with some marker bytes ("0xec" it would
>      seem in this report). The "resid" value is a better way
>      of detecting short reads but that was only added this century
>      and requires co-operation from the LLD.
> ====
> 
> IOW, we can't tell how much do we actually want to copy out, unless the SCSI driver
> in question is recent enough.  Note that the above had been written in 2009, so
> it might not be an issue these days.
> 
> Do we still have SCSI drivers that would not set the residual on bypass requests
> completion?  Because I would obviously very much prefer to get rid of that
> copy in-overwrite-copy out thing there - given the accurate information about
> the transfer length it would be easy to do.

(+Martin and Doug)

I'm not sure that we still need the double copy in the sg driver. It 
seems obscure to me that there is user space software that relies on 
finding "0xec" in bytes not originating from a SCSI device. 
Additionally, SCSI drivers that do not support residuals should be 
something from the past.

Others may be better qualified to comment on this topic.

Bart.
