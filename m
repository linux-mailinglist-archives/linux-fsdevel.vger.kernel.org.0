Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250A06FF71F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 18:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbjEKQZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 12:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbjEKQZu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 12:25:50 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CC83C18
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 09:25:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1addac3de73so1360735ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683822349; x=1686414349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fBL8bhBy0L4WzzJgjFN8jfCCTqySRrwPrRB44wIqevQ=;
        b=OQgPu4YfTZL7qqqkSJj4wN2FQ1E0myYUr2GFLGfFuX6XttnvbpHBEg86DJXLw/zJc2
         r5yBNAb5iPFZaPKz9C15Oc0wI6tD9mpl63JET8HQkFgrBl6aODupG7GbTSHEfekv9OD+
         zfK69uhe02+gc+45mfBMcsowVM04C0/mv07TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822349; x=1686414349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBL8bhBy0L4WzzJgjFN8jfCCTqySRrwPrRB44wIqevQ=;
        b=YFCcCZMhy7hhNQcrOqc6zRxNGm1vcmVebG06egkyx9kysvSSZiptQEL0ZHwfnMiWFU
         LEKkNKzDKPj8aGUunXXsIrlFhFigSlu1IcHpqAqKB82cEdzZH6v4N8iDJEFev/tvPLUf
         i68DprJPro5G4iHvNrOfcvoneLheyMY2sczAjJaOvK9V/lh9rE3wACEHHPLeFq64zafW
         7O9XYgc7BoPqcOkVxnGRkaj4IblMzL0PZPV2+yYn7NjYm9Tn2oNYbtF+/8/yOnAJaEwR
         4EXEQxiQs5a6A3tMezwQt09nPIz5GFlvkJ/jkxW321yqgsCa3IgJ6r7nsHnQKCNLlzcY
         yaPQ==
X-Gm-Message-State: AC+VfDwkonIbLflhvXwKQfNfEBXFLWFV2dTipleBO7mqhlDMEAzWmE7V
        XaaiXyd0tnCyUfYefjIQkrIN3Q==
X-Google-Smtp-Source: ACHHUZ5YybjzuwHfar2HV5/lx275nqiclRLoLzKA8d50fZnsezq6TRfbkoiOP0AKkYFTBZcU2VXqSg==
X-Received: by 2002:a17:902:c946:b0:1a5:22a:165c with SMTP id i6-20020a170902c94600b001a5022a165cmr27425021pla.0.1683822349131;
        Thu, 11 May 2023 09:25:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001ac7af57fd4sm6144610plb.86.2023.05.11.09.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:25:48 -0700 (PDT)
Date:   Thu, 11 May 2023 09:25:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] procfs: Replace all non-returning strlcpy with strscpy
Message-ID: <202305110925.22DF454F7F@keescook>
References: <20230510212457.3491385-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510212457.3491385-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 10, 2023 at 09:24:57PM +0000, Azeem Shaikh wrote:
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
