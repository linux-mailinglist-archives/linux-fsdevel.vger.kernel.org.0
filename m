Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5B73FCCAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 19:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbhHaRzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 13:55:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231668AbhHaRzn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:55:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4C2560698;
        Tue, 31 Aug 2021 17:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630432488;
        bh=oEpJwqrdV/lIvJa+gTlpcXfdeKv39iYaT1s2lla5C/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BcZk2s8RxVGw9gma/FzPPnxrR9FykbO3EwPdWbeIqB4gUNlA5U9OXGK3ro7MU6rN2
         Dd9/TWWb4yl7lksfXcdT5T/tBVqLahAiMyS7ZnByFbaBSiWwuN5nEvvGCZUpaixIzR
         deAWA0UNsk4eCCdqeDXsaL6gxK0UZwnoUarra/+h/6nVi/o09NmPHfeZG50Mp7M/M/
         Bbqq58ygF5HQk83rcZ1HxfrXj3Ky1DTaBWzU6l3zRGF6mkMftWn5Rx6KRPYzdVEQNo
         Rd/harqqlIp7xqwjbvH+0DZP0m/iEp93NO1CvZfg+Sd9Bcgl3+3a5XCHu8w0VfsMPS
         wwWUvslhZPgTQ==
Date:   Tue, 31 Aug 2021 10:54:46 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com, lhenriques@suse.de, khiremat@redhat.com
Subject: Re: [RFC PATCH v8 09/24] ceph: add ability to set fscrypt_auth via
 setattr
Message-ID: <YS5s5mYZtc3r+K/E@sol.localdomain>
References: <20210826162014.73464-1-jlayton@kernel.org>
 <20210826162014.73464-10-jlayton@kernel.org>
 <27f6a038-94a6-ec58-c7a5-0fafc2c9d779@redhat.com>
 <e92545e2d652179dd5d72f953ef58398c41a4abf.camel@kernel.org>
 <60291569-aace-cc83-88de-3de24cefb750@redhat.com>
 <7f231e95bd397394eba44c3e346524bac44a069b.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f231e95bd397394eba44c3e346524bac44a069b.camel@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 31, 2021 at 09:50:32AM -0400, Jeff Layton wrote:
> > > > > +		/* It should never be re-set once set */
> > > > > +		WARN_ON_ONCE(ci->fscrypt_auth);
> > > > > +
> > > > Maybe this should return -EEXIST if already set ?
> > > > 
> > > I don't know. In general, once the context is set on an inode, we
> > > shouldn't ever reset it. That said, I think we might need to allow
> > > admins to override an existing context if it's corrupted.
> > > 
> > > So, that's the rationale for the WARN_ON_ONCE. The admins should never
> > > do this under normal circumstances but they do have the ability to
> > > change it if needed (and we'll see a warning in the logs in that case).
> > 
> > I may miss some code in the fs/crypto/ layer.
> > 
> > I readed that once the directory/file has set the policy context, it 
> > will just return 0 if the new one matches the existence, if not match it 
> > will return -EEXIST, or will try to call ceph layer to set it.
> > 
> > So once this is set, my understanding is that it shouldn't be here ?
> > 
> 
> Where did you read that? If we have documented semantics we need to
> follow here, then we should change it to comply with them.
> 

That is how FS_IOC_SET_ENCRYPTION_POLICY behaves, but the check for an existing
policy already happens in fscrypt_ioctl_set_policy(), so ->set_context doesn't
need to worry about it.

- Eric
