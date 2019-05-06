Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 695711511B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 18:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfEFQVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 12:21:50 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55346 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfEFQVu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 12:21:50 -0400
Received: by mail-it1-f196.google.com with SMTP id q132so6006058itc.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2019 09:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JM/WZfijWawO0dM75sC9wd0xm0O1e7k2DME12T/WG/Q=;
        b=UFXgx9HuMJqBVirFEYXePbVMPL7ifubbChBpKxZBsozZhVZdUX8Ot96uTiSw/V7CNk
         fSLYzzNvhbUb5hAYmI5Zl6SEyQ2jdbAKtEms3Ypy2pQmMDDum4DOht2B4MltviwdHnoq
         pXa0AIgIt5dGhunS5vhMZ92AiF53tkkXPDPv+0pTedFeqkTRhFOKBfgyTCqxB/Bi1xP2
         dPQnaN2VrGkDeGBjsgm960JmoMz207/11+prKIuW9Ru/8earF5aZf93UhtGUWdlB18Eq
         8yfQOtssex78N19DTIEBJQMWZ9atH8CaNx3iNa+PeisifL3Ff8LW9WaSlUw/DyuxyxS9
         5Phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JM/WZfijWawO0dM75sC9wd0xm0O1e7k2DME12T/WG/Q=;
        b=EKPeSc0S+9i512sMxqfNSBCSOXnKxNhwfRkriJKSAygbGZC5jQcXz7EGdVtCgtA1xS
         sADEa7l9ksZLfUmZDqVQpA5/512t6qxg9HCOsdMVzB26q92gwhpaPYlxv4hFsMSPP5q4
         FKuwYH+poEVfcYczr8KYnOwPy0kZoN8gBbXnPSCWZaMt5UCRNlqIF+FpRNRK/TPyOUbf
         /Vmb6WIbqvha9OiaXrFIAdm+IpVo2qj3qrSx86U/sY+0vrgAO3qTA3BE6ySGE0lCzJeH
         KF5VcAFoce3ncgJ2O4KEDlzmPDRiPv7zoqxE2tiuQ1L03A903m4Pno+PfmXQrVZGXKGk
         +YXQ==
X-Gm-Message-State: APjAAAUJSs0H5uqe4xFKMeoypJQB6AVxhG3Dv24t+p6wZTEHvEq364Bz
        La5up+OGIliGeAco/MAjVH2lDg==
X-Google-Smtp-Source: APXvYqx5RyQ8KTZzVdgGtPBddYXhbpfXTeY6xfZ5bVFKqngkFqVvd5/hfJWmx5YQugDGs5G6H8rXIA==
X-Received: by 2002:a24:6987:: with SMTP id e129mr18889644itc.28.1557159709220;
        Mon, 06 May 2019 09:21:49 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id d10sm3880686ios.72.2019.05.06.09.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 09:21:48 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix shadowed variable ret return code being not
 checked
To:     Colin King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190505220122.5024-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5ccacedd-41d9-f33c-25de-ae16bcdb7b08@kernel.dk>
Date:   Mon, 6 May 2019 10:21:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190505220122.5024-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/5/19 4:01 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently variable ret is declared in a while-loop code block that
> shadows another variable ret. When an error occurs in the while-loop
> the error return in ret is not being set in the outer code block and
> so the error check on ret is always going to be checking on the wrong
> ret variable resulting in check that is always going to be true and
> a premature return occurs.
> 
> Fix this by removing the declaration of the inner while-loop variable
> ret so that shadowing does not occur.

Thanks, applied.

-- 
Jens Axboe

