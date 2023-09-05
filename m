Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C757924AC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 17:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjIEP71 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 11:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244787AbjIEBa2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 21:30:28 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF9AE6;
        Mon,  4 Sep 2023 18:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zTz8DJ0sdGnzL7BVOUEZWohsmrkaSJOjushOkK+Yck0=; b=gA+mdelJJdMPM7rjXhXZ0CQxZR
        ZuLQNBbgIVavqo1fVkRP91RKysHYPFwNNItYnzXGitQ4Fsrkjuzqk3DzhXBJScxn8fNOzH4bYkWC3
        jcVxf3mam13DNRpaFb2Tbe1SnmzohLK1J4qEZrqIpEww8g1R8NkPEQcPZtHSYVv+WwwmHIHz38aae
        JoVCh/3HxycWFqwWvEpakrMIOL2QIOOf7WmMnvZRTH87LSpA+w2ZIJTy4kuVwCtTIAtoSyE1YbTdf
        PZO/JIPO+9Nm3oFbKPJVsE1yWLoRcaaTUxiIQL3LwNla5mGH5/av+kQIWvQpkASB5RyvErRaIe1Mf
        +k78LVXQ==;
Received: from [179.232.147.2] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qdKtD-002Gtx-PS; Tue, 05 Sep 2023 03:30:00 +0200
Message-ID: <80140c50-1fbe-1631-1473-087a13fd034f@igalia.com>
Date:   Mon, 4 Sep 2023 22:29:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3 0/2] Supporting same fsid mounting through the
 single-dev compat_ro feature
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, david@fromorbit.com, kreijack@libero.it,
        johns@valvesoftware.com, ludovico.denittis@collabora.com,
        quwenruo.btrfs@gmx.com, wqu@suse.com, vivek@collabora.com,
        linux-btrfs@vger.kernel.org
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <fee2dcd5-065d-1e60-5871-4a606405a683@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <fee2dcd5-065d-1e60-5871-4a606405a683@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/09/2023 03:36, Anand Jain wrote:
> [...]
> We need some manual tests as well to understand how this feature
> will behave in a multi-pathed device, especially in SAN and iSCSI
> environments.
> 
> I have noticed that Ubuntu has two different device
> paths for the root device during boot. It should be validated
> as the root file system using some popular OS distributions.
> 
> Thanks, Anand

Hi Anand, thanks for you suggestions! I just tried on Ubuntu 22.04.3 and
it worked flawlessly. After manually enabling the single-dev feature
through btrfstune, when booted into the distro kernel (6.2.x) it mounts
as RO (as expected, since this is a compat_ro feature). When switched to
a supporting kernel (6.5 + this patch), it mounts normally -
udev/systemd are capable of identifying the underlying device based on
UUID, and it mounts as SINGLE_DEV.

About the iSCSI / multipath cases, they are/should be unsupported. Is
multi-path a feature of btrfs? I think we should prevent users from
using single-dev along with other features of btrfs that doesn't make
sense, like we're doing here with devices removal/replace and of course,
with the metadata_uuid feature.

Now if multipath is not supported from btrfs, my understanding is that
users should not tune single-dev, as it doesn't make sense, but at the
same time it's not on scope here to test such scenario. In other words,
I'm happy to test a case that you suggest, but no matter how many
non-btrfs features/cases we test, we're not in control of what users can
do in the wild.

Cheers,


Guilherme
