Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9A0179866
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 19:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgCDSvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 13:51:00 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43605 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbgCDSvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:51:00 -0500
Received: by mail-qk1-f193.google.com with SMTP id q18so2685159qki.10;
        Wed, 04 Mar 2020 10:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q1T5PHad2epTA8xiUq+4hYF2Qw1Uf8Wjwqi3EBBUBEk=;
        b=RBguA0BTOxPlY/3xFS8jgq8lLYAaYFW1tYVo2Yl4z3XVQu1oFHxbAtxE8Lq4xTi9Sd
         jEBkD6irYXp6Ssfi7KOQufVx0sTiikg4Meme0TWDl6yDSNZMxP8RW1eJ/WgC82fG2ZgF
         wspgQUoBXecu2wnaSftOP0LaNF0XaQWSa1pZ3pc+od+94YpGfjudK4JvkR7lVt0X/xNo
         33Wq6CHNkq+ZsrPMsTx3vesaRCJvYcaI2kVvCAtfgel4wRmtpGz27gYX4Qk/RTa33WyY
         zrtquDs0soEabloqP17v8ZnYVAZ2r7e3LJH6KaJJGA2/8ev4r/nLFlWm0FNvO84LH8mk
         KI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Q1T5PHad2epTA8xiUq+4hYF2Qw1Uf8Wjwqi3EBBUBEk=;
        b=CT//u3RtZ1kzKyvn9oO3q1d83e76LnSfOB8BzjjX5Lwcjx+mHqDGUxBIO1g8kG5A3J
         61Z5l3UcfdPy0E/sxCq3XZTyMyPZ/vBjOtXhobBw+6IexVNgJAqQ7PFtHDY9lPQil2bS
         d9fKCJMlimM9li5V6/y93mRV+CjCBRuOaLpPAIVBJILaA46DHpic/6vHtnWHIEAWylQw
         QnVVoKQ+6RKuybyCS9e3utuYaLAqFuV0kL1N+6Ju4a0HerzhcG1R5CXguqOzOqcR8USk
         24X0GadP3lONyOj0Xc3t8T0pfluloWGeKUMFJDwkR3I8pfhiWbxPKMJkiWK2udr8Onzl
         RrBg==
X-Gm-Message-State: ANhLgQ02mnH0ogSrC5f7fvt5m6wIX1GHTutyty5eZUwsjirS7mDv7/65
        QGAXXlJmIRKN4FNS/IaWsN4=
X-Google-Smtp-Source: ADFU+vsP4/0sQxSB9P0odtDe+a4aeQU9RzF93YAW+6H0bktKrZdEbrZ1NFNHoTc1h3znltvqIjS0GA==
X-Received: by 2002:a05:620a:90e:: with SMTP id v14mr4194782qkv.128.1583347857645;
        Wed, 04 Mar 2020 10:50:57 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:16fa])
        by smtp.gmail.com with ESMTPSA id v80sm14241477qka.15.2020.03.04.10.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 10:50:56 -0800 (PST)
Date:   Wed, 4 Mar 2020 13:50:56 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, bvanassche@acm.org, tytso@mit.edu
Subject: Re: [PATCH v2 3/7] bdi: protect device lifetime with RCU
Message-ID: <20200304185056.GM189690@mtj.thefacebook.com>
References: <20200226111851.55348-1-yuyufen@huawei.com>
 <20200226111851.55348-4-yuyufen@huawei.com>
 <20200304170543.GJ189690@mtj.thefacebook.com>
 <20200304172221.GA1864270@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304172221.GA1864270@kroah.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Wed, Mar 04, 2020 at 06:22:21PM +0100, Greg Kroah-Hartman wrote:
> Ugh, I was dreading the fact that this day might sometime come...
> 
> In theory, the reference counting for struct device shouldn't need to
> use rcu at all, right?  what is driving the need to use rcu for

Lifetime rules in block layer are kinda nebulous. Some of it comes
from the fact that some objects are reused. Instead of the usual,
create-use-release, they get repurposed to be associated with
something else. When looking at such an object from some paths, we
don't necessarily have ownership of all of the members.

> backing_device_info?  Are these being destroyed/used so often that rcu
> really is the best solution and the existing reference counting doesn't
> work properly?

It's more that there are entry points which can only ensure that just
the top level object is valid and the member objects might be going or
coming as we're looking at it.

Thanks.

-- 
tejun
