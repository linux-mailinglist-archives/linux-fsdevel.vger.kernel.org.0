Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89840665000
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 00:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjAJXkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 18:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbjAJXkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:40:09 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C2A59509
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 15:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uZ+XM+MEsmBgR/ya5Nb8zAo0JXIA3QBXArf4Db9NIwI=; b=qS5M+bO5HWxIwSZiqPVMRpwiBR
        yPAsYdIhUmENuSxPNqNgo2Wt27hKGvIoub1lXlEdJIPkRY3UsLmzNMVbFmg2Pt2aoPDW+ZICdlH9t
        NOyc30ZTyuNt/3MDh5J/pvvPRioELKlmMuy3ogm8vIv6ASDzZB5/W3HRDSVVn11v87NKco/IizKR7
        HTu07fg7t+zHzLhD5vfSI34RYZ9izGbsRGxSF5b230OnpUegEoDsLisw7qo57CuZUOp18Q8J/E8XG
        HxVUqZmI9oFNBXZ456lp37bZbNCG1mFaXa91tvlFM/YtWH1AJk2pjFWCPIyuISe3McUoIkvxyZdS+
        mcwuqq/w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pFODt-0015Uu-1N;
        Tue, 10 Jan 2023 23:40:05 +0000
Date:   Tue, 10 Jan 2023 23:40:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, p.raghav@samsung.com,
        hch@infradead.org, john.johansen@canonical.com, dhowells@redhat.com
Subject: Re: [RFC 1/3] apparmor: use SB_* flags for private sb flags
Message-ID: <Y733Vaq6Nnb9nvDK@ZenIV>
References: <20230110022554.1186499-1-mcgrof@kernel.org>
 <20230110022554.1186499-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110022554.1186499-2-mcgrof@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 06:25:52PM -0800, Luis Chamberlain wrote:
> Commit 2ea3ffb7782 ("apparmor: add mount mediation") John Johansen
> added mount mediation support. However just the day before this commit
> David Howells modified the internal sb flags through commit e462ec50cb5
> ("VFS: Differentiate mount flags (MS_*) from internal superblock flags").
> 
> Use the modified sb flags to make things clear and avoid further uses
> of the old MS_* flags for superblock internal flags. This will let us
> later remove the MS_* sb internal flags as userspace should not be
> using them.
> 
> This commit does not fix anything as the old flags used map to the
> same bitmask, this just tidies things up. I split up the flags to
> make it clearer which ones are for the superblock and used internally.

I don't think that's right.  apparmor_sb_mount() gets (almost) raw flags
from mount(2); incidentally, MS_MGC_MSK removal directly above the modified
line is BS since _that_ has already been done by the caller.

Note that the same function explicitly checks for MS_MOVE, etc. in the
same argument.

> @@ -74,7 +74,7 @@ static void audit_mnt_flags(struct audit_buffer *ab, unsigned long flags)
>  		audit_log_format(ab, ", iversion");
>  	if (flags & MS_STRICTATIME)
>  		audit_log_format(ab, ", strictatime");
> -	if (flags & MS_NOUSER)
> +	if (flags & SB_NOUSER)
>  		audit_log_format(ab, ", nouser");
>  }

Umm...  How does one trigger that one?
