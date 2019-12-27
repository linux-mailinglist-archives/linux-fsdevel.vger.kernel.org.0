Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBD4B12B443
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 12:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfL0Lhg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Dec 2019 06:37:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46215 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfL0Lhg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Dec 2019 06:37:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so25791901wrl.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2019 03:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bpIiCK5WqIgrEaa234cHRdees/ayR1lDtho4HV6gLnw=;
        b=Y/fnMhtmNh8pgB10eb6arwxjSyLM5+I+paY7YL2IY/MObHLoX8vbJpouoENflytyaM
         WqU+HtXQz4r16r9lvNxZKbTRaCliJrULZE9RAjeLemCG2ImoRtxfc7X+bp7ZCtPIIzbE
         fkXql1aoW++4m07KH7nGnnx+kQqDJSCp1fHag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bpIiCK5WqIgrEaa234cHRdees/ayR1lDtho4HV6gLnw=;
        b=kZrqQ/nca6Q9vpeyOmcZLQrWDeLQg7bbxvXQHflwfdjc50sTGwFs25ogfc8ziF88El
         g4Qk2ydd/I75aBZkv/4xjRuYjXMXVpM29FMYdm8P7dYwVkeEBx1RKVXfCZ84VVzUWjku
         LjhJ5rqiSIFl9cglhUIys6yUNshfWFvZsTKD65uOwyUJCkGfHnMkFKhjhzpuR2fui+j+
         iyAVvUDac8pcS5p2tgHpjmyFJGGSDY3olW1DNmyrG+eqfr9N4izgKiOuRIjSP2i+VXjB
         pnicG/eXV/1xzsTGYIZTLy9AqlDjhOsjBAVzev7eWioyWEq4fSGTmqYnoOrrbPWCQpf3
         XjGw==
X-Gm-Message-State: APjAAAXU5RJOiCj9haqrXEsfwkCQQrEptNsDmaDn5MAnUQ+v4DaVPTgX
        9/HCQY2hC352XspoE7lOhkR3SA==
X-Google-Smtp-Source: APXvYqz7YRORD3nJ5nHFQjwcVPr4Hrl8QOet2glGy16vOAsGaad37FExuqc9Dqqfmtsyv49zuqK2bQ==
X-Received: by 2002:a05:6000:160d:: with SMTP id u13mr51720244wrb.22.1577446654952;
        Fri, 27 Dec 2019 03:37:34 -0800 (PST)
Received: from localhost (host-92-23-123-10.as13285.net. [92.23.123.10])
        by smtp.gmail.com with ESMTPSA id r15sm10972362wmh.21.2019.12.27.03.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 03:37:34 -0800 (PST)
Date:   Fri, 27 Dec 2019 11:37:32 +0000
From:   Chris Down <chris@chrisdown.name>
To:     "zhengbin (A)" <zhengbin13@huawei.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH] fs: inode: Recycle inodenum from volatile inode slabs
Message-ID: <20191227113732.GB442424@chrisdown.name>
References: <20191226154808.GA418948@chrisdown.name>
 <CAOQ4uxj8NVwrCTswut+icF2t1-7gtW_cmyuGO7WUWdNZLHOBYA@mail.gmail.com>
 <88698fed-528b-85b2-1d07-e00051d6db60@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <88698fed-528b-85b2-1d07-e00051d6db60@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

zhengbin (A) writes:
>How about tmpfs and hugetlbfs use their own get_next_ino? like
>
>static DEFINE_PER_CPU(unsigned int, tmpfs_last_ino),
>
>which can reduce the risk of 32 bit wraparound further.

This won't help by itself, because in the case presented the wraparound almost 
solely comes from shmem alone.
