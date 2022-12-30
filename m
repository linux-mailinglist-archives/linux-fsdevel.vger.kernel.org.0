Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295CF659DC1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiL3XGG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbiL3XGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:06:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2D72DC7
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 15:06:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C49D9B81D95
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 23:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6287CC433D2;
        Fri, 30 Dec 2022 23:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672441561;
        bh=3/oSt2S6utax3I2SgIN6dsCwCHwH/vO2/sdidmDcrLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ViXyqw7KJthPWdyURB/XpguPgAH0ZwxqDtb1BrntM/3XC5vDgVi26Sdv1SAGG2MeW
         og1dhyU99bxsxsMG4YYN3Pqog8Wos1I0McT95qcwfIDd4BYo+fLwjLqKB9qoCI1G7a
         TbUfZC2JEx6trFvXmBjOFMb3CNtgitDyF68/bl+usPYF7ENv1Qhk+Bf8tivpRU2JL9
         YWmhCZC4Elrh2G0S9ET+In5LGeEb6YAmxM2lPZsaT6OW7ggvjDokP9ahvCR2MZjlvR
         v8ce45aPCUZJTRNu9yb1W7mimiq4Y28wUzWW7Kpazpotgy8BbWbeZhdI7oNzxALxjX
         9eU6nq9XMgAuA==
Date:   Fri, 30 Dec 2022 15:05:59 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [Question] Unlinking original file of bind mounted file.
Message-ID: <Y69u1zxkcVn1RHY0@sol.localdomain>
References: <CAM7-yPQOZx85f3KxKO1feSPcwYTZGRNNVEgqn4D_+nhhXvqQzQ@mail.gmail.com>
 <Y67EPM+fIu41hlCO@casper.infradead.org>
 <CAM7-yPROANYjeGn3ECfqmn0sLzEQPUpzCyU5zSN3-mJv3UA4CA@mail.gmail.com>
 <CAM7-yPSDZG6Sd9pcm+5zXteMfKYujZ8bjpywwJV4whrmRr+ELQ@mail.gmail.com>
 <Y69dRHaTLqgY+vLG@sol.localdomain>
 <CAM7-yPSdnPg56fQ=j11neee5UN3jLE6e3D5tmtMxHufR_nVD+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPSdnPg56fQ=j11neee5UN3jLE6e3D5tmtMxHufR_nVD+g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 31, 2022 at 07:58:09AM +0900, Yun Levi wrote:
> /**
>  * NOT directory bind, file bind.
>  */
> 1. mount --bind {original file} {bind file}
> 
>   // original's inode->i_count = 1, inode->i_nlink =0, and ext4_inode
> becomes orphaned,
>   // inode->i_no which managed by ext4 is freed and become reusable.
> 2. rm -f {original file}

ext4 doesn't free the inode number while the inode is still on the orphan list.
So your claim "inode->i_no which managed by ext4 is freed and become reusable"
is wrong.  

- Eric
