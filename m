Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7904CE36D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 08:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiCEHeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 02:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiCEHeO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 02:34:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87B16328
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Mar 2022 23:33:24 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bi12so8703947ejb.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Mar 2022 23:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2vWrfFimlw7a7ILoyiYoEccruaTxPiuM3k59L5Zrbzg=;
        b=6vgMAORCx6g36NxRQVDr/RDg8JmNMkalkNafmgb5ERo0VmyPFdyyxb/KQ05lmfqURH
         0zB7IwifxEg0vaKJLrfVguQjIvwh+f/IpEB2rUnQK6Y10uu/tghprPFsA9gqmaQBBTlh
         y9nQR0bqKuWprrJA1sTvmtK0kLWbUUODtPwr1xUCnwqeE1bcNiz39fB5GP0atkxWdbWk
         C9U6INOaOXMsTPQKOPeeLdbthwyN7HE/M0ouxG6lKLxJlAt0BxEvY72WhsqlWoadDELQ
         5nf8YKOcwArkeGjmPGawYSOz/U3lX9EWAkkDxAXI+w26W19V0bKaS2Fgxs+GcyYaU02w
         i1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2vWrfFimlw7a7ILoyiYoEccruaTxPiuM3k59L5Zrbzg=;
        b=VH+7tgxzA7uFOlpLWWuKJX6eHeFeCmvY9SSSNC14LuqejNvc0DCVTea5+uwvu2HHTL
         hoqcRH65glYuukPesHZprZ1y0Ufj79BlAJGn5qgWbAbNCdjoGA4tPlg5cDqF0BgDC3Ux
         WEVpkZVR4Q/rfjZJ4tCrmK1uYtDkc+IdkS5LPw4vlk87pu+nvhIApHtf6ffDoiGrMRQn
         +K1OzKz4ajZv6eh18xJJgZUvK8dX5oI6dFqV2OV0lUW0j09ZR2tjdKgiSxIGQbGhy7QE
         GDD1V7yPagolfVYLq5TRddXiFZXTxyyH7ZJUVBcJ3EENoHmMvhQWu0qiWE2pT1R5HEZU
         tY3A==
X-Gm-Message-State: AOAM5338wMp3NMIAdjbV5qH+7WrQl+IgLbrx2F6nhty8efna2vA5hOiA
        qOYweiqELT4xTION+VaRqYMDeA==
X-Google-Smtp-Source: ABdhPJxF/f7q8Vb2XlJFrzoFQigG0MRiz0ymo/PaetaTdaEsScXmEpBI2Qgx93Mm2IGm0s7W8Zuzyg==
X-Received: by 2002:a17:906:974a:b0:6da:7d4b:a3a1 with SMTP id o10-20020a170906974a00b006da7d4ba3a1mr1886101ejy.454.1646465603207;
        Fri, 04 Mar 2022 23:33:23 -0800 (PST)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id bx1-20020a0564020b4100b00410f01a91f0sm3166956edb.73.2022.03.04.23.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 23:33:22 -0800 (PST)
From:   "Javier =?utf-8?B?R29uesOhbGV6?=" <javier@javigon.com>
X-Google-Original-From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Date:   Sat, 5 Mar 2022 08:33:21 +0100
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Message-ID: <20220305073321.5apdknpmctcvo3qj@ArmHalley.localdomain>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <20220304001022.GJ3927073@dread.disaster.area>
 <YiKOQM+HMZXnArKT@bombadil.infradead.org>
 <20220304224257.GN3927073@dread.disaster.area>
 <YiKY6pMczvRuEovI@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <YiKY6pMczvRuEovI@bombadil.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04.03.2022 14:55, Luis Chamberlain wrote:
>On Sat, Mar 05, 2022 at 09:42:57AM +1100, Dave Chinner wrote:
>> On Fri, Mar 04, 2022 at 02:10:08PM -0800, Luis Chamberlain wrote:
>> > On Fri, Mar 04, 2022 at 11:10:22AM +1100, Dave Chinner wrote:
>> > > On Wed, Mar 02, 2022 at 04:56:54PM -0800, Luis Chamberlain wrote:
>> > > > Thinking proactively about LSFMM, regarding just Zone storage..
>> > > >
>> > > > I'd like to propose a BoF for Zoned Storage. The point of it is
>> > > > to address the existing point points we have and take advantage of
>> > > > having folks in the room we can likely settle on things faster which
>> > > > otherwise would take years.
>> > > >
>> > > > I'll throw at least one topic out:
>> > > >
>> > > >   * Raw access for zone append for microbenchmarks:
>> > > >   	- are we really happy with the status quo?
>> > > > 	- if not what outlets do we have?
>> > > >
>> > > > I think the nvme passthrogh stuff deserves it's own shared
>> > > > discussion though and should not make it part of the BoF.
>> > >
>> > > Reading through the discussion on this thread, perhaps this session
>> > > should be used to educate application developers about how to use
>> > > ZoneFS so they never need to manage low level details of zone
>> > > storage such as enumerating zones, controlling write pointers
>> > > safely for concurrent IO, performing zone resets, etc.
>> >
>> > I'm not even sure users are really aware that given cap can be different
>> > than zone size and btrfs uses zone size to compute size, the size is a
>> > flat out lie.
>>
>> Sorry, I don't get what btrfs does with zone management has anything
>> to do with using Zonefs to get direct, raw IO access to individual
>> zones.
>
>You are right for direct raw access. My point was that even for
>filesystem use design I don't think the communication is clear on
>expectations. Similar computation need to be managed by fileystem
>design, for instance.

Dave,

I understand that you point to ZoneFS for this. It is true that it was
presented at the moment as the way to do raw zone access from
user-space.

However, there is no users of ZoneFS for ZNS devices that I am aware of
(maybe for SMR this is a different story).  The main open-source
implementations out there for RocksDB that are being used in production
(ZenFS and xZTL) rely on either raw zone block access or the generic
char device in NVMe (/dev/ngXnY). This is because having the capability
to do zone management from applications that already work with objects
fits much better.

My point is that there is space for both ZoneFS and raw zoned block
device. And regarding !PO2 zone sizes, my point is that this can be
leveraged both by btrfs and this raw zone block device.
