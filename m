Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B34F4B5A0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 19:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357514AbiBNSjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 13:39:49 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiBNSjs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:39:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E76265490;
        Mon, 14 Feb 2022 10:39:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FBA6B80E27;
        Mon, 14 Feb 2022 18:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39850C340E9;
        Mon, 14 Feb 2022 18:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644863976;
        bh=PAyO/n9Urbqt21poj0nmg6rFC9NqVG2dqcg7hCZg018=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ChBmsYOitzDz5jVNXo4PTyMGy6QoN9yGdreqrjPIpAd5A4WEo7o2QZcbUvLrwPtmj
         ADFX43GRS7GnUYtEB4PSVAMfWxvRzIyJjjYvZbV7gU+hX4D4KOlwgfsGCRk+X76ly/
         2cidrXYMZ+N7L+oqOEdITENGZThyxuN8T2Y6fkpmUV5yIWlVcDr/8iSe3f4g6rRZez
         76eIDdTqiKxdDsVpxgUMKZZJ10kZ8ltHehbsH5Hwq7eBtF8CJdkwWn3MEdCs74/xzK
         7MPL6oAmR0Ku/h3iCsjQ3o3QQpBghP/Fh1z18mlzLxK/gsX/YpzIMvuNMyoA32SUCQ
         OfubyL8cFEFbg==
Message-ID: <62e06980ebc36c91e368e4d8bfa340b5ff291369.camel@kernel.org>
Subject: Re: [RFC PATCH v10 00/48] ceph+fscrypt: full support
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Date:   Mon, 14 Feb 2022 13:39:34 -0500
In-Reply-To: <87r185tjpi.fsf@brahms.olymp>
References: <20220111191608.88762-1-jlayton@kernel.org>
         <87r185tjpi.fsf@brahms.olymp>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-02-14 at 17:57 +0000, Luís Henriques wrote:
> Jeff Layton <jlayton@kernel.org> writes:
> 
> > This patchset represents a (mostly) complete rough draft of fscrypt
> > support for cephfs. The context, filename and symlink support is more or
> > less the same as the versions posted before, and comprise the first half
> > of the patches.
> > 
> > The new bits here are the size handling changes and support for content
> > encryption, in buffered, direct and synchronous codepaths. Much of this
> > code is still very rough and needs a lot of cleanup work.
> > 
> > fscrypt support relies on some MDS changes that are being tracked here:
> > 
> >     https://github.com/ceph/ceph/pull/43588
> > 
> 
> Please correct me if I'm wrong (and I've a feeling that I *will* be
> wrong): we're still missing some mechanism that prevents clients that do
> not support fscrypt from creating new files in an encryption directory,
> right?  I'm pretty sure I've discussed this "somewhere" with "someone",
> but I can't remember anything else.
> 
> At this point, I can create an encrypted directory and, from a different
> client (that doesn't support fscrypt), create a new non-encrypted file in
> that directory.  The result isn't good, of course.
> 
> I guess that a new feature bit can be used so that the MDS won't allow any
> sort of operations (or, at least, write/create operations) on encrypted
> dirs from clients that don't have this bit set.
> 
> So, am I missing something or is this still on the TODO list?
> 
> (I can try to have a look at it if this is still missing.)
> 
> Cheers,

It's still on the TODO list.

Basically, I think we'll want to allow non-fscrypt-enabled clients to
stat and readdir in an fscrypt-enabled directory tree, and unlink files
and directories in it.

They should have no need to do anything else. You can't run backups from
such clients since you wouldn't have the real size or crypto context.
-- 
Jeff Layton <jlayton@kernel.org>
