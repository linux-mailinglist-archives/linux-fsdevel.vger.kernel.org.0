Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CFF4DB1F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 14:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbiCPN6s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 09:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiCPN6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:58:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F126441FBE;
        Wed, 16 Mar 2022 06:57:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD56C1F38A;
        Wed, 16 Mar 2022 13:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647439050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVnaIKXQpvG9mLruAk0reUuRGL+ESYJUl+C6vlyz8wA=;
        b=e1qeW3YdkGqC/ADJdxeQv5Fq0zN9IF2QuYSXv+ruO1800/d98Q8OZegZfa1Kf7tCubCTS8
        pRBvCE4iNbN7jCeHk0Y7OwIh3+XlvKR+D1whwrtAs51vEfO4xwWdDUlTH5z6EYV51RlYoz
        VIMnnkBo1NZok3Ou/xv4e88GDN7XEWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647439050;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVnaIKXQpvG9mLruAk0reUuRGL+ESYJUl+C6vlyz8wA=;
        b=Ve+5n8MV0gYO7o3lp4IEkoRpxVgisrCbYnu7S7+uRYFziE04yx+HtD3bzJ2PMi/TTnOUki
        gwSFmulo3VuiY+Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 729D0139B5;
        Wed, 16 Mar 2022 13:57:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LPsyGsrsMWKwewAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 16 Mar 2022 13:57:30 +0000
Date:   Wed, 16 Mar 2022 14:57:28 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Vasant Karasulli <vkarasulli@suse.de>,
        Namjae Jeon <linkinjeon@kernel.org>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>,
        Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
Subject: Re: [PATCH v3 1/2] exfat: add keep_last_dots mount option
Message-ID: <20220316145728.709d85e0@suse.de>
In-Reply-To: <YjGr3IpZ4p55YuAB@vasant-suse>
References: <20220311114746.7643-1-vkarasulli@suse.de>
        <20220311114746.7643-2-vkarasulli@suse.de>
        <CAKYAXd9kdYi4rXmyfAO3ZbmKLu3i35QzsL_oOorROYieQnWGRg@mail.gmail.com>
        <YjGr3IpZ4p55YuAB@vasant-suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 16 Mar 2022 10:20:28 +0100, Vasant Karasulli wrote:

> On So 13-03-22 09:01:32, Namjae Jeon wrote:
> > 2022-03-11 20:47 GMT+09:00, Vasant Karasulli <vkarasulli@suse.de>:  
> > > The "keep_last_dots" mount option will, in a
> > > subsequent commit, control whether or not trailing periods '.' are stripped
> > > from path components during file lookup or file creation.  
> > I don't know why the 1/2 patch should be split from the 2/2 patch.
> > Wouldn't it be better to combine them? Otherwise it looks good to me.  
> 
> I just followed the same patch structure as was in the initial version
> of the patch.

I'm fine with having both patches squashed together. @Namjae: should we
resubmit as a single patch or can you do the squash on your side before
submitting to Linus?

Cheers, David
