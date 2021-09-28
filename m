Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C194441A5E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 05:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbhI1DNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 23:13:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35268 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238748AbhI1DNX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 23:13:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 95E6C222DF;
        Tue, 28 Sep 2021 03:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632798701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k1irZcE6GgE63UfMaZ69q7wFQxdxy8PkJV1UDRuOwDA=;
        b=Af8PPYiGG/KoV03reINXBzNVPccmiyHVMrwNt2UIFxlU1jhXBp5nI2Gka9opvfla6EYXOa
        u9dubE+5BF4AwBJlVzPfA+nwLlAQkhckDkag+FkKT+kBsnwd6qmqqlWA/pOjn0C1Ffe5V9
        HYSxfFfncwL3S6Y8kijKplmMugjgsEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632798701;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k1irZcE6GgE63UfMaZ69q7wFQxdxy8PkJV1UDRuOwDA=;
        b=rvEM/v30W6HdMnLZksiPaBfoRjZ8iPYI6P23HeASJG7DpSxpqPRoywlWfOvhpMFCEARX9U
        W3t0wcFCENMdaDDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1463132D4;
        Tue, 28 Sep 2021 03:11:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HD3CH+SHUmHafwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 28 Sep 2021 03:11:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "David Howells" <dhowells@redhat.com>
Cc:     willy@infradead.org, hch@lst.de, trond.myklebust@primarydata.com,
        "Theodore Ts'o" <tytso@mit.edu>, linux-block@vger.kernel.org,
        ceph-devel@vger.kernel.org,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Anna Schumaker" <anna.schumaker@netapp.com>, linux-mm@kvack.org,
        "Bob Liu" <bob.liu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "Seth Jennings" <sjenning@linux.vnet.ibm.com>,
        "Jens Axboe" <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-cifs@vger.kernel.org, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Minchan Kim" <minchan@kernel.org>,
        "Steve French" <sfrench@samba.org>,
        "Dan Magenheimer" <dan.magenheimer@oracle.com>,
        linux-nfs@vger.kernel.org, "Ilya Dryomov" <idryomov@gmail.com>,
        linux-btrfs@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v3 0/9] mm: Use DIO for swap and fix NFS swapfiles
In-reply-to: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
Date:   Tue, 28 Sep 2021 13:11:29 +1000
Message-id: <163279868982.18792.10448745714922373194@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 25 Sep 2021, David Howells wrote:
> Whilst trying to make this work, I found that NFS's support for swapfiles
> seems to have been non-functional since Aug 2019 (I think), so the first
> patch fixes that.  Question is: do we actually *want* to keep this
> functionality, given that it seems that no one's tested it with an upstream
> kernel in the last couple of years?

SUSE definitely want to keep this functionality.  We have customers
using it.
I agree it would be good if it was being tested somewhere....

Thanks,
NeilBrown
