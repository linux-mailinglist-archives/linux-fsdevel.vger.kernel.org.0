Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA33753C04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 15:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjGNNsU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 09:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjGNNsT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:48:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E312A2D64
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 06:48:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 784D761D2E
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 13:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EF0C433C8;
        Fri, 14 Jul 2023 13:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689342497;
        bh=VaLLECC2MakW9vk9LxBIZ/hwDNBRooWwJVGfNHyf2XQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kcFsybz4iussO/zOBC82QoGpXSIelUgA6mZhTehKezzA5HJc4dWTcJFQxBJLEcrHF
         fCYSjKoPOzgIi/jbFKcdPAq1hGte4FwgqPUHqwmjSQBJvn4a0K1nBO+fabwAM0fXlG
         O0T1SHCbMsJbvvmC3oKctn74VBH2XxCUujQekgIqWWJbhZGaV2CLk3NSaTZvuSoWAH
         1yU1hyGQzjISNQUY+0JeFKxT8RO7KaJWPMb8mAtpyvqdI6lA68JYKbxAhZij/JVjvx
         kxJCmPyR8zDkB9nDQz5pHNFhfI48HLRERBf9csl5pm6KplcWZr7hu3Ol4+/ly7BuNZ
         mE9NItZ1GP+LQ==
Date:   Fri, 14 Jul 2023 15:48:12 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Carlos Maiolino <cem@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, djwong@kernel.org, hughd@google.com,
        mcgrof@kernel.org
Subject: Re: [PATCH 5/6] shmem: quota support
Message-ID: <20230714-beklagen-betrieben-6e0604c8c05c@brauner>
References: <20230713134848.249779-1-cem@kernel.org>
 <20230713134848.249779-6-cem@kernel.org>
 <V-TeE9XJsldIdG4LAdNamowXDhhAOwa8MwUQyN5xP05cErk5mEje-ZMEqjcyRRaOQ5I5SqZOdybV-YTRhCpDRg==@protonmail.internalid>
 <20230714-messtechnik-knieprobleme-5d0a3abb4413@brauner>
 <20230714122644.l6g4wr3jb7fmkf7x@andromeda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230714122644.l6g4wr3jb7fmkf7x@andromeda>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 14, 2023 at 02:26:44PM +0200, Carlos Maiolino wrote:
> > >
> > > @@ -3736,6 +3853,18 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
> > >  		ctx->noswap = true;
> > >  		ctx->seen |= SHMEM_SEEN_NOSWAP;
> > >  		break;
> > > +	case Opt_quota:
> > > +		ctx->seen |= SHMEM_SEEN_QUOTA;
> > > +		ctx->quota_types |= (QTYPE_MASK_USR | QTYPE_MASK_GRP);
> > > +		break;
> > > +	case Opt_usrquota:
> > > +		ctx->seen |= SHMEM_SEEN_QUOTA;
> > > +		ctx->quota_types |= QTYPE_MASK_USR;
> > > +		break;
> > > +	case Opt_grpquota:
> > > +		ctx->seen |= SHMEM_SEEN_QUOTA;
> > > +		ctx->quota_types |= QTYPE_MASK_GRP;
> > > +		break;
> > >  	}
> > >  	return 0;
> > 
> > I mentioned this in an earlier review; following the sequence:
> > 
> > if (ctx->seen & SHMEM_SEEN_QUOTA)
> > -> shmem_enable_quotas()
> >    -> dquot_load_quota_sb()
> > 
> > to then figure out that in dquot_load_quota_sb() we fail if
> > sb->s_user_ns != &init_user_ns is too subtle for a filesystem that's
> > mountable by unprivileged users. Every few months someone will end up
> > stumbling upon this code and wonder where it's blocked. There isn't even
> > a comment in the code.
> 
> I was just going to rebase these updated changes on top of linux-next, and I
> realized the patches are already there. Wouldn't it be better if I send a
> follow-up patch on top of linux-next, applying these changes, as a Fixes: tag?

I would just resend and fold the fix into the patch. There's no good
reason to make this a separate patch imho.
