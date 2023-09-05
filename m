Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C388792FE5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 22:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243496AbjIEUYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 16:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbjIEUYG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:24:06 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B106BDF;
        Tue,  5 Sep 2023 13:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5Nzcz3SPhwbmqIj714ya6YKCT+j1fbnO2mOQICXxLIU=; b=qT0gC/Rw84aCtEczU2CjGGRhUT
        Tl5i6+48Fr/UyhHcHkdyn0P3UzNf9FwaPE8lMZHv0qjBN4b8r1lIlpcctkehcpZ4xvilXCEHYcK9d
        FUc1BpaEsDQlQmEM+mG8HIwcSjX7yID6G+TX+VB3WZtGaSWe2mEwly42TAHTV8mFxOW9QnDDGknbf
        6yE4Ldq2sFJAaOgEE474W6XkHCWoLE9JXQDqu01yUVa/x1lV9EBylVIIh7lNcQmKsu7QbpSQC4sFv
        de6+7aaT1Cyl9taBAQTKhbFM5FzydaUO90FL9NCCtTQxnjepbjwlHH1XJaCU7MkYmejeWmPcEVzkU
        x8fHKKtQ==;
Received: from [179.232.147.2] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qdcaa-002ky8-Di; Tue, 05 Sep 2023 22:23:56 +0200
Message-ID: <5a9ca846-e72b-3ee1-f163-dd9765b3b62e@igalia.com>
Date:   Tue, 5 Sep 2023 17:23:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V3 2/2] btrfs: Introduce the single-dev feature
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, anand.jain@oracle.com,
        david@fromorbit.com, kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-3-gpiccoli@igalia.com>
 <20230905165041.GF14420@twin.jikos.cz>
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230905165041.GF14420@twin.jikos.cz>
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

On 05/09/2023 13:50, David Sterba wrote:
> [...]
> I'd like to pick this as a feature for 6.7, it's extending code we
> already have for metadata_uuid so this is a low risk feature. The only
> problem I see for now is the name, using the word 'single'.
> 
> We have single as a block group profile name and a filesystem can exist
> on a single device too, this is would be confusing when referring to it.
> Single-dev can be a working name but for a final release we should
> really try to pick something more unique. I don't have a suggestion for
> now.
> 
> The plan for now is that I'll add the patch to a topic branch and add it
> to for-next so it could be tested but there might be some updates still
> needed. Either as changes to this patch or as separate patches, that
> depends.
> 

Hi David, thanks for your feedback! I agree with you that this name is a
bit confusing, we can easily change that! How about virtual-fsid?
I confess I'm not the best (by far!) to name stuff, so I'll be glad to
follow a suggestion from anyone here heheh

I also agree we could have this merged in your -next tree, and once a
new (good) name is proposed, I can re-submit with that and you'd replace
the patch in your tree, if that makes sense to you. Of course an extra
patch changing the name is also valid, if it's your preference.

Cheers,


Guilherme
