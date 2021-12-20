Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A58D47B0D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 17:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhLTQFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 11:05:38 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46208 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhLTQFi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:05:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 44B17210EF;
        Mon, 20 Dec 2021 16:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640016337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7AYQ1SxXlfi2J0tC2ZIpPKOG8jwxcEvqYVzFGiQuzI=;
        b=Bn3fKWW4pgu+4t/q1EdCR2loaiGlL82Vp3jrbwbrSJQVe1bKgoGQieg9BNVBoI4qx+2ziT
        PM9pia4BRCYkyJtUDEXF4s7IBmZBW99ai6kgrx2EYddEDolPlOm68Gqnxd58+rCQjMZ3MT
        IEKxIWcjjyG7qqksrt9veTonV5YHsgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640016337;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7AYQ1SxXlfi2J0tC2ZIpPKOG8jwxcEvqYVzFGiQuzI=;
        b=XZorGToxNbRXs3UKbvADVpt0DFAuxeg3Nm0kewB00UfxVeyxS7fCehDuhXJSIZdFN8Wdmw
        GNZTQIlU2tD6dVDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23DEE13D6B;
        Mon, 20 Dec 2021 16:05:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 41KVB9GpwGFWSwAAMHmgww
        (envelope-from <ddiss@suse.de>); Mon, 20 Dec 2021 16:05:37 +0000
Date:   Mon, 20 Dec 2021 17:05:36 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.com>, viro@zeniv.linux.org.uk,
        willy@infradead.org
Subject: Re: initramfs: "crc" cpio format and INITRAMFS_PRESERVE_MTIME
Message-ID: <20211220170536.7d0b7b28@suse.de>
In-Reply-To: <20211213232007.26851-1-ddiss@suse.de>
References: <20211213232007.26851-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 14 Dec 2021 00:20:03 +0100, David Disseldorp wrote:

> This patchset does some minor initramfs refactoring and allows cpio
> entry mtime preservation to be disabled via a new Kconfig
> INITRAMFS_PRESERVE_MTIME option.
> Patches 3/5 to 5/5 implement support for creation and extraction of
> "crc" cpio archives, which carry file data checksums. Basic tests for
> this functionality can be found at
> Link: https://github.com/rapido-linux/rapido/pull/163
> 
> Changes since v4, following feedback from Matthew Wilcox:
> - implement cpio "crc" archive creation and extraction
> - add patch to fix gen_init_cpio short read handling
> - drop now-unnecessary "crc" documentation and error msg changes

Ping, any feedback on this round?

Thanks, David

> Changes since v3, following feedback from Martin Wilck:
> - 4/4: keep vfs_utimes() call in do_copy() path
>   + drop [PATCH v3 4/5] initramfs: use do_utime() wrapper consistently
>   + add do_utime_path() helper
>   + clean up timespec64 initialisation
> - 4/4: move all mtime preservation logic to initramfs_mtime.h and drop
>   separate .c
> - 4/4: improve commit message
> 
> 
>  init/Kconfig           | 10 +++++
>  init/initramfs.c       | 89 +++++++++++++++-------------------------
>  init/initramfs_mtime.h | 50 +++++++++++++++++++++++
>  usr/gen_init_cpio.c    | 92 ++++++++++++++++++++++++++++++------------
>  4 files changed, 159 insertions(+), 82 deletions(-)
