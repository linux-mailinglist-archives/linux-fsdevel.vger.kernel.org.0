Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9406A8CEB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 00:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCBXVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 18:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjCBXVs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:21:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAF158B4D;
        Thu,  2 Mar 2023 15:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9l+6TIOZuVLTRbCQe6dl6ZEEsTf49iWyDv39rDDoCwM=; b=af68pGMkYgez5psw+7YJ0JqXQy
        45et0nVKXveju3sOhCY3d08kR9L6wXHCqH0WqAeRXBMshv1QdZ0JexY+mwBWhDodRi20tKkBM3n8k
        Io0xs7ree1soh8THlaBPpbwljdxSz+8uwne8pF4bqQOOns4klg7yNNS6WHsIpRjXp920xgB1mOBmW
        SgEAxUT2CLnnwUrNsRR/NIPvpqD2OsVR/zL4GYTwTBDo473Gad0yMN/jUKcSqkSWNDFctJ/tNXFv5
        jPoGLoWt7AvNomU5fDG0Wdp95ezs6XvSUZIpzGXXP2tKBxWcIK+UmF0uBazI8qBc/4C3uFrQDkmtO
        n3Jrl0Zw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXsEf-002jLW-5E; Thu, 02 Mar 2023 23:21:17 +0000
Date:   Thu, 2 Mar 2023 23:21:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steve French <smfrench@gmail.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Paulo Alcantara <pc@cjr.nz>, Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steve French <sfrench@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm: Add a function to get a single tagged folio from
 a file
Message-ID: <ZAEvbdyHkvAoTSAe@casper.infradead.org>
References: <20230302231638.521280-1-dhowells@redhat.com>
 <20230302231638.521280-2-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302231638.521280-2-dhowells@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 11:16:36PM +0000, David Howells wrote:
> Add a function to get a single tagged folio from a file rather than a batch
> for use in afs and cifs where, in the common case, the batch is likely to
> be rendered irrelevant by the {afs,cifs}_extend_writeback() function.

I think this is the wrong way to go.  I'll work on a replacement once
I've got a couple of other things off my plate.
