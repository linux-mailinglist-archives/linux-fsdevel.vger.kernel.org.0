Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06C814D4BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 19:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfFTRWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 13:22:22 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32922 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726637AbfFTRWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:22:22 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5KHM8mu014348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 13:22:09 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 528DC420484; Thu, 20 Jun 2019 13:22:08 -0400 (EDT)
Date:   Thu, 20 Jun 2019 13:22:08 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ross Zwisler <zwisler@google.com>
Cc:     Jan Kara <jack@suse.cz>, Ross Zwisler <zwisler@chromium.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Fletcher Woodruff <fletcherw@google.com>,
        Justin TerAvest <teravest@google.com>
Subject: Re: [PATCH 2/3] jbd2: introduce jbd2_inode dirty range scoping
Message-ID: <20190620172208.GB4650@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Ross Zwisler <zwisler@google.com>, Jan Kara <jack@suse.cz>,
        Ross Zwisler <zwisler@chromium.org>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Fletcher Woodruff <fletcherw@google.com>,
        Justin TerAvest <teravest@google.com>
References: <20190619172156.105508-1-zwisler@google.com>
 <20190619172156.105508-3-zwisler@google.com>
 <20190620110454.GL13630@quack2.suse.cz>
 <20190620150911.GA4488@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620150911.GA4488@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 20, 2019 at 09:09:11AM -0600, Ross Zwisler wrote:
> We could definitely keep separate dirty ranges for each of the current and
> next transaction.  I think the case where you would see a difference would be
> if you had multiple transactions in a row which grew the dirty range for a
> given jbd2_inode, and then had a random I/O workload which kept dirtying pages
> inside that enlarged dirty range.
> 
> I'm not sure how often this type of workload would be a problem.  For the
> workloads I've been testing which purely append to the inode, having a single
> dirty range per jbd2_inode is sufficient.

My inclination would be to keep things simple for now, unless we have
a real workload that tickles this.  In the long run I'm hoping to
remove the need to do writebacks from the journal thread altogether,
by always updating the metadata blocks *after* the I/O completes,
instead of before we submit the I/O.

					- Ted
