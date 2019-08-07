Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11AA4842B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 04:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfHGC6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 22:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfHGC6R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 22:58:17 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF1E216F4;
        Wed,  7 Aug 2019 02:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565146696;
        bh=OPOWWv3mB9DdFvmoTfWyNb6+ibWx2Cp4rvzwe+QrP9Q=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=dAMu82L1H4gYf7vcB3Oepw/fLNMFjH/D8hsdYAwj07TBSuID1R+955J5MHqmTlh9Q
         I2zKNtguWEetSnJxJNuI5INcBJ23ypyNW0Ash7Cfi2QbfmLBi1B1Ylvb0NV1I/DY8u
         DlIuhqxyixoi2IHKGM01Sj7kNZQ0H8fdJHV5B0LM=
Date:   Tue, 6 Aug 2019 19:58:14 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KEYS: Replace uid/gid/perm permissions checking with
 an ACL
Message-ID: <20190807025814.GA1167@sol.localdomain>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <155862710003.24863.11807972177275927370.stgit@warthog.procyon.org.uk>
 <155862710731.24863.14013725058582750710.stgit@warthog.procyon.org.uk>
 <20190710011559.GA7973@sol.localdomain>
 <20190730034956.GB1966@sol.localdomain>
 <20190731011614.GA687@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731011614.GA687@sol.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 30, 2019 at 06:16:14PM -0700, Eric Biggers wrote:
> On Mon, Jul 29, 2019 at 08:49:56PM -0700, Eric Biggers wrote:
> > Hi David,
> > 
> > On Tue, Jul 09, 2019 at 06:16:01PM -0700, Eric Biggers wrote:
> > > On Thu, May 23, 2019 at 04:58:27PM +0100, David Howells wrote:
> > > > Replace the uid/gid/perm permissions checking on a key with an ACL to allow
> > > > the SETATTR and SEARCH permissions to be split.  This will also allow a
> > > > greater range of subjects to represented.
> > > > 
> > > 
> > > This patch broke 'keyctl new_session', and hence broke all the fscrypt tests:
> > > 
> > > $ keyctl new_session
> > > keyctl_session_to_parent: Permission denied
> > > 
> > > Output of 'keyctl show' is
> > > 
> > > $ keyctl show
> > > Session Keyring
> > >  605894913 --alswrv      0     0  keyring: _ses
> > >  189223103 ----s-rv      0     0   \_ user: invocation_id
> > > 
> > > - Eric
> > 
> > This bug is still present in next-20190729.
> > 
> > - Eric
> 
> This fixes it:
> 
> diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
> index aa3bfcadbc660..519c94f1cc3c2 100644
> --- a/security/keys/process_keys.c
> +++ b/security/keys/process_keys.c
> @@ -58,7 +58,7 @@ static struct key_acl session_keyring_acl = {
>  	.possessor_viewable = true,
>  	.nr_ace	= 2,
>  	.aces = {
> -		KEY_POSSESSOR_ACE(KEY_ACE__PERMS & ~KEY_ACE_JOIN),
> +		KEY_POSSESSOR_ACE(KEY_ACE__PERMS),
>  		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ),
>  	}
>  };
> 
> 
> The old permissions were KEY_POS_ALL | KEY_USR_VIEW | KEY_USR_READ, so
> I'm not sure why JOIN permission was removed?
> 
> - Eric

Ping.  This is still broken in linux-next.

- Eric
