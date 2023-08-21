Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB543782EA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 18:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbjHUQnj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 12:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjHUQnj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:43:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91196CC;
        Mon, 21 Aug 2023 09:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D56B63E47;
        Mon, 21 Aug 2023 16:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DEDC433C7;
        Mon, 21 Aug 2023 16:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692636216;
        bh=xDZnf01gvSZEJKEIZ7/1mNK5Ti1NMwtcvcRje7Aoek8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+Plp/JpmxdvaW6NG5+wCJ1yJqgd08tcvU+FIsZZ7a5Bgg3HQjkDVaSax27i2DbgZ
         ibp043nQzh0XFBkNDEvwaOvazwDyNUh9tpvqIq+SMXfVy5kh4TPRhrsKOfoe4rapN8
         No6EBxcXqI4sY8A4vuAFp8wr3FauwsHUuRP5V7tg=
Date:   Mon, 21 Aug 2023 18:43:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     stable@vger.kernel.org, vegard.nossum@oracle.com,
        Namjae Jeon <linkinjeon@kernel.org>,
        Yuezhang Mo <Yuezhang.Mo@sony.com>,
        Maxim Suhanov <dfirblog@gmail.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15.y] exfat: check if filename entries exceeds max
 filename length
Message-ID: <2023082122-remold-emission-a564@gregkh>
References: <20230819075337.3270182-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819075337.3270182-1-harshit.m.mogalapalli@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 19, 2023 at 12:53:37AM -0700, Harshit Mogalapalli wrote:
> From: Namjae Jeon <linkinjeon@kernel.org>
> 
> [ Upstream commit d42334578eba1390859012ebb91e1e556d51db49 ]
> 
> exfat_extract_uni_name copies characters from a given file name entry into
> the 'uniname' variable. This variable is actually defined on the stack of
> the exfat_readdir() function. According to the definition of
> the 'exfat_uni_name' type, the file name should be limited 255 characters
> (+ null teminator space), but the exfat_get_uniname_from_ext_entry()
> function can write more characters because there is no check if filename
> entries exceeds max filename length. This patch add the check not to copy
> filename characters when exceeding max filename length.
> 
> Cc: stable@vger.kernel.org
> Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reported-by: Maxim Suhanov <dfirblog@gmail.com>
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> [Harshit: backport to 5.15.y]
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> The conflict resolved patch for 6.1.y applies cleanly to 5.15.y as
> well.
> Note: This fix is already present in 5.10.y but missing in 5.15.y

Thanks for catching this, now queued up.

greg k-h
