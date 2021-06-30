Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EA33B85BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 17:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbhF3PIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 11:08:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48990 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbhF3PIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 11:08:40 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3115222770;
        Wed, 30 Jun 2021 15:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625065570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e83E/uBs3EEaF5PdmWJZN8o1DNeX+cP8Kros1I/iaIM=;
        b=i8j3M07faKq9TQBenVIfdZmIALxxxTu7PENlW3xjdfHTWN0l/Eqvg23R0Lp/PyHD/zLyiZ
        nPHsgkm6TDd+LwDXm9GNcqRNV3xG6h/ef+6SU+nZyX1k1UUA/1pjAljHDYF0EDpShdXNG6
        SMFjl6xAYo2xvWkN47uboGENzC/42AI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625065570;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e83E/uBs3EEaF5PdmWJZN8o1DNeX+cP8Kros1I/iaIM=;
        b=398dourgC4zMm+NCPvIKaN3ye7FhTwm6y7xRyFthUtb//n1BCl4M6siuOUIiKm5LLjCdnT
        8geb4pFyLXxrmyBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A762F118DD;
        Wed, 30 Jun 2021 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625065570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e83E/uBs3EEaF5PdmWJZN8o1DNeX+cP8Kros1I/iaIM=;
        b=i8j3M07faKq9TQBenVIfdZmIALxxxTu7PENlW3xjdfHTWN0l/Eqvg23R0Lp/PyHD/zLyiZ
        nPHsgkm6TDd+LwDXm9GNcqRNV3xG6h/ef+6SU+nZyX1k1UUA/1pjAljHDYF0EDpShdXNG6
        SMFjl6xAYo2xvWkN47uboGENzC/42AI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625065570;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e83E/uBs3EEaF5PdmWJZN8o1DNeX+cP8Kros1I/iaIM=;
        b=398dourgC4zMm+NCPvIKaN3ye7FhTwm6y7xRyFthUtb//n1BCl4M6siuOUIiKm5LLjCdnT
        8geb4pFyLXxrmyBg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id HM16JWGI3GBINAAALh3uQQ
        (envelope-from <lhenriques@suse.de>); Wed, 30 Jun 2021 15:06:09 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 02e01176;
        Wed, 30 Jun 2021 15:06:08 +0000 (UTC)
Date:   Wed, 30 Jun 2021 16:06:08 +0100
From:   Luis Henriques <lhenriques@suse.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Petr Vorel <pvorel@suse.cz>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v10] vfs: fix copy_file_range regression in cross-fs
 copies
Message-ID: <YNyIYNpcy2WsnUnu@suse.de>
References: <20210630134449.16851-1-lhenriques@suse.de>
 <CAOQ4uxi6pMEehkXWAk=vzx3mZAfcxwVPvFs9W7LM2CfgBkZWxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi6pMEehkXWAk=vzx3mZAfcxwVPvFs9W7LM2CfgBkZWxQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 30, 2021 at 05:56:34PM +0300, Amir Goldstein wrote:
> On Wed, Jun 30, 2021 at 4:44 PM Luis Henriques <lhenriques@suse.de> wrote:
> >
> > A regression has been reported by Nicolas Boichat, found while using the
> > copy_file_range syscall to copy a tracefs file.  Before commit
> > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> > kernel would return -EXDEV to userspace when trying to copy a file across
> > different filesystems.  After this commit, the syscall doesn't fail anymore
> > and instead returns zero (zero bytes copied), as this file's content is
> > generated on-the-fly and thus reports a size of zero.
> >
> > This patch restores some cross-filesystem copy restrictions that existed
> > prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> > devices").  Filesystems are still allowed to fall-back to the VFS
> > generic_copy_file_range() implementation, but that has now to be done
> > explicitly.
> >
> > nfsd is also modified to fall-back into generic_copy_file_range() in case
> > vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
> >
> > Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> > Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> > Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> > Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
> > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> > ---
> > Changes since v9
> > - the early return from the syscall when len is zero now checks if the
> >   filesystem is implemented, returning -EOPNOTSUPP if it is not and 0
> >   otherwise.  Issue reported by test robot.
> 
> What issue was reported?

Here's the link to my previous email:

https://lore.kernel.org/linux-fsdevel/877dk1zibo.fsf@suse.de/

... which reminds me that I need to also send a patch to fix the fstest.
(Although the test as-is actually allowed to find this bug...)

Cheers,
--
Luís
