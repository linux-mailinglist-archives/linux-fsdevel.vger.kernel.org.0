Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90DD677E59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 15:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjAWOs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 09:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAWOsp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:48:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EDA7EEF;
        Mon, 23 Jan 2023 06:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wl3Niw4O9nNC5eHp0o15nurcQU4lhk5gY4m+aQvGNN4=; b=JUNZQuUn2GfDKxZDTgxGuyZLK8
        ZBqDUafX19yvzC/6C3UlnlinLIspGmZ5ILHlmqeld2kQjQW9IsthszzTZP/KKTPxF0eHElm+2NSeD
        3xUWnmxH+FhvxyCs8DwxnCZz/CF8iysxuNoOHHWZy6pK1bu10X2q0deJFeXkOl2ds3u7wyCPl8Ht0
        GsNmYTmd10wBx0S55GpXiJSj05wuj1yAEJUgixCtQcG4G+sJz/oTut0l432L0IT4xY5XFE7Skb4Ij
        mUlNwzbypKQarf7G/8plj8uScczUKWj0/uP/xRFR9zWBgpEnehT90eQUG6IWkDv762fcjXRDqhjJ1
        6Xuq21aQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJy7T-0001pF-MN; Mon, 23 Jan 2023 14:48:23 +0000
Date:   Mon, 23 Jan 2023 06:48:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Message-ID: <Y86eN+D7c2zCqVxV@infradead.org>
References: <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com>
 <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com>
 <246ba813-698b-8696-7f4d-400034a3380b@redhat.com>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-3-dhowells@redhat.com>
 <3814749.1674474663@warthog.procyon.org.uk>
 <3903251.1674479992@warthog.procyon.org.uk>
 <3911637.1674481111@warthog.procyon.org.uk>
 <77f3fc56-05d8-def0-e518-0906c729e7df@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77f3fc56-05d8-def0-e518-0906c729e7df@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 03:20:41PM +0100, David Hildenbrand wrote:
> > The block bio code then only needs a single bit of state: pinned or not
> > pinned.
> 
> Unfortunately, I'll have to let BIO experts comment on that :) I only know
> the MM side of things here.

It can work for bios.
