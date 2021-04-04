Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D9835394D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Apr 2021 20:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhDDSBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Apr 2021 14:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhDDSBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Apr 2021 14:01:33 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5885BC0617A7;
        Sun,  4 Apr 2021 11:01:28 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id v70so9693778qkb.8;
        Sun, 04 Apr 2021 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vqjTFrhw8is34xFbRLeJBk6zObb/0KU6NDcwEfDwcS0=;
        b=l2AjGlLTHKa6vPsOcVT9lSv7QAhpNb1GX7xYJ2agOybHNczEtfkCFH8OmOx33qjzej
         L6xkIjeDjGig1AIJjUxg7Zv9XNbsXefdFb/GnHKcBFfR3lkSLUneOAcvXaHhrYkavZDR
         l/1VzqmAJTa1mBLECjiapkDCpOVKextkWwD/NeNFYta2KRsWyFlWCydm6JrL9XIX7l/t
         tEZ3s5KlbhZUintD0sutFq6ELuQLeRTKm3hDFLgIXbbed6LmFHu2E34lM9aqBH+O9c/c
         oxBGdJ2W2vmqB3jtvaYAUpZ6aOnrYV0B0m1Hlo9F14NlA5Avj4YQEzZTSp16hWhl0z4e
         QI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vqjTFrhw8is34xFbRLeJBk6zObb/0KU6NDcwEfDwcS0=;
        b=V7VCtEQ9xjw5WfKl9e+nj50qbwLAGyifXZcqWWj8URFCgbBtpHlsdsqQ3zTQ5J9Skb
         lQgiB3cIWGNoRT9tMujwH2H4uvfh+ArBq43It87SYWc5+EfBeARgG7OhrLbgRrZzGF2f
         BUpW064n/IYqEtNsAY1sb44YOp5kjakkqQ4kkPqEnh57QEhLjy0QUU9HMNIjRWgM72jz
         qpfAfUL24xT4Vsqq4spcv2Z5AH5Tis3DMnz44BgsUweAdgPxd2opjqTgzvIp/kg4gxlR
         b+BLqkCDYoNvDSjeCza+tl1WPuSSI295V6bNMoK9DOVjq4wng4TRiDFwxL2jPK4ItRYq
         XFVg==
X-Gm-Message-State: AOAM5335gWjoXoo/8VRFuWL4oXmWTC/lfPJNGnNcbXOLwyHUWtXCXoMp
        zpXVAPLYS1WF6jLmpOnfMUqmTdjBrG5E3w==
X-Google-Smtp-Source: ABdhPJzLNUaqWgD1Wf964A7EQG9L1i3NH/sayvR0/nfYb5WNXuZR+X12deaHWKWkor/+gKkJqRNq2g==
X-Received: by 2002:a05:620a:527:: with SMTP id h7mr21428959qkh.108.1617559287424;
        Sun, 04 Apr 2021 11:01:27 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id 79sm12220473qki.37.2021.04.04.11.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 11:01:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 4 Apr 2021 14:01:26 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     viro@zeniv.linux.org.uk, axboe@fb.com, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3] writeback: fix obtain a reference to a freeing memcg
 css
Message-ID: <YGn+9gY/VAc6YI/q@mtj.duckdns.org>
References: <20210402091145.80635-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402091145.80635-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 02, 2021 at 05:11:45PM +0800, Muchun Song wrote:
> The caller of wb_get_create() should pin the memcg, because
> wb_get_create() relies on this guarantee. The rcu read lock
> only can guarantee that the memcg css returned by css_from_id()
> cannot be released, but the reference of the memcg can be zero.
> 
>   rcu_read_lock()
>   memcg_css = css_from_id()
>   wb_get_create(memcg_css)
>       cgwb_create(memcg_css)
>           // css_get can change the ref counter from 0 back to 1
>           css_get(memcg_css)
>   rcu_read_unlock()
> 
> Fix it by holding a reference to the css before calling
> wb_get_create(). This is not a problem I encountered in the
> real world. Just the result of a code review.
> 
> Fixes: 682aa8e1a6a1 ("writeback: implement unlocked_inode_to_wb transaction and use it for stat updates")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
