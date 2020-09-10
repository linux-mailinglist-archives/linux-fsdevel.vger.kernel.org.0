Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70942645D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 14:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgIJMQX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 08:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgIJMOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:14:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34936C061573;
        Thu, 10 Sep 2020 05:14:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g4so6454825wrs.5;
        Thu, 10 Sep 2020 05:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jyI3JGvS09pRlrarbYuzfD+zuLzW1NzCe2jGGYIBcDE=;
        b=mCN4TzrIUYpBOLakJPG6xEQSIk24b2s2JhsfEOEXfv8izTbw5LDD7HpLEQQFB1B/4o
         7poO/MckeBmzEyoRZeLqUmtBJT/BgRpxXan6y3yAo0Cq3p4BGymtAWta1iXvGQgFa/xf
         9QrEKLfTpszTgWAsI1Lo+2KuYgEM1QyW9NmShGNEhUZw+LHAYWYPIJo6BHLtcLhEmzBR
         nbHJWz1zwCfb6pqHoz7zssivnvdugnRGsPkPL8kCZb9ASRvEH6uN+2TyAA/kAU1rR2kf
         4WWQKJW6KDfzTftL6qgyUdgLEPA8YW2CnOyQqJDbFJOF31kwHxUvVNYETfbiCJxYt0Vt
         YFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jyI3JGvS09pRlrarbYuzfD+zuLzW1NzCe2jGGYIBcDE=;
        b=MM0eB/azjqKmS1TjtUVLbkUEnNnfNqvjXnbw4xOTXI1mdm1Sq5UMj9jVFq+j3eYOEs
         elryHkc5t095Ijp5jcZE878NpYegkWoWBFSTXsMVC7MNJcZZ5Gg7+xZwpJwrIZ+mVauJ
         xZsWD6f/iFNMieccFjcnP9aUDAAmNfBcNjunfZeg0fNF07J+zDymqcuADMJx1fVZVU6L
         Wt8jDZuyixnP39n+GKq7qoKmouQmx5hWmm0PeBiYrtSpR5FRik/fjRgexgRdLn4kzMsI
         wUIRPlsPdavD+4o7TQ0BhcODmx53jOnrQeqKzo5BFnjA5nBvCtBlu1a5LM5H3dXFJg+N
         9KIA==
X-Gm-Message-State: AOAM531oYwJnn+35cNmJaSJoqvnYbYOO24m7YsldZehCS4rPUATQxae+
        3ERi03vjMyF/hzXFjD0xHg==
X-Google-Smtp-Source: ABdhPJzVfN023eROnRibeOiKUBH6YA47852elVbFAQPB+EmQUFMR4DFZREXxGNzrGwvFm2Rl/vKjpg==
X-Received: by 2002:adf:e852:: with SMTP id d18mr9414224wrn.40.1599740090780;
        Thu, 10 Sep 2020 05:14:50 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.229])
        by smtp.gmail.com with ESMTPSA id k8sm3510926wma.16.2020.09.10.05.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:14:50 -0700 (PDT)
Date:   Thu, 10 Sep 2020 15:14:48 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Tom Hromatka <tom.hromatka@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org
Subject: Re: [RESEND PATCH 2/2] /proc/stat: Simplify iowait and idle
 calculations when cpu is offline
Message-ID: <20200910121448.GA59606@localhost.localdomain>
References: <20200909144122.77210-1-tom.hromatka@oracle.com>
 <20200909144122.77210-3-tom.hromatka@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200909144122.77210-3-tom.hromatka@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 09, 2020 at 08:41:22AM -0600, Tom Hromatka wrote:
>  static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
>  {
> -	u64 idle, idle_usecs = -1ULL;
> +	u64 idle, idle_usecs;
>  
> -	if (cpu_online(cpu))
> -		idle_usecs = get_cpu_idle_time_us(cpu, NULL);
> -
> -	if (idle_usecs == -1ULL)
> -		/* !NO_HZ or cpu offline so we can rely on cpustat.idle */
> -		idle = kcs->cpustat[CPUTIME_IDLE];
> -	else
> -		idle = idle_usecs * NSEC_PER_USEC;
> +	idle_usecs = get_cpu_idle_time_us(cpu, NULL);
> +	idle = idle_usecs * NSEC_PER_USEC;
>  
>  	return idle;
>  }
>  
>  static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
>  {
> -	u64 iowait, iowait_usecs = -1ULL;
> -
> -	if (cpu_online(cpu))
> -		iowait_usecs = get_cpu_iowait_time_us(cpu, NULL);
> +	u64 iowait, iowait_usecs;
>  
> -	if (iowait_usecs == -1ULL)
> -		/* !NO_HZ or cpu offline so we can rely on cpustat.iowait */
> -		iowait = kcs->cpustat[CPUTIME_IOWAIT];
> -	else
> -		iowait = iowait_usecs * NSEC_PER_USEC;
> +	iowait_usecs = get_cpu_iowait_time_us(cpu, NULL);
> +	iowait = iowait_usecs * NSEC_PER_USEC;

You can gc variables in both cases:

	return get_cpu_iowait_time_us() * NSEC_PER_USEC;
