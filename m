Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE3772B7FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 08:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjFLGP4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 02:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjFLGPz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:15:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE5093;
        Sun, 11 Jun 2023 23:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sBP0nSW6/Sb084WdMIA75VMt8PAOWVcCHkxnURq91eE=; b=kEpL6VvDAAsB2nSeMhVD4Gk6t2
        8m3CmKdTnhify4RvIhyedLvzcLfkZKMK1al0lEwRhVRF6zyH5bAfAA3XjM3PiryODpDKHJZgKKSOM
        wPkzlKe8S1jUUX5B0hpBasCFj1kItLzXlIjGZgzMORQePj71J8o7gaiFGInV9DhuzMAOzw5YJpVyY
        6E4yflrvJFb1zqY29YG8ZSIU9DijnJPZ9JQGSyj/pNOHJynOZq6LQpRKnGvkFRrhs0YFVx01M6jxD
        Xw0+eZTHUNZBdtoqIAZHZcfATWeab4FnFYVLqVbEq0NID5hV+80FNydEANSS67rddVfNhvJfrCvdL
        zIfAGFSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8aqF-002kBQ-0T;
        Mon, 12 Jun 2023 06:15:51 +0000
Date:   Sun, 11 Jun 2023 23:15:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Subject: Re: [PATCH v2 1/3] fs: rename FMODE_NOACCOUNT to FMODE_INTERNAL
Message-ID: <ZIa4FwIIqmn0vqYy@infradead.org>
References: <20230611132732.1502040-1-amir73il@gmail.com>
 <20230611132732.1502040-2-amir73il@gmail.com>
 <ZIaelQAs0EjPw4TR@infradead.org>
 <CAOQ4uxhNtnzpxUzfxjCJ3_7afCG1ye-pHViHjGi8asXTR_Cm3w@mail.gmail.com>
 <ZIa3DfH9D0BIBf8G@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIa3DfH9D0BIBf8G@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 11, 2023 at 11:11:25PM -0700, Christoph Hellwig wrote:
> On Mon, Jun 12, 2023 at 09:08:37AM +0300, Amir Goldstein wrote:
> > Well, I am not sure if FMODE_FAKE_PATH in v3 is a better name,
> > because you did rightfully say that "fake path" is not that descriptive,
> > but I will think of a better way to describe "fake path" and match the
> > flag to the file container name.
> 
> I suspect the just claling it out what it is and naming it
> FMODE_OVERLAYFS might be a good idea.  We'd just need to make sure not
> to set it for the cachefiles use case, which is probably a good idea
> anyway.

Adding Dave:

not sure if I'm missing something, but is there any good reason
cachefs doesn't juse use dentry_open() ?
