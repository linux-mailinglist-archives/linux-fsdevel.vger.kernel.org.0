Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E1E5ADB72
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 00:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiIEWfI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 18:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIEWfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 18:35:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C3F18E0A;
        Mon,  5 Sep 2022 15:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662417288;
        bh=snPOLToQ2XOWxW0yK26U6ttl93sI1Cim7EJSicdoCzw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gAF+SLdvbu+rwxX//FDNp+TXH7va3wTcS8GYo6WEMQ2vBbT/px8fTGY2zaqM+AkwI
         ok95YacaPrC5jmNuaEQcEKsBJ8LAX85oH9un0dnWIz+zkJZBiI7yfzK71RSAPsbnuJ
         tjbJ0H/nPtaLPP6kvkjEDspm9c48N4/ujxwUXUDk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1OXT-1pWsdI1l99-012sel; Tue, 06
 Sep 2022 00:34:48 +0200
Message-ID: <7e674801-2f6c-68f6-dcea-527771843587@gmx.com>
Date:   Tue, 6 Sep 2022 06:34:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 04/17] btrfs: handle checksum validation and repair at the
 storage layer
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-5-hch@lst.de>
 <ffd39ae8-a7fb-1a75-a2d5-b601cb802b9c@gmx.com> <20220905064816.GD2092@lst.de>
 <227328cc-a41c-be15-ab9f-fa81419b7348@gmx.com> <20220905143100.GA5426@lst.de>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220905143100.GA5426@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K/m2I5lP2+dgsSfRxSGOKwrDnAJTzRL0/PQmywwa3s4Z7tH3wwB
 aUKHXbeUuoR2inkJSGCx3/kYCYhjTmyDCBe29jqju4w90PtJRblqjBv7vo7rWLd07U+V0C4
 ybQcpGOs52FvPRf3Gs9dcjK8MmdsvteH+hYf6PPPNiI4L0caR9S2KguRy55MCqu55fG/AqN
 0xZcTzjJxTG4TY+QDRNhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1KKu6wgW7RY=:8/niDzmjnDFeJU+iby6cO8
 CCl6uhotITLS80cNPokzZskiUShvrbJFj9U+ALSWQBu18ZgMoIsIOMMk2KnYd+GXF2q2JLVaQ
 ST2fiZHqKTM2QRQCZ+5DBhKpKX1SLIyF5i1h4zEQv7Dn5igxPB7OBbSUccJtEkv7ulPtPXPsV
 cN2UewGa2fMTZ7etNRH/f/HtGMKEv+sEBj/EC1RCxx5zPe3xK/nSmQb9ExRr9uolz56LDx5zb
 u34Stox9UI+Kv2doEVTLEbKQNzPlxG+JGFeQkT8tENPb/hH3/B/QTB0oJnnFsDRbg6fGs1wV1
 ehY272Di/6NgGKFODwckWjpkBB2v57MmEZiI9Llyb0UgIhQtqOYTkJfRDCq0uICwhOWdNN32/
 mAcgKVTRV4JCyk70mPNbaIvWFhLGyeufxnGUB4WwSHwfQV78JgJSkaaMeqXB4kWxmzoBieiIT
 k6u6vKPUYnmK77wlzpKPTR59zkxO7N5Cno4njYcJJqC9DQQaEEZh/sL3+LyTqH3Raa2kTqjMV
 /DdJ1DlMekhfEVjmdGKbBY/1uynhchtVn6OixUmoonXcEe3AcOTPP+uqrQB4LX5iwMrEEbAwc
 GE1fGOhgMorW5rIk1o1iFZ0w+groTjARN19j6mdJh01ZKq6H5j5OAfUcuoQ1Y7OucfqrGBpdD
 PUwvsKylT0Ylk7aC/w3mn9JdH6Mw/VCkmd2NSKjlynyuy4Wll7iE4bpLNTnSXQmBSXCwVNcSE
 BSpokI+Dn7Oc9s19ExDORis/u+vspBEGoGtRGIM7lfAk898R5sqp/9DLorB4snxjx5pWyB+Mo
 5/T0NtI/BZ4pFBROYlNgKsjFP/vusijXefJfdLHQ4+qmwP0sfnHR96hL+OOOIz/ilkkiIBKYO
 aODSg6dp9GlBX9KeewCBRlt9sOFn/SeSGY0Kqqjl7jiEepu+h2WMeBduhTgkM6Sv0ZOy5+n98
 19f7Fnp7Zxrp37qUPoxbvfcfxaXsrxG+dajX38o/t7yxNjSN1NwP7DvY2gqJhaImBxn5kW+9+
 DjsQuwQZLKMqdprESA/Xgwa3sNKZPNoilxswuZn0h3bBk+aBdkuVvL4LFReZHMN+66GGKN97l
 4cLbBc6LMnCgPhyI8DGysh5EdRK9fMSCjbV2WsaBlpTRwLTKS2agR/Ki79pFHJHsWUPckXP2K
 jArUkW+Fxobs5fZSukJEAygJIs
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/9/5 22:31, Christoph Hellwig wrote:
> On Mon, Sep 05, 2022 at 02:59:33PM +0800, Qu Wenruo wrote:
>> Mostly due to the fact that metadata and data go split ways for
>> verification.
>>
>> All the verification for data happens at endio time.
>
> Yes.
>
>> While part of the verification of metadata (bytenr, csum, level,
>> tree-checker) goes at endio, but transid, checks against parent are all
>> done at btrfs_read_extent_buffer() time.
>>
>> This also means, the read-repair happens at different timing.
>
> Yes.  read-repair for metadata currently is very different than that
> from data.  But that is something that exists already in is not new
> in this series.
>
>> But what about putting all the needed metadata info (first key, level,
>> transid etc) also into bbio (using a union to take the same space of
>> data csum), so that all verification and read repair can happen at endi=
o
>> time, the same timing as data?
>
> I thought about that.  And I suspect it probably is the right thing
> to do.  I'm mostly stayed away from it because it doesn't really
> help with the goal in this series, and I also don't have good
> code coverage to fail comfortable touching the metadata checksum
> handling and repair.  I can offer this sneaky deal:  if someone
> help creating good metadata repair coverage in xfstests, I will look
> into this next.

Then may I take this work since it's mostly independent and you can
continue your existing work without being distracted?

Thanks,
Qu
