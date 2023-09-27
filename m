Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCBB7B0640
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjI0OJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjI0OJ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:09:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8D5F3;
        Wed, 27 Sep 2023 07:09:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F6BC433C7;
        Wed, 27 Sep 2023 14:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695823797;
        bh=9+omAMOSgipwvx8H3MoAWrDsFCQNOIaZlnkvH12Nm6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZ+BocS09LVTgXaQE+jzfwctJbFFrVzwpRVOQXInCXSrQmzlx1O+YYxboYlithJyc
         lhSW0SauiliTEyJA+0W3zP52Ga6nZNjLZZ8hQoVUUodDhnKBegqUfG/YUOgkqC51RG
         lb7Vn4j3MxIJ2bm3IAAX3N2HRqO5N7DJOmNInBNTE85ohJaXNF9vWN7M8HRn+iOKrX
         /xpLBg09iY2FEB2AhhZkUGus5u6iiiNjGoHtEKWFbR2bA4atyU7cTbh8Z5qfw5jOnD
         2EI48O6dJ8Ynqnzh2DNF4cbygaoPQ3N8myVR1AkpV/fHV35ALoUg3OHjPYjmwV5eGi
         nYxy/BERaRXfg==
Date:   Wed, 27 Sep 2023 16:09:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: shave work on failed file open
Message-ID: <20230927-kosmetik-babypuppen-75bee530b9f0@brauner>
References: <20230926162228.68666-1-mjguzik@gmail.com>
 <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
 <CAGudoHGej+gmmv0OOoep2ENkf7hMBib-KL44Fu=Ym46j=r6VEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHGej+gmmv0OOoep2ENkf7hMBib-KL44Fu=Ym46j=r6VEA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I don't have a strong opinion, I think my variant is cleaner and more
> generic, but this boils down to taste and this is definitely not the
> hill I'm willing to die on.

I kinda like the release_empty_file() approach but we should keep the
WARN_ON_ONCE() so we can see whether anyone is taking an extra reference
on this thing. It's super unlikely but I guess zebras exist and if some
(buggy) code were to call get_file() during ->open() and keep that
reference for some reason we'd want to know why. But I don't think
anything does that.

No need to resend I can massage this well enough in-tree.
