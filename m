Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23E97BB0E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 06:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjJFEcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 00:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjJFEbp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 00:31:45 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADAC11B
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 21:31:09 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-694f3444f94so1448804b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Oct 2023 21:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696566669; x=1697171469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ix+sRq4XQRGJaHRfH6WXpO9zrY7MmqagNFx/9Jnm3Cw=;
        b=1PXrH8VZnOblzuDC7aK/UG4BmUJT3RX2BSU2ovDIkmCEzmSbK9W2unlSLAt7RVfROA
         uk+A/E6ugLaxfW9A2XIFg3J2HEDzr8n6c2Aa17kn39z2vmedi082//EAkpShgfYAUSJl
         CydbxSDIB30+eGO0Da0ibs7g3KHtjrVZ8dQlY6dePodntI+1kNfJzL8U+iwhniC76fiX
         nwLztdRyyquTTwympjC0U8E4NJzkL/eB4XgzU43c6iiM3jtyBdZbOtRnfFmSAALGh7Sl
         aHvsMcP1x2wCPpxJ2lCLWZJ+qCTipRNUe8kEQnftAMToDeSR9VUp2Pqq89J2n5vMqJCC
         fDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696566669; x=1697171469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ix+sRq4XQRGJaHRfH6WXpO9zrY7MmqagNFx/9Jnm3Cw=;
        b=JEYFPikTYw72AoymVb7cV3u4QJ0GiSCmb0Kf8oW/fjgOAdhl+JHRPLzw+ez1UG08rf
         gjjPvVZMBac+z92u+5hI3QyrHiG42p+0Malxdk2PWnxcQQlFBiRiPI+X1V1maxcye6I+
         UZQpUjyIXAsIATaNeT46dEHXQSkRy6dEjB3cHPrSsfS1Bw3aegbUgXSNGhqKmwUB94Ud
         BtnJlHkX/Th+33qGoTrh2AGANo15KemOlF1XxDf+lOn5+Z4xwiiVYUlBPzO5ijArsZDZ
         KzU2TbKhGgATpflFsWovwq1ZE1G3PPisUFsGv9GfwZ/7w+O0jIlZbreaHCIODCnj/+9J
         DIxw==
X-Gm-Message-State: AOJu0YyDVebCrHUla+23aPzL79yDw7INjJZGxg25lcxZPd2g7Cbb/WvU
        zEvq/ZqYkKskAuYlkwM9B9YT6g==
X-Google-Smtp-Source: AGHT+IHgkUMxgn1iEBVFJVYZt/afT8PIq1pP/h8RwAD8SFXjlpezcSfR4j9zUmA+wytXxYHwxrQQQg==
X-Received: by 2002:a05:6a20:1447:b0:14e:3daf:fdb9 with SMTP id a7-20020a056a20144700b0014e3daffdb9mr8351717pzi.22.1696566668815;
        Thu, 05 Oct 2023 21:31:08 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id v9-20020a62a509000000b0069029a3196dsm427960pfm.184.2023.10.05.21.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 21:31:08 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qocUT-00A4Ul-1m;
        Fri, 06 Oct 2023 15:31:05 +1100
Date:   Fri, 6 Oct 2023 15:31:05 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Message-ID: <ZR+NiYIuKzEilkW3@dread.disaster.area>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d976868a-d32c-43d1-b5da-ebbc4c8de468@acm.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 05, 2023 at 03:58:38PM -0700, Bart Van Assche wrote:
> On 10/5/23 15:36, Dave Chinner wrote:
> > $ lspci |grep -i nvme
> > 03:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
> > 06:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
> > $ cat /sys/block/nvme*n1/queue/write_cache
> > write back
> > write back
> > $
> > 
> > That they have volatile writeback caches....
> 
> It seems like what I wrote has been misunderstood completely. With
> "handling a power failure cleanly" I meant that power cycling a block device
> does not result in read errors nor in reading data that has never been written.

Then I don't see what your concern is. 

Single sector writes are guaranteed atomic and have been for as long
as I've worked in this game. OTOH, multi-sector writes are not
guaranteed to be atomic - they can get torn on sector boundaries,
but the individual sectors within that write are guaranteed to be
all-or-nothing. 

Any hardware device that does not guarantee single sector write
atomicity (i.e. tears in the middle of a sector) is, by definition,
broken. And we all know that broken hardware means nothing in the
storage stack works as it should, so I just don't see what point you
are trying to make...

> Although it is hard to find information about this topic, here is what I found
> online:
> * About certain SSDs with power loss protection:
>   https://us.transcend-info.com/embedded/technology/power-loss-protection-plp
> * About another class of SSDs with power loss protection:
>   https://www.kingston.com/en/blog/servers-and-data-centers/ssd-power-loss-protection
> * About yet another class of SSDs with power loss protection:
>   https://phisonblog.com/avoiding-ssd-data-loss-with-phisons-power-loss-protection-2/

Yup, devices that behave as if they have non-volatile write caches.
Such devices have been around for more than 30 years, they operate
the same as devices without caches at all.

> So far I haven't found any information about hard disks and power failure
> handling. What I found is that most current hard disks protect data with ECC.
> The ECC mechanism should provide good protection against reading data that
> has never been written.  If a power failure occurs while a hard disk is writing
> a physical block, can this result in a read error after power is restored? If
> so, is this behavior allowed by storage standards?

If a power fail results in read errors from the storage media being
reported to the OS instead of the data that was present in the
sector before the power failure, then the device is broken. If there
is no data in the region being read because it has never been
written, then it should return zeros (no data) rather than stale
data or a media read error.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
