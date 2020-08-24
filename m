Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833D3250879
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 20:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHXSw3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 14:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXSw1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:52:27 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720C9C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 11:52:27 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s16so7020362qtn.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 11:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/a87U3xOIsepXqYxdXZyC67pPTYVYefQcfmWIfEUAdQ=;
        b=IZzd4ap3bSsv82zPm8HZR1QrAFc4aPstasMKpdH9fAGqnOZeRREXW1ml9vm3M+zH1j
         Iid0qCkyoDnQ7Gp+rQFgWZDOONNbCUWqxTYW38+4ITFteD2Mf+8aLc44+ecIGM9+mUXp
         exTRVlmDtmlciJidQjLyEugzTYdPVkRzv9rnK2oHgzQHMRnCxOP3XTrtH/o29RlCy5zn
         ui62uTIgeLIMW2xlL+o6+M0Av7VFVGbakljYqAreFJ/i5kFHoNSwINmo1EyxNxwDyjc4
         CrlwjTwTdzhulvt71JAhRWNnZ6nGoYdjmHK1IIzvGZNLkorMx6+xvi3SrtEpeFsfNGVO
         hzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/a87U3xOIsepXqYxdXZyC67pPTYVYefQcfmWIfEUAdQ=;
        b=F+QV7dfVWmx5rNh6d4L/q68Q7nTmSoCybycfnwF2EvhYxjmBLBDA3ubyin6zUjOIDH
         YS/H8qVVf8z+TIl4FDnSjYlla7/DGnNIaJXQo9ATQwJ9PTxBPdZ3gYjewH2FdUiBjFVz
         1REmdwAN9KMxyUrQX06pra/YADYZIpHTWbSQrSLmfyqzQ7HQhag8ZMhPhkmVLjC4OC0v
         KH4gMGVNHU9yTbDPgIxFMbiddy6q9HdZAjcKw0q1e/f3/6iNWsmKYZDaavDhVl7fTibZ
         A9RfQ7b1UgMOIardhBtpo/f75p3gwERXhMyfC8bquheo3DlZs1MkKA1d6zWxIj3XWkDB
         S/dw==
X-Gm-Message-State: AOAM533A3p+YUqYrojO3GXOwTJaVcKXysAvWP4zv3zj1lhA9t3VfuecT
        GHGrp6avrYmHXyaqQjM4pCk9xA==
X-Google-Smtp-Source: ABdhPJygV/nBVHEX/50hfW861ZSzyEdIO8Q5zPGw2DgDUDPPFLhBT4KyvO3z+Zq840xPgfWOgaJNYA==
X-Received: by 2002:aed:3ac7:: with SMTP id o65mr6169171qte.11.1598295146628;
        Mon, 24 Aug 2020 11:52:26 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 22sm10205679qkd.64.2020.08.24.11.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:52:26 -0700 (PDT)
Subject: Re: [PATCH v5 1/9] iov_iter: add copy_struct_from_iter()
To:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1597993855.git.osandov@osandov.com>
 <8010f8862ec494c631b1d7681a6c5886d12f60df.1597993855.git.osandov@osandov.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <93eca2d1-f72c-2181-b6a4-7015886f2418@toxicpanda.com>
Date:   Mon, 24 Aug 2020 14:52:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8010f8862ec494c631b1d7681a6c5886d12f60df.1597993855.git.osandov@osandov.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/21/20 3:38 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This is essentially copy_struct_from_user() but for an iov_iter.
> 
> Suggested-by: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

This took me a lot longer to grok than I'm proud of, but the idea is you'll have 
a single segment that represents the incoming encoded data, and then subsequent 
segments will be the read/write buffer, correct?  The code looks fine to me,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
