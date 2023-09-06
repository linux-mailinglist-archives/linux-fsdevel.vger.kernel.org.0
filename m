Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F34796DC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 01:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbjIFXw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 19:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjIFXw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:52:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E170DBD;
        Wed,  6 Sep 2023 16:52:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8A7C433C8;
        Wed,  6 Sep 2023 23:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694043977;
        bh=1rOq5EXHhMPyuF9ZtTZflVlR5YdxenQ/7XPBaEedOus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sLzhk3ZgeZZLHnO1WC+yOV0UKIDxSl+zpX+EdkBHhq/xaJMw5NOEjoZaE7wHTQPAC
         7P52fllDZVpcBupU+RJ685yPs3ycYFQYRIPdVX000V6Yxv3g2Z8eTHuYQpDr+JkQyK
         uzzTQElwegP4w5f7/chKXH7Qzd1HYDGeAhfQtt/U9q+CTp8qbCjzQDJTUyiSaZ2I42
         DnorcHrTSWTZF8TofOPopYTLE7M6neyn6HjnXt2RMcMYmZ0CmFQ9sIsYt0MKQ9F8ec
         vhMYkjbKd94fbkqM63XdbVNUi794q1GqeT0nT94d6NpGb8nQ2vKkg/bqHIGsCl05CJ
         40Yfk7V/QHT4w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 24909403F4; Wed,  6 Sep 2023 20:46:14 -0300 (-03)
Date:   Wed, 6 Sep 2023 20:46:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dsterba@suse.cz, Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs
Message-ID: <ZPkPRpe4T9RgM/CV@kernel.org>
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
 <CAHk-=whaiVhuO7W1tb8Yb-CuUHWn7bBnJ3bM7bvcQiEQwv_WrQ@mail.gmail.com>
 <CAHk-=wi6EAPRzYttb+qnZJuzinUnH9xXy-a1Y5kvx5Qs=6xDew@mail.gmail.com>
 <ZPj1WuwKKnvVEZnl@kernel.org>
 <20230906231354.GX14420@twin.jikos.cz>
 <CAHk-=wh+RRhqgmpNN=WMz-4kkkcyNF0-a6NpRvxH9DjSTy9Ccg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh+RRhqgmpNN=WMz-4kkkcyNF0-a6NpRvxH9DjSTy9Ccg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Em Wed, Sep 06, 2023 at 04:34:32PM -0700, Linus Torvalds escreveu:
> On Wed, 6 Sept 2023 at 16:20, David Sterba <dsterba@suse.cz> wrote:
> >     I think I've always seen an int for enums, unless it was
> > explicitly narrowed in the structure (:8) or by __packed attribute in
> > the enum definition.

> 'int' is definitely the default (and traditional) behavior.
 
> But exactly because enums can act very differently depending on
> compiler options (and some of those may have different defaults on
> different architectures), we should never ever have a bare 'enum' as
> part of a structure in any UAPI.
 
> In fact, having an enum as a bitfield is much better for that case.
 
> Doing a quick grep shows that sadly people haven't realized that.
 
> Now: using -fshort-enum can break a _lot_ of libraries exactly for
> this kind of reason, so the kernel isn't unusual, and I don't know of
> anybody who actually uses -fshort-enum. I'm mentioning -fshort-enum
> not because it's likely to be used, but mainly because it's an easy
> way to show some issues.
 
> You can get very similar issues by just having unusual enum values.  Doing
> 
>    enum mynum { val = 0x80000000 };
 
> does something special too.
 
> I leave it to the reader to figure out, but as a hint it's basically
> exactly the same issue as I was trying to show with my crazy
> -fshort-enum example.

Two extra hints:

⬢[acme@toolbox perf-tools-next]$ grep KIND_ENUM64 include/uapi/linux/btf.h
	BTF_KIND_ENUM64		= 19,	/* Enumeration up to 64-bit values */
/* BTF_KIND_ENUM64 is followed by multiple "struct btf_enum64".
⬢[acme@toolbox perf-tools-next]$

⬢[acme@toolbox perf-tools-next]$ pahole --help |& grep enum
      --skip_encoding_btf_enum64   Do not encode ENUM64s in BTF.
⬢[acme@toolbox perf-tools-next]$

:-)

- Arnaldo
