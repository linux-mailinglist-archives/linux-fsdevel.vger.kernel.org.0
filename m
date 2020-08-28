Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AEF255AB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 14:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgH1M7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 08:59:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34281 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729052AbgH1M7L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:59:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598619550; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=sQjBrlutG38e8mq7GYwXp8bY5IefKSFqKlbNYQ0gtlY=;
 b=vXHvlPRVlpVe3Rmnu67/8jo+42E91jvCuWFyvX1RhUHLpSTac3lkLiSN0Vy0ce1hg693cmhT
 HCt/Mjw/KDmsn6JwWxle0FYNAiIWeDi4YHH4uMNHqj7Dx3acG3Gb4DWRq7G+Wew1XK+FdX1+
 V5Kuo0kcHHd3W29CaeZcf+ML/DI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f48ff9ea816b7fb485e9b12 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 28 Aug 2020 12:59:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4522AC433CB; Fri, 28 Aug 2020 12:59:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ppvk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D6D4EC433CA;
        Fri, 28 Aug 2020 12:59:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Aug 2020 18:29:08 +0530
From:   ppvk@codeaurora.org
To:     Matthew Wilcox <willy@infradead.org>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        stummala@codeaurora.org, sayalil@codeaurora.org
Subject: Re: [PATCH V2] fuse: Fix VM_BUG_ON_PAGE issue while accessing zero
 ref count page
In-Reply-To: <20200827123424.GF14765@casper.infradead.org>
References: <1598452035-3472-1-git-send-email-ppvk@codeaurora.org>
 <20200827123424.GF14765@casper.infradead.org>
Message-ID: <f147e3ceb8bbdbe3849b264e431540e2@codeaurora.org>
X-Sender: ppvk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-08-27 18:04, Matthew Wilcox wrote:
> On Wed, Aug 26, 2020 at 07:57:15PM +0530, Pradeep P V K wrote:
>> Fix this by protecting fuse_copy_pages() with fc->lock.
> 
> No.  This is a spinlock and fuse_copy_pages() can allocate memory
> with GFP_KERNEL.  You need to enable more debugging on your test
> system.

Thanks Matthew for the review and comments. I will address this in my
next patch set. BTW, can you please share your thoughts, if there is a
way to extract fuse_connection Data Structure from fuse_copy_state DS ?
This would really help to use fc->lock only on intended function 
(fuse_ref_page()).
