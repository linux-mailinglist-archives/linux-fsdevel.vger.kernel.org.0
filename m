Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BE34F72BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 05:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbiDGDQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 23:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiDGDP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:15:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1B231923;
        Wed,  6 Apr 2022 20:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a+/6IHa8J2ibYiY7PsEo03ecQN3sZog+lPT2RUEfmQU=; b=XiY2rlMpWwSz+W6TCaFdXuEU90
        B3wVZ3teCDo6niE97uSEv6VN/Qn4+b6hZs4HHpREIo3Z1ADoaKyVeipKQhZGjheHUZqQuhGNUy02y
        44vMr3KV6IqI7w08utLuSRafzs8CygGmbGyhCSRgdauKwspKoEO46Uo3X3ot3sD2csuGq6oaOD49j
        HPGRctd+JHA1gfUiqu8yAVIbmCaqThOUuVlph+TEtdjwe80lbFuJVm1LQ6wtJQbToNmjs4OUioz4F
        oHs093V9QAbVKXbJmR0qFp6K2ISohuumBm09EShIuplcqcyVGxf5wrk6Y8rZCasfhTsJLVc7dtDuc
        7xIGki7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncIah-008Qzd-Fd; Thu, 07 Apr 2022 03:13:47 +0000
Date:   Thu, 7 Apr 2022 04:13:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 14/14] mm, netfs, fscache: Stop read optimisation when
 folio removed from pagecache
Message-ID: <Yk5W6zvvftOB+80D@casper.infradead.org>
References: <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
 <164928630577.457102.8519251179327601178.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164928630577.457102.8519251179327601178.stgit@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 07, 2022 at 12:05:05AM +0100, David Howells wrote:
> Fix this by adding an extra address_space operation, ->removing folio(),
> and flag, AS_NOTIFY_REMOVING_FOLIO.  The operation is called if the flag is
> set when a folio is removed from the pagecache.  The flag should be set if
> a non-NULL cookie is obtained from fscache and cleared in ->evict_inode()
> before truncate_inode_pages_final() is called.

What's wrong with ->freepage?
