Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D906B774D0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 01:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfGZXNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 19:13:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34755 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfGZXNt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:13:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so25302821plt.1;
        Fri, 26 Jul 2019 16:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nOIJ+UNszzboHwkoBi08mG0qYHVPcqJMO4vZonVIFD4=;
        b=XQxCuBS660CxGCKdeO25BOnidyKthxV4fxKWVtqGs0EFi/kYZO1bySpBDTmwCSxhn6
         uIzVvLlToZWz0KXSCtqakP6Gly40Aj+5gHQEWtXnpsJkXJlJRwd8b3I9ws4XJvQDLcmc
         P+mXcj15MFfbT8i+ccXNh8dR/jcfbUYe0cjsfV1soTOFXOLwSoj/HTyyKlOYmQ/UhJZB
         6C6D87AWUwHM5yg35kikoH/1RAyleu2bBt31ee1tsItykDcp/4wiBKqgYl9AVvPdBVjn
         wI3/viM/RLMKHsv9dC2n3/pBiMxIAOAL6C2mZiF0lpRC56rHp7ovWmKgpPP1dVTd88Oy
         Efzg==
X-Gm-Message-State: APjAAAXWDih0pcPs2PyjJkZleRwbMbhnND96Cxl8nNo2c1GuAT/k/BdB
        nz3njlA0f4xAmuFfWKgrCSsv8R27
X-Google-Smtp-Source: APXvYqz1ru6FF8t/nDaRN9S4VT6MtDjXT/j3xWKBywz4aPMGhk01+iNL2ydwnuIsT6ix3iTKeJMcMg==
X-Received: by 2002:a17:902:9a49:: with SMTP id x9mr99490023plv.282.1564182828344;
        Fri, 26 Jul 2019 16:13:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:3044:7ea3:7e19:4d2c? ([2601:647:4800:973f:3044:7ea3:7e19:4d2c])
        by smtp.gmail.com with ESMTPSA id i9sm53611928pgo.46.2019.07.26.16.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 16:13:47 -0700 (PDT)
Subject: Re: [PATCH v6 00/16] nvmet: add target passthru commands support
To:     Logan Gunthorpe <logang@deltatee.com>,
        Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <1f202de3-1122-f4a3-debd-0d169f545047@suse.de>
 <8fd8813f-f8e1-2139-13bf-b0635a03bc30@deltatee.com>
 <175fa142-4815-ee48-82a4-18eb411db1ae@grimberg.me>
 <76f617b9-1137-48b6-f10d-bfb1be2301df@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e166c392-1548-f0bb-02bc-ced3dd85f301@grimberg.me>
Date:   Fri, 26 Jul 2019 16:13:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <76f617b9-1137-48b6-f10d-bfb1be2301df@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>> Why? if nvmet is capable, why shouldn't we support it?
> 
> I'm saying that passthru is exporting a specific controller and submits
> commands (both admin and IO) straight to the nvme_ctrl's queues. It's
> not exporting an nvme_subsys and I think it would be troublesome to do
> so; for example, if the target receives an admin command which ctrl of
> the subsystem should it send it to?

Its the same controller in the backend, what is the difference from
which fabrics controller the admin command came from?

> There's also no userspace handle for
> a given subsystem we'd maybe have to use the subsysnqn.

Umm, not sure I understand what you mean.

>>> The one case that I think makes sense to me, but I don't know how if we
>>> can handle, is if the user had a couple multipath enabled controllers
>>> with the same subsynqn
>>
>> That is usually the case, there is no multipathing defined across NVM
>> subsystems (at least for now).
>>
>>> and wanted to passthru all of them to another
>>> system and use multipath on the host with both controllers. This would
>>> require having multiple target subsystems with the same name which I
>>> don't think will work too well.
>>
>> Don't understand why this is the case?
>>
>> AFAICT, all nvmet needs to do is:
>> 1. override cimc
>> 2. allow allocating multiple controllers to the pt ctrl as long as the
>> hostnqn match.
>> 3. answer all the ana stuff.
> 
> But with this scheme the host will only see one controller and then the
> target would have to make decisions on which ctrl to send any commands
> to. Maybe it could be done for I/O but I don't see how it could be done
> correctly for admin commands.

I haven't thought this through so its very possible that I'm missing
something, but why can't the host see multiple controllers if it has
more than one path to the target?

What specific admin commands are you concerned about? What exactly
would clash?

> And from the hosts perspective, having cimc set doesn't help anything
> because we've limited the passthru code to only accept one connection
> from one host so the host can only actually have one route to this
> controller.

And I'm suggesting to allow more than a single controller given that all
controller allocations match a single hostnqn. It wouldn't make sense to
expose this controller to multiple hosts (although that might be doable
but but definitely requires non-trivial infrastructure around it).

Look, when it comes to fabrics, multipath is a fundamental piece of the
puzzle. Not supporting multipathing significantly diminishes the value
of this in my mind (assuming this answers a real-world use-case).
