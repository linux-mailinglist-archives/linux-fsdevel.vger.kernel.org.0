Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556B17692A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 12:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjGaKDt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 06:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjGaKDX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:03:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A0D212B;
        Mon, 31 Jul 2023 03:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690797681; x=1691402481; i=quwenruo.btrfs@gmx.com;
 bh=V7HRW53KRWNHhAT0gF6aXTpowH2/0UDPGsm5OAQvR8g=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=aH5wZtUKVATqzjgJIFbOSMUWK69Y8h/8V9njrZ0clUzxllv/+2ZauVdQfELtlK49+AJeOg+
 g+lZNIoVGUOFdVfYBvDmdMRDWUJqpkb1GKYZnFX2WGwIZ6piuEMtUgaAu0upB3/cKRtgXFgzH
 dZD0hZ2cViuy5Nm0Ytrt6uWix5/snWvOU+VqJQtCd2HQRIYaJ0stFyfda8i2/J/n82GteNUmh
 yn12FxfCwYdRzIYXExgUpA2ii/p7MRimjGai/QNe0SAWZplbhJQfr8+d1yhirHz3v1lpuozwH
 XxwxYc3vy1gC0UyJBkJq5+aQTEoWiJrEaBYly/svsapb/mP48/5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqJmF-1q3VHX2dXf-00nPXT; Mon, 31
 Jul 2023 12:01:21 +0200
Message-ID: <f294c55b-3855-9ec3-c66c-a698747f22e0@gmx.com>
Date:   Mon, 31 Jul 2023 18:01:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, johannes.thumshirn@wdc.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000a3d67705ff730522@google.com>
 <000000000000f2ca8f0601bef9ca@google.com> <20230731073707.GA31980@lst.de>
 <358fab94-4eaa-4977-dd69-fc39810f18e0@gmx.com>
 <ZMeC6BPCBT/5NR+S@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZMeC6BPCBT/5NR+S@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zBKcaGb0CWrRXLgnJA+3HH9Aj96Q7RaMehaENnaq8Lwzthhxqmv
 Ejv9Pz/Mzfs2gRHyWwQy2hktw6Br3wzlOsdFxj2XadZvSglxl7GJDYZ2pMizFFpd8uwSJEG
 R6cSanyPf5wJFY0aBTSnnvhWppXbA6ESl/dP/nIaWzSUyiZrB9ZJpmZWTqqKnox424NKXsa
 IgB/ZtHVCXGHXDPQ8MrJw==
UI-OutboundReport: notjunk:1;M01:P0:n8+oEF7hq+E=;i1eT+AAs9D8O1pXMFlD46dGvTCY
 TOo6LIhJ/h+qprRkzVsKgzNAUcMP9Th4c9vLsWirV1bxe7CIV/D4NVkcIHIr8NyOe0LALFEo+
 Iyihy9MwcZixExe1kMqOTL938yYHmMAagTkjbKcb5dPm1CMWTt0gt9kES8ydCqs4MX4rTHY9E
 Ggc2kQjdj6sZbUEeZGUNPjKk9vQXJocOETGzTUM0YKPYNsm7FH0IJbn8AWkNZk4dXZu6pAQ5p
 dAY+3z1UVbBMp+vDOPapzGXiwgZCfyYx9o5IWFbaDO6ovDd0a5EXRTZyJ7nPW/Jbp7KJjsEc2
 b3S36wbqMj+tyxEB7bDa0kZwedG2qKJf0T3C8VM4ukix2MxToPXJ0XQEhN5WJT1dXSM4WEETH
 dPYGyUnnDlNq+6aWIWU928UfjIgvAjjlDaNUN9thxZV5T+mNd7rDrNcBCZmpywL7z5zWHOLcU
 74qP0zaHNuJdBkvMcUbNIk4rr7U3rnzCnSnEYGuGgC4/OvnjhMfddji5AlNNezJ98WuyjUK/O
 Xxzcz+5iosuf3JpFQWVLXtiBUuaO+WMMgfIrxAgZiRZRRLJHZQzBNPpp/3HFXBk5+B582wmez
 xVIJkei8gocvHIA2/zKPofeq0KKwq0LZj6uFW+2w0I8lPjxERZZJPRgmrmO3k6UzdlY5vHfAu
 HO8QIED3vyzeLJtD7b9MTma3EtHlm03gTuVJmCUe7lp2zkHs+1Vor4fOuIWJskn0WXBzacS+T
 3FznuhUMBoyBJ8zPKvnU1TYWdoJHFG8oUcMvUvUdXMk4XYMUHRwdCU+cULan9fakzh4ojDGKc
 bsjZ+NP+dN0BFIXTPCzcGN/UxyWDgl5snDYsiz6jZAHbwLXDGb+FnZg5kg4Y9xZrCBnIrR3pe
 p2O7qZV/pjXUx0w3a3yplAkK0XkVQu8ihDL+cwg4gt2pxomDLdgeLWMXlaqRGEg8pcPKO+cWt
 RKT75dQy689hk6tjvsdOD9IC0dI=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/7/31 17:46, Christoph Hellwig wrote:
> Thanks.  I've not been able to reproduce it on the apparent bisection
> commit for more than half an hour, but running it on the originally
> reported commit reproduces it after a few minutes.  I'll see if I
> can come up with a better bisection.
>

I checked the related code, and didn't find anything obvious.

But there is a chance that the image is intentionally corrupted so that
we got a reloc root but incorrect root owner.

Thus I sent out a patch to make that triggering ASSERT() to a more
graceful exit:

https://lore.kernel.org/linux-btrfs/24881cc9caf738f6248232709d7357d3186773=
b5.1690782754.git.wqu@suse.com/T/#u

Although I never got the C reproducer to trigger, thus no confirmation
on that.

Thanks,
Qu
