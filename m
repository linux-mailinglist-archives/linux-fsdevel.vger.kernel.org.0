Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80681723BDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 10:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbjFFIdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 04:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjFFIdd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:33:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3753E5E
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 01:33:09 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6e4554453so50730205e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 01:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686040378; x=1688632378;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hN8hdyeFPRy+nIBLlMNf6xmKeVp1ulS56k0DwIJ60s0=;
        b=UKoUUmEQr34PawGPFRWJXS0Ryp72llQ6GIValSSDnGzJId7PFqTTQwzzEsZCfSweMc
         gCsT0BMo0sc1izm3oIX/SYOpGSGnpIeahPpBWDKqN2lwh4fwJU3gv2GEX9ELkPYB21I9
         b+amhe7tugiXXqWl+MQHB+2jYDXZNNv/QWWdsONup6tgb08oFz66VM6cXOf9ilfGz/T9
         sflotQ5+R3Gks9jPXhAyhYRIPT6v9XVpH0nD6SgfXtvTJVGtLHf7fGVzrS4FfB6pVna2
         tnmQvQtl1h/O9wvtpSnnkFx6hMnJB9yAdzgkLfKAelr41YGYhr4ico/3WK5uoc/dK82t
         rQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686040378; x=1688632378;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hN8hdyeFPRy+nIBLlMNf6xmKeVp1ulS56k0DwIJ60s0=;
        b=VK9hwAgzWJVOunk7xqpwmaLbujCyxpu7WojLVkF2+whnPVbtZO0RrLAoQPEK8xvLmc
         A3LXfaIydQF4gaIINhlaZkllu33YgevjD3W/PqLLIGEA731gsypaKkx5U71prXsF6Vod
         QXNSbiHs1bif3E9rS73PDILr16Yw5EdziUYSDq8kipaGhdKS+1AZUazpkSGZmJDuTAYw
         FW/3ficJsk6e8jgp8KXUq39rtRRQ5id+dqZR14EdXaYFPu6Dz6XF/WWkGQdOflLNUf64
         UF5tC4TGI7fst/w1Wa19bhxcMxF+4tTviUBQRSeioRX8ELIroh1kiDkAwgE2Vq1VFeNQ
         4a2Q==
X-Gm-Message-State: AC+VfDyKj3orlRHAhrnVimjcAeEVuo2Rs7FgxIe89//x8uLkPtWKn86b
        3rqHNe8Lrl5a/eBqphP8Hsql3VvX4y0TWyt1uQQ=
X-Google-Smtp-Source: ACHHUZ7ldJwT/DOZC5ooAbithAg1Z+IFvt78EwG+DOEMMlw6rui2XzO87be9Qo55C5orUts9tX92KA==
X-Received: by 2002:a7b:c050:0:b0:3f6:795:6d1a with SMTP id u16-20020a7bc050000000b003f607956d1amr1370239wmc.22.1686040378638;
        Tue, 06 Jun 2023 01:32:58 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c248400b003f604793989sm16823759wms.18.2023.06.06.01.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 01:32:57 -0700 (PDT)
Date:   Tue, 6 Jun 2023 11:32:53 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     jack@suse.cz
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] fs: Restrict lock_two_nondirectories() to non-directory
 inodes
Message-ID: <ZH7vNQSIVurytnME@moroto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Jan Kara,

This is a semi-automatic email about new static checker warnings.

The patch afb4adc7c3ef: "fs: Restrict lock_two_nondirectories() to
non-directory inodes" from Jun 1, 2023, leads to the following Smatch
complaint:

    fs/inode.c:1174 unlock_two_nondirectories()
    warn: variable dereferenced before check 'inode1' (see line 1172)

    fs/inode.c:1176 unlock_two_nondirectories()
    warn: variable dereferenced before check 'inode2' (see line 1173)

fs/inode.c
  1171	{
  1172		WARN_ON_ONCE(S_ISDIR(inode1->i_mode));
                                     ^^^^^^^^^^^^^^
  1173		WARN_ON_ONCE(S_ISDIR(inode2->i_mode));
  1174		if (inode1)
                    ^^^^^^
  1175			inode_unlock(inode1);
  1176		if (inode2 && inode2 != inode1)
                    ^^^^^
regards,
dan carpenter
