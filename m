Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FC2682C90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 13:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjAaM3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 07:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjAaM3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:29:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F9F41B4D;
        Tue, 31 Jan 2023 04:28:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A81392286E;
        Tue, 31 Jan 2023 12:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675168138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QrUTypHAUkttp02W8QWkJo6LCDLcL4N0tatTKmlKOb4=;
        b=BbEYZvUHh89Z25teFMQ0r/TfosK1ThRsmIu/YY2SctXBa9Kp5p5jjwksyuk2UMUCiBJ+dK
        lghQBQhfxfwzAjpE8QFk4x1emnlXZVs4crH0N/ROg9CCi3GAFr9geXt6BTJ/z72hadrcFf
        HmqLSUCpiUXh0+BSsVKtFw2NVMJF2GY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675168138;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QrUTypHAUkttp02W8QWkJo6LCDLcL4N0tatTKmlKOb4=;
        b=2nXCGND8EePAPt/o97fnU+FUtqWIiulOdD5y7vCfu8d4v3XuYD6gOTsHb1HMKtmKtu/oCt
        FKRSgmmuOnYKurDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A48713585;
        Tue, 31 Jan 2023 12:28:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w4SdJYoJ2WMpDAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 31 Jan 2023 12:28:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CD1AFA06D5; Tue, 31 Jan 2023 13:28:57 +0100 (CET)
Date:   Tue, 31 Jan 2023 13:28:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jeff Layton <jlayton@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] iov_iter: Improve page extraction (pin or just list)
Message-ID: <20230131122857.6tchetnsgepl3ck3@quack3>
References: <e68c5cab-c3a6-1872-98fa-9f909f23be79@nvidia.com>
 <3351099.1675077249@warthog.procyon.org.uk>
 <fd0003a0-a133-3daf-891c-ba7deafad768@kernel.dk>
 <f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk>
 <e8480b18-08af-d101-a721-50d213893492@kernel.dk>
 <3520518.1675116740@warthog.procyon.org.uk>
 <f392399b-a4c4-2251-e12b-e89fff351c4d@kernel.dk>
 <040ed7a7-3f4d-dab7-5a49-1cd9933c5445@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <040ed7a7-3f4d-dab7-5a49-1cd9933c5445@redhat.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 31-01-23 09:32:27, David Hildenbrand wrote:
> On 30.01.23 23:15, Jens Axboe wrote:
> > On 1/30/23 3:12 PM, David Howells wrote:
> > > John Hubbard <jhubbard@nvidia.com> wrote:
> > > 
> > > > This is something that we say when adding pin_user_pages_fast(),
> > > > yes. I doubt that I can quickly find the email thread, but we
> > > > measured it and weren't immediately able to come up with a way
> > > > to make it faster.
> > > 
> > > percpu counters maybe - add them up at the point of viewing?
> > 
> > They are percpu, see my last email. But for every 108 changes (on
> > my system), they will do two atomic_long_adds(). So not very
> > useful for anything but low frequency modifications.
> > 
> 
> Can we just treat the whole acquired/released accounting as a debug
> mechanism to detect missing releases and do it only for debug kernels?

Yes, AFAIK it is just a debug mechanism for helping to find out issues with
page pinning conversions. So I think we can put this behind some debugging
ifdef. John?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
