Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B37F79BF37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbjIKUy7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244157AbjIKTT7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:19:59 -0400
X-Greylist: delayed 1537 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Sep 2023 12:19:54 PDT
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23BFF9;
        Mon, 11 Sep 2023 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hvtgfazEDfD/ESc/aDVpO+amH0zNM0AgcdVremR6roI=; b=cdnTajZlOlBLZ/FHvontAz4Gwc
        9l80zvpR+3R/TQbYWYLVlT/3TQFoCCxLNOUgmH3CImeJt8QdYsFU0Yp1wQvVN5MMb0j0xzT5Ba0Bh
        j5LX46+Ep9n9J0YHdn91ZQ9ad4q1dqRH0hTdrWjUrtokiqGla//UVB/SP5TX+SA6JZAw/qtGHLDDa
        2tk+n59UQ7qfoqyjAsx81tVTJqs/37wb8UMArGgXYq284MFPMI/0W1ssOfClP27YzDJGaRR7gdsen
        Pg46m47jDyzDyb2Av733cjeiNYVEYQmHD+8UCvtCxm51q+GCasH0Xoo5xKfPbvsxS52qKLGRX0gwT
        dcrZUfyw==;
Received: from [187.116.122.196] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qfm30-002QWn-6v; Mon, 11 Sep 2023 20:54:10 +0200
Message-ID: <daea5aef-e5f9-09af-cdf3-13faa204497b@igalia.com>
Date:   Mon, 11 Sep 2023 15:53:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V3 2/2] btrfs: Introduce the single-dev feature
Content-Language: en-US
To:     dsterba@suse.cz, josef@toxicpanda.com
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, anand.jain@oracle.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-3-gpiccoli@igalia.com>
 <20230911182804.GA20408@twin.jikos.cz>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230911182804.GA20408@twin.jikos.cz>
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

On 11/09/2023 15:28, David Sterba wrote:
> On Wed, Aug 30, 2023 at 09:12:34PM -0300, Guilherme G. Piccoli wrote:
> I've added Anand's patch
> https://lore.kernel.org/linux-btrfs/de8d71b1b08f2c6ce75e3c45ee801659ecd4dc43.1694164368.git.anand.jain@oracle.com/
> to misc-next that implements subset of your patch, namely extending
> btrfs_scan_one_device() with the 'mounting' parameter. I haven't looked
> if the semantics is the same so I let you take a look.
> 
> As there were more comments to V3, please fix that and resend. Thanks.
> 

Thanks David, will do.
Did we agree about the name of the feature? temp_fsid maybe?
