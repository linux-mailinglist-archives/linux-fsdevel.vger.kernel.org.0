Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A9C76FF8C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 13:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjHDLip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 07:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHDLio (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:38:44 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79610B9;
        Fri,  4 Aug 2023 04:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1zlonKhnVXwi/pJ23MHfKc3RrbGzVuwuxf93bjyTk9g=; b=ISAaPZJRkJzLCz4+8PvsQ2jc+t
        3B2z/+Dv5+7hLfdRPS/S+GQ/y4SHiiVBGBAuGbyT0utBWpr8ytNYA3/JG9kN8yzJumFZIJZQB4F2k
        2Gm+GxGl+d2rWvyZ6Sqjtme3+BrKbZucHPXBpa0Wc7FG66mGT5r7YDE1M6TkSi2uuAmcdL16zhsOJ
        iWPvAqQYfpAvSBHNF328BSPJhDoGL1LsCuHZvra6X5Jf0vfw77auqsy4gqGjo0+Akub+NURT8jDr2
        8R827POtuYHswmKtX+IY1Z9KJE/Zl+tqcGdfjWah44N4zbEzyyVsMF3YKlJJgkAtwUmK2REBmST4U
        Ig6ERN0A==;
Received: from 201-92-22-215.dsl.telesp.net.br ([201.92.22.215] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qRt8c-00CLf9-Dh; Fri, 04 Aug 2023 13:38:34 +0200
Message-ID: <b7f6a100-a802-67a9-589b-1457dee6d32a@igalia.com>
Date:   Fri, 4 Aug 2023 08:38:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] btrfs: Introduce the single-dev feature
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, anand.jain@oracle.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, wqu@suse.com, vivek@collabora.com
References: <20230803154453.1488248-1-gpiccoli@igalia.com>
 <20230803154453.1488248-3-gpiccoli@igalia.com>
 <58a425ca-f7e8-b7e2-eb04-d83bb952b382@gmx.com>
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <58a425ca-f7e8-b7e2-eb04-d83bb952b382@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/08/2023 05:27, Qu Wenruo wrote:
> [...] 
> My concern is still about the "virtual" fsid part.
> 
> If we go virtual fsid, there can be some unexpected problems.
> 
> E.g. the /sys/fs/btrfs/<uuid>/ entry would be the new virtual one.
> 
> And there may be some other problems like user space UUID detection of
> mounted fs, thus I'm not 100% sure if this is a good idea.
> 
> However I don't have any better solution either, so this may be the
> least worst solution for now.
> 
> Thanks,
> Qu

Hi Qu, thanks for your analysis!

I think the virtual/spoofed fsid part is not without problems but I
consider it to be less prone to unexpected issues than not.

It's based on the metadata_uuid code, which is stable and present in
btrfs for like 5 years. Also, we don't need to "corner-case" a lot of
stuff to use that, which would be needed if we went to the pure dup fsid
route. I tried that and it breaks in a lot of places, to which we
require a lot of if conditionals (I even discussed that briefly in the
last thread with you, about sysfs, remember?).

So, despite not perfect, I agree with you that seems to be the least
worse solution :)

Cheers,


Guilherme
