Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA3E4971CA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jan 2022 14:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiAWNzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jan 2022 08:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiAWNzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jan 2022 08:55:55 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4120C06173B;
        Sun, 23 Jan 2022 05:55:54 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id p15so14022765ejc.7;
        Sun, 23 Jan 2022 05:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6hQZBPknnRdcWgKsFRCk6L4lu1f0oDpFYzGuA9VD77o=;
        b=mRCfqJbZsNf8IiAhuwfMcUd3mSFoesuaH29GAQR8qcXTEQBI3To2oddKPY7ZU1pwnp
         Ph/FpYLiGE0PAInkQouB8cFJjysKuWCpPJABnFKUM04i+qR9v6vXtcLn+4Ncm1kx8L4D
         H/zxgC5727PeFZQtlqQ84aILr93pu5JQpo2KyPGPO3eO/Bq1rcN9qQg2DyGAIDQ85me8
         E2RdDWFneFlMH6UpLdyoxwUlWcjVjw8Zevs+K7Prza8SV4kXg8lP/kiUOQtf7OIQn2DH
         jBKu/0mXrWdfYplhosjCoxRgdpH1cV1Oc5guRKx1A1cx9fxc3NabrtLknuerxHtHhCSN
         CGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6hQZBPknnRdcWgKsFRCk6L4lu1f0oDpFYzGuA9VD77o=;
        b=mbecj7M6GU4Lq/nWayhT5HRz6LRCJBsQMEVXh69T4Voidt32EZlDPCpaL5rgDw+087
         yhfRAdFPHlOG8FwrgsBK0fFo04r/QMpUFib2hnZEkbKQZDqooVYoHjA3enKCXrxOtJ+r
         RuLdG3XI018He/FUsSIAkBxtULfPIyRtMi/BnBoWoMkvBB++V57BCqj9ur+gnfHHS6gQ
         Dj4ed1Fkb3KvKa7mDkvgXQI/l4eFNWUlGDwF1cnuzjOso53pTt0xMVzBA5hQKnPgwSDO
         hnuNARpzDruuGfIn/LAkS03VhV6jTXoRh+s1gqLzXC8dMUCaspZDFyxrKgMeMWDAygwz
         FFKg==
X-Gm-Message-State: AOAM530f94Hn69aT6mh4zTPxIR9UGQ1FCHA1FZoQPoNbsYDKXohI8FfL
        7piCOHbBKLRnxjNVg6dzsQ==
X-Google-Smtp-Source: ABdhPJxuKVIXdOO9I1ku72CGXA+1EVOmydEc98hf+Y0TPlf9tq0sPyM6ll4Tbxlx/USYKWpaqvJHag==
X-Received: by 2002:a17:907:720e:: with SMTP id dr14mr4848739ejc.146.1642946153336;
        Sun, 23 Jan 2022 05:55:53 -0800 (PST)
Received: from localhost.localdomain ([46.53.248.28])
        by smtp.gmail.com with ESMTPSA id h3sm5053638edq.83.2022.01.23.05.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 05:55:53 -0800 (PST)
Date:   Sun, 23 Jan 2022 16:55:51 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        keescook@chromium.org, jamorris@linux.microsoft.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: use kmalloc instead of __get_free_page() to alloc
 path buffer
Message-ID: <Ye1eZ5rl2E/jy8Tk@localhost.localdomain>
References: <20220123100837.GA1491@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220123100837.GA1491@haolee.io>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 23, 2022 at 10:08:37AM +0000, Hao Lee wrote:
> It's not a standard approach that use __get_free_page() to alloc path
> buffer directly. We'd better use kmalloc and PATH_MAX.

> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1764,25 +1764,26 @@ static const char *proc_pid_get_link(struct dentry *dentry,
>  
>  static int do_proc_readlink(struct path *path, char __user *buffer, int buflen)
>  {
> -	char *tmp = (char *)__get_free_page(GFP_KERNEL);
> +	char *buf = NULL;

I'd rather not rename anything but keep it minimal.
