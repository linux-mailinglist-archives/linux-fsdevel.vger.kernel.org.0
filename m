Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1040D6A8964
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 20:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCBTSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 14:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCBTSc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:18:32 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BB5125A9;
        Thu,  2 Mar 2023 11:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bSVKqTfHXZQDAAqQmNgDotHKECpRHWY2RjtIR7KJtAU=; b=k7ofA7OuCUnf9x0J3coDKqroTG
        hPOiCrhvuIdptf8anf+V/QmlNQSN/hDTCEmELqWUegppCPoOObwJoIFD3q8IDWST7sRMhKLrw6KyL
        ynRVkL5fPZs4qgbTixllpgMFCNTu9zpBom+QfHbnSQqeWzrVTt4OIDyBQ2YwVJQDkYk01oTzOEsnY
        smVQ0jR5nI0UUpb0/PtBcvZDuf0rY+DWvN4ufjxY35uDfNDwtovcsjSRR/N/qoj2fvgDH3z4Oiotg
        VsGbyJIZ3RKtt2gmOIlaZTUlOWQhy9W30hAVwpvuAY+dsXmXrfDKlWYjzqJutKFGrrCg3MEHGakw9
        BtUdgCag==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pXoRc-00DNZe-2v;
        Thu, 02 Mar 2023 19:18:25 +0000
Date:   Thu, 2 Mar 2023 19:18:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
Message-ID: <ZAD2gEQA6edzMJvl@ZenIV>
References: <20230125155557.37816-1-mjguzik@gmail.com>
 <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
 <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV>
 <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
 <ZADuWxU963sInrj/@ZenIV>
 <ZADysodnEPRqhKqc@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZADysodnEPRqhKqc@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 07:02:10PM +0000, Al Viro wrote:
> On Thu, Mar 02, 2023 at 06:43:39PM +0000, Al Viro wrote:
> > On Thu, Mar 02, 2023 at 07:22:17PM +0100, Mateusz Guzik wrote:
> > 
> > > Ops, I meant "names_cache", here:
> > > 	names_cachep = kmem_cache_create_usercopy("names_cache", PATH_MAX, 0,
> > > 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, 0, PATH_MAX, NULL);
> > > 
> > > it is fs/dcache.c and I brainfarted into the above.
> > 
> > So you mean __getname() stuff?
> 
> The thing is, getname_flags()/getname_kernel() is not the only user of that
> thing; grep and you'll see (and keep in mind that cifs alloc_dentry_path()
> is a __getname() wrapper, with its own callers).  We might have bugs papered
> over^W^Whardened away^W^Wpapered over in some of those users.
> 
> I agree that getname_flags()/getname_kernel()/sys_getcwd() have no need of
> pre-zeroing; fw_get_filesystem_firmware(), ceph_mdsc_build_path(),
> [hostfs]dentry_name() and ima_d_path() seem to be safe.  So's
> vboxsf_path_from_dentry() (I think).  But with this bunch I'd need
> a review before I'd be willing to say "this security theatre buys us
> nothing here":

[snip the list]

PS: ripping this bandaid off might very well be the right thing to do, it's just
that "I'm confident there is 0 hardening benefit for it" needs a code review
is some moderately grotty places.  It's not too awful (e.g. in case of cifs
most of the callers are immediately followed by build_path_from_dentry(), which
stores the pathname in the end of page and returns the pointer to beginning
of initialized part; verifying that after that allocation + build_path we
only access the parts past the returned pointer until it's time to free the
buffer is not hard), but it's worth doing.
