Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D482B2CA03A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 11:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgLAKqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 05:46:09 -0500
Received: from zaphod.cobb.me.uk ([213.138.97.131]:44258 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgLAKqJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:46:09 -0500
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 338EE9BB36; Tue,  1 Dec 2020 10:45:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1606819525;
        bh=kaDwRYHjc0SA0LDJtUz7w3xj6SIdXPXJxz9iUbvl8Xo=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=BPN2KiQWRW2lWrNoM+TtS+ceOkcEM3YuyT98l5HrhqZD61Tx9PucTkuuM2obxt9GN
         NB+eOm1jGma8c47cys9QG6V8m3DrMyekJNd2E+Hl9XsWBZ+sZEsaCJCEGwz3kxLvUN
         KvQHUAaATByTvfM87Z19YdQEkz82liLgvIpAIAjDMyZ6Y1B17b3eo6t0D3rLq7tW7h
         klE5IwQTy7rnscT8g6Kshefun5B70tjHebNXCUSSu4AM4OEN5W2L+0flP7SDdDITCm
         dUXrWAIPQDk4dDvHMERdpzJfJwFcjo6D4No7+hJIiTTKIOhTyv726E3ugU9r10UoYZ
         rCwe+stH9RZnQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.0 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 36FEB9B84E;
        Tue,  1 Dec 2020 10:45:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1606819513;
        bh=kaDwRYHjc0SA0LDJtUz7w3xj6SIdXPXJxz9iUbvl8Xo=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=AeS8rc+h/X5CGqkIT5FuQarzzLuwphEavajKnne3h2QnQFDG+Y0u9Ws21o3GY14UX
         GdozS45eLioaBkDf4fHS2Sk5tdCddHOiAwaODFCAeweUEx0cqz8HgA8YWlZ1tl8YB6
         TIHN+8OH+uUq/Pl4wS1dE/AtLsaXajn2NfnmMJYPu3fqJu2whb7W7HeumtSt4EhgcP
         dVaUgzB91C/w+NJ5qS3kmFUb81trFb+JnEqVfTKXnWIMITZvlSPFsK2vxshq5zIbgc
         dBUoVPoPZOyekOHZp0oePdLiL5aGjVEXzzfssyrB0ixAPpcJ9kbdlu7+XFidvDQMNZ
         iR+7mKazbVJOQ==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 558BC1AA6BC;
        Tue,  1 Dec 2020 10:45:11 +0000 (GMT)
Subject: Re: [PATCH v10 05/41] btrfs: check and enable ZONED mode
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <104218b8d66fec2e4121203b90e7673ddac19d6a.1605007036.git.naohiro.aota@wdc.com>
 <51c91510-6014-0dee-a456-b50648f48156@oracle.com>
 <20201127184439.GB6430@twin.jikos.cz>
 <e3d212c1-057e-a761-6dc2-767f1e82c748@oracle.com>
 <CH2PR04MB6522A370F9D092A42E22527BE7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
 <4a784d16-b325-bf32-5ce5-0718c6bce252@oracle.com>
 <CH2PR04MB65221794BF271B9A0E76388EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <1dc43899-82de-564f-6e52-bd5b990f3887@cobb.uk.net>
Date:   Tue, 1 Dec 2020 10:45:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CH2PR04MB65221794BF271B9A0E76388EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/12/2020 02:29, Damien Le Moal wrote:
> Yes. These drives are fully backward compatible and accept random writes
> anywhere. Performance however is potentially a different story as the drive will
> eventually need to do internal garbage collection of some sort, exactly like an
> SSD, but definitely not at SSD speeds :)
> 
>>   Are we ok to replace an HM device with a HA device? Or add a HA device 
>> to a btrfs on an HM device.
> 
> We have a choice here: we can treat HA drives as regular devices or treat them
> as HM devices. Anything in between does not make sense. I am fine either way,
> the main reason being that there are no HA drive on the market today that I know
> of (this model did not have a lot of success due to the potentially very
> unpredictable performance depending on the use case).

So there will be no testing against HA drives? And no btrfs developers
will have one? And they have very different timing and possibly failure
modes from "normal" disks when they do GC?

I think there is no option but to disallow them. If HA drives start to
appear in significant numbers then that would be easy enough to change,
after suitable testing.

> Of note is that a host-aware drive will be reported by the block layer as
> BLK_ZONED_HA only as long as the drive does not have any partition. If it does,
> then the block layer will treat the drive as a regular disk.

That is a bit of a shame. With that unfortunate decision in the block
layer, system managers need to realise that partitioning an HA disk
means they may be entering territory untested by their filesystem.
