Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4866A62E95B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 00:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiKQXM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 18:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiKQXMz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:12:55 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3FA69DC2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Nov 2022 15:12:54 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 4so3062681pli.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Nov 2022 15:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjJtOTW8qEN5Hou122FY7D2j3EMt/Y/H5Tso7yOsct0=;
        b=fHx8pl5zXICLdVv9u1Q48NBxKmTPjcmXak3CNHefX1bf7wS1ebAzxvoCck0xqah7J3
         /y1IcESkvss4jerKNgAGMIjhb5QOJtLOM0Z+OBen/kIQEJBvC6NIkY7m/ASp+OuewbuC
         FPTyf/2k/+9OG1la14GFeqL8K+/M+xSi5R01M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjJtOTW8qEN5Hou122FY7D2j3EMt/Y/H5Tso7yOsct0=;
        b=b/+OCJi2/y47CbHfYI6pnNdSyuKJuP/BmFOF6fWLAoQalFXecKNnTAf7Kkh5wp4HHV
         tcmxkg/ELWc7TqKVtebSic22PuDpU1O2LIXwk1o9/Vuegb8U9lXgyjO6T2UU/XTwZUZ1
         Rk9Grg0gor0G0CSIwNDopAEMYNgDAKgkj5QYY2vpMdp92U5tZ/qhhFEKRlBlgWijH4Uq
         UUnbSCoE0sLz/NF9ivnBNj3egjAnI5Z53KdFw2j17o17U2SpF+z/2x2o6zDqP9nMtN7v
         HvieUyEyUfFuDpULIg0k+JzJvaAHGjq9tmUszyVb2X5tL7TbwnzKuVhT9iUHuqsaZaLv
         zJfg==
X-Gm-Message-State: ANoB5pnQ5niyN1v9EQMVyPNWS9Pu33xhXBU8OOZndBDbrypf9lHYlqLf
        DlvT6maKV020YMkJq42cW7oNNg==
X-Google-Smtp-Source: AA0mqf5lWKj8nO4ONeM7K3zUSHqyqzwydexokmez7Zuk3ArBoUdcThhSgPFSfj9Bko4hQ86pBQlSbg==
X-Received: by 2002:a17:902:f80a:b0:17d:c0e3:fde with SMTP id ix10-20020a170902f80a00b0017dc0e30fdemr4973461plb.29.1668726773667;
        Thu, 17 Nov 2022 15:12:53 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v28-20020a63465c000000b00412a708f38asm1606122pgk.35.2022.11.17.15.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:12:53 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     liubo03@inspur.com
Cc:     Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: replace IS_ERR() with IS_ERR_VALUE()
Date:   Thu, 17 Nov 2022 15:12:18 -0800
Message-Id: <166872673515.147705.12252341599005148721.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115031757.2426-1-liubo03@inspur.com>
References: <20221115031757.2426-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 14 Nov 2022 22:17:57 -0500, Bo Liu wrote:
> Avoid typecasts that are needed for IS_ERR() and use IS_ERR_VALUE()
> instead.

Applied to for-next/execve, thanks!

[1/1] binfmt_elf: replace IS_ERR() with IS_ERR_VALUE()
      https://git.kernel.org/kees/c/dc64cc12bcd1

-- 
Kees Cook

