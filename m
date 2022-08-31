Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53185A89AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 02:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiIAAAE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 20:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiIAAAC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:00:02 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A66D11828;
        Wed, 31 Aug 2022 16:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H3j0Z2sqcGr82/erVNUwpG7FB1dauo0sUqWCTxHYIeM=; b=PVfvVSm4ryVqc0gHfs8mLy2beb
        IN+z1qDE9hMpR9Ew8k3IHP3HXXjUTdrPg/wDgx8yYfJ+xa9mi2pt85Ncwt6ZPFR+rcQ0uffcw4qZU
        h9Dvczng6YFOIrp0nNlqKjYDtOQulRDYJFC+gDgN+/P8AnRPacHTZeSaq/zDjPwFJjlAndIGYbR9g
        QfoBQ9CWQ7b9Q+zI23m8ypuUjgaSTyeCO0ghpbWMKyYwJQsne9CULteIkp+zH/NdkDlIwivfw99op
        iAb0V/IuCplQJiDovEzGQQ4XRaVrnCpIiOR2ZnDCpbtk4cZvxkfQTPzmlrLwXofi9UsHJduAh1bxM
        xNjNvbWw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oTXcY-00AmjW-5X;
        Wed, 31 Aug 2022 23:59:46 +0000
Date:   Thu, 1 Sep 2022 00:59:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rustam Subkhankulov <subkhankulov@ispras.ru>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH v2] fs/inode.c: change the order of initialization in
 inode_init_always()
Message-ID: <Yw/18jnzW8fA3BYd@ZenIV>
References: <20220829141517.bcjbdk5zb74mrhgu@wittgenstein>
 <20220829192521.694631-1-subkhankulov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829192521.694631-1-subkhankulov@ispras.ru>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 29, 2022 at 10:25:21PM +0300, Rustam Subkhankulov wrote:
> If function security_inode_alloc() returns a nonzero value due to an
> error (e.g. fail to allocate memory), then some of the fields, including
> 'i_private', will not be initialized.
> 
> After that, if the fs-specfic free_inode function is called in
> i_callback(), the nonzero value of 'i_private' field can be interpreted
> as initialized. As a result, this can cause dereferencing of random
> value pointer (e.g. nilfs2).
> 
> In earlier versions, a similar situation could occur with the 'u' union
> in 'inode' structure.

See vfs.git#work.inode (included into #for-next); I agree that your
commit message looks better, but...
