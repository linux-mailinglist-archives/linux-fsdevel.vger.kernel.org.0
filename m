Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC31415910
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 09:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239657AbhIWHfX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 03:35:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41410 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239619AbhIWHfX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 03:35:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EAC141FF99;
        Thu, 23 Sep 2021 07:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632382430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Sbn7YR9SykosbSTKVmFFR2FGsS1RV5j8ZzZUQEA6iE=;
        b=FDwnZhDaOgxULbD//txskn186j93Eu3Md/FxScIUSWpLVcdGKKIuW6x02Uq660oI29+6ci
        TkYk7Sv9thSgg6o+z6ySLk2siAv28y4tpG4WvbclDD+FpfC4DKpE7l3wa9siuBrGSoll1q
        HGJS7M6etuRG5Hc1pzK4ElTzG40aDhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632382430;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Sbn7YR9SykosbSTKVmFFR2FGsS1RV5j8ZzZUQEA6iE=;
        b=IeqBIi7nrpd8l2N4LEn23QlQ0O5LRU2My1b9D8KrFws3/SE15oT1geU5VWEFHTaQLKrOLA
        E0N63tsHg6Zl80Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C033413DC6;
        Thu, 23 Sep 2021 07:33:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ce9fLd4tTGEEfwAAMHmgww
        (envelope-from <ddiss@suse.de>); Thu, 23 Sep 2021 07:33:50 +0000
Date:   Thu, 23 Sep 2021 09:33:23 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH 1/5] initramfs: move unnecessary memcmp from hot path
Message-ID: <20210923093323.5632a534@suse.de>
In-Reply-To: <YUu91kH8kOcVHxyb@zeniv-ca.linux.org.uk>
References: <20210922115222.8987-1-ddiss@suse.de>
        <YUu91kH8kOcVHxyb@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 22 Sep 2021 23:35:50 +0000, Al Viro wrote:

> On Wed, Sep 22, 2021 at 01:52:18PM +0200, David Disseldorp wrote:
> > do_header() is called for each cpio entry and first checks for "newc"
> > magic before parsing further. The magic check includes a special case
> > error message if POSIX.1 ASCII (cpio -H odc) magic is detected. This
> > special case POSIX.1 check needn't be done in the hot path, so move it
> > under the non-newc-magic error path.  
> 
> You keep refering to hot paths; do you have any data to support that
> assertion?

The code-path is run for every single initramfs entry on every single
boot. Calling that "hot" is reasonable IMO.

> How much does that series buy you on average, and what kind of dispersion
> do you get before and after it?

I withdrew the perf claims for this patch after you rightly pointed out
that my previous numbers weren't statistically significant. After doing
further checks I noticed that there was more to be gained via the
INITRAMFS_PRESERVE_MTIME changes. Numbers for extraction performance
with and without mtime preservation can be found in [PATCH 5/5] of this
series.

> I'm not saying I hate the patches themselves, but those references in commit
> messages ping my BS detectors every time I see them ;-/

I'll try harder to strip anything that might be considered buzzwordy in
future, sorry.

Cheers, David
