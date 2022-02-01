Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583344A5E8C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 15:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239444AbiBAOso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 09:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiBAOsn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:48:43 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D64C061714;
        Tue,  1 Feb 2022 06:48:43 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k6-20020a05600c1c8600b003524656034cso1791872wms.2;
        Tue, 01 Feb 2022 06:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Yr6l4WAzs/sh+j2DdHdIhNo/8cVO2SAzpYdunNPosVc=;
        b=UqxGerTkLW0ev9zk1s/oTb44FweAceLPyY1tL195DfAbjFPCNKV53FRDAqGGTNGwzk
         ptVJsRECcN7LfW4UIBibL0WvXPsha34fNtHCC6cF23LJQRfFMScPFMNP5CInzesO6tAk
         DFPl5oiqXXK6sC0kfy3HqJf8oJ20dQm3VFAmuBzAWbkQtH5co6t/JPmC2iWg6ZUojzpv
         jM7uGup8vtJUHkDJ5OYXfk3yLayBD10reHN8sGXYCWXfcN/TnjXD9CgBk9NWzzYdf1hW
         ihFDJ7etGs9GABuE5vEAvwRI4fRY2UHGqi6bopK3Ys1AFTz0/Xt2cHsCp5gDt+1CTTgY
         qzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yr6l4WAzs/sh+j2DdHdIhNo/8cVO2SAzpYdunNPosVc=;
        b=Acz9kkZQYOyvzLqgoSh8iqNOaqYQrz1WMryCntGiL2mbc1j12dCKLZaqejygHuiyzJ
         chVCYfBCwH9S3lqcjF91YyBjI2RQml+eB0llkScyl3LHbFV+GqsRGZEC5rP4kagjm3+t
         5X34Oh54Wm+WMYMZcwtXqrMpEbO9ZK7ZfgbbhVU8gIODwB79odC5loufPsTXTj2rbwcr
         mUIcB8lw0tMpQfvks0nysF0OjEWT/Vav3GoWK8ZwDppn569mJ52M92sGSGR6bE4swE8e
         t6QMPJA0uiS0E0TUD3WuAZK31a/jMlYzXdaO4riokq9r80C0kAiTcGyp6qjDCjWLfww7
         Mz9w==
X-Gm-Message-State: AOAM530qmD3hGW1HSQsLHkhVOBDs4/uOQL9L1olqI7D9GB7YKAUSBs7d
        D4Aqn6M0ZzRkHdXh7Q5/MTI=
X-Google-Smtp-Source: ABdhPJzhxsxGMeWGGKxk5J7ePZW5h1PEBqm+UcDM3TmzAvhGBz6SVXmtQKsBid+Vw/LycV5xd+/VCw==
X-Received: by 2002:a05:600c:3514:: with SMTP id h20mr2080315wmq.164.1643726921970;
        Tue, 01 Feb 2022 06:48:41 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id a15sm14804160wrp.41.2022.02.01.06.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 06:48:41 -0800 (PST)
Message-ID: <a01a4f9a-da28-1135-080d-568de19e3d85@gmail.com>
Date:   Tue, 1 Feb 2022 15:48:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: EINTR for fsync(2)
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mathnerd314 <mathnerd314.gph@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-man@vger.kernel.org, mtk.manpages@gmail.com,
        linux-fsdevel@vger.kernel.org
References: <CADVL9rE70DK+gWn-pbHXy6a+5sdkHzFg_xJ9phhQkRapTUJ_zg@mail.gmail.com>
 <55d40a53-ad40-0bbf-0aed-e57419408796@gmail.com>
 <Yfh/E5i/oqhe6KsQ@casper.infradead.org>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <Yfh/E5i/oqhe6KsQ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mathnerd314, Matthew,

On 2/1/22 01:30, Matthew Wilcox wrote:
[...]
> So while it's worth adding EINTR to the man page, I don't think it's
> worth going through an exercise of trying to add every possible
> errno to every syscall.
> 

Okay.  I documented this error.

Thanks,

Alex

---
    fsync.2: ERRORS: Document EINTR

    Reported-by: Mathnerd314 <mathnerd314.gph@gmail.com>
    Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
    Cc: <linux-fsdevel@vger.kernel.org>
    Cc: Matthew Wilcox <willy@infradead.org>
    Cc: Alexander Viro <viro@zeniv.linux.org.uk>


diff --git a/man2/fsync.2 b/man2/fsync.2
index 0f070ed2c..c79723ed8 100644
--- a/man2/fsync.2
+++ b/man2/fsync.2
@@ -126,6 +126,10 @@ is set to indicate the error.
 .I fd
 is not a valid open file descriptor.
 .TP
+.B EINTR
+The function was interrupted by a signal; see
+.BR signal (7).
+.TP
 .B EIO
 An error occurred during synchronization.
 This error may relate to data written to some other file descriptor


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
