Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19260628A6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 21:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbiKNU2u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 15:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbiKNU2t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:28:49 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B88659C
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 12:28:48 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id w10so8521618qvr.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 12:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y583Jh2Pc3CXe1k+DPLcrqvBLWxncrlRyFgPw8bgSBQ=;
        b=bz4ItPXvhjsWykGyRvwdj81nyH+nRieadwAPDgqDwRST2aE2fjGZvfcwGzswde9olY
         LVHkztboFpJ/W929ynm85qo8AZ02UE4NyzkG4YQLVjUQ1oM3FUyeRvd0oqmfN6Sh6GT4
         BF2E94VU9y81R1/3dcrTxg4FWTc2bH9+xOvTBzoTDUOJspgiRby5F3pk14RpHIINx2qA
         pzv96Mj5OOD2vCPTgRcJJgwKS2YmgztvT3rxRL2z4qbZkK81gB99zwkNetsX5XhjBDcd
         weiVF9llisqXj3dDpFf/IYDFqW5BIZPO9Lcebt1Y01GSwvnc0KMoY6geanqhh8UC3K0x
         sI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y583Jh2Pc3CXe1k+DPLcrqvBLWxncrlRyFgPw8bgSBQ=;
        b=xxHgrY0pbHS5IKO3O5n6Bw/8sxUlJKojTanaiG7iek83PEQrOOzqHXNm0y6hZqW+Zs
         mNCvdyJGRm/RsbfqcY0iteM0D/Usy1aowIsh4lWvYiOvQchOuzJBVj+v3gUf5o62uEli
         /qGEYzfXRg5O20iptAPG8TgUB4GdUkiGc1n4CHSXiklGKusx+8n/sas9cn+kl8eX8hZV
         mbScAoSF+fh4ze1NtD3g8fKi+Gfr2JbS1oxyX6qAqz2Bw1eIlC/skAl9hKp2l5nJPkIe
         n//yExBzqA4Nlm747XLLdOB8XexUkFxYOpuWWVlTndKnpw2cIFxfOdugrNe7MS6B4+qt
         uXRA==
X-Gm-Message-State: ANoB5pk8pFNR6+GpANbJzmwnbFwPGkpTGkMsIvtlLHvJPs7g/G0KsEkz
        5A9uRm/HMvKJgwu0yCJadaC2CQ==
X-Google-Smtp-Source: AA0mqf42zA/jpnYWt5ejPyV8QLyWFu3K1aTeh/ukouAznsKcJ/sSPhIc8d+TW5XfFJCqEwQ5P+/b7Q==
X-Received: by 2002:ad4:5810:0:b0:4bb:5714:1d2e with SMTP id dd16-20020ad45810000000b004bb57141d2emr13713717qvb.42.1668457727414;
        Mon, 14 Nov 2022 12:28:47 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:e032])
        by smtp.gmail.com with ESMTPSA id ay40-20020a05620a17a800b006cbe3be300esm7027659qkb.12.2022.11.14.12.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 12:28:47 -0800 (PST)
Date:   Mon, 14 Nov 2022 15:29:07 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Dave Kleikamp <shaggy@kernel.org>,
        Bob Copeland <me@bobcopeland.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: start removing writepage instances
Message-ID: <Y3KlE4+SFh0jith3@cmpxchg.org>
References: <20221113162902.883850-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113162902.883850-1-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 13, 2022 at 05:28:53PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> The VM doesn't need or want ->writepage for writeback and is fine with
> just having ->writepages as long as ->migrate_folio is implemented.
> 
> This series removes all ->writepage instances that use
> block_write_full_page directly and also have a plain mpage_writepages
> based ->writepages.

The series looks good from the MM side.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
