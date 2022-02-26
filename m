Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8116C4C534A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 03:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiBZCKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 21:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBZCKo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 21:10:44 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85F824152B;
        Fri, 25 Feb 2022 18:10:10 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 21Q20u42026574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 21:00:56 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1041C15C0038; Fri, 25 Feb 2022 21:00:56 -0500 (EST)
Date:   Fri, 25 Feb 2022 21:00:56 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -v3] ext4: don't BUG if kernel subsystems dirty pages
 without asking ext4 first
Message-ID: <YhmJ2EfZv0TqRX+h@mit.edu>
References: <Yg0m6IjcNmfaSokM@google.com>
 <Yhks88tO3Em/G370@mit.edu>
 <YhlBUCi9O30szf6l@sol.localdomain>
 <YhlFRoJ3OdYMIh44@mit.edu>
 <YhlIvw00Y4MkAgxX@mit.edu>
 <2f9933b3-a574-23e1-e632-72fc29e582cf@nvidia.com>
 <YhlkcYjozFmt3Kl4@mit.edu>
 <303059e6-3a33-99cb-2952-82fe8079fa45@nvidia.com>
 <YhmFFMwvOaMiNBTQ@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhmFFMwvOaMiNBTQ@mit.edu>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 25, 2022 at 08:40:36PM -0500, Theodore Ts'o wrote:
> Well, that makes it process_vm_writev()'s is that it needs to know
> when to call pin_user_file_pages().

Sorry, typed too fast.  What I was trying to say is this make it
process_vm_writev()'s problem to figure out when it should call
pin_user_file_pages() versus some other pin_user_pages function.

> I suspect that for many use cases
> --- for example, if this is being used by a debugger to modify a
> variable on a stack, or an anonymous page in the program's data
> segment, process_vm_writev() *isn't* actually pinning a file.  So they
> want some kind of interface that automatically DTRT regardless of
> whether the user pages being edited are file-backed or not
> file-backed.

					- Ted
