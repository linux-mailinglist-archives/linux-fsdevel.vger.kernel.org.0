Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8E83D8618
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 05:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhG1Dcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 23:32:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54990 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbhG1Dcx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 23:32:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A47A92228B;
        Wed, 28 Jul 2021 03:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627443171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v21JoK9/1S7TQfB68cEs/lkY+bZlMeJqk6PE2t/TZD4=;
        b=zDJy0K9BVWRLC5kVq6fsjLTMLCSiaWvOIPzds5uITD7XoiwX/ZXMUua5k60pUfbjKEvpXd
        tQnseJHBB2QiLNBR0w71L07Xzyl/bJCM8tqd+rxFPeI72g+eklWmG9NpjPbUepIUacTMot
        ag7mGelXrhi5cR+d7YjrVj736/F822c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627443171;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v21JoK9/1S7TQfB68cEs/lkY+bZlMeJqk6PE2t/TZD4=;
        b=Sl0mmxM8DOx+JNOjmPW/Whe7OhCYSNY7ywedYcMb4mvgq71e75RQRgJn9UYkuLH3Qegr8k
        g52BmqvQfgiFkPAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B705D13B9A;
        Wed, 28 Jul 2021 03:32:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vrCfHODPAGHLHAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 28 Jul 2021 03:32:48 +0000
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
Subject: Re: [PATCH 05/11] VFS: new function: mount_is_internal()
In-reply-to: <YQC99cfMkbGz3u1q@zeniv-ca.linux.org.uk>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162742546552.32498.14429836898036234922.stgit@noble.brown>,
 <YQC99cfMkbGz3u1q@zeniv-ca.linux.org.uk>
Date:   Wed, 28 Jul 2021 13:32:45 +1000
Message-id: <162744316594.21659.15176398691432709276@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 28 Jul 2021, Al Viro wrote:
> On Wed, Jul 28, 2021 at 08:37:45AM +1000, NeilBrown wrote:
> > This patch introduces the concept of an "internal" mount which is a
> > mount where a filesystem has create the mount itself.
> > 
> > Both the mounted-on-dentry and the mount's root dentry must refer to the
> > same superblock (they may be the same dentry), and the mounted-on dentry
> > must be an automount.
> 
> And what happens if you mount --move it?
> 
> 
If you move the mount, then the mounted-on dentry would not longer be an
automount (....  I assume???...) so it would not longer be
mount_is_internal().

I think that is reasonable.  Whoever moved the mount has now taken over
responsibility for it - it no longer is controlled by the filesystem.
The moving will have removed the mount from the list of auto-expire
mounts, and the mount-trap will now be exposed and can be mounted-on
again.

It would be just like unmounting the automount, and bind-mounting the
same dentry elsewhere.

NeilBrown
