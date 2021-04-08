Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78829358999
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 18:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhDHQWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 12:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231875AbhDHQWx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:22:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5591610E8;
        Thu,  8 Apr 2021 16:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617898962;
        bh=EKctjgva3fkQ8KTXwOVXc2B/bBTWEYrb91DgKA0NPX8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=P/mvAuFOds3/CIqal722h8WUf8HUNyQuxR8VnKK/Y742npYLmEPX/Q16wJ1zNNv0B
         BsZ/zuHHvvLrXGeoygf2QC4ICkxtEkZxg7krUgpo5qqyZ9QpRqhRK2WvAbmP8HqCOq
         OtU+X4eX8Ywwfg/RwCQg+O3A2AozCEZ1SOD+rKi2xo1NvGOhGlfwqLYGGxPpj1d7I/
         mqLJ5EllV3NMS696MFyvtSz+ectCBjOLXcREkp2WZgqEzMO2XN4AfqJ8oxx0rwA+So
         HylGYGhSQGotnrGcKP7tRxAdIHxvN/BzqHtoymjvBha97inj019GH0Y+2JX8UTVYz+
         G1f+vu9rRdjMQ==
Message-ID: <9a9643e02d06c199dcb6964aae9d47e4ca124fc7.camel@kernel.org>
Subject: Re: [RFC PATCH v5 02/19] fscrypt: export fscrypt_base64_encode and
 fscrypt_base64_decode
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 08 Apr 2021 12:22:40 -0400
In-Reply-To: <YG5XIg0mGK708iiG@gmail.com>
References: <20210326173227.96363-1-jlayton@kernel.org>
         <20210326173227.96363-3-jlayton@kernel.org> <YG5XIg0mGK708iiG@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-04-07 at 18:06 -0700, Eric Biggers wrote:
> On Fri, Mar 26, 2021 at 01:32:10PM -0400, Jeff Layton wrote:
> > Ceph will need to base64-encode some encrypted filenames, so make
> > these routines, and FSCRYPT_BASE64_CHARS available to modules.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> 
> It would be helpful to have a quick explanation here about *why* ceph has to do
> base64 encoding/decoding itself.
> 

Sure. I'll plan to flesh out the changelogs a bit more before the next
posting.

The basic problem is that we want to use printable filenames for storage
on the MDS, but we don't want to tie the format we use to the fscrypt
nokey name format.

So, we have our own nokey name format that we use that's quite similar
to the one in fscrypt. So similar in fact, that we want to use the same
base64 encoding scheme that fscrypt uses for this -- hence the need to
make these available to modules. 
-- 
Jeff Layton <jlayton@kernel.org>

