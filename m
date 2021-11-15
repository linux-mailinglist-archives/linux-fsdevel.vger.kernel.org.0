Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2527245172C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 23:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352595AbhKOWKW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 17:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351358AbhKOWHn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 17:07:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2984863237;
        Mon, 15 Nov 2021 22:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637013887;
        bh=0jEF43JuvqZC2E0e+RI1uDZqXHyAKcwpeuP8JeEUML4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EOnrcpkwv83WCJIJBE5aPIFtLcPdVVgxbAHhoCXI8Kur6J/KcCoERMzGfkGi3NLzN
         CcLqQwnin18dT2bHwHMlWngxkg1aME7G+cmaNcHVMxDw+HTUTdh+U9yBMTFVupBEQ+
         bdgDCfgAm9NEZOA+oGcfSZUiQ5BC6bGX5ZtQpkPQ=
Date:   Mon, 15 Nov 2021 14:04:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] proc/vmcore: fix clearing user buffer by properly
 using clear_user()
Message-Id: <20211115140444.bca2b88cfdd992760a413442@linux-foundation.org>
In-Reply-To: <20211112092750.6921-1-david@redhat.com>
References: <20211112092750.6921-1-david@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 12 Nov 2021 10:27:50 +0100 David Hildenbrand <david@redhat.com> wrote:

> To clear a user buffer we cannot simply use memset, we have to use
> clear_user(). With a virtio-mem device that registers a vmcore_cb and has
> some logically unplugged memory inside an added Linux memory block, I can
> easily trigger a BUG by copying the vmcore via "cp":
> 
> ...
>
> Some x86-64 CPUs have a CPU feature called "Supervisor Mode Access
> Prevention (SMAP)", which is used to detect wrong access from the kernel to
> user buffers like this: SMAP triggers a permissions violation on wrong
> access. In the x86-64 variant of clear_user(), SMAP is properly
> handled via clac()+stac().
> 
> To fix, properly use clear_user() when we're dealing with a user buffer.
> 

I added cc:stable, OK?
