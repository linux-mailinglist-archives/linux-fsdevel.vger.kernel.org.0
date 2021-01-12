Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8FE2F2CE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 11:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391595AbhALKc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 05:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390082AbhALKcZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:32:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D741C061575;
        Tue, 12 Jan 2021 02:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l/TbgEzVo1YEhV95cU2d4O0NAo2vpSzJkfkZLrlwU10=; b=qjCr83yNb/TnSvcL8mxtzAEiFu
        3doVyOkZL6QRy/yG3iQiKOKqNN/enhKAh5lRG+ZrTMF1gKIVRYUxWwwysc8I++mWDVvfFd8xkNmTp
        J4AX5Md4vVe/867SMsJ8iAnM44pvS2r5qmxH588Lqky1DuFwyDv1fsivcmpY5WIsWiSBnv3ZyEawj
        UfDjRmi/PJV1GkGtXqI4msv+IP4sHV6e+zSCmN2KVKoDTKF9/U7dmIvnOj3QcBrkTgX/gOLarXC9l
        e6FQtgGzVkP5gWGFyEvtKJ2Ec6sFbEVBJPgGqU9tIReDw7LgFnuhHNqSYzV+U3xAOlgGxpTOtp0fE
        USbOGPug==;
Received: from [2001:4bb8:19b:e528:5ff5:c533:abbf:c8ac] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kzGxg-004dy5-5Z; Tue, 12 Jan 2021 10:31:41 +0000
Date:   Tue, 12 Jan 2021 11:31:39 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, andres@anarazel.de
Subject: Re: [PATCH 1/6] iomap: convert iomap_dio_rw() to an args structure
Message-ID: <X/16i5SjiSbSD1Qm@infradead.org>
References: <20210112010746.1154363-1-david@fromorbit.com>
 <20210112010746.1154363-2-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112010746.1154363-2-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 12:07:41PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Adding yet another parameter to the iomap_dio_rw() interface means
> changing lots of filesystems to add the parameter. Convert this
> interface to an args structure so in future we don't need to modify
> every caller to add a new parameter.


I don't like this at all - it leads to bloating of both the source and
binary code without a good reason as you're only passing additional
flags.  Converting the existing wait_for_completion to flags value gives
you everyting you need while both being more readable and generating
better code.
