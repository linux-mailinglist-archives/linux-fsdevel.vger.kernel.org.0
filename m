Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B4B6203BE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 00:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiKGX17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 18:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiKGX16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:27:58 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04C420190;
        Mon,  7 Nov 2022 15:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:Subject:Cc:To:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=A8xwnCqT60w058zc98UI55qeZ4mzfgbNJGagMV3saqA=; b=qkYB+Z/VBOUwDiUcokibgHwkWv
        I9NOgWnzFX5/KnGqUHR6YTHI4syeA5Co9uXaq6/oNZQW1WSfq2GrxyLIu6kuQbUgpss/Cfe0ZeBXA
        i42uF6Ng2SUHtO7SDlraMvGQH/z8S1SVv4jC0Ljt3rR0uWXV1h5Xo+5PREYNf/xqIGEOrT7MRfRFo
        UOLlViYGM+nxgTI8UJoWCGBIZF9HWFbRNYEttvz9E3e6V2AIHUtmq+k5s5vj/IlV4KujegIutlEsO
        MKqZvyGtxMhxer/mXzdmIiT5rLXMvw4bVjK9Xgp8xCM31iYCjS2khIvsWd1QJgw8YbKtI3js0mqyg
        wKefWt7A==;
Received: from [177.102.6.147] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1osBVn-00EAwg-PE; Tue, 08 Nov 2022 00:26:40 +0100
Message-ID: <c702fe27-8da9-505b-6e27-713edacf723a@igalia.com>
Date:   Mon, 7 Nov 2022 20:26:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-btrfs@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        kernel@gpiccoli.net,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        John Schoenick <johns@valvesoftware.com>, vivek@collabora.com
Subject: About duplicate fsid images in different devices
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi btrfs maintainers, I'd like to discuss about the possibility of
having btrfs allowing to mount any of a set of different devices holding
the same filesystem, i.e, a duplicate fsid scenario. For example,
imagine sda1 and sdb1 both contains the same filesystem, I'd like to be
able to mount either sda1 OR sdb1 (not both at the same time!);
currently, only the first that was created is able to get mounted.

First of all, let me describe the use case I have in mind: the Steam
Deck gaming console makes use of an A/B double side partitioning scheme
and a RO btrfs rootfs is one of the partitions (in each "side"). So, we
could have a scenario of some user that wishes to have the same image in
both "sides", perhaps to test some modifications for example and have
the pristine/unmodified image in the other one. Before using btrfs,
Steam Deck was using ext4 and everything worked fine in such scenario,
but with btrfs it's impossible to (even explicitly) mount the newer
partition with the same fsid. We also have the use case of images'
upgrading process, that in a recovery configuration might end-up
installing the same (pristine) image in the other "side"; that case is
kinda trivial one that we'd expect to work. Notice that a reason behind
this duplication in the images' fsid is because they're signed rootfs
snapshots, so wouldn't so trivial/desirable to de-duplicate them in some
cases.

By checking the code, we can see that the validations preventing such
mounting operation happens in device_list_add(): when udevd checks the
filesystems on boot time, the older partition (the first one with the
given fsid) is verified and the btrfs_fs_devices struct is null - hence
it is created along with the corresponding btrfs_device for such
partition/device, which is added in the fs_devices list. When the newer
partition gets scanned, fs_devices exists, so the function
btrfs_find_device() is invoked and finds the first btrfs_device, which
differs from the one we are trying to mount, effectively leading to this
second device being impossible to mount.

Since I'm not an expert in the btrfs inner workings, I'd like some
advice to understand if some mount flag would be accepted to enable this
behavior; maybe I'm not seeing some subtle issue, but given the 2-side
nature of our setup, the explicit mount point control, and the fact we
don't expect to use any btrfs more "complex"features that might be
confused by non-unique fsids (like RAID), seems feasible to allow such
btrfs behavior. Notice we don't require to change the default, hence the
idea to have it as a mount flag or something like that - suggestions are
greatly appreciated.

Thanks in advance,


Guilherme
