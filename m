Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B708B6476F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Dec 2022 21:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLHUGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Dec 2022 15:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiLHUGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:06:33 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10617126E
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Dec 2022 12:06:31 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qk9so6629133ejc.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Dec 2022 12:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gOEgB4vY7Vf9s9y/1d2I/HfeVyQozy3an9un5pb6tMU=;
        b=7qI5u/hpkQ8c7Yxg7nwAikcgMlU2u2IheFs5DzIrzIuzVfrnhfcSo7l3k0OL9Pc/ca
         6VfpEKAqKrUAzdd4zh6S/lCdiobfuWE8Lb39pd3UfiONLKHLvaSSUv9FOuGVpmvAk9s6
         OChMDYG3hFr1UraYxsbQtswpwVVvknPa5AFJECaMKGG08o42eBAgjSH6XdDYXENNK7HL
         cg3csTUicMWEYUHWfg1ycsaMaARnmJam+td4tbMgYOf41xybfZsLJMstddT4aAr/A++F
         HZO+X82l47sHBjjvANAz3Do0uh/xfZQFp3DqFK/bLFvKKNui2zER7GqT5Fqvvq77d3D6
         x8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOEgB4vY7Vf9s9y/1d2I/HfeVyQozy3an9un5pb6tMU=;
        b=AUmpvtJQXVcNJuPxBl9sbRIyIXsCxTR9TA/i8hspe9bRrwWQXVTGuw7TADxU4gtz0U
         na2au6tIIptLrrJQu0hpvcVLsmRX1C9d7o3z5EeihbYfasUNwzt6XyV2pablaVKZV1cN
         9FEk90cRM7im+ZwttheYbUdnpDBLQkamX8PprE77CGnKPZfSQIY2b1pP9hStXFODpFhu
         iT+4PubJQgZB66s7YHzFi5mTgTiwZotbs4zjcYo7YNiNsMIAdv4MMIfdWhizVmFaimgo
         VQTaK2+Ao8KQIGZtm4dFrdQoROf4lZ5RTY+FLIKGA+VWfQb2twX173dnRjN91Ht7XUlh
         b5rg==
X-Gm-Message-State: ANoB5pm2tY1HuUtQmUeayaJyQmw1V2jl3862DfP0ai2V9p9SAjkaTmuv
        KUKiGMweVh1ROpqkq5aiOndXRA==
X-Google-Smtp-Source: AA0mqf7HrAYMaBrDD1fHZj3YzDUzHOO73MBpqvB8tB4DexXbV9fvKzhG/kCAkGmyYJhepCzYf38YNw==
X-Received: by 2002:a17:906:c413:b0:7c0:edc9:9a6b with SMTP id u19-20020a170906c41300b007c0edc99a6bmr2447191ejz.41.1670529990248;
        Thu, 08 Dec 2022 12:06:30 -0800 (PST)
Received: from localhost (89.239.251.72.dhcp.fibianet.dk. [89.239.251.72])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709061da200b007b8a8fc6674sm10064658ejh.12.2022.12.08.12.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:06:29 -0800 (PST)
Date:   Thu, 8 Dec 2022 21:06:28 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, djwong@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        Johannes.Thumshirn@wdc.com, bvanassche@acm.org,
        dongli.zhang@oracle.com, jefflexu@linux.alibaba.com,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, jlayton@kernel.org,
        idryomov@gmail.com, danil.kipnis@cloud.ionos.com,
        ebiggers@google.com, jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Message-ID: <20221208200628.5hr5tvdyfxgvzpjj@ArmHalley.local>
References: <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
 <4F15C752-AE73-4F10-B5DD-C37353782111@javigon.com>
 <Y40DOJ+7WlqIwkbD@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y40DOJ+7WlqIwkbD@kbusch-mbp>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04.12.2022 20:29, Keith Busch wrote:
>On Sat, Dec 03, 2022 at 07:19:17AM +0300, Javier González wrote:
>>
>> > On 2 Dec 2022, at 17.58, Keith Busch <kbusch@kernel.org> wrote:
>> >
>> > ﻿On Fri, Dec 02, 2022 at 08:16:30AM +0100, Hannes Reinecke wrote:
>> >>> On 12/1/22 20:39, Matthew Wilcox wrote:
>> >>> On Thu, Dec 01, 2022 at 06:12:46PM +0000, Chaitanya Kulkarni wrote:
>> >>>> So nobody can get away with a lie.
>> >>>
>> >>> And yet devices do exist which lie.  I'm not surprised that vendors
>> >>> vehemently claim that they don't, or "nobody would get away with it".
>> >>> But, of course, they do.  And there's no way for us to find out if
>> >>> they're lying!
>> >>>
>> >> But we'll never be able to figure that out unless we try.
>> >>
>> >> Once we've tried we will have proof either way.
>> >
>> > As long as the protocols don't provide proof-of-work, trying this
>> > doesn't really prove anything with respect to this concern.
>>
>> Is this something we should bring to NVMe? Seems like the main disagreement can be addressed there.
>
>Yeah, proof for the host appears to require a new feature, so we'd need
>to bring this to the TWG. I can draft a TPAR if there's interest and
>have ideas on how the feature could be implemented, but I currently
>don't have enough skin in this game to sponser it.

Happy to review the TPAR, but I am in a similar situation.
