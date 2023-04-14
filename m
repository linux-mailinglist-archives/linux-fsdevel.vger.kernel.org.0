Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED846E1AE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 05:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjDNDvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 23:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDNDvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 23:51:14 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ED24EDC;
        Thu, 13 Apr 2023 20:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A5unxLUF/trhWh4az7FEFonxncdYDeRL1VTUQkMbeug=; b=J1uqK7jB8dgmSMMXL4PGfK/Hdq
        v14gCrD6dOrwQsq4DzOhUuaRepU392hyDjLtMcC784AMioXrn7t4UiiWbWL9vo8vIko77DTeY+Iyf
        oYbosxXTI7XDPRy3rWNrE9LSFvncCY8LXi+1QZQDeWYlS7ARkKXVXoeN0VAaUm1aWwIZzPcaNmESM
        2tEl2gzFrC8dNA/T57FM3fDOEEh9CN58iR13n+a3aFfwM6WKb61R0GpJM6lDBNGFrhZWry7nCihqG
        dNoUEPO6hKeH7rV059dxR81JUpYi88fe2+waaPvZ17ocFJWSG3NOGd/u6TsIXl99KiH5PNiY0GgUv
        rJ360xOw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnASm-008q23-29;
        Fri, 14 Apr 2023 03:51:04 +0000
Date:   Fri, 14 Apr 2023 04:51:04 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Neil Brown <neilb@suse.de>, Jeffrey Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: allowing for a completely cached umount(2) pathwalk
Message-ID: <20230414035104.GH3390869@ZenIV>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168142566371.24821.15867603327393356000@noble.neil.brown.name>
 <20230414024312.GF3390869@ZenIV>
 <8EC5C625-ACD6-4BA0-A190-21A73CCBAC34@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8EC5C625-ACD6-4BA0-A190-21A73CCBAC34@hammerspace.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 03:28:45AM +0000, Trond Myklebust wrote:

> We already have support for directory file descriptors when mounting with move_mount(). Why not add a umountat() with similar support for the unmount side?
> Then add a syscall to allow users with (e.g.) the CAP_DAC_OVERRIDE privilege to convert the mount-id into an O_PATH file descriptor.

You can already do umount -l /proc/self/fd/69 if you have a descriptor.
Converting mount-id to O_PATH... might be an interesting idea.
