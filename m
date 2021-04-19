Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23265364186
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 14:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbhDSMUc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 08:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239064AbhDSMUb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 08:20:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38A876127C;
        Mon, 19 Apr 2021 12:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618834801;
        bh=6dFTzw0YPPj0AEVakg891A3LMDTE0IT2e8OLiGHDFGw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=btHoke80zy1qRw3AMGAqF3oPz5aqOxTcxpvLkmWpXLKJzVf29reMiUjEyr7+Luba8
         ZsZkdwi2dnmoSUFiI/IWU+dAC2MUFRU/zQUxwjD3E+4ZhuDGpNwFCFYx8KF8H9k0uy
         g2T/7TEForE9n0re6HsR4qhr1HewrNFwrgjd1YHhxuyuCQ8nVlfueZnGg0lED/50cy
         mgirmHnUxbf9ZGjFo7N34xzE6jvjdzksLlhQazdg2XQvtLE83Pv+lZfUG6uNa3nyLs
         rrNS6EkDjsh1I6wt38S+ZLovlnRk4bYb4gXfVqQALijTBj3VoWNjhG/4+2xbxvEvF6
         ZbqotnHaX+Wag==
Message-ID: <f6fa8d02d31099a688ae97450143aa0eed4b73f8.camel@kernel.org>
Subject: Re: [RFC PATCH v6 20/20] ceph: add fscrypt ioctls
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Date:   Mon, 19 Apr 2021 08:19:59 -0400
In-Reply-To: <87lf9emvqv.fsf@suse.de>
References: <20210413175052.163865-1-jlayton@kernel.org>
         <20210413175052.163865-21-jlayton@kernel.org> <87lf9emvqv.fsf@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-04-19 at 11:09 +0100, Luis Henriques wrote:
> Hi Jeff!
> 
> Jeff Layton <jlayton@kernel.org> writes:
> <...>
> > +
> > +	case FS_IOC_ADD_ENCRYPTION_KEY:
> > +		ret = vet_mds_for_fscrypt(file);
> > +		if (ret)
> > +			return ret;
> > +		atomic_inc(&ci->i_shared_gen);
> 
> After spending some (well... a lot, actually) time looking at the MDS code
> to try to figure out my bug, I'm back at this point in the kernel client
> code.  I understand that this code is trying to invalidate the directory
> dentries here.  However, I just found that the directory we get at this
> point is the filesystem root directory, and not the directory we're trying
> to unlock.
> 
> So, I still don't fully understand the issue I'm seeing, but I believe the
> code above is assuming 'ci' is the inode being unlocked, which isn't
> correct.
> 
> (Note: I haven't checked if there are other ioctls getting the FS root.)
> 
> Cheers,


Oh, interesting. That was my assumption. I'll have to take a look more
closely at what effect that might have then.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

