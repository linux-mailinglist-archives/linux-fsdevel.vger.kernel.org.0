Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB27196A05
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Mar 2020 00:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgC1XOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 19:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbgC1XOl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 19:14:41 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7652C20732;
        Sat, 28 Mar 2020 23:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585437279;
        bh=QlG76wCkkoEXi8Kjn2MGOTh9NWP/DWjyDT1tuYmEUJI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wkaEDyuUQ8nzjVx2/U+W7k8x+4wH05ZUXsrYj1Ai20juPPeQTtF7oACkKjln/SVwx
         McH6dv5YtqWph1HS+Yl5NbDjo3httI/s4q5gOfIsK0sm8n4J37PYSy1e1+uzfrD7PB
         uidSSgArHHFOSp7OuvOLwib88xMzgDXfEnjuH5No=
Date:   Sat, 28 Mar 2020 16:14:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Simon Gander <simon@tuxera.com>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>
Subject: Re: [PATCH] hfsplus: Fix crash and filesystem corruption when
 deleting files
Message-Id: <20200328161439.d38f14698fe7b5671eada4a5@linux-foundation.org>
In-Reply-To: <20200327155541.1521-1-simon@tuxera.com>
References: <20200327155541.1521-1-simon@tuxera.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 27 Mar 2020 16:55:40 +0100 Simon Gander <simon@tuxera.com> wrote:

> When removing files containing extended attributes, the hfsplus driver
> may remove the wrong entries from the attributes b-tree, causing major
> filesystem damage and in some cases even kernel crashes.
> 
> To remove a file, all its extended attributes have to be removed as well.
> The driver does this by looking up all keys in the attributes b-tree with
> the cnid of the file. Each of these entries then gets deleted using the
> key used for searching, which doesn't contain the attribute's name when it
> should. Since the key doesn't contain the name, the deletion routine will
> not find the correct entry and instead remove the one in front of it. If
> parent nodes have to be modified, these become corrupt as well. This causes
> invalid links and unsorted entries that not even macOS's fsck_hfs is able
> to fix.
> 
> To fix this, modify the search key before an entry is deleted from the
> attributes b-tree by copying the found entry's key into the search key,
> therefore ensuring that the correct entry gets removed from the tree.
> 

This seems fairly important.  Should it have a cc:stable?

