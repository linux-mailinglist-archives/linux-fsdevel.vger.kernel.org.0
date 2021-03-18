Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482FF3400A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 09:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhCRIH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 04:07:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhCRIHs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:07:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB4896186A;
        Thu, 18 Mar 2021 08:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616054868;
        bh=xhFK7pf4ZvBe3zs5vAGSF6YW4d9H8T91UK5ubH1jH6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S107w3Ekc/ywg/vb7Jnf4XXKL93WP8ZHx13XCckoJeancgXzlc5z1Ft2PIOeKpgXq
         bBdsEEYxzqvshJhuGeXWTlvtjnGW46eCudxEDDZcg34hm5XX6Y4Slh+TernhhD3A9e
         gIbE5qW+nrvuzOujQO8NG3H9fpAtv9vPg914vOHU=
Date:   Thu, 18 Mar 2021 09:07:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <YFMKUZ5p1QbqkabY@kroah.com>
References: <20210315174851.622228-1-keescook@chromium.org>
 <YFBs202BqG9uqify@dhcp22.suse.cz>
 <202103161205.B2181BDE38@keescook>
 <YFHxNT1Pwoslmhxq@dhcp22.suse.cz>
 <YFIFY7mj65sStba1@kroah.com>
 <YFIVwPWTo48ITkHs@dhcp22.suse.cz>
 <YFIYrMVTC42boZ/Z@kroah.com>
 <YFIeVLDsfBMa7fHW@dhcp22.suse.cz>
 <YFIikaNixD57o3pk@kroah.com>
 <202103171425.CB0F4619A8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103171425.CB0F4619A8@keescook>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 02:30:47PM -0700, Kees Cook wrote:
> On Wed, Mar 17, 2021 at 04:38:57PM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Mar 17, 2021 at 04:20:52PM +0100, Michal Hocko wrote:
> > > On Wed 17-03-21 15:56:44, Greg KH wrote:
> > > > On Wed, Mar 17, 2021 at 03:44:16PM +0100, Michal Hocko wrote:
> > > > > On Wed 17-03-21 14:34:27, Greg KH wrote:
> > > > > > On Wed, Mar 17, 2021 at 01:08:21PM +0100, Michal Hocko wrote:
> > > > > > > Btw. I still have problems with the approach. seq_file is intended to
> > > > > > > provide safe way to dump values to the userspace. Sacrificing
> > > > > > > performance just because of some abuser seems like a wrong way to go as
> > > > > > > Al pointed out earlier. Can we simply stop the abuse and disallow to
> > > > > > > manipulate the buffer directly? I do realize this might be more tricky
> > > > > > > for reasons mentioned in other emails but this is definitely worth
> > > > > > > doing.
> > > > > > 
> > > > > > We have to provide a buffer to "write into" somehow, so what is the best
> > > > > > way to stop "abuse" like this?
> > > > > 
> > > > > What is wrong about using seq_* interface directly?
> > > > 
> > > > Right now every show() callback of sysfs would have to be changed :(
> > > 
> > > Is this really the case? Would it be too ugly to have an intermediate
> > > buffer and then seq_puts it into the seq file inside sysfs_kf_seq_show.
> > 
> > Oh, good idea.
> > 
> > > Sure one copy more than necessary but it this shouldn't be a hot path or
> > > even visible on small strings. So that might be worth destroying an
> > > inherently dangerous seq API (seq_get_buf).
> > 
> > I'm all for that, let me see if I can carve out some time tomorrow to
> > try this out.
> 
> The trouble has been that C string APIs are just so impossibly fragile.
> We just get too many bugs with it, so we really do need to rewrite the
> callbacks to use seq_file, since it has a safe API.
> 
> I've been trying to write coccinelle scripts to do some of this
> refactoring, but I have not found a silver bullet. (This is why I've
> suggested adding the temporary "seq_show" and "seq_store" functions, so
> we can transition all the callbacks without a flag day.)
> 
> > But, you don't get rid of the "ability" to have a driver write more than
> > a PAGE_SIZE into the buffer passed to it.  I guess I could be paranoid
> > and do some internal checks (allocate a bunch of memory and check for
> > overflow by hand), if this is something to really be concerned about...
> 
> Besides the CFI prototype enforcement changes (which I can build into
> the new seq_show/seq_store callbacks), the buffer management is the
> primary issue: we just can't hand drivers a string (even with a length)
> because the C functions are terrible. e.g. just look at the snprintf vs
> scnprintf -- we constantly have to just build completely new API when
> what we need is a safe way (i.e. obfuscated away from the caller) to
> build a string. Luckily seq_file does this already, so leaning into that
> is good here.

But, is it really worth the churn here?

Yes, strings in C is "hard", but this _should_ be a simple thing for any
driver to handle:
	return sysfs_emit(buffer, "%d\n", my_dev->value);

To change that to:
	return seq_printf(seq, "%d\n", my_dev->value);
feels very much "don't we have other more valuable things we could be
doing?"

So far we have found 1 driver that messed up and overflowed the buffer
that I know of.  While reworking apis to make it "hard to get wrong" is
a great goal, the work involved here vs. any "protection" feels very
low.

How about moving everyone to sysfs_emit() first?  That way it becomes
much more "obvious" when drivers are doing stupid things with their
sysfs buffer.  But even then, it would not have caught the iscsi issue
as that was printing a user-provided string so maybe I'm just feeling
grumpy about the potential churn here...

I don't know...

greg k-h
