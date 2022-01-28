Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300854A0241
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 21:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiA1Urb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 15:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiA1Ura (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:47:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF73C061714;
        Fri, 28 Jan 2022 12:47:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71A5EB826F3;
        Fri, 28 Jan 2022 20:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83708C340E7;
        Fri, 28 Jan 2022 20:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643402847;
        bh=t5PJ9YV5v84c7isAxBxnhJWXutcvV/nCMeJWIUpAVQs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jn6AtxLiT+CNKLVWi1KBrNSbOXJ7mr8FzbgDe0ZfevtrTYTmz8RxNFyVgaVsWdGgz
         D/ihhkxYJufLGVQkzgx5CVMafa2unPprtGSsm/GLQfYL2c4d0MelRI0qJagEaOLqNR
         8GmmPFoX/jbnD8S3jj9c5h5TP9kglLrFzIYMYFaGga06jke+OdHQMD+MYoPqrDKENv
         5pQv27IfPRPT/Hr+sXjuFWJxigEHjbi8JfkKrwDW5F5LaaKA9QZn9uNxfi2rwMzYY2
         UpYChG/L5Z0rLSkjeg4NjnUnLuzh/BfsQa/qJ2WMFdgBRpmQadgLOGlbl/F1Pd4QMr
         Y5+m+PLYdjLvw==
Message-ID: <d16d6d12fb38a6875abe4312c6f9e0dcf6ec5904.camel@kernel.org>
Subject: Re: [RFC PATCH v10 00/48] ceph+fscrypt: full support
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Date:   Fri, 28 Jan 2022 15:47:25 -0500
In-Reply-To: <YfRUlmVHyVBRsFIU@sol.localdomain>
References: <20220111191608.88762-1-jlayton@kernel.org>
         <YfH/8xCAtyCA9raH@sol.localdomain>
         <9777517aececf5d178e555315afc2453ab8dc9b7.camel@kernel.org>
         <YfRUlmVHyVBRsFIU@sol.localdomain>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-01-28 at 12:39 -0800, Eric Biggers wrote:
> On Thu, Jan 27, 2022 at 06:08:40AM -0500, Jeff Layton wrote:
> > On Wed, 2022-01-26 at 18:14 -0800, Eric Biggers wrote:
> > > On Tue, Jan 11, 2022 at 02:15:20PM -0500, Jeff Layton wrote:
> > > > Still, I was able to run xfstests on this set yesterday. Bug #2 above
> > > > prevented all of the tests from passing, but it didn't oops! I call that
> > > > progress! Given that, I figured this is a good time to post what I have
> > > > so far.
> > > 
> > > One question: what sort of testing are you doing to show that the file contents
> > > and filenames being stored (i.e., sent by the client to the server in this case)
> > > have been encrypted correctly?  xfstests has tests that verify this for block
> > > device based filesystems; are you doing any equivalent testing?
> > > 
> > 
> > I've been testing this pretty regularly with xfstests, and the filenames
> > portion all seems to be working correctly. Parts of the content
> > encryption also seem to work ok. I'm still working that piece, so I
> > haven't been able to validate that part yet.
> > 
> > At the moment I'm working on switching the ceph client over to doing
> > sparse reads, which is necessary in order to be able to handle sparse
> > writes without filling in unwritten holes.
> 
> To clarify, I'm asking about the correctness of the ciphertext written to
> "disk", not about the user-visible filesystem behavior which is something
> different (but also super important as well, of course).  xfstests includes both
> types of tests.
> 
> Grepping for _verify_ciphertext_for_encryption_policy in xfstests will show the
> tests that verify the ciphertext written to disk.  I doubt that you're running
> those, as they rely on a block device.  So you'll need to write some equivalent
> tests.  In a pinch, you could simply check that the ciphertext is random rather
> than correct (that would at least show that it's not plaintext) like what
> generic/399 does.  But actually verifying its correctness would be ideal to
> ensure that nothing went wrong along the way.
> 

Got it. Yes, that would be a good thing. I'll have to see what I can do
once I get to the point of a fully-functioning prototype.
-- 
Jeff Layton <jlayton@kernel.org>
