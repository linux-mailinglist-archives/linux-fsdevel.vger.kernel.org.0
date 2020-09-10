Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA729264E78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 21:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgIJTPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 15:15:42 -0400
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:60850
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730876AbgIJPyq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599752971;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=T7MnzKAEgmiTqYxe2nA95I6IrIr3swA3Otk18pZfblw=;
        b=G/uJD8My0fegYQOV/xKzU3oiF+FxCWx4yyHOXUiLl70L7KBn51fr8o0NN6uNrt/y
        oZLJj4r4EFhFAV186AmKUk5KljjIkRoUSDMW84t9YRxhpbNwN0A6/5SfyEQx7A8SFOy
        rNcYuQ6izxUoGctoKJz8h850OJcPBG6fMSBQDhn4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599752971;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=T7MnzKAEgmiTqYxe2nA95I6IrIr3swA3Otk18pZfblw=;
        b=g8lAT/SNOxdvQwzaUrOwl2M6owqWS4MUJS2X+ojzuOzu4ZndvzP3mDZdX7pzOKDd
        OOt602FAALgSwG8QdR7wsLcsEXyzCG8zcgydvpzaSjhT/OHKkx936YyNRGTJrAKdRf4
        KZmYwy+myP5erNPausCAWCEMKiCC6+kH6GGbNk0w=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Sep 2020 15:49:31 +0000
From:   ppvk@codeaurora.org
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Pradeep P V K <pragalla@qti.qualcomm.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, stummala@codeaurora.org,
        sayalil@codeaurora.org
Subject: Re: [PATCH V4] fuse: Fix VM_BUG_ON_PAGE issue while accessing zero
 ref count page
In-Reply-To: <20200908112753.GD27537@casper.infradead.org>
References: <1599553026-11745-1-git-send-email-pragalla@qti.qualcomm.com>
 <20200908112753.GD27537@casper.infradead.org>
Message-ID: <0101017478b524e0-e1f4e4f4-2137-4953-8594-9b7b55c0ea25-000000@us-west-2.amazonses.com>
X-Sender: ppvk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.10-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-09-08 16:57, Matthew Wilcox wrote:
> On Tue, Sep 08, 2020 at 01:47:06PM +0530, Pradeep P V K wrote:
>> Changes since V3:
>> - Fix smatch warnings.
>> 
>> Changes since V2:
>> - Moved the spin lock from fuse_copy_pages() to fuse_ref_page().
>> 
>> Changes since V1:
>> - Modified the logic as per kernel v5.9-rc1.
>> - Added Reported by tag.
>> 
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Umm, the way this is written, it looks like Dan reported the original
> bug rather than a bug in v3.  The usual way is to credit Dan in the
> 'Changes since' rather than putting in a 'Reported-by'.
> 
sure thanks. i will note this for my next patches to upstream.

>>  static int fuse_ref_page(struct fuse_copy_state *cs, struct page 
>> *page,
>> -			 unsigned offset, unsigned count)
>> +			 unsigned offset, unsigned count, struct fuse_conn *fc)
> 
> I'm no expert on fuse, but it looks to me like you should put a pointer
> to the fuse_conn in struct fuse_copy_state rather than passing it down
> through all these callers.

True but will wait for other expert suggestions and comments too.

Thanks and Regards,
Pradeep
