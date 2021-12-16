Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F9C477343
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 14:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbhLPNhD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 08:37:03 -0500
Received: from modo.nonmodosedetiam.net ([46.101.202.131]:54584 "EHLO
        modo.nonmodosedetiam.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbhLPNhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:37:01 -0500
X-Greylist: delayed 2083 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Dec 2021 08:37:01 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rondom.de;
         s=20151017; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=43zJ/ni02jKH0OUZwYjAY0hzSO2PxcPuW1DXWX+WLb8=; b=EBmfgx0g5ReIG3CI+vmXnklH2d
        nbKXmBrnBmRK3HfGfG4JKmPrwiOTnhBcq95gf/nQwB5vgy9TNnxry2WOEsP6sUYROIsr9yY9wUk4o
        /7BDVMO5KF+4R8X5AZJGVZ6EtLRKhDkBOxev2a6e2yjWDo8tQN3SQoEj6U4T7WETGW3M=;
Received: from 82-183-19-112.customers.ownit.se ([82.183.19.112] helo=[192.168.0.215])
        by modo.nonmodosedetiam.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <rondom@rondom.de>)
        id 1mxqMJ-0006rG-TB; Thu, 16 Dec 2021 13:59:43 +0100
Message-ID: <a5969c62-dc57-7339-899e-046030c17999@gnau.info>
Date:   Thu, 16 Dec 2021 13:59:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [fuse-devel] Reconnect to FUSE session
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Robert Vasek <rvasek01@gmail.com>
Cc:     fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org, Hao Peng <flyingpenghao@gmail.com>,
        swami@cs.wisc.edu, laxmanv@qualcomm.com, dusseau@cs.wisc.edu,
        remzi@cs.wisc.edu
References: <CADVsYmhF2=Y9AktyHdvKq5=CzJBALBjKfrSu8+2+=YdkSRazpg@mail.gmail.com>
 <CAJfpegvEppXZbX25Nage463biMjWPKthr=519PSJ61yZmTavCw@mail.gmail.com>
From:   Andreas Gnau <rondom@rondom.de>
In-Reply-To: <CAJfpegvEppXZbX25Nage463biMjWPKthr=519PSJ61yZmTavCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/12/2021 15:04, Miklos Szeredi wrote:
> On Tue, 14 Dec 2021 at 13:58, Robert Vasek <rvasek01@gmail.com> wrote:
>>
>> Hello fuse-devel,
>>
>> I'd like to ask about the feasibility of having a reconnect feature added into the FUSE kernel module.
>>
>> The idea is that when a FUSE driver disconnects (process exited due to a bug, signal, etc.), all pending and future ops for that session would wait for that driver to appear again, and then continue as normal. Waiting would be on a timer, with ENOTCONN returned in case it times out. Obviously, "continue as normal" isn't possible for all FUSE drivers, as it depends on what they do and how they implement things -- they would have to opt-in for this feature.
> 
> A kernel patch[1] as well as example userspace code[2] has already
> been proposed.
> 
> [1] https://lore.kernel.org/linux-fsdevel/CAPm50a+j8UL9g3UwpRsye5e+a=M0Hy7Tf1FdfwOrUUBWMyosNg@mail.gmail.com/
> 
> [2] https://lore.kernel.org/linux-fsdevel/CAPm50aLuK8Smy4NzdytUPmGM1vpzokKJdRuwxawUDA4jnJg=Fg@mail.gmail.com/
> 
> The example recovery is not very practical, but I can see how it would
> be possible to extend to a read-only fs.
> 

There has also been some related work in the paper
"Refuse to Crash with Re-FUSE"

https://research.cs.wisc.edu/wind/Publications/refuse-eurosys11.pdf
https://eurosys2011.cs.uni-salzburg.at/pdf/eurosys2011-sundararaman.pdf

The paper gives some insight into the challenges associated with 
restarting and it seems like it worked better for them than I would have 
thought. Not sure if any source-code for their work is available to 
reproduce their findings, though.
