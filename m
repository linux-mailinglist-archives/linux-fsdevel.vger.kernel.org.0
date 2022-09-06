Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36825AEF70
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 17:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiIFPxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 11:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiIFPw4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:52:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD68D7C;
        Tue,  6 Sep 2022 08:09:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72C8B6157F;
        Tue,  6 Sep 2022 15:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61208C433C1;
        Tue,  6 Sep 2022 15:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662476961;
        bh=FV91piF4ZeID7mpLQSFqYupHuN+3qDsgWgeUcj/uZOs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dH66mns4W2S8rBp+QMshYQesTvyRgTsnd0LKs9tvmfaBcAQGMtoLDO6l/gSvAmOog
         of0v+hU65XApnTLjDBTxKlaFu9e9Nb1QCSxhoV6f9GcXUydsrwE82yqsMHLUMvgeRZ
         ZnHlQybbsPGqifoIXjngWewLR0JGLseuEh6fMOsMpI8XwDV8Ycs7q+oAC9acbqwoLO
         JH1Dkku/dWpDPvKasN/djexjiGi0v8cTBIpt8wmjmwHWGP/AtSGzhlcj1q0BKJyQ40
         gzgRRnVK5uOU5O6yCFx3BQYGfTll1ejQoAHrNUOxNp/+WdTY4+DTJZr9WDEzia+gcI
         /Bwg11u+LthYg==
Message-ID: <faa8d9e8-f601-ebff-68f7-4e12862391de@kernel.org>
Date:   Tue, 6 Sep 2022 23:09:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [f2fs-dev] [PATCH v2 1/2] fscrypt: stop using PG_error to track
 error status
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220815235052.86545-1-ebiggers@kernel.org>
 <20220815235052.86545-2-ebiggers@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220815235052.86545-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/8/16 7:50, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> As a step towards freeing the PG_error flag for other uses, change ext4
> and f2fs to stop using PG_error to track decryption errors.  Instead, if
> a decryption error occurs, just mark the whole bio as failed.  The
> coarser granularity isn't really a problem since it isn't any worse than
> what the block layer provides, and errors from a multi-page readahead
> aren't reported to applications unless a single-page read fails too.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   fs/crypto/bio.c         | 16 ++++++++++------
>   fs/ext4/readpage.c      |  8 +++++---
>   fs/f2fs/data.c          | 18 ++++++++++--------
>   include/linux/fscrypt.h |  5 +++--
>   4 files changed, 28 insertions(+), 19 deletions(-)

For f2fs part,

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
