Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE2F4DB7BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 19:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354752AbiCPSHd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 14:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiCPSHc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 14:07:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B01F4D622;
        Wed, 16 Mar 2022 11:06:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C8F1A1F38A;
        Wed, 16 Mar 2022 18:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647453976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yscn5kD6MQtKQFswpK2eWv6RD7DA+7w1y9Ncb3yKw6Y=;
        b=RmfLDp0vukQJBVBkTr+3Llb96gXwzHH6FuDP+CEUzpWugi/dj2l2YS6LNyMh8iYBtwTfrC
        P7GNPza+WWWp/KyrE+0vvLY4q/Qks4FFbDDFnDQX1QBkOey/UXZsTg3cDLpPE2vxzd7qRa
        Jz/GjNLPSku6hgVV7n+W29Gc6iCgldI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647453976;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yscn5kD6MQtKQFswpK2eWv6RD7DA+7w1y9Ncb3yKw6Y=;
        b=vdWA+z91JfuCjGBBswU6dKi7YmW7VRHRfmBbJu+V69wNUISkmIdfNBmLG+Sft6o63OA1Za
        M5/ZZ64nDGnq48BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9732313B69;
        Wed, 16 Mar 2022 18:06:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1c58IxgnMmJWaQAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 16 Mar 2022 18:06:16 +0000
Date:   Wed, 16 Mar 2022 19:06:15 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Vasant Karasulli <vkarasulli@suse.de>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v3 2/2] exfat: keep trailing dots in paths if
 keep_last_dots is
Message-ID: <20220316190615.495163ae@suse.de>
In-Reply-To: <20220311114746.7643-3-vkarasulli@suse.de>
References: <20220311114746.7643-1-vkarasulli@suse.de>
        <20220311114746.7643-3-vkarasulli@suse.de>
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

Hi Vasant,

A couple of things I missed in the previous round...

On Fri, 11 Mar 2022 12:47:46 +0100, Vasant Karasulli wrote:

> exfat currently unconditionally strips trailing
> periods '.' when performing path lookup, but allows them in the filenames
> during file creation.

Trailing periods *are* currently stripped during creation, so that
statement should be removed, e.g.

  The Linux kernel exfat driver currently unconditionally strips
  trailing periods '.' from path components.

> This is done intentionally, loosely following Windows
> behaviour and specifications which state:
> 
>   #exFAT
>   The concatenated file name has the same set of illegal characters as
>   other FAT-based file systems (see Table 31).
> 
>   #FAT
>   ...
>   Leading and trailing spaces in a long name are ignored.
>   Leading and embedded periods are allowed in a name and are stored in
>   the long name. Trailing periods are ignored.
> 
> Note: Leading and trailing space ' ' characters are currently retained
> by Linux kernel exfat, in conflict with the above specification.
> On Windows 10, File Explore application retains leading and trailing
> space characters. But on the commandline behavior was exactly the opposite.

As mentioned earlier, my observations from Windows10 CopyFile() win32
API calls were that trailing spaces and periods are stripped. AFAICT
that's also the case for Windows Explorer and cmd.exe paths.

Cheers, David
