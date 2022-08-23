Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54FC59E85D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 19:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343866AbiHWREg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 13:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343884AbiHWRDl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:03:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9397988DF3;
        Tue, 23 Aug 2022 07:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cXTGuxSdX3IqLUmH1xbDUEImxUv/M3WOTk/NqLmVJjw=; b=EeRLYkQD0wkNgun3h/DzzNnT3X
        pU/T+Neiz84rBoUVVwFG1YXhN+K3/RjJy6SlAGY8mR3Cfd7k7pr9Tsv1Vo1fdy9I+094beQZ/2SFS
        RGtv4IG9s2MZXamHw24chpE1zevVSJBzwVgQIQeAjWUdDcmYjM45slA7bkWJ8/lPLmv8T5W6qDW9y
        ecav6TnG2ggCHc0SfSMoOBwEc4pNOPvGrpwxb4KgmkgcFoIQVu9T9UaZdeDDyHI4P/DuABZ5tMRgU
        ZsSLNjEgjl9eDjUwNdPWlyUsUXnN+CQ7ZPHf2hJeK3rGYnMOzSmHslRKo2liGi98rRAag5EEQtqbF
        ELYVJBdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQUZR-00FLAT-W7; Tue, 23 Aug 2022 14:07:58 +0000
Date:   Tue, 23 Aug 2022 15:07:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     sfrench@samba.org, linux-cifs@vger.kernel.org, lsahlber@redhat.com,
        jlayton@kernel.org, dchinner@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: Re: [PATCH 3/5] smb3: fix temporary data corruption in collapse range
Message-ID: <YwTfPRDq04/DGTVT@casper.infradead.org>
References: <166126004083.548536.11195647088995116235.stgit@warthog.procyon.org.uk>
 <166126006184.548536.12909933168251738646.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166126006184.548536.12909933168251738646.stgit@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 23, 2022 at 02:07:41PM +0100, David Howells wrote:
>  
> +	filemap_invalidate_lock(inode->i_mapping);
>  	filemap_write_and_wait(inode->i_mapping);
> +	truncate_pagecache_range(inode, off, old_eof);

It's a bit odd to writeback the entire file but then truncate only part
of it.  XFS does the same part:

        error = filemap_write_and_wait_range(inode->i_mapping, start, end);
        if (error)
                return error;
        truncate_pagecache_range(inode, start, end);

... and presumably, you'd also want the error check?

>  	rc = smb2_copychunk_range(xid, cfile, cfile, off + len,
> -				  i_size_read(inode) - off - len, off);
> +				  old_eof - off - len, off);
