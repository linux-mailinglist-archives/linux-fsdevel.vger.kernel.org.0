Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73D749E046
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 12:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbiA0LIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 06:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbiA0LIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:08:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC5FC061714;
        Thu, 27 Jan 2022 03:08:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B756B821EE;
        Thu, 27 Jan 2022 11:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F1EC340E4;
        Thu, 27 Jan 2022 11:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643281722;
        bh=4OAdEMRzvapE205uztx5+93irJfsV1aOiji4c3kdYJA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mJDPLsE0OMNsBOXjQ9p2OiRuUjvw6mZ2PI/5aKWQyE4yoATHs+6i1a23el5tIMcRK
         fu49UpHK/lVglSgJhMJmZU6IiJSgE4zNJ0SAAyBzArqZq8BPn8qPr+mX3p9UoZ4+fO
         XyNdiWkYKVHCWLWy9yrZeRHcovKmIre9iavUD1chuBzCBxJTPS//ZYMIktWHq/t545
         bggudhhQcBosmSTqD/L4PX8rL31vTKpz4OeJ8WYO6/Tkw3NOAMiIidUBmO1x8i+d5J
         cJZo6gXrYe0zcU+L3Ol43uQssTC45nxb9t6Nha4MlT8i1i10DwXB7wHbCAArgmtQQB
         q57FVg7XyKNDA==
Message-ID: <9777517aececf5d178e555315afc2453ab8dc9b7.camel@kernel.org>
Subject: Re: [RFC PATCH v10 00/48] ceph+fscrypt: full support
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Date:   Thu, 27 Jan 2022 06:08:40 -0500
In-Reply-To: <YfH/8xCAtyCA9raH@sol.localdomain>
References: <20220111191608.88762-1-jlayton@kernel.org>
         <YfH/8xCAtyCA9raH@sol.localdomain>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-01-26 at 18:14 -0800, Eric Biggers wrote:
> On Tue, Jan 11, 2022 at 02:15:20PM -0500, Jeff Layton wrote:
> > Still, I was able to run xfstests on this set yesterday. Bug #2 above
> > prevented all of the tests from passing, but it didn't oops! I call that
> > progress! Given that, I figured this is a good time to post what I have
> > so far.
> 
> One question: what sort of testing are you doing to show that the file contents
> and filenames being stored (i.e., sent by the client to the server in this case)
> have been encrypted correctly?  xfstests has tests that verify this for block
> device based filesystems; are you doing any equivalent testing?
> 

I've been testing this pretty regularly with xfstests, and the filenames
portion all seems to be working correctly. Parts of the content
encryption also seem to work ok. I'm still working that piece, so I
haven't been able to validate that part yet.

At the moment I'm working on switching the ceph client over to doing
sparse reads, which is necessary in order to be able to handle sparse
writes without filling in unwritten holes.
-- 
Jeff Layton <jlayton@kernel.org>
