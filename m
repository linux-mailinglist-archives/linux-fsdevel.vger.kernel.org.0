Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DE93D9A2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 02:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhG2Anh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 20:43:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37822 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbhG2Anf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 20:43:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D57D9201C9;
        Thu, 29 Jul 2021 00:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627519409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9FTxaVEoSr+Xax9oo8ainK5PQyM3hdeesRBkvIyazV4=;
        b=W9wlJWXzPR+NSH1Nlf6q1itAzldXvOmGDkR5jNm/RGZTHOobLrplYXH3plCNOkhZYK8ueT
        7IjlWyTvkjD3pg2Z5pdoE5ieVlsjQMA481XiRuDVRgwyMLtHoi/XqTrmYC/RmAgt9SAFj4
        VVJKKVWHTjsuWDpNPjNABwCJttMofHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627519409;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9FTxaVEoSr+Xax9oo8ainK5PQyM3hdeesRBkvIyazV4=;
        b=EVvHY4aO5lhaDw4izAyUO0sTU/eMKgNCQKhuaPDQoXb88K2Dn9kj/sUKLBFs8zziiHQErn
        ooO4YByS5QcKWXDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABEEA13ADC;
        Thu, 29 Jul 2021 00:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dBNrGq75AWHvfgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 29 Jul 2021 00:43:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christian Brauner" <christian.brauner@ubuntu.com>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 11/11] btrfs: use automount to bind-mount all subvol roots.
In-reply-to: <20210728131213.pgu3r4m4ulozrcav@wittgenstein>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162742546558.32498.1901201501617899416.stgit@noble.brown>,
 <20210728131213.pgu3r4m4ulozrcav@wittgenstein>
Date:   Thu, 29 Jul 2021 10:43:23 +1000
Message-id: <162751940386.21659.17682627731630829061@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 28 Jul 2021, Christian Brauner wrote:
> 
> Hey Neil,
> 
> Sorry if this is a stupid question but wouldn't you want to copy the
> mount properties from path->mnt here? Couldn't you otherwise use this to
> e.g. suddenly expose a dentry on a read-only mount as read-write?

There are no stupid questions, and this is a particularly non-stupid
one!

I hadn't considered that, but having examined the code I see that it
is already handled.
The vfsmount that d_automount returns is passed to finish_automount(),
which hands it to do_add_mount() together with the mnt_flags for the
parent vfsmount (plus MNT_SHRINKABLE).
do_add_mount() sets up the mnt_flags of the new vfsmount.
In fact, the d_automount interface has no control of these flags at all.
Whatever it sets will be over-written by do_add_mount.

Thanks,
NeilBrown
