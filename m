Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821E949D9A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 05:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbiA0Ehg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 23:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiA0Ehf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 23:37:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E03C06161C
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 20:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iKiKxxhrSJFYaJaeyz80qMocG8PZXo23Bcok2I9hEfE=; b=KCl5BfZ9TGRN6tjDsesNBzSC0f
        ZESBgNgm+cwYCYvkmLunjC0imVcxsPRbmeOBTwFAIM5HCVQ7pgM0JzMBa+NQHUkSc8VD+zro/ASB7
        FhdUq0pPG1XItWu6zwWj4PIB0HxhsGc0MLyKEYVkalRIT4aWBWUv3jwue8rmAn9wsUjm3JSKpsfll
        8mAFZpZQfIiHZ1VveA+Pc1KUI/bZMkpyuLzbc0NlKpzSC5V1ShMVKHlkL/gFHL+h9YBydmxKbFhGC
        XJp39B3wSutx7K6zOod6MxMtFiQflHGLAA2AVjzoxKmAAXSMmgUSgu4YhB6uATROJk04jPUgwUVRL
        ljAP8qLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCwXN-004nVH-Ch; Thu, 27 Jan 2022 04:37:33 +0000
Date:   Thu, 27 Jan 2022 04:37:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Black <daniel@mariadb.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: fcntl(fd, F_SETFL, O_DIRECT) succeeds followed by EINVAL in write
Message-ID: <YfIhjVB2gT6/EVc5@casper.infradead.org>
References: <CABVffEPxKp4o_-Bz=JzvEvQNSuOBaUmjcSU4wPB3gSzqmApLOw@mail.gmail.com>
 <YfC5vuwQyxoMfWLP@casper.infradead.org>
 <CABVffEM4KhSNywBVg06XN5JpsDaONKf7wQiKvrTvqGXosssXLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVffEM4KhSNywBVg06XN5JpsDaONKf7wQiKvrTvqGXosssXLg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 01:38:58PM +1100, Daniel Black wrote:
> > Sorry for the confusion.  You've caught us mid-transition.  Eventually,
> > ->direct_IO will be deleted, but for now it signifies whether or not the
> > filesystem supports O_DIRECT, even though it's not used (except in some
> > scenarios you don't care about).
> 
> being executed at the bottom of setfl which keeps the file descriptor
> out of O_DIRECT mode when
> the filesystem (like CIFS doesn't support it). In the original strace

Apparently I wasn't clear ...

CIFS absolutely does support O_DIRECT.  It does not do it by calling
->direct_IO; instead it's handled in cifs_loose_read_iter().

