Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DA2709533
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 12:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjESKjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 06:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjESKjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 06:39:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDF419BA;
        Fri, 19 May 2023 03:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2312D65665;
        Fri, 19 May 2023 10:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355FBC433EF;
        Fri, 19 May 2023 10:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684492625;
        bh=wml5FX+iifwiN9GWfcWZwLOn5yYaW+2EgAm1pGQ4wag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LesqHPpJFvmUzFRNKNrXorR1EYqX2OH4PzpfMnfkwpXBNMAdG0ZQ2/EhXWk4IygXG
         2SChx7zSoJ0YLPAx8NLZvJ6SOzp1REqqg2W4zVp5wbwe7o+dIDPVWUoxCl/qyUoiC6
         Hc8K5v1h61MJ/2+pFTwgJ2RbfpliI2uZCFdccGPMr9bJ2ILACO3fq5ktbLX9Ih9mt7
         borB3WCTF8vBovAIwJK2NJXzqkEsDom9vEZ+pqPWJpam+HPFNvtn25M8aQT5NRfCtp
         AGEEcDIESrx+0PUP4SCR9bC6eWarMtHEgUXfuLLSvsE0ZBK7mZlQH/I+SzX7bqFsFt
         94cgCHIsObdWA==
Date:   Fri, 19 May 2023 12:36:51 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-XFS <linux-xfs@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH v4 4/9] nfsd: ensure we use ctime_peek to grab the
 inode->i_ctime
Message-ID: <20230519-zierde-legieren-e769c19a29cb@brauner>
References: <20230518114742.128950-1-jlayton@kernel.org>
 <20230518114742.128950-5-jlayton@kernel.org>
 <2B6A4DDD-0356-4765-9CED-B22A29767254@oracle.com>
 <b046f7e3c86d1c9dd45e932d3f25785fce921f4a.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b046f7e3c86d1c9dd45e932d3f25785fce921f4a.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 11:31:45AM -0400, Jeff Layton wrote:
> On Thu, 2023-05-18 at 13:43 +0000, Chuck Lever III wrote:
> > 
> > > On May 18, 2023, at 7:47 AM, Jeff Layton <jlayton@kernel.org> wrote:
> > > 
> > > If getattr fails, then nfsd can end up scraping the time values directly
> > > out of the inode for pre and post-op attrs. This may or may not be the
> > > right thing to do, but for now make it at least use ctime_peek in this
> > > situation to ensure that the QUERIED flag is masked.
> > 
> > That code comes from:
> > 
> > commit 39ca1bf624b6b82cc895b0217889eaaf572a7913
> > Author:     Amir Goldstein <amir73il@gmail.com>
> > AuthorDate: Wed Jan 3 17:14:35 2018 +0200
> > Commit:     J. Bruce Fields <bfields@redhat.com>
> > CommitDate: Thu Feb 8 13:40:17 2018 -0500
> > 
> >     nfsd: store stat times in fill_pre_wcc() instead of inode times
> > 
> >     The time values in stat and inode may differ for overlayfs and stat time
> >     values are the correct ones to use. This is also consistent with the fact
> >     that fill_post_wcc() also stores stat time values.
> > 
> >     This means introducing a stat call that could fail, where previously we
> >     were just copying values out of the inode.  To be conservative about
> >     changing behavior, we fall back to copying values out of the inode in
> >     the error case.  It might be better just to clear fh_pre_saved (though
> >     note the BUG_ON in set_change_info).
> > 
> >     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > 
> > I was thinking it might have been added to handle odd corner
> > cases around re-exporting NFS mounts, but that does not seem
> > to be the case.
> > 
> > The fh_getattr() can fail for legitimate reasons -- like the
> > file is in the middle of being deleted or renamed over -- I
> > would think. This code should really deal with that by not
> > adding pre-op attrs, since they are optional.
> > 
> 
> That sounds fine to me. I'll plan to drop this patch from the series and
> I'll send a separate patch to just remove those branches altogether
> (which should DTRT).

I'll wait with reviewing this until you send the next version then.
