Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33A329E90E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 11:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgJ2Kcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 06:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbgJ2Kck (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:32:40 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A64A20825;
        Thu, 29 Oct 2020 10:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603967524;
        bh=TdkpJyTCP2zLz6N2j6QgeCjTAKX1OZ/wDn/TPcZKuhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WfGKps95tL2Rb6G05LbA0VEbLOFTmsZBlJNJeWBVKX8CuOClEA4/wV+4iVl/u0V0o
         OxnuQ+E7SRRNpCVP4PyE2m/KghxSjLEK6p+ybL/b1tMd3Z/Kq5jJu5Og9IhQSX2Eiv
         SHY57O9wfRNqcqbbsrIXanDLFBCLXuvb5MxjzpKI=
Date:   Thu, 29 Oct 2020 11:32:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] proc: switch over direct seq_read method calls to
 seq_read_iter
Message-ID: <20201029103255.GD3764182@kroah.com>
References: <20201029100950.46668-1-hch@lst.de>
 <20201029100950.46668-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029100950.46668-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:09:50AM +0100, Christoph Hellwig wrote:
> Switch over all instances used directly as methods using these sed
> expressions:
> 
> sed -i -e 's/\.proc_read\(\s*=\s*\)seq_read/\.proc_read_iter\1seq_read_iter/g'
> 
> This fixes a problem with the Android bionic test suite using /proc/cpuinfo
> and /proc/version for its splice based tests.
> 
> Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
> Reported-by: Greg KH <gregkh@linuxfoundation.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I tested some of these files, so might as well add my "mark":

Tested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
