Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2EA2938D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 12:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405906AbgJTKEr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 06:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405904AbgJTKEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 06:04:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C59C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2020 03:04:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k21so831773wmi.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2020 03:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BW+3XhV0xoxr/QwYHClh7Eplz35QFW4PsEyYSDMVpv0=;
        b=hC+d/E9riZ/Ymvg1EyEzNHWki5gkAp7+0j0Pep6/wZQY37YcBzWyBxzBYXf62wFeYL
         V3zH/R6d5bCsCWx5JhVQOEKuBk9gYeC/6SZ/RNsMqMAJyUWu56rm6c95gpIbekDjUeG0
         mU3djeEM1dOk+2DDVe7WScgDzt61zdGsevMW9QsTTDi8MjHWh38zQRYjIHwpqW1hfvx3
         +/KpoDfrWJEHeKZVboZ/LTKONvkrZZj/ZcO4h060jeDismke1rOhfrWo8rcyB5n5bH0M
         3IUctIcZqtHs5NeV/QtCRToBnfd0FTJ/WAqAhbnbW9hQwxpWY7SFRO1RXn0dI2nGLMIj
         yS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BW+3XhV0xoxr/QwYHClh7Eplz35QFW4PsEyYSDMVpv0=;
        b=QEbcDyi8o3mBXwJRL9gj08L7BekOosnvexT70dgjAn2pX2sYSn1HlY/eOihTzAL7H6
         t8IwkOq9jY5Z9vTuqpEULDV6JkPCsMJ2+1I70bnIHNg9uZ9Q4i3SJe4ibl2ny4U7TkhQ
         0OjuAhUyn/N7iI+bG26bn2Pzwwde7WQ8zSircMOuI0sMaH4R/41/1WQa/JyMQfOIa8FK
         ctAu48J/6aaec1JSGcpeAeG+N6BT7GJ2iAO9rUWjBwiL+jqEl/fje13CZFN0kOR6/BZF
         4n/pksHCc7wwT0/MOfVJMjPUi7xXu2tGe1cKprppMDOZ01v8c5D8Y6XQLErxwG965vZ3
         arjg==
X-Gm-Message-State: AOAM531HjtZ5a573b1kWWkYf05oWL5W6EwdNfvIZWI77u4P2QGJTtEhR
        FDzVaTEl08hFK/N0lSkw6VddabFxLg==
X-Google-Smtp-Source: ABdhPJw4AfCd4mHbKTuHw7oiKIiQh03GPai1urP5sBFsXbz421RCPu5TeHqIoZQkY2MNORcQpGHykQ==
X-Received: by 2002:a1c:e089:: with SMTP id x131mr2182816wmg.78.1603188285667;
        Tue, 20 Oct 2020 03:04:45 -0700 (PDT)
Received: from localhost.localdomain ([46.53.250.103])
        by smtp.gmail.com with ESMTPSA id i8sm1983063wmd.14.2020.10.20.03.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 03:04:44 -0700 (PDT)
Date:   Tue, 20 Oct 2020 13:04:42 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Charles Haithcock <chaithco@redhat.com>
Cc:     trivial@kernel.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH net-next] mm, oom: keep oom_adj under or at upper limit
 when printing
Message-ID: <20201020100442.GA4797@localhost.localdomain>
References: <20201019215229.225386-1-chaithco@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019215229.225386-1-chaithco@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 19, 2020 at 03:52:29PM -0600, Charles Haithcock wrote:
> For oom_score_adj values in the range [942,999], the current
> calculations will print 16 for oom_adj. This patch simply limits the
> output so output is inline with docs.

> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1048,6 +1048,8 @@ static ssize_t oom_adj_read(struct file *file, char __user *buf, size_t count,
>  	else
>  		oom_adj = (task->signal->oom_score_adj * -OOM_DISABLE) /
>  			  OOM_SCORE_ADJ_MAX;
> +	if (oom_adj > OOM_ADJUST_MAX)
> +		oom_adj = OOM_ADJUST_MAX;
>  	put_task_struct(task);

Should be done after PUT so that task is put as early as possible.

>  	len = snprintf(buffer, sizeof(buffer), "%d\n", oom_adj);
>  	return simple_read_from_buffer(buf, count, ppos, buffer, len);
