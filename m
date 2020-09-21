Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643A82722DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 13:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgIULoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 07:44:14 -0400
Received: from z5.mailgun.us ([104.130.96.5]:51234 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbgIULoG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:44:06 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 07:44:05 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600688645; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=aj7+moQI0HWZLSMQvc/earvkxmxlSTsYW5THyyMnfSg=;
 b=pC3qQ1xtn0g/sbQtGrP0plCZfYIxklGQGHRRVFL3j6TvwzTVCINKA3KdRb0igASxrlN62IRx
 D1Rcfj0hGqDRabuZQ3HoUI5s1liEMTxV6/VaW8rV5E0g7d9my1Xu1I3RJaBHjtO8qyjJSmmX
 5UN0ya777B5o4b0Vw7cw+CuBJvM=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f6890d44ab73023a792e0be (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Sep 2020 11:39:00
 GMT
Sender: ppvk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DDCE2C433F1; Mon, 21 Sep 2020 11:39:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ppvk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F189C433CB;
        Mon, 21 Sep 2020 11:39:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Sep 2020 17:09:00 +0530
From:   ppvk@codeaurora.org
To:     Matthew Wilcox <willy@infradead.org>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        stummala@codeaurora.org, sayalil@codeaurora.org
Subject: Re: [PATCH V2] fuse: Remove __GFP_FS flag to avoid allocator
 recursing
In-Reply-To: <20200916145634.GN5449@casper.infradead.org>
References: <1600238380-33350-1-git-send-email-ppvk@codeaurora.org>
 <20200916145634.GN5449@casper.infradead.org>
Message-ID: <2a5b17f0a80d6a52e6c2c7301dea4c41@codeaurora.org>
X-Sender: ppvk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-09-16 20:26, Matthew Wilcox wrote:
> On Wed, Sep 16, 2020 at 12:09:40PM +0530, Pradeep P V K wrote:
>> Changes since V1:
>> - Used memalloc_nofs_save() in all allocation paths of fuse daemons
>>   to avoid use __GFP_FS flag as per Matthew comments.
> 
> That's not how to use memalloc_nofs_save().  You call it when entering 
> a
> context in which any memory allocation would cause a deadlock.  You 
> don't
> look for every place which allocates memory and wrap the memory 
> allocation
> calls in memalloc_nofs_save() because you're likely to miss one.

> ok, i will fix this in my next patch set.
>>  static ssize_t fuse_dev_read(struct kiocb *iocb, struct iov_iter *to)
>>  {
>> +	ssize_t size;
>> +	unsigned nofs_flag;
> 
> This is almost certainly too low in the call stack.
ok, i will update this in my next patch set.
