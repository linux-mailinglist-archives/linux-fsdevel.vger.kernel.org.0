Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640FD4A0228
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 21:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351222AbiA1UkF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 15:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351218AbiA1Uj4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:39:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60243C061756;
        Fri, 28 Jan 2022 12:39:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C21A3CE275B;
        Fri, 28 Jan 2022 20:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5CEC36AF2;
        Fri, 28 Jan 2022 20:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643402391;
        bh=mx4sBLSf1WrbamZ5+mfAkPh51VnD1NLOVjvx+CC92e0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LmAlza0Xk4OOevkhoZ5j6scQQylr2PszXxeevCclwbvsnowbCmptlC0VTvOsDAoW4
         eoAqUlL9Zhy5JkluKQ5OVAsXj+/P+ySe5R/honCf8ABB+XxVXm62Zg752bSldF7F8T
         xlrVbDR0LQEC+PcBiBcuvrzEqsgI9E2t8RyNBrYZcTx2bDquSrqUdv0wu0bGkJhkKq
         aqmXPFBAAJkUP5vteydi+ZtUE5H52ZRY7W0T9FS39Q4VFnQiusSDTGVzRjFmlLyPa3
         3ul1ffAom9IAhH9oez9Jq5dCL0wiEy3FLFHRi5mqoPtkYWrAG79agf7DciEN6DK/wV
         xDUS3iPtfdMGQ==
Date:   Fri, 28 Jan 2022 12:39:50 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: Re: [RFC PATCH v10 00/48] ceph+fscrypt: full support
Message-ID: <YfRUlmVHyVBRsFIU@sol.localdomain>
References: <20220111191608.88762-1-jlayton@kernel.org>
 <YfH/8xCAtyCA9raH@sol.localdomain>
 <9777517aececf5d178e555315afc2453ab8dc9b7.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9777517aececf5d178e555315afc2453ab8dc9b7.camel@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 06:08:40AM -0500, Jeff Layton wrote:
> On Wed, 2022-01-26 at 18:14 -0800, Eric Biggers wrote:
> > On Tue, Jan 11, 2022 at 02:15:20PM -0500, Jeff Layton wrote:
> > > Still, I was able to run xfstests on this set yesterday. Bug #2 above
> > > prevented all of the tests from passing, but it didn't oops! I call that
> > > progress! Given that, I figured this is a good time to post what I have
> > > so far.
> > 
> > One question: what sort of testing are you doing to show that the file contents
> > and filenames being stored (i.e., sent by the client to the server in this case)
> > have been encrypted correctly?  xfstests has tests that verify this for block
> > device based filesystems; are you doing any equivalent testing?
> > 
> 
> I've been testing this pretty regularly with xfstests, and the filenames
> portion all seems to be working correctly. Parts of the content
> encryption also seem to work ok. I'm still working that piece, so I
> haven't been able to validate that part yet.
> 
> At the moment I'm working on switching the ceph client over to doing
> sparse reads, which is necessary in order to be able to handle sparse
> writes without filling in unwritten holes.

To clarify, I'm asking about the correctness of the ciphertext written to
"disk", not about the user-visible filesystem behavior which is something
different (but also super important as well, of course).  xfstests includes both
types of tests.

Grepping for _verify_ciphertext_for_encryption_policy in xfstests will show the
tests that verify the ciphertext written to disk.  I doubt that you're running
those, as they rely on a block device.  So you'll need to write some equivalent
tests.  In a pinch, you could simply check that the ciphertext is random rather
than correct (that would at least show that it's not plaintext) like what
generic/399 does.  But actually verifying its correctness would be ideal to
ensure that nothing went wrong along the way.

- Eric
