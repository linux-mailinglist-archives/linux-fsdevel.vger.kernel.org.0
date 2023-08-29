Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C109778C55F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 15:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjH2Nay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 09:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbjH2Nah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:30:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E645D187;
        Tue, 29 Aug 2023 06:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SwTnfgtcSQBFpm6BEK6rULrh1W3ODLZ0tDj55vULUGc=; b=fU1qelCyh3UhM/OOOOZlt/SBga
        tOC2j6Dn4HX/myc0RSGZC7Vt4gtpJ434ZW3drNhV2EfMZ68vz5XwK8BdYhSlTDz/OEAfqcXQWYRK2
        4pQRUZDk5Rmf8M8xvIU6O9yEcmhU7DLRFsKc3I4vPZDN4H5V4ittYQW35woDttfvZVU+al3pWk8lO
        v/SevJa3T05+7ApoMwnHOHnoafpMfWvO1gBRiVuFM7Qmoo6T0Tm0EOAq0bengscx7E8MqH+naTNXt
        KoQO/v/ndpax6v0YfE87aYRoYp18pz2tGBCqSKgl2Ww14o3CYix+XZNzBEVPzXwaQ9+MW39kh6+Wm
        42MXcuEg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qaynd-006nfu-9d; Tue, 29 Aug 2023 13:30:29 +0000
Date:   Tue, 29 Aug 2023 14:30:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/15] ceph: Use a folio in ceph_filemap_fault()
Message-ID: <ZO3y9ZixzE4c5oHU@casper.infradead.org>
References: <20230825201225.348148-1-willy@infradead.org>
 <20230825201225.348148-10-willy@infradead.org>
 <ZOlq5HmcdYGPwH2i@casper.infradead.org>
 <2f1e16e5-1034-b064-7a92-e89f08fd2ac1@redhat.com>
 <668b6e07047bdc97dfa1d522606ec2b28420bdce.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668b6e07047bdc97dfa1d522606ec2b28420bdce.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 29, 2023 at 07:55:01AM -0400, Jeff Layton wrote:
> On Mon, 2023-08-28 at 09:19 +0800, Xiubo Li wrote:
> > Next time please rebase to the latest ceph-client latest upstream 
> > 'testing' branch, we need to test this series by using the qa 
> > teuthology, which is running based on the 'testing' branch.
> 
> People working on wide-scale changes to the kernel really shouldn't have
> to go hunting down random branches to base their changes on. That's the
> purpose of linux-next.

Yes.  As I said last time this came up
https://lore.kernel.org/linux-fsdevel/ZH94oBBFct9b9g3z@casper.infradead.org/

it's not reasonable for me to track down every filesystem's private
git tree.  I'm happy to re-do these patches against linux-next in a
week or two, but I'm not going to start working against your ceph tree.
I'm not a Ceph developer, I'm a Linux developer.  I work against Linus'
tree or Stephen's tree.
