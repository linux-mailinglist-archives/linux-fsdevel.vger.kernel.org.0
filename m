Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09793DD018
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 07:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhHBFlN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 01:41:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52584 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhHBFlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 01:41:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E28C1FF22;
        Mon,  2 Aug 2021 05:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627882862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0eTCphXb+i+pysVmk1KQqkDmYKKDI8E5qVhYYeFRng8=;
        b=1TyMojseb7Ug7vlLlk69fqN/1zgOu2uM934P5/wVKNsaS2xwBNk0FRJ4lOklpDz9ljE9LX
        o9Bqyala1XtFdXu74tiX7cZY9UamvWMxoM0/nOEmEyiuh3yTjyDVSBRjLC46KRIuDbQht5
        //sz2tN1XqtNeSUIELzqRqgMC0wIY0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627882862;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0eTCphXb+i+pysVmk1KQqkDmYKKDI8E5qVhYYeFRng8=;
        b=H/vqUfbHtAsRjfVpG4VqcMpUc1kZfh2qZpRMfJGpDuQE/ovF0qeF46pwYfTYjrcneHZEbH
        0YDdntDUgPtOm9Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 563E613A09;
        Mon,  2 Aug 2021 05:40:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Qa6FBWuFB2HxdwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 02 Aug 2021 05:40:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Al Viro" <viro@zeniv.linux.org.uk>
Cc:     "Miklos Szeredi" <miklos@szeredi.hu>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        "Linux NFS list" <linux-nfs@vger.kernel.org>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: A Third perspective on BTRFS nfsd subvol dev/inode number issues.
In-reply-to: <YQeB3ASDyO0wSgL4@zeniv-ca.linux.org.uk>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162742546548.32498.10889023150565429936.stgit@noble.brown>,
 <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk>,
 <162762290067.21659.4783063641244045179@noble.neil.brown.name>,
 <CAJfpegsR1qvWAKNmdjLfOewUeQy-b6YBK4pcHf7JBExAqqUvvg@mail.gmail.com>,
 <162762562934.21659.18227858730706293633@noble.neil.brown.name>,
 <CAJfpegtu3NKW9m2jepRrXe4UTuD6_3k0Y6TcCBLSQH7SSC90BA@mail.gmail.com>,
 <162763043341.21659.15645923585962859662@noble.neil.brown.name>,
 <CAJfpegub4oBZCBXFQqc8J-zUiSW+KaYZLjZaeVm_cGzNVpxj+A@mail.gmail.com>,
 <162787790940.32159.14588617595952736785@noble.neil.brown.name>,
 <YQeB3ASDyO0wSgL4@zeniv-ca.linux.org.uk>
Date:   Mon, 02 Aug 2021 15:40:56 +1000
Message-id: <162788285645.32159.12666247391785546590@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 02 Aug 2021, Al Viro wrote:
> On Mon, Aug 02, 2021 at 02:18:29PM +1000, NeilBrown wrote:
> 
> > It think we need to bite-the-bullet and decide that 64bits is not
> > enough, and in fact no number of bits will ever be enough.  overlayfs
> > makes this clear.
> 
> Sure - let's go for broke and use XML.  Oh, wait - it's 8 months too
> early...
> 
> > So I think we need to strongly encourage user-space to start using
> > name_to_handle_at() whenever there is a need to test if two things are
> > the same.
> 
> ... and forgetting the inconvenient facts, such as that two different
> fhandles may correspond to the same object.

Can they?  They certainly can if the "connectable" flag is passed.
name_to_handle_at() cannot set that flag.
nfsd can, so using name_to_handle_at() on an NFS filesystem isn't quite
perfect.  However it is the best that can be done over NFS.

Or is there some other situation where two different filehandles can be
reported for the same inode?

Do you have a better suggestion?

NeilBrown
