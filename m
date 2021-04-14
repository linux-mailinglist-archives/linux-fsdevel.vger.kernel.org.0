Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A2135EB05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 04:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345952AbhDNCkr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 22:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345944AbhDNCkr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:40:47 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE41C061574;
        Tue, 13 Apr 2021 19:40:26 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWVS1-005B4L-DP; Wed, 14 Apr 2021 02:40:21 +0000
Date:   Wed, 14 Apr 2021 02:40:21 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, matthew.wilcox@oracle.com,
        khlebnikov@yandex-team.ru
Subject: Re: [PATCH RFC 0/6] fix the negative dentres bloating system memory
 usage
Message-ID: <YHZWFQp8seUUxHe9@zeniv-ca.linux.org.uk>
References: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 06:49:39PM +0530, Gautham Ananthakrishna wrote:

> We tested this patch set recently and found it limiting negative dentry to a
> small part of total memory. The following is the test result we ran on two
> types of servers, one is 256G memory with 24 CPUS and another is 3T memory
> with 384 CPUS. The test case is using a lot of processes to generate negative
> dentry in parallel, the following is the test result after 72 hours, the
> negative dentry number is stable around that number even after running longer
> for much longer time. Without the patch set, in less than half an hour 197G was
> taken by negative dentry on 256G system, in 1 day 2.4T was taken on 3T system.
> 
> system memory   neg-dentry-number   neg-dentry-mem-usage
> 256G            55259084            10.6G
> 3T              202306756           38.8G
> 
> For perf test, we ran the following, and no regression found.
> 
> 1. create 1M negative dentry and then touch them to convert them to positive
>    dentry
> 
> 2. create 10K/100K/1M files
> 
> 3. remove 10K/100K/1M files
> 
> 4. kernel compile

Good for you; how would that work for thinner boxen, though?  I agree that if you
have 8M hash buckets your "no more than 3 unused negatives per bucket" is generous
enough for everything, but that's less obvious for something with e.g 4 or 8 gigs.
And believe it or not, there are real-world boxen like that ;-)
