Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420D1731261
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 10:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243809AbjFOIiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 04:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbjFOIiY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:38:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39A91720;
        Thu, 15 Jun 2023 01:38:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A3C422415;
        Thu, 15 Jun 2023 08:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686818302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BzeXbjAQ7G4oFdMPlSXSYIYMM//XNrmPB32u8G611GA=;
        b=mIo46fAFDKnyvbApdKpFf4s2rIuBJ7xkW7VQohbwVQHx5s0mho+WiR4TYxM7P3HFcnvBXx
        TLrc0RMSlD1VsNKsTPoI2yp99sO9MHVMDEgkReZCtUjIR8Xry8CgRTpuGyuEeGHjdl3Yar
        5LkDF/dNLhGrvLnE4tFG1Gf8i7/gCQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686818302;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BzeXbjAQ7G4oFdMPlSXSYIYMM//XNrmPB32u8G611GA=;
        b=4jCLgeW4PRNDqszHty5DlXioyODlTJb3DLEsUmRa0yR08pgRfeRreM5nyIv7hpLJWyYljR
        mgLFqad+xX2GZeBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 660D513467;
        Thu, 15 Jun 2023 08:38:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t2aTGP7NimRKNwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 15 Jun 2023 08:38:22 +0000
Message-ID: <235763fe-2e76-8f80-6c98-e2ab0ff3d15b@suse.de>
Date:   Thu, 15 Jun 2023 10:38:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 11/11] md: deprecate bitmap file support
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230615064840.629492-1-hch@lst.de>
 <20230615064840.629492-12-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230615064840.629492-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/15/23 08:48, Christoph Hellwig wrote:
> The support for bitmaps on files is a very bad idea abusing various kernel
> APIs, and fundamentally requires the file to not be on the actual array
> without a way to check that this is actually the case.  Add a deprecation
> warning to see if we might be able to eventually drop it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/md/Kconfig | 2 +-
>   drivers/md/md.c    | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


