Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323B53D8871
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 09:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhG1HB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 03:01:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47346 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhG1HBW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 03:01:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CBA57222C2;
        Wed, 28 Jul 2021 07:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627455679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vfKtWzYL5xXiaqOIrst/4AjlFpXV2P7VCCB+Rl25VdM=;
        b=2XMWMKwA5ujV2g4duDlLx1urXnz015ncFd+g/bzlGaGwp3E0wkaCNB1CkvywR4RU/SRp/6
        3ZeGRXag0UNS8AhbOuYFzetobKFNDPN58HXRzIQ0Eqb06Jcj339+18DxmVPALnCW3AFHA7
        dDvSSrrKAzv1eOyPCDiO0oTqJWAhV38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627455679;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vfKtWzYL5xXiaqOIrst/4AjlFpXV2P7VCCB+Rl25VdM=;
        b=laAJHdS5TTLoYJ5xLk6clvHlwoqXRbxNQC6y50j1atA0ZrUIJTJe7rIS6lcX5FNiqUP1s+
        O1JTaN0SRvag+EDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A524A13AC2;
        Wed, 28 Jul 2021 07:01:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iuzAGLwAAWH7TQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 28 Jul 2021 07:01:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Wang Yugui" <wangyugui@e16-tech.com>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
In-reply-to: <20210728140431.D704.409509F4@e16-tech.com>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <20210728125819.6E52.409509F4@e16-tech.com>,
 <20210728140431.D704.409509F4@e16-tech.com>
Date:   Wed, 28 Jul 2021 17:01:10 +1000
Message-id: <162745567084.21659.16797059962461187633@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 28 Jul 2021, Wang Yugui wrote:
> Hi,
> 
> This patchset works well in 5.14-rc3.

Thanks for testing.

> 
> 1, fixed dummy inode(255, BTRFS_FIRST_FREE_OBJECTID - 1 )  is changed to
> dynamic dummy inode(18446744073709551358, or 18446744073709551359, ...)

The BTRFS_FIRST_FREE_OBJECTID-1 was a just a hack, I never wanted it to
be permanent.
The new number is ULONG_MAX - subvol_id (where subvol_id starts at 257 I
think).
This is a bit less of a hack.  It is an easily available number that is
fairly unique.

> 
> 2, btrfs subvol mount info is shown in /proc/mounts, even if nfsd/nfs is
> not used.
> /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test
> /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test/sub1
> /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test/sub2
> 
> This is a visiual feature change for btrfs user.

Hopefully it is an improvement.  But it is certainly a change that needs
to be carefully considered.

Thanks,
NeilBrown
