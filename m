Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEF7132D51
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 18:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgAGRoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 12:44:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34388 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgAGRoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:44:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so424576wrr.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 09:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8eqMnrGTPiMzUvhdb0Z8uXo41jdrtgsf6hpzBK0nlMQ=;
        b=P/XrLA3sWbGycnyupfzOxWdJivC6ceAXPPCxrnLUPh+TduZx5ndkDZmQXFSHrof9j/
         tQD9SaAE/CdOr3P0R5dH+i1X2R95TWzLK/Jp8GKp77O7/YBGVPPkFEYnAgDIzrogEDyu
         S+xg3zJZWVZX3XvTEenCiAzsGCh+QTqRMY1+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8eqMnrGTPiMzUvhdb0Z8uXo41jdrtgsf6hpzBK0nlMQ=;
        b=bh3nLgLhCbyxkknSQ7KQnVVd6IiPn+vw0CQ+6yNKO7RxqfpLntb5O+rXBEweQcfv8F
         ryZUZxBc9Vr5TxwKCgqdX9Yx4STllzWYOYLlGJ9UND2//CTfHuIm35JJocfLiqjb0uSU
         ig8j5ZHxDqWqXeBEbzdDlxTLJXyWsNFRbYKx8ZUlis8LG/QriO4xkalLxADmmm6bOpwJ
         AHbCQVyZjSOm1dVcWr4+EAi/WLt35PZglUK9PL12wiY/XgNO21UvkbDbYzMvQN8Ta7Me
         1hxvoj95ZeeFmatWUkLJxMTVyl0fXGD3ACGu1h/tgoN8EcsyWNTPz/i5sI7qmtQ0LR8B
         e/vw==
X-Gm-Message-State: APjAAAUPp6MumSVm2rhnVrBczAimc8GH6aSVJtO7RLnGCCXCPLJHo9O3
        zBYLix+3zen1Z71Psc1RfTI3xQ==
X-Google-Smtp-Source: APXvYqynyqHQyph7mlkfkGczhahKEDtFTIiSOiCq7anm6rJZZrYX1taZ671LNRgmt2SgYo6hlDdfDg==
X-Received: by 2002:adf:82f3:: with SMTP id 106mr225820wrc.69.1578419048428;
        Tue, 07 Jan 2020 09:44:08 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:2344])
        by smtp.gmail.com with ESMTPSA id u1sm413118wmc.5.2020.01.07.09.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 09:44:08 -0800 (PST)
Date:   Tue, 7 Jan 2020 17:44:07 +0000
From:   Chris Down <chris@chrisdown.name>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] fs: inode: Reduce volatile inode wraparound risk when
 ino_t is 64 bit
Message-ID: <20200107174407.GA666424@chrisdown.name>
References: <20191220024936.GA380394@chrisdown.name>
 <20191220213052.GB7476@magnolia>
 <20191221101652.GA494948@chrisdown.name>
 <20200107173530.GC944@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200107173530.GC944@fieldses.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

J. Bruce Fields writes:
>I thought that (dev, inum) was supposed to be unique from creation to
>last unlink (and last close), and (dev, inum, generation) was supposed
>to be unique for all time.

Sure, but I mean, we don't really protect against even the first case.

>> I didn't mention generation because, even though it's set on tmpfs
>> (to prandom_u32()), it's not possible to evaluate it from userspace
>> since `ioctl` returns ENOTTY. We can't ask userspace applications to
>> introspect on an inode attribute that they can't even access :-)
>
>Is there any reason not to add IOC_GETVERSION support to tmpfs?
>
>I wonder if statx should return it too?

We can, but that seems like a tangential discussion/patch series. For the 
second case especially, that's something we should do separately from this 
patchset, since this demonstrably fixes issues encountered in production, and 
extending a user-facing APIs is likely to be a much more extensive discussion.

(Also, this one in particular has advanced quite a lot since this v1 patch :-))
