Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0E0595F3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 17:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiHPPiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 11:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiHPPhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:37:53 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84077C306
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 08:36:26 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r141so4954149iod.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 08:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=A2T63ecIhOZRaUoHkPN/c7Sd7bQf6JInvIiB4+NzaPo=;
        b=B8GYEcsvZMsCvAaQaKYOijpFHPobYqmproJSYHE/fAp11PFZFMdwo/u4Z3P+nfJ8H3
         L/a1UVZb2XsgkKxGF8n070QZmsyfSx91a42oUVxmN3578HYDwA4AciIzd6vxjp3TfVri
         3Ugqw+A8eY2K/BvMmck1LtqZEzddgOP3aSS1cWNalYTAbAQtfsbrjm4Lvdx/ckDWHEeR
         vhxjFxMhPliax4/IaBaMQhisT/v7TXJdslncuLg7CPNKrQCUeJUQL/cS+f2aEMQvrIqn
         mPudQM165pZ6f74GJ8JAMVR+ewL3httcQXFJdpSeEMm2tsD1jHQGes2zDggy7IsHh6n/
         dPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=A2T63ecIhOZRaUoHkPN/c7Sd7bQf6JInvIiB4+NzaPo=;
        b=PEvHWxafKtc98Yudf8Q0pQn2RvXNVrNeAR98srQVuofqwqHLt6/aqApQC3BlIvaxtC
         10VkFOUzpkOeNXV/EN+QUbppNqawJM32nG13q1HK16UwtUTHGNpIqCQPV97Jzio2OdfL
         lX8NbW6rpGmsvB8Xo1XXrAdgDw4n2aAk9n16K6n75UohqAyKlgF86q7zlffSCCfLTmnd
         nl9Rs/fNXeWn1LUareBh4mvOp0LJBz7xRBuDCfXcl1xuxK++Y6fvok3kIUyd2PO28a+D
         zh++ECHlDRpu2kM3pHapZ8G9eaOZp+OyKgScDYas6rdUCkh/TLyJPTyC1E54MPwwXQj5
         hSmA==
X-Gm-Message-State: ACgBeo1giLCJujHoQP2hRC7vpDEybzMUM9qfYi51bGj5QQCbreNGHkCT
        1nxRuIgpxx9vb3p/pY0QAlixKlCuIH4viA==
X-Google-Smtp-Source: AA6agR41x/68cX38ArAJ0rEhjOSMgiY1+QRB4EbKLV/saA4GtyR6X304GDeJfhvhVNbmqIodZ9XEhg==
X-Received: by 2002:a02:a144:0:b0:343:5da5:f424 with SMTP id m4-20020a02a144000000b003435da5f424mr9569944jah.150.1660664186088;
        Tue, 16 Aug 2022 08:36:26 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a21-20020a027355000000b00343514a6be7sm4526398jae.63.2022.08.16.08.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 08:36:25 -0700 (PDT)
Message-ID: <85196548-7479-54a4-cf7b-1012166a100b@kernel.dk>
Date:   Tue, 16 Aug 2022 09:36:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [PATCH v1] fs: __file_remove_privs(): restore call to
 inode_has_no_xattr()
Content-Language: en-US
To:     Stefan Roesch <shr@fb.com>, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com
Cc:     jack@suse.cz, hch@lst.de, djwong@kernel.org, brauner@kernel.org
References: <20220816153158.1925040-1-shr@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220816153158.1925040-1-shr@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/16/22 9:31 AM, Stefan Roesch wrote:
> This restores the call to inode_has_no_xattr() in the function
> __file_remove_privs(). In case the dentry_meeds_remove_privs() returned
> 0, the function inode_has_no_xattr() was not called.

Should add a:

Fixes: faf99b563558 ("fs: add __remove_file_privs() with flags parameter")

to this commit message.

-- 
Jens Axboe


