Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A69F116FB4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 15:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfLIOyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 09:54:08 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39391 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLIOyI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:54:08 -0500
Received: by mail-lf1-f67.google.com with SMTP id c9so10431082lfi.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 06:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zXCvNPBFfW6TtfKXO5Yk7VgQZcEUj3Or8FZH8YnZ5iY=;
        b=B4Jzw/Aiu3fSn3JF/ZLYnhir6fFzn6dD+MZZbz9Pe3E6F+8fFxwMniLnAcpy4ujmNe
         ePgzHV0FFAKuT8AKRgx4vVXFtvLNOx0HkZmnG3GYtiW6EwfAcOoL6MaaNbAr4RtP6Z62
         +xJBFUSCmYf6Ib5ZTNn6KkIdK5xtigBddx58s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zXCvNPBFfW6TtfKXO5Yk7VgQZcEUj3Or8FZH8YnZ5iY=;
        b=jowCQbTzzKU4E9kAICN/gjSszUp4lb4h9OO44Db2PEY73MRNOdq4ymdO4mGIduzic2
         0n82n9sHezE65sW/Bc5YuKX4rFA8j41s8HgJ8w4XTnF/bTVko5Lv8Mwd8aN5wzO4aMz2
         5911Z/pQ1eVfbMVUrPerrs4Id6wLnWGH2xRHmhlK+tPK8ShAcjfHuGzOphctq66lgUSA
         jjNlC3Jc/vQkXrZ6rtuH8L3wCxZTPO+CqzibKl6LeWgY2ScJnVH/+gGFXFCwWtw134yN
         SMlHPGpmJk/5mtE7Ujoe7XKtgGloGJJ2uFnJjnfCv402RIs62zGFU+VQUE3ZyMng7xpo
         MwOw==
X-Gm-Message-State: APjAAAVL3l4Kzq0PXVPUceouJ8vJfvPem7PpEGx4iaNx+KWLH/4R1dsC
        1jS8uViDX8m6T5Cj1IT2X+l7lQ==
X-Google-Smtp-Source: APXvYqySt6anXUyT6kvrIZam/0bhlCpHB2LLS+I8Pe3IeqDuhU00X2/Hkn5xzYQqfHogs7Pf2XjfgA==
X-Received: by 2002:a19:f00d:: with SMTP id p13mr16200102lfc.37.1575903246184;
        Mon, 09 Dec 2019 06:54:06 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w16sm11170372lfc.1.2019.12.09.06.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 06:54:05 -0800 (PST)
Subject: Re: [PATCH] fs/namei.c: micro-optimize acl_permission_check
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191113214521.20931-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8385b895-0269-236a-665b-244a386167ac@rasmusvillemoes.dk>
Date:   Mon, 9 Dec 2019 15:54:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113214521.20931-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping

On 13/11/2019 22.45, Rasmus Villemoes wrote:
> System-installed files are usually 0755 or 0644, so in most cases, we
> can avoid the binary search and the cost of pulling the cred->groups
> array and in_group_p() .text into the cpu cache.
