Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB6C399E85
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 12:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhFCKNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 06:13:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42702 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCKNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:13:04 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4A2831FD4D;
        Thu,  3 Jun 2021 10:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622715079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DLKLuxWisUwEm2I7GscafP+C6pVodYx3ob0wXfmME24=;
        b=opSxMdmHCefm6NipON8683FA6qewHvcN98UKV5SN0zpY9wcsA5g9QiaWiZh0brxf7PpXgo
        Tmw4txrHKUr6rkAFYFdT0VQZbkDNarlX9/2c0FVWpbpOpJmZeWgsq6Ch9om+MGUUWEIPXF
        ytuzOc+qMODwC2nw/vOI6o4IG7okeDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622715079;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DLKLuxWisUwEm2I7GscafP+C6pVodYx3ob0wXfmME24=;
        b=CwCCrjCTtBrLxgjKVPF6DsG59tBJnZS3D9kB6wFmWGW8ZEDupwJy2uQt1LvGx4XhMWc74U
        YAqGk34ny6x0gLAA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 3AF63A3B8C;
        Thu,  3 Jun 2021 10:11:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 23EF91F2C98; Thu,  3 Jun 2021 12:11:19 +0200 (CEST)
Date:   Thu, 3 Jun 2021 12:11:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, brauner@suse.cz,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 1/2] quota: Change quotactl_path() systcall to an
 fd-based one
Message-ID: <20210603101119.GI23647@quack2.suse.cz>
References: <20210602151553.30090-1-jack@suse.cz>
 <20210602151553.30090-2-jack@suse.cz>
 <20210603094102.GB26174@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603094102.GB26174@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-06-21 11:41:02, Sascha Hauer wrote:
> Hello Honza,
> 
> On Wed, Jun 02, 2021 at 05:15:52PM +0200, Jan Kara wrote:
> > Some users have pointed out that path-based syscalls are problematic in
> > some environments and at least directory fd argument and possibly also
> > resolve flags are desirable for such syscalls. Rather than
> > reimplementing all details of pathname lookup and following where it may
> > eventually evolve, let's go for full file descriptor based syscall
> > similar to how ioctl(2) works since the beginning. Managing of quotas
> > isn't performance sensitive so the extra overhead of open does not
> > matter and we are able to consume O_PATH descriptors as well which makes
> > open cheap anyway. Also for frequent operations (such as retrieving
> > usage information for all users) we can reuse single fd and in fact get
> > even better performance as well as avoiding races with possible remounts
> > etc.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/quota/quota.c                  | 27 ++++++++++++---------------
> >  include/linux/syscalls.h          |  4 ++--
> >  include/uapi/asm-generic/unistd.h |  4 ++--
> >  kernel/sys_ni.c                   |  2 +-
> >  4 files changed, 17 insertions(+), 20 deletions(-)
> 
> Thanks for taking care of this.
> 
> I also gave this some testing and it's working ok for me, so at least I
> can give you my:
> 
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
