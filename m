Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE9651C3D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 17:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381296AbiEEP2Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 11:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiEEP2T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 11:28:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA11B5640D;
        Thu,  5 May 2022 08:24:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A093219B6;
        Thu,  5 May 2022 15:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651764278;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ikpy0dSS+3EVVy0wVjYXAzQkjilDieF8GRhTA77TpNQ=;
        b=vneKI9HiDoSrofTHOElTJ3lhxDwfjAUTr7JFjO913rQTUipNQDZrFo/J1IopCGooJX+Pfb
        SRHhZStVC0KwEfYla6OFo1qVBjIOBf0tChhwKML5JHMV1DEWdfDHWeDASt/iKEnY1irLzu
        j3Gu/KsEff3Z6PmePParX/1bB22IO54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651764278;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ikpy0dSS+3EVVy0wVjYXAzQkjilDieF8GRhTA77TpNQ=;
        b=NIZZmJX005Arg1Nw1b6klJ4CYcFXIQzHyJAgh7kZX3MPM2tZOTdfQfZvIDa7QPNZcdze06
        pB2u6Lnzkxmg+ODQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3843A13B11;
        Thu,  5 May 2022 15:24:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dgfQDDbsc2LRTgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 05 May 2022 15:24:38 +0000
Date:   Thu, 5 May 2022 17:20:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nikolay Borisov <nborisov@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: allocate the btrfs_dio_private as part of the
 iomap dio bio
Message-ID: <20220505152026.GV18596@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Nikolay Borisov <nborisov@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220504162342.573651-1-hch@lst.de>
 <20220504162342.573651-6-hch@lst.de>
 <c0335baa-3df5-5523-3537-6c419ace9f82@suse.com>
 <20220505150717.GB19810@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505150717.GB19810@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 05, 2022 at 05:07:17PM +0200, Christoph Hellwig wrote:
> On Thu, May 05, 2022 at 11:12:45AM +0300, Nikolay Borisov wrote:
> > nit: You are actually removing this member when copying the struct, that's 
> > an independent change (albeit I'd say insignificant). Generally we prefer 
> > such changes to be in separate patches with rationale when the given member 
> > became redundant.
> 
> This one actually was entirely unused, but yes, this could have been
> split into another patch.

Cleanest would be to do it in a separate patch, but as it's trivial
mentioning it in the changelog would be also sufficient. When code is
moved either within file or to another one it's better to keep it 1:1
besides some trivial renames or formatting. It's easy to overlook a line
missing. For now no need to resend, I'll add a notice to the changelog.
