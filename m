Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ADC75A0B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 23:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjGSVnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 17:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGSVnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:43:00 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18E91FD5
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 14:42:59 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76714d3c3a7so14370785a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 14:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689802979; x=1690407779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nausvIZDHK4oozhS52dCyFawAD8n7USKE17IR8OPC/A=;
        b=BDIdmYby8sli1rRWuvw8HyYwZKIHJJW1czNbsXvoK73/8w+/4bOMx35HAZ4tV6msGe
         CzDqKCRrqcQbVJpf5zjahbuGCUrEztxQdCiNqlWkNSu/IUF/F1BDzFEwOCOkR2KRB+sv
         YpPi8q5+yXH7z84GMqKlRKTRnuad3B5I7yRKhKZQZrQwe4bxC/UgaodN5w3EuFuwKmvO
         C+cY1S5NHa6p1X7FlKjRu/fAAtYn2YZuagCf4eSX1hj4/wY41RImjrlGc59N1vAQVTEj
         zaqAbsUUoY0URUHCF67oWWQyaexiWw5iS3LaaeI0y9sACTa5Grgot74gPazE7muQT/x0
         1CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689802979; x=1690407779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nausvIZDHK4oozhS52dCyFawAD8n7USKE17IR8OPC/A=;
        b=Ku4iCOlLSwOzwCmZMgQnla5tR4rCdwmFBgu+m5xYxOncEKX2jh+jURuORYeBciosNN
         oERlPfHfWm/Ps+fLQd/+0++URCGXmZtpV5JEdjcQ49/ImzMfDV8btWZAbFIaeHddtuzW
         3KXfmxYi1saGfW//QCh9T3V6N2JIEup2OJjGC07CMuNKkNOZ93X322hB3L3GUiuzLXeM
         QTyjsnkTMiwbzdkuvc9vYltmKicPAJx/kmACnrF3kD2OZl3HmiyPW+eOsnJBCr3FDuvn
         q+JZIfU509rRYBnQa1Km9uRl+YxfNU29cAn1Bm54jS3IHqdyrQ2x/585oqwwVtkoJYVk
         Rthw==
X-Gm-Message-State: ABy/qLZ0kLVrjqpx3mQ3pYGA9gyg4rK/LaQXRauQqkVAd9CHPkeg87q5
        Jf1d+XiR6RyZIoaaN3lzf1sa3GpygKJkj83zlLvSiQ==
X-Google-Smtp-Source: APBJJlF8ROynr9mMkIZkxoaUC/zOmmkpLaaYZGmIoh//HoYIh0JoxFiy7W5K90FVwCCRJzqjMQNhLw==
X-Received: by 2002:a05:620a:4487:b0:765:a6a5:e9fe with SMTP id x7-20020a05620a448700b00765a6a5e9femr5805333qkp.44.1689802978872;
        Wed, 19 Jul 2023 14:42:58 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x12-20020ae9e90c000000b00767d8e12ce3sm1539819qkf.49.2023.07.19.14.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 14:42:57 -0700 (PDT)
Date:   Wed, 19 Jul 2023 17:42:55 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: small writeback fixes
Message-ID: <20230719214255.GA994357@perftesting>
References: <20230713130431.4798-1-hch@lst.de>
 <20230718171744.GA843162@perftesting>
 <20230719053901.GA3241@lst.de>
 <20230719115010.GA15617@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719115010.GA15617@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023 at 01:50:10PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 19, 2023 at 07:39:01AM +0200, Christoph Hellwig wrote:
> > My day was already over by the time you sent this, but I looked into
> > it the first thing this morning.
> > 
> > I can't reproduce the hang, but my first thought was "why the heck do
> > even end up in the fixup worker" given that there is no GUP-based
> > dirtying in the thread.
> > 
> > I can reproduce the test case hitting the fixup worker now, while
> > I can't on misc-next.  Looking into it now, but the rework of the
> > fixup logic is a hot candidate.
> 
> So unfortunately even the BUG seems to trigger in a very sporadic
> manner, making a bisect impossible.  This is made worse by me actually
> hitting another hang (dmesg output below) way more frequently, but that
> one actually reproduces on misc-next as well.  I'm also still confused
> on how we hit the fixup worker, as that means we'll need to see a page
> that.
> 
>   a) was dirty so that the writeback code picks it up
>   b) had the delalloc bit already cleaned in the I/O tree
>   c) does not have the orderd bit set
> 
> "btrfs: move the cow_fixup earlier in writepages handling" would
> be the obvious candidate touching this area, even if I can't see
> how it makes a difference.  Any chance you could check if it is
> indeed the culprit?
> 
> And here is the more frequent hang I see with generic/475 loops:
> 

More investigation, what's happening is dmsetup suspend is stuck because it's
waiting for outstanding io to finish, so these other IO's are stuck in the
deffered list for the linear mapping.  I'm still getting to why the outstanding
IO's aren't going, I'll figure that out in the morning, but seems like this may
not be a btrfs problem.  Thanks,

Josef
