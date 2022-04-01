Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B854EF99E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 20:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348752AbiDASS0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 14:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348195AbiDASSY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:18:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BF2179B21;
        Fri,  1 Apr 2022 11:16:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95754B8256A;
        Fri,  1 Apr 2022 18:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E02C2BBE4;
        Fri,  1 Apr 2022 18:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648836992;
        bh=QyEJiv+glqr0H3MoECuGzd/y08s1CwNxnmVW4bLe0c4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDKZp/mG2BSapnMZMxMM6229M1ItI14fPhjLTjHxhU4EnMMam3ZtBWA3mb9LAO+ED
         BMOSbECp4+KoetpdabLnFubWhqvjuGz3RlOv/9Mnw2q2sXHaCRr6/hlqYP2rxTfz5e
         wjHGkczEUyyeoBcVxfAgvYJwHOso3pWMEodk4ZC8y7W/W96MnBVQ2n6Sjc4+h8UaE6
         cYsQWTZwYX/uHqmb6+STLufOR1XcaY46SsaEgvdMM1grjt/HGQCd5P3a5Hp5NUkw80
         Yp6i38e/53tj6mEgMiyTLxeaDb0aI1CWRhQy9K4+XrawA3sBWJtcw7k+BjbXxlBR1m
         fZOdjm49W9ISg==
Date:   Fri, 1 Apr 2022 18:16:30 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, xiubli@redhat.com, idryomov@gmail.com,
        lhenriques@suse.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 08/54] ceph: add a has_stable_inodes operation for
 ceph
Message-ID: <YkdBfkqlSUzJlNHD@gmail.com>
References: <20220331153130.41287-1-jlayton@kernel.org>
 <20220331153130.41287-9-jlayton@kernel.org>
 <YkYJF07WdQZoucQ5@gmail.com>
 <0d9311b16cae47f7a1eb417d589adc093d9dc5b9.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d9311b16cae47f7a1eb417d589adc093d9dc5b9.camel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 01, 2022 at 06:37:10AM -0400, Jeff Layton wrote:
> On Thu, 2022-03-31 at 20:03 +0000, Eric Biggers wrote:
> > On Thu, Mar 31, 2022 at 11:30:44AM -0400, Jeff Layton wrote:
> > >  static struct fscrypt_operations ceph_fscrypt_ops = {
> > >  	.key_prefix		= "ceph:",
> > >  	.get_context		= ceph_crypt_get_context,
> > >  	.set_context		= ceph_crypt_set_context,
> > >  	.empty_dir		= ceph_crypt_empty_dir,
> > > +	.has_stable_inodes	= ceph_crypt_has_stable_inodes,
> > >  };
> > 
> > What is the use case for implementing this?  Note the comment in the struct
> > definition:
> > 
> >        /*
> >          * Check whether the filesystem's inode numbers and UUID are stable,
> >          * meaning that they will never be changed even by offline operations
> >          * such as filesystem shrinking and therefore can be used in the
> >          * encryption without the possibility of files becoming unreadable.
> >          *
> >          * Filesystems only need to implement this function if they want to
> >          * support the FSCRYPT_POLICY_FLAG_IV_INO_LBLK_{32,64} flags.  These
> >          * flags are designed to work around the limitations of UFS and eMMC
> >          * inline crypto hardware, and they shouldn't be used in scenarios where
> >          * such hardware isn't being used.
> >          *
> >          * Leaving this NULL is equivalent to always returning false.
> >          */
> >         bool (*has_stable_inodes)(struct super_block *sb);
> > 
> > I think you should just leave this NULL for now.
> > 
> 
> Mostly we were just looking for ways to make all of the -g encrypt
> xfstests pass. I'll plan to drop this patch and 07/54. I don't see any
> need to support legacy modes or stuff that involves special storage hw.

Do generic/592 and generic/602 fail without this patch?  If so, that would be a
test bug, since they should be skipped if the filesystem doesn't support
FSCRYPT_POLICY_FLAG_IV_INO_LBLK_{64,32}.  I think that
_require_encryption_policy_support() should be already taking care of that,
though?

- Eric
