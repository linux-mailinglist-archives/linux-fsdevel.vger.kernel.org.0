Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C67F532118
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 04:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiEXCme (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 22:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiEXCmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 22:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EB1E38BC0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 19:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653360150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3xLfsHx+BKpExcWq85oAqX8rbkhImP1F58c/CnSyz9g=;
        b=Hl2gsxWboZzqffBa8wD6Ixlw0kD2Q8KkV3KP/4qGblxDicGdy1KRodKJ+IYS1bzKAtG7id
        fi3tMUwahTo+xV2ubqTocOCv2nC/KzxVYNbp7t3c3pjWkI82t1uk/Q9TxXai8mnTfehzLE
        R/DTN+Z7hQnv2gJ5xjkBMMcLUfnThB4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-xvIOPrTuMUO2urDzqS2sQQ-1; Mon, 23 May 2022 22:42:28 -0400
X-MC-Unique: xvIOPrTuMUO2urDzqS2sQQ-1
Received: by mail-pj1-f69.google.com with SMTP id o8-20020a17090a9f8800b001dc9f554c7fso9092929pjp.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 19:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3xLfsHx+BKpExcWq85oAqX8rbkhImP1F58c/CnSyz9g=;
        b=hkPDX8aVcreBWBb4uvxu6efAPwhx1RBd+UqWDPa7iwRJlufO8tIJ3N6rrS9LzLfolo
         W0lDzp6veAnylDmOMzJcAH+7MeUsoYqg2HqTK+dUE/uJ/dgp1WHD2HKKfLHJ2XxmnIIz
         RC1q3z017/TmMubfsVrvQKJjyRfr3uQZj/qq7ZPxXhmBDRXPWXn7XGg4C4s4XMdfCpXn
         oEWhAn2L3rP8KQ4VUsTMPrLLnUdaXzLMvrWrCWxvhUX9lFwo70PZltYz+Wor3yG8/+oT
         VcMjuk7GiO1nLTsrNhVVo0KCATkELDvlvzWwR1s/mq2gr0UFGAoyrxyX+DbdV4xCXYPH
         PZdQ==
X-Gm-Message-State: AOAM532Y4t2zQbW1mRuyKmlQL9O5Kx8fRSd6TFocswS0HdFnEebNDCt5
        kooGnUIjalMQmqk3SCVx6MreeURLRfJf6fJSKqY6svUTC9ccF/kcCP0VwQyG0C97NixabJlco0O
        763iPirjE3PGTQuYmxXKQHoRL5w==
X-Received: by 2002:a17:902:d2c3:b0:161:ab47:8afe with SMTP id n3-20020a170902d2c300b00161ab478afemr24931976plc.8.1653360147747;
        Mon, 23 May 2022 19:42:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyA+gODlV7WWNHWEp0hE4LMnP4mMf0SiHLwgiWTIyJg7uorcVuiwskaeNLeclw6WWCrAXYIgQ==
X-Received: by 2002:a17:902:d2c3:b0:161:ab47:8afe with SMTP id n3-20020a170902d2c300b00161ab478afemr24931962plc.8.1653360147525;
        Mon, 23 May 2022 19:42:27 -0700 (PDT)
Received: from [10.72.12.81] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b001624965d83bsm19137plb.228.2022.05.23.19.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 19:42:26 -0700 (PDT)
Subject: Re: [PATCH 0/4] ceph: convert to netfs_direct_read_iter for DIO reads
To:     Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        idryomov@gmail.com
References: <20220518151111.79735-1-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <d119868d-8ff4-3ad0-4704-4ae8a1bc4cc2@redhat.com>
Date:   Tue, 24 May 2022 10:42:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220518151111.79735-1-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/18/22 11:11 PM, Jeff Layton wrote:
> This patch series is based on top of David Howells' netfs-lib branch.
>
> I previously sent an RFC set for this back in early April, but David has
> revised his netfs-lib branch since then. This converts ceph to use the
> new DIO read helper netfs_direct_read_iter instead of using our own
> routine.
>
> With this change we ought to be able to rip out a large swath of
> ceph_direct_read_write, but I've decided to wait on that until the write
> helpers are in place and we can just remove that function wholesale.
>
> David, do you mind carrying these patches in your tree? Given that they
> depend on your netfs-lib branch, it's probably simpler to do it that way
> rather than have us base the ceph-client master branch on yours. If
> conflicts crop up, we can revisit that approach though.
>
> David Howells (1):
>    ceph: Use the provided iterator in ceph_netfs_issue_op()
>
> Jeff Layton (3):
>    netfs: fix sense of DIO test on short read
>    ceph: enhance dout messages in issue_read codepaths
>    ceph: switch to netfs_direct_read_iter
>
>   fs/ceph/addr.c | 55 +++++++++++++++++++++++++++++++++-----------------
>   fs/ceph/file.c |  3 +--
>   fs/netfs/io.c  |  2 +-
>   3 files changed, 38 insertions(+), 22 deletions(-)
>
This series LGTM.

Reviewed-by: Xiubo Li <xiubli@redhat.com>


