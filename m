Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762B37BBD9F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 19:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjJFRWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 13:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjJFRWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:22:14 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D321DFB;
        Fri,  6 Oct 2023 10:22:12 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-68bed2c786eso2040948b3a.0;
        Fri, 06 Oct 2023 10:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696612932; x=1697217732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEjTiQOqZq/tiyoM37CeUZKubVviy0Hfhp5dRvbPE0c=;
        b=YsNctJ0/shhjWo097m9U0+Axz93l4J8ST/Kf8XoiTiRB3dg1Vnna5RVXyySMpcjyfx
         mGN2Ml1p9qPflgFDEDeH9sAqTyFp4+AzWGhl4kUGC3L9icHYEYQB7WnYRnBLNXR0FOnm
         W5nIa6bVRuHecrHmavjx9azWy8TXSA75mJ7FwVrINtW0GfEz6IVVzXsRYgihvLITmm+m
         8YyuamQcLUngN8XoG7XlSAwruJC8xwx3PDZtdYMaQ91sAgm0WZ6syqlya61aWiqw7e+5
         9Y/95fbENTwSRe9geoSPOXhq7prhwKuzts7xYofCYgBvhQNw51uRXeLsGDXmqL7QIauq
         NC0w==
X-Gm-Message-State: AOJu0YwwhP/Ngd9CyNIYC7TI1+B4xEx+vhpH4t29MdZ8I2DEzYe888J6
        6iHb6CT6kZq0p4Vu+4CvSko=
X-Google-Smtp-Source: AGHT+IERDatMvRwiT/bQ534S3NzSEl+A3niSuO3D+OTniQoBISPNSqc1StabEZo+erszyh/gqRzPcg==
X-Received: by 2002:a05:6a20:12d6:b0:153:4ea6:d127 with SMTP id v22-20020a056a2012d600b001534ea6d127mr10425406pzg.18.1696612931891;
        Fri, 06 Oct 2023 10:22:11 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ebdb:ae30:148c:2f33? ([2620:15c:211:201:ebdb:ae30:148c:2f33])
        by smtp.gmail.com with ESMTPSA id q17-20020a62e111000000b0069327d0b491sm1719291pfh.195.2023.10.06.10.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 10:22:10 -0700 (PDT)
Message-ID: <2bb2a4d0-4f1f-45f1-9196-f5d0d8ee1878@acm.org>
Date:   Fri, 6 Oct 2023 10:22:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
 <yq1lecktuoo.fsf@ca-mkp.ca.oracle.com>
 <db6a950b-1308-4ca1-9f75-6275118bdcf5@acm.org>
 <yq1h6n7rume.fsf@ca-mkp.ca.oracle.com>
 <34c08488-a288-45f9-a28f-a514a408541d@acm.org>
 <yq1ttr6qoqp.fsf@ca-mkp.ca.oracle.com>
 <a2077ddf-9a8f-4101-aeb9-605d6dee3c6e@acm.org>
 <ZR86Z1OcO52a4BtH@dread.disaster.area>
 <d976868a-d32c-43d1-b5da-ebbc4c8de468@acm.org>
 <ZR+NiYIuKzEilkW3@dread.disaster.area>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZR+NiYIuKzEilkW3@dread.disaster.area>
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

On 10/5/23 21:31, Dave Chinner wrote:
> Then I don't see what your concern is.
> 
> Single sector writes are guaranteed atomic and have been for as long 
> as I've worked in this game. OTOH, multi-sector writes are not 
> guaranteed to be atomic - they can get torn on sector boundaries, but
> the individual sectors within that write are guaranteed to be 
> all-or-nothing.
> 
> Any hardware device that does not guarantee single sector write 
> atomicity (i.e. tears in the middle of a sector) is, by definition, 
> broken. And we all know that broken hardware means nothing in the 
> storage stack works as it should, so I just don't see what point you 
> are trying to make...

Do you agree that the above implies that it is not useful in patch 01/21
of this series to track atomic_write_unit_min_bytes in the block layer
nor to export this information to user space? The above implies that
this parameter will always be equal to the logical block size. Writes to
a single physical block happen atomically. If there are multiple logical
blocks per physical block, the block device must serialize 
read/modify/write cycles internally.

Thanks,

Bart.
