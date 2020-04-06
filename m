Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB9711A01B9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 01:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDFXd4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 19:33:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36954 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgDFXd4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 19:33:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id r4so815372pgg.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Apr 2020 16:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=APdJ2bbJpdKbX+Sk+LIMoTdwNG0LJpHDXmC1o7gJlEs=;
        b=msdjWJ+QJBaucO7GD9Jl+hBSA0PUl2BSJiwTwyO6NYTKgo++vqVg0TAlaenuKxaTZH
         GYQsp2YXDWbKyhaXMpwDDw/f8KKk2nByDrmkaR9QtCgoObBvBvsJovisx7niVMxr9702
         HRN6s+4JhXbxnccjpu+npnHfsUlpmPlkRjJSupNg44UW8zSTOsACZtlAYb/VLrwdf8Et
         xI+Hq3cQG1FvhxS54t33C0gsvLaBf9S7l6fbWaRVz+bq34EB+IoQoBhXm3AQ+gdogGfb
         O/2EDSjYBb+Bh5JHEyapryREF1j2xeLhg4WgvCTPCJsDuS/cIFjxCJ9foE2VJEeRXbNp
         fBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=APdJ2bbJpdKbX+Sk+LIMoTdwNG0LJpHDXmC1o7gJlEs=;
        b=bSCCnO9KSSteP5+ems5O6qrHleaHBPikKlpkQNw+12GFTebTpMt8dQaNSRlDQb3V4b
         pEfhffGVmieGOPTmXlJStY6Nne2PDHFQi/Wsx7XYTskF/Nkk9Nqb825JVwofWo8pSh+L
         jxkTNK/vpfa5CT+ekjpmWoqEKfj1rfgtN6SsUt+fyka1TKXU8J3lj8Q1/xDCIZ7kFRzz
         BBBgsT/Fz6IA0qSCER4XjDehzXfwdgXbiYb8xF8uxaSsr4XECGAcdcN0gKXMWSwZK027
         8Xjk31hdJOi5Jd1RdjqoyPnFPlBMrEkYm/ot68EWP+q8Bv/7lBuwQnafNHfN/+RLp6mP
         gcSQ==
X-Gm-Message-State: AGi0PuZ6/igLAitjaJPgj0llwnXqlRDL05DVt/ed8rjq/+1TeU1aw7Lf
        mF6Gqu75+0RBDmi7sQcn7/Mjas4uVceVSQ==
X-Google-Smtp-Source: APiQypIo2Aco3bI5Gz4obU/4cINPuKZSt8IQago27JXTS7utPnzZj8oW9fEgGAHRnl7DNBznTHSsUg==
X-Received: by 2002:a63:9a1a:: with SMTP id o26mr13288335pge.447.1586216035546;
        Mon, 06 Apr 2020 16:33:55 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:7d7c:3a38:f0f8:3951? ([2605:e000:100e:8c61:7d7c:3a38:f0f8:3951])
        by smtp.gmail.com with ESMTPSA id r189sm11918932pgr.31.2020.04.06.16.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 16:33:54 -0700 (PDT)
Subject: Re: [PATCH] io_uring: remove redundant variable pointer nxt and
 io_wq_assign_next call
To:     Colin King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200406225439.654486-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <434016cd-bf33-ce65-a86b-69a565d62a61@kernel.dk>
Date:   Mon, 6 Apr 2020 16:33:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200406225439.654486-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/6/20 3:54 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> An earlier commit "io_uring: remove @nxt from handlers" removed the
> setting of pointer nxt and now it is always null, hence the non-null
> check and call to io_wq_assign_next is redundant and can be removed.

Thanks, applied.

-- 
Jens Axboe

