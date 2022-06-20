Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CA05520C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 17:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241575AbiFTP0W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 11:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244534AbiFTP0C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:26:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B046B62
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 08:25:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D986661376
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 15:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7001DC3411B;
        Mon, 20 Jun 2022 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655738719;
        bh=2ifPeSWSj5l9tl68pyZJSAJEee+OiuGjjq3DuiXHkT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MBawSr0GNoDxosyHXX/CnaZDXGZZTWC4/nDD+PjthqXeY+yp/WCfhB27nlnBT5p+f
         XWPh9V/UVp/EI14EiwguJm8lEQ6724P3ufOLVKvx4SI4CcPSlAJRPLNSSeqUF7L1Gh
         aEuhMHy/7LDgHcGtglRIHo67UgnWE4HAYkCCec0WogazwjL/xB/lAb5v5cT5otqbkE
         InjZ60JGSuSdv/+p+O8Y9NHjV70uMVECKBV5S9Ay8i8m+NEjwiOm2Z2LiFnf/+Eo5i
         aadMDsqPiTaizeWdYnlX20r1BYF4G+7/TcV9jhc4XRfAeXSXdFM4uufpDKULsmdZP8
         x5ck8/sCWHjkA==
Date:   Mon, 20 Jun 2022 17:25:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Seth Forshee <sforshee@digitalocean.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/8] mnt_idmapping: add kmnt{g,u}id_t
Message-ID: <20220620152514.wqf5itczv6xtsa3u@wittgenstein>
References: <20220620134947.2772863-1-brauner@kernel.org>
 <20220620134947.2772863-2-brauner@kernel.org>
 <CAHk-=wjapw1A3qmuCPsCVCi4dynbDxb9ocjzs2EF=EDufe8y8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjapw1A3qmuCPsCVCi4dynbDxb9ocjzs2EF=EDufe8y8Q@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 20, 2022 at 09:28:00AM -0500, Linus Torvalds wrote:
> On Mon, Jun 20, 2022 at 8:50 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Introduces new kmnt{g,u}id_t types. Similar to k{g,u}id_t the new types
> > are just simple wrapper structs around regular {g,u}id_t types.
> 
> Thanks for working on this.,
> 
> I haven't actually perused the series yet, but wanted to just
> immediately react to "please don't make random-letter type names".
> 
> "gid" is something people understand. It's a thing.
> 
> "kgid" kind of made sense, in that it's the "kernel view of the gid",
> and it was still short and fairly legible.
> 
> "kmntgid" is neither short, legible, or makes sense.
> 
> For one thing, the "k" part no longer makes any sense. It's not about
> the "kernel view of the gid" any more. Sure, it's "kernel" in the
> sense that any kernel code is "kernel", but it's no longer some kind
> of "unified kernel view of a user-namespace gid".
> 
> So the "k" in "kgid" doesn't make sense because it's a kernel thing,
> but more as a negative: "it is *not* the user visible gid".
> 
> So instead of changing all our old "git_t" definitions to be "ugid_t"
> (for "user visible gid") the "kgid_t" thing was done.
> 
> As a result: when you translate it to the mount namespace, I do not
> believe that the "k" makes sense any more, because now the point to
> distinguish it from "user gids" no longer exists. So it's just one
> random letter. In a long jumble of letters that isn't really very
> legible or pronounceable.
> 
> If it didn't have that 'i' in it, I would think it's a IBM mnemonic
> (and I use the word "mnemonic" ironically) for some random assembler
> instruction. They used up all the vowels they were willing to use for
> the "eieio" instructions, and all other instruction names are a jumble
> of random consonants.
> 
> So please try to make the type names less of a random jumble of
> letters picked from a bag.
> 
> That "kmnt[gu]id" pattern exists elsewhere too, in the conversion
> functions etc, so it's not just the type name, but more of a generic
> "please don't use letter-jumble names".
> 
> Maybe just "mnt_[gu]id"" instead of "kmnt[gu]id" would be better.
> 
> But even that smells wrong to me. Isn't it really "the guid/uid seen
> by the filesystem after the mount mapping"? Wouldn't it be nice to
> name by the same "seen by users" and "seen by kernel" to be "seen by
> filesystrem"? So wouln't a name like "fs_[gu]id_t" make even more
> sense?
> 
> I dunno. Maybe I'm thinking about this the wrong way, but I wish the
> names would be more explanatory. My personal mental image is that the
> user namespaces map a traditional uid into the "kernel id space", and
> then the mount id mappings map into the "filesystem id space". Which

Yes. Basically without idmapped mounts if the caller's idmapping and the
filesystem's idmapping contain the same kuid then the uid/gid passed in
from userspace can be represented in the filesystem idmapping and thus
ultimately on-disk. That's the very basic model.

If the caller uses an idmapped mount then the caller's idmapping and the
filesystem's idmapping are connected via the mount's idmapping. Iow, the
mount remaps the caller's kuid to a different kuid in the filesystem's
idmapping.

> is why to me that "k" doesn't make sense, and the "mnt" doesn't really
> make tons of sense either (the mount is the thing that _maps_ the id
> spaces, but it's not the end result of said mapping).

Yeah, fair point.

> 
> IOW, I get the feeling that you've named the result with the mapping,
> not with the end use. That would be like naming "kuid" by the mapping
> (usernamespace), not the end result (the kernel namespace).
> 
> But maybe it's just me that is confused here. Particularly since I
> didn't really more than *very* superficially and quickly scan the
> patches.

Originally I called that kfs{g,u}id_t but I was never happy with that
either... I think either vfs{g,u}id_t or fs_{g,u}id_t makes sense.
