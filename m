Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E00A4D5099
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 18:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244031AbiCJRcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 12:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiCJRca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:32:30 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C74F5436
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 09:31:29 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id bt3so5265602qtb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 09:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i7J8e206Bwozad+xJPF02nCEZhsFp5sZ0xZvk63VV68=;
        b=UkGo0vpr4SaQ7VeIYfKdoCqVYOfqyZ3ua0gxQaiJfTvuIAdcEhC7UzaOYUa+8sTpBI
         wYGfW0Oyu3FfBBXPWw6SmL7k9/Ix6fjwuGHvkSm5lrOgl0ENo1rP0RrjvEBxzxAp03Gh
         zQ/3YctkGkQXC22sPfWYmqkvHsQeraa8bVSTnn2NJXnxYA2o5wMomQMsd54TRQk6BinA
         66SHzCNzlLrkOoGYPJbmY/C9U3RloqxiyhcEza5IJT17waUWq6Pr7CkjrynsZ5QIxT6A
         Ty6Wst/a7i05d2X56zLTgO7XY9bwMpKsT3BIpaI3jYkRcGuzXkvWvLMzj9Mop7ypQ0PI
         yD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i7J8e206Bwozad+xJPF02nCEZhsFp5sZ0xZvk63VV68=;
        b=zteNIaw3atI2fztfQBkRaA4KveqwGNNyoRYYM75PLz+NxplKPllqaIWqtD9/XvCc3s
         OhZie6KXUgl1G3OWZKyE1j2AV3+gbWUDbbxyG9oGzedsBf6Sx9QZkTcqC91F5vZD4s0R
         1oLwgfBVYF2UuEN6ynsrHhKrkMeKM5+xas5kfRLMNcnGupeBbZNZ+LO+gAZV8YPDDGK5
         twAaaLziVZlLGNZy1NsQseUeqBjb4YYCIcAV1zoWiHZa3t0RQnpQdOria+KmoYsYnQCV
         qjeBBq884mtdNGwcZWGEuWIb8Ago68saYaRKwzQZL4OYQo/x/NXA/+ZECThWW0IUYg7W
         4fcA==
X-Gm-Message-State: AOAM533hIYbliHj3X5FEQsLexHKgqUAquPZ2BSUy91uCWebac3jnrbif
        Y9rckDMD1fKqStbl0I/k1kuL1Q==
X-Google-Smtp-Source: ABdhPJwXrthz2QtCLsnFtqyDL0e1w0h1YTxxQQFSEJP3ZvHCIAN7kMeF7r6fRWtGJMhwK1gVmjpSbw==
X-Received: by 2002:a05:622a:550:b0:2e0:7422:a1d5 with SMTP id m16-20020a05622a055000b002e07422a1d5mr5001583qtx.444.1646933488129;
        Thu, 10 Mar 2022 09:31:28 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id bs11-20020a05620a470b00b004b2d02f8a92sm2579261qkb.126.2022.03.10.09.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 09:31:27 -0800 (PST)
Date:   Thu, 10 Mar 2022 12:31:26 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     cgel.zte@gmail.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] block/psi: remove PSI annotations from submit_bio
Message-ID: <Yio17pXawRuuVJFO@cmpxchg.org>
References: <20220309094323.2082884-1-yang.yang29@zte.com.cn>
 <Yij9eygSYy5MSIA0@cmpxchg.org>
 <Yime3HdbEqFgRVtO@infradead.org>
 <YiokaQLWeulWpiCx@cmpxchg.org>
 <Yiok1xi0Hqmh1fbi@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yiok1xi0Hqmh1fbi@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022 at 08:18:31AM -0800, Christoph Hellwig wrote:
> On Thu, Mar 10, 2022 at 11:16:41AM -0500, Johannes Weiner wrote:
> > The first version did that, but it was sprawling and not well-received:
> > 
> > https://lkml.org/lkml/2019/7/22/1261
> 
> Well, Dave's comments are spot on.  Except that we replaced it with
> something even more horrible and not something sensible as he suggested.

Confused. I changed it the way Dave suggested, to which he replied
"this is much cleaner and easier to maintain". Are we reading
different threads? Care to elaborate?
