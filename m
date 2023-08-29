Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA79378BCA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 04:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbjH2CGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 22:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbjH2CG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:06:27 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62141BD;
        Mon, 28 Aug 2023 19:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oP8fj38bboms1uJShzDU6mgwe9sKE93KOrcjUMBNZME=; b=wNWIUkcs/45QgUJmsxczuJiN/R
        F4wMLEpXMoZeBRGNwBwe+F5GOwBpBQ3tQnTuvGh52vY1ZObxB/YOD8AtOPrrFN44xwn/zpDwwjliC
        Wt3W6iJnKUmQsDRKIqSiVQIC7Q7nCTwbegbPk4J0tP3CWh6Y6WKRWvv9P4YHldm/0d9DHitAV2vD7
        sHOMwc/+XMDIppwQNMA7yGVj6vqWEq9uK5JU0mix8dCE5kZ/a0U3xOxlJcWUacAAnMqdEbSRq5SIg
        uNbxl4HTndR74wrJ2AoeW7KprnfHZ/wRMKXGGdh+4d9C7VWqp1u9KV5vpA1IEwURws97ihtiAQ23F
        l4VEy+ow==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qao7S-001i1V-2b;
        Tue, 29 Aug 2023 02:06:14 +0000
Date:   Tue, 29 Aug 2023 03:06:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] block: open code __generic_file_write_iter for
 blkdev writes
Message-ID: <20230829020614.GB325446@ZenIV>
References: <20230801172201.1923299-1-hch@lst.de>
 <20230801172201.1923299-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801172201.1923299-4-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 07:21:58PM +0200, Christoph Hellwig wrote:
> @@ -569,7 +594,23 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		iov_iter_truncate(from, size);
>  	}
>  
> -	ret = __generic_file_write_iter(iocb, from);
> +	ret = file_remove_privs(file);
> +	if (ret)
> +		return ret;

That chunk is a bit of a WTF generator...  Thankfully,

static int __file_remove_privs(struct file *file, unsigned int flags)
{
        struct dentry *dentry = file_dentry(file);
	struct inode *inode = file_inode(file);
	int error = 0;
	int kill;

	if (IS_NOSEC(inode) || !S_ISREG(inode->i_mode))
		return 0;

means that it's really a no-op.  But I'd still suggest
removing it, just to reduce the amount of head-scratching
for people who'll be reading that code later...
