Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5F93D9B2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 03:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhG2Bnb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 21:43:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43194 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbhG2Bnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 21:43:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E029201CA;
        Thu, 29 Jul 2021 01:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627523007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6H6l78+GftseoMpOE6fL+dPAnn9sjxeM4mKvBgWb9as=;
        b=tMKpHdeR/I6K5a7dZlHopFh+8V+SiTrbo6ipmR1NdlwE/r+LbdaDjedcgrUm2i+7OD9kp5
        MEb036qOyvd5Nff/K6vvin3VhFduh2PcVZ/NjgxSKDKY6ilJB3AB3MH+1QiMj8sdNbhprZ
        AmXBnaKQz9Gt70OwP+TNd04jaOdFfpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627523007;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6H6l78+GftseoMpOE6fL+dPAnn9sjxeM4mKvBgWb9as=;
        b=/ksdFLDHIKvesYSHQa/dIYVQVOTUif6f/Q0uC8Yxu4V7crlOJJgbjYruKUD2uQU8QlcwQ8
        sQ07q1NyYwIJ1HAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEF6113481;
        Thu, 29 Jul 2021 01:43:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RLvqJrsHAmEwDQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 29 Jul 2021 01:43:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        "Neal Gompa" <ngompa13@gmail.com>,
        "Wang Yugui" <wangyugui@e16-tech.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
In-reply-to: <20210729012931.GK10170@hungrycats.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <20210728125819.6E52.409509F4@e16-tech.com>,
 <20210728140431.D704.409509F4@e16-tech.com>,
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>,
 <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>,
 <20210728191431.GA3152@fieldses.org>, <20210729012931.GK10170@hungrycats.org>
Date:   Thu, 29 Jul 2021 11:43:21 +1000
Message-id: <162752300106.21659.7482208502904653864@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 29 Jul 2021, Zygo Blaxell wrote:
> 
> I'm looking at a few machines here, and if all the subvols are visible to
> 'df', its output would be somewhere around 3-5 MB.  That's too much--we'd
> have to hack up df to not show the same btrfs twice...as well as every
> monitoring tool that reports free space...which sounds similar to the
> problems we're trying to avoid.

Thanks for providing hard data!! How many of these subvols are actively
used (have a file open) a the same time? Most? About half? Just a few??

Thanks,
NeilBrown
