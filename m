Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786302506CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 19:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHXRrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 13:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgHXRrP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 13:47:15 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7753EC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 10:47:15 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o12so3560005qki.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=StF6bB4UWbDFXeIXLNgWaQ0wb1WHoXUyLjdPmHg2y3s=;
        b=I6F8nKYoD6kg32z/F376of7d0yLvUYhCvkSH+kwG3mlYEVXqDg8EyA6s4hMjburtXu
         S2jvqLpzyyc0gPtGIkQDTn2Y2cC+GwoNxMCmysX6LuBAamxZgsdNKkNabmvGqyCbgw88
         46iXwvr4Vsj3Y0SGIX3cNqR9pyEEqmsvx4pccKLiZUvyApdavZ4BygOVQf7vIpbk/vTr
         cMfSF2xrhQZYMKSfb8iYrKhOLEGpbsczdyxbeKLRf4Lw58WHVvAwI7dqWG4KJ/BDBicQ
         A4bR88nSdLAv8uPdZI4cH0FPdrJBGHrHB3+0rv6eLO5+R9ayEfwW9fOvYxRdAUPqz/40
         B03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=StF6bB4UWbDFXeIXLNgWaQ0wb1WHoXUyLjdPmHg2y3s=;
        b=N3sCauUM3nfVdv6JixDkPe7drQlleb1VTeS8q0I7sXxV2AVjfl5fKhAS2fMmVEZh8Z
         QGx1BetfdN8Sv1Yu2qgmlw6PRkiEY9ihfGKd14VmTzsiL+P0hcEWTBpMWLxkblSqBvnI
         izxcaV2Dx2U9VhLcUTaId6pKMqUSrg+a9yHQM1x64Su0fJ0a4o7Cjgat2aEllNkOppLP
         zQuskj3IzcT08D1zUCdXUOrCQ8MImJQ09R5XYkIJz9gCBQW0Wrs5dOtdGrpxFhxxIFIw
         Err6ZAGzJV0nkn6EqZ9sbVufo8sADGQtGFRhkPpXaHedOwqncYUDOR4PH9B3hEuGzdgZ
         8FoQ==
X-Gm-Message-State: AOAM531KwpxKBUDdnB59jo3MC4Uxug05y+OOhh/Q+Sfklkjo4t+QV5cI
        xdmKZoLjCEvpU9t3uJqeJW9u2hCZEdeTeOIA
X-Google-Smtp-Source: ABdhPJzKXGe6U6WzyTRf0KI4z/eD/R5LgUrTcAkezKetBl9f1VpmQmHQ5/o30KfKImCVTof25LPSOA==
X-Received: by 2002:a37:2781:: with SMTP id n123mr5591902qkn.59.1598291234150;
        Mon, 24 Aug 2020 10:47:14 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o16sm5076056qkj.18.2020.08.24.10.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:47:13 -0700 (PDT)
Subject: Re: [PATCH 2/9] btrfs: send: avoid copying file data
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
References: <cover.1597994106.git.osandov@osandov.com>
 <be54e8e7658f85dd5e62627a1ad02beb7a4aeed8.1597994106.git.osandov@osandov.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <254329fa-6264-03c1-860d-fefd026bd53f@toxicpanda.com>
Date:   Mon, 24 Aug 2020 13:47:12 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <be54e8e7658f85dd5e62627a1ad02beb7a4aeed8.1597994106.git.osandov@osandov.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/21/20 3:39 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> send_write() currently copies from the page cache to sctx->read_buf, and
> then from sctx->read_buf to sctx->send_buf. Similarly, send_hole()
> zeroes sctx->read_buf and then copies from sctx->read_buf to
> sctx->send_buf. However, if we write the TLV header manually, we can
> copy to sctx->send_buf directly and get rid of sctx->read_buf.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

I couldn't figure out why you weren't just using TLV_ helper for this, but then 
I realized the len is the length of the data, so you need a special helper for 
the header.  Just in case anybody else gets confused,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
