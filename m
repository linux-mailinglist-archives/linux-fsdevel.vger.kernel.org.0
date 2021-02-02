Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECE130B405
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 01:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhBBAWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 19:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhBBAWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:22:06 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D42FC061573
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Feb 2021 16:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=eMC1upQ/xh0gtDptBX82aZuARaprXrwBdivg9H1V/0k=; b=BYuWPha5ZBSqYVwMtNXfh04Mer
        e4mZ5mleYALaYVYdxbVBpPmQ1zGWJt36egCiiWS0CieqGpTYsudoYtjVlQv4dAyos1soGVcZM9Vpd
        U0kvRtCYNHwWp+T0+DzuwiJAWCG7sRVFSB9Bii05oYaJWsTg8b8FjwDm2rdE9s1RIUAWDm905sLb/
        YmtIvtdw0xlTetmFnpqza+9QdTWn55fgIegMEOJ/LP2iqTFq3SiVeuopYouLYnaoSDwpNZjh7CgsP
        fVrz6BX6sUq6RcBtMaRCC90BaDfOZXMyC9FboXoMj9rF/b6OGNKJM0izc6olhiu7ZQfgMG9AQcZpy
        7XxGfUjA==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l6jRc-0006nV-Aw; Tue, 02 Feb 2021 00:21:24 +0000
Subject: Re: Using bit shifts for VXFS file modes
To:     Amy Parker <enbyamy@gmail.com>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
References: <CAE1WUT63RUz0r2LaJZ7hvayzfLadEdsZjymg8UYU481de+6wLA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <759c43fe-c482-4eaf-8f5e-b82985bbc7da@infradead.org>
Date:   Mon, 1 Feb 2021 16:21:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAE1WUT63RUz0r2LaJZ7hvayzfLadEdsZjymg8UYU481de+6wLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/1/21 3:49 PM, Amy Parker wrote:
> Hello filesystem developers!
> 
> I was scouting through the FreeVXFS code, when I came across this in
> fs/freevxfs/vxfs.h:
> 
> enum vxfs_mode {
>         VXFS_ISUID = 0x00000800, /* setuid */
>         VXFS_ISGID = 0x00000400, /* setgid */
>         VXFS_ISVTX = 0x00000200, /* sticky bit */
>         VXFS_IREAD = 0x00000100, /* read */
>         VXFS_IWRITE = 0x00000080, /* write */
>         VXFS_IEXEC = 0x00000040, /* exec */
> 
> Especially in an expanded form like this, these are ugly to read, and
> a pain to work with.
> 
> An example of potentially a better method, from fs/dax.c:
> 
> #define DAX_SHIFT (4)
> #define DAX_LOCKED (1UL << 0)
> #define DAX_PMD (1UL << 1)
> #define DAX_ZERO_PAGE (1UL << 2)
> #define DAX_EMPTY (1UL << 3)
> 
> Pardon the space condensation - my email client is not functioning properly.

That's the gmail web interface, right?
I believe that you can use a real email client to talk to
smtp.gmail.com and it won't mangle spaces in your emails.

> Anyways, I believe using bit shifts to represent different file modes
> would be a much better idea - no runtime penalty as they get
> calculated into constants at compile time, and significantly easier
> for the average user to read.
> 
> Any thoughts on this?

It's all just opinions. :)

I find the hex number list easier to read .. and the values are
right there in front of you when debugging, instead of having to
determine what 1 << 9 is.

cheers.
-- 
~Randy

