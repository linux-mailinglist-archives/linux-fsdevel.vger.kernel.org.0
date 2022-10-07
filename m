Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37485F7808
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 14:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiJGMi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 08:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGMi5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:38:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19D7CA89E;
        Fri,  7 Oct 2022 05:38:55 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r13so7093164wrj.11;
        Fri, 07 Oct 2022 05:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gf7RCQeQguejwd2v0ikzLyew4+a8z+8COcAmUUx4Kto=;
        b=pFTLFPrCw71p6DcTapmqq+EZwVZNTAS7FWVeIaTb87anIQaBjgXYKAVyLXwLCM8wOp
         VOXkOoZn1rmL/6lwYFXXKv4Y7PaeDa89HhbW6VvQZQmLZ1aFHrK5Wy1I+zSwn4+6B8/f
         /Pz+ua9s4ctmoJCrgVSD9CfUxEuo5hmQZ2TVQ5dnwi6f6tZuuWNj40BB14uxGuAiaq/S
         oZzXmGBcAnKGcUmWhjwzWb6sPiIOfkyfni0M8INGieqp+8b6jOTy0s9kDrCIji7kHGWA
         +y7zEUFeRGopj5o9NSU7ythXuMeyKjLmyttPWHfLoksM7+g2G8IXne0Iu2aDYp4nUnv0
         W1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gf7RCQeQguejwd2v0ikzLyew4+a8z+8COcAmUUx4Kto=;
        b=VsYeoQSFFwzQ/iT3Dp9mvHbHNYpRTuY9psLFfsh3JWHQi02Beh1pau29kPSHIuE54p
         3esj+zcSF2GKORYis7wXBHOw/B7x902+udF7vvepKWuCpEANABlp6qTXP6QYGH+Ftuc2
         bq/LQrhy6ZeaPQxw0yVqJL+JE3p+gkjKpG3eHmG6NvVdHiqWwvZxCxCIcBRLS9ID6SMp
         6+SglmRuUOlWmiF2IpNuxknz5yFFJJptgYLTwqDzKf67w6ODfZRDSWi4DjDsX/JnsMuu
         +A6BFdgKw7EzYz1y7ABJIdFx0SgzItZlLUVA1/hxaNsDFcBNnPiOzdfyGtae/7THEU9O
         ejvA==
X-Gm-Message-State: ACrzQf0ldBMZEYybJNi3dx3tyfANuCW6QZz8V0Jygvwnh3GDLHi3hvle
        Msjzon/9P6qsxnBSdUcYExw=
X-Google-Smtp-Source: AMsMyM41+hUD6dKXqSdLDCidvHYS4Y9pvZIdCJBvoPEG624ScV+bjnSkVSmKijrnbBJ/sjBMUlF+oQ==
X-Received: by 2002:a5d:47a8:0:b0:226:f124:ad74 with SMTP id 8-20020a5d47a8000000b00226f124ad74mr3313939wrb.18.1665146334345;
        Fri, 07 Oct 2022 05:38:54 -0700 (PDT)
Received: from [192.168.42.102] (mo-217-129-7-245.netvisao.pt. [217.129.7.245])
        by smtp.gmail.com with ESMTPSA id v12-20020adfe28c000000b0022e51c5222esm1902960wri.86.2022.10.07.05.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 05:38:53 -0700 (PDT)
Message-ID: <39664539-d881-9129-8213-ac6fad4e575b@gmail.com>
Date:   Fri, 7 Oct 2022 13:38:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: [PATCH 2/4] fs/ntfs3: make hidedotfiles mount option work when
 renaming files
Content-Language: en-US
From:   Daniel Pinto <danielpinto52@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <536f13a9-0890-7e69-65e9-5fe1a30e04ef@gmail.com>
In-Reply-To: <536f13a9-0890-7e69-65e9-5fe1a30e04ef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, the hidedotfiles mount option only has an effect when
creating new files. Removing or adding the starting dot when moving
or renaming files does not update the hidden attribute.

Make hidedotfiles also set or unset the hidden attribute when a file
gains or loses its starting dot by being moved or renamed.

Signed-off-by: Daniel Pinto <danielpinto52@gmail.com>
---
 fs/ntfs3/frecord.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 70a80f9412f7..41a20d71562a 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3018,6 +3018,15 @@ int ni_add_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
 	struct ATTR_FILE_NAME *de_name = (struct ATTR_FILE_NAME *)(de + 1);
 	u16 de_key_size = le16_to_cpu(de->key_size);
 
+	/* If option "hidedotfiles" then set hidden attribute for dot files. */
+	if (ni->mi.sbi->options->hide_dot_files) {
+		if (de_name->name_len > 0 &&
+		    le16_to_cpu(de_name->name[0]) == '.')
+			ni->std_fa |= FILE_ATTRIBUTE_HIDDEN;
+		else
+			ni->std_fa &= ~FILE_ATTRIBUTE_HIDDEN;
+	}
+
 	mi_get_ref(&ni->mi, &de->ref);
 	mi_get_ref(&dir_ni->mi, &de_name->home);
