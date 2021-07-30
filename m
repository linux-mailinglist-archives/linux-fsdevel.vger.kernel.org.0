Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E113DB2D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 07:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbhG3Fdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 01:33:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50578 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhG3Fdi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:33:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B7EE52234C;
        Fri, 30 Jul 2021 05:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627623212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U23+/hZjJxbH5NKPlHP4VCQ6o249NRYzE/t/5htL4+k=;
        b=A13dI3Bnye6A+xR11hb9a02sSAIJFMavYVMgSGF43ZK+etvdcpJbgxWiBRoVRBpP5G+98Z
        kDQZA8Fo77LaIN1cGRyWmiSy0BOT/hW8mBhEXyUqSEZYRLzZ/MkJ3uQu4EjEA1q9iIFJDw
        RzHvvAjmOauK1qFhz8LJgTpQJQC+Vko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627623212;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U23+/hZjJxbH5NKPlHP4VCQ6o249NRYzE/t/5htL4+k=;
        b=lcUuFGfY/zgFx4jyK69l3f7/++5RKWlQsF3uhCiAhwa8vY4ztg0+TBLvxWySJQJ5BpQAHb
        eb9B/Qng16X0WNDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAFD513BF9;
        Fri, 30 Jul 2021 05:33:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /EKHISmPA2HIeQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 30 Jul 2021 05:33:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Al Viro" <viro@zeniv.linux.org.uk>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/11] VFS: export lookup_mnt()
In-reply-to: <YQNIUA6NKmSgdawv@zeniv-ca.linux.org.uk>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162742546551.32498.5847026750506620683.stgit@noble.brown>,
 <YQNIUA6NKmSgdawv@zeniv-ca.linux.org.uk>
Date:   Fri, 30 Jul 2021 15:33:26 +1000
Message-id: <162762320688.21659.7949785958006573635@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Jul 2021, Al Viro wrote:
> On Wed, Jul 28, 2021 at 08:37:45AM +1000, NeilBrown wrote:
> > In order to support filehandle lookup in filesystems with internal
> > mounts (multiple subvols in the one filesystem) reconnect_path() in
> > exportfs will need to find out if a given dentry is already mounted.
> > This can be done with the function lookup_mnt(), so export that to make
> > it available.
> 
> IMO having exportfs modular is wrong - note that fs/fhandle.c is
> 	* calling functions in exportfs
> 	* non-modular
> 	* ... and not going to be modular, no matter what - there
> are syscalls in it.
> 
> 

I agree - it makes sense for exportfs to be non-module.  It cannot be
module if FHANDLE is enabled, and if you don't want FHANDLE you probably
don't want EXPORTFS either.

Thanks,
NeilBrown
