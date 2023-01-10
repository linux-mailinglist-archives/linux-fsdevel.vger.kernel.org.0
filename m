Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1F3665013
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 00:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbjAJXyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 18:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjAJXyS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:54:18 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6B455663
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 15:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Dfs4Ez1D2PMYAE/2ri8Kelm0l8oGdZvE+/3EEsPLk9A=; b=U5hBdBjeq5GH5Ginj9e58A+ZB5
        O4AfO5uEqkNh/gOdz/p8BzdqZiJBSYW3e82D7wOt/zQGCCFfQWT1DvvhcFifAKa65mpVYUVQYTSTv
        4CAdps3viGNpA9ZWa6wwSk2bX2JKCHl93SkkpOd/lY+o3MQv2W8HmZftQ6MvSqpq8F2opRdqLrKBr
        dIXHIcrOze+n3ro6qEaWfOku6lr7anXTIfbiHfZ/VlqHum/fKI2G14t4m/j6Fdqa5NTgx9u2ePkyd
        lpAv0E+5axqM/gyHa2+ixqHVYGw5F0uqQnT2HAmUj0ZoVSl476JpgudhPteDadz2LJRPyJ8GYaDM7
        eQ05qccA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pFORb-0015Yr-1G;
        Tue, 10 Jan 2023 23:54:15 +0000
Date:   Tue, 10 Jan 2023 23:54:15 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, p.raghav@samsung.com,
        hch@infradead.org, john.johansen@canonical.com, dhowells@redhat.com
Subject: Re: [RFC 3/3] fs: remove old MS_* internal flags for the superblock
Message-ID: <Y736p/ChILQE5a9X@ZenIV>
References: <20230110022554.1186499-1-mcgrof@kernel.org>
 <20230110022554.1186499-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110022554.1186499-4-mcgrof@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 06:25:54PM -0800, Luis Chamberlain wrote:
> During commit e462ec50cb5 ("VFS: Differentiate mount flags (MS_*) from
> internal superblock flags") Christoph had suggested we should eventually
> remove these old flags which were exposed to userspace but could not
> be used as they were internal-only.
> 
> Nuke them.

Umm...  They are still exposed to userland after your series, though.
IOW, we can't change the bit assignment of e.g. SB_ACTIVE - the apparmor
part will break, etc.

If anything, it would be more honest to lift the "we ignore those bits"
logics to path_mount()...
