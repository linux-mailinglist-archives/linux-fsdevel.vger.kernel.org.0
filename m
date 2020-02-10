Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF21B158419
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 21:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgBJUIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 15:08:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43803 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBJUIL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 15:08:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id p11so3247234plq.10;
        Mon, 10 Feb 2020 12:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vzD8T2ieMGuxRVquXoaKhsc9qQG8vkAzhKmtkEYAgME=;
        b=Qzw0w0uhDFc0lVDg3qQ7EudAV9KgDGnchjtYiNT6GXRnig/zDmWcoUongraFxg5uzC
         3MZ47fyJhnZiYxMMn40RSdGWwseMyCvdNDVMKYeHQBJF2w+hPKyvyx8MDeTOubDFCras
         ZNiVEK86jyaVRQQcLanP7q4pTsFTffS5/GVQF2gN/85kvfcGDtwlE3de/cJM2qHX/QQd
         D2U8AZa/GZeSV4qoK4GHgt2e/GLeG8g8oHDanmqtxy98RvwBXAd72E1GK3qmLHj9i63H
         /YoRCR5a+jGqrWKAhtI9ZzQgkVoSI48aT1bPSnho1rpVkMsiszbY+gvBwbIj0FUKWLuR
         cCKA==
X-Gm-Message-State: APjAAAXeWEI6ZiHEik6Ej6NiDl+cr1MMaWmXZLBrFdxC3dUzG6E75+0F
        glDll7RdFEZRcz4t9z2G08s=
X-Google-Smtp-Source: APXvYqwpRZDVHmwnxkppDE4vflEV7ygmMhLnExpIK0qJ7hBOpSQizNe1MUmbUYX6OUu1qR7MPVYgkg==
X-Received: by 2002:a17:90a:d78f:: with SMTP id z15mr911773pju.36.1581365290349;
        Mon, 10 Feb 2020 12:08:10 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id az9sm265420pjb.3.2020.02.10.12.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 12:08:09 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9B1B84060F; Mon, 10 Feb 2020 20:08:08 +0000 (UTC)
Date:   Mon, 10 Feb 2020 20:08:08 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, alex.williamson@redhat.com,
        keescook@chromium.org, yzaikin@google.com,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/5] proc/sysctl: optimize proc_sys_readdir
Message-ID: <20200210200808.GN11244@42.do-not-panic.com>
References: <20200207180305.11092-1-dave@stgolabs.net>
 <20200207180305.11092-3-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207180305.11092-3-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 10:03:02AM -0800, Davidlohr Bueso wrote:
> This patch coverts struct ctl_dir to use an llrbtree
> instead of a regular rbtree such that computing nodes for
> potential usable entries becomes a branchless O(1) operation,
> therefore optimizing first_usable_entry(). The cost are
> mainly three additional pointers: one for the root and two
> for each struct ctl_node next/prev nodes, enlarging it from
> 32 to 48 bytes on x86-64.

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
