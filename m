Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73BE701FBC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 May 2023 23:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjENVZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 May 2023 17:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjENVZx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 May 2023 17:25:53 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FFF10DF;
        Sun, 14 May 2023 14:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TQyvInVi//A6sXxnwXr5jO17/KnZHkPqWVlrPBjGck0=; b=sHG3qhfQ/AyMPsz66znPsapdUg
        BZk8gFd12W+G2eVSMDNhVWA3VunCFKciZh4W4zZOvdVyEObdk7CaY/TCQ2WPiN1S/Uk7HRgYXpXQa
        9I7l1V3zZrCAiIgEhQBHXXZRRgUmzIUKwn0NSba5UVnvG80Y8eBtfBC9uRBAB0i2UntATd1ri4QWY
        CPzJ3cC/gaJrI87kkwBj9XuL7NIn/CMItvdoE3PUyg3Qm8nJe4xp3mmW+87VrUaK8vYHMsxDQPMSR
        DNcZT8i1hVzSIAMplZV/Tf7L5QiNoVfTaNpmhBfeOdapQ0GCF2DqFWqQpfUYoKS/0+a9auOvQ6PGt
        W7BMnvOQ==;
Received: from [177.189.3.227] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pyJDm-009RQ9-NY; Sun, 14 May 2023 23:25:39 +0200
Message-ID: <6c758bad-1a82-8f69-505c-70d383a26b4d@igalia.com>
Date:   Sun, 14 May 2023 18:25:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
 <20230505133810.GO6373@twin.jikos.cz>
 <9839c86a-10e9-9c3c-0ddb-fc8011717221@oracle.com>
 <7eaf251e-2369-1a07-a81f-87e4da8b6780@gmx.com>
 <20230511115150.GX32559@suse.cz>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230511115150.GX32559@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/05/2023 08:51, David Sterba wrote:
> [...]
> With the scanning complications that Anand mentions the compat_ro flag
> might make more sense, with all the limitations but allowing a safe use
> of the duplicated UUIDs.
> 
> The flag would have to be set at mkfs time or by btrfsune on an
> unmounted filesystem. Doing that on a mounted filesystem is possible too
> but brings problems with updating the state of scanned device,
> potentially ongoing operations like dev-replace and more.

Hi David, thank you! So, would it make sense to also have a
"nouuid"-like mount option along with the compat_ro flag? I'm saying
this because I'm considering the "old"/existing SteamOS images heh

If we go only with the compat_ro flag, we'll only be able to mount 2
images at same time iff they have it set, meaning it'll only work for
newer images.

Anyway, I'm glad to implement the compat_ro flag code - I'll be out some
weeks on holidays, and will retake this work as soon as I'm back.

Thanks all that provided feedback / suggestions in this thread!
Cheers,


Guilherme
