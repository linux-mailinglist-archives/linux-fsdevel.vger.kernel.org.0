Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F338764181
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 23:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGZV4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 17:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGZV4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 17:56:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990211BD5
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:56:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b89cfb4571so2169815ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690408577; x=1691013377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTnTPyUChx0sAwZF2MNrXaeFAkRzkrBXS0aTBLLDPZk=;
        b=IWcOTkAilfjO30aVduyx1ux6dmmPLPp6fYwqMlinVp/BNgslgirUI3K6QQoyv1r6DD
         sHjD3GPv76lR4SgFTkxqc7vxAWWLlkH+eiK+gDlw64nGIIYAI9Y1qvparPJGxBIDBb7D
         VGvlXJjMWhOa7FOFji6IA3pwQ77ikVyyRsGew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690408577; x=1691013377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTnTPyUChx0sAwZF2MNrXaeFAkRzkrBXS0aTBLLDPZk=;
        b=AwN1ExvXM5qBQ0WpbeZKSM8lq6un+bsXgqAKLdDo/IOIzVP52b2IsVANF4252UA585
         XLUv3lDBFh5tOeRliwWE7VvtYCY0emJFm2VbYMLVjfHSh6QoyLvKwgFOikefFLPOt4H3
         uP/TnLlBNTqWL6vD0kf+aOZbnBWlK1OPfgdjTSsDHryB4WNsKvPnafK6sZVHmMJHCyPm
         WcH93ScQq480rVhB7VJR60RT6Ib2DrXXzVBKL11vhcsBiCsQUOoKnJGU1tUiGClBGbr4
         huIIuqsiKj+2QhYa+TcFcvfnweA4WAydKmfd9wFGm8qg4NwQpTj8QMW9CyxIskgmkh8k
         AZPw==
X-Gm-Message-State: ABy/qLa7TUkNDz8BQGZ/hAnRSHp8pAnLbjkshm3ZZJVpqQhprcFOz5fr
        HOoEJAyOeolm3tIIT8K0ISJyOw==
X-Google-Smtp-Source: APBJJlGTizBLly85YS0wuAFV+YY0tSPJ/d7SY5Zcm8qrRSfPM+8K7M05ND9D80PgFvhVWNLiI5TmsQ==
X-Received: by 2002:a17:903:1cd:b0:1bb:7d2f:7c19 with SMTP id e13-20020a17090301cd00b001bb7d2f7c19mr3117909plh.64.1690408577108;
        Wed, 26 Jul 2023 14:56:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v5-20020a170902b7c500b001b5247cac3dsm32637plz.110.2023.07.26.14.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 14:56:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] vboxsf: Use flexible arrays for trailing string member
Date:   Wed, 26 Jul 2023 14:55:48 -0700
Message-Id: <169040854617.1782642.4557415464507636357.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720151458.never.673-kees@kernel.org>
References: <20230720151458.never.673-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Thu, 20 Jul 2023 08:15:06 -0700, Kees Cook wrote:
> The declaration of struct shfl_string used trailing fake flexible arrays
> for the string member. This was tripping FORTIFY_SOURCE since commit
> df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3"). Replace the
> utf8 and utf16 members with actual flexible arrays, drop the unused ucs2
> member, and retriain a 2 byte padding to keep the structure size the same.
> 
> 
> [...]

Applied to for-linus/hardening, thanks!

[1/1] vboxsf: Use flexible arrays for trailing string member
      https://git.kernel.org/kees/c/a8f014ec6a21

Best regards,
-- 
Kees Cook

