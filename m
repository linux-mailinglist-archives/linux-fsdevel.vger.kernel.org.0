Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C953317987B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 19:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbgCDS5n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 13:57:43 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38947 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387969AbgCDS5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:57:43 -0500
Received: by mail-qk1-f195.google.com with SMTP id e16so2725224qkl.6;
        Wed, 04 Mar 2020 10:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=reMaZcTV9vHROvCZWfAYJ8p3cCaUx6ThSkKMcFQB/c8=;
        b=qx2HqI821+9Gtr96NWBoszbc5XTvqjtZIJtw4kwW89ww/ZviwqW4Tyt5Zh3ZPBcmOD
         NuRCDtSmraL2ctnO1+VYZEwYlRGH6+LgJTm0EaS6r8xVN3Zre7A2XdM0CL8czZFqCIG1
         JZQtEOeaocbeqO2oUojGYhlzMMmW1znZkRGLJHSx+RVXDHBOKzDZAo/F9QgrWZrU4lLQ
         Ll1CMmieWJ4aiXkt+tg6/a0Q/b9ME5xVYpSojyBfS6pjCJ5SoY+PDCfBHlxhfg5h9sav
         sm8XVcAYR0sicBN39fBNCcSxUI6xSZkWHACrjVWZp45KMDsZOGxdBzdW5/9MQvzTeP8n
         s/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=reMaZcTV9vHROvCZWfAYJ8p3cCaUx6ThSkKMcFQB/c8=;
        b=Nyk0J51nI46Z2pTmX6EhxCC4ojnoIOuIjoaiU/f3IrrHoNGb9j5DPh6wJeUZ3M6KmC
         xg1ToG2govdTAIq4XHooHQUm1tO5fR1lLaip08uDsnt/YjljDXZi/vKG0lnH9K7retno
         SFUaSLij/EPSpGpazcZLb33PC6A3Tc9matsuX81TAntFSzWH58QCjl8PMlwjQewmJzwv
         bsXXwSV5wahHCLkJnB2yPlDiqJ35YeXZmvsybAMtE5YnzUb0qbQyfjx1hUqpJwNj16Nb
         3iCx4WygmgK0dDyJm7aZQhDHcW1+N+H8fXLu3hHPzDZJiRT/XWDbAeBi9OskwI0vlsZn
         XRiw==
X-Gm-Message-State: ANhLgQ1wlLm+wOvTlqlIFwWSh0ANHkNPSUCWq7czsZR0Bs/5mvUFZvFK
        O8ip/jHfQb0inuK2OQmvYiI=
X-Google-Smtp-Source: ADFU+vtI9t9NNfGvMmNY4UsS/F25o8Zlmwddhqfc4LeohBIql01WFcLEax2Xd8xA3NkSilAF8/S7Hw==
X-Received: by 2002:a05:620a:13b4:: with SMTP id m20mr4235927qki.289.1583348261024;
        Wed, 04 Mar 2020 10:57:41 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:16fa])
        by smtp.gmail.com with ESMTPSA id d185sm14854116qkf.46.2020.03.04.10.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 10:57:40 -0800 (PST)
Date:   Wed, 4 Mar 2020 13:57:39 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, bvanassche@acm.org, tytso@mit.edu
Subject: Re: [PATCH v2 0/7] bdi: fix use-after-free for bdi device
Message-ID: <20200304185739.GN189690@mtj.thefacebook.com>
References: <20200226111851.55348-1-yuyufen@huawei.com>
 <20200304172907.GA1864710@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304172907.GA1864710@kroah.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey, Greg.

On Wed, Mar 04, 2020 at 06:29:07PM +0100, Greg KH wrote:
> How does that happen?  Who has access to a kobject without also having
> the reference count incremented at the same time?  Is this through sysfs
> or somewhere within the kernel itself?

Hopefully, this part was addressed in the other reply.

> The struct device refcount should be all that is needed, don't use RCU
> just to "delay freeing this object until some later time because someone
> else might have a pointer to id".  That's ripe for disaster.

I think it's an idiomatic use of rcu given the circumstances. Whether
the circumstances are reasonable is totally debatable.

Thanks.

-- 
tejun
