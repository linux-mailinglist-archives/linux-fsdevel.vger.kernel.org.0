Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8342868AFB2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Feb 2023 13:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBEMWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Feb 2023 07:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBEMWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Feb 2023 07:22:00 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2956D6582;
        Sun,  5 Feb 2023 04:21:58 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p26so26969355ejx.13;
        Sun, 05 Feb 2023 04:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESR27gS0Q60mwFX3gxHFnuXLWXp7TrVvVnn7lkX+iM0=;
        b=hT3llNhvBzzBEUm1Z4GYcZIQXdY/lfmjijV1GQm3HxSG6QbVs81503d838x9CKNBOL
         cexI0WKfl7L4j98qblU4EwdJI25ggj5OSaLt6gzZKCZCFJXicYpzxyDmMnEYXXnMRAzy
         J7X2AmgdsEYEf4g9s9A9UCa/MhtWzXEU4GQHUT4b+WvqNCgA60XfHZF2wHoK9HuLwITf
         /hdAMYwYK273vNnFicNom6VXJPngmfZOtJzPhoQeKOAwwq5z+F2gl0JLFuH8LRa6rNeb
         FFjkoW3buPyQ52EfjJW+B9BtN7AAu0wY8yQ27wrEyGqCZaXB3Wa2Gc4dfGIhEjRsUiSS
         3/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESR27gS0Q60mwFX3gxHFnuXLWXp7TrVvVnn7lkX+iM0=;
        b=JENTyGnktZy2bUBGbwKfnXMBFCS3cmMP9vd8L6zASIZCVYvCRuItxB/VTk0FWkqnZZ
         ZkiN6D7xZZp/F3DOqlyq32yoGiYBj/2+0afqI1hPxzj4oYq2MJkGqCYg6Mtj2hx/O5P4
         eMxTDu0kmevG7RpVZvh7Jz+2YfKX8xChoI0CoslNDU+qQDuPfuiGcrXZVuhBqAJvYOG4
         0zHtCZkXzQbEhARNQWPi5MjefRRNJt2zCLvbToGPB1QJTx++Kr5k/8IY7f2tu7Nr3v4h
         1gvDAv3PEpolt3oudCFkbmegByDkq0nV/aTOXVLflZuads4VE+Jreo+74nu4ootWIi+l
         ecsA==
X-Gm-Message-State: AO0yUKUdpVcsYXN4TtmzHtmq3ctM/FyMhyF5EOhA6pDkENK6YMl6t0N/
        O51tKWyiTVqr0iBVI8I4Ve3EsxACYw==
X-Google-Smtp-Source: AK7set+PzHvN3EfoOQj3bCgUQrjRNqfSHeHERxL6cpm2HrwtF5ChGKvQ+YbtI3vYrQpK2Rxx6SmkJg==
X-Received: by 2002:a17:907:3e96:b0:88e:2ff5:85d6 with SMTP id hs22-20020a1709073e9600b0088e2ff585d6mr14736954ejc.5.1675599716691;
        Sun, 05 Feb 2023 04:21:56 -0800 (PST)
Received: from p183 ([46.53.252.66])
        by smtp.gmail.com with ESMTPSA id g17-20020a1709062db100b0087943d525e1sm4022893eji.215.2023.02.05.04.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 04:21:56 -0800 (PST)
Date:   Sun, 5 Feb 2023 15:21:54 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chao Yu <chao@kernel.org>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] proc: fix to check name length in proc_lookup_de()
Message-ID: <Y9+fYuixrjGnkReH@p183>
References: <20230131155559.35800-1-chao@kernel.org>
 <93c1e281-82a5-d7d0-04b1-67ac2cf3d0fa@kernel.org>
 <20230202154154.64a087a47bbf2210584b1734@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230202154154.64a087a47bbf2210584b1734@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 02, 2023 at 03:41:54PM -0800, Andrew Morton wrote:
> On Wed, 1 Feb 2023 21:01:14 +0800 Chao Yu <chao@kernel.org> wrote:
> 
> > Hi Andrew,
> > 
> > Could you please take a look at this patchset? Or should I ping
> > Alexey Dobriyan?
> > 
> 
> [patch 1/2]: Alexey wasn't keen on the v1 patch.  What changed?

Nothing! /proc lived without this check for 30 years:

int proc_match(int len,const char * name,struct proc_dir_entry * de)
{
        register int same __asm__("ax");

        if (!de || !de->low_ino)
                return 0;
        /* "" means "." ---> so paths like "/usr/lib//libc.a" work */
        if (!len && (de->name[0]=='.') && (de->name[1]=='\0'))
                return 1;
        if (de->namelen != len)
                return 0;
        __asm__("cld\n\t"
                "repe ; cmpsb\n\t"
                "setz %%al"
                :"=a" (same)
                :"0" (0),"S" ((long) name),"D" ((long) de->name),"c" (len)
                :"cx","di","si");
        return same;
}
