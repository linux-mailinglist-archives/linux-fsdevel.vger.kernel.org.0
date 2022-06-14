Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E947654AC80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 10:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354361AbiFNIvP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 04:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354482AbiFNIuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:50:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90B91004;
        Tue, 14 Jun 2022 01:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655196631;
        bh=SSwUJf2qwRRbaZd++lZS60kPIH49wvQPY3CwMrUjTd4=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=KXdh+hAyaXHpmvpx6xkz9KNcxpWJY6vO2/DbaJhl4A4a5wx1yIK2KNHAIktncIdfq
         4m4P11upDW54wU1wtvxPmRRdQHZ7RwD1BzeMgAuTA5hYCpOWGHLUUQvUV5KfgMSXT+
         CIQSinCvmCpk7DJfB7yZxYnXnCVWv6fPgroAfsVE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfYPY-1nUBPJ3uJs-00fzXd; Tue, 14
 Jun 2022 10:50:30 +0200
Message-ID: <2cc67037-cf90-cca2-1655-46b92b43eba8@gmx.com>
Date:   Tue, 14 Jun 2022 16:50:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [syzbot] KASAN: use-after-free Read in copy_page_from_iter_atomic
 (2)
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, dsterba@suse.cz,
        syzbot <syzbot+d2dd123304b4ae59f1bd@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
References: <0000000000003ce9d105e0db53c8@google.com>
 <00000000000085068105e112a117@google.com>
 <20220613193912.GI20633@twin.jikos.cz> <20220614071757.GA1207@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220614071757.GA1207@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i8aMBCfBMPWuzbC1vKjvmN0BZxwNkVC5GuImuj/IaO48QbbgqQZ
 rRQUgAI0L+Es+alusDJ4kSYGqc9EoZZMJg0Vrm2aeqjxSCqdWPxEHIGC3/+qHJ4+hzQVnjg
 lO9zc7BI2hfBqFS84n10onGbzULt81Tdoryq48GgWon+x3+NwmSyyVG7QS0o+Ij2y3g0nkf
 gbnozN+NduFMqSy8f0icw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tl/jVn197pY=:7sRfFjthlxd0bqcIzmCQXu
 CzQwRPhxWErHfYPAcPR8YYj8WMjpe4pqCvMiWnkoI83ZfmT+Wy74o5/UklfG0Eb/5D80slsoe
 2a3q0tL5PgolRGX6kxDI7Jy7mHjE7QiGKxbU1o6tk+TGaDl8WfwZtxAchTEoIz646ZeVlMjeW
 VA04gq8yLWn0lSUfdm3SCrL78YiHSJAttrNQIJtFDAtCgFGdQ0KvTOK1L1X1QQfQOFsW3vlhd
 3XC0bJ2CqAuMF0XaiRLDzhC3S6GM9tSwPW+2GZFmbXJBhp92XAiosRTtpbwlK7+MqcxjyBAoZ
 kaiACgDE/4vYE4CuDl9qe/CgpsU9lFf7IErLAN/eNPdiNtLbfZujqrB+6lk8HDoXQEXeZrvpC
 OjiXBpQLSeEYsi7nt+Yq8ZT8vlX91kowuRO+Q2OYrcxmEdEclA7F+7X8nfD5WjxLGRJggzOsA
 5JEBdYwmxKPv0rqAB6sg8zU0M1W5OMONxXFZZoRIVoVUZvCRVvBOG6QUUUdwYtW8gH55Nh2Mw
 vOGEsFHIKrYgLeIMHPVvsTtFcsn+icszSlr6/9eQX16+Gjf/jwv+Om6+hvX3+0KgEJP4hkI5Z
 fB81sd1BHZWJVoBWeFQ5b1UscrAtvYS8e3+xS8t5vXj9QFQtzeVmZbAgwWLbp+btRF5yRuVZ7
 TjZhVqiFfoJi/RXJRi5vrJHnSZfoNEmwjT7WSb/G9wpSfJrchorQ/F9Np7KsM8S1ZarT4mq0n
 JVG1ubjt1pct2tH9t3rEfGBWSuuYq10wWMc+urg9lqRvFgSx3x0nTEvL5t4/9KMfoz1z6TGEu
 qnCi47NDXx1eYSkpd1Djl2ZleeEhupt2BssVNVHDImpNrEF/qzDwmUHYO/r1WTm5RSsSxxKr8
 nOJKOnnsRuip2bf7yHDkHH9PzGfrJgSeqdeRduLvSYgUfgaOhAs108m8x3edj5TibjP8IDb6A
 np2hZT8/39iCXlXiZlryfFoZS38wzYov5ea1YmYQByPPH7NlFp3oXw8+9NN4wF592ns+sgqM5
 DYwcNg5K+MoelRSnnfW6quR+lEiLQGq+XMLRDXWxfTRqFpGcWenfbfdYKTssx7yhgbwE5VlWT
 WRUmPaMYy+jrvc9z6fkPKVDJYUevWWtK9V6MZop8t7sodSjorFYUcM0yQ==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/6/14 15:17, Christoph Hellwig wrote:
> On Mon, Jun 13, 2022 at 09:39:12PM +0200, David Sterba wrote:
>> On Fri, Jun 10, 2022 at 12:10:19AM -0700, syzbot wrote:
>>> syzbot has bisected this issue to:
>>>
>>> commit 4cd4aed63125ccd4efc35162627827491c2a7be7
>>> Author: Christoph Hellwig <hch@lst.de>
>>> Date:   Fri May 27 08:43:20 2022 +0000
>>>
>>>      btrfs: fold repair_io_failure into btrfs_repair_eb_io_failure
>>
>> Josef also reported a crash and found a bug in the patch, now added as
>> fixup that'll be in for-next:
>
> The patch looks correct to me.  Two things to note here:
>
>   - I hadn't realized you had queued up the series.  I've actually
>     started to merge some of my bio work with the bio split at
>     submission time work from Qu and after a few iterations I think
>     I would do the repair code a bit differently based on that.
>     Can you just drop the series for now?
>   - I find it interesting that syzbot hits btrfs metadata repair.
>     xfstests seems to have no coverage and I could not come up with
>     a good idea how to properly test it.  Does anyone have a good
>     idea on how to intentially corrupt metadata in a deterministic
>     way?

The same way as data?

map-logical to find the location of a mirror, write 4 bytes of zero into
the location, then call it a day.

Although for metadata, you may want to choose a metadata that would
definitely get read.
Thus tree root is a good candidate.

Thanks,
Qu
