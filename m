Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEAAC0154
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2019 10:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfI0Ii3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Sep 2019 04:38:29 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33277 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfI0Ii3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:38:29 -0400
Received: by mail-lf1-f67.google.com with SMTP id y127so1311968lfc.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2019 01:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZQ7PgEigiWP+iFi5g31iLI6DCZWNjaRYQUZv3+A6Guc=;
        b=OmyzyLGm6jVWYGe/Qf6g9c4ayvHcL/EXwYFQnPiIgUYPxw1p6ORPH2dVrloLdEbaWt
         DY8IMy+9/XVnFyFJkbDRBf3YgALGQMjpYCJlZMFQlZjkDdGsZdrZVDqkc1gcEDHSzmRl
         ubjOf7Ca3IRE1p7gdQSW+qIXrPY7rVqR4jP1JdWQcUusVmboN5JuAb4C7d2Gce9STMAF
         MYk01I9ombw2tK+/WdzCkQ7yMx8PB/wt462+mj8Vc6fckuOG4/VN1uUPuDCJCfNtrqcF
         zSMa0nLjCugw+tvqYupigEAXkPl+YCu2P9Z1EqFviZc2TlcBZOmep/wtlkSAnrgdql5i
         mz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZQ7PgEigiWP+iFi5g31iLI6DCZWNjaRYQUZv3+A6Guc=;
        b=GeKx1AnNjRxde1ALgzEo0/saieBzc8qLVAPCZX2Ynt02j9S/wsqSMsH9t81F3jLz8N
         DiHavNQhx63SEoEy7/GV2CrKu0R6RHuv6iHMyLsfbZpYA3Qd65etTE/EwBybSFNoHtAU
         VD/tpTzduBPMuWDoKj+CfYUPtEBaCGCoywo7+KM9XmIYEKwbryf2z1eYFahagpu8ve/O
         AbIBsrudtuxYW5z/IgrCgKKeWcDOD0tH5M1hcYH+p6CoommJGCGrn7VCrfMGQmvVt6YO
         iJdVrL3M6K7qKd3UK7xdZaRJtX6uIOz5NlTqDj77naFjBhY55t9YUmF3TYq2MKmVZoZv
         723g==
X-Gm-Message-State: APjAAAUVIdmQWBMX0OQID9qhAJjgwsPN2Jl2c62iEdF6SfWpYmVJC0fS
        o0pGUPhNnJiG5X/nnqyrMV0CDmBcilxWjQ==
X-Google-Smtp-Source: APXvYqzX+M6AZLBfanv8/BbFtBIKYq/m6FvDp7LWSo1Mcnqu6rZMr8QR+qBICHyIGw5XzQkaEpjGdQ==
X-Received: by 2002:a19:98e:: with SMTP id 136mr1933572lfj.156.1569573505672;
        Fri, 27 Sep 2019 01:38:25 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:8df:57d9:c46b:3c97:5028:3a4f? ([2a00:1fa0:8df:57d9:c46b:3c97:5028:3a4f])
        by smtp.gmail.com with ESMTPSA id t27sm345992lfl.48.2019.09.27.01.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 01:38:24 -0700 (PDT)
Subject: Re: [PATCH] jffs2: Fix mounting under new mount API
To:     David Howells <dhowells@redhat.com>, dwmw2@infradead.org,
        richard@nod.at
Cc:     linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
References: <156950767876.30879.17024491763471689960.stgit@warthog.procyon.org.uk>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <f34aaf61-955a-7867-ef93-f22d3d8732c3@cogentembedded.com>
Date:   Fri, 27 Sep 2019 11:38:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <156950767876.30879.17024491763471689960.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On 26.09.2019 17:21, David Howells wrote:

> The mounting of jffs2 is broken due to the changes from the new mount API
> because it specifies a "source" operation, but then doesn't actually
> process it.  But because it specified it, it doesn't return -ENOPARAM and

    What specified what? Too many "it"'s to figure that out. :-)

> the caller doesn't process it either and the source gets lost.
> 
> Fix this by simply removing the source parameter from jffs2 and letting the
> VFS deal with it in the default manner.
> 
> To test it, enable CONFIG_MTD_MTDRAM and allow the default size and erase
> block size parameters, then try and mount the /dev/mtdblock<N> file that
> that creates as jffs2.  No need to initialise it.

    One "that" should be enough. :-)

> Fixes: ec10a24f10c8 ("vfs: Convert jffs2 to use the new mount API")
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: David Woodhouse <dwmw2@infradead.org>
> cc: Richard Weinberger <richard@nod.at>
> cc: linux-mtd@lists.infradead.org
[...]

MBR, Sergei
