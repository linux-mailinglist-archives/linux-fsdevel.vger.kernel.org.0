Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2B46E1A5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 04:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjDNCcW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 22:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNCcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 22:32:21 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D1E92;
        Thu, 13 Apr 2023 19:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v41fcR0oiGVQ+m9ogk5gxk4uWOF6zrvV/oFE4o7kLkE=; b=B/SRh72hekYLRL/qFgXHNQ3IkA
        8Vo7lPVb84jtfdk3gN9td2/VyuImaXgu1gbpvh6SyStH+v90peg1LWr0A9I9q5JsUMwvUdxTANJzW
        2SLJXoCw+Ciq8oqewUgi5EjISCWUXctsxugkcFvauxUdOL/07n64PqjlpGYC3WX9F5XI88p4yz+4Q
        WFlwxxcXcmYPDT2kmEm2O286behrQd57po4lc+uGMaFl1VY6ZeeAcfQlUIUuZuC9N15DtKEB2m6JY
        VF4CjlKpG1+tOMLL12PNmakESptmOtSbi9K8jDeJai+1c7IcyOZ0oqUn7EqrQhxIPCNqnK0IuHm8U
        kd7/b03g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pn9ER-008p2I-0C;
        Fri, 14 Apr 2023 02:32:11 +0000
Date:   Fri, 14 Apr 2023 03:32:11 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, NeilBrown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: allowing for a completely cached umount(2) pathwalk
Message-ID: <20230414023211.GE3390869@ZenIV>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 13, 2023 at 06:00:42PM -0400, Jeff Layton wrote:

> It describes a situation where there are nested NFS mounts on a client,
> and one of the intermediate mounts ends up being unexported from the
> server. In a situation like this, we end up being unable to pathwalk
> down to the child mount of these unreachable dentries and can't unmount
> anything, even as root.

So umount -l the stuck sucker.  What's the problem with that?

> 2/ disallow ->lookup operations: a umount is about removing an existing
> mount, so the dentries had better already be there.

That changes the semantics; as it is, you need exec permissions on the
entire path...

> Is this a terrible idea? Are there potentially problems with
> containerized setups if we were to do something like this? Are there
> better ways to solve this problem (and others like it)? Maybe this would
> be best done with a new UMOUNT_CACHED flag for umount2()?

We already have lazy umount.  And what will you do to symlinks you run
into along the way?  They *are* traversed; requiring the caller to
canonicalize them will only shift the problem to userland...
