Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C983E0223
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 15:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbhHDNiE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 09:38:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44522 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbhHDNiE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:38:04 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CBEC91FDF1;
        Wed,  4 Aug 2021 13:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628084270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kAOyPfhApQEvYuznvyJ9FA5mKKOF/pnqDMA2tFhz0QM=;
        b=QI3YyHqfmDJGAdQgLFOU+rlhZPyk3YS7dLYnRBSb+B751BIzkRHfZowKoCuN2VcJEqhr7i
        /3ew01zSCO8Gbf0scwI/WkYkM2CZMorCEoth7qVPG4NX7sRhdB61h1ETsaKGFSXnc7zFmB
        a/xsfNqKc9utPqgY+rfk7WXnf5XQWSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628084270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kAOyPfhApQEvYuznvyJ9FA5mKKOF/pnqDMA2tFhz0QM=;
        b=V3EG5c72wjKqApkkkYjmPcIo2GiCxgGiOeL12dG1KvMZYgpMAaCVMhZQ0yOHFyWZNAUSDH
        nVK5N3hbGXkl2UBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A26C513942;
        Wed,  4 Aug 2021 13:37:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id mkY1Ji6YCmEPQAAAGKfGzw
        (envelope-from <ddiss@suse.de>); Wed, 04 Aug 2021 13:37:50 +0000
Date:   Wed, 4 Aug 2021 15:37:49 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RESEND 1/3] initramfs: move unnecessary memcmp from hot
 path
Message-ID: <20210804153749.5bb69afd@suse.de>
In-Reply-To: <YQqOrCw29ff7zJHb@zeniv-ca.linux.org.uk>
References: <20210721115153.28620-1-ddiss@suse.de>
        <20210804113129.60848be6@suse.de>
        <YQqOrCw29ff7zJHb@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 4 Aug 2021 12:57:16 +0000, Al Viro wrote:

> On Wed, Aug 04, 2021 at 11:31:29AM +0200, David Disseldorp wrote:
> > Ping, any feedback on this change?
> > 
> > I think it's a no brainer, but for kicks I ran a few unrealistic micro
> > benchmarks on my laptop. Extraction time for a cpio image with 1M+
> > directories improved by 5ms (pre: 14.614s, post: 14.609s), when averaged
> > across 20 runs of:
> >   qemu-system-x86_64 -machine accel=kvm -smp cpus=1 -m 10240 \
> >         -kernel ~/linux/arch/x86/boot/bzImage \
> >         -initrd ./initrds/gen_cpio.out \
> >         -append "initramfs_async=0 console=ttyS0 panic=0" -nographic \
> >         | awk '/Trying to unpack rootfs/ {start_ts = $2};
> >                /Freeing initrd memory/ {end_ts = $2}
> >                END {printf "%f\n", end_ts - start_ts}'  
> 
> What was the dispersion for those runs?

Too high for the 5ms to be considered statistically significant. Std
deviations were pre: 171ms, post: 214ms... <sigh> I'll redo this on a
proper test rig.

Cheers, David
