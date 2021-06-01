Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A849396D96
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 08:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhFAGx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 02:53:58 -0400
Received: from first.geanix.com ([116.203.34.67]:42262 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232917AbhFAGx5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 02:53:57 -0400
Received: from [192.168.100.10] (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id A7038464038;
        Tue,  1 Jun 2021 06:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1622530333; bh=iIMAOcEHY6wDQ53OPlW7P0eoOlrFgGJqpSGMuFvKKUo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YAk5/lco7wGrtaO2GbCJlrB9nzY0aUQv3nfMxhBCNoU9VT4YRZ3bcm7P1b4zQBJ7y
         EmPJ7tIOZ9FclgB6OSWsWsGBKUAdfwQSA9NmQn1fnul2vAVc3r8agOTwwLSevnZv1t
         kJaZ6Hjn3TqgrFh36Xxe/be3J6UZGm61AHi4nN0ioFUrNvsVZLgz/jEIjxehX3ua/J
         bkYUXsWHLL7L+jhfAI32oCBGW1ZhpqAF0b3Mh7ryXNZOfcdbzqi5meNqhdJ9XwyDO5
         cbLsC6Yz2rIpBdQ0Uzep+3axEEs91Mt1BVK4t+cUPvotXX2HzJtAuzSFCCrYStHuDL
         7oyK+l1xvqg0g==
Subject: Re: [RESEND]: Kernel 4.14: UBIFS+SQUASHFS: Device fails to boot after
 flashing rootfs volume
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <CAOuPNLjgpkBh9dnfNTdDcfk5HiL=HjjiB9o_=fjrm+0vP7Re2Q@mail.gmail.com>
 <CAOuPNLh_0Q9w96GKT-ogC0BBcEHgo=Hv3+c=JBcas2VgqDiyaw@mail.gmail.com>
 <CAOuPNLjmJ0YufFktJzjkyvdxwFTOpxVj5AW5gANAGSG=_yT=mQ@mail.gmail.com>
 <1762403920.6716767.1621029029246@webmail.123-reg.co.uk>
 <CAOuPNLhn90z9i6jt0-Vv4e9hjsxwYUT2Su-7SQrxy+N=HDe_xA@mail.gmail.com>
 <486335206.6969995.1621485014357@webmail.123-reg.co.uk>
 <CAOuPNLjBsm9YLtcb4SnqLYYaHPnscYq4captvCmsR7DthiWGsQ@mail.gmail.com>
 <1339b24a-b5a5-5c73-7de0-9541455b66af@geanix.com>
 <CAOuPNLiMnHJJNFBbOrMOLmnxU86ROMBaLaeFxviPENCkuKfUVg@mail.gmail.com>
 <4304c082-6fc5-7389-f883-d0adfc95ee86@geanix.com>
 <CAOuPNLigHdbu_OTpsFr7gq+nFK2Pv+4MUSrC6A6PfKfF1H1X3Q@mail.gmail.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <8b488dbf-9a2b-4c26-b377-1c150826051e@geanix.com>
Date:   Tue, 1 Jun 2021 08:52:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAOuPNLigHdbu_OTpsFr7gq+nFK2Pv+4MUSrC6A6PfKfF1H1X3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31/05/2021 04.54, Pintu Agarwal wrote:
> On Tue, 25 May 2021 at 11:07, Sean Nyekjaer <sean@geanix.com> wrote:
>> We are writing our rootfs with this command:
>> ubiupdatevol /dev/ubi0_4 rootfs.squashfs
>>
>> Please understand the differences between the UBI and UBIFS. UBI(unsorted block image) and UBIFS(UBI File System).
>> I think you want to write the squashfs to the UBI(unsorted block image).
>>
>> Can you try to boot with a initramfs, and then use ubiupdatevol to write the rootfs.squshfs.
>>
> Dear Sean, thank you so much for this suggestion.
> Just a final help I need here.
> 
> For future experiment purposes, I am trying to setup my qemu-arm
> environment using ubifs/squashfs and "nandsim" module.
> I already have a working setup for qemu-arm with busybox/initramfs.
> Now I wanted to prepare ubifs/squashfs based busybox rootfs which I
> can use for booting the mainline kernel.
> Is it possible ?> Are there already some pre-built ubifs images available which I can
> use for my qemu-arm ?
> Or, please guide me how to do it ?
> 
> I think it is more convenient to do all experiments with "nandsim"
> instead of corrupting the actual NAND hardware.
> If you have any other suggestions please let me know.
> 
> 
> Thanks,
> Pintu
> 
Hi,


I have not used qemu with nandsim :(
I would prefer testing on the actual hardware.

We have used Labgrid in the past for that.

/Sean
