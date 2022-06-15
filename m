Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11B454D3B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 23:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349740AbiFOV1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 17:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349710AbiFOV1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:27:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BFC167C7;
        Wed, 15 Jun 2022 14:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655328434;
        bh=sewS1k19E5zNFt7guGx8ADD0uovsZroqX/MykOeNoAw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZaY29LgSeKsC0VKC0SfEO8gCT/mbD6Qy/5eG//rKUlfwQK32wCZyAB8p4+MeiczAs
         wEnfd+sTmcT94yqzlRVJePYywnp5EvPECoxAhy5pRe56snX/8JFtBBgpCsKSUAfHNV
         jL/7QpKzQmAvk0RCH/rLb4FqlMv8n1jXIqjxFB38=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsHru-1nhIVP2ZLu-00tnF1; Wed, 15
 Jun 2022 23:27:14 +0200
Message-ID: <00bbda63-dc00-05c0-4244-343352591d98@gmx.com>
Date:   Thu, 16 Jun 2022 05:27:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [syzbot] KASAN: use-after-free Read in copy_page_from_iter_atomic
 (2)
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     dsterba@suse.cz,
        syzbot <syzbot+d2dd123304b4ae59f1bd@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
References: <0000000000003ce9d105e0db53c8@google.com>
 <00000000000085068105e112a117@google.com>
 <20220613193912.GI20633@twin.jikos.cz> <20220614071757.GA1207@lst.de>
 <2cc67037-cf90-cca2-1655-46b92b43eba8@gmx.com>
 <20220615132147.GA18252@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220615132147.GA18252@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GzvWUv7j+dS6fGBh0O76pQHRuv0QctvPBDKfUco4+Y/GlL/5y5g
 BXHYTJT9fnyYxlKhn1+btWdWvWOiF9BDnLfCq+EChmasKSAq6b9B1pCQq6ZQASuejlOodGV
 HN32edj0jLN7bwq3m5m0D0pObpIh6RNHWquJ644IBNrDdnIdMTXGq0sbFfGfNtFwiDuTyIw
 bbtKn1jfl54A+36cVRM4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lmKkDBBaQN4=:jf9gSILfZGEkHNseXPaNRe
 PvP7u+k40FY2CY2c0qVJJZBB/SSwTJDnZaUJ+SDpqeZrdOVsk4C8rtHyoZ8VARRoOxw5VTHmO
 Ccz1d/+zDolUMSDJN/JxkTSUDCi2OKfQeM8YN7zQyU1v+Pg8h/hVzRfH+sXiLqZHpm7yImcXe
 Zns22cRY5ahuRaE2oWaY1UC1+UNPve57Dv7F1pFGJQVGEqTOvkI1xzJuM8qT/ieBd55fD/oAs
 +55imKkenFxKoBNFuRBqJtrb98zaAbF0NbNBl5pktTcEOsz1cjYh4KKWMFNa5qnu3lHRVjFW3
 ONRUrJDpOunQSHpCP8sruk9PrSwAmxUHeIWZdGTY7XIfJUMs/ISyhdsYDW1cMmK2JGnUtyp0q
 /5fzm0FFf6xdr6G9q4cwF1q2jsuHIV+y7uKkqGyNicAXak9LPk7aXkU6Mnw0WYUKFdBmMPYTJ
 8TvJRrLCXnJB4RQGlAe2KNe3jelUpxv0Ei6DJqn7gTb5tiESBPwTu7NHZ7EcZ+io2rjhfrJ7y
 Y/FP/JpHG1b//XFXHUbQTCvbMJ/43T/wrLGtw3wwa2RDgtWGdP+XwIGL5sAlQODdEKXMR2hxa
 L6yL2jOirN64cSOHfNuQ5aHJ9fhfqmezh1imJwI7+nWdkjiKYZMgucyVWFqTwZAyclAj4jLka
 eSVL2A07OUVdeB6IDpq4LW4KFqX+HFtZD566Dw61X8vjl4W2kSyTdZknPV/eatpzAEQKJ+YA3
 +wvPTCK/09H35naTvpU8cdM9FDkWK2rEQHZZpBSlCC0D6F+x3GT0XL2fj+v9j+51RUk2Q4Hbc
 ByLPN/HiArHr1xbq6ktyJEjpMmjMQMv30Vq/4BM6ZqJty8OHCs7dnwqBo1RxgcaDcglFBAy6r
 Wwsy3UqRjM3N3/IsstSmsF1f112zJKzsOYGBVU4n+YxJgSKiRC7yDB2VPVt3e6jdeK3Y8m5gg
 qq53Pz/u7c4wKhvf5ASPAnB2ygA748E+2SLwxVHmnm0UFKhZJCJA+GnZsL21qOCyZ6N0bei8M
 QRln+yhh05sPLbVNlsPEmewJAHICI57FsNDrKog79AJsQEEtviKYHZqb1O8GsrBevAn4KBoZi
 Xr+vzv/l0huLKyq0FCz7buQROHIxWvDxZDm22i6sWCwe/AwVl79didzmQ==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/6/15 21:21, Christoph Hellwig wrote:
> On Tue, Jun 14, 2022 at 04:50:22PM +0800, Qu Wenruo wrote:
>> The same way as data?
>>
>> map-logical to find the location of a mirror, write 4 bytes of zero int=
o
>> the location, then call it a day.
>>
>> Although for metadata, you may want to choose a metadata that would
>> definitely get read.
>> Thus tree root is a good candidate.
>
> And how do I find out the logic address of the tree root?

For tree root, "btrfs ins dump-super <dev> | grep '^root\s'.

For other tree blocks, "btrfs ins dump-tree <dev>" then with other other
keywords to grab.

Thanks,
Qu
