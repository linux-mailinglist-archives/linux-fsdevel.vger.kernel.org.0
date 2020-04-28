Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1C71BBCA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 13:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgD1Llm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 07:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgD1Llm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:41:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4AFC03C1A9;
        Tue, 28 Apr 2020 04:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SF44fARHVEHGSih0nsujUJDqXIWrTmWE2wblzvWtNoM=; b=S3fHEC0nyl6kuxo/FB9XuhCTWw
        ifdbioIGGiLhcfqThKqwQQnvKYjSPTn+aMo9NsxuCDV3swnMih3Sl3f3xrM9mSlOv4YjcTRuoPKq3
        TEtkB2wia7s3ghMI6sMhCbD0gZhHslReZn5T+g5Rrh7OH81YMlmFuAxkOrAdARhpGvELFTsQRHgc4
        QicsPK9ptKNIaSL9j4/0j9ALSXic/kesz8Y9P33C5ynqFSVhoR6otMxyYKaChFHoJYrl0BYXbMb6K
        Yzk4VYIZUq+2Ha1dCPM0nW+oC1cAtzQJnL5YYOAKjZU3Bg9EXPLwJd4wBPXBR4f2GFZWTqfn0+tb0
        pmKPldhg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTOcP-0004HY-My; Tue, 28 Apr 2020 11:41:41 +0000
Date:   Tue, 28 Apr 2020 04:41:41 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2] fibmap: Warn and return an error in case of block >
 INT_MAX
Message-ID: <20200428114141.GL29705@bombadil.infradead.org>
References: <58f0c64a3f2dbd363fb93371435f6bcaeeb7abe4.1588058868.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58f0c64a3f2dbd363fb93371435f6bcaeeb7abe4.1588058868.git.riteshh@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 01:08:31PM +0530, Ritesh Harjani wrote:
> @@ -71,6 +72,13 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
>  	block = ur_block;
>  	error = bmap(inode, &block);
>  
> +	if (block > INT_MAX) {
> +		error = -ERANGE;
> +		pr_warn_ratelimited("[%s/%d] FS (%s): would truncate fibmap result\n",
> +				    current->comm, task_pid_nr(current),
> +				    sb->s_id);

Why is it useful to print the pid?
And why print the superblock when we could print the filename instead?
We have a struct file, so we can printk("%pD4", filp) to print the
last four components of the pathname.

