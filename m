Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB8A592D6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 12:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiHOKe5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 06:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiHOKe4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:34:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EB8220C2;
        Mon, 15 Aug 2022 03:34:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 73299205F4;
        Mon, 15 Aug 2022 10:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660559693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z2sTzG5HaRXhQPCslS7WPQTvEXy810GcFy0EHN4D2FY=;
        b=d0xbmtfNVw/MvU6+bQ3HQFC6/eOHRDO0hk4mCewBYF9H9WilB3gGIjKtwIximGd7jVPQro
        ofHMtKm0OtiR7Obj8jNFPW54ZopHDms1RvvbUO9RYBHHyjfXzdOCoeBW/hbXzS7+SQo+eK
        IXjL56rrq0EBj/k0huFg9CIwDYgw4pA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660559693;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z2sTzG5HaRXhQPCslS7WPQTvEXy810GcFy0EHN4D2FY=;
        b=PRoCPRbbFARRhIfXYY0cnN+6b0riR9XPa8+Rj0ktoW+Vi7CLFq9IemVqNNxE3XiuXed0wA
        L6luQ6WWpGIqgrAA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4EDF82C1B9;
        Mon, 15 Aug 2022 10:34:53 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C0284A066A; Mon, 15 Aug 2022 12:34:52 +0200 (CEST)
Date:   Mon, 15 Aug 2022 12:34:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geetika.Moolchandani1@ibm.com, regressions@lists.linux.dev
Subject: Re: [Regression] ext4: changes to mb_optimize_scan cause issues on
 Raspberry Pi
Message-ID: <20220815103452.7hjx7ohzx64e5lex@quack3>
References: <0d81a7c2-46b7-6010-62a4-3e6cfc1628d6@i2se.com>
 <20220728100055.efbvaudwp3ofolpi@quack3>
 <76a9b920-0937-7bef-db55-844f0f5f6c1b@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76a9b920-0937-7bef-db55-844f0f5f6c1b@i2se.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Stefan,

Back from vacation...

On Sun 31-07-22 22:42:56, Stefan Wahren wrote:
> Hi Jan,
> 
> Am 28.07.22 um 12:00 schrieb Jan Kara:
> > 
> > Also can get filesystem metadata image of your card like:
> >    e2image -r <fs-device> - | gzip >/tmp/ext4-image.gz
> > 
> > and put it somewhere for download? The image will contain only fs metadata,
> > not data so it should be relatively small and we won't have access to your
> > secrets ;). With the image we'd be able to see how the free space looks
> > like and whether it perhaps does not trigger some pathological behavior.
> i've problems with this. If i try store uncompressed the metadata of the
> second SD card partition (/dev/sdb2 = rootfs) the generated image file is
> nearly big as the whole partition. In compressed state it's 25 MB. Is this
> expected?

Yes, that is expected. The resulting file is a sparse file that contains
only metadata blocks that is the reason why it compresses so well but looks
big.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
