Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D984D3AB8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 21:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbiCIUCH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 15:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiCIUCG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:02:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF54B39B;
        Wed,  9 Mar 2022 12:01:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8989961978;
        Wed,  9 Mar 2022 19:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47679C340EC;
        Wed,  9 Mar 2022 19:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646855215;
        bh=dtsgPPBOF4aKczoSHHusq0zXiGSQrjZKnGswyuM+XJE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MFEq8OQOCv7mjY36/BZPDOg/6xDn+q4ZCsq+GEWtvmnAi594FNAO6of8LjsCMztt9
         57A7cOSy3CmT85vAUV/B+bmymMDuOdmg9cb22Y/sFXJVT89FykAjJCcA5EA3lFp9sc
         AGbCiBTUQs/6tIlx2bRi7dmWAFoiNUxHAziXlP3VwiitMTrD7yabK+82+UQdwp4lYK
         Co18p/9jk8YY2IJsInOgeVJ6I4QnnwQuAWGMbTis2ffwKDj1RLdrebL9T3xU9fkGy3
         XJGkLC48xuoVGZoyAjbn7ZXG+lyDVzoBwpdrd5+nGQSEEhx3HN4QjeQ/tVTcEOl9pG
         8SGi3EsPtc6Bw==
Message-ID: <beaf4f6a6c2575ed489adb14b257253c868f9a5c.camel@kernel.org>
Subject: Re: [PATCH v2 12/19] netfs: Add a netfs inode context
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 09 Mar 2022 14:46:52 -0500
In-Reply-To: <1790300.1646853782@warthog.procyon.org.uk>
References: <8af0d47f17d89c06bbf602496dd845f2b0bf25b3.camel@kernel.org>
         <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
         <164678213320.1200972.16807551936267647470.stgit@warthog.procyon.org.uk>
         <1790300.1646853782@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-03-09 at 19:23 +0000, David Howells wrote:
> Jeff Layton <jlayton@kernel.org> wrote:
> 
> > > Add a netfs_i_context struct that should be included in the network
> > > filesystem's own inode struct wrapper, directly after the VFS's inode
> > > struct, e.g.:
> > > 
> > > 	struct my_inode {
> > > 		struct {
> > > 			struct inode		vfs_inode;
> > > 			struct netfs_i_context	netfs_ctx;
> > > 		};
> > 
> > This seems a bit klunky.
> > 
> > I think it'd be better encapsulation to give this struct a name (e.g.
> > netfs_inode) and then have the filesystems replace the embedded
> > vfs_inode with a netfs_inode.
> 
> I think what you really want is:
> 
> 	struct my_inode : netfs_inode {
> 	};
> 
> right? ;-)
> 

Sort of, I guess.  The natural way to enforce the requirement that the
inode and context be ordered and adjacent like that is to make a struct
that embeds them both.

My thinking was that someone at some point will try to move things
around if they're just adjacent like this rather than an encapsulated
"object".

If we go this route, then please leave some comments in each filesystem
warning people off from breaking them up.

> > That way it's still just pointer math to get to the context from the
> > inode and vice versa, but the replacement seems a bit cleaner.
> > 
> > It might mean a bit more churn in the filesystems themselves as you
> > convert them, but most of them use macros or inline functions as
> > accessors so it shouldn't be _too_ bad.
> 
> That's a lot of churn - and will definitely cause conflicts with other
> patches aimed at those filesystems.  I'd prefer to avoid that if I can.
> 

Good point. Looks like around 200 or so places that would need to change
in the affected filesystems.

> > > +static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
> > > +{
> > > ...
> > > +}
> > > +
> > 
> > ^^^
> > The above change seems like it should be in its own patch. Wasn't it at
> > one point? Converting this to use init_request doesn't seem to rely on
> > the new embedded context.
> 
> Well, I wrote it as a separate patch on the end for convenience, but I
> intended to merge it here otherwise ceph wouldn't be able to do readahead for
> a few patches.
> 
> I was thinking that it would require the context change to work and certainly
> it requires the error-return-from-init_request patch to work, but actually it
> probably doesn't require the former so I could probably separate that bit out
> and put it between 11 and 12.
> 

Ok.

-- 
Jeff Layton <jlayton@kernel.org>
