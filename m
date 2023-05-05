Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31946F8885
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 20:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjEESQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 14:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjEESQP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 14:16:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1987F1F4BD;
        Fri,  5 May 2023 11:16:14 -0700 (PDT)
Received: from [IPV6:2001:4d48:ad5d:8e00::27f] (unknown [IPv6:2001:4d48:ad5d:8e00::27f])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vivek)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 551426605728;
        Fri,  5 May 2023 19:16:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683310572;
        bh=0xLPNzDeEtKDMaqTt4MA1mcVpBK6aO3CRC3K6+d3cho=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GpXc/7sgRpDAdcD3r2kgV6zJBDFzRjasOh6A3Vb1y4yZaUfoPVD/aWnnOT1MqTNv6
         dzodR2s1HyZxu5oI/ANfBnaAeTw+VB0msPsBdaaymq+0FfqNTHLymF+g0Tcx/h9SQn
         gV4kgHrf3ZZKD/rAECEvkrWqJF5dVTtoZylaASi93X0bbzAcXfonpGryhmhpgtnHet
         NmphZiejju+iQszxj3uhVbobXgwAcQ5O7HgKumm42H7gzeiLe5vprip3tpW6WgGrCh
         Q9ED0PPJHP/F1JAaPsRJ913VzihfyeCm8LELmxQGGYeW0xnuz6HVLUNthTdMyY4b6t
         JZ2CMnkq4fL8g==
Message-ID: <af359ba1-9beb-610b-c7f1-9b0f9e4df2a7@collabora.com>
Date:   Fri, 5 May 2023 19:15:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] Supporting same fsid filesystems mounting on btrfs
Content-Language: en-GB
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anand Jain <anand.jain@oracle.com>, johns@valvesoftware.com,
        ludovico.denittis@collabora.com
Cc:     clm@fb.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <b8f55fc3-80b3-be46-933a-4cfbd3c76a71@oracle.com>
 <7320368b-fd62-1482-1043-2f9cb1e2a5b9@igalia.com>
From:   Vivek Dasmohapatra <vivek@collabora.com>
In-Reply-To: <7320368b-fd62-1482-1043-2f9cb1e2a5b9@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/05/2023 17:27, Guilherme G. Piccoli wrote:
> On 05/05/2023 02:16, Anand Jain wrote:

[cut]

> I'll defer a more detailed response for John / Vivek / Ludovico, that
> are aware of the use case in a detail level I'm not, since they designed
> the installation / update path from the ground up.
> 

The OS images are entirely independent. The goal is that you could
completely corrupt slot A and it would have no impact on the bootability
of slot B.

So, yes, we sacrifice space but as a trade off we get robustness which
is more important to us.

=========================================================================

When a new OS image is delivered, the normal flow is this (simplified):

While booted on slot A (for example) the update process is started.

Our client fetches the most recent image from the update server.

This is delivered as a block level diff between the image you
have and the image you want.

The partitions that are allocated to slot B have the new data written
into them.

As a final step, the root fs of the new slot is mounted and a couple of
initialisation steps are completed (mostly writing config into the
common boot partition: The slot B partitions contents are not modified
as a result of this).

The system is rebooted. If all goes well slot B is booted and becomes
the primary (current) image.

If it fails for some reason, the bootloader will (either automatically
or by user intervention) go back to booting slot A.

Note that other than the final mount to update the common boot partition
with information about the new image we don't care at all about the
contents or even the type of the filesystems we have delivered (and even
then all we care about is that we _can_ mount it, not what it is).
===========================================================================

Now normally this is not a problem: If the new image is not the same as
the current one we will have written entirely new filesystems into
the B partitions and there is no conflict.

However if the user wishes or needs to reinstall a fresh copy of the
_current_ image (for whatever reason: maybe the current image is damaged
in some way and they need to so a factory reset) then with btrfs in the
mix this breaks down:

Since btrfs won't (at present) tolerate a second fs with the same fsuuid
we have to check that the user is not installing the same image on both
slots.

If the user has a broken image which is also the latest release and
needs to recover we have to artificially select an _older_ image, put
that on slot B. boot into that, then the user needs to boot that and
upgrade _again_ to get a repaired A slot.

This sort of works but isn't a great user experience and introduces an
artificial restriction - suddenly the images _do_ affect one another.

If the user subverts our safety checks (or we mess up and put the same
image on both slots) then suddenly the whole system becomes unbootable
which is less than ideal.

Hope that clarifies the situation and explains why we care.



