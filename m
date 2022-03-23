Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744014E4E54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 09:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242874AbiCWIiG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 04:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242744AbiCWIhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:37:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF2012639;
        Wed, 23 Mar 2022 01:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648024575;
        bh=G4dxdms8g2p3603BmWS9UgY3NmeE/b1uZYRAxmHy540=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=kGzpTLCd65py6R2ft13lR2lFyJjJV9pKj2wQZDSBx6Vyu/JcIrZZiWdZHIxRupD0x
         WZqB9Q+Ykkqn8OyGd0bbYHbPczGh5XBJhrYEN4F4ZnxAOxOm0tt9fzGfbvzl/pVXYy
         XIJHIP5wS+GjTMViT07ScFKiV2JDi4tp/X2wgcUU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MC30Z-1nNLYB43wr-00CNVv; Wed, 23
 Mar 2022 09:36:15 +0100
Message-ID: <a0440a76-6d15-9ff2-4fca-6d7fb124eb33@gmx.com>
Date:   Wed, 23 Mar 2022 16:36:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220322155606.1267165-1-hch@lst.de>
 <20220322155606.1267165-41-hch@lst.de>
 <37a6e06f-c8ac-37dc-2f3b-b469e2410a97@gmx.com>
 <20220323061756.GA24589@lst.de>
 <58f9eaad-e857-7619-dfd3-318ae71448d2@gmx.com>
 <20220323081128.GA26391@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 40/40] btrfs: use the iomap direct I/O bio directly
In-Reply-To: <20220323081128.GA26391@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:urgfbefpyWJznkQ2yCj8b+PQ8vRYB48qGdMuvCffrmNyR0nb+TX
 21iThNI2FIyhRGekwf/eZ24gMMnPlVlX3OP7/vT3tSVkV2miR4/9ELOYAPFq4W9QuI1CrAI
 MoATdkRyaok7SmNHBm4SFAflZbgigxLeF4CmThpIXrAxH6dbQxTVXvblBE3SCR/jSlzjOr6
 Ilf3ZUYeNCtk4Kt+FSMig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rd3UPh7peyI=:aDvPftLVlx3e50ClgeUxyN
 3tJ1JjPHyeQkDft9SyvnJkp01W0KBo/APGSwd63Hxcfg3G/fjJ29SAJI1UdDMPrvykqrkhPjg
 UL5GL5/L2Otzr4vsTXAdueXIb+5LVmCegW8fEC0+qE40h+D68Q37n71u8/H1YGFV4YNuFCUph
 CsY8WRKH0MldpHlGX33S99wXmH5EgJ3UhoLl74AKz1zMlwm7RpML1IqGyfes0ZUa6j06HAWRq
 3vlKjAtgLYZm2B40EG54LW5FiRDmRLcrnAY4n1gdaEgJz64lLc3FIbx444vgvIJPR+dtL/AHj
 Leto4muA5sy0auE8uu9KlMWwvPXlOgEnfDZXabWsA32CWOWHrKjkba+d4uphMsmikJZDQpZ4K
 2GwdWcLB4Hz7UgjGElEAd3Cjc9VlBnrvsQMHtgCUZ0VgSECq/jPYAJ6WVEFfP650F36SSvpYn
 fiJsHrbh6JUIJb7gkE6yIZHpD+W7zLF2sLNrmV96Jq1zLPSqzMY0uo8kCN+9ItfuBHjcobOYa
 Ug5VsPgxAAyItYSfsaBAhM+PzpgBUN0H0S6TZbIoN7xRS8LU3lLHtg2u0sbp+fvtbLYE21yGr
 ee4tSQXZWIw8U6yM1HMcwZKzyNmwnZqiJcqTlyO2+gCRGLX47yLktcPF0XvmWvOzsu8VsckWY
 Jj4nCHaO8HcM5BnUdKc/XGhpM1KE3J/FrNAgrzXnv3TVxk9E0TVkb0BeVUiiVMnUgs9SAhLVU
 FxljOLA+gKZih0k2+wJ/kkLhoRwF2ssRCH1Kn6RpryhcEqh7v52AQux7MSR4r5dBbGINwTqt3
 PsvG0etUXpmVLrgvdek5OBDWFAsXfbKQKBSqRgyHRnxqd82mAs07BUFIhtBy9SeUqmlDxUtSk
 uXWxei27y6WwElJTGF5Pn6qJ7by2vLeLrco+tzTIUVwZSH9FQePyXIkVrqlav21t+pwK+8dRH
 jP39Vb++c56n3QDg9RixOUYHo+rlLgbVUwDdmSGHWSTF3MXXxXygt9PHDDzxTB+RckzNCxcY9
 x+4UIgKTI6LsHqc2+Wg0n3zRJx5X085JZA12OcSZ7YCEtvajePHnPy2+0YH6Vj8cutaN1ol2A
 4yJ1wHMa5fTuCA=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/3/23 16:11, Christoph Hellwig wrote:
> On Wed, Mar 23, 2022 at 04:02:34PM +0800, Qu Wenruo wrote:
>> A little curious if there will be other users of this other than btrfs.
>>
>> I guess for XFS/EXT4 they don't need any extra space and can just submi=
t
>> the generic bio directly to their devices?
>
> For normal I/O, yes.  But if we want to use Zone Append we'll basically
> need to use this kind of hook everywhere.
>
>>>> Personally speaking I didn't see much problem of cloning an iomap bio=
,
>>>> it only causes extra memory of btrfs_bio, which is pretty small previ=
ously.
>>>
>>> It is yet another pointless memory allocation in something considered =
very
>>> much a fast path.
>>
>> Another concern is, this behavior mostly means we don't split the
>> generic bio.
>> Or we still need to allocate memory for the btrfs specific memory for
>> the new bio.
>
> With the current series we never split it, yes.  I'm relatively new
> to btrfs, so why would we want to split the bio anyway?

Two reasons, one is to make iomap call backs easier, they won't need to
bother the stripe boundary anymore if we can do the bio split inside btrfs=
.
(Also why I want to get rid of the zone boundary check, but not any clue
on that yet)

Another one is purely design pattern.
We want better layer separation, things like stripe boundary should
belong to chunk layer, thus split should also happen when we map the
bio, not the read/write path.

This is exactly how the stack drivers do, and I really hope to follow
the path.

>
> As far as I can tell this is only done for parity raid, and maybe
> we could actually do the split for those with just this scheme.
>
> I.e. do what you are doing in your series in btrfs_map_bio and
> allow to clone partial bios there, which should still be possible
> threre.

I guess yes, we are probably still able to do that.

Just to mention we can not really get rid of the memory allocation.

>  We'd still need the high-level btrfs_bio to contain the
> mapping and various end I/O infrastructure like the btrfs_work.
>
Then it looks fine to me now.

Thanks,
Qu
