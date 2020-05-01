Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946A31C1F75
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 23:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgEAVTF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 17:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAVTF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 17:19:05 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88E9E20787;
        Fri,  1 May 2020 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588367945;
        bh=eS4UFrsPzGu4rvp9KfgUzgHF9eFBoLTYHJ7BQe382wk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1OURwhfWhQ712LzjrmsRXv/qnPOWXnqXvqPjKnaoB1zOxQmDB2UaYfMMzEs4gZ8MP
         Bt4ZnmD5d8sdd3IzGK5ZtRkNTg7zhWibaEwEUoFROYrODSFbELcTnYf+g936Wdu8vn
         3ag5Fotuv7+d67bdifx+GdSZSf/mA6VoHUab1ekw=
Date:   Fri, 1 May 2020 14:19:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] exec: open code copy_string_kernel
Message-Id: <20200501141903.5f7b1f81fdd38ae372d91f0e@linux-foundation.org>
In-Reply-To: <20200501104105.2621149-3-hch@lst.de>
References: <20200501104105.2621149-1-hch@lst.de>
        <20200501104105.2621149-3-hch@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri,  1 May 2020 12:41:05 +0200 Christoph Hellwig <hch@lst.de> wrote:

> Currently copy_string_kernel is just a wrapper around copy_strings that
> simplifies the calling conventions and uses set_fs to allow passing a
> kernel pointer.  But due to the fact the we only need to handle a single
> kernel argument pointer, the logic can be sigificantly simplified while
> getting rid of the set_fs.
> 

I don't get why this is better?  copy_strings() is still there and
won't be going away - what's wrong with simply reusing it in this
fashion?

I guess set_fs() is a bit hacky, but there's the benefit of not having
to maintain two largely similar bits of code?

