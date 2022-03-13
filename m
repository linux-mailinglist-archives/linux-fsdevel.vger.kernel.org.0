Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD05C4D7437
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Mar 2022 11:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiCMKZt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Mar 2022 06:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiCMKZs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Mar 2022 06:25:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBEA2C64C;
        Sun, 13 Mar 2022 03:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647167076;
        bh=RBnTYpvhytvABdmuxOOQarUBhg0bWr+FwUypMI32+NQ=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=jgiBjpNwmt99wQkyD9f+AMvy/uGIkONBUM7TG7P4CJyASfdVjXKBe3wl9UievtfRY
         QUCbyXwBvLfRG/7d7pN1ytz/TRIwgDlfQ2E1YWOOW8gZ0CCu0nW424rvmny63236/f
         KB4A3OFldfdB633cplx0hzddJ7hBUxCutl8eOcnY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4axq-1nSmu5238Q-001fD4; Sun, 13
 Mar 2022 11:24:36 +0100
Message-ID: <88a5d138-68b0-da5f-8b08-5ddf02fff244@gmx.com>
Date:   Sun, 13 Mar 2022 18:24:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Better read bio error granularity?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eDbfbmB7YpEKXAqDHWfkxATH4FVeK7qmSSfBVYbpbU+WyG8C/N4
 FGk1JI8mNe7rIKyJEs0z9hoRNOSgwNZsT6HetEApaaUzpDl5ODQnRBlRUKD0Hnn9YhcdO/u
 pEkUY0IvhVs4x3qdwKmynNl5Tetn1FFlrxv0yr8WqUAyGHypi/tFuJqS+EsQ5tDk8GiUNTB
 RdfFaJ0pS7pcE/oulY52A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TkgtGE0/COw=:3NT/lA8cywBCJKaqQv2Gs4
 sSbNR4cEqNGTggnOBGEMRouN2YM0Iqzi9OrTcevwzPnonk3BU+CGa2ItAdLN66V7HR2phFiso
 f9EhHadDoEDQz/wD5/ERiuk7+VyhAiHxXO7CB40lS8YYymN7gz2k1MY7VAFu6E1VJhYR0EI2z
 u1bcEPP0dRA83sPJ7Ee8v8VZLoeQt6HZCdmaWuuEClSlPLL6m5tMPeZRwdzipSkD1rFz5osIo
 3Y5X9DFX9YJsJNGw8fpgZsb6J8n+Rq6zpj4OimT7++OxcXCxSVu8375sHik8GO1H155HZTDIi
 FCm9+HgRf2aIzJq4ri8yo5l7RM5NYPjuL77GmIm3oaJJgsJ4czu3/bSiZWI9f5G26yzH8KKOo
 2ZVH2ivHvkVqqLWgSc1B1apdZxOQi/w3eFzXWB4tkZ7plhV+x5DUzpiuKTEop7tgY0S3T610B
 BAgZdBxBMcii4VmUfLmsMHY21OELerleK23PxqRr5m/zmqfSThk3EbS0U2vT1x+9mfIz49UWu
 /AbYuhF8lBIXTQqpYN5kGsbUHP6BCy8h9GjQSaCaxeiKOeJDylWUcF/8X0+OYXN5V+8yOBBt7
 TFaYsh0XZwS79M0PnqXp7hPU5J6+EIGDNo2hVDmF0ucWeaK3oZS0WSJDzcoLKj/EW60hNWZ0Z
 dI6/Pk+DZ8iETDpK9tUcM0LC/QzKSyQZ9M0jFnifUyYkrsLekyB7AW2JIK1cy3bo7CZ9cEqqI
 vBFB0w1Dt2qmKKZKAi3Pbm7c5G9R9QzCrIzKvkSZgc4EgZ1oLtINTJKy3Jpo8Gwf6j781eFWD
 92f/AkRX04B6qG1uaSIj93OMyADakTDY3rZ0lvTTX57hPmMLeMmZSCf0p8TNYFj7E0CgqGihN
 V29upv5o0E3IPvvM8ocLDblN0uoW2VuI6bJVtK/FM6z507msgBcnEpO2pGGMg4YsEhPLrNIQz
 Z6iYumJPAdk3UdW1CCVD+OFbs3U116jqfByb/opAsPdav5e4H1qeH494m7QPCCvMjMRF7YaoJ
 PX+56kWtmXA9A/n+UKoxwFr9JCKFdVpmlCJ5mAUM83lSgUENy4wtlAoruzafGwxl9aKrl3k2I
 e+cQ2Zw9DIh1qw=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Since if any of the split bio got an error, the whole bio will have
bi_status set to some error number.

This is completely fine for write bio, but I'm wondering can we get a
better granularity by introducing per-bvec bi_status or using page status?


One situation is, for fs like btrfs or dm device like dm-verify, if a
large bio is submitted, say a 128K one, and one of the page failed to
pass checksum/hmac verification.

Then the whole 128K will be marked error, while in fact the rest 124K
are completely fine.


Can this be solved by something like per-vec bi_status, or using page
error status to indicate where exactly the error is?

Or is such usage case too niche (only makes sense for read, only makes
sense for fs with verification)?

Thanks,
Qu
