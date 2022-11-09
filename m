Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9984A622AB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 12:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiKILix (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 06:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKILiw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:38:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDA5D2EE;
        Wed,  9 Nov 2022 03:38:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6E12B21C3A;
        Wed,  9 Nov 2022 11:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667993930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b3H2YfrTeZRMEuaURCpH7PJ90j0TDo0blJ2eSwkjItQ=;
        b=s0Pb0P8w6HVcYu5nwIG461XtzjPvtFA9rIaqzg44lro/BxkZEjJtNHy3JfQVBt1o9n3hIJ
        DBPAwguqKdY9y7LDSm6zV/BsHK0yMu/d6+u2UaTQ9Dtf/1klk2JVN9ABKH+OfeH5Ig8eWr
        yRGWkYvgjhVLriW8FhfPq6bDZCvozCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667993930;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b3H2YfrTeZRMEuaURCpH7PJ90j0TDo0blJ2eSwkjItQ=;
        b=Q7WUbqWXu+ksn1DjRBuT4NdOXsqAzjK9K8L0wao9ypgXo90JE42yFgN0H03cis6jagnTFy
        UStD+Q6ZvT5KARAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A0091331F;
        Wed,  9 Nov 2022 11:38:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hOPuFUqRa2O7QQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 09 Nov 2022 11:38:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E01F4A0704; Wed,  9 Nov 2022 12:38:49 +0100 (CET)
Date:   Wed, 9 Nov 2022 12:38:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Fix the DAX-gup mistake
Message-ID: <20221109113849.p7pwob533ijgrytu@quack3>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
 <20221108162059.2ee440d5244657c4f16bdca0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108162059.2ee440d5244657c4f16bdca0@linux-foundation.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 08-11-22 16:20:59, Andrew Morton wrote:
> All seems to be quiet on this front, so I plan to move this series into
> mm-stable a few days from now.
> 
> We do have this report of dax_holder_notify_failure being unavailable
> with CONFIG_DAX=n:
> https://lkml.kernel.org/r/202210230716.tNv8A5mN-lkp@intel.com but that
> appears to predate this series.

Andrew, there has been v3 some time ago [1] and even that gathered some
non-trivial feedback from Jason so I don't think this is settled...

[1] https://lore.kernel.org/all/166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
