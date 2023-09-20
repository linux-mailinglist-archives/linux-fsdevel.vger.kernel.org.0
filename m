Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24B87A8CF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 21:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjITThP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 15:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjITThO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:37:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921E6A3;
        Wed, 20 Sep 2023 12:37:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12EDC433C8;
        Wed, 20 Sep 2023 19:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695238628;
        bh=j+jorpIRAaPJFNymaByLkAEIB8117cyMKfFxgXZxHg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kzHGRB9Q2kuEWQekIKGrHPr7rq9bDr3IyHKuXrus3e6FwWDk86aIxcYtCXO4dgEHp
         bkPMLHdRNyA+iS+7YyeZpl/eyxV1BS6NT48opo88Ef22lGi9H+QH6sNvAm5U7KvlNn
         fmHNCDgLt5Wve77qO+Ket2cwCQzm9c9gIuwecSgk536B+J4sVyipeE/qM82OU1f9jt
         wkSCIfzLmngLK7+MLboCQ4vb7MLVnVeH77juYG9Bm9rcLyvm0LTi03e73/P77mB8Xh
         Jg7WioU7Tx7khon8lhq7Ey390ZFsx3gbJoU6whL43CQMPu1ex8MDgwGdLq88vcISmU
         vyDJlq03S496A==
Date:   Wed, 20 Sep 2023 12:37:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Edward AD <twuufnxlz@gmail.com>
Cc:     syzbot+9cf75dc581fb4307d6dd@syzkaller.appspotmail.com,
        adilger.kernel@dilger.ca, krisman@collabora.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [PATCH] unicode: add s_encoding null ptr check in utf8ncursor
Message-ID: <20230920193706.GB914@sol.localdomain>
References: <0000000000001f0b970605c39a7e@google.com>
 <20230920112015.829124-2-twuufnxlz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920112015.829124-2-twuufnxlz@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 07:20:16PM +0800, Edward AD wrote:
> When init struct utf8cursor *u8c in utf8ncursor(), we need check um is
> valid.
> 
> Reported-and-tested-by: syzbot+9cf75dc581fb4307d6dd@syzkaller.appspotmail.com
> Fixes: b81427939590 ("ext4: remove redundant checks of s_encoding")
> Signed-off-by: Edward AD <twuufnxlz@gmail.com>
> ---
>  fs/unicode/utf8-norm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
> index 768f8ab448b8..906b639b2f38 100644
> --- a/fs/unicode/utf8-norm.c
> +++ b/fs/unicode/utf8-norm.c
> @@ -422,6 +422,10 @@ int utf8ncursor(struct utf8cursor *u8c, const struct unicode_map *um,
>  {
>  	if (!s)
>  		return -1;
> +
> +	if (IS_ERR_OR_NULL(um))
> +		return -1;
> +
>  	u8c->um = um;
>  	u8c->n = n;
>  	u8c->s = s;
> -- 

See https://lore.kernel.org/linux-fsdevel/20230920073659.GC2739@sol.localdomain/

- Eric
