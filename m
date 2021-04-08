Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0BB3589B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 18:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhDHQ1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 12:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231480AbhDHQ1Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:27:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64D27610F8;
        Thu,  8 Apr 2021 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617899233;
        bh=c2RcE5/L2t/+QXFcl7ZNTBXkBUqwLLtx+mpVvClyUoY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YaALznKzznpguScASsp4/QVt62nbZ3gRjai2mMuLY4No6pL4wcDQQyaLe5Z649a28
         3JA/Qox20LUSK2kAQDYibyOY5JFRCujUzEq5u7WEU1hsTsgVkEizkYW0jIHVIIyWeq
         d2ONGm8d2Z7CWoH0uWkQNuMCNKx+oJmBV2EpigiPr1Hhagro3JoixM6wHYaEwt/qJ4
         6s5XG40wtu2WEoUX/f969buibeaMXxFD8m3G5+Hdtf/4u2suSjAQZPUEadPdBj4Fde
         k4q9ZLFuPzIVJPfede74SqNRskyM0nlGtbJ2on8BNd7pa7r/gs1KZpHai0P3t4r4t6
         sq/3PRLRQVPFQ==
Message-ID: <c8b1efb9a8d52a88eb906181e8b402d196d1868d.camel@kernel.org>
Subject: Re: [RFC PATCH v5 04/19] fscrypt: add fscrypt_context_for_new_inode
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 08 Apr 2021 12:27:12 -0400
In-Reply-To: <YG5agZ49PSJUtI7C@gmail.com>
References: <20210326173227.96363-1-jlayton@kernel.org>
         <20210326173227.96363-5-jlayton@kernel.org> <YG5agZ49PSJUtI7C@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-04-07 at 18:21 -0700, Eric Biggers wrote:
> On Fri, Mar 26, 2021 at 01:32:12PM -0400, Jeff Layton wrote:
> > CephFS will need to be able to generate a context for a new "prepared"
> > inode. Add a new routine for getting the context out of an in-core
> > inode.
> 
> It would be helpful to briefly mention why fscrypt_set_context() can't be used
> instead (like the other filesystems do).
> 

I'll add this to the changelog as well before the next posting, but
basically, when we send a create request to the MDS, we send along a
full set of attributes, including an xattr blob that includes the
encryption.ctx xattr.

If we used fscrypt_set_context then we'd have to make a separate round
trip to set the xattr on the server for every create. We'd also have a
window of time where the inode exists on the MDS but has no encryption
context attached, which could cause race conditions with other clients.
-- 
Jeff Layton <jlayton@kernel.org>

