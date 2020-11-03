Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADB62A48C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 15:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgKCO61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 09:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgKCO5w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:57:52 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD371C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 06:57:51 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id b18so14847438qkc.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 06:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+bZraXjlwiXWtHvYgrgXFNOGII49UuD/qUqho59g4f8=;
        b=uGsa9mbUsilURKu0n+jMxoXFkcl866kFbHvWKkVyiyIvwQTPRyE7bs2EbdYiTD+Fw6
         5BGCigSwP9ORRVdgOA/2wRvzvxDpJWHkF/2B1Vt8WY/kuIl2G+s2upPkCtZtoPnohp42
         DEoPiXiyd0wOS5AHkFEdxc5YHHefoQNpHlen4Cs+QJV1bVVaYiwN1nTwlIwsAjvSGWZW
         cuKQG5brtm8naaaKSlZoNMk0DBeTL9/yiCnWqThRFhbqw5nUDRrx6fATrGs79NZo8fLH
         oai9DSir+ndrlbnEBDqT56QXfu22VjekWh0AadG1yKLv3uSNbUUcuV0mx3ZtvmVtLR+h
         lzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+bZraXjlwiXWtHvYgrgXFNOGII49UuD/qUqho59g4f8=;
        b=VR/bbkGEM5CwaSHU85cF8e6kupJXCE4D3oBRTa8fkiDObotLEQ6z/Z2zdP30mNs6a7
         2o9QOWFyO0UBCCMN4aSoP09SVggWuTg//cut5/xgRg2Dl4UF6NylXsqAtulGoA17DzPb
         6KUX9PM2Pm6+BVW0acrHHesD3Yb+yqpYXe4+Zaiptkfwbs2l54z6b3qb+PB9ahicTVt3
         2odlAQ2r+nrboxE8r9EQNViy4TSt4mi3sGWYEOm1nGM85iEs018XXMWMdcHFnbn7ANLt
         WEOA5ZZwJkIjlAkAs/GWGsY628R0FSCBFIZyfHUfIv19B/Zm4fCTB/jxAuWvqQrLaZEX
         lZdA==
X-Gm-Message-State: AOAM530XStnYzsPoynVSAlqAf69lWdB6Wm6NDNzHVSTW7WIzVUf6VbTF
        3dNaob8jdf7qrE9vH3v8qTvnQrTibzg3ierF
X-Google-Smtp-Source: ABdhPJyOdeOhcJKr8v0Dn6YU8ULqyTydRXk3FaZ/4hUyEoCYhg8R2MJanCDaXVKoH4zwDfEWvtpwtg==
X-Received: by 2002:a05:620a:814:: with SMTP id s20mr19958309qks.127.1604415470895;
        Tue, 03 Nov 2020 06:57:50 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h125sm10431187qkc.36.2020.11.03.06.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 06:57:50 -0800 (PST)
Subject: Re: [PATCH v9 22/41] btrfs: handle REQ_OP_ZONE_APPEND as writing
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <4f9bb21cb378fa0b123caf56c37c06dedccbbf1f.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a31167bd-9713-467e-884d-7c8340a592d6@toxicpanda.com>
Date:   Tue, 3 Nov 2020 09:57:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <4f9bb21cb378fa0b123caf56c37c06dedccbbf1f.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> ZONED btrfs uses REQ_OP_ZONE_APPEND bios for writing to actual devices. Let
> btrfs_end_bio() and btrfs_op be aware of it.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
