Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E06873EBDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 22:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjFZUb5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 16:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFZUb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:31:56 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47441B0;
        Mon, 26 Jun 2023 13:31:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666ecb21f86so3703341b3a.3;
        Mon, 26 Jun 2023 13:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687811510; x=1690403510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTCUF3XNaBvj4PKCzDGtH7uEP3TDMjaq/uRkjjEZ9Kc=;
        b=cuVy06QAcKG7awJdVWfu3saYHOdNHs21sEzuNJv1hP1fJMvoZXxx44+ki4ge02Zws6
         3+H7SLURjdL0eGT0h09pJSxeORiSBwJC3GZQmDtWew8yDFbmp9pmcn7/+DMlBTpX6D15
         Vf2rCPnevhB4/EoCpVRwAh3pbOxfls3TA4wg83yboMFqod0y+weJAf4BQuTKhFeZBYIz
         yUYxqXLQ9sLYGGdYBlZXxxO+b7aRW5xiPbjVx4FOps38qMnvYtzeqF+/RB66SAD+jSsB
         mLT49KB0jhpZeghMFlfDB4kLvTlGiK9P0huREC178+E7wxC9xlR7So/FVYt7A+DNeLAA
         LdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687811510; x=1690403510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTCUF3XNaBvj4PKCzDGtH7uEP3TDMjaq/uRkjjEZ9Kc=;
        b=OgbYDvOrbUzkRWro3JjYzhS5rOKY1cFGMGfNpfhQ8MMl5hJl1QQYrx+yUScF7bNrhh
         plEqdV3IyQBLQROoK/6i42nNV7KSeVGS0FFX6sYzY+tV8kts2YgmOT0ZjyF3zYWscFOJ
         sObXcQkSa8dSH7EgopFS3WIKCiSr1acX6ZCWk3dj6Z1533UBjmO9T0HlnJ3prdxBJNKb
         9v5x1ud/D25ELqIa7AU8rJ2BhzPNbH0kw8QeJb5UsCKdhjLfK+d3eRuJMdHFzNzOGCNj
         rlAVsQzyCWMb+NQ/q5hlig2MoQUZD+zJhD0gwEf1XW6grV6QhRW3HAVhsw63LcixsSy2
         GDDA==
X-Gm-Message-State: AC+VfDzZv1zl3FJxrKDgsGeNapEmNchAmAzonu6ahOhesCeBNhlrhizA
        u4GM1dAZku7Zo9Ghr0KrzgI=
X-Google-Smtp-Source: ACHHUZ5kXAsJ08lvWJYI8HhejgiMKaZvIGp1FaOz0mDDM3eZT72Z6nPi0VuQRvPaNY++QvdLZ9svkA==
X-Received: by 2002:a05:6a21:9016:b0:11d:4c79:90ee with SMTP id tq22-20020a056a21901600b0011d4c7990eemr31210442pzb.25.1687811510038;
        Mon, 26 Jun 2023 13:31:50 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id j17-20020aa79291000000b00640f588b36dsm4185288pfa.8.2023.06.26.13.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 13:31:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Jun 2023 10:31:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, peterz@infradead.org,
        lujialin4@huawei.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mingo@redhat.com, ebiggers@kernel.org, oleg@redhat.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
Message-ID: <ZJn1tQDgfmcE7mNG@slm.duckdns.org>
References: <20230626201713.1204982-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626201713.1204982-1-surenb@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 01:17:12PM -0700, Suren Baghdasaryan wrote:
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index 73f5c120def8..a7e404ff31bb 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -273,6 +273,11 @@ struct kernfs_ops {
>  	 */
>  	int (*open)(struct kernfs_open_file *of);
>  	void (*release)(struct kernfs_open_file *of);
> +	/*
> +	 * Free resources tied to the lifecycle of the file, like a
> +	 * waitqueue used for polling.
> +	 */
> +	void (*free)(struct kernfs_open_file *of);

I think this can use a bit more commenting - ie. explain that release may be
called earlier than the actual freeing of the file and how that can lead to
problems. Othre than that, looks fine to me.

Greg, as Suren suggested, I can route both patches through the cgroup tree
if you're okay with it.

Thanks.

-- 
tejun
