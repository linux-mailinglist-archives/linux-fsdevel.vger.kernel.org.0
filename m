Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2DA6FF721
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 18:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238804AbjEKQ0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 12:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbjEKQ0M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 12:26:12 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86AD468E
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 09:26:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ab1ce53ca6so63989285ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 09:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683822371; x=1686414371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QFE6EmlE8h99fLdr/n78erJnKE49/4tug0gzOrRNkC4=;
        b=EykkaEjgbAGDvabHBLyWwMb5BAmPVn90y9ZuwrOrcyra7YiaUkI9aV5h2w1lCQ37o7
         fFGwZbZxXs1vpisb0PJBT57PCO3eTyqHbVObO3K1AvlePcvsae6uSA3oFs045YJS57tY
         9jMnxtB9ysCQBRTDrq10wyatmNMEGxhOlioQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822371; x=1686414371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFE6EmlE8h99fLdr/n78erJnKE49/4tug0gzOrRNkC4=;
        b=VPttgMOg+fGF3mCWtlvnfrf5kd/enQeKSOJ7eDEFxYh1sLeOkY2kQtx7gi68KRCfUq
         aEzk9H5N/zaiO9RQyT6ssGm6iNa0V5nath0MtKXelRwh8kfT/WpBC2aPFnKTuEo1/86v
         B5OMklBdUD6YuXbwEvaEnYZGl6llcbKCT2Tnz0zvYi7cyGvCgC9lT9eF2ioOl2Rk+Rkv
         FxY/t3eqOz5D1Y6GUCxQGAJ+uDG6rDNJmE38tThYtkyYrqoqIv73UiwjnlZxn+jOm8q4
         PWw0YgWrn0fx97bs3wPYLcoKM61ZUXd/tq/aYFrWwdqW+QS1xJLqJaLnRLQfDSg2W064
         Kn5A==
X-Gm-Message-State: AC+VfDwIsQo9jocdiue8pY6T57vfQxh+8FyC2Toy1bOvFmc2TcdkMXKg
        2j8b6vLCEL2wr0x00SFU2yZrJA==
X-Google-Smtp-Source: ACHHUZ7YjRd0bUpXxDJX4dIe0JbB/PRyLu0ViHF56BI+ScwquFW5Ze9lgc93oetrShHB7yrf9gYNCQ==
X-Received: by 2002:a17:903:1d0:b0:1ac:7624:51d7 with SMTP id e16-20020a17090301d000b001ac762451d7mr15220371plh.69.1683822371220;
        Thu, 11 May 2023 09:26:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903244900b001ac94b33ab1sm6137598pls.304.2023.05.11.09.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:26:10 -0700 (PDT)
Date:   Thu, 11 May 2023 09:26:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Replace all non-returning strlcpy with strscpy
Message-ID: <202305110926.05E8FBD7E@keescook>
References: <20230510221119.3508930-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510221119.3508930-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 10, 2023 at 10:11:19PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
