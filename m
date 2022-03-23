Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60A24E4DB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 09:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242401AbiCWIEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 04:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiCWIEP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:04:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4155AEC3;
        Wed, 23 Mar 2022 01:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648022559;
        bh=TuVRwC+KcFgAGu5py81OpdoEq61VqeV4sUvDY89FNuE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cAd4SOsAKFSaWSx9H4fapt22h380udHbhm6JByHXEmMRK2YW2VWTezOmKdGNNlm6j
         FqDdPL6cTGGSrTu6DnarQ9qx27JInmy3eVBJtKuOychRJpz7RXagfcT0w0i/jzkV1e
         vQxCKd4hPMpsZBYyAkR9EU1oDuRp1xuR58YV3GMU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MyKHm-1oI0os3UdA-00ylEh; Wed, 23
 Mar 2022 09:02:39 +0100
Message-ID: <58f9eaad-e857-7619-dfd3-318ae71448d2@gmx.com>
Date:   Wed, 23 Mar 2022 16:02:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 40/40] btrfs: use the iomap direct I/O bio directly
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220323061756.GA24589@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H5Xi0+Y7QvmXDloJgBRtAvwSvTUWTjH7P73i3oWAB27Gw3FMfAh
 ZCcAaIo3kN+pj/PzOxc1NZp4YSUUfIMy/Qo0bo2pzpod6c+2/ny/iJi6O8rwRz3B5NqVd2E
 +UHaZPhrpPfgK1bdtEJ98DusFwJguDNi0iLGRd3PX06OgZzccedW+9VjNYH5S827buQXkwH
 9GqTkh3AIlAW0rAfNA8rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ddMcENNvhb8=:98RUshxUaqeJgbrtNAqYMt
 whFKloqGI5cz+tbGks6JvWhtEfH4C74N7hxeGO8U3VK0qHLuGLg1H0sM9qTp4i2bcH3eKD9bx
 EyPg+Sex70PdBFY5f8rxMBCgtoDUEzcmkaXjXdZSxOqY5XoH3N2mD245cHsewtpDvCUhjN8ma
 ubpLPEMLqFhfBDrc/+JwO5deO0fh0N4xXSjPp/uAhJndsGpHAOwsGKYanRtG2ujx0cbpIZtrC
 UybkOFYkexexhwrT7taXTbPSyQA5L9cP2xf32BMPWYcC9wCHIbBSSwA92c7ZfEPWPH0G6gR3Q
 4ntw7mK5NHAsSHUzcRT4SD1C0Tf+qTsjU6QT0OSFxK/54/szF1hojewQqyiuSriRpguQmYklj
 7g9cXojg9jpIk/vDrJINyCCaWcfePTyXJKnFoOWT93Y++Rl7AzNcAVpHsXywzpU3adHKi/R3q
 swzgikwVayHmYWYzKmPtKCJ2RECvoY6RDH4T8Ss1UsD1TBL36S8b0brpb2t+0VlYB3dugq+gr
 2WnHfOxp5q5alu8RvZVJdjhdGbL4VLdl745zFqaU+x4dCz0jZFBzv+B4/3vQqA+CjDtkRVvkx
 uoQty8GY4cNn6Mgp05KOEr7kyKKFqD77WR8SJFpHBF2vWLqzWAXM4FCfR9kN1S1bJVZJdsEtM
 +aK/HgDitfe2KUK7bOPNJN7brTQMROjCXbgvwCrP9cK7qpOBrlRGTPA4rYQUiDRXhcrQIp2IL
 J6mFlKaRbecny9yx1FS8oziIrLzNiBYEhtEfbyf2lPfGbyorFfdEgRcW8weEIQhClv/vgYIXt
 6jGIl99qv0f2pYdpU87CO1ivbwF0z11r6GHo+Sud4Z96XNnukkvMsxJABS5VpXI8A6xcQw/7G
 DA6PGDfTrZRNhdoqnS0OEmMBqnDY1VVFBi5vRAU5JqbB8JZYBVBKgh40kZSSdgzqUBUg//Gfv
 2nR6Dh+X1fAkdL1NAiPC6pirOuZbFmdIOHs1mletvfufaJDyBNoE8+4Swz7DarclCLVRTS88r
 UEtMd1ZrJCjGT5ubCvxkdI4DfYuv62J2cy9mOWHfBkeElqP8fGuQNyxcHwNxYcS6YhUOQitd2
 +ln/XGOx2PZs1o=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/3/23 14:17, Christoph Hellwig wrote:
> On Wed, Mar 23, 2022 at 09:39:24AM +0800, Qu Wenruo wrote:
>> Not familar with iomap thus I can be totally wrong, but isn't the idea
>> of iomap to separate more code from fs?
>
> Well, to share more code, which requires a certain abstraction, yes.
>
>> I'm really not sure if it's a good idea to expose btrfs internal bio_se=
t
>> just for iomap.
>
> We don't.  iomap still purely operates on the generic bio.  It just
> allocates additional space for btrfs to use after ->submit_io is called.
> Just like how e.g. VFS inodes can come with extra space for file
> system use.

OK, it's just higher layer pre-allocates those structures.

A little curious if there will be other users of this other than btrfs.

I guess for XFS/EXT4 they don't need any extra space and can just submit
the generic bio directly to their devices?

>
>> Personally speaking I didn't see much problem of cloning an iomap bio,
>> it only causes extra memory of btrfs_bio, which is pretty small previou=
sly.
>
> It is yet another pointless memory allocation in something considered ve=
ry
> much a fast path.

Another concern is, this behavior mostly means we don't split the
generic bio.
Or we still need to allocate memory for the btrfs specific memory for
the new bio.

Thanks,
Qu
